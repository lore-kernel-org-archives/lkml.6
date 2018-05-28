Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034108AbeE1K0D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033864AbeE1KZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:25:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 264/268] regulator: of: Add a missing of_node_put() in an error handling path of of_regulator_match()
Date: Mon, 28 May 2018 12:03:58 +0200
Message-Id: <20180528100232.783888805@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 30966861a7a2051457be8c49466887d78cc47e97 ]

If an unlikely failure in 'of_get_regulator_init_data()' occurs, we must
release the reference on the current 'child' node before returning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/of_regulator.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -274,6 +274,7 @@ int of_regulator_match(struct device *de
 				dev_err(dev,
 					"failed to parse DT for regulator %s\n",
 					child->name);
+				of_node_put(child);
 				return -EINVAL;
 			}
 			match->of_node = of_node_get(child);
