Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeFDOAu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:00:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58865 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbeFDN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180604135956euoutp02818352dacca5e3be33b873c8044f6814~0_cSXXxg20724607246euoutp02i
X-AuditID: cbfec7f2-1c1ff70000011644-86-5b1545dbaf34
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 6/7] regulator: core: Lock dependent regulators on
 regulator_enable()
Date: Mon, 04 Jun 2018 15:59:23 +0200
Message-id: <1528120764-14316-7-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7djPc7q3XUWjDTpWMltMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK+PB8hmsBV08Fe86v7I1ME7j6mLk5JAQMJHYcPkp
        excjF4eQwApGiZX/rjODJIQEPjNKtH8VgClqXHyQCSK+jFFiygaohv+MEk9//wZyODjYBLQk
        1rTHg9SICLhKfO85ywJSwyxwg1HiyqHzjCAJYYFwiZ09V5lA6lkEVCU6T1aBmLwCLhLb9glB
        rJKTuHmuE+wETqAxb2dvYgQZIyEwhU3iw5G1TBBFLhJPe+5C2cISr45vYYewZSQuT+5mgbDz
        JVqfPYaKV0js6z3NCmFbSxw+fhHMZhbgk5i0bTozyA0SArwSHW1QN3hI3Pm1jAnixX2MEk3b
        l7FNYJRcwMiwilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzAST/87/mkH49dLSYcYBTgY
        lXh4NaxEo4VYE8uKK3MPMUpwMCuJ8J62AArxpiRWVqUW5ccXleakFh9ilOZgURLnjdOoixIS
        SE8sSc1OTS1ILYLJMnFwSjUwhrdlH0vX/Ke48trzwva192K+M7z892pvSsThqLXbLic8OsN4
        k5HtkvGKSVcVr4etyGPTmVgTtk8oIPRqgqcC3+PFv0QXHn/yfOWP8kKJpLNsNmE7Dpn1FEhO
        U5IOODFlo5HsnG0NJpyGIo+2djPKtPxXm6Pp5ifuGDQvy6R6ympb1zRuuQPJSizFGYmGWsxF
        xYkALtlBlMACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42I5/e/4Nd1brqLRBlfPyFtMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK+PB8hmsBV08Fe86v7I1ME7j6mLk5JAQMJFoXHyQ
        qYuRi0NIYAmjxNEPm9ghnEYmiX9PT7B1MXJwsAloSaxpjwdpEBFwlfjec5YFpIZZ4BajxPpX
        R1lAEsIC4RI7e64ygdSzCKhKdJ6sAjF5BVwktu0TgtglJ3HzXCcziM0JNObt7E2MILaQQJbE
        giuLmCcw8ixgZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGEjbjv3csoOx613wIUYBDkYl
        Ht4GG9FoIdbEsuLK3EOMEhzMSiK8py2AQrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmk
        J5akZqemFqQWwWSZODilGhgLnpvIWimbsOax9n5mPVg265jZEtc565++XFlVarMjQTK6jUPo
        SNu+1G39XFIXP85ewlPw/62g9I3WNd4z2XaHZ7jsFt74Z0mrPfvBjOvdUyd7Ggcfe+w7t6qa
        k1c6q7ulb39NqMjPCRGzjnpOzGyeE9fwxjw2pvHx1zD3FsavP6dN+5h/X06JpTgj0VCLuag4
        EQBXOTDzIAIAAA==
X-CMS-MailID: 20180604135954eucas1p2eeb77ada3ca97fecc6caec20d7e8397a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135954eucas1p2eeb77ada3ca97fecc6caec20d7e8397a
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135954eucas1p2eeb77ada3ca97fecc6caec20d7e8397a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since regulator_enable() might now call regulator_balance_voltage(),
it should also lock its coupled regulators and suppliers.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7c57268..2a7ffb7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2305,9 +2305,9 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	regulator_lock(rdev);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
-	regulator_unlock(rdev);
+	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2415,9 +2415,9 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	regulator_lock(rdev);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
-	regulator_unlock(rdev);
+	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2467,10 +2467,10 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	regulator_lock(rdev);
+	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	regulator_unlock(rdev);
+	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
-- 
2.7.4
