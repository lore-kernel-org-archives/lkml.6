Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeCNXF0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:05:26 -0400
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:11291
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751413AbeCNXFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:05:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 3/5] iommu/amd - Add a README variable for the IOMMU
 debugfs
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 18:05:15 -0500
Message-ID: <152106871561.67212.3504698988832928735.stgit@sosxen2.amd.com>
In-Reply-To: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1001CA0034.namprd10.prod.outlook.com
 (2603:10b6:405:28::47) To BLUPR12MB0690.namprd12.prod.outlook.com
 (2a01:111:e400:5951::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5640674-f92f-471b-eb94-08d58a000f08
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0690;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;3:Fa1GArmA8UxAw3nSdmFh2rAzflT5mr5NpHZvOgnAJx3dv3OLuOra1fvMUT/V8yeFMod3nmBXU+DvFvbqHPFgL+IjdB07cDiSlfIbjBgmXtx6rvsUcOnirQcoX+Vl8m0ma6QBDtPWNPkLN1S/SkG8GLrQa4vlzloLVgewuj7MYAj7ManN0mpgMYa+ocmAdngqmBQF/wJ9ntrGuFyU++Uk/UJ2yFAMCiDJ15OAR5eP4MpW/+sTwXrqplqGP9+T6Xen;25:bvR98TkKFCyZbEn4C/2pXmTFGGHVRhpCqYbtDdsLow5w1mhzVGAAgC6RwWUfzH7VOkk+hGY4AJ7lg+qVfORjn0pfilDic7KcXDJRrMvwzLEVeGIPRhte5zcfwZRpBAuSZAq7GJO+0ZqWvw8HAm8Ntn39sgIpdF9DCh3m+TEIJe8X4ZvfG+Z5sI3fhmC+vfBCv8xYQrVWIfWjcDN3LWN9NwmFcsROA+ZnLHZj8535WX35yD13gUkpd1qBeF96XArOpW3PezilnvU/iUgpGn2usOUxu3PKV3AKYnrc7WKls1hq/W0pvOJN7cXLw2Ys5B2pYT2OxgRXhUFrCOIpShodSNgGLbAI71NAcdUmPyi2omU=;31:z0X6cn+pgC4I5sLUT+MBATFfIgFgZl6Gv3D9BgylhswDzjD44wTWOHXCIGZ/viKmW1ZFL5YCd9vWoCH3AkCXUZlme+JVG/RiqcpvYctuTNQI0W+0D6A430H17Iln0nz6NONRTl7O6Jaw/TpERupR9cL+AxZhnw+tHemzfGaqRu8do8GVKTiyUI7RK76BkrVKzLXQ0QgI/wXZiBrOfQOfOtUM1Pv+iPH47rOhHr2g+2I=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0690:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;20:8lDWKbg/4rHZecNIVGe0cjBt/+56vhp9ixjQYJPg5rYmBokd4ol0KbsYALqPztPccf+4zsVPaR+fTIqRQt8HUDtrWxF9olOF2CWxYuA5CUfIi3CuOuLKU73skGfJpW10gcnPQZKLlxMjDjR5bg7gfbQoW5RZUcmPA7jf0unum7Q9QSYB5FHYPGdfpkNVouI8V/rg9pESTYHyqHPu5WQAtxrlfuskE3thYMCZO1ouuKSkJk6ZgLHrlGyR00YyH4f9KYXLo9LFlXR+mR2dKpytfRCfbEHi1RrdPBJ8A2J5QNR2l+J7j8dhUlFVxE1YMxdQopnyvWUOw5iHMNm0OhluKx6c3oqs+xoZpflffBt1+q2Ke3o6y+K3FGioTGd0PSUc6AIsNCSrPoXyESZllUo1kt3bLs80C8CoN1ehADtfVMeIzPDzaRRv7Vk3xMw/LZH0twz4WPpD5TNiXjmBPbaHj+3gwpiMn/LPi1vxpx2Hn49bIgiZpgKFozEQON24U1l8;4:154T6OjuWh5La1S0rPV3s9Cx7goCe6IZm7lTdIEy9E1bOXujuIAgKXMgvX6G2mRjOpK0a7yyWfufI/K26PCfVykbjn7MjZkZCeKvVfOpCI/nuZLOKWzOibFH6encU3vtXpcX9L9JgJKQliRkFqOW7g6Jll2eFlLD9Ka5Uv4LrqPl1p684jIhwTAM6tcTb5iK8x9Pn93XLEPvQ487r0LeQgAp45M3S0iasNb5HxfsXk1obrK65rKLSsfuPfcCxNFCy/pK1LdvbIO+x87tftpt2MoQ3lZd5kpeFOYPzdsz1S3xl9d/goseOtrj7+qwLOJ4
X-Microsoft-Antispam-PRVS: <BLUPR12MB0690366F5391F3D28524C46BFDD10@BLUPR12MB0690.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR12MB0690;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0690;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(189003)(199004)(2486003)(7696005)(6116002)(66066001)(6916009)(6666003)(2950100002)(5660300001)(53936002)(2906002)(52116002)(186003)(26005)(23676004)(50466002)(25786009)(4326008)(103116003)(386003)(16526019)(86362001)(316002)(8676002)(68736007)(106356001)(97736004)(305945005)(47776003)(8936002)(3846002)(478600001)(105586002)(72206003)(2361001)(230700001)(7736002)(2351001)(81156014)(55016002)(58126008)(81166006)(53416004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0690;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkwOzIzOklqTVhPcWpMT2dWMmZKaFJDVHhQM0l6aUMz?=
 =?utf-8?B?eW5sSmpDeWVIZ2FrbStRSStHWU1wZE9wU3VHM2NjTU5lNThTeGZTdDYvWVpS?=
 =?utf-8?B?anp1bW9EWFlYSGpyanY5WnhrWXZ1dGJFUFdGSFI4c3ZudmN4NDRkSmlQTlo0?=
 =?utf-8?B?N0VnRThUWkNDSndNa3FJR2dYUk5NaTJkYzBDZDZTczEvQWpFd1BJU0EyVyt6?=
 =?utf-8?B?cEZHQW5zckEvS1NkVnBnb1BkL05CaDZRMEJyWWViZmMrc0N2TXdPdVZ0S3lt?=
 =?utf-8?B?UHdrTnJTZWxjL0VjcldYeXlKR3UwT0lCcHNHcG5TcmE5Q2VNMzFNTkJTL3pY?=
 =?utf-8?B?QTFaRnl1Y0t1M3NHYy92QldLb0UvOXZORmxQd2xVSzA5MlhJbzNjQk5vVnVV?=
 =?utf-8?B?YnJ1QTZpUXAvOTZUVHJUNG1ZK1dmL2NobVNKd1FERVdNTDl3dnQ3UmxTMWcy?=
 =?utf-8?B?U2dWcEs2SnBaQ21LVVVQMEZsV25hSzlMZ1NIcVpRWUpTZjg2ZUpzYnAzUFRQ?=
 =?utf-8?B?Y29QVW9TRGxjNGlsVWl1Tit3T1BFcUNrL1pzR2VCZ2NwYi8wTHd1KzlCU0xz?=
 =?utf-8?B?SWFqY3lGajRWYzZJMnAzcTk0YW1yVnVXanZjZEJ6R2FFSkx6MTBROGNja2ph?=
 =?utf-8?B?NW81TGpTY1dnbFlpVFNnV0drR2l6TmY4eGdGYXBOSlBrK0ZKUE9ucmwrVU8y?=
 =?utf-8?B?NStVMW5ZOFp5bXJXcUhqcE5jZG9sbTVhMzVDaEhlenV5elJWK3hxYnhHYXh6?=
 =?utf-8?B?enYwcTRwczYwcDJtRndPTkJSckx3ckR1SzRPQU5ER3Y0b0xKRlZ3QWxHbU0v?=
 =?utf-8?B?UUMvQXcxZWZTUzRjZzZuTDdmTE14Q3J0OHFsWUdpUi9wYjlvdEFmRWlObFI2?=
 =?utf-8?B?dm9xY1U3emNzc3A3ck8xMWFuSDlSVk9Nc0Z1bkphTmZDZHRrcllJS3hhUExJ?=
 =?utf-8?B?cGZvVGExOU56SFN6MWZOWXZSbk56S0phUkphN2ZiZng1SGZoRjhOcHNuTENV?=
 =?utf-8?B?cTBOcDdXKzdRTHRxdHk4dHlGbUY0L0hPamVGVU54STFwTWc1MDJIdzNqdGpV?=
 =?utf-8?B?R1ZiS24zUzdCaUlHUE1HNWU5SElLRGJhNDVmQ1gyc0c3ZVhOY3NldjF5MXFG?=
 =?utf-8?B?cGFkS1F1VFA3TVNQSzN6ZnhkZDk4TGo1ODZoc1VsVGdzOUYwNSsvdzVYL1I4?=
 =?utf-8?B?ZktybEsvdFg1SlpSc2s0bkRVUGt3RlB4SFRvK0o0NG5VTnMxSFpRUFIyUlFO?=
 =?utf-8?B?dFR3R0xTV0tPanY3RktDTFZKS2JzMUxCQ01SZEdtbTkyc3kvQTl1NmJ3ZGdk?=
 =?utf-8?B?N1k3dUlzUzZXQmpDb3oxN3FwZktBaDNrV3F3TFUrR09hT1V1d0tFdy9hajNS?=
 =?utf-8?B?Uk5JNzMvTUhZTnhjb2M1a0V3L1VKQWp2d2ovWXZ1ODNJQ2VKTUcrYW9ZbzBP?=
 =?utf-8?B?bVdhYkxnKzIwQVlPL1BtTk5NREp1c1dZdU5TL1ptZGpXSzRtZE53bko3NVVX?=
 =?utf-8?B?SHd3d0FmbElYVksrYzYyc21lenNmRDB0VGgrUmR2UFlBVE13RmtwSmYvOVps?=
 =?utf-8?B?S2NzaW85SlZLMVZZRlNNQXVYaGJtSWc9PQ==?=
X-Microsoft-Antispam-Message-Info: uuBlO4tqAltWEAd1IZTyDqP891hK9sN3oS5u63uc/QmCFKXeJz2zxdfL8lnW91sxIhEJ9gKlaBO0TAjO0m7F571ApnzZbEw2ktyVtYmJbadQd9b7P5EYYIbrOeNOH0b7x+GGm45Jq+v7jS1qkGIEF9K0J7nvtT7PinbW/bthNBilU+dS/KKRp9ANA38sd372
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;6:HCZeTnGiYfDRjxbUvMDRxeSuCiWthsVnB2FyiMjktvzpqMz3IoYSHQk6+GSgfjuxSmNuioRrylswbY/ifdMqMtNi8XJQ7bVfloZMfxtai08qEaLoVSv1cUlyzsjqDv6sdMZMnCSy10IfgXjGDDXn4KYKCDaTG9vuOMInPyllFS49wKit694C6oLt0XYTqCSPy+uQkUVLA/JDlCbYVAMERJAfZQ+djZq17J2d6xkXQXKOZCCvHOTSk9wlcWE08wFeV+/gm+r3Acjn6FFB2wd8ZGjioSyaPxU/DybhqlgeuUk1BnlArxEpMBGfHNz4J+cyoTMz5q4SHAFg0GS31geh/74Dp9hKqhUX0pLhWb2EYxA=;5:nDxth5q2Yvf8/W2Re+Pz8Ck9r7ADIzpWu5zura3jlUG9FaFbwrAaUbMy30naZyGsY9BBSsEBNEC7xkC8LoVSUsdJ5UAl7sPoem4byOmDfMwKS5El3i6ObdGmO1s13MN36gSmSdW7yx7x0XT803gF5hv6axuu2UL5tYC4+CsLT9o=;24:UU3OxvrHJpq8uMivlYYPZXtI/eYXR3dSRBGFrKrVxcFQOMF2lrcaCd3vQ71h+hDcbZnwYp97VGvgB99K7KpIj7Xt6Cr0dsblUVZy0Cvhxu4=;7:Oh/wR/X7K2iJceEITu1xG9m4QEHTENYM/HqGBkuMCWOnCKCk9W2JS+J9V13GQ6kmIRchJ2jw7f8b94QlmdJnr7KxQXkWJKnjwHyofSLU1RFy778BZYZ5DbGK6hwYLDg+KI6hYFiZ2sFNMlOXk1vhW5qXK8jgCIM/7mqVzqF29qGSe4IQbLTkh4MKZSqW419Xl5UYqAD0FPr6Qq5w1y0CnjUR/HMBips9F04cVX1k4iqszJjxoIBgsX70Un8xX+dS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;20:HHO094HGV20R52/U/rfLpQPzoZQz+/nvEiU3ArKw5+Ze+l1vSF4L0EW580CBRJ73GNhJxMHi+z1wP1UXWxD5+ipR0vbM5+K+ZnhxMyLgX2wygVkZWwFZxi3kVS2/518w7yNVlNpFhmAr5yVcWJZdKQxnmIaCDPvL7gmJXXTiBe3mE0l7Zm4ieeGNiu3tgebFwVccfKDkYBjGnsQHj48SONDNdcuwexsAG1LRRn+DSfG8BDAUXK3KZOSzfTh16flE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 23:05:19.6231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5640674-f92f-471b-eb94-08d58a000f08
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0690
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide help text via a filesystem entry

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 170863e5e86b..d95428b1ef90 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -92,6 +92,31 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+static char readmetext[] =
+"count                   Count of active devices\n"
+"verbose                 Provide additional descriptive text\n"
+"\n";
+
+static ssize_t amd_iommu_debugfs_readme_read(struct file *filp,
+				      char __user *ubuf,
+				      size_t count, loff_t *offp)
+{
+	ssize_t ret;
+
+	ret = simple_read_from_buffer(ubuf, count, offp,
+				      readmetext, strlen(readmetext));
+
+	return ret;
+}
+
+
+static const struct file_operations amd_iommu_debugfs_readme_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_readme_read,
+	.write = NULL,
+};
+
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 {
 	char name[MAX_NAME_LEN + 1];
@@ -125,6 +150,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!d_dte)
 		goto err;
 
+	d_dte = debugfs_create_file("README", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_readme_ops);
+	if (!d_dte)
+		goto err;
+
 	return;
 
 err:
