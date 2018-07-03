Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C36C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD79208FA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4BmVso3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD79208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbeGCGve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:51:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43428 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeGCGva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:51:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so539200plj.10;
        Mon, 02 Jul 2018 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XDwYUnB9q6ZwmBTwn6+mxs9DFgEKQwJJSi/07xpomkE=;
        b=G4BmVso3MG+fPQWUfghlzUUnuZPlWVb7zU9qYrXImnuyIHnWHYIeEiiniEtPrJWURP
         LyxH7TVsERq1rEz08GfK3QidcxTgwaKOCsjUhaPgq+Gm4uEzGM/RQ88zTgxCBihjbCHi
         4f2ljPBlEvl73VAu6xl4MfZWeegHrUUFoge2djVljorAbFLZ56VDnTEyAQN3jN+o35Fn
         /1A8sIrYG2kxI1pgIJIB3z7+vdOfOkzXiSEFNXjc0Akzdtxvqaap2PJ3SU4tQ9+JCtza
         mjMHMRIyFQPOkBB3Ei6AP271UuZ8No8F91O5Q2kbmqvuCNkU7h/qlkroM7IBTtMNuph6
         +dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XDwYUnB9q6ZwmBTwn6+mxs9DFgEKQwJJSi/07xpomkE=;
        b=Y7NgJOR+SXb+1gtOUjwqd5p6rqThEyiA7xWQEbgtxZseByymQ0rxA9l6BZGHJWF3Te
         Qzg8O4EWxAw+Y1yIOeBtTQdH7IMjcvMNhSp02ATZ+3gWnM1vE0K600FwuHPLKHhquKV5
         hILCcXPxCB77ejoTrTjc0mog1wJSGwcLiQ5K0pHWPDU8OCLMmzpXM4RMKV+4z29OfS+6
         RAyKk0WdJ2P3qgJsD5pnzoS1d45iosPL7aNwZoLi5hNiMi4/4xhCswvhpwDX8DXlRRWy
         X8A2KoYgPOK6/tjS54Ag3cQNerTrE+U5bKz1y1EC7PDm/UWnWvogTgGNYXyf2NYvYpgn
         L5pA==
X-Gm-Message-State: APt69E1+j3OrKzn2XW7uhDTWNFW4Hj7imVyWgjsBvb2phHQ/QBehnZ89
        bG713VNy1zOToWmuu1CFy3VC
X-Google-Smtp-Source: AAOMgpcxDcvC4hakQfPWolil53bLx5RxzSgh3Krkf8UD3xw08hVsORXlq31O1h6rA8Cg58rqMYc8Ww==
X-Received: by 2002:a17:902:5a4f:: with SMTP id f15-v6mr21839212plm.253.1530600689998;
        Mon, 02 Jul 2018 23:51:29 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e189-v6sm981122pfe.52.2018.07.02.23.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 23:51:29 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer ordering in device_kset
Date:   Tue,  3 Jul 2018 14:50:38 +0800
Message-Id: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
places an assumption of supplier<-consumer order on the process of probe.
But it turns out to break down the parent <- child order in some scene.
E.g in pci, a bridge is enabled by pci core, and behind it, the devices
have been probed. Then comes the bridge's module, which enables extra
feature(such as hotplug) on this bridge.
This will break the parent<-children order and cause failure when
"kexec -e" in some scenario.

v2 -> v3:
It is a little hard to impose both "parent<-child" and "supplier<-consumer"
on devices_kset. Hence v3 drops this method, postpones the issue to shutdown
time instead of probing, and utilizes device-tree info during shutdown
instead of the item's seq inside devices_kset.

Pingfan Liu (4):
  drivers/base: fold the routine of device's shutdown into a func
  drivers/base: utilize device tree info to shutdown devices
  drivers/base: clean up the usage of devices_kset_move_last()
  Revert "driver core: correct device's shutdown order"

 drivers/base/base.h    |   1 -
 drivers/base/core.c    | 196 +++++++++++++++++++++++--------------------------
 drivers/base/dd.c      |   8 --
 include/linux/device.h |   1 +
 4 files changed, 92 insertions(+), 114 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

-- 
2.7.4

