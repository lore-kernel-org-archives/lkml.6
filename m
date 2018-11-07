Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AB8C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9692081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TgHjlORg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9692081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeKHE1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:27:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38642 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeKHE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:27:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so18561604wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T10zk169Vu2UzjfEPpQ0MWPBPxcsbXBzEtqR+juRvPM=;
        b=TgHjlORgWGpXLN6EPsofxHpSvYRh0atnOg2Tnslr9/HJ6rzRpULKbnmXjd8PH9vJsz
         ADcX9HT2zPOnTB0zZFIPTNnhx9CdG39Pg9Rcc0ndI3JkSJH1/lsAeNJiU67WYwEOMbQa
         rX2lPvKqRRy1dKVcYiCmfHk/IdhSSzev4AcStRSF/kEzhcStJdrJIdZoL1q6wuKyvyCM
         1n7bMx7zOLCY07nvNDqdOnL47xf6aTi5mofVKdpQskeO0n8/N1Qdivh7ED9RqW/oGVD6
         dIfq4aTc+w8RnKINUH4fbGdMYYTCM/hUMKXjPLPCY6oISfT2x8vRpoZ86i6zrd04gMO8
         1Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T10zk169Vu2UzjfEPpQ0MWPBPxcsbXBzEtqR+juRvPM=;
        b=AjaWxzZZCGcc+2Z8ZrWhGxl8n5AjwYmCOcMbZhSx+qKFDJVOVzuc4IAc9k+Guw3SZt
         VeoRJ3hZeVJxl+VzQ205Fh+JofVNjMRSMFqwksDvbj28X8gv9qcIPv/ALMQDx6U6CCTK
         5KL2FKJFK6LScI9wtMQ0C58K+7KnMQXfAr44mKens+fiHUjIW9qyQgN/mZVfOzg3DsKZ
         JE2KFOtsEwCMmAG+IkxnZcW37ptyfTSGExgoHHyqt6Ky1yqxyMmYGLsSQrewdsEonTmz
         0sCk+U4wjFHDYwPIArlWWb1PY/t3Qx9enoWqjRmL4GhjD6fLV3qnPCVFVRsbTQv3U6lA
         Yy9A==
X-Gm-Message-State: AGRZ1gL9dkiFAXY9yyJScx+gOVuXfU6a7MKVgdIyblIMuTPBzeO/gRiD
        5COv810ndsurjxLG0gmITze9jA==
X-Google-Smtp-Source: AJdET5d4cg1XTJVPT8BM6KuFIt8FjN6pZP9jD6G3pR12ZGliD/YitkVfwOx2wWhSeKVl/jOFADuPeQ==
X-Received: by 2002:a5d:6389:: with SMTP id p9-v6mr1268429wru.215.1541616944671;
        Wed, 07 Nov 2018 10:55:44 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id t77-v6sm2932817wme.18.2018.11.07.10.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:55:43 -0800 (PST)
Date:   Wed, 7 Nov 2018 19:55:41 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] crypto: crypto_user_stat: made crypto_user_stat
 optional
Message-ID: <20181107185541.GB5133@Red>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
 <1541422274-40060-2-git-send-email-clabbe@baylibre.com>
 <20181106014126.GC28490@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106014126.GC28490@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:41:27PM -0800, Eric Biggers wrote:
> Hi Corentin,
> 
> On Mon, Nov 05, 2018 at 12:51:10PM +0000, Corentin Labbe wrote:
> > Even if CRYPTO_STATS is set to n, some part of CRYPTO_STATS are
> > compiled.
> > This patch made all part of crypto_user_stat uncompiled in that case.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  crypto/Makefile                      |  3 ++-
> >  crypto/algapi.c                      |  2 ++
> >  include/crypto/internal/cryptouser.h | 17 +++++++++++++++++
> >  include/linux/crypto.h               |  2 ++
> >  4 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/crypto/Makefile b/crypto/Makefile
> > index 5c207c76abf7..1e9e5960946a 100644
> > --- a/crypto/Makefile
> > +++ b/crypto/Makefile
> > @@ -54,7 +54,8 @@ cryptomgr-y := algboss.o testmgr.o
> >  
> >  obj-$(CONFIG_CRYPTO_MANAGER2) += cryptomgr.o
> >  obj-$(CONFIG_CRYPTO_USER) += crypto_user.o
> > -crypto_user-y := crypto_user_base.o crypto_user_stat.o
> > +crypto_user-y := crypto_user_base.o
> > +crypto_user-$(CONFIG_CRYPTO_STATS) += crypto_user_stat.o
> >  obj-$(CONFIG_CRYPTO_CMAC) += cmac.o
> >  obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
> >  obj-$(CONFIG_CRYPTO_VMAC) += vmac.o
> 
> Doesn't CONFIG_CRYPTO_STATS also need to depend on CONFIG_CRYPTO_USER?
> Currently you can enable it but without CRYPTO_USER the API won't be available.
> 
> config CRYPTO_STATS
> 	bool "Crypto usage statistics for User-space"
> 
> should be:
> 
> config CRYPTO_STATS
> 	bool "Crypto usage statistics for User-space"
> 	depends on CRYPTO_USER
> 
> > diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> > index 3634ad6fe202..35de61d99cd5 100644
> > --- a/include/linux/crypto.h
> > +++ b/include/linux/crypto.h
> > @@ -515,6 +515,7 @@ struct crypto_alg {
> >  	
> >  	struct module *cra_module;
> >  
> > +#ifdef CONFIG_CRYPTO_STATS
> >  	union {
> >  		atomic_t encrypt_cnt;
> >  		atomic_t compress_cnt;
> > @@ -552,6 +553,7 @@ struct crypto_alg {
> >  		atomic_t compute_shared_secret_cnt;
> >  	};
> >  	atomic_t sign_cnt;
> > +#endif
> 
> This is a long ifdef, so use:
> 
> #endif /* CONFIG_CRYPTO_STATS */
> 
> - Eric

I will fix that
Thanks
