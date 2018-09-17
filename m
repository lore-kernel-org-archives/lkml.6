Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFEDECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E16214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8BW+Pi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E16214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeIQXoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:44:37 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43272 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIQXoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:44:37 -0400
Received: by mail-pg1-f179.google.com with SMTP id v66-v6so8037840pgb.10;
        Mon, 17 Sep 2018 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgEw7t5by70EF2K82qNwoCmMlEgAhtmyB6wHDIQ41BM=;
        b=Z8BW+Pi1geG0GDJrtdhCxDrxIVmhO3aTh+9W8qqBZWaI9RFk1G29Hdvxw68kX31u9s
         4n8ccsnqkLl17ScRNSJZzK1JlDGjBDhfgQ7+MO3XQnmL2ocbRwxfUPl0owh87PkegA+3
         6uI9vnB6g666Mp89QjnQFqm9HMRqZx3L75CAjQP8EXZCU/I/Z3Gx8zaIZJDS4yoKypgY
         vhOViLyb0J+vh75ukzc7nC8OSiS3kM3Mb045fZun4hmZhWGvp95R4hqISU/Jgx+FyIi5
         34IdLp7CwBj3R3Qj96kaHmTZOMrO8CJ1dG6egVRaiC/51EE/rqRoqL+E+3/Qc1Sc7ynH
         ljrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgEw7t5by70EF2K82qNwoCmMlEgAhtmyB6wHDIQ41BM=;
        b=jkg/eplA+XFHwsi4VMXvcJInmXpm5nyVqJuuhIUp31paUQchRdkYiFGjBS7myxEk2F
         9nvRjsyxEZ97JqwVqsscZZHDJJX1WeQdVNqDPFd2XrTP5pyZXKkBJZTURGoWcQMUBpCk
         hHqT8uZkE3MeYiLlpJREUtI+tKJUYG/MKkOR9Yi4Bw+n/Q0IbuQoSpCOERkt7doSfJUJ
         elXvo4dMKb22Pg8bRP2LwMa90Mz/qGlmXEGRf38cpKArQBQbyaklM8UwetejAihOwgWT
         ygVNByHrJEJa7s1lyvc1/jcVXnKvNgQLH3ND098Q/IjkzuR7Qa6mCBkJ++4R/VkIOKav
         EGjQ==
X-Gm-Message-State: APzg51Bal0SUmG24CQq20qTpd5THpqRroiiBjbKL0FYB0WWYj+matIDb
        3Von07JjJF/oghLKcvwpnhA=
X-Google-Smtp-Source: ANB0Vdbo5/OLHCJtRZRzxXsspz9mreuJqaotdizHL7jKVwyeQgynm/8mqKhMCfnt6Jk6+693huNdBw==
X-Received: by 2002:a62:6283:: with SMTP id w125-v6mr27014971pfb.108.1537208166881;
        Mon, 17 Sep 2018 11:16:06 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 74-v6sm24076366pfv.33.2018.09.17.11.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:16:05 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC/PATCH 0/5] Support children for legacy device properties
Date:   Mon, 17 Sep 2018 11:15:58 -0700
Message-Id: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic device properties APIs are very helpful as they allow abstracting
away details of the platform (whether it is ACPI, device tree, or legacy board
file), so that individual driver does not need separate code paths to support
all variants. However there are drivers that currently can not use generic
device properties API as they need notion of children properties, for example
gpio_keys driver, that expects every button to be described as a sub-node of
main device.

This patch series introduces notion of sub-nodes for static properties and ties
it up with GPIO lookup tables so that they are usable with sub-nodes as well.

Thanks.

-- 
Dmitry

