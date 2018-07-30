Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DBB13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C7E20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C7E20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeG3NLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:11:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:33249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeG3NLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:11:03 -0400
Received: from localhost ([60.39.96.235]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Ma1pn-1fOrOX3oJ5-00LnZ0; Mon, 30
 Jul 2018 13:36:27 +0200
Date:   Mon, 30 Jul 2018 20:35:27 +0900 (JST)
Message-Id: <20180730.203527.1651668819503376656.teika@gmx.com>
To:     rosenp@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.steffens@gmail.com, waltercool@slash.cl
Subject: [PATCH v2 1/1] Input: synaptics - Enable RMI4 for Clevo P870DM
 laptops.
From:   Teika Kazura <teika@gmx.com>
In-Reply-To: <20180730.201359.525452745785453302.teika@gmx.com>
References: <20180730.201359.525452745785453302.teika@gmx.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dO5T1eOFjVJFhEN/pMXPE+EGyUQO+jQ+OJ0996CMTO2Sco6HZpt
 iZ3jRQ44fJfQ0o9eaG77YTQi/EgL+OCIMhz23kDMqm6bwYChVWpiU3OC+B507z3I5znsJ3m
 9NezsTRAzW0TEjTJD2Gpag9qU0uRne/+bTeEDo6HRdk/Kdjt7XRz6DLnic/4IrH5zB7RUgM
 IupYHyB//bVJZb5BDk/RQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o837KEVaoRc=:2LmvPz0T96v13RwJNskGUF
 9toS874oOpJ8yqtp09cR6wt+L0oxBckTkvioOMck1crHYJBdH4gkyXKdg/sj9cZYyfCdcLXIS
 kOgQPmUqbmFORpN+Cc8zfEoTkrAdrZ44V5uY0T8Kg6Ql6nm3I3/bt0HSTHJPjlNwG11FSXYDD
 WMH3lApfeBo9Lp4frBK2r7OeEIV7iRg8PqGSEihAMreqGPnyrMr5LrXo31ZqwFuH5OpTnv38D
 VI5+YzD57yFsujWgNDblNlYTkx9LDn7H3QRZeJ7HOQ7Df3HZC0XRNmyhcjkTJataWBVbGZTpR
 OfrhjKup0zDQkmsxcO0x9mYB4wwbHRuIiQZyppot8cMsjeGGMhy9AvepVQ6BboQ/SRoD7n81s
 YfIoJ214pk+zeg7wtl8gaGIhrSyDHaPnnI986VtKDulODKzTFuThp30QhS/400aWVFPwhZaBK
 U1/TGpJg2s9X68YslT2P5ojjw46n0Xa9MXDH/bgYkKTdv9zFomWHomYptbdzAOhEaZm8M619b
 2d6x21tijvI32XEl66PmlP4AU5+wzunKu1xCYPCPwBWj723j7WbykP/uom7cAl2hQ6otpdzdC
 2aIuaPxMfCNih3FwZhABJb6S/hu5qb/pWikXURM61UOM4wX5hw3YOlIEQcXpxHmjQyeIRWadT
 IT++TqH2lb+ihoXkQL7qOMuCwuW4C60Q6sbctyrtDD0sImx/7whGRGccGYH61+U8SyBO+17Yp
 CIyw29CwQ6ySm1bNscahk91FCcgh0yaMK9oaPtjYclPuvCjdlDpiSdKOKUIk1vSF8gnGjHb9W
 RvqjDGk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables SMBus/RMI4 for PCs with SYN1219, e.g. Clevo P870DM etc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Co-Developed-by: Teika Kazura <teika@gmx.com>
Signed-off-by: Teika Kazura <teika@gmx.com>
---
drivers/input/mouse/synaptics.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a9591d2..0669770 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,7 +179,7 @@ static const char * const smbus_pnp_ids[] = {
"LEN0096", /* X280 */
"LEN0097", /* X280 -> ALPS trackpoint */
"LEN200f", /* T450s */
+	"SYN1219", /* Schenker H506 (rebrand of Clevo P651RG), Clevo P870DM */
NULL
};

--
2.16.1
