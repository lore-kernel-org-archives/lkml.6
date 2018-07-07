Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30BCC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92D21884
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="BI44J8MV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="BI44J8MV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C92D21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeGGF3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:29:51 -0400
Received: from fallback16.mail.ru ([94.100.177.128]:52966 "EHLO
        fallback16.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeGGF3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Message-Id:Date:Subject:Cc:To:From; bh=YSzxZIni5lnLMO8hthf8om9qZgiFpJKFk4PPiRzVJ+g=;
        b=BI44J8MV2tJyd9apOu2McswYlscR260tL6+6ina00baA2AROoQ8/DwBSw9KDp7fLFCzKapvIefTH86ui7ZWWCrEJLPzkfwsHGwuVTj3rS/5GHejkKsRhzwJnegIhcwMz46PSDtN+Gd3i7XbwdCLEG4lzn0tj15LBlF9kHvEscT0=;
Received: from [10.161.110.10] (port=48666 helo=smtp2.mail.ru)
        by fallback16.i with esmtp (envelope-from <kitsunyan@inbox.ru>)
        id 1fbfn2-0003Ys-DE; Sat, 07 Jul 2018 08:29:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Message-Id:Date:Subject:Cc:To:From; bh=YSzxZIni5lnLMO8hthf8om9qZgiFpJKFk4PPiRzVJ+g=;
        b=BI44J8MV2tJyd9apOu2McswYlscR260tL6+6ina00baA2AROoQ8/DwBSw9KDp7fLFCzKapvIefTH86ui7ZWWCrEJLPzkfwsHGwuVTj3rS/5GHejkKsRhzwJnegIhcwMz46PSDtN+Gd3i7XbwdCLEG4lzn0tj15LBlF9kHvEscT0=;
Received: by smtp2.mail.ru with esmtpa (envelope-from <kitsunyan@inbox.ru>)
        id 1fbfmw-0002ib-E5; Sat, 07 Jul 2018 08:29:42 +0300
From:   kitsunyan <kitsunyan@inbox.ru>
Cc:     kitsunyan <kitsunyan@inbox.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics - Lenovo ThinkPad T25 and T480 devices should use RMI
Date:   Sat,  7 Jul 2018 08:19:12 +0300
Message-Id: <20180707051913.24035-1-kitsunyan@inbox.ru>
X-Mailer: git-send-email 2.18.0
X-7FA49CB5: 0D63561A33F958A5A1811A25CE8F8C187F377BA6FB89D38C7F8C361B31AE222B0A6AB1C7CE11FEE30A35B161A8BF67C1BA3038C0950A5D36B5C8C57E37DE458B4C7702A67D5C33162DBA43225CD8A89FDD013041C98CC2AB2D78188EE14988A9A43A3B36E652819043847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148F53FDB0A1CE3EC88B3B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: E252BC732A74C87F5C73C7DE684FA90FFCEFAC4FCEE6F4214ABA216FC6FC048C76D1B6BEECD16C279C6999534B19A478CA448B6582BF645E5B2433C9C15A0C96B0C09A45F598CAFDC7092FF7CD7CF138C001A007A554749AB4A721A3011E896F
X-Mras: OK
X-Mras: OK
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchpads on both T25 and T480 are accessible over SMBUS/RMI.

Signed-off-by: kitsunyan <kitsunyan@inbox.ru>
---
 drivers/input/mouse/synaptics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 55d33500d55e..be934a082424 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -175,7 +175,9 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
+	"LEN008e", /* T25 */
 	"LEN0092", /* X1 Carbon 6 */
+	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
-- 
2.18.0

