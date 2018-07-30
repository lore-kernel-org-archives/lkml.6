Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EB620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7nF7k6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EB620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbeG3XQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:16:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54679 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeG3XQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:16:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so850477wmb.4;
        Mon, 30 Jul 2018 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLRTzG3IH4CWymWhETQY8fS7tdzUNeRZ8kYA1Ty5o+M=;
        b=k7nF7k6yvK8ExcBjziumt8mgFa1sM72T3RCOEGAo5K8mkq31Sy309qNE1thrtlQwr7
         15RisSoeCp3RG+cg/KmbVgg+ergOR9HFwmhpzRfCc4gQIvXX/WZr0il83G0sMWSvKrsy
         oSRtnA/BScgbFJxuKju+gSSrwOSDxwINixh1lPmT/wzvzAZF1gQaensXYMVHPt8F07ch
         +4QvWYVa/SVgWMWUb2RVIsXa9RKpk9ZR3+SrHeCSSviW9l4w7wHzxu9w5CGCRp8H6Jc1
         ZzXIsSWvnYoj9BvVBizkiQ0KRqX5xju8bwFMLNXl+SPL/1DoDWAzfyUZ5Ar8fpUQ1nKy
         GlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xLRTzG3IH4CWymWhETQY8fS7tdzUNeRZ8kYA1Ty5o+M=;
        b=HryCzXYYMxZxflPielP4JKuuk5h3fjjP/51UFFkt5giYRhA0Y316Q3R8wp+YcM1Da9
         bbesSd+4XHOvnMjSokKe1G9wM5wH+ODVL1b0yrD4CEO+XODBhyzUnDd7SpqfXIta0ulF
         czEI/AROUDp5pYs2Ez6ht4OH5t/tStQqlRyn0L41UMYZBktaqR39f4cJq6iMbnoU8I5Q
         RVMM9GJSPOhreB9KMvr4IDWPADpn4zmsnHAB3CoDGXkTmdC1ntsPrO/M5CnRAXsssJnh
         BNTpgd6l9NrVFE5RUK8eDX+kSQOO7dy+MhWMHk4Ox22InZTpTMChu+6g8ZoDlUSYQEF6
         GAnQ==
X-Gm-Message-State: AOUpUlGQwj2l8dlDwiIgHsRtSIWYdFWxrAddNGf3yOTUh0paeiApVbc9
        4M+gPal7PjlSCc72CLRfJSM=
X-Google-Smtp-Source: AAOMgpctfmGt+UXnCeYuzTSzH4gZ7xdwfyCG8N0R4c80eFVE//Qtm54rESWXsJFFLaWXD0TZSG9cvQ==
X-Received: by 2002:a1c:30c3:: with SMTP id w186-v6mr515209wmw.153.1532986785567;
        Mon, 30 Jul 2018 14:39:45 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id w4-v6sm10621848wrl.46.2018.07.30.14.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 14:39:44 -0700 (PDT)
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net
Cc:     kishon@ti.com, andrew@lunn.ch, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <bcea7c75-e5a6-4533-aee0-65c893e8a422@gmail.com>
Date:   Mon, 30 Jul 2018 14:39:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 05:43 AM, Quentin Schulz wrote:
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt | 42 +++++++-
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> new file mode 100644
> index 0000000..25b102d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> @@ -0,0 +1,42 @@
> +Microsemi Ocelot SerDes muxing driver
> +-------------------------------------
> +
> +On Microsemi Ocelot, there is a handful of registers in HSIO address
> +space for setting up the SerDes to switch port muxing.
> +
> +A SerDes X can be "muxed" to work with switch port Y or Z for example.
> +One specific SerDes can also be used as a PCIe interface.
> +
> +Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
> +
> +There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> +half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
> +10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> +
> +Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> +QSGMII.
> +
> +Required properties:
> +
> +- compatible: should be "mscc,vsc7514-serdes"
> +- #phy-cells : from the generic phy bindings, must be 3. The first number
> +               defines the kind of Serdes (1 for SERDES1G_X, 6 for
> +	       SERDES6G_X), the second defines the macros in the specified
> +	       kind of Serdes (X for SERDES1G_X or SERDES6G_X) and the
> +	       last one defines the input port to use for a given SerDes
> +	       macro,

It would probably be more natural to reverse some of this and have the
1st cell be the input port, while the 2nd and 3rd cell are the serdes
kind and the serdes macro type. Same comment as Andrew, can you please
define the 2nd and 3rd cells possible values in a header file that you
can include from both the DTS and the driver making use of that?
-- 
Florian
