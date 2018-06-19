Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CEBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28F020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hZ1smqWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28F020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967041AbeFSQbz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:31:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965953AbeFSQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3gozFi4YoYuqyJBDrGEwDc842ylJzhuXclrq2bg+hA4=; b=hZ1smqWx7G5Rkx1+n2/PriIIs
        Wf0sp9X6q/2jH0RgggcLlE0U9O500Hj7U1pdozThLdBWLvnNPmye2/VfcDd1HqtYM1vWUSUaF6EZL
        DckNLTd8YFAuKeJ3VwJN/GcZuwXkpDkE25LFwK2khAQS8WAT9MTnjRiCis3+q3UIqdt5b3pFsV9dw
        cGKdPC/vhqM3n0eg7sl9Ua3jkkQ0ktWl4Kq0SAtujN9BD802S32BWTcPe1J3QHmlD2TTAYWYPlMsy
        alyXLUbczI6I9YavVVokha/zZRYWSNGidh74K68gSPSsQx7YPnWY/eaEkaAb0M5LWEnTaBbF6K9NR
        ao3acg14Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVJXs-0003Ub-OL; Tue, 19 Jun 2018 16:31:52 +0000
Subject: Re: [PATCH -tip v6 26/27] Documentation: kprobes: Add how to change
 the execution path
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <152942424698.15209.15245996287444292393.stgit@devbox>
 <152942500680.15209.12374262914863044775.stgit@devbox>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <706832c5-dab4-f806-96d6-2cdc37203d9d@infradead.org>
Date:   Tue, 19 Jun 2018 09:31:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152942500680.15209.12374262914863044775.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 09:16 AM, Masami Hiramatsu wrote:
> Add a section that explaining how to change the execution
> path with kprobes and warnings for some arch.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/kprobes.txt |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 3e9e99ea751b..8a98eed1521b 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -80,6 +80,26 @@ After the instruction is single-stepped, Kprobes executes the
>  "post_handler," if any, that is associated with the kprobe.
>  Execution then continues with the instruction following the probepoint.
>  

Hi,
I have a few small suggestions...


> +Changing Execution Path
> +-----------------------
> +
> +Since the kprobes can probe into a running kernel code, it can change

   Since kprobes can probe into running kernel code, it can change

> +the register set, including instruction pointer. This operation
> +requires maximum attention, such as keeping the stack frame, recovering
> +execution path etc. Since it is operated on running kernel and need deep

                       Since it operates on a running kernel and needs deep

> +knowladge of the archtecture and concurrent computing, you can easily

   knowledge of the architecture

> +shot your foot.

   shoot

> +
> +If you change the instruction pointer (and set up other related
> +registers) in pre_handler, you must return !0 so that the kprobes

                                                 so that kprobes

> +stops single stepping and just returns to given address.

                                          to the given address.

> +This also means post_handler should not be called anymore.
> +
> +Note that this operation may be harder on some architectures which
> +use TOC (Table of Contents) for function call, since you have to
> +setup new TOC for your function in your module, and recover old

   setup a new TOC for your function in your module, and recover the old

> +one after back from it.

   one after returning from it.

> +
>  Return Probes
>  -------------


-- 
~Randy
