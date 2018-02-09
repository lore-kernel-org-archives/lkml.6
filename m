Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeBIMHl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:07:41 -0500
Received: from mout.gmx.net ([212.227.17.20]:53751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbeBIMHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:07:39 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 0/4] Nintendo Wii GPIO driver
Date: Fri,  9 Feb 2018 13:07:27 +0100
Message-Id: <20180209120732.17863-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:n4AYcxVYkUmK320ZnYqYhTtji/zhTj8NSC5jUQ6zeslnxrmUqkz
 1+rjkmHM7M+riAeuVW2/n56wRj1iLpgmNW/BkOMRk+2i1MHXooF5wEIl5jgTIYWQAPSaps8
 g9iSjfbxs6fkOeTuLhWsddX76YE1HSDVhCQMFUHgjwDsMepBKdrychOPJ2ff33F8xRSRJXE
 rjEKaJfZJoCnYYz6K8uLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fTVrENPqqrY=:mrSJzh+bKUAu/plXahQIGp
 8hP47Smm9duOVtdXCDcb8plp4QatKCc0OkyJWTdvWXnBY7Haen5n2Aov+ZD1xYwTeY71WlDha
 s9ajA2cJ9AhBVCJF/rqWELXWumNStZNuDh5cEqLMNQqewwIt62n2hfUgBT1FMcuXDLApJ8sIs
 CheNchZLotSTLYl1MqDzy+LD9DAI+0ya1u/s4wTFB+yWbglEnchw1UdUgvjM9bjRNujOJ2XmE
 tPKdzvFovqt3gs14TIhV3KAfZfHY85ZJ0Y6COvX4PtUUWxF5AlO/PD8mCJSmnDjNYRfXsyIKo
 OYJTmOepQB+OKifoOG48JSr63nUfFFAUsGLTE/sf/y3bAbgzIYS7ZL5UJ2h33uIPZbIMi8UUn
 G3OPhvORtWyYj3sEu8UQNoQvrDxzH+2WjZkFHssw4Yz9LcaG3ceBRoKcHS0LvCRpuRGld2cfE
 NXf7al8PPGcvaDOpEqm3XQgEJ7kpUuIIuvi7mBNudkL1OjDsBRr1SqTom2LOqMLK8ZGhA7AUU
 TVPVM3n195HjBPMZDvWm66v3oEhDawbtINAZn4h2Yq0jEKt2+wUJDViF1H1f9QC9ejUim94TY
 X5NMRrHHKyRwa8lrQCnBR9pVtrEj4a5rRBhK1zuKLXHMqlcR1QAoTe/VCVnpaMuYrYPVXH4kZ
 5VkaHSG4C9XV9xYSSlEvrylpVdQSPmkh9YMwvOstvRSLVKZU0yIspjW4RJ9vkfgxW+2eBZD/O
 F0dZkRj/IBZtoEvQ1KUaakdbulQ605ftxR7kRYloV+nI/w7l4kmgAaVfPXCfsVOfLM1VNI6IP
 tu7D0Gok1pJDrbqOhuiamaipjSX0jnv2wUxk7qcc3w10O/GHis=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: https://www.spinics.net/lists/devicetree/msg211283.html

This series adds a driver for the GPIO controller used in the Nintendo
Wii game console.

Previous versions of this series included a patch to kernel/resource.c
("resource: Extend the PPC32 reserved memory hack") to work around a
resource allocation problem on PPC32. In this version, I dropped this
patch, because the problem will be solved differently and in a separate
patchset.

I also dropped the dt-bindings patch, because Linus Walleij has already
applied it.

Jonathan Neuschäfer (4):
  powerpc: wii: Explicitly configure GPIO owner for poweroff pin
  gpio: Add GPIO driver for Nintendo Wii
  powerpc: wii.dts: Add ngpios property
  powerpc: wii.dts: Add GPIO line names

 arch/powerpc/boot/dts/wii.dts            |   9 +++
 arch/powerpc/platforms/embedded6xx/wii.c |   7 ++
 drivers/gpio/Kconfig                     |   9 +++
 drivers/gpio/Makefile                    |   1 +
 drivers/gpio/gpio-hlwd.c                 | 115 +++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 drivers/gpio/gpio-hlwd.c

-- 
2.15.1
