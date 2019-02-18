Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8633AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4B52177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DNzyc+qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbfBROIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:08:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40655 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390319AbfBROIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:08:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so13913079eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=gFO8LwK33ywbW9SIa15Cb2gHG5oozM6OBAvVIPZVXeQ=;
        b=DNzyc+qYAb0NALeJg8RzVLqy5pj2aOWYWpkgh1UJ75D0mESwiTMtROi3ixJjqTPXgs
         VeRsa5L7avUdKK1tal1QfU61H8ifm6m51boKWdKoYDnEWmNsloICO2Vpm86J0eiGCUeY
         n9Mi2RwB6INJ/TVB8wv+hhPNizbA/eIruGJErj4amKoHGCpc3U97kMAlix7KAtYnzBwB
         gsC1NP5118CAiIHviDvpcjV0a2F4XvP1bkctr+D9jejS9NZjliNxCAqgBiNDZXsVtxIh
         W4CRh6NlpS4djp47IcObWOS/rfu28g2TO3oBZHS3PzN1yah0rakfKdtOSaN5qSeshENr
         O6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=gFO8LwK33ywbW9SIa15Cb2gHG5oozM6OBAvVIPZVXeQ=;
        b=dCTU9Xouud4Zz6B1H7ef8CC2QpvxSrQPpAg0QljUR4ZGnwm/BydU3GdmPmsZ+lj9BP
         HBaLOiBY4dTtbDHCMQpNkoYyJVQlmpm3r84fm3hm5PNtbiH5JazlY5qHjjuzaEHlaCOF
         m4grw2+7kaeUwkc+rbvTC1FGCjc8/1RHPHPZSmJydAa3bSmA6FzcRX4G3hd4aQa7lqz7
         MzOMNaRKULb3nCMPkDEueZjiMu8bGL9K6GIWFkoAeP7HB8NkJVkGB8Z9l3bL+GXCeIua
         5loAlOvJe6FiicKt4veIFihjF/XdaQp9jh1gT/XfrHV483VW2Rf/0ERMkArZ7Vyavosh
         zmOw==
X-Gm-Message-State: AHQUAuaACQM8AoRYgUAcrm/NVkxigHQujj+wFHKq8mJh3aU58Z4NJpkD
        9C4O0vQ+OwTWOShZo00fSHWEsw==
X-Google-Smtp-Source: AHgI3IZ7ok34FpI0tRYpAXVimkuavzpjqGgMrAfeBtgkLwiOqtsdEYxrS6H+LQDmdFWUDrZAitMD6A==
X-Received: by 2002:a50:9927:: with SMTP id k36mr19279800edb.31.1550498921640;
        Mon, 18 Feb 2019 06:08:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:3053])
        by smtp.gmail.com with ESMTPSA id k4sm3094441ejj.32.2019.02.18.06.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:08:40 -0800 (PST)
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com> <1550070569-18588-3-git-send-email-lollivier@baylibre.com> <20190215160457.GO28278@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190215160457.GO28278@localhost>
Date:   Mon, 18 Feb 2019 15:08:38 +0100
Message-ID: <86k1hxur2x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 15 Feb 2019 at 16:04, Johan Hovold <johan@kernel.org> wrote:

> On Wed, Feb 13, 2019 at 04:09:27PM +0100, Loys Ollivier wrote:
>> Add binding for Mediatek-based GNSS receivers.
>> 
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> ---
>> v4:
>> Use standard names for reset-gpios and gnss-fix-gpios
>> s/an/a UART
>> 
>> v3:
>> Removed the I2C and SPI interfaces references.
>> Removed the "mediatek,mt3339" compatible line.
>> Added the optional propertied (reset, fix)
>> Added the pin names for the optional properties.
>> 
>> v2:
>> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> Moved current-speed as an optional propertie.
>> Removed the status line in the example.
>> Added "mediatek,mt3339" compatible.
>> 
>>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> new file mode 100644
>> index 000000000000..12283d429baa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> @@ -0,0 +1,37 @@
>> +Mediatek-based GNSS Receiver DT binding
>> +
>> +Mediatek chipsets are used in GNSS-receiver modules produced by several
>> +vendors and can use a UART interface.
>> +
>> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>> +properties.
>> +
>> +Required properties:
>> +
>> +- compatible	: Must be
>> +
>> +			"globaltop,pa6h"
>> +
>> +- vcc-supply	: Main voltage regulator (pin name: VCC)
>> +
>> +Optional properties:
>> +
>> +- current-speed		: Default UART baud rate
>> +- gnss-fix-gpios	: GPIO used to determine device position fix state
>> +			  (pin name: FIX, 3D_FIX)
>> +- reset-gpios		: GPIO used to reset the device
>> +  		  	  (pin name: RESET, NRESET)
>> +- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
>> +- v-bckp-supply		: Backup voltage regulator
>> +  			  (pin name: VBAT, VBACKUP)
>
> As we discussed, I changed this to "vbackup-supply" (here and in the
> driver) before applying.
>
> Note that git reported some whitespace errors above too (spaces before
> tabs) that I fixed up. Not sure why checkpatch doesn't complain.
>
Oops, thanks for fixing it. I ran checkpatch again and it did not
complain. Apprently it's not checking for spaces before tabs in "txt"
files.
I'll add a step in my flow to apply the patches I create before sending
them to the list so that won't happen again ;)

> All now applied.
>
Yay ! Thanks !
Loys


> Thanks,
> Johan


-- 
-L
