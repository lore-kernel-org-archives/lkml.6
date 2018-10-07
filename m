Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE75EC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D0E20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiwSByBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D0E20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJGPO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 11:14:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40328 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJGPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 11:14:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so13051685wro.7;
        Sun, 07 Oct 2018 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=+LiuT5tc9K65xktWfAQcJTc6+fJBESruVTUuxbPiIUc=;
        b=SiwSByBExBL6bgsDbvyRveF8yM/C+nmTjT9LLHq/O7+zhZqYX+if7SVQITpLtAUBDe
         y4Efn/DLsKZscbTQjQYJtiTNv5pbB/TogEB+rRdPttTaD5dX4BT10nnRHVmAkSugRjwr
         hfq5taPdoovV0ff3R3DmZ9Btua62EJM5z6cQA4gUQBRAnfbGEMm4AsQs1LKKXxeq/hkP
         QvfvcWl60j2HZIWNjmZZLVO915WfuPjA4jNXaqZYo+2Xn6hEiUD0VlVAin3ppqf1oWCL
         Y7y4EK3UQ5739cxHLEU5K5rtbRIkznI7s3Bq+eg4fhanYga+/U5/n6+UX7EGNp984Jvo
         KEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=+LiuT5tc9K65xktWfAQcJTc6+fJBESruVTUuxbPiIUc=;
        b=niPiRWKy/o2MBLtidJR4gTz+GUFGB5DOWzrHYyrumNnCeCCyhkUVdeJwEaY4ATC+kJ
         gnOV+Qc5TsPkJs9m/f/JUffcjAmpuxBCLiD+vUGR+ZVEzl4DwNbFqFCno/LJI+WR5Hhk
         k1wJaXH9bZPmDXEg/Y6YFg1hzzYkH5Pe1iAuZ0RClqWBaEANjkWagE3y/f7gnLKhC3dA
         SE+AoJ+tuZlbxDmbXHn/8J2KfbVOB/ZUb9Ae+FtfjG3WYsUnP53e5Bl022/HuwBCBT40
         d5Qfr8xZrIYlLLB4mryBJORgyrWwVqe1IP4WUogZASAkAeJQVrjpBxpvLJwHIP6B1JqW
         qSZA==
X-Gm-Message-State: ABuFfoh93OyxnB4lPfhEifS5jdpV78cbBzMUy4PPhGrIr/BMt7hAdOSE
        jPWTyLXWHNWC9MyX81deWQ==
X-Google-Smtp-Source: ACcGV60h/3NkHGA19ontS/joocnbZ9NAYq+Bb6E/mJs9NqmOXOuUwQypoG0fhMqzIbZR6uBSQPa+WA==
X-Received: by 2002:adf:e94b:: with SMTP id m11-v6mr13190212wrn.126.1538899677960;
        Sun, 07 Oct 2018 01:07:57 -0700 (PDT)
Received: from [192.168.1.79] (host86-147-130-6.range86-147.btcentralplus.com. [86.147.130.6])
        by smtp.gmail.com with ESMTPSA id y12-v6sm8895967wrq.33.2018.10.07.01.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 01:07:57 -0700 (PDT)
Date:   Sun, 07 Oct 2018 09:07:52 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <C01C1C07-13FA-4693-9493-2FAEE9153577@gmail.com>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org> <20180924194412.GA27477@arch> <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org> <C01C1C07-13FA-4693-9493-2FAEE9153577@gmail.com>
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
Message-ID: <74ABB71C-6B0C-44AE-BC30-1F385ADC3E42@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any updates on this?

On 25 September 2018 16:39:33 BST, Craig <ctatlor97@gmail=2Ecom> wrote:
>
>
>On 25 September 2018 12:17:26 BST, Veerabhadrarao Badiganti
><vbadigan@codeaurora=2Eorg> wrote:
>>
>>On 9/25/2018 1:18 AM, Craig Tatlor wrote:
>>> What socs have you tested this on?
>>> On sdm660 it seems to crash device
>>> when writing pwr ctl=2E
>>
>>Hi
>>We have tested this on SDM845=2E
>>SDM660 also has SDCC5 controller, so you would need to define
>>"qcom,sdhci-msm-v5" in your platform dt=2E
>>Can you confirm if you have defined this?
>>
>Hi,
>Yes my DT entry is as follows
>
>sdhc_1: sdhci@f9824900 {                                              =20
>                 =20
>compatible =3D "qcom,sdhci-msm-v5";                                     =
=20
>         =20
>reg =3D <0xc0c4000 0x1000>, <0xc0c5000 0x1000>;                         =
=20
>         =20
>interrupts =3D <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;                       =
=20
>         =20
>interrupt-names =3D "pwr_irq";                                          =
=20
>         =20
>                                                                      =20
>bus-width =3D <8>;                                                      =
=20
>         =20
>non-removable;                                                        =20
>         =20
>                                                                      =20
>vmmc-supply =3D <&pm660l_l4>;                                           =
=20
>         =20
>vqmmc-supply =3D <&pm660_l8>;                                           =
=20
>         =20
>                                                                      =20
>pinctrl-names =3D "default";                                            =
=20
>         =20
>pinctrl-0 =3D <&sdc1_clk &sdc1_cmd &sdc1_data &sdc1_rclk>;              =
=20
>         =20
>                                                                      =20
>clocks =3D <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;         =
=20
>         =20
>clock-names =3D "core", "iface";                                        =
=20
>         =20
>        };         =20
>
>>BTW, can you please share few details of the platform that you are
>>checking?
>>We are not aware of any dev platform based on SDM660=2E This is just for
>
>>my info
>
>I'm checking on the sony xperia xa2 (pioneer) smartphone=2E
>>
>>> On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
>>>> With SDCC5, the MCI register space got removed and the offset/order
>>of
>>>> several registers have changed=2E Based on SDCC version used and the
>>register,
>>>> we need to pick the base address and offset=2E
>>>>
>>>> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm:
>Configuring
>>IO_PAD support for sdhci-msm"
>>>>
>>>> Changes since RFC:
>>>> 	Dropped voltage regulator changes in sdhci-msm
>>>> 	Split the "Register changes for sdcc V5" patch
>>>> 	Instead of checking mci removal for deciding which base addr to
>>use,
>>>> 	new function pointers are defined for the 2 variants of sdcc:
>>>> 		1) MCI present
>>>> 		2) V5 (mci removed)
>>>> 	Instead of string comparing with the compatible string from DT
>>file,
>>>> 	the sdhci_msm_probe will now pick the data associated with the
>>>> 	compatible entry and use it to load variant specific address
>>offsets
>>>> 	and msm variant specific read/write ops=2E
>>>>
>>>> Changes since V1:
>>>> 	Removed unused msm_reab & msm_writeb APIs
>>>> 	Changed certain register addresses from uppercase to lowercase hex
>>>> 	letters
>>>> 	Removed extra lines and spaces
>>>> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
>>>> 	one for Documentation and other for the driver changes=2E
>>>>
>>>> Changes since V2:
>>>> 	Used lower case for macro function defenitions
>>>> 	Removed unused function pointers for msm_readb & msm_writeb
>>>>
>>>>
>>>> Sayali Lokhande (3):
>>>>    mmc: sdhci-msm: Define new Register address map
>>>>    Documentation: sdhci-msm: Add new compatible string for SDCC v5
>>>>    mmc: host: Register changes for sdcc V5
>>>>
>>>> Vijay Viswanath (1):
>>>>    mmc: sdhci-msm: Add msm version specific ops and data structures
>>>>
>>>>   =2E=2E=2E/devicetree/bindings/mmc/sdhci-msm=2Etxt          |   7 +-
>>>>   drivers/mmc/host/sdhci-msm=2Ec                       | 511
>>++++++++++++++++-----
>>>>   2 files changed, 391 insertions(+), 127 deletions(-)
>>>>
>>>> --=20
>>>>   Qualcomm India Private Limited, on behalf of Qualcomm Innovation
>>Center, Inc=2E
>>>> Qualcomm Innovation Center, Inc=2E is a member of Code Aurora Forum,
>a
>>Linux Foundation Collaborative Project=2E
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>linux-arm-msm" in
>>>> the body of a message to majordomo@vger=2Ekernel=2Eorg
>>>> More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Eh=
tml
>>
>>Thanks,
>>Veera

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
