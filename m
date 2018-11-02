Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4372081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMBQon73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4372081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeKBQse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:48:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46530 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:48:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id c13-v6so603061plz.13;
        Fri, 02 Nov 2018 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5eogydV58NedhRyYMqn6t3mbksyfO0fBbOJOytYjtjw=;
        b=kMBQon73n72JCi1Wt2pmIs/zxNV9NYH29UiCMnUgCpUyM9fIzy8PLFqBt/KpiggVPi
         A6UQ5vXXQAnbnF5acBckvNCU6QOBhuVuzK65h4k6AThsZq1I6IveTiCVplSDT2F6EGVe
         IN1W8OiXmCGTd1yE4EzBJKJQTex070pn0E4/lSq1TAuT1OMEagsAiaMTtuOttJikeYCD
         +3voPBGCNAv3ZlI9pkBImtVdbL3SQe7KOtlfUjl2dYLTf04/s27Emakh7BOpzR/w2ljc
         +dsXvdwBdAie/osQIx9HUxCS3xNILes8BiuRE8sl7gNd6tR3KI3tGYidAtwXg7sVO7eb
         QPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5eogydV58NedhRyYMqn6t3mbksyfO0fBbOJOytYjtjw=;
        b=cSlegeUS5N8B5Ck4HouUs8iKkRQnGEP/i51jfoSFTeqbc7LNDC1SMMGF2y2U+fkR+4
         ttzO+jppmHCE0PUO0w7A21jy3cnYkL43cdOrykXF9VMBa6MSuFclx/p7rPoKuWyhLqA+
         kQf/SFbXzRowPH+DcZFeOYmaPNN99fQjbrYfVlw6AUqYrXLMIrGj8VOscYK9bL4gE5t0
         CKJjUWaRvaR8HjiOHMCEHTJtngzsqDZN0DPGjqTVabe2c764sZgDmlbQLFVet+DWtIR8
         Zm1EEJkUpCoEo3b4cgYzJKhH/YqqNtw4RKuyn3KkZ4K41alXHgVEsYZi/mUhbYDvXlr1
         vOQg==
X-Gm-Message-State: AGRZ1gIFd96FSpv0+0Czwb19hOE8K4FYGLj4SBPZfY7he7QrjDOt/qry
        YA8Vxd46x1Cz44EuLNas6Qw=
X-Google-Smtp-Source: AJdET5eVCCm/1LAP32ZIv0RvyF/vWjpKRHVFHCzcFpf+fvq6KPhBEjtcakgHwwXu4N1uuTJwWQ8PKQ==
X-Received: by 2002:a17:902:b83:: with SMTP id 3-v6mr11057513plr.202.1541144539684;
        Fri, 02 Nov 2018 00:42:19 -0700 (PDT)
Received: from localhost (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id s2-v6sm78684959pfk.133.2018.11.02.00.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 00:42:18 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v5 0/3] Add support for PNI RM3100 magnetometer
Date:   Fri,  2 Nov 2018 15:42:06 +0800
Message-Id: <20181102074209.12620-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Changes in v5:
 - Fix a bug about checking if completion is timed out. Used to check if ret < 0.
 - Add INDIO_BUFFER_TRIGGERED to indio_dev->modes.
 - Add init mode 'INDIO_DIRECT_MODE'. 
 - Remove case 0 in trigger handler.
 - store scale value directly instead of store cycle_count_index and search for scale value.
 - Fix the bug of restarting all channels in rm3100_set_sample_freq.
 - Replace 4 in rm3100_buffer_preenable with define 'RM3100_CMM_AXIS_SHIFT'
 - Replace timestamp of trigger_hanlder to use iio_pollfunc_store_time.
 - Remove rm3100_remove.
 - Replace 3 seconds timeout time with double conversions time.
 - Read all 3 axis in case BIT(0) | BIT(2) instead of reading each of them independantly.
 - Remove i2c_check_functionality since regmap_get_i2c_bus already checks it.

Changes in v4:
 - Fix a bug about regmap_range configurations.
 - Add DRDY trigger support.
 - Change DRDY interrupt trigger source from RISING to HIGH.
 - Add a thread function to clear the interrupt.
 - Change the logic of one-shot read from waiting next continuous ends to
   writing to POLL register and waiting conversion ends.
 - Add iio_buffer_setup_ops to enable continuous conversion only when
   buffer is enabled.
 - Add active_scan_mask check in continuous conversions.
 - Remove *wait_measurement() in *trigger_handler().

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
  iio: magnetometer: Add DT support for PNI RM3100
  iio: magnetometer: Add driver support for PNI RM3100

 .../bindings/iio/magnetometer/pni,rm3100.txt  |  20 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  29 +
 drivers/iio/magnetometer/Makefile             |   4 +
 drivers/iio/magnetometer/rm3100-core.c        | 613 ++++++++++++++++++
 drivers/iio/magnetometer/rm3100-i2c.c         |  54 ++
 drivers/iio/magnetometer/rm3100-spi.c         |  64 ++
 drivers/iio/magnetometer/rm3100.h             |  17 +
 9 files changed, 809 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 create mode 100644 drivers/iio/magnetometer/rm3100-core.c
 create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
 create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
 create mode 100644 drivers/iio/magnetometer/rm3100.h

-- 
2.17.1

