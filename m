Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeFDOAt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:00:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58870 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeFDN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:59:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180604135956euoutp025601df829a564a5a7cae2291b9be2ce3~0_cSu2vvU0825308253euoutp02H
X-AuditID: cbfec7f2-1dbff70000011644-87-5b1545db470e
From: Maciej Purski <m.purski@samsung.com>
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 7/7] regulator: core: Enable voltage balancing
Date: Mon, 04 Jun 2018 15:59:24 +0200
Message-id: <1528120764-14316-8-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7djP87q3XUWjDWb/ELeY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBYLXt5isVh75C67xf4rXg4cHt++TmLx2LSqk81j85J6j74tqxg9
        jt/YzuTxeZNcAFsUl01Kak5mWWqRvl0CV8bpZzeYCnaIVfz8sI61gfG6UBcjJ4eEgIlE28yV
        jF2MXBxCAisYJVZu6maGcD4zSlx//5UJpur/5W6oqmWMErf63rBCOP8ZJZ7+/s3excjBwSag
        JbGmPR6kQUTAVeJ7z1kWkBpmgRuMElcOnWcESQgL2EnMOT+HBaSeRUBV4s47sHpeAReJEyeP
        MUIsk5O4ea6TGcTmBJrzdvYmsMUSAlPYJBacvMYKUeQicbJxMTOELSzx6vgWdghbRuLy5G4W
        CDtfovXZY6h4hcS+3tNQvdYSh49fBLOZBfgkJm2bzgxyj4QAr0RHGzRYPCQ+Xt/CBPHjPkaJ
        pmXfWCYwSi5gZFjFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRGI+n/x3/tIPx66WkQ4wC
        HIxKPLwaVqLRQqyJZcWVuYcYJTiYlUR4T1sAhXhTEiurUovy44tKc1KLDzFKc7AoifPGadRF
        CQmkJ5akZqemFqQWwWSZODilGhiN7pzuNgy4srpxwp7dE/Ztz8x4+7o+/lHZUXcLw7hr+5ZO
        ea4pWfVa7sS77vTVc3vXuXvknDp5ZluReXO+yvHddq7R77gfHNscN+WC5ZMV1vWJz5J+z9kg
        89xN8XBCx1LrdSbHUi5e3rO2yeVN4yIV1uCmqEZPX4Pev51LzrKkrp4uyzBjjts3JZbijERD
        Leai4kQAzdRYlcMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4Nd1brqLRBtc/GlpMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+FosFL2+xWKw9cpfdYv8VLwcOj29fJ7F4bFrVyeaxeUm9R9+WVYwe
        x29sZ/L4vEkugC2KyyYlNSezLLVI3y6BK+P0sxtMBTvEKn5+WMfawHhdqIuRk0NCwETi/+Vu
        xi5GLg4hgSWMElfP97BBOI1MEv+engByODjYBLQk1rTHgzSICLhKfO85ywJSwyxwi1Fi/auj
        LCAJYQE7iTnn57CA1LMIqErceQdWzyvgInHi5DFGiGVyEjfPdTKD2JxAc97O3gQWFxLIklhw
        ZRHzBEaeBYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJDaduxn1t2MHa9Cz7EKMDBqMTD
        22AjGi3EmlhWXJl7iFGCg1lJhPe0BVCINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTE
        ktTs1NSC1CKYLBMHp1QD47Rv0y/xidlO8GGSja+ZJvlqr/HtlyZ892+bFAa5H3wwca6E/4Hb
        t8t6g7X+sWtve7Bi/hGHF37bKtj19PacfWN8ZalqNOtN0TnXX/C8/3n1UZC5k5fa/iOvU7ZU
        FW1OVTwQanUz+XfhmSkMOh9aVrzu3LakNeDgzNiY1hBnoQWzZrzpTDPQXKrEUpyRaKjFXFSc
        CACZGD10IQIAAA==
X-CMS-MailID: 20180604135954eucas1p2bebd1c4970401bb957da228056f9a662
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135954eucas1p2bebd1c4970401bb957da228056f9a662
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135954eucas1p2bebd1c4970401bb957da228056f9a662@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call regulator_balance_voltage() instead of set_voltage_rdev()
in set_voltage_unlocked() and in enabling and disabling functions,
but only if the regulator is coupled.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2a7ffb7..2dd1f99 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2296,6 +2296,11 @@ int regulator_enable(struct regulator *regulator)
 	int ret = 0;
 
 	pr_err("%s: %d\n", __func__, __LINE__);
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
 	if (regulator->always_on)
 		return 0;
 
@@ -2307,6 +2312,9 @@ int regulator_enable(struct regulator *regulator)
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
@@ -2417,6 +2425,8 @@ int regulator_disable(struct regulator *regulator)
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
@@ -2470,6 +2480,8 @@ int regulator_force_disable(struct regulator *regulator)
 	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
@@ -3031,7 +3043,16 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int old_min_uV, old_max_uV;
 	int current_uV;
 
+<<<<<<< HEAD
 	pr_err("%s: %d\n", __func__, __LINE__);
+=======
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+>>>>>>> fcbf6fa... regulator: core: Enable voltage balancing
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
 	 * voltage for multiple frequencies, for example).
@@ -3074,7 +3095,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
-	ret = regulator_set_voltage_rdev(rdev, min_uV, max_uV, state);
+	/* for not coupled regulators this will just set the voltage */
+	ret = regulator_balance_voltage(rdev, state);
 	if (ret < 0)
 		goto out2;
 
-- 
2.7.4
