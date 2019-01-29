Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E892820869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="vDWZ8xEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfA2UzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:55:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45428 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2UzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:55:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so18714051ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebd4B/AkZtpa6mFXnvdr/ez9zTT+cqAuD0fjPwoJvSg=;
        b=vDWZ8xEKwqL8o6TKZ0RBJiC6Tq8PfYnlg/HVmi95Wu8aNdxysMTNxYvPcoolkVJlll
         Y8D+UCWZ0ATFOTSo2T5hMhiojotT5xe4OI57WNqw5Bxkf5R8k1AL0qf3z4d1QWOGTJat
         ys9TOm12xAI7FVivQ7O/I4YObQ6PuzKpdOxZifKfkN/m1zDgmCp92P1ed5hJ18nEMkcn
         85lLLo/AVzngVcsGfm+P7VoOIB/XSQXQTVJg+DGw4Yg6ADzBMYB4yX8ao8s5gGXgs9+V
         hQfKpVLcKgwXC+lNBhEIKCa2M7To7QEeyK+UT+k/RWeo0scS+nw6BpGvsIfmc4CYtw9T
         ql/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebd4B/AkZtpa6mFXnvdr/ez9zTT+cqAuD0fjPwoJvSg=;
        b=UeUp5lSEUBX36dnxffuCPM7gktnXuggiHxoiB19z333j5Lfib77IwTiLPLWnzMp5+s
         h3G+xSmYgpUtnqcNyT5pK89YkcjHLieIgJC2u+3sBX4yilFH+JIzzb3Xf+dTD7IkCUB/
         bcaveqnGUT2ujvyigIRB/rpRrVy7UYgsRIRbgVvF9ohjmY4cdHjN3nXHz3I0RML+MjoU
         b/QyCdOI6P4vopF91kcSbj5NPFGilzl8bA35Fniq8uCy/3VchqcmBDYCxkIPTb56tdyu
         tlyIL8NIw8pgrj8IC7N6V/UqVu8ZoMgpVhR4aRpgv/llGRUi56wiEeQNGG7FW7EY2A6o
         uneg==
X-Gm-Message-State: AJcUukeYYcD31SJ677sL4Q7rTpVpbILvkveIh6dpVSYHkd6FpFD5L6LD
        j7b3dXE7Zuhqc2hWmntquQul/KaSPxQ=
X-Google-Smtp-Source: ALg8bN6L5qowfEJ7Oo8y4o5vrkOZ8wAjHtYXnlYeysHC74tGsNYR5qTaZV2iIS33niwXxScfjC081w==
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr21917389ljh.135.1548795305120;
        Tue, 29 Jan 2019 12:55:05 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id o17sm3677287lff.77.2019.01.29.12.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:55:04 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v5 0/2] spi: support inter-word delays
Date:   Tue, 29 Jan 2019 21:55:00 +0100
Message-Id: <20190129205502.7741-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed in v5:
* Rebased on linux-next
* Fixed up Atmel patch to simplify register setting

Changed in v4:
* Rename word_delay to word_delay_us and slot it in _beside_ the
  existing word_delay parameter in spi_transfer (see commit message for
  more info).
* Add code to __spi_validate to make sure transfer and device align with
  respect to the word_delay_us parameter

Changed in v3:
* Drop setting of inter-word delay via device tree

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

 drivers/spi/spi-atmel.c | 11 ++++++-----
 drivers/spi/spi.c       |  5 +++++
 include/linux/spi/spi.h |  6 ++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.19.1

