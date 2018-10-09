Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E5C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A5C214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="h/uV/ry7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A5C214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJIWeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:34:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38880 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeJIWeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:34:10 -0400
Received: by mail-io1-f65.google.com with SMTP id n5-v6so1442370ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9HW8VYx7bMPc3xCQ4IFZXaCDdlwywtCjeiSndtyAc08=;
        b=h/uV/ry7DQHwyGLk0ZlegPGjFSkXYe1eg5u83vHRB7v1vzWtKoBUk+6B2oiuwWdr9P
         kpJhCgP7bbk7umQAQ6riX/IIH5aiP1P3qGNuVhh9MktnMbceewy/zBz69DnrRA/PlEiq
         nfuibC9nQJWP7OrAIeTKfn0/N1R2pqwlM/Drui2TeO7T/tsKRjAl2n6S6cEVHeAlHnDv
         j5xgMyNif76HNpBPljaGSl/g86YgmASKlT44p7Q1irM63VcMDxVUKbRE1fpjLN0sghI8
         DtvvcmXn237RhbwutoTctWCkAXZZnvzl4DrID6Vvltuz9oWAYcbu+PoeSI+4NlQdvFW+
         O9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9HW8VYx7bMPc3xCQ4IFZXaCDdlwywtCjeiSndtyAc08=;
        b=bB0knpP52440Y1jbjEk3c4v27J+1dcecPwfthIMPdrFE4mn8bgcdvLidSMIM1Em1pw
         y03jMGIefnCVG3dQfCikQsytThhTltV4LpFeypRFMmWdDqw5Vk8GtOFLTAzZIi6DjUD9
         HCMT1gmU9CDBEiuzC+CFoff2k+qTsUdfx8TgiPyTIwQH29XbtWUOSOmesvKrdm6eLet0
         l0ZdcnC1pxq4mun1gr/w2bACBpuGaaroOxkhMvO1EpvWhBMtU07h90tbvyVAqzve3r37
         o0A4ELlhZ0Jd+y63QOLBSE4QAC4l8E26eCNRJYGWyCxkrzVzDhXAqqQL4sQrL9Nfnwwc
         MCyg==
X-Gm-Message-State: ABuFfoix6aNH68rYYfvROAtWe+bXeob+mhjacj28ln0L32Eej7Yqk1Fp
        nNPftneVSz/f8xxsuprHgMxLnw==
X-Google-Smtp-Source: ACcGV63T7e+Re5a/DDDgT8D0VWsIrp3U9BU0b5kG07uBS9wEEFice7xxcIlWsBmvDU+A6OGkW9qoAQ==
X-Received: by 2002:a6b:3108:: with SMTP id j8-v6mr9647878ioa.219.1539098205184;
        Tue, 09 Oct 2018 08:16:45 -0700 (PDT)
Received: from cisco ([12.226.92.2])
        by smtp.gmail.com with ESMTPSA id g4-v6sm7024056ioc.87.2018.10.09.08.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 08:16:44 -0700 (PDT)
Date:   Tue, 9 Oct 2018 08:16:41 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <20181009151641.GB10149@cisco>
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009103752.21482-2-laurent@vivier.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:37:52PM +0200, Laurent Vivier wrote:
> @@ -80,18 +74,32 @@ static int entry_count;
>   */
>  #define MAX_REGISTER_LENGTH 1920
>  
> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
> +{
> +	struct binfmt_namespace *b_ns;
> +
> +	while (ns) {
> +		b_ns = READ_ONCE(ns->binfmt_ns);
> +		if (b_ns)
> +			return b_ns;
> +		ns = ns->parent;
> +	}
> +	WARN_ON_ONCE(1);

It looks like we warn here,

> @@ -133,17 +141,18 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	struct file *interp_file = NULL;
>  	int retval;
>  	int fd_binary = -1;
> +	struct binfmt_namespace *ns = binfmt_ns(current_user_ns());
>  
>  	retval = -ENOEXEC;
> -	if (!enabled)
> +	if (!ns->enabled)

...but then in cases like this we immediately dereference the pointer
anyways and crash. Can we return some other error code here in the !ns
case so we don't crash?

Tycho
