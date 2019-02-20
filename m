Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F6EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD192089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaMy5pf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfBTUrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:47:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33413 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:47:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so27662510wrw.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 12:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j5vcakdDl8387Tu318xfj3WMU/t7dPLIuJoaP/jo6GQ=;
        b=OaMy5pf4ce/mBWFme4xXThCQ3aufaK8E5P3letJ/QBnUY/TAhclICns2DisohHWJgZ
         Wv5DzX72nKZdhOEDXTcLlADMURJnBzNF7KzczAswoVvs9Qp9mtr5IjuUh/JnjUWMCAiZ
         4BgfKCNoYIIpHECcXZX6yf2VGu0tudHKUH9hyRP5TjXLVjY5WRmW0YQqmivad4/lseg6
         bdouH0UOnn1n5UZvVRD12lDBFqaMpmFa50JqA1qlXhESyDpVJ2+ItqORf372TOQo8zUX
         PxWqI6Z2+y5nIn1PSxnRIgb0Vgj4NEfg7eHAJRl3wiL6I9q3jMTr5zua097shOSs6gp+
         t/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j5vcakdDl8387Tu318xfj3WMU/t7dPLIuJoaP/jo6GQ=;
        b=HVxGP6XsWOblKne+ApOY2k/emhkxraJKnbMGd48pcaktTWaYe23Q2C8HmXRpZ0gJn8
         kyvfMnRMkr4OYSnIHoFKpYMC2h7p54f8iBjKBVaM/k3k7ium6pUyGAlV58DZcjg0esed
         tTnkdHut6zsHXaKQreUNpoFaMywf6wHQ+M1icKv6M1vhXDV5DWEAKqluzskb2O+2fIdJ
         F+WsoRO3fWY0GUhaSsUeObqTE+qMYORDuNgCruB3cwg+Vc+U3Ngep3pZDnkPNskw7Muj
         f51ql0Sjvg4wjbFsGULtBZUrISZONlWw3aKA9LFMinEvjEJy+IigxQYSZa/HXxJRwgcq
         IgJw==
X-Gm-Message-State: AHQUAuaJOjDD5SEVjIB7fQIDugzQQUCVYn+z5MOYFIpfShq3G4MsrKQa
        HIzlp+B+jR6DnYuBfCzzhKg=
X-Google-Smtp-Source: AHgI3IZ23fxihTkEle1m6IpDPY8Zj4oxScTSqAqztu58OQe9bjiu5M9wl2a52dwrqHkTC1KOJs2CQA==
X-Received: by 2002:adf:ba84:: with SMTP id p4mr26088739wrg.156.1550695618161;
        Wed, 20 Feb 2019 12:46:58 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.67])
        by smtp.gmail.com with ESMTPSA id c186sm9656791wmf.34.2019.02.20.12.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 12:46:57 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gwYlb-0006qQ-DU; Wed, 20 Feb 2019 23:46:55 +0300
Date:   Wed, 20 Feb 2019 23:46:55 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/2] extcon-intel-cht-wc: Make charger detection
 co-existed with OTG host mode
Message-ID: <20190220204655.GB23567@jeknote.loshitsa1.net>
References: <20190219212441.19391-1-jekhor@gmail.com>
 <20190219212441.19391-2-jekhor@gmail.com>
 <20190220124206.GP9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220124206.GP9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:42:06PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 20, 2019 at 12:24:40AM +0300, Yauhen Kharuzhy wrote:
> > Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
> > of charger detection procedure. Do this by manipulationg of CHGRCTRL1
> > register.
> > 
> > Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
> > Intel's drivers.
> 
> Some minor comments below.
> 
> Otherwise,
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > -#define CHT_WC_CHGRCTRL1		0x5e17
> > +#define CHT_WC_CHGRCTRL1			0x5e17
> 
> Not related change?

just alignment, yes.

> 
> > +#define CHT_WC_CHGRCTRL1_DBPEN_MASK		BIT(7)
> 
> Drop the _MASK, it's one bit anyway.
OK.

> 
> > +#define CHT_WC_CHGRCTRL1_OTGMODE		BIT(6)
> > +#define CHT_WC_CHGRCTRL1_FTEMP_EVENT		BIT(5)
> > +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_1500	BIT(4)
> > +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_900		BIT(3)
> > +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_500		BIT(2)
> > +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_150		BIT(1)
> > +#define CHT_WC_CHGRCTRL1_FUSB_INLMT_100		BIT(0)
> 
> I think better to keep ascending order.

OK.

> 
> > +static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
> > +				      bool enable)
> > +{
> > +	unsigned int chgrctrl1;
> > +	int ret;
> > +
> > +	ret = regmap_read(ext->regmap, CHT_WC_CHGRCTRL1, &chgrctrl1);
> > +	if (ret) {
> > +		dev_err(ext->dev, "Error reading CHGRCTRL1 reg: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	if (enable)
> > +		chgrctrl1 |= CHT_WC_CHGRCTRL1_OTGMODE;
> > +	else
> > +		chgrctrl1 &= ~(CHT_WC_CHGRCTRL1_OTGMODE);
> 
> Redundant parens.

Hmm... Why I didn't use regmap_update_bits() here... I will simplify this
piece with it.

Thanks!

-- 
Yauhen Kharuzhy
