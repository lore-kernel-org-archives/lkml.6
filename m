Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9DC46477
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0175C208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxf1g9aK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0175C208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeIYWXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:23:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55210 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbeIYWXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:23:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id c14-v6so14065945wmb.4;
        Tue, 25 Sep 2018 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/aGEzDnx3yEWD8OaBNWCcEq+06Kyu4hCeafXUqmsYGU=;
        b=Qxf1g9aKCMqhyGCK8Nw1fwdXcq9tsDCNVQ67w+qUbiaioI48p4e2XhY7wjgbzSI4cC
         fDbQvdEaT1ppWMBKWJ4+F/hPtCRale+uRlBoZ1OoDGkdBXaeW9VaYd3EU2//cLW+4IUe
         5EonsUbBjaLPNkvtwslNyZ4JIHzREC9+36tJmTFEi7/+S/7+HS2NTUqni3kPYgXs9jkw
         lqQjd7YLl49QayQ8V2U/Agr53xDcChG2tULYzq8w35x6PjoI1URPkmsBulAHgMU51Zjw
         QNgutnAYInLMTsqAGn7Ja59q8NNWZei3m8w2h6N8Tjub0QhUZZTb/GxernZSNAo563n0
         +BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/aGEzDnx3yEWD8OaBNWCcEq+06Kyu4hCeafXUqmsYGU=;
        b=DJ1T6AamMIKp/IQr8CTr2qyEj2zgRXcuHLxdiSKGWGh37FLWuvYaUgzu/G1caP/syl
         qDoIhlPvycr/FuOS4f5x0DzPy7HM9sQ+0dDtpWXRO+WgMMTda7kZ8/J5yKjbzGSl4XIV
         oZfKda6mzbABhW3oJqBKEk5R6JoBh5bKsYum29px7O1aTZD8ETZWG4MZxLv9ltu2MOwP
         JXB/NnBkgkAfzTLnzFOdi8Qx6zMPhbWiEOYI/pjGgHDd8SEYn0ktPseKkLskYsidrP+f
         A6XBXE/tUAd+7Wk+R5D7hezHA5IX+phrapKxVyoWI1InxHf8TAv37ptv2Vs4LL0pKjZi
         URTA==
X-Gm-Message-State: ABuFfohsJRfmvSQIfLtW/2G4kZqQa3XDP2Lgt2YjvRW2HEXffMpQd7TE
        0RlpPL2L5n5yQQz4HV47MaQ=
X-Google-Smtp-Source: ACcGV62D6DToJe+o1hxluAmOvBOaB0wOJmkxEfBoXWSzTGY45IUChc7UBKgD21S8Jbu7WyFDU+O70g==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr1340548wmc.81.1537892104257;
        Tue, 25 Sep 2018 09:15:04 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r13-v6sm2290166wmf.35.2018.09.25.09.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 09:15:01 -0700 (PDT)
Date:   Tue, 25 Sep 2018 09:14:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ndesaulniers@google.com
Subject: Re: [PATCH] pinctrl: generic: Avoid several implicit enum conversions
Message-ID: <20180925161459.GA15840@flashbox>
References: <20180925061855.19557-1-natechancellor@gmail.com>
 <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdadODxsuae7uhwcfBBMQ-eZ8bvnV71fhDCuudbJEbhhYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:58:16PM +0200, Linus Walleij wrote:
> On Tue, Sep 25, 2018 at 8:19 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> 
> > Clang warns when one enumerated type is implicitly converted to another,
> > which happens several times in the pinctrl drivers for a few reasons:
> >
> > * The PCONFDUMP macro, which sets the param member in pin_config_item.
> > * The pinconf_generic_params structure, which is used by drivers to
> >   configure their bindings, which has a param member like pin_config_item.
> > * The pinconf_to_config_packed, which takes either the generic enum
> >   pin_config_param or a specialized one.
> >
> > Drivers are allowed to extend this enumerated type because of the gap
> > betweem PIN_CONFIG_END and PIN_CONFIG_MAX. Make it clear to Clang that
> > this is allowed by changing param's type in all of these instances to
> > int so no conversion needs to happen.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/138
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> I'm not superhappy about this because that enum is great for readability,
> even if the static syntax checker is unhappy.
> 
> If we can't have an enum here I would argue that we can just as well
> remove the enum altogether and just use #define for the config
> parameters, would you agree?
> 
> Yours,
> Linus Walleij

Hi Linus,

I see no reason to get rid of the enums. All this patch should do is
silence Clang's warnings because there is no other way to tell it that
this construct is okay except for changing the parameter/member type to
int (so no conversion needs to happen) or an explicit cast, which will
result in more noise in my opinion since this warning happens at least
10-15 times in the pinctrl drivers. There's no fundamental change to
how the enums are used.

See these other commits for similar fixes:

3eb95feac113 ("mm/zsmalloc.c: change stat type parameter to int")
04fecbf51b3c ("mm: memcontrol: use int for event/state parameter in several functions")

Cheers!
Nathan
