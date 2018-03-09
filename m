Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCIAvl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:51:41 -0500
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:59608
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751146AbeCIAvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:51:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
 device table entry
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 18:51:31 -0600
Message-ID: <152055669123.63229.1692099069085978884.stgit@sosxen2.amd.com>
In-Reply-To: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:404:65::30) To BLUPR12MB0689.namprd12.prod.outlook.com
 (2a01:111:e400:5950::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f9b53ac-5e7d-49ad-f93f-08d58557e8c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0689;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;3:RFt8ZVkDzC1q/DEFAYLhKJilAZ+uThpkEKXGabrj3c4H0ybA6SIKSqPrmcRrekxZVx4h+eYhLqT1USt5W9Wyyv3WIry7OsuR2rL7QFDayTmMw9wTiv6YjGLiYNnEHWIv5TzNj0N0zBAmPjdhnIUMOUvw/eLIqRnvlBjf9Ck6YoTJNO5LeCwbkYaqoYxbdU6AbToQ/nedIievjABCI/L/WPijwnGInktwNiEltFiuC+x0Nyy3NFKB/rTIWo3uMWFZ;25:0SLqPiq9sV/ikFJRpdiLpKnN17vdCZbuKmn0ifABRRnW7g/Rty9dzr7k6seXB1jjnQfLZgJLhp6D1sSDa4t4J085qzDj7KIMw6zbMMwf6edeyO/EbLhAT2cUxsrGiObQU/+Smw1i4afvsEGGu+32F1VxB80dC7e4jzz0CP8JcLuGrvMcMy09P4ryW6OEMEho7r332GF7z+77rG5y+AweAFqbTtWbu2crfgi5g2TQ715HK8n9pgtdtKQmtT4ZOjxrinZW2NDYM+eRyoC1EdEXtfF/i5xnpxxN4SCQHlSovlStLZisREXoDm0GKqMDjMlxsFDpbJa6+J2HpfuBm7kU4A==;31:bwlUrEiI/YzjTtL7xtWCw4XIsEJsigWiiOn3sgeonPN6LCMylvuQe2CV0ucLLVtVUy9DhcJuPDJfFnyVmcKO1m9tyC8cWEAKuhEBlekYS2NY+8jxCv6VNB1T8YSMywu0lfHZw71uuJzadgZOfdE+qMciLjrq46bRtSv8r5HsXjwbrScod3l+y9RFS/7SBgRmvji7YWyefS4CH45wgzuFIQVt4AjRmwVro7a7LoKbesY=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0689:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;20:18z2vUbsSG9s/13In4Vxs3s+XZg9lwY6oog6irRjETSmWxb4zP1dvJRJa7U7Q24vHTEDsfIPOu7Ii6mRAY/pA9EXMtPd58FC+g9nOBQ1ov0rsrcjx48ylFcUBLYVM4RZ1QceEXPWSLHvVfuoolgAj4qqHfu6dAlJthRaVDmcp6HcrO0DlZBqRtiLhTupsqJzUSUyDEOdQPFkIpP6cBPkuWkjlK69nS8hT07t4gB3XU4v7WK+xGztOZ0BnZwgpRsxlGlx/Gsf63JcdrzjxVeW/up1rVjUkCLlpenrxraUMdkQtghkeectZ8vZbnDLJwzJ8cUikLMvx2eOTP59cXi7fn7xPaHXBqp8sQYmkbW7+KbGE0RGNVuCDEJLuCuS+ACHj4xWWu+Ls20h4foQHAtHyyWUAd9FIATc+olrzQmvQvzoNLFIzAVJ9iIXg/6tnWbAGjU+GSKL1nE7fwMc63M+ANDpeJ4echWiS2jwQ/q8L2gk++XmLsscnQhA9CLmETbo;4:o2nvcbtu2OWD1joakdjxNXXFxOEkjKV7ToOhLe4Wv8r1IbMwT8+Hj7F+MEQE7/WcONu9MC8srj5/YEbdg2XZKTm5+MgkKIAhzvGSOIDqV/pQrj76Kp8fWFb3QwD2znBEYSccz3Kj8j05zy54N4wZqL1/PlIPXv8wmo6Zl9Ig9bovkoSmlFxc17DmFWXcoGwu0/HdwcebLHrsFx+hzUtGeXwgjHmkYIejW8gcUFJ1Vve0Fs+Ej4s1vfTNk96+sE/5NMZ1yugNVJTND8gWcOvdlC87rWYWBbxFOcnPHdakz9ZK471R05xYm9fIfvOLJTXc
X-Microsoft-Antispam-PRVS: <BLUPR12MB0689F38ED6A1FFAC1DA9160AFDDE0@BLUPR12MB0689.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040521)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041309)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR12MB0689;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0689;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(97736004)(2950100002)(6916009)(6666003)(316002)(2351001)(58126008)(53936002)(81156014)(8676002)(386003)(86362001)(26005)(59450400001)(16526019)(8936002)(186003)(81166006)(55016002)(52116002)(230700001)(72206003)(4326008)(478600001)(2906002)(2486003)(7696005)(50466002)(23676004)(76176011)(3846002)(25786009)(5660300001)(68736007)(103116003)(305945005)(105586002)(2361001)(66066001)(7736002)(106356001)(53416004)(6116002)(47776003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0689;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjg5OzIzOnF5UjFqK0s4OUtGV1pMQVlMY2tneWhQZjZj?=
 =?utf-8?B?VGNwU1hHRmpHTzFKT1lmZFFKM2d1a200Mmp2dFgwUFJWZ2d6c2FhcVhJTmMr?=
 =?utf-8?B?ZHkwQlhlNGJ2NnRBVEJ5dDVrYm51bSswdllMcEgvOGhoN3hwNFB1a3dESllD?=
 =?utf-8?B?eUNsNE9MN2lxeDlnRkZuS29uY2RxaEYwOExnNWdudElSNjArNTZMMUhPQmRN?=
 =?utf-8?B?bUtPSldnVkEwWXk3bTQwSUtndk50eXplbWc4ekxTV21IOFBYdUg3Lzd1ZTFU?=
 =?utf-8?B?ZVhnQjArUmRsRzM1UW5zQnlHZFMyZ05mcDQrU0VTd3ZwdUhrb2NSNDJ3ZHN4?=
 =?utf-8?B?MzZSbHFaSVVWSG1XbWNEU1lYY0dZaThiNi84WVN4eHMwcDBKbHJGVjczYjFa?=
 =?utf-8?B?aEh4V1FJV29LZm01RUpXaXhTbmhVNm84bG4wYTNvczVGaWNLaHRvSzdKMHV6?=
 =?utf-8?B?bnJocTBUUkY3N3NGcm9QTDNWb2ZoTG1PUzJ6OFVEWVNsMkNDVm4xbW1nVUdu?=
 =?utf-8?B?aUY1b2dQK245Y1B0TTlLRWpoemZHTGxkQlhMa090bVlpMkV3bjI0NGl5dnJi?=
 =?utf-8?B?TXBTTGh4TVY5M1VXREIrK0FHTHYyamVQc3RWaE02Sks3V1NWQXpvUzJjeXlZ?=
 =?utf-8?B?SXloWTRrRGZNSTVKVlJoeUJHVVYzNlBEdFBRMjFCUzh2UmhJeXB6OXUxNnha?=
 =?utf-8?B?bTZ1VUNpTnFrZVc4T1Nzd3ZKQUcyTUpRSCtDM3Bsall3RXlLZTFvenkyWjdR?=
 =?utf-8?B?aFh2Qm1PdC9SdDdOc1pDbGY3dTVjM1VWZkErdjYwRFRmVjFrRkJkTU1TaHlE?=
 =?utf-8?B?ZHV2TEJUb0VnOGdVYWlabEpTTzdPNnRyajFHbFdaVEpBa2lkN3FnSmJITXFD?=
 =?utf-8?B?SmIxL1k4YVBHcU9Rd3YramVXMXlNWTE4ZEhCSHA0TWNpaUswS1ZObXpnOVZT?=
 =?utf-8?B?dVRVWEk3NzhFZXVyNFErZStoM3pDZDJLK1Jjb1d2ai9jYWhNUTFJRFROUlVh?=
 =?utf-8?B?Um12SUUyVmhOYzIwOUJUQW5Ec2k4SlBTd3FSN1BFdkw0NWw4VzFCT2hVY0Uz?=
 =?utf-8?B?OEFxM0tJWk9JZ2Q4MzlJV1Z1bnpFSWpZbGxybVFFNElVcElBdWRBN3hvcEVh?=
 =?utf-8?B?b2dqSTZ3VEJJZ3g2RHNjUjZrYSthT2l5SmZ0cC81NGdSQ2RRZHB2TEVZeG9p?=
 =?utf-8?B?Vms1QVhoTHE4MnJKUlNuRGE1bWdyem81anFXalYvRXIyYW94c2NsazlpeUdw?=
 =?utf-8?B?bGt2TzJqeHYwd29ZL1FUYW9KQndYN3AzbWlaellSenYzdDVweU9sR01OZFVs?=
 =?utf-8?B?TzlHK0xpQWxxVytLNHVtUTdoanA5M09DSU8wZlFyZ3NjUGsrVlZRNEhUUXJH?=
 =?utf-8?B?R0FSTVgwOUcxSXJJRVhQdzZIemZYTTFnaHNxZzFEZ0l5UEtFYi80OXptb2VL?=
 =?utf-8?B?VFFhWmN0S25Ma2VNcXVFMFUzUUZ0Q0paemgrQ0txT3FzSklNM3lSRWd2aTc5?=
 =?utf-8?B?QWdQOU5WUnJDTUZGY0pKT1NsakJmbnh3MUhkN2FYK1R0a3c4VE5lc2lLbFdv?=
 =?utf-8?B?QlhscW5JcmVCUXJyN2tlcnVnQlRzeFNVTUwwR2ZuQTVMK0NoK0FmSGcwdDN0?=
 =?utf-8?B?NnUvWDJRUUhzb0l1ZTI1eklNTVhGZW1HMDVlYytHaHgzY0x6WllvR1pBU2Ja?=
 =?utf-8?B?bFpWdmxDYjFRalkydkM2R1F3NkkydnBFTGk2d0RhdkdZU2RuMzIvL1B6RGZ0?=
 =?utf-8?B?bS9yRjVlSitTQmJuTTVJUT09?=
X-Microsoft-Antispam-Message-Info: DS2YDJRRCuysk+Owjm+niPHE7petGdi7paiBjSxZa+aIFN7mXVKqlCgQD1qGwWumz9VB7kT66u3XmlX/IwAef5qSjbt6tw735ACMREB0BJihIytm+bFRhuGVgIluiQ8PMqK9Act1hQAbsutb1b7f1MwtbRjRGb7JhaiinlquwlVxbhHGYjECWpmaTGM+oBK0
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;6:sFbFZlupeUdi5c8e+cch24v14WHgja2+Hurdp+pDdKeiCM7QyNzTtjb6r/qlkurZ/Z6JpVXETQiBbOfsvNTM+d5xs2zMNHP1rE6aO3gPUhrxO++Eh3mOtRQNJd8KTv3XZdI8FWhqhg00y64tEwgW4hwDS04Uc0+aoFqm5zUQpBt6FNP6Tdh/KoUcCDXHwiS3HOJgh5Jg35Yr54EuV9CBOyqGR/IMVGDpKbzfimpm7DSEWlaA430IsV2jJ/WaC7C2kRtQKjh9Jq9LZdoMA3kBKWu+8z9xl03RMLF6exKhsIeNwHTkaEjZ2DiHj3wUBEJV/a5I4EdqffGCIBcRH+YfUtKvEl6rupcHrQCOp6zi+Vg=;5:84rgn5HwGglhoOpgmeypVx3GJUf8/kq4upbndgP9Mc7BH7FutsdjwHa3sH3CzUPjJ2uGwufxDAP1R53ViTsvzwTvNnKE/Kk9xbtfLEDNeNUTkdmGmhD2cpxy+l5gCqlWwlfdeOMJmQ2UZecdwoTrdMbS8GlV13mcJTJsMufJ9F0=;24:oY9bZBVn7A6iMmvpPMaWWZYV3qtl40Mtfh/bZa9KbAy2gLiZybDflg/Zn0to9x+RvTaD5XBSdhVAKlm6rlx4vgJIXYNRk5jfySaj5t9o6xk=;7:SS7G+cqNSfcblyHHJ5ENc27R4NVSvGSoPjJxDeSAugLliQkzfDUJi06oN3vx0WPG+/jYA0znvrtpLPT+I6aQ6yTr3CrcYD6jD8Q5jz58sTJj1ajEL51KUzTUv+wQd5A5ISDtdn2y+gojGrGa/Aj5576XomIQC+r8sxdhupvsbEkB1Nci6aduiY0yVDM2hjbLaSEhMSMOgJRBFOFPn0cgLqtFtbwzg4imcP0+nnrl738NjNqq2OGCTWxdOwSzcp6c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0689;20:uyGgeIZBKUolc6A8ZNI0WmvQUqq/6A75VKbwFjsOjxuwG3LpWhQDa9fm4XC5vs0KDJBVjPdMYa6J+zCthQlf5Em4NlbB08+3kGgnb9rXfS/6WcZG44rpEMYaSyvUvEEZml8m3fMYfRbBRffURLzWBsY7npjoirViAeOBJ5y7VHfWsXQTugZxunBSepCMZAQmP9XuBvvGa4lzAJPMiAFft4AD8Z4PwQeRRIxlpmmG4g8c8qfeer8fEYNX4lTdJyvL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:51:35.3373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9b53ac-5e7d-49ad-f93f-08d58557e8c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0689
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially (at boot) the device table values dumped are all of the
active devices.  Add a devid debugfs file to allow the user to select a
single device table entry to dump (active or not). Let any devid value
greater than the maximum allowable PCI ID (0xFFFF) restore the
behavior to that effective at boot.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |  109 ++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index c4e071f7a5b9..aa6935340163 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -28,6 +28,7 @@ static DEFINE_RWLOCK(iommu_debugfs_lock);
 #define	MAX_NAME_LEN	20
 
 static unsigned int amd_iommu_verbose = 0;
+static unsigned int amd_iommu_devid = ~0;
 
 static unsigned int amd_iommu_count_valid_dtes(int start, int end)
 {
@@ -81,6 +82,76 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+static ssize_t amd_iommu_debugfs_devid_read(struct file *filp,
+					    char __user *ubuf,
+					    size_t count, loff_t *offp)
+{
+	struct amd_iommu *iommu = filp->private_data;
+	unsigned int obuflen = 512;
+	unsigned int oboff = 0;
+	ssize_t ret;
+	char *obuf;
+
+	if (!iommu)
+		return 0;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	if (amd_iommu_verbose)
+		oboff += OSCNPRINTF("%02x:%02x:%x (%u / %04x)\n",
+				    PCI_BUS_NUM(amd_iommu_devid),
+				    PCI_SLOT(amd_iommu_devid),
+				    PCI_FUNC(amd_iommu_devid),
+				    amd_iommu_devid, amd_iommu_devid);
+	else
+		oboff += OSCNPRINTF("%u\n", amd_iommu_devid);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+static ssize_t amd_iommu_debugfs_devid_write(struct file *filp,
+					    const char __user *ubuf,
+					    size_t count, loff_t *offp)
+{
+	unsigned int pci_id, pci_slot, pci_func;
+	unsigned int obuflen = 80;
+	ssize_t ret;
+	char *obuf;
+	int n;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(obuf, OBUFLEN, offp, ubuf, count);
+
+	if (strnchr(obuf, OBUFLEN, ':'))
+	{
+		n = sscanf(obuf, "%x:%x.%x", &pci_id, &pci_slot, &pci_func);
+		if (n == 3)
+			amd_iommu_devid = PCI_DEVID(pci_id, PCI_DEVFN(pci_slot, pci_func));
+	} else if (obuf[0] == '0' && obuf[1] == 'x') {
+		n = sscanf(obuf, "%x", &amd_iommu_devid);
+	} else {
+		n = sscanf(obuf, "%d", &amd_iommu_devid);
+	}
+	kfree(obuf);
+
+	return ret;
+}
+
+static const struct file_operations amd_iommu_debugfs_devid_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_devid_read,
+	.write = amd_iommu_debugfs_devid_write,
+};
+
 #define	MAX_PCI_ID	0xFFFF
 
 #define	PRINTDTE(i)	OSCNPRINTF("%02x:%02x:%x - %016llx %016llx %016llx %016llx\n", \
@@ -106,19 +177,28 @@ static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
 		return 0;
 
 	/* Count the number of valid entries in the device table */
-	istart = 0;
-	iend = MAX_PCI_ID;
-	n = amd_iommu_count_valid_dtes(istart, iend);
+	if (amd_iommu_devid > MAX_PCI_ID) {
+		istart = 0;
+		iend = MAX_PCI_ID;
+		n = amd_iommu_count_valid_dtes(istart, iend);
+	} else {
+		n = 1;
+	}
 	obuflen = n * 80;
 
 	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
 	if (!obuf)
 		return -ENOMEM;
 
-	for (i = istart ; i <= iend ; i++)
-		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
-		     || amd_iommu_dev_table[i].data[1])
-			oboff += PRINTDTE(i);
+	if (amd_iommu_devid > MAX_PCI_ID) {
+		for (i = istart ; i <= iend ; i++)
+			if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+			     || amd_iommu_dev_table[i].data[1])
+				oboff += PRINTDTE(i);
+	} else {
+		i = amd_iommu_devid;
+		oboff += PRINTDTE(i);
+	}
 
 	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
 	kfree(obuf);
@@ -135,12 +215,17 @@ static const struct file_operations amd_iommu_debugfs_dte_ops = {
 
 static char readmetext[] =
 "devicetable             Print active entries in the device table\n"
+"devid                   Controls which device IDs are printed\n"
 "count                   Count of active devices\n"
 "verbose                 Provide additional descriptive text\n"
 "\n"
 "                        Dumping the Device Table\n"
-"The device table is scanned for entries that appear to be active. The\n"
-"default range is from 0 to 0xFFFF, and only active entries will be reported\n"
+"The device table is scanned for entries that appear to be active.\n"
+"The default (initial) range is from 0 to 0xFFFF, represented by a devid\n"
+"value greater than 0xFFFF, and only active entries will be reported.\n"
+"If devid is set to a specific value, only that device entry will be\n"
+"displayed (active or not). devid may be specified as ##:##:#, a decimal\n"
+"value, or a hex value.\n"
 "\n";
 
 static ssize_t amd_iommu_debugfs_readme_read(struct file *filp,
@@ -204,6 +289,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!d_dte)
 		goto err;
 
+	d_dte = debugfs_create_file("devid", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_devid_ops);
+	if (!d_dte)
+		goto err;
+
 	d_dte = debugfs_create_file("README", 0400,
 				    iommu->debugfs_instance, iommu,
 				    &amd_iommu_debugfs_readme_ops);
