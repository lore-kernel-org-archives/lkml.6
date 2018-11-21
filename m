Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74528C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E09E2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSNOkRsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E09E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeKUMXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:23:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33282 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeKUMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:23:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so3971894wrr.0;
        Tue, 20 Nov 2018 17:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y2fmDKf5hxF75CTQp/zdiNY8rMfrwOSiIfz3uPF+M8Y=;
        b=pSNOkRsIARK2oIdnnwfNHEss24IDT1XV4ErQF4LtHQ5QIyllClKThjIpEdmJo79mAX
         EvEhlEiWotZvVSHRDtHtNMLKsiopGTlH8WbmCs7zVMZrRBuV/xzgmJI5TX0zyz2mrYoU
         7y9AgcRHdvqO1O39Td1MUwaCTGZwkNJ3kj0eRtC9vyIdKD3z/gGDLBWUrhzEo+Gk1J7E
         h5k+GDAhL8KI5Bw/qMrDql2cx4OuODju32OUjVaJezdvT6o0xqFkUN1ciG21nVfW90mZ
         yYc4clafkKcAC3YQUGmsTA8kmQJmdk+2Cc3djwp7WR6vLFZui7+keIKUuf0hUkVIzLes
         5mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y2fmDKf5hxF75CTQp/zdiNY8rMfrwOSiIfz3uPF+M8Y=;
        b=oiDy7lcLN88SQpR3xsD04coK8FxF6jGxDF7GH18hkAZfghmIWvHCH5qOsqRQlgjvuf
         zziUcwz+8w01BOQJ9lYj3IGbJ6tKph3VOBxG8Gc0CyNPxsLv4kFd5T6SRsyYbqrcPGja
         LHSPzT3/j7B6HrlMNs9WCRG01m9qQLBL/wac5fB/9tcPAmdyXaqhrw7rAcOV8II15KhF
         oJAm+VB2asZr2L85gEpaWodR/Lb9rCuov+Ho2+wZ7bLw1z5/s9QS6vuNJrX8O3NsLzhd
         k3jwsZSeA9glsfq4HzBoVlO/cVkTMMQpjvOA6iGtdmGDDnyrZaBIPmpPGREqFi8nwejK
         qh0A==
X-Gm-Message-State: AA+aEWZ2c9/TYs2gvGgEzME2/bM0b0FEcnrTQR1ZFM4TuA2pMz8WhTTL
        wVYGQ2J3/mS1NVYBc0utZ5Q=
X-Google-Smtp-Source: AFSGD/VdbFLlDEph2z7nBp4nKPxxDi6x/gf8euC1qWidwrOjsTkKVyR0jhu5/TQN/rZ8xgqYG1vs0g==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr4203383wrm.2.1542765070912;
        Tue, 20 Nov 2018 17:51:10 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id c13sm3481784wrb.38.2018.11.20.17.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 17:51:09 -0800 (PST)
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
 <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
 <OFDD04CD59.10199EDD-ON4825834B.001E1390-4825834B.001F65DD@mxic.com.tw>
 <e7fd0653-75a7-249a-462a-18a7bf4616d1@gmail.com>
 <OF26D8352D.B4B02BBE-ON4825834C.00043726-4825834C.0004E2F7@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <163dfc15-71b2-fdbe-f872-f6c6e4c3e14e@gmail.com>
Date:   Wed, 21 Nov 2018 02:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OF26D8352D.B4B02BBE-ON4825834C.00043726-4825834C.0004E2F7@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2018 01:53 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> Marek Vasut <marek.vasut@gmail.com>
>> 2018/11/20 下午 08:57
>>
>> >> > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-
>> >> rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> >> > new file mode 100644
>> >> > index 0000000..8286cc8
>> >> > --- /dev/null
>> >> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> >> > @@ -0,0 +1,33 @@
>> >> > +Renesas R-Car D3 RPC controller Device Tree Bindings
>> >> > +----------------------------------------------------
>> >> > +
>> >> > +Required properties:
>> >> > +- compatible: should be "renesas,rpc-r8a77995"
>> >> > +- #address-cells: should be 1
>> >> > +- #size-cells: should be 0
>> >> > +- reg: should contain 2 entries, one for the registers and one
>> >> for the direct
>> >> > +       mapping area
>> >> > +- reg-names: should contain "rpc_regs" and "dirmap"
>> >> > +- interrupts: interrupt line connected to the RPC SPI controller
>> >>
>> >> Do you also plan to support the RPC HF mode ? And if so, how would that
>> >> look in the bindings ? I'd like to avoid having to redesign the
> bindings
>> >> later to handle both the SPI and HF modes.
>> >>
>> >
>> > I patched this RPC SPI/Octa driver is for mx25uw51245g and you may also
>> > refer to Boris's patch. [1][2][3]
>>
>> Does this mean the driver is specific to one particular kind of flash ?
>>
> 
> No, this driver supports all SPI flash, spi, qspi and octa flash.
> 
> The target is Octa 8-8-8 DDR2 mode once spi-nor layer is merged.[1][2][3]

The HyperFlash must also be supported, cfr my previous comment that I'd
like to avoid redesigning the bindings again when the HF mode is added.

-- 
Best regards,
Marek Vasut
