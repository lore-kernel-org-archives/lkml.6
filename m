Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeEATxI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:53:08 -0400
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:47481
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751275AbeEATxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:53:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH 2/2] iommu/amd - Update logging information for new event
 type
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 14:53:00 -0500
Message-ID: <152520438022.30928.18122180240633468855.stgit@taos>
In-Reply-To: <152520429853.30928.9793486018349326103.stgit@taos>
References: <152520429853.30928.9793486018349326103.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To SN1PR12MB0703.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0703;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;3:IEPSgHsu6OByZAyiBJ2T3OVCeie8m87wvS1msjhGTxuYhNHNVzaE+vR7O1z+4XCYk+hMPBIWHoxmx7UDN81gay3WlzXW/xCS6aBciPX8f0nCPsZbaeYVyIuQl+wjvqYVQhWlu0syN+7zCQlNm2sAjhajFMJbRPkz95sPFZhBlMcpVrkDQGuTF4vTPToJJtDrbmzLi9nqEm915GzzyMD7AhR7LAGVJvkzj7wg9g3xiWaG7BaFu8iyVmAf9VABGDyo;25:mXNUbjJYX+jwvdbspU6H/wMppfKSY4S55EbxazPJ1Wf9icOY52volMpCTC7VOvxuGgXBaj88ExECywht/QgjvhGEmJfljeyV8//EOTj0wfWxG1Fb3wDLcwNoBU+aIqmmSmO15L4jM8SDl00yrVSmm0d0ncTnT36wmPYs/Oq9bcDTPs7OQuHrL1bE+z7j8H2F8X4DD4GFhmbJ7mXL86v1AZ5RU5O0+jUriWef2vkMDMGOaCUr/ycveaP/qLM8In07NeXyZwbEL9MEbvoE+Aqj+OWbltlCJMtRB66QSqfi8FvAKanJcwn8+J8v3ODJldrY46tXxxy8XfZ9XPcNMPWk7w==;31:puojdJj3i828YnXz1i9YPKu28UQGvbRfZMqLvlJ32ILWmVhyX29VSDWWQPXndDTgmptEUgkpRXe1CRzLDmhalkU2cBiLGAWCme4B+4EO5+MbMbxNkpFnj/MSYcRbQD/KpSM+6APQtfJuiEdr5YJBix/a7xlYU1xxNvwp4Hfy641QhXRhqlSm9k7uS8JssRzBeIwqgJVDBPhNOw261cJNcSP9aqaxjUSXEisOxwsSFww=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0703:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:lwehBNmOHEJH3xWb7VVkCiYtCZVxzamvNPUh3uXWALOVhuJ5qkJmHDDq1tvybImTMqFvd00z+ndktl25VZ93AbOcxeJ5JTeMSLPuyAtbWWO2jw5JcEYAoqFac096KLjz26opzTSEvbq8eGJHWVhrf7Xu0E6+AeG0ntZ0q6svc1x2z51lnRrbLo8y6n8T8JbxTgK3zOXmgCrkvEygFP3kyWmMa1iQvlNwbvEchSnroDnYFAJ2+LWrfJbe0WLVYzizcuN1Lb+Jeoy1QVEDwy//qgg+41cppcjg+IaQPS3aB1ZEtu2Q24uAPloRjgFy8OT6hmc4sQW+kdGsZEBxKpoV8QgAD0IO4n+3ywn8vUCWfD9d+uvUUGJquXxjqAku//bO2fkfmx4/T5INc/hmPEkDElSI5zK6Iy8kErxDqoJv65dwqONlR5cnnzmynWzc1E+ppQEqAVpH4gWU3gcPsNsrfXRa1+wLRObUViXKsDCOR0B3lzA62Q9/8oGIyTj+lcDS;4:spMV+5m7CqwNn9RIr9HqYAW4SUQrkVvwa9Ve/Tm9B1UyRdn4PazjXgg+/L+gChGzJuwG7RkJIvgaS1ZOefb55U9aCUvtp7jCHD9PBw/oLD/hg1WXk3tN/EzE/FoVn3W41ETjk5aa2pJ2HogAZ2vCU+G7c2Bys14UzqrJcZ4mrIWAkkJ2RHA/kAPxhVhg8e9eVoJKX0V7mz2R7ld3Dlmu/8ZDyuTSIFcofRWmLVTgaq5fbdlnyBzhmUnYVfJkTKJ2YYo771ICoVGZ74QBA95QG28Mj2oPTUyOltDQZOCtGMhyBvTFIPtH/sBoe/6VKJiH
X-Microsoft-Antispam-PRVS: <SN1PR12MB0703EFCA8E153F151D93C818FD810@SN1PR12MB0703.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0703;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0703;
X-Forefront-PRVS: 06592CCE58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(366004)(346002)(396003)(39860400002)(39380400002)(376002)(199004)(189003)(68736007)(11346002)(66066001)(16526019)(575784001)(58126008)(23676004)(476003)(6916009)(8676002)(33896004)(81166006)(6116002)(956004)(16576012)(106356001)(446003)(86362001)(77096007)(2486003)(52116002)(3846002)(486006)(9686003)(72206003)(47776003)(2906002)(81156014)(478600001)(105586002)(186003)(7736002)(25786009)(2351001)(97736004)(6486002)(316002)(26005)(33716001)(8936002)(2361001)(230700001)(4326008)(59450400001)(76176011)(386003)(5660300001)(103116003)(53936002)(305945005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0703;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAzOzIzOmdYb1dla1NWSjg5UkFvdkNJSjlRVVhORzdE?=
 =?utf-8?B?TEZ5MUZBREZyam5jZkJ3MlVSRzNWZ1R5MXgwL3ByTmZYdmpEczRwUHozTmx2?=
 =?utf-8?B?NnkyQ25LR1hGQWhuSzI3aDJzc09mOUlHTkgvNE1xS1NpRkMzRDJZTk54RVRC?=
 =?utf-8?B?eWRROXhvOHROTndLRWpIY1pDSlJrcUNSWktqVWxJMjJJSUMzZTdZZkllWCtm?=
 =?utf-8?B?dWhJVitHUDVXUkw5QktZeFBJaDBockFsT2dSTTF4V1RhNmhTREptUER6aHZr?=
 =?utf-8?B?SWZyYkhyMlJqdXhOei9GbUxkVEVsWnhDT3NseStFdzdmbHNHc2xLNWxnNjNV?=
 =?utf-8?B?dVE5U0o5RlgvNU0zeC9PM3NqMGVqUjAwNGp2Vkw0aFQwakJ4TTZ0bDdIeExY?=
 =?utf-8?B?bGZibGhaNnVZUDNTMElWUmxMc2xCUndQSWlIdEE1S2NtZDNtNU9rM2ZwU0NI?=
 =?utf-8?B?eTNnMFRySVBYN3dwZWIrWHk5OGNHMDR1MmRLdTRJZ3lzK3JkVXFCSllpLzdO?=
 =?utf-8?B?MUJodDZKVytuTGIzTitrNXBYRldlMUNqSDhRRUljQmZtMkswdUZibEtWRm43?=
 =?utf-8?B?M05IcWlqc256VzFIOFJNdjVMMlEwN0ZwUXJHK2RWeCt2OE9jVU1PUGtiMnds?=
 =?utf-8?B?OFd6aHovRVJSWHRxM2xXQlZQUVFoQlQ2a2Y0OVRLU0d1cFNON2dEeUZlYnBV?=
 =?utf-8?B?M2ErQisrbEZEQ1luQ25PVWVxK0xyTWkyS0Fpd0FIRDUxa2JHTDVFaFBad3h2?=
 =?utf-8?B?aEYxaDgvWWs0NFdxTTV1ZzlBdG1abVVFbXE1ZzIyVUlqVFhSQ1NjYkRMU3Ay?=
 =?utf-8?B?RjYweW5QZHF4YVJIM0ZqcGJFTEsxNUUwMW1jbGFRZ3ZrZHNYd3RtS1F6Ky9k?=
 =?utf-8?B?S1BtRzZUcjllRE9BSlNQQ3VoeVQ0WkJscXcwNUxpZ0p0c0M5NVE2eWQvNFNL?=
 =?utf-8?B?TnhXRGh6R3NCRUp3MFZFOFlxV1ErQVMydVZCZWFPZWdjZUVzblZxakdOOE5L?=
 =?utf-8?B?VEpkRWJ3R1pNQ1BFMzBIU3hXZGNXd0h0V1M2KzVIUU5Yc3N6Ulpma0M1WnVU?=
 =?utf-8?B?VHRPcnVKTVI2bkUyalQ0UVFVVVA3aE14ZGpLOWlOTEtsQStVNS81bHdoNFJM?=
 =?utf-8?B?VU5hM2h5ekNQbisxQjhSa3A3bHFyTzVIdFYyZi9obytaamZwWXltZk1GK25w?=
 =?utf-8?B?U3FiS3VtWjFYRUhQWmpQRTlGaWpCT2lIMTQ4bXlOc3hMa3BNNHFkaENVKzlI?=
 =?utf-8?B?NXU4MmQzL1liUHAvTktOU3pERG93MzdCUjZNRm1IUmJBeHViY2crV1VFMXdK?=
 =?utf-8?B?YlpGbE0vcEhyazJSL0NIYXVTZENYL2Z5d2lvOGt5RUdJMjlRdytlUU9NR3hr?=
 =?utf-8?B?dlNGQkdvWllXdUdpSitYS0FPbGlaYTB4MDdUbTM5Y1dTT0dtYWV5M2hxRE9v?=
 =?utf-8?B?alRPMVE5RmM5bFlmejA1cnRRQjJTNUJDOUhHdloxZSt0SlRIbGJZaHVnYmhp?=
 =?utf-8?B?djBwSjg0enJUWGNJbzgraUdXMXp0b2htZ25RUTUvaWMrbmFFd1BkODY4dXF3?=
 =?utf-8?B?c3E5ZHE0M29hRkljMkpDTENVWnRxY1dDQ3JyZ0Y3Tytzc1liU040Q0svWEE5?=
 =?utf-8?B?ZVQvNlB2ZWtqYWNrNEFpRFU2WXd5Wmg1aDJScUd5MmxmeGZYYjJIbWpzcmZw?=
 =?utf-8?B?UkpYWGhueW5kcHZoeU1hOXZOOU1LSGVSSVp1YXZLUk9TNHg0a0F2Y25vcGlQ?=
 =?utf-8?B?eVpnallvYzRnaFR1ai8wTG14ZGFpbm5LVE0rSXMvTmJhUTRPRXYxTEFqYStq?=
 =?utf-8?B?ajVsUWI4MFdyUTNxdnJzZStkQXE0MnRzVy9sdFBBOWFIMUE9PQ==?=
X-Microsoft-Antispam-Message-Info: knl3tD/wKyGIE/LtAwgqxLCkqOC9bgW1QlzOitXpErV41ADYJoW4+XBGajO4zLbhcNpaJTpHaZggdOmjNpI+ZmoMsWSvacQXfLZaWcCzUbBXA8EsL+BzmJLeitYWlzjpPZQuxniRGgT7mKcrGLC6aOlpfidfDNo8vct5KL/Qy5N0cJZG08aT5b78z4rEKVBm
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;6:45eOnDxYfFuNsxAhropAunIVTA1iD/D4PIkj0v44ujZarjxC5yLSS5IniA+lCiPHgXpINq30xg9qFHI2wddE2c6+SpOjMDYqhfr7K/i42PRYungCxLarRVQ3R6dX/t9V4bTTknvPFLwp0kcRC+mH/5UNdMcb3Z2y+VCKvWXmSehNRsFuptryuFiyZYSFv3vWmo/VDe/2/7ZlAkXrV/0Xy0UgcRPMgDe5dVEDIc70z/PMFTaBC7IzULUitFcomHn2QSWHOzM1hMQxmbQp/+kpe6q38UqVKFnTQzA0r5fcuwd6+nhMjxDHXRm77wJ4UYtbfaLk4Mhj5rlv2mnhDdhL3xTX2nZa7InREWCrlqqMXJvi56Td7oHTD3ElrTfqfWgmRYF3njaD6BoxxhMJNdtC1/QLdubxx2tUGJM6aKiLZYp6fT/aleGJxMX4WyEuphGAHTH+rEm6TdASNdMd4csKbQ==;5:jo5qLvGB5qavuVBDYKS/twUNoEdmo+Hv1YIJlzY02x7gPxGQgrf2mJNC7TrCtxeAB+2mEKM1JR727dpx3I+UDi7E0sz/81jBAssZ1ZzNobtpToqDvlg7W1AOIQmhJ7hK/zZ7ORFDAQ4DSPW8d3LH5EtLUpNkeRJYxZzL3OBd26g=;24:E2GtenzZU1whgVZjAJAHxKWtIVLQq3FFksjhyhO5VV2K/rqvoxVPBJmr0Dk5bnbBYYqlcW0kKMwKDng0hefK0cWfYyRILp8Y6TbL12DsSAs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;7:Bur6i7mGaYN9uOVhFdvuuEzrzcEPQRp8wfCQYQxqBOzg1AdVr1Kvu+oKCsDEsADf4D9LjKJ4q0F7jXalVvbHVyxhsaBPHTuOuMhqOj6yD/K+BHnFwLIKesJsshyVZcaOqHxLYUwWMNbkeNb8FtHrkHdhW3WkrLPTOYkE6mLFtfb+u2O6ZVqNf1BrQ8wn1GDhLdrH8EVGdGl96qOOrRTKGIxr4VaDRKExM2D++7b/mtQdifd/cq8lNJfH/0AN/KE9;20:ei0EFRhX0a4+jruGyh6vOQAhefBNIEGdahxbSzArhVGBngFdCDoCnwD/GQ+zmeR9rsJDOvI+fhAKPTKoQGbadvzW2tRwe03FtoDmIjFb8U0LD6snSPI4wqG3c3fDv989jtNFRrN3O3mg4end7Z4Ai1uwcJa1FFVT7ob1J3rUEYAMTLiPT78OR3tgOPpbNNTkq8/0pIkePtQHNaLVoKeUTgWyj2X0oApkwQpFdSfcVe6J6joSH5ck5bemvd5B+XVg
X-MS-Office365-Filtering-Correlation-Id: 7a73551f-0d71-4f08-b5cd-08d5af9d261d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 19:53:02.5438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a73551f-0d71-4f08-b5cd-08d5af9d261d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0703
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new events have been defined in the AMD IOMMU spec:

0x09 - "invalid PPR request"

Add support for logging this type of event.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
~
~
~
---
 drivers/iommu/amd_iommu.c       |   10 +++++++++-
 drivers/iommu/amd_iommu_types.h |    1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a557565d4413..009c6d801fae 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -544,7 +544,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
 	struct device *dev = iommu->iommu.dev;
-	int type, devid, pasid, flags;
+	int type, devid, pasid, flags, tag;
 	volatile u32 *event = __evt;
 	int count = 0;
 	u64 address;
@@ -609,6 +609,14 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
+	case EVENT_TYPE_INV_PPR_REQ:
+		pasid = ((event[0] >> 16) & 0xFFFF)
+			| ((event[1] << 6) & 0xF0000);
+		tag = event[1] & 0x03FF;
+		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			pasid, address, flags);
+		break;
 	default:
 		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 1c9b080276c9..986cbe0cc189 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -133,6 +133,7 @@
 #define EVENT_TYPE_CMD_HARD_ERR	0x6
 #define EVENT_TYPE_IOTLB_INV_TO	0x7
 #define EVENT_TYPE_INV_DEV_REQ	0x8
+#define EVENT_TYPE_INV_PPR_REQ	0x9
 #define EVENT_DEVID_MASK	0xffff
 #define EVENT_DEVID_SHIFT	0
 #define EVENT_DOMID_MASK	0xffff
