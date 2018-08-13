Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDFFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046C4217FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WihFIAVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046C4217FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeHMJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:18:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33515 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:18:04 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so25496773oip.0;
        Sun, 12 Aug 2018 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CarX7VpmkKCz529zGywUO+p39LHs71GvvGqQ+gM8lhA=;
        b=WihFIAVS5cJbs+/Wpgta9c+Hy4N5VMPnuoJKiXZzY2/y6fNNolG3iOUW2e3PVTqGVp
         YXqq33t5Ix1yl9cLZ8KKdrBrwd62s7MDR9cIpJQaLMDHpj+i3t6pz9RW1QkgjvCrrGa7
         UojEPKvfY4TGyrdHmhTVKz9AL//giEFfy9g7Bp98Owz4W2Q8s+oS2W+bwJAmqBBHAFAQ
         +wVszLx6ef0LlT2r5JLFwRlo9tQyr9mJB+bK65Tv7fODTFmlX3H5oI2XfHMy0KD5dyws
         YhTgTuJVWW8I49Yauj+TPS0fwECF/so0uY1qIqOO2A01W4sRXnG/jOZfAHHD+T+9wAGq
         Nw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CarX7VpmkKCz529zGywUO+p39LHs71GvvGqQ+gM8lhA=;
        b=X5QSyQG/76hXmADYir7HWHj2OICEKhiRWpLHSyJcCFAFvF0Mxc4pDCoQIWLPi71Npr
         pHuu20redBBYdBpzZeMuOTYRv/NIjoqVjUC91hjv20FqbVHZ7ebukjVS1bZuqstSbWzf
         KGIIucPwxxeEY/sAq5mI35sS7+Zla1y0vEddDXvBD45s3CGnkvQbe+SgDnNrOLjkoz75
         cqLkfm35XiMOo84OS8fcHjNIAm67s/bZ/99mFQrqQFcOtp/ee6vExQOtOzKIJZz/EbVH
         Xrc64fQ+9wM0wty/WRNlBMHjS5WbMcCUWB3UBGMRgeEHooIlihC+wGswegk08MFqOQtL
         sJNg==
X-Gm-Message-State: AOUpUlGInRBWErXHpKRGH+POo3jnOeDIJwvkzpgxj5jZAuvOkiHnJN1H
        JZgNyDGm6Sj8rr+Qc+aUtO9WDAbBxeiinYxv0yp/ccDH
X-Google-Smtp-Source: AA+uWPxJ5MYoQAjsRDw3veB9nhS9NYt2uKl4Y6ick7THaULPMYh0epB6ubYwUn3GFHJL1Jvz4LKZ1qfOwGxR7bn52sE=
X-Received: by 2002:aca:b48b:: with SMTP id d133-v6mr15253706oif.165.1534142233587;
 Sun, 12 Aug 2018 23:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180806160933.6578-1-krzk@kernel.org> <CANAwSgTYviRnLjVU50w_o5k6=iMjxqU5qQ+7RW9K43KrrqRKPA@mail.gmail.com>
 <CAJKOXPds5s8omeR7UOB4u4HrYCZBTJX3t4YU4PSWBGb-9MG7iw@mail.gmail.com>
In-Reply-To: <CAJKOXPds5s8omeR7UOB4u4HrYCZBTJX3t4YU4PSWBGb-9MG7iw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 13 Aug 2018 12:07:02 +0530
Message-ID: <CANAwSgQBthsKMKBBnKBnCJdKwKOMm0XKRn5r=gnpdbC6Eu9=ag@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: exynos: Add missing used PMIC regulators on
 Exynos5422 Odroid boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: multipart/mixed; boundary="000000000000de532a05734b5259"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000de532a05734b5259
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Sun, 12 Aug 2018 at 18:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 11 August 2018 at 08:39, Anand Moon <linux.amoon@gmail.com> wrote:
> > Hi Krzysztof,
> >
> > These patches should also be ported to u-boot to enable PMIC.
> >
> > I was just looking into S2MPS11B data sheet
> > According to the 1.2 Key Features of  S2MPS11
> >
> > BUCK1, BUCK2, BUCK3, BUCK4, BUCK6 have (0.65 V to 1.6 V) min /max range.
> > BUCK5 have (0.65 V to 2.0 V) min /max range.
> > BUCK7 have (1.2 V to 1.5 V) min / max range.
> > BUCK8 have (1.8 V to 2.1 V) min / max range.
> > BUCK10 have (0.75 V to 1.4 V) min / max range.
> >
> > BUCKBOST9 (3.0 V to 3.75 V) min / max range.
> >
> > LDO1, LDO6, LDO11, LDO22, LDO23, LDO27, LDO35 (0.8 V to 2.375 V) min / max range
> >
> > LDO2, LDO3, LDO5, LDO7, LDO9, LDO10, LD012, LDO13, LDO14, LDO15,
> > LDO16, LDO17, LDO18, LDO19, LDO20, LD021, LDO24, LDO25, LDO26,
> > LDO28, LDO29, LDO30, LDO31, LDO32, LDO33, LDO34, LDO36, LDO37, LDO38
> > (0.8 V to 3.95 V) min / max range
> >
> > I am aware off we have configures the min/max range as per board schematics.
> > but each regulator support dynamic voltage scale and have different
> > turn on/off voltage and current rating.
> >
> > So why are we not setting the regulator-min-microvolt /
> > regulator-max-microvolt as per datasheets.
> > Please correct me if I am wrong.
>
> Which regulators are not configured as in datasheet?
>
> Best regards,
> Krzysztof

Almost all the regulator have some miss default match of min/max setting.
I have tried to adjust the setting on top your above patches.

I am attaching my patch diff for testing.
I have have perform some stress testing and found no issue at my end.

Best Regards
-Anand

--000000000000de532a05734b5259
Content-Type: application/octet-stream; name="regulator.patch"
Content-Disposition: attachment; filename="regulator.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jkrwmcxc0>
X-Attachment-Id: f_jkrwmcxc0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0MjItb2Ryb2lkLWNvcmUuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5vczU0MjItb2Ryb2lkLWNvcmUuZHRzaQppbmRleCAx
NzhlMTA2NGNmYzcuLmQ5OTAxNzg1MjNhMCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
ZXh5bm9zNTQyMi1vZHJvaWQtY29yZS5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2V4eW5v
czU0MjItb2Ryb2lkLWNvcmUuZHRzaQpAQCAtMTQ5LDc2ICsxNDksNzYgQEAKIAkJcmVndWxhdG9y
cyB7CiAJCQlsZG8xX3JlZzogTERPMSB7CiAJCQkJcmVndWxhdG9yLW5hbWUgPSAidmRkX2xkbzEi
OwotCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDEwMDAwMDA+OwotCQkJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDEwMDAwMDA+OworCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDgwMDAwMD47CisJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MjM3NTAwMD47CiAJ
CQkJcmVndWxhdG9yLWFsd2F5cy1vbjsKIAkJCX07CiAKIAkJCWxkbzJfcmVnOiBMRE8yIHsKIAkJ
CQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRfbGRvMiI7Ci0JCQkJcmVndWxhdG9yLW1pbi1taWNyb3Zv
bHQgPSA8MTgwMDAwMD47Ci0JCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTgwMDAwMD47
CisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3It
bWF4LW1pY3Jvdm9sdCA9IDwzOTUwMDAwPjsKIAkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwogCQkJ
fTsKIAogCQkJbGRvM19yZWc6IExETzMgewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZHFfbW1j
MCI7Ci0JCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47Ci0JCQkJcmVndWxh
dG9yLW1heC1taWNyb3ZvbHQgPSA8MTgwMDAwMD47CisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3Zv
bHQgPSA8ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzOTUwMDAwPjsK
IAkJCX07CiAKIAkJCWxkbzRfcmVnOiBMRE80IHsKIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRf
YWRjIjsKLQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKLQkJCQlyZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDw4MDAwMDA+OworCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDM5NTAwMDA+
OwogCQkJfTsKIAogCQkJbGRvNV9yZWc6IExETzUgewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZk
ZF9sZG81IjsKLQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKLQkJCQly
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWluLW1p
Y3Jvdm9sdCA9IDw4MDAwMDA+OworCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDM5NTAw
MDA+OwogCQkJCXJlZ3VsYXRvci1hbHdheXMtb247CiAJCQl9OwogCiAJCQlsZG82X3JlZzogTERP
NiB7CiAJCQkJcmVndWxhdG9yLW5hbWUgPSAidmRkX2xkbzYiOwotCQkJCXJlZ3VsYXRvci1taW4t
bWljcm92b2x0ID0gPDEwMDAwMDA+OwotCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDEw
MDAwMDA+OworCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDgwMDAwMD47CisJCQkJcmVn
dWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MjM3NTAwMD47CiAJCQkJcmVndWxhdG9yLWFsd2F5cy1v
bjsKIAkJCX07CiAKIAkJCWxkbzdfcmVnOiBMRE83IHsKIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2
ZGRfbGRvNyI7Ci0JCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47Ci0JCQkJ
cmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTgwMDAwMD47CisJCQkJcmVndWxhdG9yLW1pbi1t
aWNyb3ZvbHQgPSA8ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzOTUw
MDAwPjsKIAkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwogCQkJfTsKIAogCQkJbGRvOF9yZWc6IExE
TzggewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZF9sZG84IjsKLQkJCQlyZWd1bGF0b3ItbWlu
LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKLQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwx
ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OworCQkJCXJl
Z3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDM5NTAwMDA+OwogCQkJCXJlZ3VsYXRvci1hbHdheXMt
b247CiAJCQl9OwogCiAJCQlsZG85X3JlZzogTERPOSB7CiAJCQkJcmVndWxhdG9yLW5hbWUgPSAi
dmRkX2xkbzkiOwotCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMwMDAwMDA+OwotCQkJ
CXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMwMDAwMDA+OworCQkJCXJlZ3VsYXRvci1taW4t
bWljcm92b2x0ID0gPDgwMDAwMD47CisJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8Mzk1
MDAwMD47CiAJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsKIAkJCX07CiAKIAkJCWxkbzEwX3JlZzog
TERPMTAgewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZF9sZG8xMCI7Ci0JCQkJcmVndWxhdG9y
LW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47Ci0JCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQg
PSA8MTgwMDAwMD47CisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKKwkJ
CQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzOTUwMDAwPjsKIAkJCQlyZWd1bGF0b3ItYWx3
YXlzLW9uOwogCQkJfTsKIAogCQkJbGRvMTFfcmVnOiBMRE8xMSB7CiAJCQkJcmVndWxhdG9yLW5h
bWUgPSAidmRkX2xkbzExIjsKLQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxMDAwMDAw
PjsKLQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsKKwkJCQlyZWd1bGF0
b3ItbWluLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OworCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0
ID0gPDIzNzUwMDA+OwogCQkJCXJlZ3VsYXRvci1hbHdheXMtb247CiAJCQl9OwogCkBAIC0yMjYs
MTMgKzIyNiwxMyBAQAogCQkJCS8qIFVudXNlZCAqLwogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZk
ZF9sZG8xMiI7CiAJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKLQkJCQly
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwyMzc1MDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1p
Y3Jvdm9sdCA9IDwzOTUwMDAwPjsKIAkJCX07CiAKIAkJCWxkbzEzX3JlZzogTERPMTMgewogCQkJ
CXJlZ3VsYXRvci1uYW1lID0gInZkZHFfbW1jMiI7Ci0JCQkJcmVndWxhdG9yLW1pbi1taWNyb3Zv
bHQgPSA8MjgwMDAwMD47Ci0JCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MjgwMDAwMD47
CisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3It
bWF4LW1pY3Jvdm9sdCA9IDwzOTUwMDAwPjsKIAkJCX07CiAKIAkJCWxkbzE0X3JlZzogTERPMTQg
ewpAQCAtMjQ0LDggKzI0NCw4IEBACiAKIAkJCWxkbzE1X3JlZzogTERPMTUgewogCQkJCXJlZ3Vs
YXRvci1uYW1lID0gInZkZF9sZG8xNSI7Ci0JCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8
MzMwMDAwMD47Ci0JCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47CisJCQkJ
cmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1p
Y3Jvdm9sdCA9IDwzOTUwMDAwPjsKIAkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwogCQkJfTsKIApA
QCAtMjU4LDIxICsyNTgsMjEgQEAKIAogCQkJbGRvMTdfcmVnOiBMRE8xNyB7CiAJCQkJcmVndWxh
dG9yLW5hbWUgPSAidmRkX2xkbzE3IjsKLQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwz
MzAwMDAwPjsKLQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsKKwkJCQly
ZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OworCQkJCXJlZ3VsYXRvci1tYXgtbWlj
cm92b2x0ID0gPDM5NTAwMDA+OwogCQkJCXJlZ3VsYXRvci1hbHdheXMtb247CiAJCQl9OwogCiAJ
CQlsZG8xOF9yZWc6IExETzE4IHsKIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRfZW1tY18xVjgi
OwotCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDE4MDAwMDA+OwotCQkJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDE4MDAwMDA+OworCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDgwMDAwMD47CisJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8Mzk1MDAwMD47CiAJ
CQl9OwogCiAJCQlsZG8xOV9yZWc6IExETzE5IHsKIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRf
c2QiOwotCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDI4MDAwMDA+OwotCQkJCXJlZ3Vs
YXRvci1tYXgtbWljcm92b2x0ID0gPDI4MDAwMDA+OworCQkJCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0gPDgwMDAwMD47CisJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8Mzk1MDAwMD47
CiAJCQl9OwogCiAJCQlsZG8yMF9yZWc6IExETzIwIHsKQEAgLTI5OCw4ICsyOTgsOCBAQAogCiAJ
CQlsZG8yM19yZWc6IExETzIzIHsKIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRfbWlmcyI7Ci0J
CQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTEwMDAwMD47Ci0JCQkJcmVndWxhdG9yLW1h
eC1taWNyb3ZvbHQgPSA8MTEwMDAwMD47CisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8
ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwyMzc1MDAwPjsKIAkJCQly
ZWd1bGF0b3ItYWx3YXlzLW9uOwogCQkJfTsKIApAQCAtMzIyLDE4ICszMjIsMTkgQEAKIAkJCQly
ZWd1bGF0b3ItbmFtZSA9ICJ2ZGRfbGRvMjYiOwogCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDgwMDAwMD47CiAJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8Mzk1MDAwMD47CisJ
CQkJcmVndWxhdG9yLWFsd2F5cy1vbjsKIAkJCX07CiAKIAkJCWxkbzI3X3JlZzogTERPMjcgewog
CQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZF9nM2RzIjsKLQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDwxMDAwMDAwPjsKLQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMDAwMDAw
PjsKKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OworCQkJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDIzNzUwMDA+OwogCQkJCXJlZ3VsYXRvci1hbHdheXMtb247CiAJ
CQl9OwogCiAJCQlsZG8yOF9yZWc6IExETzI4IHsKIAkJCQkvKiBVc2VkIG9uIFhVMyAqLwotCQkJ
CXJlZ3VsYXRvci1uYW1lID0gInZkZF9sZG8yNiI7CisJCQkJcmVndWxhdG9yLW5hbWUgPSAidmRk
X2xkbzI4IjsKIAkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OwogCQkJCXJl
Z3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDM5NTAwMDA+OwogCQkJfTsKQEAgLTQxMCw1NSArNDEx
LDU1IEBACiAKIAkJCWJ1Y2sxX3JlZzogQlVDSzEgewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZk
ZF9taWYiOwotCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDgwMDAwMD47Ci0JCQkJcmVn
dWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTMwMDAwMD47CisJCQkJcmVndWxhdG9yLW1pbi1taWNy
b3ZvbHQgPSA8NjUwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxNjAwMDAw
PjsKIAkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwogCQkJCXJlZ3VsYXRvci1ib290LW9uOwogCQkJ
fTsKIAogCQkJYnVjazJfcmVnOiBCVUNLMiB7CiAJCQkJcmVndWxhdG9yLW5hbWUgPSAidmRkX2Fy
bSI7Ci0JCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKLQkJCQlyZWd1bGF0
b3ItbWF4LW1pY3Jvdm9sdCA9IDwxNTAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9s
dCA9IDw2NTAwMDA+OworCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE2MDAwMDA+Owog
CQkJCXJlZ3VsYXRvci1hbHdheXMtb247CiAJCQkJcmVndWxhdG9yLWJvb3Qtb247CiAJCQl9Owog
CiAJCQlidWNrM19yZWc6IEJVQ0szIHsKIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRfaW50IjsK
LQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OwotCQkJCXJlZ3VsYXRvci1t
YXgtbWljcm92b2x0ID0gPDE0MDAwMDA+OworCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0g
PDY1MDAwMD47CisJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTYwMDAwMD47CiAJCQkJ
cmVndWxhdG9yLWFsd2F5cy1vbjsKIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsKIAkJCX07CiAKIAkJ
CWJ1Y2s0X3JlZzogQlVDSzQgewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZF9nM2QiOwotCQkJ
CXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDgwMDAwMD47Ci0JCQkJcmVndWxhdG9yLW1heC1t
aWNyb3ZvbHQgPSA8MTQwMDAwMD47CisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NjUw
MDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxNjAwMDAwPjsKIAkJCQlyZWd1
bGF0b3ItYWx3YXlzLW9uOwogCQkJCXJlZ3VsYXRvci1ib290LW9uOwogCQkJfTsKIAogCQkJYnVj
azVfcmVnOiBCVUNLNSB7CiAJCQkJcmVndWxhdG9yLW5hbWUgPSAidmRkX21lbSI7Ci0JCQkJcmVn
dWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKLQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jv
dm9sdCA9IDwxNDAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw2NTAwMDA+
OworCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDIwMDAwMDA+OwogCQkJCXJlZ3VsYXRv
ci1hbHdheXMtb247CiAJCQkJcmVndWxhdG9yLWJvb3Qtb247CiAJCQl9OwogCiAJCQlidWNrNl9y
ZWc6IEJVQ0s2IHsKIAkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRfa2ZjIjsKLQkJCQlyZWd1bGF0
b3ItbWluLW1pY3Jvdm9sdCA9IDw4MDAwMDA+OwotCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0
ID0gPDE1MDAwMDA+OworCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDY1MDAwMD47CisJ
CQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTYwMDAwMD47CiAJCQkJcmVndWxhdG9yLWFs
d2F5cy1vbjsKIAkJCQlyZWd1bGF0b3ItYm9vdC1vbjsKIAkJCX07CiAKIAkJCWJ1Y2s3X3JlZzog
QlVDSzcgewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZF8xLjB2X2xkbyI7Ci0JCQkJcmVndWxh
dG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9s
dCA9IDwxMjAwMDAwPjsKIAkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxNTAwMDAwPjsK
IAkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwogCQkJCXJlZ3VsYXRvci1ib290LW9uOwpAQCAtNDY2
LDggKzQ2Nyw4IEBACiAKIAkJCWJ1Y2s4X3JlZzogQlVDSzggewogCQkJCXJlZ3VsYXRvci1uYW1l
ID0gInZkZF8xLjh2X2xkbyI7Ci0JCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAw
PjsKLQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxNTAwMDAwPjsKKwkJCQlyZWd1bGF0
b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9s
dCA9IDwyMTAwMDAwPjsKIAkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOwogCQkJCXJlZ3VsYXRvci1i
b290LW9uOwogCQkJfTsKQEAgLTQ4Miw4ICs0ODMsOCBAQAogCiAJCQlidWNrMTBfcmVnOiBCVUNL
MTAgewogCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZF92bWVtIjsKLQkJCQlyZWd1bGF0b3ItbWlu
LW1pY3Jvdm9sdCA9IDwyODUwMDAwPjsKLQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwy
ODUwMDAwPjsKKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw3NTAwMDA+OworCQkJCXJl
Z3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE0MDAwMDA+OwogCQkJCXJlZ3VsYXRvci1hbHdheXMt
b247CiAJCQkJcmVndWxhdG9yLWJvb3Qtb247CiAJCQl9OwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvZXh5bm9zNTQyMi1vZHJvaWR4dTMtY29tbW9uLmR0c2kgYi9hcmNoL2FybS9ib290
L2R0cy9leHlub3M1NDIyLW9kcm9pZHh1My1jb21tb24uZHRzaQppbmRleCBlNTIyZWRiMmJiODIu
LjJjMDAzNzFjYTYyNyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQyMi1v
ZHJvaWR4dTMtY29tbW9uLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQyMi1v
ZHJvaWR4dTMtY29tbW9uLmR0c2kKQEAgLTM2OCw4ICszNjgsOCBAQAogfTsKIAogJmxkbzI2X3Jl
ZyB7Ci0JcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzAwMDAwMD47Ci0JcmVndWxhdG9yLW1h
eC1taWNyb3ZvbHQgPSA8MzAwMDAwMD47CisJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAw
MDAwPjsKKwlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzOTUwMDAwPjsKIAlyZWd1bGF0b3It
YWx3YXlzLW9uOwogfTsKIApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQy
Mi1vZHJvaWR4dTMuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvZXh5bm9zNTQyMi1vZHJvaWR4dTMu
ZHRzCmluZGV4IGRiMGJjMTdhNjY3Yi4uZTYwYzc5OTk2ZDZjIDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9leHlub3M1NDIyLW9kcm9pZHh1My5kdHMKKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvZXh5bm9zNTQyMi1vZHJvaWR4dTMuZHRzCkBAIC01MSw4ICs1MSw4IEBACiAKICZsZG8yOF9y
ZWcgewogCXJlZ3VsYXRvci1uYW1lID0gImRwX3AzdjMiOwotCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0gPDMzMDAwMDA+OwotCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Owor
CXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDgwMDAwMD47CisJcmVndWxhdG9yLW1heC1taWNy
b3ZvbHQgPSA8Mzk1MDAwMD47CiB9OwogCiAmcHdtIHsK
--000000000000de532a05734b5259--
