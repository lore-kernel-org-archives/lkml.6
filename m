Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD07C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9397F2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="bz03GCqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9397F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=scalemp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbeKGR2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:28:48 -0500
Received: from www.scalemp.com ([169.44.78.149]:42833 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeKGR2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XstwxqCWHCWnKaKSpFy5nFx+DruyEkQNqmX2/R691AM=; b=bz03GCqDYcJeqREgbzGeyRuHWC
        C8HsST/9xYMVLB7CCokn2bpg070TBC9GiQqPYck7Fn6G5pj9WMSnKnoMZySk7ilp3tZ86AoIyVDYE
        mYXbKIXk9KJHuQTQs1o7xeVWEC0k15q45m8zp/0q8AAXQjHIu41ZC3ex+ihyxY0p6A7c=;
Received: from bzq-80-45-146.static.bezeqint.net ([82.80.45.146]:20505 helo=[10.100.0.120])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1gKIkQ-001mXs-GA; Wed, 07 Nov 2018 02:59:34 -0500
Subject: Re: [PATCH v3] x86/vsmp_64.c: Remove dependency on pv_irq_ops
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1541439114-28297-1-git-send-email-eial@scalemp.com>
 <20181105175902.GA32060@gmail.com>
From:   Eial Czerwacki <eial@scalemp.com>
Organization: ScaleMP
Message-ID: <50d90a5f-69c8-6b19-c5e7-3c3380b40351@scalemp.com>
Date:   Wed, 7 Nov 2018 09:59:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181105175902.GA32060@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Ingo,

On 11/05/2018 07:59 PM, Ingo Molnar wrote:
> 
> * Eial Czerwacki <eial@scalemp.com> wrote:
> 
>> +#if defined(CONFIG_PCI)
> 
> This is shorter:
> 
>    #ifdef CONFIG_PCI
> 
> Thanks,
> 
> 	Ingo
> 

you are absolutely right, looks like Thomas have handled it already.

Eial.
