Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A33ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8964920881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgT8pVJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8964920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIOBmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:42:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40251 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOBmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:42:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207-v6so3205632wme.5;
        Fri, 14 Sep 2018 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+6WweJG3cNmqHj1KtQAx0yWvgxqkZic98Vsg5Ugv0KA=;
        b=kgT8pVJ19sHQlTNqbj+gj6T9ze1PFLhltYLuPv8KNtZWX42HsfrCjmYli73uuYmMV7
         ZZOgY81y9TlQflB4ILRrjBXtVrV71zP69afNlO/jaVSeojwbL+xpzMMAHIauJOVn/X2B
         qvHiICjkvqjJJjTz/q1+ews6xPrzbp+OjGK0XKFB9V4DJsp7rvt8iZ5u6hblk8mQRWQw
         aa9G6CI4rB1wBklRcnpQgr/8bJv6uKTnuAyo8Fy5rCoSA7jvePzGdvIgBjs9ujTQa/cz
         KGG5Tbfch33nNHgoINgRqJJ9TMhdcAjCy0HY+r4FA+Hum70n9G1AUy/OY0lP9+ENNxi4
         uIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+6WweJG3cNmqHj1KtQAx0yWvgxqkZic98Vsg5Ugv0KA=;
        b=cZ632hPqq9WHk8/8u40pZ1NklTnL5ItPQh1ztk8RBljZ1KHEri2n7r5SoIPDxGCpKm
         4Pc3kdfMseQ2Gugsu/8cSpatHtKPhmZDri1RtdEQlQan+IBQSDtdM+CUokVC3s+vJo7M
         Shrd4pWNyBQeP3OhHwfiw12AmUvpD+uEozJXmtlOAe1fnNBoHIqHcAxsTlvXgxMY/ADU
         vCy784dRuEy9IuOiP4mfGHhLXjhnhYTJhu/51/ZYB+ywk6smmE7pJI7XNfYgpcvAhXzK
         NMTumvhF7+JVrt7L6rl8XPURBgMhBa/25eBZkbztng0ZGQPBiHTCjTI4IPyr+O8UDpmG
         s4LA==
X-Gm-Message-State: APzg51C2F57AwosEWCz4pMNPTgeNeEEaV59R4fqOfHiqGPAiJbj7uB+F
        Ze7a8cEFyGHQJT9S3hSANVg=
X-Google-Smtp-Source: ANB0VdY32Jsz+Ft5AcOqG7j66CnRtA3Pki4ikdgzgm/zGhnQx5XpF5pTjM+KLmKhWLX5+BTNOigtDg==
X-Received: by 2002:a1c:a94d:: with SMTP id s74-v6mr3678270wme.39.1536956787828;
        Fri, 14 Sep 2018 13:26:27 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id d12-v6sm8615717wru.36.2018.09.14.13.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 13:26:26 -0700 (PDT)
Subject: Re: [PATCH net-next 4/7] net: phy: mscc: add support for VSC8574 PHY
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <236ef7815c0bec6048e79ef06868719b65c63892.1536916714.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <bc95fae7-cf2f-5cf1-4e24-59fcc231fd64@gmail.com>
Date:   Fri, 14 Sep 2018 13:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <236ef7815c0bec6048e79ef06868719b65c63892.1536916714.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 02:44 AM, Quentin Schulz wrote:
> The VSC8574 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
> 1000BASE-X and triple-speed copper SFP capable, can communicate with
> the MAC via SGMII, QSGMII or 1000BASE-X, supports WOL, downshifting and
> can set the blinking pattern of each of its 4 LEDs, supports SyncE as
> well as HP Auto-MDIX detection.
> 
> This adds support for 10/100/1000BASE-T, SGMII/QSGMII link with the MAC,
> WOL, downshifting, HP Auto-MDIX detection and blinking pattern for its 4
> LEDs.
> 
> The VSC8574 has also an internal Intel 8051 microcontroller whose
> firmware needs to be patched when the PHY is reset. If the 8051's
> firmware has the expected CRC, its patching can be skipped. The
> microcontroller can be accessed from any port of the PHY, though the CRC
> function can only be done through the PHY that is the base PHY of the
> package (internal address 0) due to a limitation of the firmware.
> 
> The GPIO register bank is a set of registers that are common to all PHYs
> in the package. So any modification in any register of this bank affects
> all PHYs of the package.
> 
> If the PHYs haven't been reset before booting the Linux kernel and were
> configured to use interrupts for e.g. link status updates, it is
> required to clear the interrupts mask register of all PHYs before being
> able to use interrupts with any PHY. The first PHY of the package that
> will be init will take care of clearing all PHYs interrupts mask
> registers. Thus, we need to keep track of the init sequence in the
> package, if it's already been done or if it's to be done.
> 
> Most of the init sequence of a PHY of the package is common to all PHYs
> in the package, thus we use the SMI broadcast feature which enables us
> to propagate a write in one register of one PHY to all PHYs in the
> package.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

[snip]

> +	reg = __mdiobus_read(bus, phy, MSCC_PHY_TEST_PAGE_8);
> +	reg |= 0x8000;

Having a define would be nice here? This looks like a write enable?

> +	__mdiobus_write(bus, phy, MSCC_PHY_TEST_PAGE_8, reg);
> +
> +	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
> +
> +	vsc8584_csr_write(bus, phy, 0x8fae, 0x000401bd);

Just make this an array of address + value pairs and blast it to the
PHY, having them be inlined here is both error prone and does not scale
well at all.
[snip]
> +	vsc8584_csr_write(bus, phy, 0x84a8, 0x00000000);
> +	vsc8584_csr_write(bus, phy, 0x84aa, 0x00000000);
> +	vsc8584_csr_write(bus, phy, 0x84ae, 0x007df7dd);
> +	vsc8584_csr_write(bus, phy, 0x84b0, 0x006d95d4);
> +	vsc8584_csr_write(bus, phy, 0x84b2, 0x00492410);

Likewise

[snip]
-- 
Florian
