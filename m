Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53AEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B07214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMvrz+B1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B07214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeIQUoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:44:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37280 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeIQUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:44:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so13533105ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sfaAJVrGXAzuCEX4R9e02evUC6Hk/VSQaSNxmepRk6w=;
        b=aMvrz+B16wbBNv5Wx0N/T6jSuRooIY0H6TdxoXMIZAJA3ibZZBvSK2W8yn3Q/486st
         fUlJgOGHal/p9HrerziHlcfjMp8b/jO3DaR0sxlokuwW0AHT/KPQq7ycPP6JEGZPbTOv
         7Kbm+j5FNCzm4buCeggIJ0R8JjZ1uoj/KPl5PzCPy66JDvY9vtuD3Afzh5mUzIFzjEqZ
         Of+2wE6Jt7iVlXmM+GdU7HgQ3Hpwq63QL0kvdgljIRkqGBo+WuTXRep6CRd08lHBeGNy
         gOsVBijyAisXTR2zl7flUqqPDCTmJsRVG91zyVazaR95dcSloYLnLSKAJ/DXQbyPhcBr
         xCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sfaAJVrGXAzuCEX4R9e02evUC6Hk/VSQaSNxmepRk6w=;
        b=WHQkhxfBQOY0IApdFUace6EYlBZtsPa9uekxJvS1g0Ulwt5eEeJLAEpCBBNaB1CdfV
         KVHKltxlGuHRoiHzYDkxVGvRgTNn0rI6F78h5FT2CrL7Xy48mGN6uDvXUgsVz0vPOSZS
         yuvZhw2GJaoK6pp/YEwY1I9CTZ1Ha3zFnZkFX5/hcWk6zahisW4jUe7hPKhfGvso5q0y
         si2w2TJiIdYTobhjIYXpdzPz+wlZE82wIfdrsYMzt6ZjhCn+/EtyYXBI+Lfe887Af+NJ
         K0RGPt79o87jnVomqqVdV6bRy5TvjVsq2dcRW8ix5gg7qRGMYPt6gO6l1ln2bsVPqkKL
         hV7w==
X-Gm-Message-State: APzg51CO3zvgKGv5r37/rEuPJmXgNwCtAONclwh02ez6mGRE4W3SRF/M
        RRLsWzwAwXeUvK2TorlL+5Y=
X-Google-Smtp-Source: ANB0VdYhhoOWZmKsrN8+niZlqT5HFRGoI2gWIGrh2k2STX5hHrX8CdtDg303tKjZyXIMd008i0sO+Q==
X-Received: by 2002:a2e:9d0c:: with SMTP id t12-v6mr15443337lji.75.1537197384840;
        Mon, 17 Sep 2018 08:16:24 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2886963lji.63.2018.09.17.08.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 08:16:23 -0700 (PDT)
Date:   Mon, 17 Sep 2018 18:16:23 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>,
        linux@yadro.com
Subject: Re: [PATCH v2 0/8] Fix breakage caused by the NTB multi-port patchset
Message-ID: <20180917151622.lnlckvkiyqqxlt4c@alfbook-pro.local>
References: <20180720180034.3964-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720180034.3964-1-logang@deltatee.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 12:00:26PM -0600, Logan Gunthorpe wrote:

> To reiterate the main points on the feedback: the switchtec driver,
> in the cross link mode, will not be able to implement the port number
> function callbacks and will have to always return 0. It's a physical
> impossibility due to the symmetry. Therefore, in order fix this feature
> (which worked when merged), the clients must be changed to support not
> knowing the port number in the way they worked previously (ie. a legacy
> mode where there will only be two ports and you know there will be two
> sets of doorbells, one for each peer). The majority of this patch set
> fixes these issues.
> 
> The other point of controversy is the dma mask. I still strongly
> disagree with doing it in the driver as the code is clearly common
> to all and not at all driver specific. Moreover, I think as written,
> it is extra dangerous seeing all impleminting drivers are operating on
> the new struct device before it's initialized in ntb_register().
> Patch 2 in this series also fixes that.
> 
> [...]
> 
> Logan Gunthorpe (8):
>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>   NTB: Setup the DMA mask globally for all drivers
>   NTB: Fix the default port and peer numbers for legacy drivers
>   NTB: ntb_pingpong: Choose doorbells based on port number
>   NTB: perf: Don't require one more memory window than number of peers
>   NTB: perf: Fix support for hardware that doesn't have port numbers
>   NTB: perf: Fix race condition when run with ntb_test
>   NTB: ntb_test: Fix bug when counting remote files

Tested successfully on i5-based desktop PC, NTB on PM8535 chip, both
ends are on the local system.

Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>

-- 
Regards,
  Alexander
