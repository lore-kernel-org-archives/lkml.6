Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D1DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B05221725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOF6VayH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B05221725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbeHOB1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:27:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40372 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbeHOB1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:27:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so8891243plp.7;
        Tue, 14 Aug 2018 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlbVHQZptRl/D0izGEcfDiJDy11yt2JSqJtW1mL2s/s=;
        b=cOF6VayHoR2pmxbnc/ue36xEN39aAHq3crFOcw/0jc5NAveuTucTHiJfcUZWV+BShx
         FXwxNPcw7u9zAtALI2VEWxiTLGptUE5dO96SIqvSkH1J925S8sWEltJxK+QiFfASsJfw
         XCiogDqNbWECDLJyW20aizDSxogIi4rqRoO89w/wB3AV6xz51qe+U/tsQOBkCLxvwWFZ
         gzPSDw1YT0Iv3yKmTrgLKCyQ7jnuJ1T2cw7DDS/BEmBXy3/hH+j4U29lyxUZkms4Bn02
         lalDIBambt7miW75Zcpcm3cjT/6+v2tkwKoVQG3pA8mrbxnggIn3d36cCt67xKxT737O
         AnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlbVHQZptRl/D0izGEcfDiJDy11yt2JSqJtW1mL2s/s=;
        b=OOvYmkLT9dCK7wAhm7HZ8Y8LrCvqH5Ik3HMRN5WMbXv4GPulye3Xid4Dr0L1mkeSji
         PgZmqVTDcAwO4y8B80Y4VlxUYM8TXKVM+ydHSbavXYlaR7drHekouCEFzQoxO2BLmZcB
         FDt71DG0bjruzQhmP1xWurHCowivmX3ye7nxdkNPPbVfjv69jeD6Y5CHgSQuHjnkuJVn
         XlcYLUjtTFDiC1CvdPWwsxf9nwURxCDumtaUg/TSxKqX866KnelpwKaAS/zpJsPQRxlv
         uoG6/L3rOA5k2XoEULkRS71cyL9iBX6XDEBi50TGJuWSDL4+cAcN12X5Vdg60/1yq2SU
         Rxfw==
X-Gm-Message-State: AOUpUlFV0W4cnasEuo9CtvkK8ykkTd29a1bm1SnZEGyafroj3a3+DARf
        UNyFtcHF+B2Y7622lw9E1eI=
X-Google-Smtp-Source: AA+uWPxtfW2Sao8RX11iv3bfrbke4DECRHyH3vsvdfnMKTlEJxFipB64nHcs3va5W7nxi5v/TBypUg==
X-Received: by 2002:a17:902:290a:: with SMTP id g10-v6mr22020412plb.110.1534286304794;
        Tue, 14 Aug 2018 15:38:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id e126-v6sm48420948pfg.31.2018.08.14.15.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 15:38:23 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
X-Google-Original-From: Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
Date:   Tue, 14 Aug 2018 15:37:55 -0700
Message-Id: <20180814223758.117433-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Preface: I'm sure there are at least a few minor issues with this
patchset as-is. But I'd appreciate ("RFC") if I can get general feedback
on the approach here; perhaps there are alternatives, or perhaps I've
missed similar proposals in the past. (My problems don't feel all that
unique.)

---

Today, we have generic support for 'mac-address' and 'local-mac-address'
properties in both Device Tree nodes and in generic Device Properties,
such that network device drivers can pick up a hardware address from
there, in cases where the MAC address isn't baked into the network card.
This method of MAC address retrieval presumes that either:
(a) there's a unique device tree (or similar) stored on a given device
    or
(b) some other entity (e.g., boot firmware) will modify device nodes
    runtime to place that MAC address into the appropriate device
    properties.

Option (a) is not feasbile for many systems.

Option (b) can work, but there are some reasons why one might not want
to do that:
 (1) This requires that system firmware understand the device tree
     structure, sometimes to the point of memorizing path names (e.g.,
     /soc/wifi@xxxxxxxx). At least for Device Tree, these path names are
     not necessarily an ABI, and so this introduces unneeded fragility.
 (2) Other than this device-tree shim requirement, system firmware may
     have no reason to understand anything about network devices.

So instead, I'm looking for a way to have a device node describe where
to find its MAC address, rather than having the device node contain the
MAC address directly. Then system firmware doesn't have to manage
anything.

In particular, I add support for the Google Vital Product Data (VPD)
format, used within the Coreboot project. The format is described here:

https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md

TL;DR: VPD consists of a TLV-like table, with key/value pairs of
strings. This is often stored persistently on the boot flash and
presented via in-memory Coreboot tables, for the operating system to
read.

We already have a VPD driver that parses this table and presents it to
user space. This series extends that driver to allow in-kernel lookups
of MAC address entries.

Thanks,
Brian


Brian Norris (3):
  dt-bindings: net: Add 'mac-address-lookup' property
  device property: Support complex MAC address lookup
  firmware: vpd: add MAC address parser

 .../devicetree/bindings/net/ethernet.txt      | 12 +++
 drivers/base/property.c                       | 83 ++++++++++++++++++-
 drivers/firmware/google/vpd.c                 | 67 +++++++++++++++
 include/linux/property.h                      | 23 +++++
 4 files changed, 183 insertions(+), 2 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6-goog

