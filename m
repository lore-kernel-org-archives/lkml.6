Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCD2223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ahb1kKjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCD2223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbeKMT5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:57:48 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:54448 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbeKMT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:57:48 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 897F210C004C;
        Tue, 13 Nov 2018 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542103227; bh=0JYzbCT1ZxnaInC/7pfsyI2Qxplr7eoPRIQQ1O/CExw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Ahb1kKjVuMahSX9aRRrrwQYoPcTy9FsDa1lGa7I87kE7WGZRzScQ8AYS5iKwaykPr
         cLdyEMTIsnkAIBLuZAcHqCy7lVXa+WVAOsJt+OQCaO4qAuLkey2gEZqKRvzuYhPvhG
         KIcQFvyhAoEFobfce9yuLpP0WnikM0EXSPscHj68ABiruMPAuIv07/vX2dyXrtK2tU
         /br2YrRGLR5eo89Us68ipy8DuI6tQAzVmWgla1hlyRGUW1DNfTeoawEe77Y4vnh3Qw
         1thtIpqkQsxMGoMmSedR54G194zmuB9f8KWB87Xl+1dfPtE7LJpyWeoTrOwof4ubRe
         ek8WgZ2ANDSUA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id C54AC35CA;
        Tue, 13 Nov 2018 02:00:26 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 02:00:26 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 11:00:24 +0100
Received: from [10.107.25.130] (10.107.25.130) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 11:00:24 +0100
Subject: Re: [V3, 3/4] Documentation: dt-bindings: media: Document bindings
 for DW MIPI CSI-2 Host
To:     Rob Herring <robh@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <joao.pinto@synopsys.com>, <festevam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Keiichi Watanabe" <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        <devicetree@vger.kernel.org>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
 <1539953556-35762-4-git-send-email-lolivei@synopsys.com>
 <20181024174007.GA2902@bogus>
From:   Luis de Oliveira <luis.oliveira@synopsys.com>
Message-ID: <45d87050-c5a8-dd96-20ae-d4951b0f4564@synopsys.com>
Date:   Tue, 13 Nov 2018 10:00:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024174007.GA2902@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.130]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24-Oct-18 18:40, Rob Herring wrote:
> On Fri, Oct 19, 2018 at 02:52:25PM +0200, Luis Oliveira wrote:
>> Add bindings for Synopsys DesignWare MIPI CSI-2 host.
>>
>> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
>> ---
>> Changelog
>> v2-V3
>> - removed IPI settings
>>
>>  .../devicetree/bindings/media/snps,dw-csi-plat.txt | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
>> new file mode 100644
>> index 0000000..be3da05
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
>> @@ -0,0 +1,52 @@
>> +Synopsys DesignWare CSI-2 Host controller
>> +
>> +Description
>> +-----------
>> +
>> +This HW block is used to receive image coming from an MIPI CSI-2 compatible
>> +camera.
>> +
>> +Required properties:
>> +- compatible: shall be "snps,dw-csi-plat"
> 
> 'plat' is really part of the name of the h/w block?
> 

It is the name of the platform driver for CSI compatible with this block. Is
that wrong?

>> +- reg			: physical base address and size of the device memory mapped
>> +  registers;
>> +- interrupts		: CSI-2 Host interrupt
>> +- snps,output-type	: Core output to be used (IPI-> 0 or IDI->1 or BOTH->2)
>> +			  These  values choose which of the Core outputs will be used,
>> +			  it can be Image Data Interface or Image Pixel Interface.
>> +- phys			: List of one PHY specifier (as defined in
>> +			  Documentation/devicetree/bindings/phy/phy-bindings.txt).
>> +			  This PHY is a MIPI DPHY working in RX mode.
>> +- resets		: Reference to a reset controller (optional)
>> +
>> +The per-board settings:
>> + - port sub-node describing a single endpoint connected to the camera as
>> +   described in video-interfaces.txt[1].
> 
> Need to say 2 ports and what is each port? Why no port #0?
> 

I will elaborate on that.

>> +
>> +Example:
>> +
>> +	csi2_1: csi2@3000 {
>> +		compatible = "snps,dw-csi-plat";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = < 0x03000 0x7FF>;
>> +		interrupts = <2>;
>> +		output-type = <2>;
>> +		resets = <&dw_rst 1>;
>> +		phys = <&mipi_dphy_rx1 0>;
>> +		phy-names = "csi2-dphy";
> 
> Not documented. Not really needed for a single entry, so I'd just drop 
> it.
> 

I will, thanks.

>> +
>> +		/* CSI-2 per-board settings */
>> +		port@1 {
>> +			reg = <1>;
>> +			csi1_ep1: endpoint {
>> +				remote-endpoint = <&camera_1>;
>> +				data-lanes = <1 2>;
>> +			};
>> +		};
>> +		port@2 {
>> +			csi1_ep2: endpoint {
>> +				remote-endpoint = <&vif1_ep>;
>> +			};
>> +		};
>> +	};
>> --
>> 2.7.4
>>
