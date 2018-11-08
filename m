Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681C6ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3138720818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3138720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeKIHAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:00:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:33573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeKIHAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:00:42 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MDhny-1gI65u2mZK-00HBFL; Thu, 08 Nov 2018 22:23:21 +0100
Message-ID: <1541712198.12945.12.camel@gmx.us>
Subject: kmemleak: Early log buffer exceeded (525980) during boot
From:   Qian Cai <cai@gmx.us>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>
Date:   Thu, 08 Nov 2018 16:23:18 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:StJXaC+gu7kN10p5WMEzRAfycMzoxEgxYeLbWdYVXTbqPxyts/A
 H/kPc8kHsM18o2XMpe9d9qZNNUu0tZc9Mqboevi80IKIpmd77ybkUwwfGWhhDI8i+Q97pON
 Y0jTAzlQ6msPUPUAAbbAlCb1Pgjh9iCmUUZAm5yLmYVTJRyGCObyZ+WAk+BlwmPKTGVJcmp
 QAmNxXH+Wlez5KTSQsJPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:08BI51Fcp4U=:epn0fQcG36VNDiCxJrQhHr
 /fzz8WHYzFxP2CYzngNvTg/Terq05zqZpZZhcC45aC3/WlPIjgXGpmG3C67A+UQXW6H5C6ZI3
 RBkqa8/Jv+0vaFADX6bg+t/cN2BGRtvUsJoOGagEYydwf+azIdvp07O9QKdl3uIsvUNRqVgWY
 XeH5ODMWt6xofyFbwTcFEiOs7VBvVtLJAn9YzyGWw6snu5k8oXs2rMoV9+kBUsLzfeM9+s2qm
 UO8+QFsRslBTbTgPYxhjLj9TbJO/VK2GdGsLmw+rKBMmszQNCoU1+1481mh3hEoe9Z8DkW9Mc
 KY6IhmNFs6tTuFTEYPc4ktlRSV6rXk+a2g7kxRoQAa7YboQzT/l3Rdp3A1fpSftFQcQRElqnt
 jCK2dIZ+4tzeVO2Ou88o0f681VwANdgfiUWWWwKBhJ4jxQ28pN2VKNRw8ps0NEi5tiMW+zooc
 VwqSxrNE0oaiP2meuUksx1bi4Xvz2xe/sMfcwehPUoz6BXczbQdnbpF5wEMYGlrIuGQ4sV37p
 ZGVG8yC/cL38BCV5ZdZ2kXnXcH9pjq5Om2i3hqMEHoEUD9+tiK0pZGXk/Ed8PNFyIIwTukxzB
 yMewXUoxENru5/Ipo4zFKPhN1PJ6erntRQDqjBdjMCV2S6Klr1dm501mZJ6h7996/0uHHUOPL
 MKbUHUuXnQzEAfym+ASRAQkuY0N8+LUuJDBXy1lJwANtck0lUqpvo2jWR4sef9iSdsoU+mWLh
 EK9uLvRTcdMNiN0TK/zlOc/aTYVWEVbyly7uLS5OZHHwbAQ2xMMtag/yiNTy7V1i7Xt0By0eO
 f2HNvzOK5eBn4OxRHHCKB918Wy+kXnlJKU+Ca5QMtKJa8/VxYihrFie1608GfUYaRVblqLcIt
 ofhog6fTV9LvfVBVgv1Ji5dZbBVhcD+8fdc1wVtIjMdNsY/+OFQTT/DK1T1WSY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum value for DEBUG_KMEMLEAK_EARLY_LOG_SIZE is only 40000, so it
disables kmemleak every time on this aarch64 server running the latest mainline
(b00d209).

# echo scan > /sys/kernel/debug/kmemleak 
-bash: echo: write error: Device or resource busy

Any idea on how to enable kmemleak there?
