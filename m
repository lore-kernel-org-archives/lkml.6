Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeCNPpj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:45:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeCNPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:45:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH 23/47] cpufreq: remove cris specific drivers
Date: Wed, 14 Mar 2018 16:35:36 +0100
Message-Id: <20180314153603.3127932-24-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:q5clH/C/IO+WhP9C8UaJcpuzrpjX1kDXrqST0VFeBKYqYbumufY
 WbxDYKUPNRD4Xd5COQN08M5BWeDBWt1OHzD6xicAU5s3BiSks+EdLrfL2k8Vy/o0ULxclDx
 q6P99945mT1MNfJUKDTK8P+4Q1AH0JiLZ+tkWak4T9B9cxKngxgoHPn1a4W9r1v8ai+3erH
 GF7UEr/bw4lFjGIH5OE8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+F01YTo18Vo=:oFGQZbBRgIPhZa24uLJAi4
 l7DOsWK4ZODWIWM7C1CramKcWak/oxqEbvwmPv3tqQlz0a6fInP8Mxq3+FhXqGN+kqKmdzHdB
 XmPw58E+Qhx0wGzsZsLAxznav5Y7AWbT7fLNMKtIAwo8IqeCtxWynoGw0MGb/IW/IHK5SPKnq
 3NxRsCRA0j5XWUZi3dymcdQqNx00VYSewQKElfdHeGNTk5WCVYQUeR6TtHSNKiaFJ6Wf5j8xG
 ApFSqvvc+hmk0W7DndfwgtCTwFJ3I/1XhEjJg6lxkZEv34S2coOds5k24FA8i9egMYgk4hP0P
 +jcOjimQoxx6Q8W3sPZVapO9S+3ua0UR+6X2RdOOTQy0FR+PR6Jh9qwyL3YDMQkDe5cfrdsLu
 rT7apU8+FMpO3ZomzFZSa8ivfPIs5EuoooiMdLYMQqTyDydRrEcaCGeKv6yuyVqkN0eqeCXH4
 LcqaJtu+xtNjbdbMeI/4iGqwaF51McpZaZiestBvsr5cdZYuBqggKBxo8631yxBNpxFrmtfJS
 DoPTy/D/2p580zMBywn6uou3dZeaL+MXeMDDmCn+d0yrDJA0ZRiLvDSAUnZYLY14AINEkUcGb
 U2m0cMdbMRbmGrb+B6SYp/PBI/IsygtarWyVniqpNIUh60qJNDPeSjO0xYDy4Q8F4nUF3k9e0
 syOnpfqx335slWfW8V0KtrehImU9xrxpoHNV1xJWLjGncwAZiMRVbEYxAGv7DTs1vWod4l2kz
 scO7T0hmWRGLCWbppiSsIg883gdhFmyOcq3isw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cris architecture is getting removed, including the artpec3
and etraxfs SoCs, so these cpufreq drivers are now unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Makefile               |  2 -
 drivers/cpufreq/cris-artpec3-cpufreq.c | 93 ----------------------------------
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 92 ---------------------------------
 3 files changed, 187 deletions(-)
 delete mode 100644 drivers/cpufreq/cris-artpec3-cpufreq.c
 delete mode 100644 drivers/cpufreq/cris-etraxfs-cpufreq.c

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 2e4495cf9aa8..8d24ade3bd02 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -102,8 +102,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 ##################################################################################
 # Other platform drivers
 obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
-obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
-obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
 obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
deleted file mode 100644
index 455b4fb78cba..000000000000
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
deleted file mode 100644
index 4c4b5dd685e3..000000000000
-- 
2.9.0
