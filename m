Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7776A21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545313743;
	bh=/yCjwrulphD2Ub/SJaKoA4YCvHnIDETP1sWJiQIgqqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bs68I9RTNxHL0J5zhYNdCVD4fVpsdSLIrJa1l9TTSgM2fmsHvHDUUc3JUpVXrPfeL
	 BVpcDx9c22vnFvJJ8HO0WG5BVGY1DQAUUQU60L86vWANLyeoGrb+92XyUqNABJ1Js+
	 SYsCiEcbaH5NbY2Ta1rm9+LOeEa5ZpKa/t0UmH+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbeLTNtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733309AbeLTNs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:57 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD69218AE;
        Thu, 20 Dec 2018 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545313735;
        bh=/yCjwrulphD2Ub/SJaKoA4YCvHnIDETP1sWJiQIgqqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AbneHcqpFOnHLNaK2zIrV5FSiWQzjAshS6FEHF2Y2SuzdgNrLwyZFNP9ned/Sg7gE
         qgfWh6O5OL2YNs12yaZ6yadG0FtgpDEmrqb0AEFRVqAMRMyAlT++6Ppap8BRRZtaka
         I1VZxvH32QtiX4C7f8g6PkUGyIgpL/nlQ9+53chA=
Received: by mail-qt1-f178.google.com with SMTP id v11so1839944qtc.2;
        Thu, 20 Dec 2018 05:48:55 -0800 (PST)
X-Gm-Message-State: AA+aEWbDINonTvXQUEmK3Mzvo2tmnP4ibDktECZ30HbXm+AnwHmFu/1F
        lukfu/CkjnvNube26/A8OUJ4+Po0LF3+20DpJQ==
X-Google-Smtp-Source: AFSGD/U6DXCG168neThkYAkaCKk5p9JOzPkqJ0RwyBvfcsyIkuR/iQgiIFpRh6FVOyckXOXFkRrTe/tx/eoU4I6CpWI=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr26787364qvl.77.1545313734888;
 Thu, 20 Dec 2018 05:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-2-chenyu56@huawei.com>
 <fde4d37b-0c4d-055b-a0ba-4e9fe87717ad@cogentembedded.com> <33cda716-d09c-28e7-d4b4-26f246786f5e@huawei.com>
 <680c5b9f-e2c7-926d-7d10-4ce2cd091282@cogentembedded.com> <bbe390f0-2fa6-515b-42c5-ede620b2b8c7@huawei.com>
 <20181219140953.GA9910@bogus> <87y38ku24b.fsf@linux.intel.com>
In-Reply-To: <87y38ku24b.fsf@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Dec 2018 07:48:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKooF=R93enNTvP9MLaJgoygoOEYyh4OU6-RP6E3Fv0vA@mail.gmail.com>
Message-ID: <CAL_JsqKooF=R93enNTvP9MLaJgoygoOEYyh4OU6-RP6E3Fv0vA@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] dt-bindings: usb: add support for dwc3
 controller on HiSilicon SoCs
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Chen Yu <chenyu56@huawei.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>, kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 12:46 AM Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
>
> Hi,
>
> Rob Herring <robh@kernel.org> writes:
> >> >>>> +Example:
> >> >>>> +    usb3: hisi_dwc3 {
> >> >>>> +        compatible = "hisilicon,hi3660-dwc3";
> >> >>>> +        #address-cells = <2>;
> >> >>>> +        #size-cells = <2>;
> >> >>>> +        ranges;
> >> >>>> +
> >> >>>> +        clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> >> >>>> +             <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> >> >>>> +        clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> >> >>>> +        assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> >> >>>> +        assigned-clock-rates = <229000000>;
> >> >>>> +        resets = <&crg_rst 0x90 8>,
> >> >>>> +             <&crg_rst 0x90 7>,
> >> >>>> +             <&crg_rst 0x90 6>,
> >> >>>> +             <&crg_rst 0x90 5>;
> >> >>>> +
> >> >>>> +        dwc3: dwc3@ff100000 {
> >
> > Please combine these into a single node. Unless you have a wrapper with
> > registers, you don't need these 2 nodes. Clocks and reset can go in the
> > dwc3 node.
> >
> >> >>>
> >> >>>      According to the DT spec, the node names should be generic, not chip specific, i.e. usb@ff100000 in this case.
> >> >>>
> >> >>
> >> >> Do you mean it should be usb@ff100000: dwc3@ff100000 ?
> >> >
> >> >     dwc3: usb@ff100000
> >> >
> >> >    "dwc3:" is a label, not name.
> >>
> >> I use the node name "dwc3@ff100000" according to Documentation/devicetree/bindings/usb/dwc3.txt
> >> and documentations of vendor drivers, i.e. qcom,dwc3.txt, rockchip,dwc3.txt.
> >>
> >> In these documentations, the dwc3 sub-node name uses "dwc3@xxxxxxxx".
> >>
> >> I think it is better to be same as the other vendor's dwc3 drivers.
> >
> > It's not. The other bindings are wrong. Follow the DT Spec.
>
> what's wrong about them? They clearly describe the HW:
>
> 1) a company-specific glue/adaptation/integration IP
> 2) a generic licensed IP inside it

That is *every* licensed IP block and DWC3 is the oddball where we did
this 2 node thing. It is not a pattern we should continue. If there's
registers in the wrapper, then yes, having 2 nodes makes sense. But
just additional clocks or resets, no. I would guess these extra clocks
and resets are inter-connect related and are needed as an artifact of
not describing and managing inter-connects.

I can just as easily argue it doesn't describe the hardware. I'm
pretty sure the DWC3 has clocks and resets yet there are none in the
DWC3 node. How can it operate with no clocks?

> dwc3.ko is compatible with Synopsys' documentation and there's only one
> incarnation of dwc3. Everything that can be detected in runtime, we do
> so. Everything that can't, we use quirk flags. Keep in mind dwc3.ko is
> also used as is by non-DT systems where we can't simply change a
> compatible flag.

Linux driver architecture doesn't dictate bindings.

Rob
