Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE2C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26F421733
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26F421733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbeHNAQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:16:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeHNAQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:16:41 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MYvnH-1fKgk12pBD-00VeFa; Mon, 13 Aug 2018 23:32:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Peter Seiderer <ps.report@gmx.net>,
        Jan Luebbe <jlu@pengutronix.de>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: imx: work around false-positive warning, again
Date:   Mon, 13 Aug 2018 23:32:17 +0200
Message-Id: <20180813213228.2834099-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:huaeqNRn3W3JyedO+eJjI0kMd4s579K3/5w3Ib+7MFNAI9NIEp7
 bP22M8bN1KfPzHlpnMbPD7xKzoXyMv8MlnweC0ugcDvgpmEz8lD5qt6ngGXLm7m6+Y44ZuF
 v6Q0Pt2Ok0u5wSHYMP/nDJ972ZiZ7iVud2X6cjIjIgInIxJZ4VvUBjTGNrWcrchQWg0q2XG
 t1ZQ11XGD/Z6Sm3+ziZrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LNVRkhu0OQo=:nsbbcGTO27wXHOZLnl2JIH
 Fxs135CSA9MCAtvudPhfVYTGXdO43XEs//eqASA4nM/RIT89IjKy4LN7aTArYxDQuDLRaJfUf
 NdtglAIiOIycomCnnr7AyxEtkEn6J3xvr04JJuFKzynnXSKBSwwF+vegUr3Q2lTUreGbSzb3c
 M12UMlgD8ttiLlK05Fk0v1xibozqimweXS7lOsHbGfx66fv92jLnDARKIP99pLRq2lDA625wa
 fzcQlYvCB3P1qdUxkY9OHp03Y2X1iuRhw2SlNelixU0k45vTYEpTS5X3EBQDMm/bvUF/4RFMz
 g1s6qbKHAnBe1GLRCIB5ONE6jho7TIqxKMeU9qH5yuILiXjOPlwTvnTa1s5IjMWXngY2nimZz
 dBiV0a/o6EGJnMt/RgfzIpzv5U+AoR7Firq1gVbJMsG5ILmaJooUMtm4b/RsA00ahw3LhPjal
 4zcOUlzIw4laHl/0tVHorKtFzGFkdXSRL56QimkoqGH0wOmLrOxUbREg5tOG8h7j3A1JFLU2j
 sVWbJIBFAvU/+pNyyIy72WdyZfGVKWJ2wbqXQantDPmpEZcRqink90ATPT84uDqIxn6N65SPG
 KbVPh8tY/W5/ByT1TYBB241fD7lYUdu6H7GaNt7DFYkIX5p9+2HEO8wg2K0dx5Iw19gZBLwV1
 l6g+7TwlTof/o/WCoou236FpQvwkXqmFHO5jqOodfdZ9bCwqC0/6NXIRWRisv0Bgw7Hs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning that I thought to be solved by a previous patch of mine
has resurfaced with gcc-8:

media/imx/imx-media-csi.c: In function 'csi_link_validate':
media/imx/imx-media-csi.c:1025:20: error: 'upstream_ep' may be used uninitialized in this function [-Werror=maybe-uninitialized]
media/imx/imx-media-csi.c:1026:24: error: 'upstream_ep.bus_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
media/imx/imx-media-csi.c:127:19: error: 'upstream_ep.bus.parallel.bus_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
media/imx/imx-media-csi.c: In function 'csi_enum_mbus_code':
media/imx/imx-media-csi.c:132:9: error: '*((void *)&upstream_ep+12)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
media/imx/imx-media-csi.c:132:48: error: 'upstream_ep.bus.parallel.bus_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I spent some more time digging in this time, and think I have a better
fix, bailing out of the function that either initializes or errors
out here, which simplifies the code enough for gcc to figure out
what is going on. The earlier partial workaround can be removed now,
as the new workaround is better.

Fixes: 890f27693f2a ("media: imx: work around false-positive warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/media/imx/imx-media-csi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index cd2c291e1e94..4acdd7ae612b 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -165,6 +165,9 @@ static int csi_get_upstream_endpoint(struct csi_priv *priv,
 	struct v4l2_subdev *sd;
 	struct media_pad *pad;
 
+	if (!IS_ENABLED(CONFIG_OF))
+		return -ENXIO;
+
 	if (!priv->src_sd)
 		return -EPIPE;
 
@@ -1050,7 +1053,7 @@ static int csi_link_validate(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_format *sink_fmt)
 {
 	struct csi_priv *priv = v4l2_get_subdevdata(sd);
-	struct v4l2_fwnode_endpoint upstream_ep = {};
+	struct v4l2_fwnode_endpoint upstream_ep;
 	bool is_csi2;
 	int ret;
 
-- 
2.18.0

