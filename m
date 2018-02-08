Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeBHUoB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:44:01 -0500
Received: from mout.web.de ([212.227.15.14]:51147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbeBHUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:43:59 -0500
Subject: [PATCH 1/3] drm/amd/powerplay/hwmgr: Delete an error message for a
 failed memory allocation in three functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>, Eric Huang <JinHuiEric.Huang@amd.com>,
        Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1e5850db-c07f-add1-919a-be29be9c553d@users.sourceforge.net>
Message-ID: <29e72072-809b-9e8c-8087-0daa9665430d@users.sourceforge.net>
Date: Thu, 8 Feb 2018 21:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1e5850db-c07f-add1-919a-be29be9c553d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:bsaTw6T5qyx0f44FctA2YX774LUYej5K0UvP5lPK7SnSK6vL1gO
 ziZwAx6P7JEPD0wCkmzlxu9wiQqAZGWBV05jtX9Tk/pBwWhWjdV2Q0xWMK7LVV7aBrNtEVQ
 Gu6SYVR2W0pO+CyC4rq1X7tLlOZbKQqjKwfCoKfofrOsEZO+jhL0QuwHWsoF7eEQ01U/xZJ
 wRtUCcNd1i4+OTsQRRQXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iOqXZYEc0Lg=:IXBTUchctKz0K9x/VBmxg7
 cRaij2x+BAXXICLUn8zOVgRsB6Sy+1LWcGgQuvslXNrRYUgcQDaLBrZWuPYjSLK3zfsiSGAn9
 7W7K63fpYTyng+aJ0FbPKeOmCkggt1tyEuYjd/t8IkQ/Q5JBj3GJX8PEdgdVkJ2PfspQ13u4p
 r1A2krbstI60Bmsrh0RlyW/j0Eq7PCtzT8BP9UjuP0HFihN8TajMmP9SI5pH4RB0lAiVz4jIq
 E0A/yAFY/FSd0e4out+N3epdHSicSTXcPEGJHqjUFozfT9fEnl1Z3ikPOex6si3YIXv5niGnd
 amNQwABLcwJ/sDICs6gvBZT58qCcFJcj+DqoJsowBPuSDTRUIKlhU386c2fWdWfp222n2JUWt
 fijvGMkGHAIVg73OwiKRmoRme0bCw8Qf5VxswQ6UBcFakQkm1GVX+fBesJavSDx1WVJrabayj
 ocyo9KGsJb5o5fmsWpea0zsMngBDYJ6UuoBe2SuC7j5z12e7eHeZqQIxQWOhUWmWbcFIqDGLF
 eOJEnct82jsl9kFZ1euSfs7KXMtMgQNzMoZHabK9VhZRZrRzMzRWElRLdAobkcu1L7NzSLtPq
 Nz8BFunPYDKRq+oEhWJxvzvCtF6scEXKZrAvyQ4ZLQ/ANaKKWqR9RZX9PvbL8hZhrHVUcNZGg
 Mxpjf5ahyCGlWokUGq59ymNLJbd/OZt4ZQuGS+nV9/iPZuYupJf7p4DfMSROFlh+7rr3+kDD4
 wuVrRelYCmBr67f+wS7J3qSuNoOdFOqdaSxujvllnJ90A9RPPiVh4bvc4TglgNSZ94h92yKE0
 HiSLIbsozWGStOd4477MMJElYGSWOp5gZ8XsAaGPzKao9qEPxg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 20:32:39 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c | 4 +---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c    | 1 -
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c | 4 +---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
index b314d09d41af..c0699b884894 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
@@ -286,10 +286,8 @@ static int cz_init_dynamic_state_adjustment_rule_settings(
 	struct phm_clock_voltage_dependency_table *table_clk_vlt =
 					kzalloc(table_size, GFP_KERNEL);
 
-	if (NULL == table_clk_vlt) {
-		pr_err("Can not allocate memory!\n");
+	if (!table_clk_vlt)
 		return -ENOMEM;
-	}
 
 	table_clk_vlt->count = 8;
 	table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 0229f774f7a9..ded33ed03f11 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -815,7 +815,6 @@ int phm_initializa_dynamic_state_adjustment_rule_settings(struct pp_hwmgr *hwmgr
 	table_clk_vlt = kzalloc(table_size, GFP_KERNEL);
 
 	if (NULL == table_clk_vlt) {
-		pr_err("Can not allocate space for vddc_dep_on_dal_pwrl! \n");
 		return -ENOMEM;
 	} else {
 		table_clk_vlt->count = 4;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
index 569073e3a5a1..967b93e56113 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
@@ -107,10 +107,8 @@ static int rv_init_dynamic_state_adjustment_rule_settings(
 	struct phm_clock_voltage_dependency_table *table_clk_vlt =
 					kzalloc(table_size, GFP_KERNEL);
 
-	if (NULL == table_clk_vlt) {
-		pr_err("Can not allocate memory!\n");
+	if (!table_clk_vlt)
 		return -ENOMEM;
-	}
 
 	table_clk_vlt->count = 8;
 	table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_0;
-- 
2.16.1
