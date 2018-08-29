Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B69C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D582064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GONOMEZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D582064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeH2WEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:04:05 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42796 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeH2WEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:04:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so4643475oib.9;
        Wed, 29 Aug 2018 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:from:date:message-id:subject:to:cc;
        bh=ucMsBF9spkBK8Uh0j9ZI/488YeUHAVi5v/L/w0gtNKc=;
        b=GONOMEZwySeQOI3L/5c12fmU9hoWX17SiZ5bXxzvY0eMai88TZZaLKNFzt3dwFiqy2
         eayuLp1qxUzJBgYvwuJsFxV3zaHnDPS+XfWvUMDDHqvbXKSY4/lQLtEqgfLT+ocPyBoP
         ryjkXTNhs85di/EJN0eD4OkOuFKPi2dBOARsRX9qOzCrYb8ua00oTN5GV6Pyki6KHlA+
         YU7IORT9NjLfQakkSgLPSGCg3Sw58fbhLSAr8PB/FlQ5R3dgSSGqkg5LpdD2MSTPlFob
         sP8bUqL9xjz1tIXNOd52PAvtJlOS0yqXs48Vy8SpUX/d/SO4GLRalFyU2LBpBnsLmO/L
         lSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:from:date:message-id
         :subject:to:cc;
        bh=ucMsBF9spkBK8Uh0j9ZI/488YeUHAVi5v/L/w0gtNKc=;
        b=cFBKN0gDj2XyM9yyjVJomQDMJw7dS4JdRd2qDD367IFa3+iR5kbeVmbSWyJrrakwNR
         uTcVm7dLgaHNlsgxIPFEjJrey4VOVeE4VdFPbbgBMHnIaeGWWA1IbTi5Q3ojlBznna5h
         3hMLgtYloylDHioEyACsRaRZYgoOyBAjCDmCM+/ZM6dG4bV9oEYQZYMq4VT/Rfzwx12S
         RJM8rzDJDvT6qgI+E5C/rzq8eMWjSTp44CPZUCeY9qwTvsoNycUeGSB+DGjKE2caoMw1
         cXGvbWuuJA2S+rwkkp5r9tOr0GzAr9zFJGwqmc56vETyT+kZ10cT5kUj+Cj0mvi6tp1J
         wklQ==
X-Gm-Message-State: APzg51Av4GGd1uE8ujjZ1X8xTY062NdZQL1OOSWkxWE8LvTpxf8GO81G
        MOuqywVlNzsdsjo8LgDBD3+5SuKTaImL5bdSmY9Omg==
X-Google-Smtp-Source: ANB0VdZsESLRIFOwuKoRDW/0yRRnCvOduumkigI4k3EkJ11xS8ECOpQzbQXVYAT6zucsVmOdkflmcArC/4MjAYCOh/8=
X-Received: by 2002:aca:d706:: with SMTP id o6-v6mr4001069oig.45.1535565961701;
 Wed, 29 Aug 2018 11:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180824090440.13411-1-jbrunet@baylibre.com> <d3858ef0-97c7-28b5-db4a-4ac71af52ba5@synopsys.com>
 <CAFBinCA+Q6vLzutdMLOgeTDg5GBkqvp3YzBQiUd_y-qyiz=dsQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 29 Aug 2018 20:05:50 +0200
Message-ID: <CAFBinCDZ3t-_-+Erfm_ubTjKkHpfQ1zWsLg=Ad7rwBHuiGm_xg@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: stmmac: Do not keep rearming the coalesce
 timer in stmmac_xmit"
To:     Jose.Abreu@synopsys.com
Cc:     jbrunet@baylibre.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, Joao.Pinto@synopsys.com,
        clabbe@baylibre.com, linux-kernel@vger.kernel.org,
        Vitor.Soares@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 8:03 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
[snip]
> from that point on:
> # dmesg | tail -n 4
> [   47.782778] RTL8211F Gigabit Ethernet 0.2009087f:00: attached PHY driver [RTL8211F Gigabit Ethernet] (mii_bus:phy_addr=0.2009087f:00, irq=30)
> [   47.803540] meson8b-dwmac c9410000.ethernet eth0: No Safety Features support found
> [   47.805505] meson8b-dwmac c9410000.ethernet eth0: PTP not supported by HW
> [   50.311975] meson8b-dwmac c9410000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
I forgot to mention: after traffic doesn't flow anymore there are no
additional messages in the kernel log
thus the output of "dmesg | tail -n 4" is identical before and after
the test run


Regards
Martin
