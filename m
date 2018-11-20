Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F1C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B45B2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA0OsEXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B45B2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeKUJDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeKUJDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:03:05 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BB92147A;
        Tue, 20 Nov 2018 22:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542753100;
        bh=UmQuXEwSgKPe44f8T65RKRJmJCvqAYgQrbyq8nNXmoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LA0OsEXgEssexnn+lCCccAh/YmEYPj+zlEQEWihy+7XQzXITnWrBIOfARLBnZy9vk
         O8VdkDgZQumcJNkF7oNzvZZZ7bWiPYeRdkmeU6yrJ/ePEYWQu3mtJkXRT81l7fQnDt
         9aklkHMWI+3qXw28cIP8H7k30mHk8azYXZ2MQPZ0=
Date:   Tue, 20 Nov 2018 23:31:37 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 21/25] procfs: Use vtime aware kcpustat accessor
Message-ID: <20181120223136.GA22332@lerouge>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-22-git-send-email-frederic@kernel.org>
 <20181120142422.GY2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120142422.GY2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:24:22PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 14, 2018 at 03:46:05AM +0100, Frederic Weisbecker wrote:
> >  		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
> 
> Just a note to let you know the current minimum GCC version is 4.6 :-)

Yeah, comments tend to become desperately conservative overtime :-)
