Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeCZRFw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:05:52 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:57120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751994AbeCZRDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 3/8] drm/arm/malidp: Split malidp_de_irq_init
Date: Mon, 26 Mar 2018 18:03:15 +0100
Message-Id: <1522083800-30100-4-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AM6PR08MB3032.eurprd08.prod.outlook.com
 (2603:10a6:209:45::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93d181ff-366f-44df-5270-08d5933b8655
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:Rm/vjquQNE5cf0S1VajI5qFTSFv0FTwXFfjDbBavCbimP9SAe8VZpCY+1dFbVqXac7t2Dle1K2TpfLQNWkSSpBaXTrCXBYZu6iu6nlBqU54BzedEP48dQW9ftFeF6cMHMMX7Esv76TpmshESWWFvV50jVLCLJes1z33EJxkk02W1vqXMC9N5mPzV6eHc9XnEi9rzJUIPjiEO+VG/Yc0TrgI75a1dXLsvdR2Xphk0MVL6ipj9HdxdRkiZFBRhVLaN;25:4t79Pvue2jEBDULilNdBtVIBcxN9qZpucx9dhx6KkISgVsLh0LT8D2x9l2kSmnoNg/HIpzbzdDOcNABFmIUwscbTStIyK1A4h2nkQfefAoUmRBtkMKFeBaY9jlXlMJXJaFK1akELGkzmPeaeEFr0pSwezQ21WxFLDt5/8e2iQaiGH3xP4LmgxwuoeWrzfjqT4zYjb7ULWcZEgtXDO3yFgnSoh5HoecxOC4iUbNwSiYDUyRB0/LSQBkFVEjzpOodT2we2JeAAACXarNjiCVrs2fK860qfT6UrKIP1b7wsx+5Mg2ypq+BSh/Vf0SGrl8+LPOv3FzMGgx1BFzlnxcq2Rg==;31:i6IsbRn3OfE/WdLg5q+yOBzV5Kdr46mG4v3SCkMvw9vpraoj9P1FAR13NbGOGUBJOXBr6touN3r3U28HZm/Kiv0cqw+tj3jLMqbULHJGbUKKtPuT19ucU5N8xtNdSIqv4zP3YPSk7X5TVSkIL7/ZtnfAxWeWKhugJNLsxAVxFVZV7Mcgm5IfLYWetot8aTZtoAyjNGCTJEd9t0B3z3gKsDcYuK+xBMFeH9yF99ySH6g=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:NjujIniFqJrO2pu25I2FzHWsw09tD0i0hi+hOMmuQ1QqNvwKFDuUzDZhuMzTZYYgXtJm3ze/h9Vb7HVJUUG0UzZOlv4F9Mq/hMbSmVYf/7pxdLFwspO/hjxaejHxcizIJ7vkSLVh6/qf14SKiR9GKHl1fMHkIf5+ITtK79c3lV0=;4:YlWJOPSKe5s1Tb9NpGsmL4/caDvYRlHoxm6TQtgmS+4LK72BdWmQitehx0s2neYYAH95UTipvuqxpbtBY51+o/Bao0XoUbRGZR7NrBWjPptFl99uG0/zANkxR8bEoXZv1qwMuMK1Ee8H6ULs2tsz8pgRsTRzr4DM12ihGAYU1pl/TmMfiAQ5eTOkKVg7IafnftjP6tLp3jKwMAN3M+aVA2u8qD3pL9Amb+YJ3QMG/wCAG21XFEbtBM70gLKRHu29SWiD/bJwlKvxYrgyIVMJzkdLzsCwoDMwk+ACm7nKqDeh7xFpjbMP1jPraPeRnMKh
X-Microsoft-Antispam-PRVS: <AM6PR08MB30328D9FD8F63E6028A543F9E4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(575784001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(59450400001)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:5idsyGnRQldkeB4ibUGWB+e+T+ywxBPlnZ5V+u++/?=
 =?us-ascii?Q?OQIpwHpF6G/27VID/3ZNk6ISz2BoHw6FhhrRH/mRUi1hr49dWGXKv82AHA3d?=
 =?us-ascii?Q?O7FwwRU+td/WY80icriHf1kwmGPKBZj6UoTX189aB+BSEhpDSZK30co/aRkW?=
 =?us-ascii?Q?l7F6OfPj6m2OGOJgnSzsH0vw2GGp5bvuONBIXwu2FtJvSDdSsIhOZc9JQf0N?=
 =?us-ascii?Q?wxJR7UhcncEIavcuPPy2apBsXpECsyWrV33eBZs/wfJBxt0v4Z+wJ+I4qUFO?=
 =?us-ascii?Q?P8H9SaiGLhzS5q+H1tbGEQkATqfq8qi/VpHiWj1DeiQZi5BD5rVHWLtSepJ3?=
 =?us-ascii?Q?NO+WBogen8tXPdeJzhvlm6O1GduorpNnB2FIhh/GGeOt9JO410eo50QVp8Tf?=
 =?us-ascii?Q?aU/lGU2H/36uMYJU3OjYqVCNGFatulIrV6csVBLoid43jooskelnOz71sR5x?=
 =?us-ascii?Q?KMV+uslIGzpUsZ8DsFI+UpDeBFVQrPxkB1nINw2ZLavQdIEuXx8/ooZrqCZb?=
 =?us-ascii?Q?IsFbOW2OV/d5Z0TlUo2g6o6ZCTHJkagvLLd9hE4gfl5yrUFA7sb2bDOtTxw3?=
 =?us-ascii?Q?x+zFNLYTU2C5AZv4X7CbtNDRNqaO93IJvUcl0A3BWILEKpT8jRnpBpR2ojEa?=
 =?us-ascii?Q?CmFVso19WQj2wBnZod/jOHLJ382Jdc5gOWcCemy0aJqEgKI8pNi2lRFD+nBr?=
 =?us-ascii?Q?kw0XF39m9oYK5/Q87LhEvOL9cnq1To4hZyh+5UfCR4CeBcO4ILcePHAL8Xby?=
 =?us-ascii?Q?g7GCZGRZR8B/miQd9Edqa6nzozdcFGN8JijyYJKTyaoJvFbO1tJYjR2Vsm4/?=
 =?us-ascii?Q?racu2Oaiik4xVv5SRrNuJ4tiOEHdCB9zSq1bdvZehL04c60VNURbAuAHiJRQ?=
 =?us-ascii?Q?nWtXyYke8mYbOwyNAry8/CbY7jdxCvpxZ++l9DDQYTw/kk1QKnA4euKfM8GT?=
 =?us-ascii?Q?PrnzE8fNuwEzHvOaftyNeQzMU4s31IvltsiStbF8oEcuTtAQVtkZ6/+lC6t8?=
 =?us-ascii?Q?SRJIw/9GWmk8pdk3KBQGx24r8JNms7ssVoBvfWWL24o6QkDnbcoKZtWK1aef?=
 =?us-ascii?Q?p3TYbDeXtaeJyYMsOvNSuKze4lmFAb0kU2Fg8nfsqHQtL2cFWmsvuFAhcyiO?=
 =?us-ascii?Q?pn/kqJR2H0E3biGXZIQZnmphQOQAOQjaE2BJZvtp8PcAhxSk5no95AWS5zJX?=
 =?us-ascii?Q?tZu+BfGscgVmKZ7o0PDMvUy2AZlasMWj6h9?=
X-Microsoft-Antispam-Message-Info: jPr4UHYPkluqnuaPICU5WzBCWX3ime3WuJqY4kjjPMZOdAkkL3VogxWXxlFzAVGZmX/IF2c2gmNuphz4+B3pal/LkxC8zlezto2RvCASIFn5/JGoyHUxWJl+6dp9kdldPUX81pw9YQuEbpNMwN64dqhX6JrEtDV9T5Kfa6iOjJ/kUR3Y7Yjy5J5ilaGR3d41
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:yDdytl4evKfh3lMvcrMxrcIwf68XmmQxL577j/O2jkFIzl1dbewg+9/SHKK1kvM/dH8MJsM/Clq4K7rW35Y2x3rroiLFWVA1Kpmqz3FOVufU08CfEcPw3DQFxXq+tO77XHgyh6no0BseL+zkFLs01M9bYaK0Q57FWLjPUh4MkeRhBlivdPJaBDiAcahN3PJsaFEPuTwJ+6X8vk3A0UbbvZvdjV1gF1MmnJY6EBQqmM3A+3uLxl1eJZ+z3iFBntQ91rE9NRdhjN63YVoe6KhI6CAIZpTrgDSslgQncKWnJX/4+oU+fnISdB1HrAPmDwbZA9Ot7gNYENiNnkLk636pzntgA2Q78BSC2lcsyiLFJcntApAByQLhPHp909z/5bn1rIxSWwL0YTjLZuttihD1an3kh3Zv0cTgO/8AGzFxaIFbKs3N/ymQDGCmRt59YZeSQWRUhJpVkTy67uDzVFoKyg==;5:KBRY8KBCrzTyRqlJUpW+9g5D8Ps6fkHZgjLHVTKR3tEmQC2SprsyczIFTnGSNMux0gU9AnU4b8B8mWUdViD8a9khEak+g192lzquuoRjoibRxABO9pDgd/v57p615z04dUrIyOXWgx6cxJbWF5eXnbHXZDkyWT3SKV75ePVnlCs=;24:L8ARkkqDLruCsuzjkHEFdMgLsgxyP22+G6JLOh+PTMoAbP1c07EjxVakJiEoVuO2AD9HaFOcJ65aSY/gqany85NwhmBLmeVrVv0TxvOce1E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:bo+pJJVbM8BQNzZ7PPtoTdie8FW9ISvZsPCstB44QxP2I2wZfZ/WOr5lLHZfhWZwdi8Tas4tPjJDldhc1hjCmnvPi6ceELzw5kjk8RLOjIloA/C+r6n/Spin5vkcTeUxPsiOsWP2Q1xYUe25msokjbtWso4kkgzrlokLmC5hixvFLinjI76DtMDN2HY9oWX45nYERFkplNdDwcnz/33MtEExpM0+YbrDTAllBx7sCT52RAPlDWhfVeQtjUjjDMbl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:40.2322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d181ff-366f-44df-5270-08d5933b8655
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the hardware initialisation part from malidp_de_irq_init() into the
malidp_de_irq_hw_init() which will be later invoked from runtime_pm_resume
function when it needs to re-enable the interrupts.

Change-Id: If8bdb0e246653cb7d7b7d6d63919c45b01350c10
Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c | 25 ++++++++++++++++++-------
 drivers/gpu/drm/arm/malidp_hw.h |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 8fb02f3..3e73370 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -869,6 +869,23 @@ static irqreturn_t malidp_de_irq_thread_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+void malidp_de_irq_hw_init(struct malidp_hw_device *hwdev)
+{
+	/* ensure interrupts are disabled */
+	malidp_hw_disable_irq(hwdev, MALIDP_DE_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_DE_BLOCK, 0xffffffff);
+	malidp_hw_disable_irq(hwdev, MALIDP_DC_BLOCK, 0xffffffff);
+	malidp_hw_clear_irq(hwdev, MALIDP_DC_BLOCK, 0xffffffff);
+
+	/* first enable the DC block IRQs */
+	malidp_hw_enable_irq(hwdev, MALIDP_DC_BLOCK,
+			     hwdev->hw->map.dc_irq_map.irq_mask);
+
+	/* now enable the DE block IRQs */
+	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
+			     hwdev->hw->map.de_irq_map.irq_mask);
+}
+
 int malidp_de_irq_init(struct drm_device *drm, int irq)
 {
 	struct malidp_drm *malidp = drm->dev_private;
@@ -889,13 +906,7 @@ int malidp_de_irq_init(struct drm_device *drm, int irq)
 		return ret;
 	}
 
-	/* first enable the DC block IRQs */
-	malidp_hw_enable_irq(hwdev, MALIDP_DC_BLOCK,
-			     hwdev->hw->map.dc_irq_map.irq_mask);
-
-	/* now enable the DE block IRQs */
-	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
-			     hwdev->hw->map.de_irq_map.irq_mask);
+	malidp_de_irq_hw_init(hwdev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 6607aba..3b049d0 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -297,6 +297,7 @@ static inline void malidp_hw_enable_irq(struct malidp_hw_device *hwdev,
 }
 
 int malidp_de_irq_init(struct drm_device *drm, int irq);
+void malidp_de_irq_hw_init(struct malidp_hw_device *hwdev);
 void malidp_de_irq_fini(struct malidp_hw_device *hwdev);
 int malidp_se_irq_init(struct drm_device *drm, int irq);
 void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
-- 
2.7.4
