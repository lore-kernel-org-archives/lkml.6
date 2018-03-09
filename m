Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeCIAew (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:34:52 -0500
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:60316
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751237AbeCIAeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:34:50 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2] iommu/amd - Use dev_err to send events to the system log
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 18:34:41 -0600
Message-ID: <152055568151.107515.8442872081731932876.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:404:8e::11) To BLUPR12MB0692.namprd12.prod.outlook.com
 (2a01:111:e400:5951::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2acc44a4-37e8-4b2b-1abc-08d585558ebf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0692;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;3:zm8uCqHvBmGVl2QxJ3z8zqbmqx202ELvGegKGhjO5okj2ujWxGtaH5i+/O/7UrBIJZfypIT3eqVgwLbKiP4WVFCuNaxUMy19+UoOm9OkkCsjW0yrT/2a6qaVU7t+HT4YuhE+KG/RLT9tHFFiMoHYG3n/SvzZ/QUfh2G7xd8/ZPkTnjCZCxldyBV9MYq/WNctpj9zYahSR3EwxcyK5hiTpw32vHvm5kIcu1JCoxWRoALyXiqzQHihg0wWl8ibfP7h;25:TMSi9e6cEBuq/C58xcAz+YGj6gjUnB9vB5ky+UpJSB2qtzKpwGa27hCvPOgLwOw2q8KwbBjHgh/mF844j0fYOIo7lBA9ZXhfTbeo/VI7oJh0I3qo/7ROKggChpcNloFwoOyJ1Ay9lDQgdpgUWXRD+wuwqHfkqUF8sY92hmLrS3DU3bdMRDik7I0xcdzd16n8BtJkrt7apZBXsWGGfUGupUkk5RSKyPUqyKxS+Pup8Bru9n2HT5L+0NIH5YlV6Zyb56CxPnFhgwYWCBe3MGjZQ3av7qa1dd6UpD88HE/ZwIjounad01Z3XBH3Z7SBA6NE4lHx+lPRYGSA9V/QEGRrpQ==;31:SNAeIONpLHGYI1ryJNXynqHF+wG6CkEObj0YVaQRnkqpycdLCII9GUxj+JR2sPE5H/pr6qM4fOJepASerL0fmHN902rvumVlU4pANmMIEc/ZtgxceBSPL/gZ2Xdl4B/6IwOM9zxx9yInDCFDQ8QzOQxqGCBITbT78Kbxx45lJznrmloGuZ1Vj82a1jRi36THN+a7k/1+j7rEhBHOz0MPHuN+9gdh5Tees9xnCd+KP5E=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0692:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:DV4h+y0VWTDR64cHuARe9lqmXBC2fqIzOFCyBZF3JLp3l99fnptatbbU3a8IEqUUZTKhsxLEnzdnYaiaLUoXY6QajWjnLe6jJ5LFlXXNgd0h4Y/8VfGPAXrkhrop8bhILsMSWK0hYGGzjPIGnYWAIzO24omZ6IC3q4K90BD8ercNf4BEMF/jv9/PgNhpZoZjpkL0uUsVC+N5HrrfgcguKZ/zG6fPoqI68vufAJb20SkzJE4corZ65Re7FNBlwO67AcQoL80OyFBBjYC7rJBEzfFTy6SfvvbspZWHPmUgQmSXKZMTZZFibe0HGZHRvfG+2M6rjaFuH+0SoPOJ99uAZb7tenODciP5XGexHPe21w6LR/rYfQdvyy4qdaAo6s06IGtSjlnG43MmQHlG7+SQdPkjdOkO+8MIui8X7Q0t/FQNHM39BlnS7WvqXWQpMXmE0Y4Nk2sQwRTetXjkCB6O7KyL390kF02roCrJJkRrgRo/ksT4m7g/caKyp7AYQDX2;4:0N7uGLjoMX6fDbGOo6EvoKhuor385O7b3e17K8YeY/JQIxoX9Poe0y3hiUwJHym7FnchyaoiF62sCvhdC4tU+JXFX8FU0YMGLan++JMLbwjuWfp+KZLQXti9dnW+XlfC8Emloio13T0Trzl4C3Z6X/6ibwrIxhpiX5riFpv92Fz0m7DHXlWC5h/nL9WF2ENLHrEVk11B2HYqHPaoywwy1gmBwcDcT5f4WsexMvIvFuFEwoMwnk2uDdHkNQRvQL34VPBPeSgCquRKIZGHNlOlz39nfhM0FSWHXrinyWY2kT3cTLjWBUdVcycAt/u7XCmE
X-Microsoft-Antispam-PRVS: <BLUPR12MB0692EEF053804CCAB11C21F7FDDE0@BLUPR12MB0692.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040521)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(6041309)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BLUPR12MB0692;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0692;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(39380400002)(366004)(376002)(189003)(199004)(97736004)(53416004)(386003)(81166006)(81156014)(4326008)(8936002)(186003)(8676002)(16526019)(105586002)(6916009)(6116002)(6666003)(478600001)(305945005)(72206003)(7736002)(2906002)(50466002)(3846002)(59450400001)(86362001)(2361001)(2486003)(23676004)(2351001)(55016002)(316002)(58126008)(230700001)(106356001)(66066001)(52116002)(68736007)(103116003)(25786009)(5660300001)(7696005)(53936002)(47776003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0692;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkyOzIzOm4xdDZTZUhJUEk5SWpSWFM2T3Izb3U3OU9v?=
 =?utf-8?B?RXJpZzUxWnl4R0gwQkFqT0FkWVRYWno0K1pkZGliTGVlSjJuNlBnSlh5TG56?=
 =?utf-8?B?NUM2VzZBejBKaXBlQ3lpNkFOZS9aYUs0emRPek1nWmJ5Umw4YTJPR2swNmxM?=
 =?utf-8?B?Y0JOVDNXbndFWTVzNmFwa1JzenFGQS93SzVQeHUrNENTRUkxQ1hmaTRhZkN1?=
 =?utf-8?B?TjFKaWo1MUszKzE1eG95Z2hla2ZHM2RGZGVXcFJNcjEwU054VEovT3NweG1l?=
 =?utf-8?B?alhDMnBJelU2b0YyeERUWlovYjlxTXdmdHdVaHBUVWtTMnhsNGkrcU1xZGw0?=
 =?utf-8?B?bGs0bWhGRVQwb054UVFlN1dIc29UdzVLMXF6YjNmQURVVCtuaWw5ZmJqMEJy?=
 =?utf-8?B?QnhoVUlhWjlQYXRJMWkzWEZGTkNiT1kxRWVWNnVzYUcxdG1PbFcvWnJvV1Bu?=
 =?utf-8?B?UmJXNWg5UXNxajZuZUt2MTJ2aUF6Tkl3S04yS0orOEhXVVJGcENvUXNNZkFn?=
 =?utf-8?B?ZVJwd3BZK05SZEdUaUhrM2VhNWRlRjVXRGNzblp0cjdpZjVKWVMxQi85b0NW?=
 =?utf-8?B?bS9ZRVdCS1JzazJNTDFuVDkvTlVUdVNyNVFOQ1NUOUNWT015MUIvWDQ2Z3Uv?=
 =?utf-8?B?RGRScmg0ckYwekxsLzIxVTFVbXZFNXpBVFlSUi80VHpWb2lUSjhOelFmd0k4?=
 =?utf-8?B?eW41Z1NkZHhtajNCbS9iVkhTbW1rNHErNy9GcitURHByRE1jMXdGVTVvekV0?=
 =?utf-8?B?QllwZ3lvTnVURndyUkUvTlZpVTNwMU83ZlVlc1VZOFhCdHZTTUlIWEJULzBr?=
 =?utf-8?B?RDZVUmRzNmkrYWdoRlpMR2dCVmtROTVQV2Y5blU2djlaQ0VCQXR3SjY0RFFS?=
 =?utf-8?B?bER5dUdSa016ZDBseU1kR3FIUjF0S1JKK1Q5ZllzclVpcWoxY3FFRHYzN3VR?=
 =?utf-8?B?VHdqTVdpRUNBenRDUUJMdS8vRzFaRlAyeGN4STBJV1BIQ0VIYkZxMElTRmpo?=
 =?utf-8?B?NVRkdE9TcmI3LzQ0ckJvSVFQN2hNZnhZRCtyR0pZWTFjMVZTcnFNSHJGZUJh?=
 =?utf-8?B?M2xTRDVPUUgwY1h0UWZZeWZpVll6WFlDcnB0RTZURVR2VWRoN0dvbmxGVzY0?=
 =?utf-8?B?OGVER2lGWUpib2FwOHNIbmh5TnFma2UyZU1QNkorYnF2aU5vT1FtUUJ1UXZ3?=
 =?utf-8?B?NXRkdzZoeG5QTHk4NkFmY3pmZ29RaXREb0FtNHlTdGNWSTJ1Kzh4L1QvazNP?=
 =?utf-8?B?dVVxSTVPTVk3TkpmUVhiNml2dmptSTBkUGg4cEpOYlRkWUQyVUsyaG04dU11?=
 =?utf-8?B?dXl5TEQ5Vy93cnl5dnJxWnpkZW4weFZYb3FMZVlFVjVTL25MVlJLNjg4R2Vx?=
 =?utf-8?B?NGVVU3g5Ymd2TzlmbzBubTE2SHA4RjhxMGt1TlUvd3kyeVhQYUFRV1lDQnFi?=
 =?utf-8?B?R2JZSmtYb01PM3JzNk5Pcm9pYlVoWnVCbjk2em9POGpNSkp2SlBVQlVaQ09x?=
 =?utf-8?Q?GBk2u9T7tNosFO5OvewKIW5f2zobzsibF83EYuGvdbEq1P?=
X-Microsoft-Antispam-Message-Info: oYgnaRWsorO8Ei7kj1g4CD8qxzlxcmjM2G4DRJNAvE8/6tszjZZ3SqKjYK3+q8dZvK+24eDx3bq8LTALZTRbl/39pBzAO0O1CVjtO7lZAqRF89xmENV8H4eVKJjzwAHH2EuTj0Gl6gOyPyKAsmiwhWdh94njAvRZVi+omg8vlqAs1mNzQ+tfE3zyCQemtxiH
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;6:G8lj7jcd5sljNYgg+s15xlP6jN2ITBQGqh9dNAdGo0nSDDcEo8VTElfjc/seeOd5DRpVjkl7uQSUcecfE5TnxSkXnNAFbI6kZIx2RH/zmkWP5SeSxerNMuP9MHQbu1vitPLVohJVEnBxHThvco/ro0O4FwJ6V09Z42iQzQIrXGG/cBAHaJlK+fFWWNLjGEz9BBdEw9WUrHoWKr2Asu/94t9i/m/mTkOXJLmKljBXqjLbIFJZPhBnIRT5+vCcFkq75892R89iXtGKBUCU55127Nh18fi8m8ZD4me9O4bJlVygj/dxWc9OFYVHBIl47gU4il6dY0C9uyPf8rTD/V7jt717Gd1Mf8kT9shK3GSCeKg=;5:Egswv1fEz5gSsOnPBzVfTFAzNL1utUPzqnMr0CQY1RuVaZ41ufqRiHoTZdo+eXzf82RanAtdwsqGwfPiso+rYDO6YkR/dv/+SHuGZVPb03wsKDPh8GRIPva3eWWyhVwk/Tb4G18nd5zR0Qbc2i+eQIxaQ/JO6jbGrn748UM4kiM=;24:A3YGM80g8SKuBmQ044/kBP/fsCWbS/DnZRw9C2X/b3oXDWKyXXQ6rNzKug/XiKuk88rrfZOBQC3lZ/h16z5/qzQffcalvMndKrXxuTZHH1w=;7:k3Lfl8o31otdcHn+OcOkL0OPo0V0Uqljmfn3+jD5rpV8/awkDaCpd0n/nMFA+1MpRHmmd1NSyDt8p6o8Qv604zZOSVzA3/QV21mz521efV4deoiLAkuwHfLFW0FYEbCBA8+jmsvP13GKKew8YiyL9sReQK5FhQq7s4b9LjBWvIzltJVIRUpExKgn2d3jN+CRvjVT6Lsmou43Nad5xjTp2KxpfvpHnEwEr1QJ0lWSksshjNtNHAEVz6E6a1tZh4ij
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:q2sFKwNvdShqpbdTkTyvQuqiaoCI6j9YA2EVlxWQ9upRxlqkXw0VjUo4w3mugMIdLGvecB4IZJELOndnv+4Wk4b0BeZIYdZTxw+DNifPaJSEgoQtewFugH8LtAoD8xwNe/+0LN1eI+A8ixVdI1WvnvqtcaCWvbM+qIM8QwF1op7nWH3nv14UtvTjza/BlqBWXSo8n73lQyux3ob6mhDdtbcjTBCUfI2k5gFrzIhWDv9dfDd03A99A6NjcUL9oHjK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:34:45.2958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc44a4-37e8-4b2b-1abc-08d585558ebf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove printk and use a more preferable error logging function.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu.c |   55 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7389cc15d97a..7f4e82aed6a0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -547,6 +547,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
+	struct device *dev = iommu->iommu.dev;
 	int type, devid, domid, flags;
 	volatile u32 *event = __evt;
 	int count = 0;
@@ -573,53 +574,53 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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
