Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeCUTN6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:13:58 -0400
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:23344
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752796AbeCUTNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:13:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de
Subject: [PATCH 2/3] EDAC/amd64: Only remove instances that exist
Date: Wed, 21 Mar 2018 14:13:34 -0500
Message-Id: <20180321191335.7832-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
References: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:405:39::39) To DM5PR12MB1913.namprd12.prod.outlook.com
 (2603:10b6:3:10d::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79fb34a2-cf11-4249-8375-08d58f5fe165
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1913;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;3:q7UGS1z7CyAeQvnjXUAWtZQtEeGHgt6IFEgRDu0vUC5eZdcfpaT2CSgX5yzOGu9qcIG6BDdd7tvg3h39tRdN9dlk+/GX1YMjbCnXr6LjJUIAIHFgl1JDbw1sAsU091wecShOzrhwApduuoxOjfgxkfoulcW8AY3qK73KumumIo+3bj2ZvsAnhuah8mxwMCLkYwo0y5KztXvyR8f1ms2kMbNmAWQwQ3nRiS6M7y5Sf7p5LQvs/eJWpj5RmntDTuvf;25:GqYCwcoVEqYlPNNthUHitPGVNTK5rMmycux4BhJh6XODFebKQVCM+/3Xhh/D2BbU8YHP7JkVVfnF9dH45JLR4PONvzbPW8rRtqk/N/HgQCT1K0S+wHS1awf7PkF8bcBdkboaUrxAqWT4jxoE0ORqvyv+PooLwRqvYXVwXKoLZ5fKbWXMe/iEYMZ+HLI86w8YSbGHLjtI2mIWhoQwobIPZCh0KJWqIMidMDIOaRveVHRz1FpNiCAtDLWGlyhMzLeFbuLLeOpavzFc4HlxKuNBd4bhdCd+JLRRdISM2Og6Q9pRoX5J+nxqOfGp/Tu40tklUHvjNN28z3uqX4nnufX0iw==;31:FQ9EeYv+/gAV161P3+Bfyen5K1wXD6Fi/ikFPl1f9kaUxxkUWhp3yFaKMGlIZz6ux+VIw9KdMDl2XFsVfMO5L45tMbwBLY61RzgmD6vnc+uUpbdB6QDE87aKMND2vzeHBhGsBP9+vGuJKryEDstqi8RoX8q0TqOJQFIw5SPZWI7bajRo0NWY3RkiKI6lq7SJ8YTfCQ8p3d570ahFeL/1LO2vhabB9RJgo5hQPeABzws=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1913:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;20:hdgbUa0AlR4OvaB/+cHc72ryVSbCTXxP8NKCBPZLQIjRxuMl2BT+N0vgGWqII0SI1jlwpGiffUsJoOMbw2ru9QP4eAeJKHW8Z/TGDH6gLFIxkDbK8EcdutE7H5NkYZahvWvAOGFUhRfzzB02zGBqZGRw929Qd4VQ0kMtNuv6TwhFD5czOGPxNpPLH/+rMN2733woJKAI1ok10EscH8rXgltBGwZsNW54FSvQviBdbZMQDisg/7LF0ov6tgqOAa5DhAlZkY0e5TXm9oZJjCQOOZU+/TotO1wZGV6MG3cHz0pu+HTqO9hjIkTGl3KYzMl8qFkBYPFWWzUETWkOJeMYu3fMlDpn4Zv1HROYEs0pj79iLs1HCBYl6NylhaBy62gQ7ZlBiz08F36XVGofXPJEJ620j0RyGaF/SKtgY4sgGe8oKf8iq+rvd8b3WMRDbM2a19bbfQIrAZL603i4MHgcz62eEHcmqEfH4wfelTIv00FiZYAPepaO79Sb/NIsKyPK;4:QhMkY7Eh92SiSLWLsbAjZt5ffXiV79rjQjiu+Qj1KoE9KHRgfOHiyrTAavJe9urL2TYXpdCEUW0jsupTO5DA/kjoQOvOgzch6Xf2QLO8kk/atucuYLQJe0rORaKdA5nRtocXjfvbkd4ys0BdB+hoV6z4xhYO2h1IJMEevt5K6XXc/JAOMGQrMcMrYSfm/S8WCAcs2BSUrshVSuUDBlZWYI6vq/o/n9rkg3wYAbNS8d1KDaC8JdCXFY6LAFut8a9nmHRzcI64qnwEhf+ChMi7c4Yv1cte6fq6KDC6sCxt0U5JMM9eNmbeLTLLlV5DZ6H+o6Dgf2JZaQs3KYEra5XB9Q==
X-Microsoft-Antispam-PRVS: <DM5PR12MB19135DEFE5041941DA7E3B51F8AA0@DM5PR12MB1913.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501326)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1913;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1913;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(396003)(366004)(39860400002)(199004)(189003)(186003)(305945005)(8936002)(53936002)(50466002)(7736002)(2906002)(36756003)(59450400001)(5660300001)(105586002)(386003)(50226002)(25786009)(53416004)(97736004)(48376002)(72206003)(1076002)(2361001)(6486002)(3846002)(6116002)(86362001)(575784001)(16586007)(316002)(26005)(478600001)(8676002)(6916009)(47776003)(106356001)(51416003)(2950100002)(16526019)(6666003)(66066001)(2351001)(76176011)(68736007)(4326008)(81166006)(81156014)(7696005)(52116002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1913;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1913;23:7IZNJbr9eTRf6tTx2JWuY7Kw9JdEfv2x1jkEs+JjF?=
 =?us-ascii?Q?cwV061PodWb3Lct9qjEHWo6XWCM/d4ioldWD2Q0ZWAy9lpCBs0YCYJuPhaJn?=
 =?us-ascii?Q?WSl7jUSAHhJ4u1ar74FIO8EG4Eg4Z46C3QdzzGAb3kqiNyWMYA7eTM4xSllO?=
 =?us-ascii?Q?tzUQAEei7EKMvekykXKWTXgW/9Gl+kbc4hi+QYh2AHmLWMkHDrxNQNxh2H9g?=
 =?us-ascii?Q?BB+5kd9W7LL+8QvX/D8XsdzWUsauz4nitO31X7l3AKF5TY32Eh5u0rbfxTsS?=
 =?us-ascii?Q?fBzynxdkvZrOWrHxXZXXDIiLc4Th/OKxkgCVJeQ0EoP8XPFwUgGfVw1a3xMs?=
 =?us-ascii?Q?cxSSLHQtyLOwnHrBkVtbMT4IeLrc/IunrtZDqOxfA6fewcYOYBDTjHKCOPbf?=
 =?us-ascii?Q?lPv6oq//QUblG3rkrl3zkXyy2d7I9MfRVvP+QeTahmD3JUHH5fZCsnFV5HoM?=
 =?us-ascii?Q?qbsyYUEiOCb1t0VZ9NRFKL5Pfn7ZiY1Asd3UzSEm27SCdA/KmZT0x1FLo6BA?=
 =?us-ascii?Q?cBiIy0+x88zstVhh8J1QZ/WX+nmZk7j8n8GuJvnu+pC9ByQwWYKp19JRRk/f?=
 =?us-ascii?Q?R3cCJbVKSF4XOHjy3CWlBeQJ5ulvO/OGgPXSIQKbudtZ1cvFephihA0t5kCD?=
 =?us-ascii?Q?OJy5EmKCXvr/c3kmkuCOO7xqa6KICUbjbwsExhexKYN6irOTDjMIHGngmPZy?=
 =?us-ascii?Q?djZGnWhDAdIWkS+iTHvNAgBvHpM6guGv2EkJyw/jyUsXayqzGtgqR9fy27C+?=
 =?us-ascii?Q?tAW/gdnXNAXmEZtH1r78U8EEJTiZ0aay35uyBL9UkDnptrWgRYpwAGxLyDeV?=
 =?us-ascii?Q?lR6Uc53saxRxGDbf4jDauSz3vOQuK+lcnttbhs6zB3e5tyXSQR9mnZAbU2f7?=
 =?us-ascii?Q?AL+yblNj6WxVeI7z1tSBqeUGnwoLd0I7lghZqA3vQZfbPX6kJGpeFV09vQRe?=
 =?us-ascii?Q?m6W9+NIC0+CNCwfIDY4zYR4eHg7MqZR/cWjaBVkhCYq5JI5cBnluclp15OPG?=
 =?us-ascii?Q?us2NgNb5SXIPjGlkSn5RzbllAUz4F4Y7sCjTJwpGHIk1R3fzLTHEHEiFQyhM?=
 =?us-ascii?Q?6YRiZAH8hMAR2dwEuSgiJwmQlxidivLS0cQyU68Wz3KLi/miiwIhyj5hKd2q?=
 =?us-ascii?Q?awqwqEAv6SaCqm+P0nQiZkmcCep68lM0jtVypvHlRDUwKr38uyFLb/5gQLNI?=
 =?us-ascii?Q?xIT6hd/SK2XXaUDotQXQgq/gnG5yOgO8SjQZu7vmiC/j6b3n54KazyT4VuLy?=
 =?us-ascii?Q?r3JE/ly8lBnVguu4Bg=3D?=
X-Microsoft-Antispam-Message-Info: KNuf/ySK7xzg1atQr5pyHvjtlen1FxVKMYQ6DsdLS+AxnVboHtwa9QkQ2RaRm7VebkJr/hV7qRk7rXRJCCpgsrGEQt9jEUJFHb3/zAYAB4sqsnkxPyuYoX76iUpP65qrulCy2m+YylJbpcs/6tCHpIkmacRmVntjd0GbuAdF/SH5rIqUFBgyi8WKdmNkd/HC
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;6:TAzsP1PSRix5PHMRBxBqs/mvgDMJRmjbsDUyxcnuhTakIU47fUCEkNkrEIcnJBUNtXnifkkeelWKnI8D7lHz3yDPtl12acifrjSrhYRr+WiSZmDB6JzdDjwxrPhHzY1vvo0vhvsj7nA0S3Qgl0CNKAvN/Ec6Ur+up/tU+OsYmRuFI/Kk317tW4UknFMKiGhwYJsP/Tdj0nrwHQm8Xk5RE3r542wckqtpUFYxVvKvpw38coKowOpkvynE55YEUvYmTdT8tt4s7bDnNitMmC9fr0x0JcAOvT8jo9MRDHe9hs7koIuvmVxxrWB/kBNcEXmYi+tMAKniHBUoK4ga/kjycq9i48EsrjuvW17LeaACsWs=;5:X2iyQDskInLgGgRPq3dNXF0JIqRLoIYPxLDGOMCqJwD1GvsFuLkHXH7QQRjzSIqoiGpsib5OXPSNJseXtP5LZ6RR11WXQvWWYAf0KaVu+vrSbK+y6NMRlr+sibjng8qYUymQTiHFUQbD4ErzDMV/d/F7zyW1u/b49NS12nl/Ddk=;24:qVqHvnlnJOAsnNHpThO+ROhucG2s7/h9j3FXrxeqV56ibvUN/2JVf2EFwVBspPnOwiqntfc3c5DsScwWWXi8kzPmTjWfVA0p/sAwNmC+Yyo=;7:r2Nl03KMt+65JPkh80TrzDfdn5A2c1AP5cDL8XVTQBYL7JNUiSufF9fTopdzB5l7qew/3jVlqh+6QdCAhgXh93RlRveVLgYbqyaRWwHteV4eAhbNuoULC7cSRXBnHshVVyED+Eytk2cVaVITWqY0oho6te0k4hlUO3veCygTuLV2UZqVXayxJirB5LndjmByFE/Y2Ok3nS59CCGbDsEbghJNj1LxLbiu2AsvYjzQmnktsq+zWQoef3H4vJJvjZTy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1913;20:j/xGAK+SxSoUopVktM+cErF5/ZINdZxwxuvhijN8EGd/Qad2jJaOg1p1wY13H5PTJYV64VAJbCjwgmNk4Sh447e/m/hG+YS7jPv++g49gJCo/JZISF8ryuqFeTMj0GLDXm+jTCNJqBY38i2HrewlYL/HLdg7a2Gv8laAW4wQYBC47DMoFtAgqErHEZXQQxnqyPbogjCbZ0TeKAmMS0L17aOb4cEySihQ0GChaxYQfjfLM8VD38M8qs3R6Gwa3c9w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 19:13:50.3515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fb34a2-cf11-4249-8375-08d58f5fe165
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

An instance may have failed probing because the probed node did not have
DRAM installed. When the module is unloaded we'll get a WARNing when
we try to remove a non-existent instance.

Save a bitmask of enabled instances with a bit for each node.

Only try to remove an instance if it was successfully enabled in the
first place.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index af0ce9aa8d24..054086b19c6c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -13,6 +13,8 @@ module_param(report_gart_errors, int, 0644);
 static int ecc_enable_override;
 module_param(ecc_enable_override, int, 0644);
 
+static unsigned long int enabled_instances;
+
 static struct msr __percpu *msrs;
 
 /* Per-node stuff */
@@ -3366,6 +3368,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
+	set_bit(nid, &enabled_instances);
 	return ret;
 
 err_enable:
@@ -3383,6 +3386,9 @@ static void remove_one_instance(unsigned int nid)
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 
+	if (!test_bit(nid, &enabled_instances))
+		return;
+
 	mci = find_mci_by_dev(&F3->dev);
 	WARN_ON(!mci);
 
@@ -3405,6 +3411,8 @@ static void remove_one_instance(unsigned int nid)
 
 	kfree(pvt);
 	edac_mc_free(mci);
+
+	clear_bit(nid, &enabled_instances);
 }
 
 static void setup_pci_device(void)
-- 
2.14.1
