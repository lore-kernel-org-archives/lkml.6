Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XxdGD1xOGlsrewAAmS7hNA
	; Fri, 08 Jun 2018 09:40:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B8817607DC; Fri,  8 Jun 2018 09:40:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnRpsedb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3A6AA602FC;
	Fri,  8 Jun 2018 09:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A6AA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeFHJkj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:40:39 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35438 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeFHJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:40:33 -0400
Received: by mail-vk0-f66.google.com with SMTP id o17-v6so7842928vka.2;
        Fri, 08 Jun 2018 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cs/diijMD/t43OBrQrSD7YSCuUjL/i28a2NzPKLo5pY=;
        b=DnRpsedbCjNIS3t0NRMft003xRPk8I43pt+WJj6mWmy+SwL0oRgum0wBQ2Dmexoy4r
         YfwP/OyBDZFcJ7jdAxWZ7+hypCJj6IfT5hOjRih9CXfTYHsmXdHfSA7R9NGN5bZraEi3
         ELGcQrUNBDPWCerkzersqddin7i60oPmK1YBw/hclsaksf+75+LyIwsYN22apTMYqdKm
         dkw7/6Ek5sqkv2dwhC444exqjXOv0xwOXc/Eys4v+0nnJ9YSLIsDSkKV9xR6f83BoEbl
         su6JwGVBorPW0i50np50lbJVfOn1wGtu0MdLaidjJFumPIwmggKMFqR6xH1XpyajoySp
         v6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cs/diijMD/t43OBrQrSD7YSCuUjL/i28a2NzPKLo5pY=;
        b=LqX/KFUNkjnU0qf+zhpaZ/86uO2OFlrsrSDAUBeFx7ntQbcxeWGg4Qpp9ewRjUd7Kk
         i0+eH2BxnOFmkD/ML73CudErtyzu4x1XHvmyeJ4f+lUzggw7tBEqJq0dufq8PTsAna/T
         46/UHSyddjs605or33lHxga4zncCX7BlSa7nAH4FdNKNEDulAM4ifefOWpLOhMnRZ9LC
         bZGP3xvNjRqgghs9vGdoNRo3HIElRfykwMEyXgMheLKYt4REZYs6HBveqlXPHSIbWjkZ
         eXBPurnQlRPlatA1RN/GDUCYB1lKJ5v000d8SJJDo22uo4hxTx9loKqnXGzoa9uci+sS
         jqIw==
X-Gm-Message-State: APt69E2CR24FHUxoy8x/Pn2snNb16d47yzjBBROdzRJCCS0wPYu7FtKZ
        sou8mkP3YSkNpAgVQVyItFDd4vL4oYy0CLfLPcYNFpb8
X-Google-Smtp-Source: ADUXVKKgBU+pefGk7obEXAaw0K3qbTiDaG3QxG7Nhs+acM81G/pGux9CUjgHhAsdrRaigZlVN+rqBS/JrSAgsgbpCAw=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr3367756vkc.26.1528450832662;
 Fri, 08 Jun 2018 02:40:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 02:40:32 -0700 (PDT)
In-Reply-To: <20180608081204.ztv4yb62szuyfsz6@pali>
References: <20180608081204.ztv4yb62szuyfsz6@pali>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Jun 2018 12:40:32 +0300
Message-ID: <CAHp75VfFA6ghuSeAAfcbRS47A12BCcQiAmBt_N5ejm8EsP+3yA@mail.gmail.com>
Subject: Re: ThinkPad T480s & thinkpad_acpi.ko
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 11:12 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> Hi! I just found out that thinkpad_acpi.ko is not automatically loaded
> on new ThinkPad T480s. Is there any reason for it? Manually calling
> modprobe thinkpad_acpi is working fine, but I would expect that it
> should be loaded automatically.
>
> Here is dmesg output after loading it manually:
>
> thinkpad_acpi: ThinkPad ACPI Extras v0.25
> thinkpad_acpi: http://ibm-acpi.sf.net/
> thinkpad_acpi: ThinkPad BIOS N22ET34W (1.11 ), EC unknown
> thinkpad_acpi: Lenovo ThinkPad T480s, model 20L7S03000
> thinkpad_acpi: radio switch found; radios are enabled
> thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness contr=
ol, supported by the ACPI video driver
> thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
> thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
> thinkpad_acpi: Standard ACPI backlight interface available, not loading n=
ative one

Did you run depmod -a?
Is it present in the output?

There are three ways of enumeration as far as I can see from the driver's c=
ode:
- by short driver name "tpacpi" (not likely our case)
- by DMI matching (only for old BIOS'es)
- by ACPI ID

So, does the ACPI contain one of the listed IDs?

#define TPACPI_ACPI_IBM_HKEY_HID        "IBM0068"
#define TPACPI_ACPI_LENOVO_HKEY_HID     "LEN0068"
#define TPACPI_ACPI_LENOVO_HKEY_V2_HID  "LEN0268"
?

--=20
With Best Regards,
Andy Shevchenko
