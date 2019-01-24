Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636B0C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310F7217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY5cZBH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfAXUTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:19:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39420 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfAXUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:19:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so8215212qtj.6;
        Thu, 24 Jan 2019 12:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=Rmdy4UB1A1AkwjRj+cp+mngH8gJX7VX65HqaiNctPo4=;
        b=EY5cZBH3W2jSAkyTiOZiofBWJdccVmNcwYPnX1bTFx3FrEUBl2CSsEtJHI7p+NFxXV
         kaqpFMUVzNlYAggionA+U8V5/BMIidQ+TAbdyGq8StD42zNb+7WRHCXJmYR6EjkU6Wtd
         UHkdnBG8g4doBk+g3B3CDSeScab8njLEMpjeml96kf8mlqdGMigXz0E47k1NSJiQ4BQ+
         XBgd9GoSrcocShIPd8nKJXxWdooKF9aTctqtvNkXh8dw0WGhtzlkLdKhlrOPMuu4Q6w4
         Q8FWY15BdJPpnMc0WCzwo/8PiGgOHYecnlE3ZXVE40fibGJYCRNYZQvU6KHolmeCxs8N
         M6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Rmdy4UB1A1AkwjRj+cp+mngH8gJX7VX65HqaiNctPo4=;
        b=kSzDBFYOFjUJYNaZ3xbl09OIBt1/FalCt8qCjQWrrglfusvNqJgNqz8XU6N1Qbk5gG
         t8RQl9Eo2JeEXahZFVvuDoBODZ2q/ISOK+7Sd/l8/XgHXZp3g7UGJrQHVvRwF5RCAwLG
         dnAXcAunR/0BFSVCI1GciHZhqHP4pgbiK6otWiKdhbtd35b8dJ8wZQxJE1WGzziYTvZu
         uFmTPdpf3yhgox0J29SD+NaZjAYb1cilNvInvHaIIeeNYu9dp3+XgLWRD6/EmFw1LtgC
         a40nXv9Tv1dBFAN+rMedupOCIjetSHZNHSj0L953C31DI7MkbEP5bvhiM98SWezbABRZ
         DwIw==
X-Gm-Message-State: AJcUukflgD5ArpnIxWN1KcRk6jmiR1uYcBezeNgypvZA1487GSz19qde
        /W53CsvU31zc6w5RmNMLyXE=
X-Google-Smtp-Source: ALg8bN4ddfgelWLPg/UxCXywxmHmTcNvGLdRFOij+5NECZX84QfoeA34E5UVv70R6Q4o5vrA0YyiiQ==
X-Received: by 2002:ac8:16d8:: with SMTP id y24mr8341485qtk.253.1548361148456;
        Thu, 24 Jan 2019 12:19:08 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id m20sm51206084qkk.66.2019.01.24.12.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:19:07 -0800 (PST)
Date:   Thu, 24 Jan 2019 15:19:06 -0500
Message-ID: <20190124151906.GB31994@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] of: Make of_node_name_eq() case insensitive
In-Reply-To: <20190124200825.2611-1-f.fainelli@gmail.com>
References: <20190124200825.2611-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Jan 2019 12:08:25 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
> comparisons") Vivien reported the mc13892-regulator complaining about
> not being able to find regulators.
> 
> This is because prior to that commit we used of_node_cmp() to compare
> the regulator array passed from mc13892_regulators down to
> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
> lowercase in the DTS.
> 
> Fix this by use strncasecmp() since that makes sure the comparison is
> case insensitive like what of_node_cmp() did.
> 
> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
 
This fixes the boot on i.MX51 ZII RDU1, which was printing this:

    [    2.895302] imx-ipuv3 40000000.ipu: IPUv3EX probed
    [    2.903869] spi_imx 70010000.spi: dma setup error -19, use pio
    [    2.911943] mc13xxx spi0.0: mc13892: rev: 2.4, fin: 2, fab: 0, icid: 7/2
    [    2.921463] mc13892-regulator mc13892-regulator: Unknown regulator: sw1
    [    2.928207] mc13892-regulator mc13892-regulator: Unknown regulator: sw2
    [    2.934896] mc13892-regulator mc13892-regulator: Unknown regulator: sw3
    [    2.941575] mc13892-regulator mc13892-regulator: Unknown regulator: sw4
    [    2.948263] mc13892-regulator mc13892-regulator: Unknown regulator: vpll
    [    2.955050] mc13892-regulator mc13892-regulator: Unknown regulator: vdig
    [    2.961820] mc13892-regulator mc13892-regulator: Unknown regulator: vsd
    [    2.968464] mc13892-regulator mc13892-regulator: Unknown regulator: vusb
    [    2.975251] mc13892-regulator mc13892-regulator: Unknown regulator: vusb2
    [    2.982110] mc13892-regulator mc13892-regulator: Unknown regulator: vvideo
    [    2.989039] mc13892-regulator mc13892-regulator: Unknown regulator: vaudio
    [    2.995983] mc13892-regulator mc13892-regulator: Unknown regulator: vcam
    [    3.002754] mc13892-regulator mc13892-regulator: Unknown regulator: vgen1
    [    3.009597] mc13892-regulator mc13892-regulator: Unknown regulator: vgen2
    [    3.016458] mc13892-regulator mc13892-regulator: Unknown regulator: vgen3

before looping forever on the defered probe of the Marvell switch.

Tested-by: Vivien Didelot <vivien.didelot@gmail.com>


Thanks,

	Vivien
