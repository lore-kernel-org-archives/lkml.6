Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503A1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B03B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UadlR7aQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfA1Rgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:42 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41202 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbfA1PzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:10 -0500
Received: by mail-wr1-f48.google.com with SMTP id x10so18589078wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0T59a439PmoM+RBgHtX80yzeydI/sVDjVRx3AEpgX0=;
        b=UadlR7aQshABJxFPB82d1N9pB0A6NKRrPDpA5aFK6EhRHCrE4LKRVvO6zy70m/lG63
         9ABNQj94PJd/z6cP/oIGEGeEEBeHhySS0o0i7D3TPnCh6TenfVG03B9ZAFOvpf4gOmHm
         lxUP0trOnZrEMix0rgNnn5xGJoY1cbuuJInwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0T59a439PmoM+RBgHtX80yzeydI/sVDjVRx3AEpgX0=;
        b=cdP1lwkBOWiQEnZYbe5Y0TZ4Wm0uUiARHOzF9ciorOHh9l5JF9YcdP57RVQvwhYpcw
         apf6d37av/mbcp/9jBg7MhceQPqFAT7S1QXlmxHxqVqeXmHhUVgzpHU/GSjC+1JKJGBe
         HNKphcUkOFo8cfbQalJXXE4kpOR3IOHOPlpEuNDxVHpU6Gn5zcaKSgkd2l+OdU6TmSoD
         VUhxES79nfa2O5lsFLWuQUYpE+GUZGI+D+dU3qGR2qsvfGeuVQBeZPnASi04BcDTCPds
         +Pzax38Uf/BH/z+LO6Myzzmi1ijvqewTFi07JnOxHsIe3qfgfuX5AK2M55s5oyQyE7jV
         iZEQ==
X-Gm-Message-State: AJcUukfqv2mgYOil1LR7vZBHntDW3hyCYTR8oUiXvWySyz5O8q9AwMiY
        C6wJ9/hXee/Yf+HodeVs+HrSX75xOJA=
X-Google-Smtp-Source: ALg8bN5Je+wuGL5CiQlixta8EMw4c1Am0cwqq9YKAcc5BuQyoHgrSUH+UXDwIOPVSzoGqY0i79cSGQ==
X-Received: by 2002:adf:f091:: with SMTP id n17mr22173594wro.292.1548690908564;
        Mon, 28 Jan 2019 07:55:08 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] nvmem: patches for 5.1
Date:   Mon, 28 Jan 2019 15:54:53 +0000
Message-Id: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are few nvmem patches which includes
	- some improvements to nvmem core done by Alban
	- add support for imx MX7ULP and MX6ULL.
	- fix block index calculation on sc27xx provider
	- add ACPI support to BCM OCOTP provider

Can you please pick them up for 5.1.

thanks,
srini


Alban Bedel (7):
  nvmem: core: Set the provider read-only when no write callback is
    given
  nvmem: core: Fix of_nvmem_cell_get() for optional cells
  nvmem: core: Fix cell lookup when no cell is found
  nvmem: core: Properly handle connection ID in of_nvmem_device_get()
  nvmem: core: Always reference the device returned by
    nvmem_device_get()
  nvmem: core: Fix device reference leak
  nvmem: core: Avoid useless iterations in nvmem_cell_get_from_lookup()

Anson Huang (2):
  dt-bindings: nvmem: imx-ocotp: add compatible string for i.MX7ULP
  nvmem: imx-ocotp: add i.MX7ULP support

Freeman Liu (1):
  nvmem: sc27xx: Convert nvmem offset to block index

Srinath Mannam (1):
  nvmem: bcm-ocotp: Add ACPI support to BCM OCOTP

Stefan Wahren (2):
  dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
  nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support

 .../devicetree/bindings/nvmem/imx-ocotp.txt   |  4 +-
 drivers/nvmem/bcm-ocotp.c                     | 37 +++++++++---------
 drivers/nvmem/core.c                          | 38 +++++++++++--------
 drivers/nvmem/imx-ocotp.c                     | 13 +++++++
 drivers/nvmem/sc27xx-efuse.c                  | 12 ++++--
 5 files changed, 66 insertions(+), 38 deletions(-)

-- 
2.20.1

