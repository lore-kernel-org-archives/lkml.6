Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75323C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C52D204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cfTpPXSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfARKw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:52:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41484 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfARKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:52:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so14441683wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PZJF0C+hyFf1HstSG8qVVlhySOMtz+6M9ZQ3PF9X9Ew=;
        b=cfTpPXSVs5yuz54aguDsdCaA76Qtr45ZnGqb/DF07Igl0NlhRRaQt1cGNiY4ENJQag
         npNJ3ASBh8WzidPjeXcTL4ww5gmRMibPxhK8q7kIZqUqxqUBO+/D/F7c7QyPTXFRqCgH
         3DfaCRTCw0sEzvP+CA240SU1vSDekCNBeeuCYE1hBMW8ONntyQ+gAxLfC30KD2KoQio0
         VULHmDlqgrieEYiCQxAzxdbVTtdm9a5/ffVmNjVwLRo/tH8VevVxoHEYysNIgyVAhlgm
         Y+KE7gmS9L3QdMS1jnppiDiDb00oSDTu4dFnpOj0bQ3rxSN5MdwMB4lrtcchrkEydPdx
         KfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PZJF0C+hyFf1HstSG8qVVlhySOMtz+6M9ZQ3PF9X9Ew=;
        b=SaP5mQUaswIsmg6SGRgDpFiBSip6Tegl/udD9EhJX+Qr1Sw0J74VLvgLHuSXMSmdyd
         X7bZLo1iParoT6QodqSvt1+vZb+uMq5Fu8lErQX17wkCPTKTAfUAYh2xc9dGvPMLhPCd
         fyQ3Eh01SEGim/SWP/swKBZRwEPUkJoR8owIjGSUgMhfRLZklJexdv4IeQq5xQv3CQkf
         YntmYP0zldE55TXIbaDZf3fpbQztxI26hPIo0K0dqA0OGwsAoFeZazywgyR1YGoEu2yj
         vuUsYOxnaqfkWNy6DxkdV81w82GHNakhth7q1+SCI94kZRg1iEqKUKQiDrJ2FFrq1/NJ
         DHyw==
X-Gm-Message-State: AJcUukdeT/TO4t+OT1fqeLWFzOuhhlc65zi9e/cxqD9qw5clGm3mWTqn
        7VFPvj8MlNMoHbSetmCDzz82GSGVaNo=
X-Google-Smtp-Source: ALg8bN5wXeZDCG25oh/WrHddaTNt26L+kaLrahjwZyV87YS0wriRJf0B6oEwaO+KgIdqOCmy1wjb2g==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr16614575wrs.289.1547808745228;
        Fri, 18 Jan 2019 02:52:25 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w18sm75539645wru.54.2019.01.18.02.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:52:24 -0800 (PST)
Subject: Re: [PATCH v2 0/4] soc: amlogic: clk-measure: add axg and g12a
 support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        patchwork-bot+notify@kernel.org, linux-kernel@vger.kernel.org
References: <20190118103423.15075-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <bc1aa147-e08a-5bb2-9a3b-cf3dad3c0235@baylibre.com>
Date:   Fri, 18 Jan 2019 11:52:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118103423.15075-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 11:34, Jerome Brunet wrote:
> This patchset adds support for the axg and g12a SoC family in amlogic's
> clock measure driver and enable it on the related devices
> 
> Changes since v1 [0]:
> * re-order node in the g12a.dtsi
> * change node name
> 
> [0]: https://lkml.kernel.org/r/20190117164838.8008-1-jbrunet@baylibre.com
> 
> Jerome Brunet (4):
>   dt-bindings: amlogic: add new compatible devices to clk_measure
>   soc: amlogic: clk-measure: add axg and g12a support
>   arm64: dts: meson: axg: add clk measure support
>   arm64: dts: meson: g12a: add clk measure support
> 
>  .../bindings/soc/amlogic/clk-measure.txt      |   2 +
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   5 +
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |   5 +
>  drivers/soc/amlogic/meson-clk-measure.c       | 194 ++++++++++++++++++
>  4 files changed, 206 insertions(+)
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
