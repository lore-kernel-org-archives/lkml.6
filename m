Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2FFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3557D20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftbf+bg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3557D20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeKAAxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:53:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38263 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeKAAw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:52:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so7823060pfi.5;
        Wed, 31 Oct 2018 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0m2bCnfc3Hx5A6TqlQQS1VxnmjoIkF3lh6xONpj9bBQ=;
        b=Ftbf+bg3mwRiI1kj4AxGqj+qZAkQPs+BoZCymhHCGCftNySf6/KXY6yZRaAv5rqJEC
         N/1EY3AO7kTmcTAu/vd6l/2M8xmnMzVm1wbYAHITCUjKXdXtSRc2KNva5VfTA1umIF+R
         puGbaH7ekb+9GWerwn3W5/ZUbE/syLcqYbi3s9skwYvYHNx59WcDlgMSKUt7NoBU+yh1
         5NLn2HFuYPTiHlz+ba2G17/55qVxcyh8CU83p0ipIHNFuBHx+nnBSTNV+8lRiQjck6F1
         iNOyHbRyupUe/8OB0YRX6dowumCBcjRBKTNA8y7OjIh6ZUISryXZ7RGyC4MgSTQ+PsK3
         Xakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0m2bCnfc3Hx5A6TqlQQS1VxnmjoIkF3lh6xONpj9bBQ=;
        b=hRgaGVNZBQuzeKY/1ZRRZa6kjEg0mSOClJ7bUGkzNFr2SgW+LGlFNGT8Jy8cb8tDmU
         bRFSuP9Lj+VsV/cI354n+c3EEzF4YMXnZEiz7UazDG+uwr05GPK8M9iCLQvTQIniZZTT
         2GfyB9hhI9EtiqMq0Pu0mpuzimk/jjwCgOWs2p5s9q7Md+r7MTdNRo+OqGcTII10eFhF
         KwxfJGH9J3bEOQys8V3hCH+FzRMKYbyXZNsbF+Z16CUcbjvqopVMm1/MTD6k6OvjB72E
         84Z0b6CDasDn4/EjamxO7JNGFIIx6VZaODVWikUYgyUhfdQr2Ki8Fb6Ld892ht+b0lsI
         9ThQ==
X-Gm-Message-State: AGRZ1gJCVF2lI+1alD5amJdXtIrBoFwOW1B2M/f+OWS/7rF1d340TkK0
        C3au51scGKhkBdmmyqSGGlM=
X-Google-Smtp-Source: AJdET5cu6DPduIdOyhlvZMNclFP2FjaHvXAfB8cCmqVc4mk5G6oxhk2rer/nzirjn/DtPyzrRUzxGw==
X-Received: by 2002:a62:6c49:: with SMTP id h70-v6mr4138647pfc.134.1541001264589;
        Wed, 31 Oct 2018 08:54:24 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id w2-v6sm25930929pfw.26.2018.10.31.08.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:54:24 -0700 (PDT)
Date:   Wed, 31 Oct 2018 21:24:16 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface.
Message-ID: <cover.1541000375.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor

Changes in v7:
 - Adds a level of indirection to read and write
   the gpio_desc to make the code simpler.
 - Drop gpioin flag which decides how the GPIOs
   are controlled as the GPIOs must be outputs
   for the host as per the datasheet.
Changes in v6:
 - Split device tree table addition and device tree support 
   addition in two patches.
 - Replace platform data with device tree support.
 - Rename boolean property.
Changes in v5:
 - Add device tree support.
 - Add device tree table for matching vendor ID.
 - Add Support for retrieving platform data from device tree.
Changes in v4:
 - Add spaces after { and before } in gpios[]
   initialization.
 - Check the correct pointer for error.
 - Align the dev_err msg to existing format in the code.
Changes in v3:
 - Use a pointer to pointer for gpio_desc in
   struct ad2s1210_gpio as it will be used to
   modify a pointer.
 - Use dot notation to initialize the structure.
 - Use a pointer variable to avoid writing gpios[i].
Changes in v2:
 - Use the spi_device struct embedded in st instead
   of passing it as an argument to ad2s1210_setup_gpios().
 - Use an array of structs to reduce redundant code in
   in ad2s1210_setup_gpios().
 - Remove ad2s1210_free_gpios() as devm API is being used.

Nishad Kamdar (3):
  staging: iio: ad2s1210: Switch to the gpio descriptor interface
  staging: iio: ad2s1210: Drop the gpioin flag.
  staging: iio: ad2s1210: Add device tree table.

 drivers/staging/iio/resolver/ad2s1210.c | 132 +++++++++++-------------
 drivers/staging/iio/resolver/ad2s1210.h |  20 ----
 2 files changed, 62 insertions(+), 90 deletions(-)

-- 
2.17.1

