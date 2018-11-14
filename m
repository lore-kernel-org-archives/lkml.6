Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1821780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBHCaSkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA1821780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbeKOBO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:14:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38363 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeKOBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:14:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so1613488lja.5;
        Wed, 14 Nov 2018 07:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xM5yCp9rTULcTDX2JsWjmFwenX6yZTZAwAoL3feC4vA=;
        b=SBHCaSkURNNTFOEhl/JhoSQc7qOIDp1TZUJvkJ9JjAR1Frh+RKwmLe1YOF2j7obuFv
         VYjtQ5nKBEbKItkSwdH0ezgd1Q9TPEkr4x9RweddmiZQPeThTpydusv8n1cQuAySOqcP
         H5CW1VhNlxatnpGzI0xX0JQCi7CKomP1n0D693IUMST5YGKr37SSMVxJjmvHO80SwP51
         yuEpitQXQCn/Y1fQFdurDGFr779qFY01Sps85uSN8epcZS4DYzOBG5ZlmVJnnZ+VcXwE
         FPVT/AbYoSxk3UAaNdGwd4HLVVkRdFFDaNU3eZlL7Al2iK9K+SZsu29Irpc5sKvs3KFy
         tjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xM5yCp9rTULcTDX2JsWjmFwenX6yZTZAwAoL3feC4vA=;
        b=LhlTEe+kanptwAeJYc02n0shBnchc1sGPvWvew8I/N+xIxopjev1mSxYnFeY0yZwNL
         bkl1uPZjlDJ9c2fqiD7S5AWuvNcX1uAn3OruXD0bo9bRMr4ulqYoykKkUhD/WZHmy44h
         q3NSHHEqQRJVSoPTYGDrZ3BazUvtVMCofaTM/wsmNchUMTVJVJEOMZd/bI/fSZmNdhAE
         hg4H3Q2wMD/9+IWF/OKqDDj1c2kkxgE3NUIfVQCy/mUC8RMKn97gEnZXZ5SLuxSoWxcS
         B55LBwd1ktg5uc8OgxpSUpcbALqRrQrv4KBjXcv6N16a5BXgTCrZGFaTfexO5RQZ2TJ9
         fE+A==
X-Gm-Message-State: AGRZ1gKyvZ09ItKhS+RxnYXlCc8FMaVJTrkp7Tj1eDxKKBcQkGTDyBQI
        PjaO+1UEn5edS5VvpPE/lgQ=
X-Google-Smtp-Source: AJdET5caMQDebHc3hxs6tDxBRT9hcfe0B1S6uribfZxfcvlO/cjBJMYRyFgrDQTiQyzwUk9NSoTrng==
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr1354939ljh.135.1542208248497;
        Wed, 14 Nov 2018 07:10:48 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q124-v6sm3846172ljb.89.2018.11.14.07.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:10:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gMwoX-00058U-AW; Wed, 14 Nov 2018 16:10:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] serdev: make serdev_device_write() more usable
Date:   Wed, 14 Nov 2018 16:09:00 +0100
Message-Id: <20181114150904.19653-1-johan@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series make the synchronous serdev_device_write() helper more
usable by 

	1) allowing drivers to pass a zero timeout to indicate that they
	   want to wait forever;

	2) returning the number of bytes actually written (buffered)
	   if the helper is interrupted;

	3) make the helper use interruptible wait so that the helper can
	   be used on behalf of user space.

Finally, the two write functions are documented using kernel-doc.

Turns out I was using the wrong timeout for two gnss drivers that
expected the helper to wait indefinitely. I've fixed up those separately
(by using MAX_SCHEDULE_TIMEOUT for now), but for the helper to be usable
when using flow control we really want it to be interruptible.

Besides the two gnss drivers, there's currently only one other in-kernel
user of this helper and that driver (rave-sp) uses a non-zero timeout
and doesn't check the return value and therefore does not need to be
updated.

Note that this series depends on the two above mentioned GNSS fixes
(submitted for v4.20-rc3).

Johan


Johan Hovold (4):
  serdev: use zero to indicate infinite write timeout
  serdev: make synchronous write return bytes written
  serdev: make synchronous write helper interruptible
  serdev: document the write functions using kernel-doc

 drivers/gnss/serial.c     |  2 +-
 drivers/gnss/sirf.c       |  2 +-
 drivers/tty/serdev/core.c | 70 +++++++++++++++++++++++++++++++++++----
 include/linux/serdev.h    |  2 +-
 4 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.19.1

