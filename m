Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeCNXFg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:05:36 -0400
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751413AbeCNXFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:05:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 4/5] iommu/amd - Expose the active IOMMU device table
 entries
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 18:05:25 -0500
Message-ID: <152106872543.67212.1710383006630131454.stgit@sosxen2.amd.com>
In-Reply-To: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR21CA0039.namprd21.prod.outlook.com (10.172.92.153) To
 BY2PR12MB0693.namprd12.prod.outlook.com (10.163.113.158)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69489541-641d-48d5-60d2-08d58a0014ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:rJnREtJvQellrENw0BIwxuwGAnErRQp5iGhqZnUUcQyBBhd659itaZNtYOSxyW2Ez/to34cFIP0rvd4V+BABeRfIvQjw9zZ2ttalgNNyNxAVsJw/7SiE09aXTqrcznrY1JOneB9wELHuksWB3cq4/YQ/Com2ZCn/Y+LBhWKEq6svgpM5MBavJgKAQRe8TqeQIxJ+XQeN6nh6KnzQzUbYkVy4ZHZ2dJNwDnERqeVINIOD4zfbh8n9MgaLkY53OJ30;25:NR6UjF+6JLhNFYR1nUg7EwgQiaK6hWPbaWp4YhEYbBUYtwUg2xHyulfCNVU1DwYt212nHZvZjzvOMFBBd2CkU/4pNG+rwdqZzf0sXW4IEygGQVwHJX1KaLJVY+Elo6lR6nsxQtrRKlrtWXtA+M5aKVH8EUR5aLFMnu/hgWTyGMEDF2bKoJrpIcPzhlH0ynneThP9x0rPCmG5HKRzKJ+l6BPxKqgHa1/SpJ9KLW8xDiN6xHLBowdmF2YVnY4wMqob/wgy+1kEH4AVpOUcqgvijsEzxpPI0Z12hDPu04dkfwl7JbS9SGiWEBDLLQjUKHOootZy9F38ZXcIx4iMIHszDBp9wrt8Zbi3VECZ12xfFQw=;31:axG3aEGi9q7Bv957DhjxGxoJkJ1QiRrEEw0eJXWOPHzz3APs29XvJceVA+ptRa6A6ZetJZWYmICjuMKxEEtz8PVjyDDocn5D+hLxELAo8pD538ucCtuqGxL2JTqatN4FjWUyZBsHB1HeeRSkRZm9ORNxpEHVw6EjPRXsxeOpDVcI+yTg0IN31eOvUcPVrS06VbWpYBgUJfRai6eG4GrYMkA+G7Bi3lO33mwlMph5yrA=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:5FUjU5WqUNyArVHNADlV6vSwzPcMPB/hVp+6v2gt1mpqtJrGT0NrMg+27/73eDXERcRniUJjkBUhxw0KmLmEBKL5NJXNXqHBV4Edk7Q2kzUlTHaXHTTWlSuIGGYOOesWcNGBtNVukAin2yBwYI4hbQsGAoMxcJAao29GrLALmd+jawkTApn9qyxx1h8c3F8+hczQJWxfWhEQAPfiufRwounX8TrFnYYeWGke/86/93urrKwxl6Je4sqIWZYeNBiX9qtnZ7YZqaNlNMnwQH9YykFMIFDfbnN7fXZqponCTm6CQARM46TjrSBVuPN/spxFe9KbzMO1OugwcgdFIIPQwXXKsNZpU7I23Zfe2P9yLGJK4r/+M2BaoHNYP1OkIZHjvxnP5wTDRuDA4bnxkIlTPkxzhGbESRppHkbSv+PE4fC7Snl221zu2li6jMF2o0KnbGFOQUUULnqs4QaT/+S8ewrRWgIpFbTBLg2ogdoB6B0EfzRWq11Lr3mYN7T68Hiw;4:ONPWkbfXmlfjS7YyqG3YAnWKUU03iAVGnIFlcilxcIa41C5iOE0PeT0tZKGzWazQ1mXVia5jkonlz01mYoTz28+aNb10WoWWiZt0u8QrOax3dvdW2Ar+BEpPZyquEoxugrCkVek8/yHA98cM+K1kKacVjwOItcRu3ZO0p8eqVN9V0H4lrV3vVy2rIZuc4Bw5iUjjd3TYbZXy7/G4qmVNCf2o+euqU2FO57qZmuXm9Txy8YQGensA08E0AhV9sz/DM1vvv/+iuCX7eL/gXp+cpotuwv3A4X/VjROyQsfMZcOTpTjZ+4xsGyi82TdSFASU
X-Microsoft-Antispam-PRVS: <BY2PR12MB0693ED8627BA64FDCEBC2C2AFDD10@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(199004)(189003)(26005)(81166006)(8936002)(2906002)(2361001)(55016002)(2351001)(6666003)(97736004)(72206003)(66066001)(103116003)(3846002)(6916009)(478600001)(53936002)(105586002)(81156014)(53416004)(230700001)(4326008)(8676002)(47776003)(106356001)(6116002)(5660300001)(86362001)(2950100002)(50466002)(58126008)(25786009)(68736007)(16526019)(23676004)(186003)(2486003)(52116002)(76176011)(7696005)(305945005)(7736002)(386003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjkzOzIzOk0rcVlVc1ZPRWxpN3ZYN3k1bWIrN25WUHlw?=
 =?utf-8?B?M1pIMXUrWkxrZ1VUSGJsM0VLWmJTeC9QV1kvc25oMHhYS1F1b241c1d4ektr?=
 =?utf-8?B?WGJIZWdYVDNPaDhPZU9nd01HeFFZT3B2MC9ST3R5bkNYTHRSL0FpMU9OYklz?=
 =?utf-8?B?QTZ1R3hLUCtRWmx2S05lcUdDcVdSdjhxR0hwWUNEOG43S054YVdvb29FNVNh?=
 =?utf-8?B?NnNLdDRsWkJzMWxGakpEcjBjaVVlQkxTSENUdUdFWUJKWG9VQ0dWa2ZtaFJB?=
 =?utf-8?B?R25Ra0ZtV0QzOHJVOWtEQ01tdTVCMmJSYlhrdHZTOGNiZU1Qd1dzMWZQeUZQ?=
 =?utf-8?B?bW5QeVJUYjRySERMSzVrL0FsVFZpQUhVekdDa0FnclpIa01McWloOEtadGo2?=
 =?utf-8?B?MW9zbE92MGorazhTd2ZURkZOZ3l6aTRlR2tjZVplVCswaE1zVTRjVmlQUHBK?=
 =?utf-8?B?d3NSQUc4Yy80OGJBclVuSWJEdGRXMnVWWlVLdzdOeWJMWGZNNWFLY292OVpz?=
 =?utf-8?B?di9kZytJYzh2OUlIL0d3ZE1xTFVXNThpc2lyQzR2ZXNWTEZsd3BONG1WQzJv?=
 =?utf-8?B?TzdkWXpjdUZxK3g3MGlNMDR4MUdNMkxNNVRJWnZLKzVlalVQbXNIUlZPSnVN?=
 =?utf-8?B?cWwyUGZRY3RwYnl0UVlCNks3cW5QZzdjS2pCdjZBQVhuRitTZ2hpaGFHYTI0?=
 =?utf-8?B?Zi92cUtuZkw3S3QwL0YzMmNWT3VQc1ozM0d0R1orcEppVzdSdG9IRThUdjlp?=
 =?utf-8?B?eGRvem1qam93TWI5VFVHU2J1czVqTkRxNUpxNElvYkVEUVRZbGRYSnRpckpm?=
 =?utf-8?B?THAxYUJvUnRLN3J6S1BNbm5Bb3hDZkduaVptaXJDRitJOFYwUkhFTFFKSmJ0?=
 =?utf-8?B?UWt0Q25yN3hDNXRuUkQ4clJoL1ljN1AwQlNzMkhRUEcrSlJwZ3VKcTNTanRu?=
 =?utf-8?B?bmpQVW1jcFJCZUJ1VjZsWnRCbXJDbTlJeVBzNXFIUEZzVU9NK0pRZ2ozSWp4?=
 =?utf-8?B?dnFZMEpJbXVzQnBHR2lhTnRyN3p1clRLY1JOYkNnbjBQbXVEZTBnSmpjd1lj?=
 =?utf-8?B?eWxGc3hjWGJTZWsrWk04S0xRM0lWMGtKMlcwWDlEc2NBL0RFWElPQlB0THpE?=
 =?utf-8?B?dEprQlZpelZEUWwvMThldDFWYWxxeFl2QnhqWm8rQit5cmdGQXJUdnY4ZVBh?=
 =?utf-8?B?bUJlcjl0RGFPa0VSVDhiOEptZmJ4WkJnZ0M5UG5TeVZ4bGVYdXRxQkdJRUFJ?=
 =?utf-8?B?SFNsdUwrYUdWMVMwUFRKTHNoREVkdVR3UHRBMnVTdzNPNnJ2bFlJWDE3a0Iv?=
 =?utf-8?B?ekRYb2YxK3pPdlVKRkZHdjc3MGEzeURJN1JDYXRybE9OZ1lRL3ZOVS9OLzJW?=
 =?utf-8?B?Ukl2djNHRDJoVENudklvakFzRlVBUmxGdmcxUHI1MlRqUXVLakR5VVR2dlFo?=
 =?utf-8?B?Y0ZDWHFvM21ZbVlLdTcveFozeURWRHFjbVlqUDdZWUZJTVF1ZWhGNXcvcTNX?=
 =?utf-8?B?K2xHS3hqSG5ERFkyNFYwT1JGazVHbWR5dXlTOGltaFE0YTJlZEszSnlpWVRC?=
 =?utf-8?B?MElJQlNuOEd0a3lsS2NKbllMNldYWmc9PQ==?=
X-Microsoft-Antispam-Message-Info: 52R1eFOSxh8tRSIbBKK9RwNUTtkNBAUOdP+CntwVUI95Ea/BRPjwVI3HD0Ij4Yh/Z6eICNC4i7hoYjmsdnzLN8rcoP0b0eWqTD4kESNLhSyA+GiPcaoU4jd6D7tmYqrVZIckdO/SjIOJddlkS19nM+cEzpxEI4xeaHwsfdv3rSjAQ5C4E3W1Lkklkin315PA
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:SagA05oXd80k9IpP/88u5w16oNWJaig5BlFv5Nj9OM+cKNlo8jdcgSL2LMJ5o7UAkeMpCR0krQIYAlPe/FAUivB7oqYsWwjfW3SUlRkFEBrrpcK4dT9P9jRoI22PjMX+saMxMHcJ+WC9Z0fAJx1vra2S+Z4JNsz3eUmqHhNOmoHBuvmlX/mn0lcdbqx959KkLo7lLcMw6Nel58uvn4EWFhW2VOs/4+sED6Lo0x/JSdjnpEVSZouyjFce+iLDkvRmeJP1bGv9PlvGkmpYaih/pBLGRAwJQ1jVX9FjqsxXLwfQXmeSr83H7UG2eG+2eIp0AQnIY8fI0udxlTs1eBEeAC4v2ZUqG5w8OxM6KJLW1Wg=;5:GOn8enSnwPneb/kUrLKCykKhzSAPEWjGBqCUT3oI6B3aMqOv3rOkbx8Jfuv2SfF1hsISD1R1WfiWxIzsLtftMstk/RQ8wNVgBohulS2/F01ETXwkGMDz1Zk0EWCVibw3RxJIrd4ztgvkM56ZuCYi/2JrrMGyU+XC3RwFWJRO7bI=;24:EZQRW1kDrYE0hLTWUIzkUw2jD5MmcE7weMp9+5TKEChUnXcFyf+0u6d/4VqIcui9TxsAhskWhSN8RM7Dk4vMS6UijF4KrhYHawytdRhO3Tw=;7:HXZVe+p4q/tdctpMfoGXDGWE3X17rvDGGdkA7PfIPOPjIG+9ALjzg3PYRvXzGjEU9h6xmN4P6qrrPPQUu0Xcjcztj0UaYq/bRHehIZ5g4Z46m/x0aq9rCd4zjel+S7brJ+DyMVd96KzZF18p7Bb+T4CUsrkxLH0udzOtOrGUahMeADotdY8goJzB+EyVbwHufXzy2/746CT7HmSs8iX/Gz5eLj5DtO6kuGWIIW4Lqvx3EC1H+RWpG7AjLphoag6C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:aoeWnuvOMXyHnX1+Te2RyAssxUQos35puYb+p4vftsYD5jEzEAmvxLPhB2NHdTtYUuzMt099XgB6muUZiuRPXyTnFmJcAzLlUQiqnyGmzOZ4sp0XmKQFBGdIfx/S1vJCRhxRsZAGXwFvbixUz620GObpcJOH/wCdH4Zo1fYLNU0jBFxSsjdKN9W/z9TqmqWYZSglVQI3C5Af8/zRO1zhScUbf0Zuf24U8CYai4I1cMvlMuSAthrlgmX9e/J2tH7A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 23:05:28.9712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69489541-641d-48d5-60d2-08d58a0014ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs entry to dump the active device table entries from
the IOMMU's table. Active is determined by non-default values
in the first and second long words of the DTE. Aside from IOMMU
devices, this output should list every device reported by lspci.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index d95428b1ef90..1d941c5329be 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -92,9 +92,62 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+#define	MAX_PCI_ID	0xFFFF
+
+#define	PRINTDTE(i)	OSCNPRINTF("%02x:%02x:%x - %016llx %016llx %016llx %016llx\n", \
+				   PCI_BUS_NUM(i), PCI_SLOT(i), PCI_FUNC(i), \
+				   amd_iommu_dev_table[i].data[0], \
+				   amd_iommu_dev_table[i].data[1], \
+				   amd_iommu_dev_table[i].data[2], \
+				   amd_iommu_dev_table[i].data[3]);
+
+static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
+					  char __user *ubuf,
+					  size_t count, loff_t *offp)
+{
+	unsigned int obuflen;
+	unsigned int oboff = 0;
+	unsigned int istart, iend;
+	ssize_t ret;
+	u32 i, n;
+	char *obuf;
+
+	/* Count the number of valid entries in the device table */
+	istart = 0;
+	iend = MAX_PCI_ID;
+	n = amd_iommu_count_valid_dtes(istart, iend);
+	obuflen = n * 80;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	for (i = istart ; i <= iend ; i++)
+		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+		     || amd_iommu_dev_table[i].data[1])
+			oboff += PRINTDTE(i);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+static const struct file_operations amd_iommu_debugfs_dte_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_dte_read,
+	.write = NULL,
+};
+
 static char readmetext[] =
+"devicetable             Print active entries in the device table\n"
 "count                   Count of active devices\n"
 "verbose                 Provide additional descriptive text\n"
+"\n"
+"                        Dumping the Device Table\n"
+"The device table is scanned for entries that appear to be active. The\n"
+"default range is from 0 to 0xFFFF, and only active entries will be reported\n"
 "\n";
 
 static ssize_t amd_iommu_debugfs_readme_read(struct file *filp,
@@ -144,6 +197,13 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!d_verbose)
 		goto err;
 
+	/* Device Table Entries */
+	d_dte = debugfs_create_file("devicetable", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_dte_ops);
+	if (!d_dte)
+		goto err;
+
 	d_dte = debugfs_create_file("count", 0400,
 				    iommu->debugfs_instance, iommu,
 				    &amd_iommu_debugfs_dtecount_ops);
