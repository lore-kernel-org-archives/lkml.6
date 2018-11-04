Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED47C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F97204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oTJso4+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F97204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeKDUdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 15:33:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40504 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbeKDUdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 15:33:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so5390054wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WK6s2/NAUqBxnZxGeAq6Lhqo2R4LmCX84oAOo9tJm5w=;
        b=oTJso4+KmorET0F44N3e7XrKt/e7DncKSDF3dBGw3znnBCVDbt/wWqcsigv20d7WzI
         jWUKU5WdYZUvTiufOfM2Gj4nf+MoqpLaE5ViPnRLRZfkyptPvmDYSNL3KweoIbLWmwNb
         cKx33QbRzssDaSQyJhw7lOyA6MLjal6DDlpt8q52UTzdi7kl3TdsSvRfenALAYRw+SDc
         4UNyoczwjvhHohzmmgOvtfEqOst+F9+g0EHavj3FuQTkC9Kq61Viba/LGJbN6rEtq4Dl
         nSITOisVzyWFPLGOEDZdBSq4vWaDlSmOtydkxLPsfmy/gnfrXjCw1zIngi5Z1aaquOy0
         /D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WK6s2/NAUqBxnZxGeAq6Lhqo2R4LmCX84oAOo9tJm5w=;
        b=DWuVNxHVvpimAwaEnQw26kV5aNNrhGSdydp+Weqm/wO+wvHWcG1RnrVyonLnyja6o3
         nqRIVmCI6AOmR6FNCzXwTxm6bYkRFq1PIfEaZIjz4p891ljNMQb38on+fZVbbzXuuBts
         EV/l+EOqtM8O9+x0FXRtAQ97+1x5X/zH9NeIu8Tl+JsN9as8J4A5cEK3IWpejK911KF8
         MI2SftOa5AEjtNIXNt6VKH7MIJdYM8t7mBo5FFEWbbX9ckQ0sjLPfC4xKUHsm2oDj5Lm
         nG0wefcJWmqDCuRUaY6PUs2vwxkh0dOq8pvkYlrq8jFkhOnFjMyOGa7aQYG9E6iVBG5p
         zeAw==
X-Gm-Message-State: AGRZ1gJcTrOQe6LqfbQZFC+rsVuzEBGE6p80x3jF7BawNTkDjcF4GBNq
        BVRvESYofMS1FzusunWab+4p6w==
X-Google-Smtp-Source: AJdET5eYT/gdpWdWJsZLxDxqiu4tAWLN3h4wjHAUFLGgICVGKC66//rKEvwDu2dxxOPB04lNGrjPSg==
X-Received: by 2002:a7b:c183:: with SMTP id y3-v6mr2993242wmi.150.1541330316360;
        Sun, 04 Nov 2018 03:18:36 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g10-v6sm24183794wru.39.2018.11.04.03.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 03:18:35 -0800 (PST)
Date:   Sun, 4 Nov 2018 12:18:33 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6939a606a5305e9e9799@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in skcipher_recvmsg
Message-ID: <20181104111833.GC6963@Red>
References: <000000000000d8053d05799b4b86@google.com>
 <20181103223504.GC808@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103223504.GC808@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 03:35:04PM -0700, Eric Biggers wrote:
> [+clabbe@baylibre.com]
> 
> Hi Corentin, I think this is a bug in the new crypto statistics feature.  In the
> skcipher_decrypt case the code is (but this applies elsewhere too!):
> 
> static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
> 						int ret, struct crypto_alg *alg)
> {
> #ifdef CONFIG_CRYPTO_STATS
> 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
> 		atomic_inc(&alg->cipher_err_cnt);
> 	} else {
> 		atomic_inc(&alg->decrypt_cnt);
> 		atomic64_add(req->cryptlen, &alg->decrypt_tlen);
> 	}
> #endif
> }
> 
> static inline int crypto_skcipher_decrypt(struct skcipher_request *req)
> {
> 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> 	int ret;
> 
> 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
> 		ret = -ENOKEY;
> 	else
> 		ret = tfm->decrypt(req);
> 	crypto_stat_skcipher_decrypt(req, ret, tfm->base.__crt_alg);
> 	return ret;
> }
> 
> The bug is the request may be issued asynchronously (as indicated by EINPROGRESS
> or EBUSY) being returned, and the stats are updated afterwards.  But by that
> time, the request's completion function may have already run, and the request
> structure may have already been freed.
> 
> In theory, I think the algorithm could have even been unregistered as well.
> Therefore, it's only safe to update the stats either *before* calling
> tfm->decrypt(), or afterwards if the error code was not EINPROGRESS or EBUSY.

Hello

I can store "len" and alg for later use, this will fix a part of the problem.

For the fact that algorithm could be unregistred, I think it cannot happen since at least the tfm running this crypto_skcipher_decrypt/othersamefunction still exists and that it is(should be) impossible to unregister an alg with still existing tfm which uses it.
But that needs to be verified.

Regards
