Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF97C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D9B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjdeOLmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D9B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeLKAZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:25:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51033 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeLKAZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:25:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so459074wmd.0;
        Mon, 10 Dec 2018 16:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G4OmV/lvcX0E5wDsLTOwegdQQwRmoI/WRDrorzA8PGc=;
        b=GjdeOLmq5TN9Ql8nsNY+HpjRip1iudHRxgxrFq4QVVsAZiu5RPLEtdfq+kryXR8KlO
         ECV95flpRGohzPbV/iagLQ62bO9gK8eHxuRUHWdq9WpHGu534Sjw+j8qCkkj8HuZKHxm
         8GMmRuqF9c2wXKGX/HombuNZ+6jmQrQ5FB4kR+hTEX/ob+z+bmQvrm2xFHGFCq36NAHD
         YBphAJL06qCbwSl5Hk2fOuO7gsxA6SV/r8yitefhZsAAkPWxY7N5+gniqm7jS+7uZ4tS
         RqbY8QbdKJDmmNVd9tB5dXEbrV+N4kx4/nDcVOFy+SG+P8iE3O8ssBcebB5jwH1wBhba
         0F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G4OmV/lvcX0E5wDsLTOwegdQQwRmoI/WRDrorzA8PGc=;
        b=drwIGfU9En/SVwZUHaQXp4n9a/yYPKGFru9ObyHM460rhLrPtNXdKSepm7UOz9c9QP
         zUiZ0ZMh53AtMJ+keCNawlCyMjmit33N/3oc3igIBhfxU7AnCt1PZcoR21T7gRw+vfV+
         jpvcULtghVgUUUqiUeO+BAsIV+dmsN8JkZnNiR84HPZ7y0mv7kpjX7X8BbNYTRSwZsA4
         CSpH+5+FiyAmJlSmMKja98I1yj3ztZT2DeFORfleMrbbx2GeZmZ5k90MXKkNZSQWb9Ed
         GpHymSyjXLAFRDz/wFparc1/lKltgBkH5B0ypmkJltZeLeJH2Z14K5m8K1Mqy0QylZ1M
         3HUQ==
X-Gm-Message-State: AA+aEWYBfgTmPmZKSszt997F1RhdIqVJZjIhSoTX4ln4388llquxonUR
        XopUMMmolO5nuOpZ4z5e+X0=
X-Google-Smtp-Source: AFSGD/UvC0yldA5VpgOd+MLeODxPnEeTZmSZ4KM1XaSEWHPb26onz/GWqYIyJnkcz+RawTAd49Dc1Q==
X-Received: by 2002:a1c:2856:: with SMTP id o83mr417730wmo.45.1544487927267;
        Mon, 10 Dec 2018 16:25:27 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c9sm510606wmh.27.2018.12.10.16.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 16:25:26 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:25:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
Message-ID: <20181211002525.GA8468@flashbox>
References: <20181211000506.7559-1-natechancellor@gmail.com>
 <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
 <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:46:26AM +1030, Joel Stanley wrote:
> On Tue, 11 Dec 2018 at 10:40, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Tue, 11 Dec 2018, at 10:35, Nathan Chancellor wrote:
> > > Clang does not support this option:
> > >
> > > warning: unknown warning option '-Woverride-init'; did you mean
> > > '-Woverride-module'? [-Wunknown-warning-option]
> > > 1 warning generated.
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Acked-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Thanks Nathan.
> 
> Andrew explained to me that this warning helps find bugs when
> developing the complicated (some would say crazy) set of macros that
> this pinctrl driver uses. It would be good to have this warning
> available in clang. Do we have a clang issue opened for that?
> 
> Acked-by: Joel Stanley <joel@jms.id.au>
> 
> Cheers,
> 
> Joel

Hi Joel,

I just opened https://github.com/ClangBuiltLinux/linux/issues/293.

I searched the LLVM issue tracker and haven't see any reference of this.
I can file an issue but if you are a little more familiar with this
warning, you are welcome to do it instead.

Thanks for the quick response,
Nathan
