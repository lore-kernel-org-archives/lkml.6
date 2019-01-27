Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A25C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 12:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EAD2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 12:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jiITg+iE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfA0MbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 07:31:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44761 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfA0MbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 07:31:06 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so11226268iod.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 04:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ylwVQt/bj/wGunye0Cfen+VL65GmNXz4RkapuwjnSuY=;
        b=jiITg+iEelaAbvPaqqpRNaKA+YI70JqxADX7KhOpvsIKbLVl+1BasZJg7FVuGuxdfy
         ebmcUU5JVEdOJ45TTipW6ru+ZOfnE+a5FX5YBQiIqKxF/jh6O+GKA7/ht3M+3K7xYwtr
         U6aboeYgEcvw1btcMEWYh+L5cuvhpm3/U2Mvci+bIBEBswWV5QD8m7rZL3ZNtek1jSHX
         OwkYAyLzVVtA9c4amLEMs8qBZt0iAVM0M+B3Wk4ENn+2AhcGFuQl50IRKCt0Ny2LnelL
         3k3Wh3A3Yxpd6AOJ1Ut7SiS2vDR0j3WSPRnI610wT1BIcFEtJWXygEBk2G7rkavKB/qf
         nM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylwVQt/bj/wGunye0Cfen+VL65GmNXz4RkapuwjnSuY=;
        b=U3w+53e3YxBybG9ySWaRX865ptuLZy1AIW6xJHDzTD2BzhDK1xDHsNaDy7fPA9prO8
         T8fjJe33xahd/ywQ5+b6hP6oqpewPmUl+KpXc6zcPKEEdxrF0DWGbOyo+7SOX3tCC+eQ
         NmKdJVDOws1Uhnn+JZpWWvebRlfuLM2zGP+u2N1L8nGX/1JppuOQyo+6cYZWBtRU7b2+
         auSjqxrIzAet/kw2Sgf831QhTvvWoTtaaHMKpBkPgn2KAFDQsHwsqMT0aw+jkwuu/5Qk
         /lXyryczA218VTaOCZXziBKqejfUtA+Pzg6i75q2Mb/A6hbh49dtrkjb8N2yENPIactJ
         slvg==
X-Gm-Message-State: AHQUAuZBgu5rmkTGjzxTwDJxmbdozxHRpUP9ku6H127aEw9V2fIHlfeK
        d//xp37U61Y/sP4X64cwVRA2cRTfZVtY1/RL3xpAlA==
X-Google-Smtp-Source: AHgI3IbrNjBhNjaxQBxwwg4tvFiBjE3B65LKZsMe/9T4QcFezz+mRJC2LTko71NCqHcDrkk9P+lRJRnOH/5fRua23qI=
X-Received: by 2002:a5d:834e:: with SMTP id q14mr10583438ior.258.1548592265876;
 Sun, 27 Jan 2019 04:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20190124151837.1ca96816@canb.auug.org.au> <df1743f8-71c8-3b18-1e8a-94198d99477d@huawei.com>
In-Reply-To: <df1743f8-71c8-3b18-1e8a-94198d99477d@huawei.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 27 Jan 2019 13:30:55 +0100
Message-ID: <CAMRc=MdMK=PMqHeroiyytwZ0w3++iiXWZaBQsRMQvjgvQqDBQw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the gpio-brgl tree
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 24 sty 2019 o 06:42 YueHaibing <yuehaibing@huawei.com> napisa=C5=82(a=
):
>
> On 2019/1/24 12:18, Stephen Rothwell wrote:
> > Hi Bartosz,
> >
> > After merging the gpio-brgl tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >
> > drivers/gpio/gpio-davinci.c: In function 'davinci_gpio_get_irq_chip':
> > drivers/gpio/gpio-davinci.c:472:9: warning: function returns address of=
 local variable [-Wreturn-local-addr]
> >   return &gpio_unbanked.chip;
> >          ^~~~~~~~~~~~~~~~~~~
> > drivers/gpio/gpio-davinci.c: In function 'keystone_gpio_get_irq_chip':
> > drivers/gpio/gpio-davinci.c:480:9: warning: function returns address of=
 local variable [-Wreturn-local-addr]
> >   return &gpio_unbanked;
> >          ^~~~~~~~~~~~~~
> >
> > Introduced by commit
> >
> >   ee5e87158e63 ("gpio: davinci: drop pointless static qualifier")
>
> I'm very sorry for this.
>
> I misread the code, Pls revert this.
>
> >
>

I backed out this one.

Thanks,
Bartosz
