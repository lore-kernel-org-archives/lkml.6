Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4145EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED152073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="RECLUrag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED152073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIEWl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:41:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35410 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeIEWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:41:28 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 03A0C5C00FA;
        Wed,  5 Sep 2018 20:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536171009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apZoP+shIF26tClVeACs8JTbF7npn2Xzz17KQvODUxE=;
        b=RECLUragXnY2pDr9orfRB4CWRCSlyOqBcd+R4GUrwWSqtgxL+a7d+2ag4LwImfRtxsM0Vr
        5LlJTL3Yrqb8jvbHsoriP2iqd0VMIn4eHSASeWx1lNLIgLXApCGlPJVsUqNEIfOjrArVnB
        xlV4CJbKIPI+hRhVOdft/uLx6Adz9oE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Sep 2018 11:10:08 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, architt@codeaurora.org,
        a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: display: add data-enable polarity
 property
In-Reply-To: <139651706.L0sBFfZMDQ@avalon>
References: <20180905052113.21262-1-stefan@agner.ch>
 <20180905052113.21262-3-stefan@agner.ch> <139651706.L0sBFfZMDQ@avalon>
Message-ID: <e708c5bac502e60a2eeb685fddf67042@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2018 00:07, Laurent Pinchart wrote:
> Hi Stefan,
> 
> Thank you for the patch.
> 
> On Wednesday, 5 September 2018 08:21:10 EEST Stefan Agner wrote:
>> Allow to specify the data-enable polarity required by a dumb VGA
>> DAC converting parallel RGB to VGA.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  .../devicetree/bindings/display/bridge/dumb-vga-dac.txt          | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>> b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt index
>> 164cbb15f04c..adbd2ca0af2f 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
>> @@ -18,6 +18,7 @@ graph bindings specified in
>> Documentation/devicetree/bindings/graph.txt.
>>
>>  Optional properties:
>>  - vdd-supply: Power supply for DAC
>> +- de-active: data-enable pulse is active low/high/ignored
> 
> Which value corresponds to low, high and ignored ?
> 

The wording is taken from
Documentation/devicetree/bindings/display/panel/display-timing.txt. But
I agree, not very useful.

0 is low active, 1 is high active, and none is using driver defaults.

How about:
- de-active: data-enable pulse is 0=active low/1=active high

--
Stefan

>>  Example
>>  -------
