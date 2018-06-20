Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594E0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111EC20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0eq56GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111EC20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754492AbeFTJqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:46:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36592 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeFTI0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:26:12 -0400
Received: by mail-lf0-f65.google.com with SMTP id n24-v6so3637174lfh.3;
        Wed, 20 Jun 2018 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVu3r8gm5HUo3zC5zlWyoHyblJAa32dQ2XhhpiE9R0k=;
        b=N0eq56GHv42bO3Lam9yNjDI3Dl4Yx/XG5YpvY9ULDmjpmjW+VqlVSzd/OGM2JKpfzG
         OpXfulmvZHkpG4KyXof/YAJGcazjd3hA240xMzPg6BdOuEXjt2Z4txKWdS5tRkCasfLp
         iqNxMsS61yVgTEc08cZofFzmICen2kHA44OXryvzQMwK9VHvQVlPy9gvIDDkiusynVjg
         Q8Qq6juMy0IAFAQwTlCVnaztqQpEQofs/7iMdBzIVVTZYJ/fBO58kuJon+30NtFYedhy
         TwPhdYoCIPjqLQPhuxOCp/mm7XfIsvzEdrDLKtqrr1o53EjrlY4vHp6MtnjlWJuYjACl
         hdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KVu3r8gm5HUo3zC5zlWyoHyblJAa32dQ2XhhpiE9R0k=;
        b=n+0F4A3+wn3KfD96Hz0mxYSXkCLFiORhiZdTNbygjAS16c7ux63oRobKpgltuxHIXA
         tNZdrRdzTsaLW4QaROK25glSw2Ei0lWMOKFiWeJ6jGUtOsRopBwb0QDZS52YBJ/rjNEs
         2DzJSpEIMl7z66d3tbZla1JyLl4tH8fz9P4b3S7I8uAruP95bmzZYY5h6+wEP8SHd1Lj
         yshSNe+j3mmmJ0yQvI76MsgSKdHmsEozxopivKOzroTNLQN1ZrD1/oOmXMQSyyru9/ec
         E9Pd1Vrs5JPP5o1x7BsA/V2gCkqBhM1V4H2bG5pmf+PVSu3K07GIbeqT3hmLSwKHetMI
         5uwA==
X-Gm-Message-State: APt69E02FIwxz9CoeqOGVA5KHI6VQqdoUHFJ+4sRNMgmurMVrCXSHmsY
        qC+wROIQpHuZHYK13Ywf+KAvD+gM
X-Google-Smtp-Source: ADUXVKKoKv+6zd/z17I5W7F6ls6bHeVgP8AWA/ntnigQoburXDX8lXbeO3wWIHqdzeVFC2N2nR1V9A==
X-Received: by 2002:a19:4a53:: with SMTP id x80-v6mr8132966lfa.69.1529480085137;
        Wed, 20 Jun 2018 00:34:45 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id l16-v6sm274494lji.40.2018.06.20.00.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:34:44 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>
Subject: [PATCH 00/12] XSPI mode for LS1021A DSPI
Date:   Wed, 20 Jun 2018 09:34:30 +0200
Message-Id: <20180620073442.20913-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This patch series contains a number of fixes and cleanups for the spi-fsl-dspi
driver (commit 1-7), and on top of that, implementation of XSPI mode for
LS1021A allowing for SPI transfers larger than 16 bits (commit 8-12).

User visible changes (improvements) are:

* Support for all transfer sizes between 4 and 16, not just 4 (which I believe
  were broken anyway), 8 and 16 bits per word.  

* Full support for transfer->cs_change flag.  Setting cs_change in last
  transfer leaves CS asserted.

* Support for all transfers sizes between 4 and 32 bits per word for LS1021A.

The XSPI mode can be trivially enabled for other target using TCQF mode.
Enable for targets using EOQ mode requires additional work due to the split
of TX FIFO into command and data FIFO.

If you like, I will happily squash the last 5 commits into a single XSPI mode
commit.

Esben Haabendal (12):
  spi: spi-fsl-dspi: Drop unreachable else if statement
  spi: spi-fsl-dspi: Drop unneeded use of dataflags bits
  spi: spi-fsl-dspi: Fix per transfer cs_change handling
  spi: spi-fsl-dspi: Simplify transfer counter handling
  spi: spi-fsl-dspi: Support 4 to 16 bits per word transfers
  spi: spi-fsl-dspi: Fixup regmap configuration
  spi: spi-fsl-dspi: Fix MCR register handling
  spi: spi-fsl-dspi: Add support for XSPI mode registers
  spi: spi-fsl-dspi: Framesize control for XSPI mode
  spi: spi-fsl-dspi: XSPI FIFO handling (in TCFQ mode)
  spi: spi-fsl-dspi: Advertise 32 bit for XSPI mode
  spi: spi-fsl-dspi: Enable extended SPI mode

 drivers/spi/spi-fsl-dspi.c | 458 ++++++++++++++++++++-----------------
 1 file changed, 250 insertions(+), 208 deletions(-)

-- 
2.17.1

