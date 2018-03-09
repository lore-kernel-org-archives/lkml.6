Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCIAvK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:51:10 -0500
Received: from mail-by2nam01on0066.outbound.protection.outlook.com ([104.47.34.66]:26208
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751776AbeCIAvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:51:08 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 2/5] iommu/amd - Add a 'verbose' switch for IOMMU debugfs
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 18:50:58 -0600
Message-ID: <152055665818.63229.14230357529475243257.stgit@sosxen2.amd.com>
In-Reply-To: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0006.namprd21.prod.outlook.com (10.173.197.16) To
 BY2PR12MB0694.namprd12.prod.outlook.com (10.163.113.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ea5aa9a-847d-4259-f856-08d58557d5e3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0694;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;3:dZ9IZcnG54V/AJZfR9W4+GKQye9UjNhro8vvhbM/MMvK4ArdcK03JcsCXZdzdX8UtrrQIYBxGSeDX299B10Li+R4ePzO57donXJw0HMYzOD7foeANU0L6TJv1pliyC7uTrU9DYf5qzpITYg/5xtcdviv5Ld7NSqo0A9aoJTx8iXISbYpVXZp5TptbmWPFPJPUbc4J2KGNax9t64j23lqZalGxl4jr4l4W7/E0UCMNWFLg/w47dEI1/68V17De2Sd;25:3C7851iHfLN3+eYrQog2/BtVTvyvhBp+GQzGXSw08dXyplFGYEKavA+1Cvyv+RNbrXXc0oBxUhxzt5E7hTm9uerMRpJh6BSwhyk4Kn8dazpSGmGTHM9Y7kMCFxJqq4ezgD7g2UsLXZikZXlLOOqwj1frx9aqRTRuU4FDqyZV8zCFG3oirKgbsqFmsJ541C8Qf7HehFJXYr3vMKGPefoHZkKmoRlay4vIZ27qK+b+t9SaWHwatB2VPaqwWgIE6VxcOlGppV2h0wXY6bjdB+DFQW0J8uLTCrU4pdWCFjsNbRomZW74pzYF7nuXr8ivM4ES3xUAuLrJReD/o8ajzWwCZg==;31:feHREZm66z36AFLtwF6RwO5v0MFNN6lF76dgv/0TiMnuZKAc1+7qw/leJEdT3RKzGhmrzYNF/snTqCmCC1sKpqHhzDZw7CVxlr46ZDzHrXxTd3ZJ73wNyrseiLonX3dZpY3YWUWQrVj4ALKXfLVLL6t2PBSCwCeh4281CNMlj0qLPRIs8dWjbGHWKSs4U/5eQKyBM92DOakoDq/DuBEslIExZdNTti5t/pFf1CeG7Iw=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0694:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:OsU3wOedSunLKtL4Z54Qh33RkZBhkRrEk8PcushONXRZ/cGsWFjk9lz9BWfhVE5r1veFefLz9E8XiLxx+jz1klmvIBq7GBYZOYVMAtSe2PKfP3ryxNJqJGd8d0Ycq+UHLdPmX6OHdROQL+1HLQl1yYEEdT/lY9t57yJMr/clHjxoTsud10nWN8j7KcngiOWFeQ4VCNx3me+jonDD3dKiQQptCmK52+sqPii0RKAfbeUsZoxiWuIu7eoegUhs3ueqD2dybvUmtO4lLjJ4KSz3u4Vk1wgg7Ylr00920HAPvIy6BE1PAbwhaJiTLhGZdIEYhL9au0sU8FNcIz9qJaQogSog4eE7Qst88n58054nBupl7DGaR11i+qiYD4ppdqq44PJfYyLZ4BfHIUZrrF9AI8H/zk3gtdBREwCqZM0Z7DCmhDyx+l9gAqJwlz5He2HHG3V5iVe4vYyZL6VN9hSkkvpNcC2RsAeKAm1Pbr0nGhkgelfSEjhlpzeGxosmJV9/;4:38aZLk1oT4a8tI52/WQbKjeyVZGcD+3X6/X+3hpX1Fai9M59aUCUCSI+mlytRh8oJUrCPzt9OtRZwSD1GGO+sHTfK85EspT9ZhjdkuwmHmajlyIRe2JP0C7dDL8JWI8HnJmp2XJNY96qtiCvEaWAyovNqZhVgsEuLXiZdRXBV5X2wIHF0ZT095qvYzvhADrL1LwlZAeK344r32mcR6/esJaiRr550IGaxPlr+SoLEVWHhF9odrSBYlXaKYVW9SbkzVcZ6JjYnagmAavTtQZsd3z74usfjx7UhCMR1Z1rwht4OVr/xTJVQJEUy/6IWSN5
X-Microsoft-Antispam-PRVS: <BY2PR12MB0694569AABA134F20DF271F8FDDE0@BY2PR12MB0694.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040521)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041309)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0694;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0694;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(7696005)(72206003)(50466002)(478600001)(186003)(16526019)(55016002)(68736007)(86362001)(97736004)(2906002)(52116002)(76176011)(47776003)(23676004)(2486003)(316002)(59450400001)(81166006)(81156014)(4326008)(8676002)(58126008)(25786009)(3846002)(66066001)(6916009)(106356001)(5660300001)(6666003)(2950100002)(386003)(105586002)(53416004)(2361001)(7736002)(26005)(8936002)(230700001)(6116002)(305945005)(53936002)(103116003)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0694;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk0OzIzOkFDVFJKM2JOZEx3dVR6V1UwdFlwMFRrLzVv?=
 =?utf-8?B?bFhxbHdxZEdOMndhU21qYldMM0N4aUwwbGl0QXdFQ29zVG1GLzdDSzdhK0Vs?=
 =?utf-8?B?eDlEeGtsREZCK21sYkZ6WkprZ3l4VlBSYTdUYmtEemVmbm1HTTVkMTgzQTJN?=
 =?utf-8?B?dURGSFplYzBkUytaR0N2ckdvbXpVNXBKWWJFS1hCQXNySjlodUZpVGhjbXJM?=
 =?utf-8?B?cDhTK0ZSTmxzRlJkQ2lyNDZ0bk9yRGgveWZ0UUZoc0ZtOHE3WWFTQ01oMkFV?=
 =?utf-8?B?ZDJFZStYTWFJbHRVTUdxMzFoNC8zN3hGeVU5UmNXa2t6ejNKY25pZnlFQnVs?=
 =?utf-8?B?VUhpaVFIUUVuWldxVGNkRjhFcUdSaElZeEUxekdZU1RvN25veUdaS09tcmtl?=
 =?utf-8?B?ZnZwMnJSaWVvQy9SUXZBc2Q5NWg3YWVtVVFZRm5QeUdRNW5oOXBXbGdIMVJW?=
 =?utf-8?B?TlJxbUMyY0YyOXVicXNwQWxkQTUvUmZHNE52aTlUd3REamdGSC9FWkRkeitG?=
 =?utf-8?B?ZHdOQWgzbGVJOU9iQS9BRFpTL1hzSTRkYzRYRVROZkNXVkhkUWpjMlRMbTFH?=
 =?utf-8?B?RkZmdUpqZitJUFhTeWVvaEtNZUNjWWFoM2owQkFBbU4wUjFmNTM4THFXZlZn?=
 =?utf-8?B?MDhhN2xWd3lHc2pRdVZ2ZDBtZ24vSVd2Y2JBMTNESlczWkhsMWJ4bjdGd3gv?=
 =?utf-8?B?ZmVWVE4wZnRPaXVFT1BZYTVKOTVFUDBVdDJVcm50ZEg1RjVjSnVwQ1gyV3hF?=
 =?utf-8?B?TFFrV1R3bm15R0xJZkVhR2greDIvVjF3RXA1N21tbHpVZkJhTXduV3hIL1p2?=
 =?utf-8?B?Zkt5ekZSWEZOeTI2d2xwdnVoVXdwbHhqMXNlQ3JxSHluQTJ6L0p5VXZVaHdC?=
 =?utf-8?B?VDJWbGsyTXlqdk54K2FXQlIvRHplTDZ1YXFZNWlMNjE5d0tOMmUwMFVLaGZT?=
 =?utf-8?B?d29ET3pWa2VidW1TWEQ3SXhlNUFuTlo3R1pEQlhzOGl1TXBXZzkvSkNTYnNo?=
 =?utf-8?B?RCtrekduT2pXUG1DYUZaSEVxbUJTSUE0UXpkekRtUlZBc245b0dnS1pBT2d2?=
 =?utf-8?B?RVBxanNnSU1nYXk0azVCWnphcHh5eXY3d0FvWHRlRmg0eXMzYzFYNVFmTWZL?=
 =?utf-8?B?OVg4NEdpOTkzaEFSVkNQRzRoKytmczJUNGVaOGY2ZE5oSGpZMmM4Z3I2SXlv?=
 =?utf-8?B?K2w4Q3RUQXJiZEZDUkhUVnZnRDVLS1RteHFXdURyOEJ5SjNKTlpxUXpOQWtN?=
 =?utf-8?B?c3pIY2FJMVIxY3doeXVaQ252aUNyZ0ZpTExIMHBlTTU2cWpvS1VWZms1ODNP?=
 =?utf-8?B?ZEpoUVZQeWpWcDRvWGxXOTc0alllNktZbjlpMTVGL3JWcUtzU2J0cmRJV2c5?=
 =?utf-8?B?Z3E5VUI0MkFFU2QzbWljdjUrL3gwWXhJenFhK3hUTEE4QmhMOVYyZVlEUzZQ?=
 =?utf-8?B?SllyK2IrTkRtNFhuRFBvME5yWDR6UFh4STAxZjhIc0lpQmZOZXltWGRFL1V2?=
 =?utf-8?B?T0NxQnZ4ZFFaeDliNXFTcW5LajJUTzJBemF6TXNqOXlYemxDSlU1L2R1TVhJ?=
 =?utf-8?Q?13PXbUEuHLpoB7Qr3JWXcpGr8gLig4DScl+LuuONLRdk=3D?=
X-Microsoft-Antispam-Message-Info: ssoP7XJnBdXmxurWZsoHdNfyQhUSkqGoD2UmZMVbtV4dcle71QxX8VIhZclQw9X+tppsqBnIGf3n1PhfAXV6kDyTs0sBUwwQPMLTMKNqL1WN0JvkptQV0ilvMJgTrObZEuDYa8bsRzTAYnV83aL/COg9hxppslnx27W8ZDSvmTOYI4RHk5CQ5PTc4ioy1Hau
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;6:QmIgLpK0PW+NYGTfczfIbkvZd2BPDm/mO3dlExtnP5X+wDm9Umbm0vGgtJQUq+tN1SHKS+7bWMBztD7wgEQBgxSEV77qdW/FmJlNtnWghuI7JtciIqd+Rir6qmGA/I6RER6UdoFnY5+je7TN+gVfuuVT+ZogDSN3qWZfk+zUIkQG7o4A5qcITwV4y9d462wZL6VB5gb+eu1tlrSkZDaY73hkfRvddW3g8A+2aff8Ic59gCjOQNbxS3hOYHYxS/qUdPnHu+Hj44pLtHarw+HRsTChwQIdFWY5rYYlVkoVsVxBqbXo1JAsYazLOwICL68YlzDImAZqeYj421XR5rw7+HeMTxZZG5RWmgoKw9ZxP7s=;5:C6sKTHaxjQGGCjwDPU7UqKlkZjayN1uvOLopAsINVHwC5/yI6D+SRjJrINVHvwmoqRI4bRaMo1uG31T6Tey9bNJfUJ6ZHe9mZfDILDt9I4N0wayIt/DTLhY98fv5GZ1DyPWfEsQrCmA6WFiUAdrgYcY1Bc/VQiYHLAZI6O5sljU=;24:GnbbeM3XLHaAqnx6Qsq+Wzd5wuR7Ml1zlBR66PuZ9apleTq3mXydWUu7mxZu+CQ34yNhjqL/8mA92y0XxnXKkHmBY9y4C9EmxMLzltbDeTQ=;7:w+dtDASDd5vp8TuBvA1y8HzairM61UtRMJpLEfoH0rt1md+c+SveMHIuHKAfZzGfHrWd9Z4Zgd/Y78CPUAQA4K3V4CUzUAxcMkRodm11snK7CbLWeny9aPT/EJq3ujaa4H/bRK2NaxwIvvr7Lddr3SDA5QCYfoTWa3rrpCO29dyzyyO3LVFceRUYR/2+P1RGKa91Aq9nP5vJynC8tNzN3BfSlWA1h13MVeVzXWzo1X8/YYLY50vB7rrDDyeke3zF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:SinFl3jZ6RNz4aJEQPh9OQirFpFJZ2ODFmJONi+bmpBGzfSf3mNdtT8qJ2d0FV5JE6gVKrfoNBWhromctq+sxEVpDosBul1WPKSnOvAECG4B21my/rsTinShtG6LanEIN2/xI8AMyFZ95MIet3w59sBWMoLtkA3W5EAy7ShnMUPBznXLKV7gcebJKWmscOafCqnryTo3cfmS5qv7A2rKJ2ejXfdaxl8UoE0Uf/ggtKUOXLonCFSv6k21W2GOMY5Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:51:03.2272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea5aa9a-847d-4259-f856-08d58557d5e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable more descriptive debugfs output via a 'verbose' variable.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index b0395a47bc32..481f4d86f8f8 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -27,6 +27,8 @@ static DEFINE_RWLOCK(iommu_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
 
+static unsigned int amd_iommu_verbose = 0;
+
 static unsigned int amd_iommu_count_valid_dtes(int start, int end)
 {
 	unsigned int n = 0;
@@ -61,7 +63,10 @@ static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
 		return -ENOMEM;
 
 	n = amd_iommu_count_valid_dtes(0, 0xFFFF);
-	oboff += OSCNPRINTF("%d\n", n);
+	if (amd_iommu_verbose)
+		oboff += OSCNPRINTF("# DTEs:  %d\n", n);
+	else
+		oboff += OSCNPRINTF("%d\n", n);
 
 	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
 	kfree(obuf);
@@ -79,6 +84,7 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 {
 	char name[MAX_NAME_LEN + 1];
+	struct dentry *d_verbose;
 	struct dentry *d_dte;
 	unsigned long flags;
 
@@ -97,6 +103,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!iommu->debugfs_instance)
 		goto err;
 
+	d_verbose = debugfs_create_u32("verbose", 0600,
+				       iommu->debugfs_instance,
+				       &amd_iommu_verbose);
+	if (!d_verbose)
+		goto err;
+
 	d_dte = debugfs_create_file("count", 0400,
 				    iommu->debugfs_instance, iommu,
 				    &amd_iommu_debugfs_dtecount_ops);
