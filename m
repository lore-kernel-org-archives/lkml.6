Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD22C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E77920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqFmpbt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfAQXNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:13:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45635 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfAQXNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:13:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so5098657pgc.12;
        Thu, 17 Jan 2019 15:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JSjpioWtnVOL/eJ484jB3jAB2KYQjCIrAGKWHS8nR3o=;
        b=IqFmpbt2FI5BP301xirN0YroTft31d4V2kgvnsAilL+gbNj6p5/ARWd4U5nnNkT8N/
         StE6O4Kzz2tzlCi9BZKTpRg5Rc70bKAiX3cI9A5HUhczhO12JEl8TkgMJCSYHvmL3O3z
         HLUvG4eW3kob12f5eSj93roCsf5f2EzF3YsESwsSmNMIM88QJba+rn7Um9vUFN6KWnSL
         nzvNYKlzJq4ZvLse5MRnNFKtbBJ615art+FKzMuGWRaiQ9lMT/YDt1rv/Gw7tefUMIz1
         kfCElp97GHopk+1rMbuUKNBNBF3SLYbJ6lj45xRwalWvfmWKY6eBRhLuojX7WuV1EVrK
         immA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JSjpioWtnVOL/eJ484jB3jAB2KYQjCIrAGKWHS8nR3o=;
        b=F1uWmeeOMOYtpuF7t1C/Q/c2BSezILPIsOwr0BtjEG3jUnPqzSVDtdrn75jvp76Slq
         klJ36StIETEGxd9lJdVEuuu3Ewsvl929rbPoYL/+0II4k3B5luSD2euLz32D5NlUH6qz
         JTiEZPBXIrQqITRjcM7p5sGHPq5QF+ak0Yurefp49a5rYaZRQBGqiyJLjwAy61wKHhK4
         zODUa35+s6ZpbgrHzhgnVwUjYa9n3ud2cMMB4AOdvDQjzv9Z/z/GIAURbS+752eM+MbG
         335x20QzT2blyKbEzDc3dVVCk+u0922r8EgKQYBC35G7RMImSVWjc8IYmvcGbFPrBg/O
         giAg==
X-Gm-Message-State: AJcUukckjCxY9rjGEkgvuRT3ZHrWUzlK7C4EHrzQT/NhKBwlFL/U4Xhw
        UKsVx7nc1dZGTB9551N/VUU=
X-Google-Smtp-Source: ALg8bN4tBXp3EDROodfPeqIEFDtofJjNh7rRbGEGcU3fJNfFhpVh7GXrdEUBwIyqQ1eeGXzjgeFsbQ==
X-Received: by 2002:a63:960a:: with SMTP id c10mr15236408pge.106.1547766786676;
        Thu, 17 Jan 2019 15:13:06 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b27sm4125145pfh.113.2019.01.17.15.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:13:06 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] hwmon (ina3221) Add single-shot mode support
Date:   Thu, 17 Jan 2019 15:12:51 -0800
Message-Id: <20190117231253.8828-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, ina3221, as a hardware monitor, continuously measures
the inputs and generates corresponding data. However, for battery
powered devices, this mode might be power consuming.

This series of patches add a feature of changing default operating
mode to its single-shot mode via DT.

Changelog
v2->v3:
 * Added "Reviewed-by" from Rob to PATCH-1
 * Cleaned-up PATCH-2
v1->v2:
 * Cleaned-up PATCH-2

Nicolin Chen (2):
  dt-bindings: hwmon: ina3221: Add ti,single-shot property
  hwmon: (ina3221) Implement ti,single-shot DT property

 .../devicetree/bindings/hwmon/ina3221.txt     | 10 ++++++++++
 drivers/hwmon/ina3221.c                       | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.17.1

