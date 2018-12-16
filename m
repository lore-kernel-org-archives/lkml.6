Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B0AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6252217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="XH1/3Cda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbeLPKTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:19:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbeLPKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:19:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so4728084pgm.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=359ovBunooVD3P2Qm3x/seh4P2yoaskOTXN+uKbC/PE=;
        b=XH1/3CdaF+GdLyzADbT9LJj9D05H+brwi4e2QqeOrFtrsjjVbiku0Dihnifl1J4sLE
         lEXybiCm5v7fMTnxrQ84OKLxsFfz7urIt54WqpwHPwl5f34crA3ofxJGngW8p5oRVEPi
         /5GrBiQHtCMZz1ykcvP+fdL4yTUAEY8i/yrhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=359ovBunooVD3P2Qm3x/seh4P2yoaskOTXN+uKbC/PE=;
        b=TjAiu4m34hE5ZpLD7lsByXkjHgd0zRgmRHlNhPlIpBL1E6odVeA4LmIWWevDk3Gngn
         B5oe5M4c+7JlLFE9Vpr3u0Zv9gx6/KRdYjo6E9IJttXo1EuiN62wP2hUSZjJXzDX8sB+
         4PcJcIaW7zLLNHs9c8n3c2E0nAk7JA0ftIukF/wjVKtY0x2GTuN5b2bxCzN5q2fj/15R
         fdv65+Kbg/HVlCzU7ELhBixh/0flzoJeIZ6l3bpvll1MNFFq5jwXt2Lt9xkZXZDLvGgY
         s1kJToK/XZ8y6Gm1cdEFiC6F18bvpC+ml12XDW6r7kqjRJWkGV8lgyj/lwN8eXAAPRh1
         sERw==
X-Gm-Message-State: AA+aEWaelRNjtuKV/had7UQjBl6I35HuovflORGNG2KDWDIjNqy8PHOp
        aVxX46OvSiQM53IoZxh/QCd67g==
X-Google-Smtp-Source: AFSGD/WUCNLNOOpIUKVDZOlfVBWH0/cSKqP62cej936OMvCQK+5oVL+Uu04P7HZXmlHcEHKxJhAAFA==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr8231749pga.191.1544955555822;
        Sun, 16 Dec 2018 02:19:15 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id d21sm14964454pgv.37.2018.12.16.02.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 02:19:15 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH v5 0/6] net: lorawan: Add LoRaWAN soft MAC module
Date:   Sun, 16 Dec 2018 18:18:53 +0800
Message-Id: <20181216101858.9585-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.

LoRaWAN networks typically are laid out in a star-of-stars topology in
which gateways relay messages between end-devices and a central network
server at the backend.  Gateways are connected to the network server via
standard IP connections while end-devices use single hop LoRa(TM) or FSK
communication to one or many gateways.

A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
optional features (Class B, Class C ...):
* Bi-directional end-devices (Class A)
* Bi-directional end-devices with scheduled receive slots (Class B)
* Bi-directional end-devices with maximal receive slots (Class C)

This patch set add LoRaWAN class module implementing the stack,
especially the soft MAC, between socket APIs and LoRa device drivers.

socket APIs:
send and receive the data
------------------------------------------------------------------------
LoRaWAN class module implements soft MAC:
append the header/footer, encryption/decryption, timing slot and MAC
commands
------------------------------------------------------------------------
LoRa device drivers:
send and receive the messages for MAC layer
------------------------------------------------------------------------
LoRa devices

This module starts from simple and implements partial Class A
end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
More features and complexity, for example regional parameters, confirmed
data messages, join request/accept messages for Over-The-Air Activation,
MAC commands ... will be added in the future.

Jian-Hong Pan (6):
  net: lorawan: Add LoRaWAN socket module
  net: lorawan: Add LoRaWAN API declaration for LoRa devices
  net: maclorawan: Add maclorawan module declaration
  net: maclorawan: Implement the crypto of maclorawan module
  net: maclorawan: Implement maclorawan class module
  net: lorawan: List LORAWAN in menuconfig

 include/linux/lora/lorawan.h        | 131 ++++++
 include/linux/lora/lorawan_netdev.h |  52 +++
 net/Kconfig                         |   2 +
 net/Makefile                        |   2 +
 net/lorawan/Kconfig                 |  10 +
 net/lorawan/Makefile                |   2 +
 net/lorawan/socket.c                | 686 ++++++++++++++++++++++++++++
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/crypto.c             | 212 +++++++++
 net/maclorawan/crypto.h             |  27 ++
 net/maclorawan/mac.c                | 555 ++++++++++++++++++++++
 net/maclorawan/maclorawan.h         | 202 ++++++++
 net/maclorawan/main.c               | 606 ++++++++++++++++++++++++
 14 files changed, 2503 insertions(+)
 create mode 100644 include/linux/lora/lorawan.h
 create mode 100644 include/linux/lora/lorawan_netdev.h
 create mode 100644 net/lorawan/Kconfig
 create mode 100644 net/lorawan/Makefile
 create mode 100644 net/lorawan/socket.c
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/maclorawan.h
 create mode 100644 net/maclorawan/main.c

-- 
2.20.0

