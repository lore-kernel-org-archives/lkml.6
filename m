Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424831AbeE1LUX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424654AbeE1LQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 263/272] regmap: Correct comparison in regmap_cached
Date: Mon, 28 May 2018 12:04:56 +0200
Message-Id: <20180528100302.258828070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 71df179363a5a733a8932e9afb869760d7559383 ]

The cache pointer points to the actual memory used by the cache, as the
comparison here is looking for the type of the cache it should check
against cache_type.

Fixes: 1ea975cf1ef5 ("regmap: Add a function to check if a regmap register is cached")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/regmap/regmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -99,7 +99,7 @@ bool regmap_cached(struct regmap *map, u
 	int ret;
 	unsigned int val;
 
-	if (map->cache == REGCACHE_NONE)
+	if (map->cache_type == REGCACHE_NONE)
 		return false;
 
 	if (!map->cache_ops)
