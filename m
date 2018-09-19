Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AB42086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+i0u3Uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AB42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeISHlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:41:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36325 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeISHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:41:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so1914058pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5gROdCyNbpmzNaoXRednzwucpIad/b3JepEFZOUF7o=;
        b=f+i0u3UhRlfVHBQDvjwGPVkcH1r4dyxGn2yRoKtxBwdb5lTvL7LMFWIFZL2cJfsP7U
         vid4yt4PDl0UztiawGxfZfP8YdBMs+kXIUcLe11m53A5r4TGomXvhHktX0tP/UhBvtuY
         ueO8YsFwkg7THcCDZFKG9ckm0SmFoPphts3lxp64N5yG2ObCWk0f/LfeQYQKjOOucDpd
         wPGGf0cFfh9slzVKSWevgDLIIzEA8ZyzxoPNraBLPPmhE8V5l6kUQO4xegOgiBjyezwe
         4bogzKLLNawL9owN56GZmJ3jmDR76VOLNBdBWkGa5lRhjYvJNJXtjEOPs+PglweBOgEq
         SvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5gROdCyNbpmzNaoXRednzwucpIad/b3JepEFZOUF7o=;
        b=GWxrYDBFGm6BBTl6ZkxiMtyplYg7boGMqb5BXMASuwV3QlRIHeU1xuw7W5C7hVBtP2
         IJZiqdszNzkliHuKhDHlIVHgoYj57srxdT5HMhymiFRfyrSIkoEiyeobSl8S2qVHBLdt
         OajhAtR9wqN29Nx5RjJ0QqIIkaa6c27pFQGfbOZ3xlXRIwvEzmSBPvfX8Z1ttMUthAqe
         sLWY/krFnof30uQDMH5aOYXAd94bnjYaE9a48KoEbEqwR/KMNC+QWBqv4Z+CsxcIVlCh
         q3VE+NC+RKFm/bY2mkRXMy9EnheZT8BMVB1ANoEU+M+bOxM+kWyoArQBl7WmR5QcL7l8
         ZDeA==
X-Gm-Message-State: APzg51B+udLGCKET7/Z/tLKIGRRVixBljuptUaiOr+33uyfTOJZAXJ+O
        xsgrOOMc0zBWuGFUvrg2CAI=
X-Google-Smtp-Source: ANB0VdZRi29NA8Fcj9oI7LN1hD+5nsQGA+/pVyl+nDGGPJOs5NBvBNJr/nTUpB0mqZ5NBXVFlYmCqg==
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr30556577pge.23.1537322785444;
        Tue, 18 Sep 2018 19:06:25 -0700 (PDT)
Received: from localhost ([175.223.11.230])
        by smtp.gmail.com with ESMTPSA id u25-v6sm25931353pfk.177.2018.09.18.19.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:06:24 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:06:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] printk: Add KBUILD_MODNAME and correct bare use
 of unsigned
Message-ID: <20180919020621.GA390@jagdpanzerIV>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <1537291068-443145-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537291068-443145-2-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/19/18 01:17), zhe.he@windriver.com wrote:
> Add KBUILD_MODNAME to make prints more clear.

No strong opinion. I'm OK with this change.

> And use 'unsigned int' intead of 'unsigned' according to
> checkpatch.pl's suggestion.

I don't think that "unsigned int" is the right thing to use there.

>  		if (console_seq < log_first_seq) {
>  			len = sprintf(text, "** %u printk messages dropped **\n",
> -				      (unsigned)(log_first_seq - console_seq));
> +				   (unsigned int)(log_first_seq - console_seq));

Both log_first_seq and console_seq are u64.

	log_first_seq - console_seq

thus, *in theory*, can be larger than "unsigned int". So I'd just avoid cast
and use an appropriate for u64 %llu sprintf() specifier. Something like below,
perhaps:

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f73ea9dd6f46..4b8c5832bf14 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2408,8 +2408,9 @@ void console_unlock(void)
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
 		if (console_seq < log_first_seq) {
-			len = sprintf(text, "** %u printk messages dropped **\n",
-				   (unsigned int)(log_first_seq - console_seq));
+			len = sprintf(text,
+				      "** %llu printk messages dropped **\n",
+				      log_first_seq - console_seq);
 
 			/* messages are gone, move to first one */
 			console_seq = log_first_seq;

---

Steven, Petr, any objections?

	-ss
