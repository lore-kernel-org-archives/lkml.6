Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeAaBEf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:04:35 -0500
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:34912
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751429AbeAaBEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:04:33 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH] iommu/amd - Use dev_err to send events to the system log
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Tue, 30 Jan 2018 19:04:27 -0600
Message-ID: <151736066756.21649.4739957712713863861.stgit@sosam4>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0002.namprd21.prod.outlook.com (10.173.197.12) To
 DM5PR12MB1212.namprd12.prod.outlook.com (10.168.237.15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b07bd58c-f10c-47df-bfb0-08d5684695ff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1212;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1212;3:huN/gKm8nHDZo8wQ32DHCxScYQZg6bSPby8lMsVT5bm5sntovb/vnqS27m2hVVlu7PlPDfFJdeWibS/DpCSJYLNR/q/P62yemwZL2itiV5dx4FehVGFdYaYopHpnymtfdC64Fg3b/uo6Rd0NQsKcv067LhQw6+u7sESowzKHd8jhH8AhY7xAWmFn9YN03Vu48OLixLiYwo1me6zrB9NfnjE/6WiZnXc4kHzGm5Ys0qOtIv7axIVuZAJAoQBA9tNk;25:6AI+GyS9HE4pXnpIagG7MC77av/LPtpz0vPULji3SUiejWQITuqGkxtF6lGwSUBgdBwGCaR6EzNrWAjMIbQe7ry7sDXPapPUi5VdmyUcQZwEdG3qAIoCeJSSK1e7WT69/FWK+Bt6Zjax8DUvvtyQ5JgogP/yyetoukfY1HwiGQ7ucPWbKJ9xP7HjclIN2X0MFUmG2B3D7n5c3tRk3coqVdER+0/caEov0SxblO0VfUlOq2qYKwbPRameCYE+MxfJK4md+6ar21RefFeYzqiYJAESl3yO7NTWlnYV66IT/8997K3swSThEU/REO9X1q//4ICGsMAXO6mywz/ygsbHXQ==;31:bOIc/9JbGqgQyEG9YIzk5jGXERnNP2m5Afg/jr+puyv7UjN6W7cx8lWGmGGDnF9yE8+IXQ/pTPPq0kiCLp3uRWQujfhvt3LqTqMKhEeQcnvz1yhw9zJYnlseeR2hF0F3PNEb7aGLonWM1yDpgtGqpBUBfWp0lavjn/oHZhFvSDAjA+eMKmmTMj56HNcHGDBR8rex/2xua3SBk1iHu+lPcNopizjWdwIqN/XWFTt6TjA=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1212:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1212;20:YVbaQtNBtxKpBtj2PkXqk7G8vnxhJh8xppCvqZTq2T6B2oZtVSmKjBuEjb73rskVzlWlrmIbysmTWGo/M8xrW0ChU2Tsk36xgfFGbyzuplRi3RHoGijGCVfDFudNMU/RuH/2ewk8XabkmPt/XNn/w9eH17YGvP8Ohg9msAHuw2v5eDqi7aQ35tvgRySN5TGJFMI2wmusUfUzCEZwfaubnHDb+YLeS3D/tRN+Rv9ZzxpoXfItSVdKmvrZwO5wCkq967q49sCCpwBFG3jrUCQUu2sYTZjF+zv/zb2OXWrx4m37Hllq3E2RNLY4yxt5DAi5ABJPFH1wU8lr7GB7heNZN+CoPegryW0ZLclcKOAmBP9yg5gWKMRVuIIh0q+ZKcRCdP3wef0dYhJb7XnMb3XHUV/kwpSIYfYuvuXnsK8FuE9ExIALtncY6EtlKqyXc9LbhBseqGIOcijl95Ddp0GPSFlqDiLMoaA7nvVFLk6HvH168Y+YG764+QQfZBpQi7H8;4:GSfqb37Y4CE+mNzbNmgNWYH1XIsPoT9ZWZqAlgnl46lHAe64Gsevr8wcp0iISYKirMkED4eCIPxescBnJxBKhByeOkXU3kE7HIKKci3g+GZKpjkFT0p7zw3qNJKhEikw57KsyOBNJAf5So6/FnwBFyjhQnO74b/ewOoF/maK3byy3mIMI8Tlu+Go0GHSdEx5q8Q+JXH4vQk7ItZ/5tFkGw6RGuY2uwraBk8ecfQuguFaRlmE+vRlBzXN9MzlBWO6Z0FkMd2kCpBO4AVRPDWYz0kJ7kA6MvL17ftarCkH4YUWCbTFbyRwKZlT8reM4I45
X-Microsoft-Antispam-PRVS: <DM5PR12MB1212C382793A3F323CE641A9FDFB0@DM5PR12MB1212.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1212;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1212;
X-Forefront-PRVS: 056929CBB8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(346002)(376002)(366004)(39380400002)(396003)(39860400002)(199004)(189003)(16526019)(47776003)(83506002)(16576012)(77096007)(66066001)(8676002)(105586002)(186003)(72206003)(386003)(6666003)(59450400001)(230700001)(2486003)(86362001)(23676004)(26005)(6916009)(33896004)(81166006)(8936002)(50466002)(575784001)(6486002)(106356001)(4326008)(5660300001)(68736007)(305945005)(90366009)(103116003)(7736002)(2361001)(2906002)(58126008)(97736004)(33716001)(53936002)(52116002)(478600001)(25786009)(3846002)(316002)(9686003)(6116002)(81156014)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1212;H:[127.0.1.1];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMjEyOzIzOlR5aExFajE1djRRVC9sR1NpSzB5S3lDQXZI?=
 =?utf-8?B?ejFvdkZqZ1NCNjhkdE9hTS9mWXhtd0g5SWN0WW5XQzhhbE9vNlBOdUN3NUhS?=
 =?utf-8?B?d0lRVVhmdFJRRVkrL0xkdHMwNmJ5ck1pajRwclhaMnRqVWlIbzB6MEJMRVBt?=
 =?utf-8?B?Y1FNTGo5RE8vTkszUlVybXBNSHYvVThKcTB3RTQ1NzZyQUtoMmVXWEtDUEFw?=
 =?utf-8?B?eDhDM1RBTkJUejNGS294QUl4SnAycGlQalVXUUEwYXBXRHorc2pjc1JOTTZr?=
 =?utf-8?B?UVExYWlFbnJHSCtOQndiczFRTGx2bU1CZDZOa05TTnoyeHBGcTFzRnorL2Ft?=
 =?utf-8?B?T25FcURrVEtIRlJsUGVwVDBsU3dwemliME1OMnJNYzBiUVkzNnNnOVlNSGVS?=
 =?utf-8?B?djVrczRjR3dkOUVGNS9wSE1FT2pPNUJPdk13emJBRkxwTVFNSGcxYktpdXh4?=
 =?utf-8?B?OURsT1ZjU1VFRHRUNit3d05lQXpwNWN3YytNdG1ibWgwaUwzTUFmVzJ6aUdD?=
 =?utf-8?B?N05nZWN0ejl6YUw5cWtLY3JTQzhnNG5Eejk1eERhSnJRckRSSU10WU0wQUJU?=
 =?utf-8?B?UGkrQkFOTVYxRk5wNVI5UUhMcDFRbTJ5amVRVld6V0JCTjMzS2xtTGdGbmpo?=
 =?utf-8?B?S2l6Skd2SlR5NUtJRklhNGE0cGpqUTE0UzhDemVDNVFkTXFncWpWVkhZRFha?=
 =?utf-8?B?TE5IRjFvN0VWYXRGbGxnU3NJNFBwQXhDL0xWdFkxZ0I1Z2U1ckh4TVZGOG5s?=
 =?utf-8?B?Nm5mVVpHZ3JqZE1pMW1FVDhIeVc1emwvRXhUYnlCNVZybDRJMXMvbVYvOHd5?=
 =?utf-8?B?Z283aU5RTWczZGZBSUtHcEZIS1N6MXBSLzJNU1ZkVUNCajhXcTIxeTdqWVJa?=
 =?utf-8?B?QnVZR2FJVThsd092K3l1ektROWUzc1ByQ1o1bHBBeEhkU0lKTFRqbGJtNTVn?=
 =?utf-8?B?M3hER01lbGdCdHAvd2Q0ZWV3dSs5UWZWWEQyaHJWZjg4ejQzYlJZN2RHVzVT?=
 =?utf-8?B?V0xzS2tWNFVHbS9XbFVBd2ZFaFVuM01ESjYrY21veCtrK2FwOGdqMXBuSWdE?=
 =?utf-8?B?Mkd3ekp1TWVXbVhXbnN3THQxU0luMU1Jc2F1WXdQeVNKeWorY1hrbitoM252?=
 =?utf-8?B?ZkNhREtGa2hhTk94bXJoUnFxN3Y0S2tJZUJzY2J4L3NGcE4vRDJEbGZiM0Zx?=
 =?utf-8?B?NytjRncrVzNsRS9tRzNNT1orSmpnL3NOWWp5QTVEMkNXL01aOHRsclQrSzUz?=
 =?utf-8?B?dEF6d3ZzbzY1bDRQWEphTDVVcWhRd3h3aDNjcmJlVzM4UmZPditLT3FmMG13?=
 =?utf-8?B?b25Bc3o1cncyT2JyejdOckQ5NnEwaFBUWEdsTmJWZisvNVdXR1Rwc0FZNUJS?=
 =?utf-8?B?VHExLzVYS2JweXhLWHhGSGJGdEYydjBqV05QK21sVmJDaUhicHJwYzNaZFU5?=
 =?utf-8?B?OURONVRBTXFhS3Z6ek56Q2Jxa0ZHMFk2Wkc5Y2FJczhxQnYzSzVPekpyWnUx?=
 =?utf-8?B?N2ZHeE1Tb1VyZzhaaW4xYmljNXQ4QkJJYW0wZ1o4ZFZQZ1VsN083STVrOE0r?=
 =?utf-8?B?a1pIODhIYjViQm1DMWVsbTVBNGxWUmhDZ29PYXR4OTIxRmJ3WjgyTy9ZTHBo?=
 =?utf-8?B?WjlhTTh1Yms4elU0ZzZTRUxBSlBoVm1rZHFCVWQxUEpBTnh5TWdaVUV4OEIz?=
 =?utf-8?B?S2d2OGRwUTZWSmUrWFBGdmY2ZDAweWUxcVh0dTJvYlA1bnM2amFPNXA4Wm0r?=
 =?utf-8?Q?PeA6Y6HEyWaBJs6p0Iq3ej/lD6LahU+6Ofqnw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1212;6:tlyyp0ie6q7t6vsUrooVuCUDRqdx3miisqWMj/pInkAzxupK5XK286nHm9xrguUE8vMuFpAHv8P+sl6e8uDU7R8A+9iN57MckUYDoPIXEa9aA/IZ+bdX5zNqhNzU/8lIWLpL7TIjIHGfqdHamBskdZxvNnYS7ttepcrSxjcFro8HncqkEnaMN9Kh4Z++UiBIv8Afj2rvd3jCoGzyJnllr+WoUKcmWTc8hc1b5s9KG4pqAZGquSsJEig42kwgOSm1yAvxmkI05VlCi/ukzjHqJ5K1JthyAt8ttyBzHKPrRTMOtexRFG698kwa5SgGojYzs8REG5kIyRvQMfTXpCAMqlVuFfiEcWUPCnTu4LxdNas=;5:dXFPss1FpsMiecuvfePCdmaPo/iCC/2P1UJ0bXxelHWM1bZxd3veGFepXRv7P1AEPrNhdc0FS7MO24eqj2WDDAEzLR/ABbVijVURiPijFk6yue91TwGMyKai0jS2w12NtRHJBVaZ1MzIXkFoYvZBHUpsSRf900qgxWguKYBC5Xs=;24:g0byYeJOA+nydf5ZnzpV4y4n//Y2TOJSPMGt/SHjFE5+SnHyyPqJzw5Bgo71bE2LqaErSTr6/qrlYh49pixvBcVn/0f6ij2WUG3fKFwyT6M=;7:smDVzDphwZU+pv4oCoTgkY7wkQjjqUx5OPu0kSyI1+lzDlJ8hz+t0+BYFAaGgJ6hFUgpwtBzfmXUzuYeSlpHvkc1bJak1vus6Xn8lghS3ksYCppIFg7UQNoBuK2cWTm0BLHiKyawgxFtVZaEu0uLaRGs+7B5Xnc1KIuAcEyH8TGSmmVqSIgd6Y1EG4aXq5D1k3q73REFGCNnOJFst6jtqk+pOeqEikmGkYCbGV2N1+G2hoq9KU4d8WoccREFC6FM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1212;20:WDZ1oHOkSe1HBCjJlxjF92mdIjHfBp1xPWdc9uO/uIIkEeXhP0LosjfU1sNkY4aiK41r5AK81zR34HhxNe5+VicMbQUYgd9eRYBAicrA5jnyiza4MdZmquOoXRteXT/J2G8msv5Xb+QI1Cd/MyHxyCUH3rQ+bS272Tyj+koV/n7y8oU7pZnQ1m+zUX/pKOksnXhgeHnWFSshXzVQZjTq9CMH5jDEbWNgoAL4HxlWJXhQ4lW9oXPOwXf7zuMHIXIq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 01:04:31.0421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b07bd58c-f10c-47df-bfb0-08d5684695ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove printk and use a more preferable error logging function.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu.c |   56 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b58e0a745b7f..90a61f546bac 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -546,6 +546,8 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
+	struct pci_dev *pdev = iommu->dev;
+	struct device *dev = &pdev->dev;
 	int type, devid, domid, flags;
 	volatile u32 *event = __evt;
 	int count = 0;
@@ -572,53 +574,53 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		amd_iommu_report_page_fault(devid, domid, address, flags);
 		return;
 	} else {
-		printk(KERN_ERR "AMD-Vi: Event logged [");
+		dev_err(dev, "AMD-Vi: Event logged [");
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		printk("ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
-		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address, flags);
+		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
+			"address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		printk("DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address, flags);
+		dev_err(dev, "DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
+			"address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		printk("PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-		       "domain=0x%04x address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       domid, address, flags);
+		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
+			"domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			domid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
-		printk("ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
+		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
-		printk("COMMAND_HARDWARE_ERROR address=0x%016llx "
-		       "flags=0x%04x]\n", address, flags);
+		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx "
+			"flags=0x%04x]\n", address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		printk("IOTLB_INV_TIMEOUT device=%02x:%02x.%x "
-		       "address=0x%016llx]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address);
+		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x "
+			"address=0x%016llx]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		printk("INVALID_DEVICE_REQUEST device=%02x:%02x.%x "
-		       "address=0x%016llx flags=0x%04x]\n",
-		       PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		       address, flags);
+		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x "
+			"address=0x%016llx flags=0x%04x]\n",
+			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			address, flags);
 		break;
 	default:
-		printk(KERN_ERR "UNKNOWN type=0x%02x event[0]=0x%08x "
-		       "event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
-		       type, event[0], event[1], event[2], event[3]);
+		dev_err(dev, KERN_ERR "UNKNOWN event[0]=0x%08x event[1]=0x%08x "
+			"event[2]=0x%08x event[3]=0x%08x\n",
+			event[0], event[1], event[2], event[3]);
 	}
 
 	memset(__evt, 0, 4 * sizeof(u32));
