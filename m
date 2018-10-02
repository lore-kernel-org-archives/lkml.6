Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C38AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BD62082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U66h/K69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BD62082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeJBVWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:22:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39352 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:22:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so1750183plp.6;
        Tue, 02 Oct 2018 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ARI4ZM9WZRepuJjj7nZlQQuLUxwLqPvXpV5DinEDa10=;
        b=U66h/K69t1FjJDXk3wWWHBtPfPn/GWZxzT39sfqmDtALOq77juuanrLnmkEOZL/spG
         tOxywb47QTMqn6lD0nBfFXDaPXVsMEQf0Uyl20vcjQZFAGGGRhB6S1g+SBBtQpln5/Py
         EIkGZZ7SFZgu0ZbArn6Mla48q3AFDZDj4UovWMdhMtIhvhrZS++3axUxmnMCkGx5MN9J
         QHEsxbBZdTAHg6OgeEo7Z0djJj7CAnsRRzg1RoDSbkRa6YSvm5wmq6or/iLNPSxoN+g6
         oRkgLSmo3XjvZnHl+ViL1LiCCS8qlfwhEPZojKNeiBqunS+X5U47fK9CLBLT6QXMu/vR
         RJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ARI4ZM9WZRepuJjj7nZlQQuLUxwLqPvXpV5DinEDa10=;
        b=SgdgoKP/nQD6+zFUvA/5D1E/cRhdBPPrexKf4OgRarp2WeN3kMlK/7OOiXoKrarpuE
         OzvapGNTgAriyFBYBQfa7TxLtDXnMaorf0fEf4BrKsIqWI8H5Xg1Q2VoLZlDHZvzxIyl
         TKbawvPsJ53D0xwK9yvXboXShAAmtKAalgK0TG07/lsomuolWNYMajnLSPy6p8hxeF39
         yOw5ZvA5cwPNoVogKlTrsLjCcblLbR65udrp45hZp53pon1x+WxXiTwkusm9llXfcOO/
         KWLRT9vBZQ082+/Ht/9xsbCWHXwP+9ciaFVLMv9gyHYTH2FZFIlNwu18C0PEcGvyclsi
         8Unw==
X-Gm-Message-State: ABuFfoh00DkYOdev4HpEfYbZq+04zhaif4oIo3mPXgTaW3wKtT8Lo8b5
        4/K6WjeadvIvx2x7owsftts=
X-Google-Smtp-Source: ACcGV60GfVVD4uleegvfFLfxPWilmzvFltqjVmwHNOszjTlwRv+qNaPsX70/gjZWaoGNimrbNWNG5w==
X-Received: by 2002:a17:902:b78c:: with SMTP id e12-v6mr17075479pls.67.1538491098783;
        Tue, 02 Oct 2018 07:38:18 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id u184-v6sm32146276pgd.27.2018.10.02.07.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 07:38:18 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v3 0/3] Add  support for PNI RM3100 magnetometer
Date:   Tue,  2 Oct 2018 22:38:09 +0800
Message-Id: <20181002143812.3661-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925031724.21399-1-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The next 3 patches do the following:
 - The first patch adds PNI Sensor Corporation to the vendor prefix list.
 - The second patch adds devicetree binding for RM3100 magnetometer.
 - The third patch adds the driver for RM3100 magnetometer.

 -- Song Qiang

Changes in v3:
 - Change PNI to PNI Sensor Corporation in vendor-prefix.txt.
 - Sort header files in alpabetical order.
 - Add more specific doc for the mutex.
 - Fix the bug in the rm3100_set_cycle_count() where we always set the
   cycle count value to 100 no matter what val is.
 - Change some multiple else if to switch.
 - Remove iio_device_release_direct_mode() in the case claim direct mode
   fails.
 - Use the same buffer in rm3100_trigger_handler().
 - Add space around some operators.
 - Add manually unwind functions in case devm_add_action() fails.
 - Move devm_add_action before the devm_iio_device_register().
 - Move register defines and rm3100_data struct to *-core.c. 
 - Change some storage variable type of regmap from int to unsigned int.
 - Change 10e4 to 10^4.
 - Remove explicit cast of data pointer in rm3100_remove().
 - Remve dev in rm3100_data and use regmap_get_device() to obtain device
   pointer instead.
 - Change register bits alignment in defines.
 - Move RM3100_SCAN_BYTES to the top.
 - Change Channel endieness from LE to BE.
 - Adjust the place of comment about the 3 second wait time.
 - Some spell check.

Changes in v2:
	- Add scale channel.
	- Add EXPORT_SYMBOL_GPL() to export regmap confuguration structures.
	- Add sampling frequency available attribute.
	- Clean up headers and License declarations.
	- Change axis number to 3.
	- Remove bus specific part in compatible string.
	- Remove le32_to_cpu().
	- Check cycle count registers at *_probe().
	- Format comments.
	- Spell check.
	- Change prefix from RM_* to RM3100_*.
	- Check all error return paths.
	- Add devm_add_action() to avoid race condition when remove.

Song Qiang (3):
  dt-bindings: Add PNI to the vendor prefixes.
  dt-bindings: Add PNI RM3100 device tree binding.
  iio: magnetometer: Add driver support for PNI RM3100

 .../bindings/iio/magnetometer/pni,rm3100.txt  |  20 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  29 +
 drivers/iio/magnetometer/Makefile             |   4 +
 drivers/iio/magnetometer/rm3100-core.c        | 539 ++++++++++++++++++
 drivers/iio/magnetometer/rm3100-i2c.c         |  58 ++
 drivers/iio/magnetometer/rm3100-spi.c         |  64 +++
 drivers/iio/magnetometer/rm3100.h             |  17 +
 9 files changed, 739 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 create mode 100644 drivers/iio/magnetometer/rm3100-core.c
 create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
 create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
 create mode 100644 drivers/iio/magnetometer/rm3100.h

-- 
2.17.1

