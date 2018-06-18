Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E983C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B5A208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B5A208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964886AbeFRPB1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:01:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964921AbeFRPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:01:24 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lwzrl-1gJ5Ry2bIP-016e7E; Mon, 18 Jun 2018 17:01:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sysinfo: remove get_monotonic_boottime()
Date:   Mon, 18 Jun 2018 17:00:38 +0200
Message-Id: <20180618150114.849216-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Q2e3/BUEmgOL9AGcI1VDjSZbKI35xoRwRN8xBJ2k1qF1dztLA0X
 Wp5qoIN0N7zy8J/GnQZecqC0rroxkEbc65TyMwchRSyDpgEDgCRId/fcgllK1VRXncUopA5
 R9vHno1+4h47mbrcsq0dQP1abuaAC3TQ3qhe7QgC0dmVPBzV2C3RvzGbjUsbcGvWfYSh1+i
 zkD0LtVYgcXfRDRVAA0kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mWU2enx82Ds=:1D7pAmVRLRvjNMulUff58b
 a+ar0rXfoC/F5ymLSRvW6s2o5k3cmlvvFwxX/9fd6oikyatvQraf8jd5bphXpXKz14YTYM6Nj
 d05w3bOcaYAc5Zq01kICCbnFE2n+2bHhKPjGs5vPcxEtQo2DyebcjemgpfP96YsyyR6xSWGEz
 USkYZHbbu75oNJ3cs/dDCWWT4+y/Ih2J+zQt+8M8vA/5mewFUYhjMUPi/2Mueo13JYUVEa3sj
 6iuULF6T1fvUf4ytcuxVhQK2hxOs3ah61aGiPuduiqu9ZPDjwaMHQ/tWJFZTkDahFEHGu9KNO
 YJ1aRKI2pgP17JvVzBeako/AU5m+P6/UbmQ2TyVQ/iQKlVXI9lUdm0g6GQxM9yrjuI46gHyOg
 gtBe5nuMXiojykuetaM9Nco2YOeHf0BM4nAzo8eiQKAJdE1JRZxNs6mxpH7zb3k6QaGh9XA6K
 sanke63FRwtWQYrnFglOUW9rlut/xXVrdKFPpK6U8mqok+Kb4F4w8LyKh+M+LLJzcD8waOu/D
 /noNq2T8lFNmp7Oqypa+NhUiO+dayy2FiMp8sWmWu9VR/40OMrvJJPhHGq/jAsMr/9uHs8atf
 6z+Smy+UHqdIgtyOHeBEbS8jtV5COZ6cWS69HTcji5wL9qcgXU9rg5zqfdNrc1YAy0oBki4s4
 SP3OBLjuDYUlSgjaJxVCFKU45Ay2cuetv3B5SXuCJ1D7q6xHbayDXf4XXRZ/fg37Y/is=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_monotonic_boottime() is deprecated because it uses the
old 'timespec' structure. This replaces one of the last callers
with a call to ktime_get_boottime.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index ccaeffa2171b..24f838da8ca1 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2574,11 +2574,11 @@ static int do_sysinfo(struct sysinfo *info)
 {
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
-	struct timespec tp;
+	struct timespec64 tp;
 
 	memset(info, 0, sizeof(struct sysinfo));
 
-	get_monotonic_boottime(&tp);
+	ktime_get_boottime_ts64(&tp);
 	info->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
 	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);
-- 
2.9.0

