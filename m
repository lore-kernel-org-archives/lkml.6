Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEATxA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:53:00 -0400
Received: from mail-by2nam01on0079.outbound.protection.outlook.com ([104.47.34.79]:51024
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751275AbeEATw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:52:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH 1/2] iommu/amd - Update the PASID information printed to the
 system log
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 14:52:52 -0500
Message-ID: <152520437211.30928.8410126837908568791.stgit@taos>
In-Reply-To: <152520429853.30928.9793486018349326103.stgit@taos>
References: <152520429853.30928.9793486018349326103.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:zzs5HwoRuKrApkLsCEUBk7aedX+AfwnFK55VvEx9Be5ek5rKyn4bWPzK5ZmsyBWaAkiIwRR1YG2Beb0j0HaVrgsu0lKmL/bXwH27bucWqnDhR5t6RcSQmg3XwsWtZ68nurum46N1QCcn4yhiy5/bLJyWiZorFWZCSBKGGPB/1NvI6dGhN3Rm/QJ7NtG+2K3EUrOx574N/wotmOx91P1CA6wUOIydhzb+HE9gN+WfOEAauuaZP+hkb09MrnR3TxhG;25:SQm5fKrxNkLLOlnRH6xEAUdZEWqs+YgelC3RWLeCXX3han1uqta+aMklJjVhlQ6HCrQ3xTHkyBg9qQ4lbqiDfkqJi0adAN43P+xz3P3mhKZ81pwDV/bcsUS9xrGH2TBG9x7Wbep6/jWVfc2AuFnxF96YKpb1QCD5zLCOFGC3CMiow/g23cLuHLoG0Rq00x+iFaLKufZASy8fW99xklRJ0P6iXj7T1cDDyw1i2VlinDQUF2cJUe4/XoxbSEOS9h3sQ3OhpwKgXHgW+GIkvomTOQVix+i7Ml3wY8ilsPDu2A7X4bHVnva+oLwnIHLIlsZh9Gq5mAJgJRj8Ce5t46PzOw==;31:5MkvTVWUCLP5TzI/xJnvuo1gkJi4g7FOtlVfq5TAh31lEqVg8rCj0cyCv58B7r6pS0mOSGDZwryIn9DogE3/MEyvd2M7sTQCdPqpx/HppcnBIctwxmACyJXKwdML3Qdd7tjMtk68PDUOwQ4r8QH4Ntzo/rgUdNJC+N3PrkG1kLuwIsXfFjFx1T6lD0SSiKeYjH3h+KHHQaT0FSPHlW8PqaF+CP3a/EA8sS19mZI9BnY=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:ZHsM7+3dEJ1ibtTAkDJbVqqM0oDJ4gw86bCB7v7RPWGlvp8NyTDvznEkvEiSvgo1ggXkxuvZrijGsWsBqpsbWMne8aGfpHEBOvmaou7/LZbYCWECr/f5VVUuPbS/vE4nlsmIkmENvjCw9/mwySQ4Mmhp8OEg/JMqPQsZ+dtKCs6/lGJATe0vDQ/lwcFJfM89kki2ifEn5Lzk9RWz9P48DUa6lafxRj1VDFpWeUqRn071r6BNjY7XEmrtSP/4dQuM9GfozyjQgySZDLmTkr630kw5jWemrZGND0SlxAjFI0UdOm1zZizyUcaLUuWIxs6Ca8soIuoAEU087/vbXnIzi/RBOHZQp+UGmFyoiI8Pe7D+eAdIrHuEHuxvCxs35omC/U6gYBYb17Gk7+1A07xhaicsSaVyndtnaJSBh1jfIY/nNwJD2ghZ1j6Ow5daebBSsyuy2xi5zUFaNcPW+lRUZf6/TPCN8r+sorLx/H0UUUU9RhJvp42zis/ka6WnRFbn;4:z1zkKupHMOsaVkvSKc6m015SWC5rZ6LNsgacYA+N+RQ6FYNJqxKR3HclcuZu8v/kgHJcfMndptZ/sEzMtT77h+mHyTDKHPLIe+N2MQidos80v9elyHqZWpEiNsFZ9t8nBo2TQM8urmWyGuMkU2Ij/19dtVD9qxoXD224nu8dHe4JhBbQiLB3YNlbCaYTF5zTd246fKrz/VwTbXBfxBubhMyfAyYhG8OxNV42WXJtWDleapyjfnibXLnoWeE+1fXG0yiU+546e9q4gan8s9KYiDyEO9LTDdQCUjHIZsYA39uPYbe14rp/291SzglBhMQx
X-Microsoft-Antispam-PRVS: <SN1PR12MB07024573E08FA956D4D3416EFD810@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 06592CCE58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(366004)(396003)(376002)(39860400002)(346002)(39380400002)(189003)(199004)(2906002)(316002)(476003)(50466002)(478600001)(81156014)(4326008)(53936002)(7736002)(25786009)(105586002)(47776003)(186003)(16576012)(58126008)(16526019)(230700001)(68736007)(66066001)(2361001)(9686003)(956004)(5660300001)(486006)(77096007)(103116003)(81166006)(11346002)(8676002)(23676004)(6116002)(59450400001)(97736004)(446003)(3846002)(305945005)(33896004)(106356001)(386003)(6486002)(8936002)(86362001)(52116002)(2486003)(76176011)(26005)(2351001)(72206003)(6916009)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOnF5Z0w2Sy9VV1d0K090UmtzWjNyM0s5bmR2?=
 =?utf-8?B?MGl2QXkxQWFZb0RJRVVnNi83Q3NIckVnYWY5NXRka2NKSGFhSnR6QU1KaVlv?=
 =?utf-8?B?TkVGdGlUck5xaG1vM3kyUi93dkFhMm9oRzFkR21SSlRld1ZMbzJrbXVWVDFK?=
 =?utf-8?B?NnVpbmw5a2s2M1Flb21nQVh4Vi9hcjExaXZha3ZOVDZuTXVwOGxDTk82MjRC?=
 =?utf-8?B?cXR6eURGZW5ZVTEvQURWUHFOd3BxZHZkR1hNb2pSNTZ2ZVEydmZ3YnROMDVL?=
 =?utf-8?B?MkFBck96YVcwZlZlVzRFVWxZZGloZ0FDMGpyT3Axa2lKRHlJRU1RUStIZVdV?=
 =?utf-8?B?aHRyODhKT2RpK3o4NUtTT2FnUHlvVG1nUlhVcVhkc2tZVDJVdTVRS0E4YnlJ?=
 =?utf-8?B?OHpUcW1JWFQ2RWxuV0lDUmNJK0FmOUlFcjVqK3FaZDExM0xBK0pjdlR3YUE5?=
 =?utf-8?B?elFOeFh1MmJHdWVOUWJ6dWtqRUJkUWo5WnlIejRoWUZvQVVYQ0tmWFdnejc2?=
 =?utf-8?B?WEpuZTdOWGhOWHpzWk9rckFiZHBpclpmRjRMeTFDUGF2QmxBQnFIQlRNZ3Y3?=
 =?utf-8?B?cG9DUWxoV3ZYOXR0b0VUMXVMdFJDTFg1R1dlcmpKR3g1a2VBQlpuSzVRanZ5?=
 =?utf-8?B?S29Lb283c29Ed2VDaEhuNVNRWXVjL2psR09Oc0pkREQ4eHd5VzNEalpqWm5y?=
 =?utf-8?B?YmZib3dmTThWNU5RWGEyVzBEM0YrSkM3VXlqRHYwaWhWKzFVdHBPM0xFSmcw?=
 =?utf-8?B?L1VMM011dmNlQzBjbk1ERGNhK1NlTTBOT2ovbEgwakV2SjJvbUFid0tibEhC?=
 =?utf-8?B?Vk56ZW94b3o3dmZOK0doL0hyRWxCYkExTGJ5R1lHZWtJOWlnVXpLb1dvcFVz?=
 =?utf-8?B?cWZtT0JSaitZZldXVVBETzFwU1U3N0hZdFhpV0N4b3krcldaN2NpQ3ZpZVc5?=
 =?utf-8?B?cmJMRjJhWXJGSTR1VElYbjEzSXRFSU5FeUttSXFTS2tORVJnbW1KUlZmQTJB?=
 =?utf-8?B?dmRwRnNMeWp1SmJQRVBPMzBBeXNPaGU5L093bGMwOWlXOTBaWDRna1hPajRY?=
 =?utf-8?B?dlc4Qmg4VlZGaXZNVldId0Z6ZlJhUldyN2M0d1I5NytuSGFiNjVqTlBja2hB?=
 =?utf-8?B?VEhnQ0syN1NLNGVRNHdlMWh2ejNKNEtpYSs3QUxUeFh3eHlvUnlOWnNxbTVP?=
 =?utf-8?B?bjhlODlBVXVOV3BYMS9JWWQ1TWU0bk0xRFNaK25yNk83SzFneUFrNjVCQTA1?=
 =?utf-8?B?SUR0bHdnWTcvdklOczJyWThXRkY3SDBwcDI3YXpQUmhMVDQxajE5SitBeDdJ?=
 =?utf-8?B?WjIyQ1pXTnNlRVNuS1ZnRXMyellSd2J0aHo5VTIxL3FRcWpVK2JyRkJBMGpy?=
 =?utf-8?B?VWJsME9NbFJ5Y3hZVlBZNmFJUDkwMXRSK2s3cnZjVDVwUG1YY2JjdlJrWDdP?=
 =?utf-8?B?TVE4RVRpUWtmRzVPd21LVGpzaVZ6RXRFSlFsMDdtOWp3ZTdlblhieVozZXVq?=
 =?utf-8?B?NkhKSU0vU25JVlV1N3AydzZBMS9vcFRYZzBsc1Vpcm8xbE5VVFJnWEpuQmJx?=
 =?utf-8?B?ZXBFNHA2eG14My9nQUg4Tm1XRzRIeFUwczRVcGRFTjZFa0Z0QkIxeE1Nd3N5?=
 =?utf-8?B?VVphQlRIanNzeEtvajVXMWpCK1lxMWQzclZqaGdsZmUxRC9obG9INnlpQkFl?=
 =?utf-8?B?VnBvTVBKYTFGc0lpRXZmQ1pnT3pIK0VnbWIrdUp1Qkg5NzhRRElBd3JkUHMv?=
 =?utf-8?B?a045dUNMNzVjVDQwdGJiWVFBYzN5MFJMQWhVTTliMS9JQzFEVDBhR3RkQTZ6?=
 =?utf-8?Q?wcV3QWfchHm3I?=
X-Microsoft-Antispam-Message-Info: MIw4KvGNtrXPp/Phol2n1RUl8hjNfaee1U1//oWQrmKxZBItG8/+NbC1jx/uqUBF2gy240l1/svZM0snbLhumvW50co+OD8uNGgmrSJuxdBAj7Lv1q6BUAwcU7N603Y2tkA66extK8vF9t7x6n+YpwmkHF1Cc9iIdqaesG7MAd5SAZwHtEHgGECdhuf0dwgr
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:3CeyADRSmcyWNfarIR51lvqaCS7zT6Tll257cOS/QP5aWxxx4bLd3p86EdbVnfyTL5hygqW3aE4WxlhYqwEMw1osd1ryCwNBzs8HvqfDApZz+yf2agZ702wNUHjRx6fb5oYZE/+MQNSkToH40OSbqNJmheOozU1aokPCdXAm2i5bK8/Sa3iiuGYYk++LAXFGRmuXjq+XX7HX558YC359TOaEI7lCnGoc7zy8sIQlVzXV78+XjKiLh5p3W0KsfThhsOaRSKbxkQZdvdMfqnsHygMGhQb1RzXtLUmqx4fy02KwOuN907tgJdVjSAxNEpOhhxI0ocbxr+kBzUOEfP8HSNJgB3TFcZzNVIQIwbL2bDKsebsnUKGljo+vx0K+9lLW6lrrq+PTAVQv+hQAoS5rldv2SJ19MSYJGJiYf83hfWWwZtt9ngqMsSWxyKHMccvtALGpINpVS9IRmgRfmnvC5w==;5:O7WqjtY87uaeEaSPO/djhNaSxvxVvL1h5K8EsMJrcFKFDYpmCw7LPeWwlYlt1Zak0HY9gb/KG+ueN7S2MtCG1yh2K0kH6tWEQ+oHmR5k0SuN5uZnbmKikSmFg70+mC5Ka+fvSVc6OF7b4TTDqJ+mozjT/K5HN3Qak8J71p9KIxU=;24:mh1Sdl4nFr3Pu4I00+gdDLZJXjfCtiqH/B65ZwiAosnii4/F9l3L3ZcU1ahGOdXiPzllfe0cIT421QcGVImdrzkxWLz/8PliB/382hF721s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;7:fdowxKLoil50AGhoRTB1mbAYQKEwnJfcUxwsTkXiZH+BvL66nHDo/WT1f7r0BN3E8P8JI+Oh3+Reh+vQoyxxveXvHxRJOsZ2KqdnKX2pp3jp0P5wvjeZ/FiC+9iwzdjRXGH4BSrCpObm1x2CCkUy/wRkFnO2OWmheHPtw4B5KWFa1VHOp2QsobgljjGLuaGqjdGbhBROtQVnECxBlL8r5M1Teym2tptIWUERvnAObAANLWN6pvbQgKzS5eFdEe+A;20:/LVTv477c5PRxBe11LD0OjwC5R3cB2aSj/UuxOHTzX5dSP5qUeumFYjnZcBtK4YPjJlQ/yzNNoi6OWO8Gvo8+lmRzPYdykjusloX7JSy2lFjP99pjt6E6hG/k2ntocZzmOEO4fUzdGQW/WTyBvsdkBti7lh1k0yRWrKBh3XGWYQCvIBGL3Ppiz0cZqBkeyX6AN9j3FjwlFW8D7mehxKBcufOaitBYkmt+Rhho071kyvbBUYLkUrZdWBOWWU7+Bc0
X-MS-Office365-Filtering-Correlation-Id: fdda26df-0678-4056-fe9b-08d5af9d2181
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 19:52:54.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdda26df-0678-4056-fe9b-08d5af9d2181
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide detailed data for each event, as appropriate.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8c469b51185f..a557565d4413 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -544,7 +544,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
 	struct device *dev = iommu->iommu.dev;
-	int type, devid, domid, flags;
+	int type, devid, pasid, flags;
 	volatile u32 *event = __evt;
 	int count = 0;
 	u64 address;
@@ -552,7 +552,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 retry:
 	type    = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
 	devid   = (event[0] >> EVENT_DEVID_SHIFT) & EVENT_DEVID_MASK;
-	domid   = (event[1] >> EVENT_DOMID_SHIFT) & EVENT_DOMID_MASK;
+	pasid   = PPR_PASID(*(u64 *)&event[0]);
 	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	address = (u64)(((u64)event[3]) << 32) | event[2];
 
@@ -567,7 +567,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	}
 
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(devid, domid, address, flags);
+		amd_iommu_report_page_fault(devid, pasid, address, flags);
 		return;
 	} else {
 		dev_err(dev, "AMD-Vi: Event logged [");
@@ -575,10 +575,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
-			"address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			address, flags);
+			pasid, address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
@@ -588,34 +587,30 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-			"domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			domid, address, flags);
+			pasid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
 		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
-		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx "
-			"flags=0x%04x]\n", address, flags);
+		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
+			address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x "
-			"address=0x%016llx]\n",
+		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x "
-			"address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			address, flags);
+			pasid, address, flags);
 		break;
 	default:
-		dev_err(dev, KERN_ERR "UNKNOWN event[0]=0x%08x event[1]=0x%08x "
-			"event[2]=0x%08x event[3]=0x%08x\n",
+		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
 	}
 
