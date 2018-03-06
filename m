Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AG47ELuAGAueOsMSK0eqXyx9C4U8YhdnTF0EjPKaq6Gqx3vSC+QHunNDoXRDgdKfClUe2jCWTAJ+
ARC-Seal: i=1; a=rsa-sha256; t=1520358256; cv=none;
        d=google.com; s=arc-20160816;
        b=dyPYkGD9M3IjBK5buTlRjlvej9VSRiHCZ8Vp3lzrTuDQZBXfpfy/WBZlrig9PeYBQE
         QOTP3GowI5JpiYAC+ovgcAUpNkn59bv1dB34efevlnY+rHsFaHoqkr0bCMSh7XZ0pD4n
         q09IY2z7wjVLAAxkDhkK6/oqQq+xTcab6VbXpOD7Ux/DTSU/pQRHF4K0zr7f8BTv0hfw
         QtJg0NWaGdlk8mkbtmuYLSh5IstMaOuXYx8D0jSQgLYR9ykuOWjlda42pYaIJumIn/cq
         Qf0Qb8WsdkEmflphFtmggtNdXGu6+g30Cnsx8LasXyY43b9SLVrdvIVNw3vv7L5GF7dj
         d8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=cJpPFNnqD4F34NDJQ6JwHhoqrpk6XH3biUVPzNAU9/Q=;
        b=vAyOfMCvAfzm2CDKYp0QzgZ7KGQhJlFyUEsm5cfKWnjq8GCiRiUpo2lZWWVtN0a5GJ
         zK57huQy3s6Q1RO94ctF0fCtkYx67zvlFNS1oSej/UApnPbTYaKYt1inW+z1+QtRdyzo
         H2Q0thxLrvb8ga9F1odTHDKa95y1ByqdVhToWyojsI76yB6yYWyjj6+RXT7nP2ZEvB8Y
         6pR16DMI/0VcLWxpUICi4gjHVSVK5GBM0vg+ict4AqzhRODgz9oWD+NPk8YglHLZVB/o
         vHZYHlAVqg+Zm0UjNfr/0VWj0mAQjHXh6Ai30xJnujMHpOST+x7GDSrPagZDmltAHfQ2
         yetQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NeXHIZrj;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.83 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NeXHIZrj;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.83 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	roy.pledge@nxp.com,
	laurentiu.tudor@nxp.com
Subject: [PATCH 5/5] staging: fsl-mc/dpio: Remove dead code
Date: Tue,  6 Mar 2018 11:43:48 -0600
Message-Id: <20180306174348.26095-6-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
References: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To HE1PR0402MB2700.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41f6473c-89c7-49e1-ab3c-08d58389e0bd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;3:M0wpmrXqLyNEHPo1CKasVU4BsbRCROKjsGV4q+jb3gMWRHP+aZqzE1PxZwtwzBNlxA30XqBuoD0L05iMs3blZ1rafGD/v8KhSkvtiTLAzSXydxTASZBkDcD/stkyMZKxADUazIHBHndadQaCJfurrYM2l7+M9KUm3xFxZgw0Ak5UXWtd+jQncWAJvc7A7wMOIUMUSx+cq/Ew7TZT6P+3oImuh27cnB2WwFkGHgZa7tqc2+DK2VurUTd2UFiePq7W;25:rnCTE/z8ZLk8TYiDt4uHrhZrjk1IGnkt1NFG0FrTNX3YTEEj9jhYFmJeumapj5/E/zcJWa+PGSO+PLmKTuaQVWDZtFVly3N/WdHHe4ckNgXP00OY0FpYEyLMaQQdSnFJNBh14LJCs5O41CH+7KldocRMQkmTn81UtM4haCm9JbE92pOt5gzVisg4mjFZl3XOl9kJlYdFm1AIw4+Px09iMJqRp5D7GFGvHRpn5MEhrDXxXmcj+Tqmh1HlGspUCQNakg3ZOzhjEuBU5OzF2TR3rWybx8fw0omZhY7DRXnqmp/kckIArpAjcMZ6ve2fsuVfTgwZQEsHFq1F8GfRNdH78w==;31:da/7jJqAsu/xk40mctMZjdQOxUUKe/HmqwUUYBtIyaf7CA4SVUo1kcdF1itPvUweY/e1Fy0Nu7BUprGwR/VTuuHP9bxshPTdz7QDrl5vz69afiatVYztWnPEkxxrpxXmVewqjNeFaxVZ/e9Ru4BGlJMYiNBr8Sw4V/YbkRxS5b1ysrKd7yP25HbXIfADMeph6T19bhluN+BwNoftDlJLFHj7gmQDpI7KCwLNTD1hBFY=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;20:uGFt9wbnY4EfJqQqs+3nsFT/bfqz5FKvNPvtWY4X3D9xAqGQc7wJVWbYctPa7uu8DK2UzKkvImFL2IGJsuBk1L88pIIzgKdEn++Lj30BSdb+zv2xCoZNdtkOYeCJdM1o7pIOPQFIoaINVC4tcRNFNAfc+nI8nFpCRrIVhOjFu8CEYEhyiUTfnl5Q+hURJ2tAV0bRFp37ePMkWAZ0kkM53Voe18/3T7WgFph4z16wRb7eG7ZEqElEQ1OlbfxYvqjJzNtognpL/5VfXEjdwfjg4Xwk/XyI3Oc1sbLH13E2rIBVjxUbXo1/H7cNnHqhc4F18+q25lT92dnET+GYyulk6yWY666bWvJOczfPxxBwRXvDCZpAqf+bWfxnUBeq9XNbhor+KJ/kcO2DBSBB1oqbjL6fPym1Jyk5qA/geKniwLvzoYBYS0jZwsrHdLpJSW1jbuHLKTLJywXmA3DZCIjlHsR7QhUD+iPDX+rfWfOuSLFYJouzq+MxBHHa4NByXtPq;4:2gZC3YZ/rYTAmsEnGWwDUvGFcSN7JOIxmBKFxo8nHPFhk+eXZCZUHVifihTyJWDFoRggiL3/TEygfAzFvH/mEaCntm3PI7QrSiPuHZJkHWSDleeDVMk1IAAjKCarcTjDoYm9arP6HDp6uxI//cAzpBAdWkaASulDXAgiHDLMjCqANdt0rGOI14nmGEIRmC6hbRefgMNXinSmcVgEzoELQp3bdXuQdrGQAahGetAzijcDl9h7PrMKaxL+bYXBbvILZkwh6ZOv24DTUWOQKcm9qhchmJ8s/GQ1MrXgKMNbqevri/0gvTfslJ/3ZCfLpn9Zj3LaAbe+mrKtixQVXrqYl7Xt+cPhMlezS5/+DQPKvrs=
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2700924EB911CE95533924EE94D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0402MB2700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2700;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6916009)(106356001)(3846002)(48376002)(68736007)(53936002)(6512007)(47776003)(2361001)(66066001)(7736002)(97736004)(51416003)(6116002)(2351001)(52116002)(8936002)(478600001)(76176011)(105586002)(2950100002)(316002)(26005)(8676002)(81156014)(5660300001)(50226002)(2906002)(4326008)(6666003)(50466002)(81166006)(25786009)(6486002)(16526019)(16586007)(6506007)(1076002)(305945005)(186003)(86362001)(36756003)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2700;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB2700;23:0q3kxMOyO0OPSRB0/Tg1GyyApHGPh2bhUbROI6f?=
 =?us-ascii?Q?5AV6cGWUwyGbJVcUKZ71vpRCwLNc/7xRx0n5ft5zLK1XOb9t62rJCbAUriKP?=
 =?us-ascii?Q?YToa872jId8tB6PzV1OWj/v0U3JtbvOiT9Dk8Bjo2TS8N6kch3WCMdbW1mCu?=
 =?us-ascii?Q?uWxKSj4r6xjB7CkZ51/j9P41waXLKwphY6ehUmd1jktxPJIOCDZkt38KT8Ca?=
 =?us-ascii?Q?oP3Z5APlzu4dM3S9Kzt3dOPF+soLgRAq0WGKWNlkmFWw8cPS4gjJfQ2+mt6m?=
 =?us-ascii?Q?Oq1UPfvF4t1hM8lls/cdoT/Zcb29nLgu34eeZDpUNkZXB84keoFx7+i7V15H?=
 =?us-ascii?Q?QsieAAGq9lLCVU9VjlYX8/Ijpo5f2EWtyWwWgkGI+740DRECdrmjHxDDOO/w?=
 =?us-ascii?Q?7OCI7tYwmcNdd/QBVAxRlDcNoN68HTjiAxct9Mcae3UkeTYm8EVauH+463TA?=
 =?us-ascii?Q?wLen392lCHcD8YmB0E0kA8/qu9Mr7bY4OH2WoSBlq8ecsJz0U3ubSkYh3bgw?=
 =?us-ascii?Q?KfAkSPkXp/AJmh9HwWBmcJUlw21rMuWEhJffja6ApDT93ajX8eoQnLi9gw8Z?=
 =?us-ascii?Q?vIE0Zp0iyPvj8s9IW5DGLLvrNNeCuJ1UinD1WE1lBpLap3yisb7edUbG8C8Z?=
 =?us-ascii?Q?PjEaJotDSn4sDTpEbl9m75JSmo/+chrneSGhLcKWwVDYNRIy7RYPrpvevfDU?=
 =?us-ascii?Q?rABVP+vQt2k4yS6/AJ+PFLLoFKUSrsLuL/pwwqi5Mmc6y2NxR9UU8Ga19Ms3?=
 =?us-ascii?Q?eRz/zfENcwhF1xlhr8seD0mRuwyInOJFODTikAOVy2FMq/5cMcBnns0Xo77s?=
 =?us-ascii?Q?M0lywGvjAcHNTDPWHINfgFTyrM0eIsfp/igsN5zgVj1/XvBqdoDQwDJ5gVzt?=
 =?us-ascii?Q?qzS9gcSH03+PS60Ag4PFMMdGyqZ8DLX4BUIrh+LZwBk6IdMD8Dvv89USrOkG?=
 =?us-ascii?Q?jBx2e3O27ASLgrZzND8sC2KyngWZdOdFCA8Us6coCY650zka2N78SHQPAhg3?=
 =?us-ascii?Q?cpTY1N0VmdJY/xawZeKULcABZBgZKU0n3CrvWbNoIBSGmzdvu6MKcidkxjiB?=
 =?us-ascii?Q?COZVeA9QKSzK0Pa9Hsz57o4ehmsHtUveUIxkVruqGcqRSaFXtD2m9QMwliUc?=
 =?us-ascii?Q?LOevXtAThJ9IdO6ayrSjgu8j6eXKIewrIKPgGIkZUJzAWvH6wR2VAnw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: kgJTGLjTw63eiqAVE8m9f4OktyRriQ/zMBhs4BhfcqQJLi7gLpTKB8i0TM3t5sENfnXIpdDi78ski9om3PNT19VvO6hhEcmnikjyvs0hpeRC9RnJ5rWVzXVAx09i4p9PuGhzrYKpOc7CuGux/83aFKMDVAB68EOEzQ/ciT3HwKO23ReFypW0n0iODikGwPZb
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;6:E04VEUz6sa5B/7j6CJ0UgeehinroU0PyMK9POSzGk6rigBGK3PxpsIefUJzsjA/LUwWGuIPkEmyKXG9j+oPt6H+i4JxZ8yDWYG9+WCZMTkaaB6Fvir2iLRuBLctJTifLMorep/uGCiZhVepbD0uSW6ZTmfo+tJ8CZASuDAGIbihRJV3Z20MwkIb8hKKQHrSOMJdHIjh0BXa9njN1MErbEKT8wA5/Fee7B8q/T7gwAHhP2S5qXZOCyzA4RnVG16aneAnX4AUSckhPMr1nD4b/MjNCCA0oLFCE6UoW+/apqgwNdjOvFBAdh5NXt47raoeSt+GtATlVLm6A84YN9o/rihOvyvWN+VCtVUpChHJVx8I=;5:mF+WONRZHtcmG8dCUgPIWh7kqBr+pyo9ZXVyRhk74J/zUXEMxhdWDPx+3MG3+VgYdkL4fbV65T5ywnrTsJ72Za3W4e1QgRKLBjwcLELRs+nFsm339lKHQZTmLoTLjLY/tEbe9HqqkjhHXnA/uNPlaYqOVVH7YCCN1G2YXobqPYE=;24:zYO76QWMhc8yW+Hd25kKnEZmCrb1tIuwEQ4wm9zXiVI7avF7yM0RjLMJ7L+AGIivS0nDyn6n6nSmbbg4h3lojBf1SkZ3/dwJee11rIXMwek=;7:PUPI3DSOeiXYBqU7+DgKWZlA3rBCVnyZr8nkifupuSbttKmvvdK18wYPt+nDGMiT8AfKrGHDkMNsxTDOX5F9kM8UC10ynCNVt4zVIGw2RT/A+/a8VlKB2NM+0db0vVBwxJutBEWGmxw4Gds4E3VOi1KR9lpUMa1pNCO/rfEyOGlMZVCOANrg6ZQ2Fy0rZL/rFy7PhESRCDpEtt7HOa8+3TwcAoRktg0GRUw1U5S4pUlc6IDkwIUB6SYp4PFvA4dI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 17:44:13.3171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f6473c-89c7-49e1-ab3c-08d58389e0bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594211179127107570?=
X-GMAIL-MSGID: =?utf-8?q?1594211179127107570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Function qbman_pull_desc_set_token() is not used at all, so remove it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
index 7e55b56..116fafb 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
@@ -522,11 +522,6 @@ void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes)
 	d->numf = numframes - 1;
 }
 
-static void qbman_pull_desc_set_token(struct qbman_pull_desc *d, u8 token)
-{
-	d->tok = token;
-}
-
 /*
  * Exactly one of the following descriptor "actions" should be set. (Calling any
  * one of these will replace the effect of any prior call to one of these.)
-- 
2.7.4
