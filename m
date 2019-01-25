Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F57C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817DB218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="N1hlQ2v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfAYMYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:24:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41609 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYMYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:24:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so8192123ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ap3WJXi6N0MaUhuDdAWlD/0LwseVhRF0+wzqnXt9JsE=;
        b=N1hlQ2v3e4qJwOnJHt23ThoGYV8GnbwHxZVK4gq79hzmgA3FdvRV1qUg6kP7IXIj/H
         yWYTy8gdP7KKCzStohbrRWeXyccgm4JGDx6umLx8B+gRYM4Cz78qYyrDkxs+SRxs7ZXZ
         OPT36udNGMVHIRD4YCxhVVYWIYkBN00dpNo3jVP9d/g8cy0mi9e3lzT6KjvXpGznJaxM
         7/KjQTqlnrTrZa6cx3odHOeBOVeEIxYvVxISx6jGNhnieBcEfFLZ02jIpuLalHxy7SkQ
         PYzyZLI32Br0ZiBQwSFppKEzasPagMd9gNbDiAoEDChueGQZaxpoBxRa084lksWHOOZ0
         E5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ap3WJXi6N0MaUhuDdAWlD/0LwseVhRF0+wzqnXt9JsE=;
        b=SIBPm/SPKDdahODku3gZLconwUNDIiy53Dcb5JCoPFdJ+Apyl1MUifBfb1ItKLFtcx
         uLYOvCjCvzsTsM6mE7chUObi19g9dJoahrFsq09FSDscWegTWakhkzNGIUyyLNVqALad
         7v4oStT+2cj9X7dP4B5tij6nkBqNkWld+NHOvQ2yFn3zC2vnoxwsTNpAwkh0hR4CWlfG
         NMGPAz0BPMcyObqANPZsrGV0a5TZvs/CxDYVrgjwNCENyQvDWcucbNOqjXwpHC/frhGu
         q3mflctChgkcsdK5WHzfG/mSELU9u3O+QNHlUCYPs3fRtCV0UDnnXfdPD583wCUot0ve
         cu3Q==
X-Gm-Message-State: AJcUukfNLSs+7DZYKUo8qYuPGw8wdZrmGtXmndWQWcl1DGi40vRIyJUI
        a+Oa8Vth0mfuTtA4hMh1XNriqat6Tkc=
X-Google-Smtp-Source: ALg8bN5rESJROxSMX8inCJCYWAaFNqMf/7krSjLH9H5SEiINriqiT9Xt2kqKPJLAFbNLzLGBbrexwA==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr9597207ljk.55.1548419068337;
        Fri, 25 Jan 2019 04:24:28 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id y81-v6sm1508376lje.30.2019.01.25.04.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:24:27 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 0/2] spi: support inter-word delays
Date:   Fri, 25 Jan 2019 13:24:23 +0100
Message-Id: <20190125122425.30676-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmission to fix thinko in spi-atmel patch.

Changed in v2:
* Fix atmel-spi driver to not unconditionally set minimal delay if no
  delay is required (erroneous clamping)

This short series adds support for SPI inter-word delays and configures
the spi-atmel driver to honour the setting.

Some SPI slaves are so slow that they are unable to keep up even at the
SPI controller's lowest available clock frequency.  I have such a
configuration where an AVR-based SPI slave is unable to feed the SPI bus
fast enough even the SPI master runs at the lowest possible clock speed.

Jonas Bonn (2):
  spi: support inter-word delay requirement for devices
  spi-atmel: support inter-word delay

 .../devicetree/bindings/spi/spi-bus.txt        |  1 +
 drivers/spi/spi-atmel.c                        | 18 +++++++++++++-----
 drivers/spi/spi.c                              |  4 ++++
 include/linux/spi/spi.h                        |  1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.19.1

