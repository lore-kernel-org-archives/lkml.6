Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3EC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26730214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3VxD7ut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfAIAt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:49:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43057 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAIAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:49:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so5235927otr.10;
        Tue, 08 Jan 2019 16:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wXrQbyQZ+anYfBs8BuhzWXIQPhlbwfC6XJo7brY0Pvg=;
        b=V3VxD7utis6dsrNoW1BWMFUNi/7ItYU+4MRKLLiJFZmgpNd8MlSeKvCr5ZTQwzUjKA
         4epO9UWnLK8wjy6L8M4OIUvCXEu5OhDZ1hW5su7/2F51XJc99UqrT5Kc8sBF3+EP8yD4
         DfoOFDTXXiz4sTqw/eHrNuRQEqk1LRwuHzrqFYhj/uaYRwBF67KY2WHGPb5Ec271/D5q
         xKtH2rGgJpeSzFMa2NwBxJ82D9Pyn0lZB3j7rkjFxaRDvEgaxpTnMY5itxNWpQt9abpg
         57iXeZSZV3FT6u5P2jDWpoRpAP75WCiDDqpjvP1i9cvA8gRof7F9pKbDJtykTag33ZHq
         haVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wXrQbyQZ+anYfBs8BuhzWXIQPhlbwfC6XJo7brY0Pvg=;
        b=sputRRNnR5u/p5fLBmqYxL+V5Adxj11spsf3kwvOQTfu2Fses5FzG7sQC9TsKEYZQW
         IC6HYHCGFpMxroRxMghWRCh2sy1TstoOaM/NF3WzzdoaeqD9tS7PrVsdIXK8gzq1CcVM
         ZjnnwSwfvTTmYKXHZl1O6Mbg9OCaTVVUtOdv/4vWkiFJ9Gdxm9UZImfUG0TYQAVes3zN
         lY7Xah7A1Fuq59KXPv/P9z9CLBdV870Mpbh3HL1OiyDSTtwXNNK/Dq+g3FphUhGW3Nz3
         lz6Bu0nTvyFtMjhT5y5Vm3w00BvnG/e5W6FhCTo30Php1kaONBo3ttnlHHLDWyYtvzwx
         4UgA==
X-Gm-Message-State: AJcUuked4WHr7VaQ8HqPaym/q3XT8jAueQddpf2QH3pgB1ka208ewFqx
        NJPWdDMK0xJiK85nStA4X85iXKwal50/U/lSrNo=
X-Google-Smtp-Source: ALg8bN5Uju+yXm4RhSXRrdFPYBj+327n67L7kBVYRCs+epXl6YNk5RVuMaPDwLm6q9K+1ku0XcGR+OaDcngtl+6v9y0=
X-Received: by 2002:a9d:67:: with SMTP id 94mr2732948ota.57.1546994994808;
 Tue, 08 Jan 2019 16:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20190108192628.121270-1-sashal@kernel.org> <20190108192628.121270-8-sashal@kernel.org>
In-Reply-To: <20190108192628.121270-8-sashal@kernel.org>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Tue, 8 Jan 2019 16:49:18 -0800
Message-ID: <CA+A7VXUA5CGqWMMX_C6sar14f1_TYHxL166bjkMMcW731ndeHg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.20 008/117] platform/x86: asus-wmi: Tell the EC
 the OS will handle the display off hotkey
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sasha,

On Tue, Jan 8, 2019 at 11:26 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com>
>
> [ Upstream commit 78f3ac76d9e5219589718b9e4733bee21627b3f5 ]
>
> In the past, Asus firmwares would change the panel backlight directly
> through the EC when the display off hotkey (Fn+F7) was pressed, and
> only notify the OS of such change, with 0x33 when the LCD was ON and
> 0x34 when the LCD was OFF. These are currently mapped to
> KEY_DISPLAYTOGGLE and KEY_DISPLAY_OFF, respectively.
>
> Most recently the EC on Asus most machines lost ability to toggle the
> LCD backlight directly, but unless the OS informs the firmware it is
> going to handle the display toggle hotkey events, the firmware still
> tries change the brightness through the EC, to no effect. The end result
> is a long list (at Endless we counted 11) of Asus laptop models where
> the display toggle hotkey does not perform any action. Our firmware
> engineers contacts at Asus were surprised that there were still machines
> out there with the old behavior.
>
> Calling WMNB(ASUS_WMI_DEVID_BACKLIGHT=3D=3D0x00050011, 2) on the _WDG dev=
ice
> tells the firmware that it should let the OS handle the display toggle
> event, in which case it will simply notify the OS of a key press with
> 0x35, as shown by the DSDT excerpts bellow.
>
>  Scope (_SB)
>  {
>      (...)
>
>      Device (ATKD)
>      {
>          (...)
>
>          Name (_WDG, Buffer (0x28)
>          {
>              /* 0000 */  0xD0, 0x5E, 0x84, 0x97, 0x6D, 0x4E, 0xDE, 0x11,
>              /* 0008 */  0x8A, 0x39, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66,
>              /* 0010 */  0x4E, 0x42, 0x01, 0x02, 0x35, 0xBB, 0x3C, 0x0B,
>              /* 0018 */  0xC2, 0xE3, 0xED, 0x45, 0x91, 0xC2, 0x4C, 0x5A,
>              /* 0020 */  0x6D, 0x19, 0x5D, 0x1C, 0xFF, 0x00, 0x01, 0x08
>          })
>          Method (WMNB, 3, Serialized)
>          {
>              CreateDWordField (Arg2, Zero, IIA0)
>              CreateDWordField (Arg2, 0x04, IIA1)
>              Local0 =3D (Arg1 & 0xFFFFFFFF)
>
>              (...)
>
>              If ((Local0 =3D=3D 0x53564544))
>              {
>                  (...)
>
>                  If ((IIA0 =3D=3D 0x00050011))
>                  {
>                      If ((IIA1 =3D=3D 0x02))
>                      {
>                          ^^PCI0.SBRG.EC0.SPIN (0x72, One)
>                          ^^PCI0.SBRG.EC0.BLCT =3D One
>                      }
>
>                      Return (One)
>                  }
>              }
>              (...)
>          }
>          (...)
>      }
>      (...)
>  }
>  (...)
>
>  Scope (_SB.PCI0.SBRG.EC0)
>  {
>      (...)
>
>      Name (BLCT, Zero)
>
>      (...)
>
>      Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
>      {
>          If ((BLCT =3D=3D Zero))
>          {
>              Local0 =3D One
>              Local0 =3D RPIN (0x72)
>              Local0 ^=3D One
>              SPIN (0x72, Local0)
>              If (ATKP)
>              {
>                  Local0 =3D (0x34 - Local0)
>                  ^^^^ATKD.IANE (Local0)
>              }
>          }
>          ElseIf ((BLCT =3D=3D One))
>          {
>              If (ATKP)
>              {
>                  ^^^^ATKD.IANE (0x35)
>              }
>          }
>      }
>      (...)
>  }
>
> Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I am not entirely sure this is linux-stable material. This patch makes
the "turn off the display backlight" hotkey work on some Asus machines
where, without this patch, the key would simply do nothing. It seems
to me this is more of a new feature support than a bug fix. That said,
if you or Andy think this should go to stable after this short
explanation, I'll not object it.

Thanks and best regards,

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
