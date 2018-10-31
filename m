Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B018CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FED20843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNG6OjUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FED20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeJaTzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44890 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaTzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id n19-v6so2235878edq.11;
        Wed, 31 Oct 2018 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ihppaPJoSaqiRruJsvGDzxn2DU71weWvXlHv+GBVdA=;
        b=lNG6OjUdw/nqOQw6e6eTWSnDM15TI+3R5DR/4EdHMu6NacVNyzrrvQZlpQzcy/JtUg
         mdgiYDAvlb0wCp3GKtJCDzawzGYeCmX2Wxbw+ZtzlxziGbYxNHAvLebmRjK+WsjbM2xY
         KX9en94R4r+Ystob1Hc5xR/47cEQdNF9ikHzVE3YGYp/BYmf4MU+LC2qrJqU9/kmt4jH
         TLJR3Cf4+fyieGujNmwS9qXjVqRSkgPJi7pNH+Io6MhE1/OGOvZXyKK2TfJkwESknIKX
         aBNhcwWoTyENB+n7EJeZNXxU8Qy5Uan73tvPktNhYFWoYAynEOdUSgyiJdCcn0RtiJPN
         8clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2ihppaPJoSaqiRruJsvGDzxn2DU71weWvXlHv+GBVdA=;
        b=Sq2/i4/K/MLBpl8ODMGq7dYI/+bJs2bEhBe882svNdYwyK1KoFWzpD6YzsNZF9s0xx
         JcSAPrK+c0+Emn48osBVuTCv7zdIX27GCQKiqluEgEro/JTYlbTt9zuQHLh0uH49jclC
         dwKn9LYPU8UpZVLTCZ3Wlk7jDWZkoX2RxGQNYEt0iJJ8a507ihCDwCRu7Qk5P8OtgxN+
         9ezoLA+OybF2gMGqE5KT7GbJ08Vk0XSYBzPdpK46cFRV6pqxXKsrS5JMKHLY4l7MHSWg
         kwhlX+45g1RRaWqT3JnIF8LcYV+lrVNmDGc1WOkQmYc/O1XkQ2uDfB2ZquOFyTkreR3y
         uQbw==
X-Gm-Message-State: AGRZ1gJOfhaliIbfLWW9bEUN+MLh2FQrHKbvW2iKgEkBKzzpLLIKk2Ol
        fzMf5V9XSeWntXFwixNRCFPCTHIezys=
X-Google-Smtp-Source: AJdET5eJb/dQXHUxWN5umXYwa/PwR4tovvyQyaH5njoaTvFzp/YZLuGqmLz0cN/ID4XzUz8/WdAdcQ==
X-Received: by 2002:a17:906:29d7:: with SMTP id y23-v6mr1220654eje.156.1540983478407;
        Wed, 31 Oct 2018 03:57:58 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:57:57 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/14] Rockchip SPI cleanup and use interrupts
Date:   Wed, 31 Oct 2018 11:56:57 +0100
Message-Id: <20181031105711.19575-1-esmil@mailme.dk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Hi,

I took another look at the rockchip spi driver and ended up
with more cleanups and implementing an interrupt handler
to fill/empty the tx and rx fifos rather than busy-looping.

I have two question though:

The driver sets the SPI_LOOP flag in master->mode_bits,
but never checks if the flag is set on an spi device.
That looks suspicious to me, but I'm not exactly sure what
that flag means, so it might be ok?

The driver registers a master->max_transfer_size function
to always return 0xffff, but also checks each transfer
for xfer->len > 0xffff.
I thought that was redundant, but it turns out I can
trigger it with a simple
dd if=/dev/mtd0 of=/dev/null bs=[something > 0xffff]
Is that a bug or have I just not understood what
master->max_transfer_size is supposed to do?

/Emil

Emil Renner Berthing (14):
  spi: rockchip: make spi_enable_chip take bool
  spi: rockchip: use designated init for dma config
  spi: rockchip: always use SPI mode
  spi: rockchip: use atomic_t state
  spi: rockchip: disable spi on error
  spi: rockchip: read transfer info directly
  spi: rockchip: don't store dma channels twice
  spi: rockchip: remove master pointer from dev data
  spi: rockchip: simplify use_dma logic
  spi: rockchip: set min/max speed
  spi: rockchip: precompute rx sample delay
  spi: rockchip: use irq rather than polling
  spi: rockchip: support 4bit words
  spi: rockchip: support lsb-first mode

 drivers/spi/spi-rockchip.c | 579 +++++++++++++++++--------------------
 1 file changed, 264 insertions(+), 315 deletions(-)

-- 
2.19.1

