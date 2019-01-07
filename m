Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F48C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481D22173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="uCgY4BsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfAGUNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:13:36 -0500
Received: from mx2.ucr.edu ([138.23.62.3]:49673 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfAGUNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1546892014; x=1578428014;
  h=from:to:cc:subject:date:message-id;
  bh=NdKpoJfbcWZP6rBGXWSEedWUj6BFUZYqn7eq8HXskQg=;
  b=uCgY4BsSjc4zG/qpmwKo3tga+kU/1tLVFjKPFpvTkrizzYW0eiebpQtS
   EygJC4VZurvnVhUvOUVbzfyJk3jtQ8IXagQ+GrA6hSxvYoHzFjvZrVB5Q
   0XLndg+6i7JjYyhOFHDS8ThY1ZLkG5oWtfoJ5SsOEQoQ6exnm/qUQh8fQ
   eI6wgS0tIf2Y7uVD+ydB8JC9EmbQtlmgvdBR7/C5FhJ8GknjsHwbs7d3f
   YZbpDHtrXBdTXuSWaojFqZ8vAlCkdiJFbaJ8iur7PHZS6mP6TW9DM/Tue
   IHxnw5DTe6k2RR/dL2gZ9lHhMBykHggqpwRz0EoSPCNKw7leOHiI2UTNk
   w==;
IronPort-PHdr: =?us-ascii?q?9a23=3AaY+Y2BYFQPPjLSHXPZuhzg//LSx+4OfEezUN459i?=
 =?us-ascii?q?sYplN5qZoMS4bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUxJXwe?=
 =?us-ascii?q?43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRp?=
 =?us-ascii?q?OOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0AbCrGFSe+?=
 =?us-ascii?q?RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG81/9HktQPC?=
 =?us-ascii?q?TQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjm58axlVAHnhz?=
 =?us-ascii?q?sGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7deNIaRXFaXsZQUSxBDZ63?=
 =?us-ascii?q?YZUWAeEcM+ZYrpfyp18TohCjAQWhCv/jxjpOi3Tr36M1zv4hHBnG0gI+AtwAvn?=
 =?us-ascii?q?faotLuOasOTey41rXEwC/fY/9K3zr29YjGcgomofGJRb9/c8vRyEgvFwPYiVWb?=
 =?us-ascii?q?tIvoPjOU1+QNqWeb7vZsWf6hhmM8tgF+viKvyt0yhYbUm4IY01bJ/jh6zoYtPd?=
 =?us-ascii?q?C0VlJ3bNq+HJZTtyyWLZV6Tt4tTm1ypio21qEKtYamcCULzJkr3QDTZvKHfoSS?=
 =?us-ascii?q?/B7uVfydLDV3iX9jZbmxnQy98VK6xe35TsS01VFKoTdbndTUrXAN0gDT6tCASv?=
 =?us-ascii?q?tg4ketwTaP2B7X6uFDOU00kLDUK58lwrIpjpoTtVnPEjb4mEnokKOaal8o+uev?=
 =?us-ascii?q?6+TgbbXmooGTO5VohQH5N6Qigs2/AeImPQgSR2WX5/iw2bn58UD6QLhGlOM6nr?=
 =?us-ascii?q?TWvZzAO8gXurK1DxdQ0ok56ha/Czmm0M4fnXkCNF9EeBOGj4jzNFHPPPz0Efmy?=
 =?us-ascii?q?jk+xkDh33fDKJKPuDYjQLnTbirfuYa5961JAyAo01d1f45NUCrccIPP8Q0Pxt8?=
 =?us-ascii?q?LXDgU/MwOqx+bqE8t91owAVmKVGKOZM73dsUWO5u0xJ+mAfogVuCzyK6ttyeTp?=
 =?us-ascii?q?iCoImE0dYK7hiYoFaHm5Rqw9C1iSezzhjspXQjRChRY3UOG/0A7KajVUfXvnGv?=
 =?us-ascii?q?1k6w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AgBQCbsjNcgMjWVdFiHQEBBQEHBQGBZ?=
 =?us-ascii?q?YQED4x4iwxPAQEBBopbGGyFU4JwhnwBCgEBLIRAggYiSgEDAQECAQMBEwEBCQ0?=
 =?us-ascii?q?JCCcxgjopgl82UoEVAQUBNVuCRwGBdA2bZDyMFTOIWQEHgUwJAQiHbIRBgQ+BB?=
 =?us-ascii?q?4NuiFKCQwKBKgEBAYoehR6QcgEGAgGBXIE5jlAkgyKGXYdvAS2ZaQIEAgQFAgU?=
 =?us-ascii?q?PIYMzTSWBbAqBRIInFxOOLB4zgQeJewE?=
X-IPAS-Result: =?us-ascii?q?A2AgBQCbsjNcgMjWVdFiHQEBBQEHBQGBZYQED4x4iwxPAQE?=
 =?us-ascii?q?BBopbGGyFU4JwhnwBCgEBLIRAggYiSgEDAQECAQMBEwEBCQ0JCCcxgjopgl82U?=
 =?us-ascii?q?oEVAQUBNVuCRwGBdA2bZDyMFTOIWQEHgUwJAQiHbIRBgQ+BB4NuiFKCQwKBKgE?=
 =?us-ascii?q?BAYoehR6QcgEGAgGBXIE5jlAkgyKGXYdvAS2ZaQIEAgQFAgUPIYMzTSWBbAqBR?=
 =?us-ascii?q?IInFxOOLB4zgQeJewE?=
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="1053188059"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtp2.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 07 Jan 2019 12:12:53 -0800
Received: by mail-pl1-f200.google.com with SMTP id l9so740125plt.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 12:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EE5h6degJKpPRjRNKC3WOaHToYIlkncg20CLavTqYJ8=;
        b=hfBry4HYqWMlS8dOhKBng2BHi6g86YkXGfSglygQUzoSerw9g6pz3AlQIv+zlb8TJF
         ltEQ0/OhmJWJvp5XoqoxYiWl94hxJ39b2gufOUPWAbnueg0IwvaB0i68csAwRrqjBESC
         IwdN4cY97pcc9LX0+g6f6zRu5HOZP6ltJNfXeL7+OnXacpfIBmQ+otuJHc1TSJVWMf5H
         95bXU/qmugwQhFX1ubDqWZ90bgAjkCw16ZUOziZjGtiw3O25szlf9JF3dvJ4E4Y6lvhA
         70JsrhA9eUMQnn5kKbgop3wh8tk6Q4GjEO9Aa7MuKenzeT4myzB7700xXWDxVbI5xgAl
         WNfA==
X-Gm-Message-State: AJcUukdbVmeRgOfR4KeGpbtvNs9R9I77RTxrTUwWGonbD1fVTno7nGnT
        agblMwLXxXDm4qKrne8XFxoSJcbOfLflQI66arrGLA/+IziXclOXxBOc/womJ+Z05o4lRH8oCfE
        KvaYCRnceJEjsQvi0ZpqHdeiNtg==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr62299867ply.132.1546891973564;
        Mon, 07 Jan 2019 12:12:53 -0800 (PST)
X-Google-Smtp-Source: ALg8bN71tEseuucLL61wMFGdPFfhHlAAvxhvjWPzDSNdWh6iP+nZmOOeQgS37g6GGtn6dVSRDcJ4gg==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr62299849ply.132.1546891973247;
        Mon, 07 Jan 2019 12:12:53 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id u29sm93112997pgn.23.2019.01.07.12.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 12:12:52 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt274: Variable "buf" in function rt274_jack_detect() could be uninitialized
Date:   Mon,  7 Jan 2019 12:12:32 -0800
Message-Id: <20190107201232.19464-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rt274_jack_detect(), local variable "buf" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used to calculate "hp" and "mic" and
make their value unpredictable while those value are used
in the caller. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt274.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 8f92e5c4dd9d..332a3e955bdb 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -353,6 +353,7 @@ static void rt274_index_sync(struct snd_soc_codec *codec)
 static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 {
 	unsigned int buf;
+	int ret;
 
 	*hp = false;
 	*mic = false;
@@ -360,9 +361,15 @@ static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 	if (!rt274->codec)
 		return -EINVAL;
 
-	regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*hp = buf & 0x80000000;
-	regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*mic = buf & 0x80000000;
 
 	pr_debug("*hp = %d *mic = %d\n", *hp, *mic);
-- 
2.17.1

