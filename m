Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755079AbeEHPdH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:33:07 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:38238 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbeEHPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:33:03 -0400
X-Google-Smtp-Source: AB8JxZoazddn3Nz2U79hk+sRUJwr4qNh59VqUaahLWlX4WLGG6VQr2TmbgcUfbtvAYprvNh4JClaaQ==
MIME-Version: 1.0
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue, 8 May 2018 23:33:01 +0800
X-Gmail-Original-Message-ID: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
Message-ID: <CAC=mGzijVyqEG=DXH4v9WkD0kXR2WOJC4KBPzoT7g5wqVrPGXA@mail.gmail.com>
Subject: [RFC] net: Add new LoRaWAN subsystem
To: "David S. Miller" <davem@davemloft.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48FXDiX023232

A Low-Power Wide-Area Network (LPWAN) is a type of wireless
telecommunication wide area network designed to allow long range
communications at a low bit rate among things (connected objects), such
as sensors operated on a battery.  It can be used widely in IoT area.
LoRaWAN, which is one kind of implementation of LPWAN, is a medium
access control (MAC) layer protocol for managing communication between
LPWAN gateways and end-node devices, maintained by the LoRa Alliance.
LoRaWAN™ Specification could be downloaded at:
https://lora-alliance.org/lorawan-for-developers

However, LoRaWAN is not implemented in Linux kernel right now, so I am
trying to develop it.  Here is my repository:
https://github.com/starnight/LoRa/tree/lorawan-ndo/LoRaWAN

Because it is a kind of network, the ideal usage in an user space
program should be like "socket(PF_LORAWAN, SOCK_DGRAM, 0)" and with
other socket APIs.  Therefore, the definitions like AF_LORAWAN,
PF_LORAWAN ..., must be listed in the header files of glibc.
For the driver in kernel space, the definitions also must be listed in
the corresponding Linux socket header files.
Especially, both are for the testing programs.

Back to the mentioned "LoRaWAN is not implemented in Linux kernel now".
Could or should we add the definitions into corresponding kernel header
files now, if LoRaWAN will be accepted as a subsystem in Linux?

Thanks,
Jian-Hong Pan
