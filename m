Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23BC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F292150B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUiF25Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F292150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJIUzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:55:40 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:52167 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJIUzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:55:39 -0400
Received: by mail-it1-f175.google.com with SMTP id 74-v6so2627898itw.1;
        Tue, 09 Oct 2018 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4lZNUpH62YJI8adavLqkWiqQfSwj52oDbhrGCNA1+HA=;
        b=WUiF25PvHxwFFbdOQ7zklx6+HEsIFUUt5SZ3d2EdLTcJIAZPbFFVf6taCPYnRwEI+N
         QO8DY5+dfgFRG2hhj1XQnycZumvV3cr7xbYD2aOq4aJBMnj8hb/u1bGofn17HL1Ceq2L
         XOcwFbaDCP+mEKy21qxbRuWvPb/5z+eRTAKCjbaoIcfgorX/sgNt62rnDSqsFjfzJUok
         veAmrBxoKlgMVQx+ws3yZ/e04iFqLMK5CgbMMQ4Z3s0IBM3MSvR6aVdlu1t848sdc1jG
         TIPzvGMXAvC/MoVM5U1qyAK5VOpCqc8LpVqfazZqNMfkDcgbvLmAjeYTlUNchXYl9feQ
         Io8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4lZNUpH62YJI8adavLqkWiqQfSwj52oDbhrGCNA1+HA=;
        b=Y04M/NZHMD8usplEX2Xh1Z1hApItKD5C4RKo7OVzxqMbFf9exLqtUcUNQjnUVf/oJf
         hWqymXQ6GQY/0y8hrXs+Q+1RK9AN+K0+8HNJAgvczWQSPlx05o9dUDZkEDyGWKJHCB5z
         AWolWD62QVHcg6Squ2Htv/I06UGGKWA6Sq6fj8TGxuINKo33kBM9SXljUs21FbsTYg/A
         bhzQ0wpHv+vRP8h9zwlX8G55zw2JQ4QywYMfpHix1MEAHAodReZ2TFl8YPj0XoJBCZ90
         WAK3NQCJMqhKFAHDWk1LW7/XXzRvtO8mlGxlSjGs/1BHm/XcPmNO0EijJ1GMabZSKh8x
         NPPA==
X-Gm-Message-State: ABuFfoj1Qa+aN3VDkDG+vF7vgYgQuZdp6KUhktLya2H/nZ8XT8rev987
        g3d0GOq9NUi2x65qP75sAok/fp51P0rxooDbYrCWYHKPo5g=
X-Google-Smtp-Source: ACcGV62LFzi4TihMj1BITz23E8L8cr/6hrisD6YqoN8NcKxTxUFjX4WfF99BbuOpuBhvXWkbG1xT4iAGzV72WJGHQQg=
X-Received: by 2002:a24:cac6:: with SMTP id k189-v6mr1455040itg.168.1539092319148;
 Tue, 09 Oct 2018 06:38:39 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 9 Oct 2018 08:38:27 -0500
Message-ID: <CAHCN7xJnqbzyx=wFw4XY+NWRP_Y4RTVjeeyU3wSAsGtSUyG9Bw@mail.gmail.com>
Subject: Pinmuxing and SDHC speeds on sdhci-esdhc-imx
To:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aisheng.dong@nxp.com, haibo.chen@freescale.com,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question regarding the pinstate and the corresponding uhs_signaling.

The uhs_signaling shows a variety of timing options,

 MMC_TIMING_UHS_SDR12,  MMC_TIMING_UHS_SDR25:,  MMC_TIMING_UHS_SDR50,
MMC_TIMING_UHS_SDR104,  MMC_TIMING_MMC_HS200,  MMC_TIMING_UHS_DDR50,
MMC_TIMING_MMC_DDR52,  MMC_TIMING_MMC_HS400, and MMC_TIMING_LEGACY

However the esdhc_change_pinstate function only lists
MMC_TIMING_UHS_SDR50, MMC_TIMING_UHS_DDR50, MMC_TIMING_UHS_SDR104,
MMC_TIMING_MMC_HS200, and MMC_TIMING_MMC_HS40, and a defaut.

From what I can tell, this means that  MMC_TIMING_MMC_DDR52 uses the
default pinmux.  I am wondering if it should use pins_100mhz.  We have
an eMMC part that we want to operate at this point and it seems like
it missing.  If so, I can submit a patch.

It also seems like that SDR12, SDR25 use the default.  I assume this is OK.

adam
