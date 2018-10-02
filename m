Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC42C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E305206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E305206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJBS3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:29:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeJBS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:29:11 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3B1FB73;
        Tue,  2 Oct 2018 11:46:16 +0000 (UTC)
Date:   Tue, 2 Oct 2018 04:46:14 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Rickard <matt@softrans.com.au>,
        Borislav Petkov <bp@alien8.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4.14 114/165] x86/vdso: Fix vDSO build if a retpoline is
 emitted
Message-ID: <20181002114614.GA2581@kroah.com>
References: <20180903165655.003605184@linuxfoundation.org>
 <20180903165701.245301231@linuxfoundation.org>
 <20181002080655.GV31855@pcnci.linuxbox.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002080655.GV31855@pcnci.linuxbox.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:06:55AM +0200, Nikola Ciprich wrote:
> Hi Greg and others,
> 
> sorry for reporting this so late, but still...
> 
> this breaks build on older compilers, since it requires
> -mindirect-branch=thunk-inline -mindirect-branch-register even though
> retpoline support is disabled in kernel config.. is this expected?

What exact "older compilers" break here?

And does the same breakage happen in 4.18.6 or 4.19-rc?

thanks,

greg k-h
