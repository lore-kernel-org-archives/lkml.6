Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A226C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207892086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207892086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeKPPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:10:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:51665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeKPPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:10:52 -0500
Received: from localhost ([125.172.82.9]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M8NBi-1faefz2MZG-00vuQZ; Fri, 16
 Nov 2018 05:59:54 +0100
Date:   Fri, 16 Nov 2018 13:04:59 +0900 (JST)
Message-Id: <20181116.130459.1796034910024118091.teika@gmx.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/1] Input: synaptics - enable SMBus for HP 15-ay000
 (SYN3221).
From:   Teika Kazura <teika@gmx.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yh2f8Yu8M/fUqGdLMBHGaJX9oK3yV+O+yVQLOEv+Zg4XWuvTSen
 YdDk556NK8pnZlBs5yGMaEVZBc2L2GqXE6Fhc1Qrsb1aZay5PlAOMZ4AMfJKCMAxq8OQ2Bp
 hXrHDaVWf9+UxyrlLRJZ0KiqGbmqoROZi02nFZeZsILQcE9svj+eBb8/JiFlkEnk4YWH92t
 dxTDrRwsMKNpj4dM6idjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ZXuai/i1us=:EZS/FPXso41DSwUVTJXZ9i
 +NFEo1WSfyXzi9xpcRE3BK8FUgFdOJh8Oht0LZgqE+yXOLHmIe6bXuoLAOc+JZ6HHTLbFupSS
 ByO3Uq5gH8IXT0XkX17TF6A9yNF3YFiaFCB2GxiVyYVDGLc0RLwxT9/IFrv9GZlFyfQvt9S9N
 KEmxh/zyuGFa50ekWR3xug73T74mPJ+KhZPNJD/p6tK+yRpawF/qFo5tIDBkg+bZUfU+NGvU3
 sEcsBccl2p7LmUan+h1MmU+3OFhcLzIOYuopgQQTjs0DwLZ2v6nm5tgpae/qzKpEywucYIvCJ
 QXf32FzKy/iBgQ+VOaDA+I7Pl1uJcc3Ox/jpZRyS2B7EMuprmCp9dmQNvU5j1vo8/yaZfY98x
 dp9hxRWhxrOupEGdkpZ1vsL0tC68ClozWUauIYYFsQgDu1u3tttYNaRZSqoHTABoPrxQEceLv
 vT+ZjedChMLI6N1VV8uVhEnKk2MbxcfxbPp0+VdV7Bh6UdkDWTxlTEvC11Ik3MHk/6FHpmoQp
 ebnOrj34/8rjNwC2IFnVtLRvH4z+18meqhdt3VT4s2+yDiJ+PKlBdZYIHC9aomMdVUPsUi2ES
 97fas+GfLIopYejimuBVcjLsXkflTft80CBsdGXgKRvHrkg5zaloRR4QfStxPqLGvamRYsw4u
 wC8R6bKtNf/VNdBqqWHeSrAK64Wd/LBncBY0wTsXOpu/h9wict+JlG20zV680JRl42Vov3jAm
 E06Q85+6xxXZIpAeDZE6M7RvONGoUqjhuzYeh8eav6rSZL4B8LxoqjbQh03EJB2SLKMVVpRlK
 PyED5yRZmZl4Xqq2JG+kph2ZDUBGfesBdvu+MnlmY5q19ik+cCfUiyAoE6J/miWkt1Rt+eSyC
 yJzjDEuzquvAuVCBtJElv1qb54rYXhnEZOHaN9185jBBeM1r4qF4+0llgPAfT7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMBus works fine for the touchpad with id SYN3221, used in the HP 15-ay000 series,

This device has been reported in these messages in the "linux-input" mailing list:
* https://marc.info/?l=linux-input&m=152016683003369&w=2
* https://www.spinics.net/lists/linux-input/msg52525.html

Reported-by: Nitesh Debnath <niteshkd1999@gmail.com>
Reported-by: Teika Kazura <teika@gmx.com>
Signed-off-by: Teika Kazura <teika@gmx.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 55d33500d5..591b776f22 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
+	"SYN3221", /* HP 15-ay000 */
 	NULL
 };

--
2.18.1
