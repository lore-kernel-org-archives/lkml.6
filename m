Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C22C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255FE20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255FE20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeLJUri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:47:38 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJUrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:47:37 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M2OEq-1gSchP17fC-003yef; Mon, 10 Dec 2018 21:46:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-card-utils: fix build warning without CONFIG_OF
Date:   Mon, 10 Dec 2018 21:46:10 +0100
Message-Id: <20181210204640.2407929-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TaKrS6bVFklw/uV/eUdapwird9EwOGcPBDAbySiL0Fsc2VFkRlU
 857KuIQB+T5uHi1WMqMcwjRP+nwnbSiKf9weUp7c89UQmhMvaINs2oRkykiuZyUcriix4iW
 NtdWfk7vefHPsvzXELA3sZS1d0kSgqBZCBCSaYORaATb6ElOo2aNck/9t3lr7WML9snSSWl
 rX8JFBoCLfrAsethXJ3Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rfqArJOtWeA=:AMeeuePRcfqRbWvJCDPtoI
 bTeYkccbUBKUOoPYIAOhsRqm9Aca6ETMIGDeR3QwFJRufuQiPgu2P9yvFdkSVN71hxJ48/Ymy
 wxPdx6fPi72P5JMC4J8meSUZGQSJ0sayIO83LrG4lstUjitR9RRZIHLssKz/ahCuAR2G/gEDf
 Zi5Di9/LHdIdPr4z5ahJNFXcGOAqFrIU7+4QpEmzrwNiBZhNlXg15+b9oGQKvX/xosoAilq18
 6zTBCTl8WBVDsm9AXK9A8zEKFamQEetC05vgOFJYIJf5eSSV/fCGjIYwftc1UO4GUte/5ceqJ
 9306UXd+N/c5UEfjfzE/qpH9skBUHtyOmt9hW0+S/eTGPSj4k45DxJxQWVToNFRWqirhCev6F
 zuBNr3/xUPC5OHXLMaegzjRBIzllPnSYzK85HT5xKKvCRA3DqFFSJbfNgWPp5vLCeBiR2V29H
 4JCEchW3nWNJDN96gTlBQx7UDsDj/yP2tNg0FFNyQJ6MCk/av+LYl2UDNrWe5VgDzldPnwado
 Iqs9n9zA3QPQN+1qfNvZiHFHDOlBPdGZ9yjiC6kv4O6L/xLBmBOW+CtH26lv0QJFQjHT3T5Cg
 bhYvjD134TP6xG21TC0rrug3+D2e9IsKYrOVqQIrWmqJf8XkfLMfsXzAw6boUF3kFnH7ErjFs
 2lTGhDZ0UiZ5o0yP7QQn895W09dagzPMPXgNbIg+9+TxG7Agzj5lHczM9YlyGBKWu/nqVLVss
 lOnFoAJGYXmlkoKWOjeYuWAuOrtxL1HSP43woQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF is disabled, of_graph_parse_endpoint() does not
initialize 'info', and gcc can see that:

sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_card_parse_graph_dai':
sound/soc/generic/simple-card-utils.c:284:13: error: 'info.port' may be used uninitialized in this function [-Werror=maybe-uninitialized]

It's probably best to check the return code anyway, and that also
takes care of the warning.

Fixes: b6f3fc005a2c ("ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/generic/simple-card-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 6a31d07976b9..17d8aee43835 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -280,7 +280,10 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 	 * Non HDMI sound case, counting port/endpoint on its DT
 	 * is enough. Let's count it.
 	 */
-	of_graph_parse_endpoint(ep, &info);
+	ret = of_graph_parse_endpoint(ep, &info);
+	if (ret)
+		return -ENXIO;
+
 	return info.port;
 }
 
-- 
2.20.0

