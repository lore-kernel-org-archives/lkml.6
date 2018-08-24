Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72648C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FEE2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FEE2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeHXIlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 04:41:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:40733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbeHXIlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 04:41:18 -0400
Received: from localhost ([60.45.10.218]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lyi0B-1fvUk40ubX-0166Zg; Fri, 24
 Aug 2018 07:08:15 +0200
Date:   Fri, 24 Aug 2018 14:07:56 +0900 (JST)
Message-Id: <20180824.140756.2287821275533434713.teika@gmx.com>
Cc:     kitsunyan@inbox.ru, benjamin.tissoires@redhat.com
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: synaptics - Lenovo ThinkPad T25 and T480 devices
 should use RMI
From:   Teika Kazura <teika@gmx.com>
In-Reply-To: <20180707051913.24035-1-kitsunyan@inbox.ru>
References: <20180707051913.24035-1-kitsunyan@inbox.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iW5lJnzIKk7dmb8GhrFXTRIPVJtQFShhEfdJ54pY3yrD8EP86nI
 Kbgtgmbmk2+eshaiXEk2Y8q3WhXbqi0S8ZO4VmXxxzo8OfGOML2xJgQemiLDzr4rrqUoIGD
 zhxzrxYNPP0rnTBXq0e2MH5HayBUCqJi9Tai4MP5AC5gtnYAlCXhFDEseT9321VQ2YsD+KV
 wUmJNyjDLGHB4mH628Ygg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T8nOSgQOreE=:RtFrzVeoJppz8d7Y8ry7as
 BkrOsT3rT1aL6m+HtedP3hWXe9r9WrhIo6v67D5JiXYGBJvasqnRiLMO+DQNNMumFmvRcXxuj
 yvXt0TlJVwL1C5h3UCZvlaENX8ZINQhSnee9c7EYkFkQ87yJXVeGXb6NYTCldp4QqegwQq94F
 kW3/mrm3csF5LXcEV/YioIaaKOjih1JEvuPlmwN9/KDLhVJJ4pvLaWE4xkhZuywsUwKsOSN1d
 ASlPZaqa6hq4FGi3aAKJcKavPq5eBBA2Ph9524qWwO+wVPRq0IHDj/ZeoQg6S+pJLkERKu4wy
 OoNG45e3UrWpjYTg2Pf0xwL1QRBevRSH4J9rAvuowxlxQf3bU6B8cLjwPMHkIWHg3xu5cMVCG
 JrzJi8w06bNVOMDqREsfDwadF6LkVO4r/HH113z+fnvegm9SjFiu+4+En1ONG7mhnqZOMzPRc
 NXoh8G0TutC2AFyhZp9OlzG8WhY5zqAkmUeoxp3cyLXbUXpTqw7HpIyDdGiU7fVY5PuGYfxoJ
 s+KGftkJayjCbML8YthpiJmsJECn0k8bT3jRepqIICWg6494uwH4/RRupWDNsxKXglqlZqtWf
 apfxehNBvGSdWA2v+CmIQdGqM0FRHZBXwlIO/KN/6xkscrq82gLMmvIE7Wt+M0WzzgqDLSQVX
 Qur2c6MECrO4ya4XqBrn1AkVRPfyziUgXRRQ5iQBFZf96hNvokNFrifwa3QaIoOuCablwL+fq
 Ug8+VFLasTE7ZZ47434eE1TQMiw+dLK5cxS+KrKzTfDS7pDmSedE/ppti/AoROqUy+gNq/OtS
 gYIfKeb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchpads on both T25 and T480 are accessible over SMBUS/RMI.

---
v2

Only a tag change.
The original author wants to use a pseudonym, and agrees with the usurpation of the signed-off-by tag. See https://patchwork.kernel.org/patch/10512751/

Reported-by: kitsunyan <kitsunyan@inbox.ru>
Signed-off-by: Teika Kazura <teika@gmx.com>
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
