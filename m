Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F51C208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdGpxs2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F51C208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbeIYVrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:47:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53007 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:47:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id l7-v6so9150043wme.2;
        Tue, 25 Sep 2018 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=z3JkBWuf39V9hT+sI/MiHVo51J5VXt/1UpOCuVdGl/Q=;
        b=YdGpxs2exzjpMNWy2I3TpsNVhW2eyncSaBQJNZITfaNbhKUdOyVjmU53tvygOkCJWk
         wpZ2uQFuMBVMP3v1LbbXIqR/5COsmNAABafZbJ35bc1RNF3+cc+1JAneQtfKZyjzFrJq
         s3+WmhnYgR7OaH+nkQKV1rqk/jjOtGsPiaPI3n3fgQnJHkHDhvBc9mYM5dXMnmQHnIzk
         sb+Bge/Sxgn9W1JmFhKn2lXb7jsTQJQm8B/FReo+hAlR761wBokcnCBUrOnleWjeduEv
         +3S7Kp+V1Bsw0VZ0TSjSCCVyCXZJ7PgwLQ3A5JnYue2hZ8g5WnpGQkngxNVpyR18g3r9
         rI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=z3JkBWuf39V9hT+sI/MiHVo51J5VXt/1UpOCuVdGl/Q=;
        b=scXIsDnG5xywx2ZM0l3CdpR7K2njkWwScjiN+ykraJpEyTwyx2ulTmSjZf2ATjfmOZ
         1OO7G2yjanJKHgiOYW4dV1oshuqEqAz4AXreNkNgJmqlqWnJnNlxM8KSXbhajJBYjKI4
         9npjOhXV2cZso/x8ne9nRdLrXhWUjTP9kbokeN7nbB3u7WWQI0l3d2wrkVByXTeHmn65
         eF/mjJbaQibOfI5VYU4+Jore+lvMxOZKLsTiFghNmNwqTMjPmt+gOSsYlM0ocMOsgHJT
         Qe4WJCOvX/XAwlOleWzwAUSyvz5dXEmIfcMF7UaBWtNoo7OwxEAm1qUbj9SuWH+TjIK+
         dKAQ==
X-Gm-Message-State: ABuFfohVe5uokwvoz0Br/WoQk6lb9IKszNad0DXh5zhDdc3beHqkwVms
        UHo47RQvs9AeoH/GnrNnmw==
X-Google-Smtp-Source: ACcGV61cczQ53RMd3Pv9M0RY9afbsRjLRkQlj+bhp4kL1WKb3H98ZG9PSXXI03c+yW7tgfofnFTRNg==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr1273092wme.111.1537889980795;
        Tue, 25 Sep 2018 08:39:40 -0700 (PDT)
Received: from android-dhcp-8-1-0-d4-38-9c-a2-1f-05.home (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2440195wrs.54.2018.09.25.08.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:39:40 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:39:33 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org> <20180924194412.GA27477@arch> <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>
CC:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
From:   Craig <ctatlor97@gmail.com>
Message-ID: <C01C1C07-13FA-4693-9493-2FAEE9153577@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 September 2018 12:17:26 BST, Veerabhadrarao Badiganti <vbadigan@code=
aurora=2Eorg> wrote:
>
>On 9/25/2018 1:18 AM, Craig Tatlor wrote:
>> What socs have you tested this on?
>> On sdm660 it seems to crash device
>> when writing pwr ctl=2E
>
>Hi
>We have tested this on SDM845=2E
>SDM660 also has SDCC5 controller, so you would need to define
>"qcom,sdhci-msm-v5" in your platform dt=2E
>Can you confirm if you have defined this?
>
Hi,
Yes my DT entry is as follows

        sdhc_1: sdhci@f9824900 {                                          =
                       =20
                compatible =3D "qcom,sdhci-msm-v5";                       =
                         =20
                reg =3D <0xc0c4000 0x1000>, <0xc0c5000 0x1000>;           =
                         =20
                interrupts =3D <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;         =
                         =20
                interrupt-names =3D "pwr_irq";                            =
                         =20
                                                                          =
                       =20
                bus-width =3D <8>;                                        =
                         =20
                non-removable;                                            =
                       =20
                                                                          =
                       =20
                vmmc-supply =3D <&pm660l_l4>;                             =
                         =20
                vqmmc-supply =3D <&pm660_l8>;                             =
                         =20
                                                                          =
                       =20
                pinctrl-names =3D "default";                              =
                         =20
                pinctrl-0 =3D <&sdc1_clk &sdc1_cmd &sdc1_data &sdc1_rclk>;=
                         =20
                                                                          =
                       =20
                clocks =3D <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_=
CLK>;                    =20
                clock-names =3D "core", "iface";                          =
                         =20
        };         =20

>BTW, can you please share few details of the platform that you are
>checking?
>We are not aware of any dev platform based on SDM660=2E This is just for=
=20
>my info

I'm checking on the sony xperia xa2 (pioneer) smartphone=2E
>
>> On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
>>> With SDCC5, the MCI register space got removed and the offset/order
>of
>>> several registers have changed=2E Based on SDCC version used and the
>register,
>>> we need to pick the base address and offset=2E
>>>
>>> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm: Configuring
>IO_PAD support for sdhci-msm"
>>>
>>> Changes since RFC:
>>> 	Dropped voltage regulator changes in sdhci-msm
>>> 	Split the "Register changes for sdcc V5" patch
>>> 	Instead of checking mci removal for deciding which base addr to
>use,
>>> 	new function pointers are defined for the 2 variants of sdcc:
>>> 		1) MCI present
>>> 		2) V5 (mci removed)
>>> 	Instead of string comparing with the compatible string from DT
>file,
>>> 	the sdhci_msm_probe will now pick the data associated with the
>>> 	compatible entry and use it to load variant specific address
>offsets
>>> 	and msm variant specific read/write ops=2E
>>>
>>> Changes since V1:
>>> 	Removed unused msm_reab & msm_writeb APIs
>>> 	Changed certain register addresses from uppercase to lowercase hex
>>> 	letters
>>> 	Removed extra lines and spaces
>>> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
>>> 	one for Documentation and other for the driver changes=2E
>>>
>>> Changes since V2:
>>> 	Used lower case for macro function defenitions
>>> 	Removed unused function pointers for msm_readb & msm_writeb
>>>
>>>
>>> Sayali Lokhande (3):
>>>    mmc: sdhci-msm: Define new Register address map
>>>    Documentation: sdhci-msm: Add new compatible string for SDCC v5
>>>    mmc: host: Register changes for sdcc V5
>>>
>>> Vijay Viswanath (1):
>>>    mmc: sdhci-msm: Add msm version specific ops and data structures
>>>
>>>   =2E=2E=2E/devicetree/bindings/mmc/sdhci-msm=2Etxt          |   7 +-
>>>   drivers/mmc/host/sdhci-msm=2Ec                       | 511
>++++++++++++++++-----
>>>   2 files changed, 391 insertions(+), 127 deletions(-)
>>>
>>> --=20
>>>   Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>Center, Inc=2E
>>> Qualcomm Innovation Center, Inc=2E is a member of Code Aurora Forum, a
>Linux Foundation Collaborative Project=2E
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>linux-arm-msm" in
>>> the body of a message to majordomo@vger=2Ekernel=2Eorg
>>> More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Eht=
ml
>
>Thanks,
>Veera

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
