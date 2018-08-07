Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC58C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C544221A13
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kxw4WpTd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AuLF8mcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C544221A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeHGHaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:30:39 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40965 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeHGHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:30:39 -0400
Received: by mail-ua0-f196.google.com with SMTP id h1-v6so14760377uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kdfOnoyUtb6fE8haYwyTUmKHuGuMkKHtHm1GHiAHBJI=;
        b=kxw4WpTd0xHSZVGZfpeIIuCzkFCupaUSIyag/peOpLzeCOyn0T/sf+b4yp2fxom8fL
         w4nvnLbViTpB6M2g7+EFHccFekXivpP/LAkyhnOg0JKJ+TaLgb1YwzY5VAcZfLIvQtxr
         d125Huf1mJ17X3Sfp8dj8z4vfKaCXPFCsvk9hybgHmvFx2aq4pMP+SUHlVGBoqQrKgsh
         F1+uypoPc7KvwihU2CuISdmPpeg7005W6pAdpoLhyqtqYkOlSsLaA2vyc/zFttuOFVz3
         Xj1+BipWYiwzTjNUa1zIddQkefQAum50hTyGnS2H26OjXo4H/CgCgPNgvrsU+ymybu7S
         cqxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kdfOnoyUtb6fE8haYwyTUmKHuGuMkKHtHm1GHiAHBJI=;
        b=AuLF8mcIMMzooOO/684k2e5h4+sI412+AhQ8UZrjzWtFJoPwoKVZL4a1lODGmsIn2q
         et67Wtdpgmanyc54Id6Q3rAE+wO5PSKr8rlzB/SlKHKEI8MmIz2K9nRgOSdcDS/URY66
         b6RDD60fzFm+xJT9siI9odiXKhU2iryABLS/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kdfOnoyUtb6fE8haYwyTUmKHuGuMkKHtHm1GHiAHBJI=;
        b=OSz/vQUwN2ldfhsevRSJwu4Y/ECLSwg+Q+OBV1gWjtiw41fw6cG3Zkg0iACoXGjGqg
         YDKOdRW04oGGeZuZbtJL1DRonD+b39Z9EtZhpL0faz4d0y7X7TEqx7TVsW5PTGdgdGve
         sqUYPEjKyP2OcswYwlBBSltz9CIUdu7EQMVELgH0XWBkSlK0wtY+9nNPGEToJaFXJ2bA
         stkFbMDAtvE8e0ZVAgAm1h5XVeELOFyh+TnO+121q/VF3OsGYUvPeXpfQ0Efrkk4V3+F
         BY7QKivXtN6mBZnTMaDiV6P67wpf898+neuaGSJXzOtCPOYOQich8v2rYhGZBtMmGcNt
         FAZQ==
X-Gm-Message-State: AOUpUlFlBeS+/DZuEFkigH3/nwaAew57etIpJDhrJS/EqFU14KqNirL0
        rYDsCYwojRQh8s3RnuAiEmSXS1A1/hpQ90QKySM/nQ==
X-Google-Smtp-Source: AAOMgpf4EO5HDnIBWIFKHSFDq23BPQr1nwB/y/SnL3G4KHCP/C4/v2pDY/Uk7JXvm9zujP7EbcNpjy8FrD5askVhm+E=
X-Received: by 2002:a1f:acc4:: with SMTP id v187-v6mr11098191vke.32.1533619084233;
 Mon, 06 Aug 2018 22:18:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 22:18:03 -0700 (PDT)
In-Reply-To: <CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com>
References: <20180706233142.166296-1-dianders@chromium.org>
 <20180720141059.GA3064@rob-hp-laptop> <CAD=FV=WzjZBYV+yjekC-GGgjyWNbdGX=ZwesQMQhiYHZLyzhzA@mail.gmail.com>
 <CAL_JsqKZUB3P_Z_pRG-Udx0wgWtSjzgF=Rc3t8Xf2n2uZkV3Qw@mail.gmail.com>
 <CAD=FV=XBCeKUrfMCppfhetWNWLJWzsbiBkQnTugoXDff-0SD5w@mail.gmail.com>
 <CAL_Jsq+X=RZK-GU+9LqK-0O1A=cYeudhHvvnrXm6xv=j1Ck4_w@mail.gmail.com>
 <CAD=FV=UDq8oq+nKsa2mZWvAUueUFxEUSYz2JoZ=E7e131SOR=g@mail.gmail.com> <CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Aug 2018 22:18:03 -0700
X-Google-Sender-Auth: XJjfBQ6FEHuBnt2zOoKftIWXmjE
Message-ID: <CAD=FV=We9OQggYh_vpB6AF4uj=Fk1cqVZZhOijfOv0fEh98DZw@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qmp: Fix dts bindings to reflect reality
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 23, 2018 at 4:33 PM, Rob Herring <robh@kernel.org> wrote:
>> OK, I guess I will try again then and you can tell me when I get it
>> right (unless you tell me I should just change the driver to not use
>> named registers at all).  How about:
>>
>> - reg:
>>   - For "qcom,sdm845-qmp-usb3-phy":
>>     - index 0: address and length of register set for PHY's common serdes
>>                block.
>>     - index 1: address and length of the DP_COM control block.
>
> Instead of repeating index 0 below, just say "for
> 'qcom,sdm845-qmp-usb3-phy' only" here.
>
>>   - For all others:
>>     - index 0: address and length of register set for PHY's common serdes
>>                block.
>> - reg-names:
>>   - For "qcom,sdm845-qmp-usb3-phy":
>>     - Should be: "reg-base", "dp_com"
>>   - For all others:
>>     - The reg-names property shouldn't be defined.

To close the loop, I've just posted
<https://lore.kernel.org/patchwork/patch/972177/> AKA ("dt-bindings:
phy: qcom-qmp: Cleanup the 'reg' documentation as per review").
Hopefully that addresses everything properly but if not I'm happy to
spin it again.  Thanks for your patience in helping me understand what
you were looking for.

-Doug
