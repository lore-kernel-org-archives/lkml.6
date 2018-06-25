Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE541C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B8249F9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxVibJky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5B8249F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeFYFXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:23:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34787 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeFYFXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:23:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id q4-v6so5567020pgr.1;
        Sun, 24 Jun 2018 22:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Uzhd6exg4mqiosMFZpw005mH+F6FZFOmY7NdD7oZDNg=;
        b=hxVibJkyd4aLdrt4k1HHfhVr0Ny1PIcuMU9cPI7BvbRzrqLGo8qPnzYEU0YfK+1eCT
         I8Iwy2rMd1feX2q+vQagz2FwzZGNbg74a6pKLFjK7SbiaYZBLWKZ/ZQ5eMBwZadwVFzH
         ZcM+5uGfoPabUdBGc2czqLD1BQNrNcGbOpFepec/YujfFNaZgdP7kHlSgYObe16BAcsc
         WyeSi2ShmtqtFhnzLJwvcHa9jw0EBfR4xkIv+QJiKC7oGQlNBzyV11jw2XZmwznZ40QC
         a6E+Y8w5gquLgotBgBatw0ZQ9eQ5WXjrERc5OajBWYhkr50yivqL8wp8PGvC4eju7wan
         M4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Uzhd6exg4mqiosMFZpw005mH+F6FZFOmY7NdD7oZDNg=;
        b=mWX8avSmN2jhdoz5FykUSafnb3u2Fm+YpfV+8CUvwcYu4CROjb/j9DN7goBi05QiPa
         q6DPhORrPujjDT/stc2kOUkAw1eJoYXAc+TDhFgSG1mEp+SwiHAzxcuOneHNtwjdVMPH
         oBuaUyLg1ABw9w/Gcu6k8neO9th0D1apE+qbyu9q8QiHADU73FUYcNmjCTeXJjxc0slh
         yJ945lvmBKiFLFfXBnv/PlMhq2NkhMGGk7HpNE99WFS/HMGQwH1sfn8da7juarCioJJK
         8y+BkH5bccGnzf7lJmZJ5hVR6ucqXIWScOcnp4jkZAiclkudNMVeZQPN8VRl6JENDwBe
         phVQ==
X-Gm-Message-State: APt69E0LClJjIKmHMmNKdp/mBt6l7e+KQEIpawDT/UEBDvyu2fX4ewJy
        IysiUQH8XL/qTlegQrdjlgwm
X-Google-Smtp-Source: ADUXVKJ8Mgp6+HJyTDm4J4aRKXEiABJxhxaZvCYC+n6wU9WIbS0ZPHYJirj4ZH1veVt8NwppQcK1zQ==
X-Received: by 2002:a63:3f05:: with SMTP id m5-v6mr6508368pga.51.1529904218189;
        Sun, 24 Jun 2018 22:23:38 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k71-v6sm1835936pga.62.2018.06.24.22.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 22:23:37 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] drivers/base: bugfix for supplier<-consumer ordering in device_kset
Date:   Mon, 25 Jun 2018 13:23:04 +0800
Message-Id: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
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

I tried to fix this issue in pci subsystem, and it turns out to be wrong.
Thanks to Christoph Hellwig, he enlightens me that it should be a bug in
driver core.

To ease the review, I organize the patch as the following
[3/3] reflects the root cause of this bug. if [2/3] is not acceptable,
we still need some way to fix it.
[2/3] introduce a algorithm to reorder device
[1/3] some trivial help routine


Pingfan Liu (3):
  drivers/base: introduce some help routines for reordering a group of
    dev
  drivers/base: reorder consumer and its children behind suppliers
  drivers/base: only reordering consumer device when probing

 drivers/base/base.h |   1 +
 drivers/base/core.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |   9 +---
 3 files changed, 138 insertions(+), 7 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
-- 
2.7.4

