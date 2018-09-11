Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651DCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1834B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="SFqsd5to"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1834B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sweptlaser.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeIKW3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:29:02 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33655 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeIKW3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:29:02 -0400
Received: by mail-io0-f171.google.com with SMTP id r196-v6so4254854iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1hMAetTvqeBYjwET2Anap9K95Oq0TPxHr+OlGr1r7U4=;
        b=SFqsd5toXr2j4s/Ffj0a8ou2QOPFIf2H5ujmyIosjMW50CKPXrwsh5EqEB1n3nZXPc
         +HuoSE0T5b3UyaVXmrSyvic90xfTF104ThGomx/cWfjnhtJKLJt9fevav5Lj7F70aPQ6
         ii3SPnoRaFnrL4w9Xoa5IxX78ts8WWdyqj9qcWYAA1X5v8assZy9RK+0LBxxHNmAVzHt
         p/DYeWIT4ApfJB1JwNgDZ/kUaduiHt9o2YMf4IBEmOJUO1i4XBlD16f46UCrjXe/XAWL
         J+FJuLR347J32xdTPmvuUPO6tO0Qino7QmlZs+9X0G8rlQREzxD2f7yKDPvNT8WC6r+p
         0dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1hMAetTvqeBYjwET2Anap9K95Oq0TPxHr+OlGr1r7U4=;
        b=EOzVIoInomBvPLvjj7yayfdxU8ZZHEkEgyVoDfNafZH9bAxLZjM6RhNWU+/OKIUCE7
         Z1azivEYNHGnrciMhkaNtFmd6R6ow1csufPwoGHpTkJ9s//KsABq+L36xqdLRdF/iQ74
         iFVqY/vi53j8uvxEoTFmrQOFLI+hQdCO7zMroA8i8qKpQUqS1Dg9GkvT4N8H+ZyjJMYs
         SiGSBfO1eP9P+9sVBVqqe6DN8/hw9IXI/RnURqIN0FgV0te5V/TZ1kG9zWT0a6zi13U2
         WvYlp3a++qNKKGsr6aj1OpdAtXOt5A18VSaXPfe9EIWyGMVlCM7RhioQxlQuSo2fd+rx
         rjqA==
X-Gm-Message-State: APzg51DsBp7vfUsc68tjC+FeS6jkpBkYpLBBKv74D2ItX00fnBP+tWOD
        HyN3fq2B/Prl793wILqIrqcZ/g==
X-Google-Smtp-Source: ANB0Vda2Wt0Usunmjxea1kMAb7WhV7/JyFTfyCBLe1TmbI3QuZO6kOVqWYsBYXfFsnA5iss0p8aZgA==
X-Received: by 2002:a6b:c042:: with SMTP id q63-v6mr21366526iof.261.1536686922595;
        Tue, 11 Sep 2018 10:28:42 -0700 (PDT)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id g198-v6sm5050261itg.4.2018.09.11.10.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 10:28:41 -0700 (PDT)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] rtc: abx80x: add basic watchdog support
Date:   Tue, 11 Sep 2018 11:28:24 -0600
Message-Id: <20180911172826.7195-1-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds watchdog support for abracon RTC chips which
include basic watchdog functionality.

Thank you for reviewing.

Changes in v3 (all in patch 2):
* fix CONFIG_WATCHDOG dependency again (hopefully correctly this time)
* don't start hardware when set_timeout is called
* remove unneeded WDOG_HW_RUNNING bit changes
* fix abx80x_setup_watchdog()
* fix formatting of multiline splits
 
Changes in v2:
* split out priv structure into a separate patch
* remove new Kconfig option
* fix CONFIG_WATCHDOG dependency
* fix WDT interrupt message


Jeremy Gebben (2):
  rtc: abx80x: use a 'priv' struct for client data
  rtc: abx80x: add basic watchdog support

 drivers/rtc/Kconfig      |   1 +
 drivers/rtc/rtc-abx80x.c | 143 +++++++++++++++++++++++++++++++++++----
 2 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.17.1

