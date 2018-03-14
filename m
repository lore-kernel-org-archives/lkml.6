Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeCNXFq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:05:46 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:14368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeCNXFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:05:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
 device table entry
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 18:05:34 -0500
Message-ID: <152106873475.67212.6697709546085749566.stgit@sosxen2.amd.com>
In-Reply-To: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR15CA0035.namprd15.prod.outlook.com (10.173.226.149) To
 BY2PR12MB0696.namprd12.prod.outlook.com (10.163.113.18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b5f0eb7-a8c3-4bd4-e044-08d58a001abe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0696;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;3:7tWNEi9Tv4wa3PtTK9/ccrUT3ZQP+wSRyi4CD1QEeHr3bumbMBrgaFmI8K43V0qSGtB8OwbGHDNQZH7ntJCTvRo4VVNvOfSoKKs7pAV0fayy/EMD+lH4qe3rvKDusI86tDxCTEKGFWw/C2/U//TJAI+zNIcj8CWG62KoZ4aeBUys0BnKG9wS1Je5yTGnyqLCJ90u7b5UpmnMedZWi8bwEk2i2O0qo+ZTpl7MaojXMRp3VgwW+fHAT+JgVg1Ep1zC;25:v3OMpuTQWIw7sBsZUOgQlRdgvcKAKKSjJPbf3Rcnbwd0qS0Hl5kUod7N71ztTw6AfUQCpZGZCNzEMurBSHMO5J97FtvrhAd64D4EJmpPhNj3BOSz0K1YvXXvvbGOqYGRqTYpvLaVGA95sLFdrcKYgYriwHEXmknaFgIs+3wJz/ybyE57TLHPPdmX9u43KSdlfhlLwqXgyZtvNkrD8VwSw/oGQBU42VJkH8Z+0ZNAn8wy/EHdWtCcIbFuYWn8bBp4B8MYxxa1NyvQlufGOLDzHHn+tzZHKlk6AUYgepsVvh3dNLG8M/8/YdDZciWuudxuo/e2xid9C+sBCH3SRENfIzBOOZ48E5x8+DD9mFtPcIY=;31:ZGM/39uGFxwO/tIS3qEphDzK4b6ZXTPtHOoRyYa2OC8bOZ8CGu1ltgA2JHymgkyY8bhiA+Hxuzh9wmZlhBCy81TWJncQ3D4pwIYodoGLKKUjt5XAH+8elRennBPDQL8uK7FjdtmGtum/4suGMoi+8/zFEFYBFtbvkYxm/np5ibAbR1Idym2YGZHl2tO8xxr8OqaDAaP2dYyzEehxrAPthF1kraIABNrPd/XaI3Vkr30=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0696:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;20:9OOA90c4nbB/fBDN2c+hlf7YtBnFfWtZgQTKvCqlZ+aG+ZBO/EJWCxNW5CKZDhGgqu7NmWBU7DT3JvtM8M1RosXRcep3WxaQ3U4q/IUh+u2AR05KL0RufTNU41XuYNjjQNizeNjB2uCWfefe28uamqbj4d9aR/mk19LnYGA9OEXxsD1f2W9FsVks6P8butSZDPyb7iW4ETO/FHS2jYrc9CDQRnLe0vPA85cn+MwgqLv1cS4eeNhYDs3D2WGy4Udi5sOqDkFZcecBebv/btrTznIGTj/QI45g0TeYTRQgxHE/q/JUdEvFmTQ+GfsGDfh6Worm/A478VYIjdtaaTSOkfQrUf3aKxv63CZPqG8P4pnrGw8FcbL7vN+zaacVmJDtGijLNj36cchL60Il+RRXKkDTuChlvD5Ta3+TMnY2pN9ePc4QfxciOaQvVI0irS1XudShy4GmRJCtkNEMl9OuPJNiMUDqvlT9FsF8QGyuh/mmEQXqIc/yNcqdiiDPOTgv;4:aBsRmF+lZxCcCklVplN5u2mU26aRMfF+As7agpus36sVzoGocV5E0EXbgUV0CzZsNInLvKy0cqEh3AHubwDykxswqTihsP7mjJ1Tt9M1iODASVPwj/0zUVPgPOz4Ol/jiCCQjngbHuhjOjYM/cgmiTLZpRK0OJYYcP+1kHxU8cWzl/w7eCHXqQr55fu8R9KZlwx/mXqJnJnDKTd2klb0wj97Q/LmfeoFhtkDp72j/aBnaFKfGbaqEqDIokwKX4wh3p9ereUaCNcNwZoOaH521K50YDwkIIGFsGfGrqgrcrTHBVidZqYk7fmf2jXK4pIh
X-Microsoft-Antispam-PRVS: <BY2PR12MB069640F6E37340FEAF50F16BFDD10@BY2PR12MB0696.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0696;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0696;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(39380400002)(396003)(189003)(199004)(68736007)(316002)(66066001)(5660300001)(2486003)(3846002)(7736002)(186003)(305945005)(16526019)(7696005)(52116002)(59450400001)(6116002)(478600001)(50466002)(26005)(53416004)(8936002)(23676004)(8676002)(81166006)(105586002)(386003)(81156014)(72206003)(97736004)(4326008)(55016002)(103116003)(230700001)(6916009)(106356001)(2351001)(2906002)(2361001)(6666003)(2950100002)(86362001)(25786009)(47776003)(58126008)(53936002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0696;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk2OzIzOk1SbGNnOXpvU09IczYvMDBiWVZUWnZLd0No?=
 =?utf-8?B?NVEvMk9wU3pIamFqTk9ZSUVCaVZtck9kNEVJZGVHT1k1cXRPcVp1ZnpXNmgw?=
 =?utf-8?B?QUhJYjNoMlFiR2h6S25ReEV2aTNFUVAvSmROWW9BaWdpNjUzZmQ0aWJFcHdQ?=
 =?utf-8?B?aDMzMmozdTd6Tk9sQXlFUGw0SW9DeFlrNW1pZVNuVlB4UnRrTU1BS1puNnpO?=
 =?utf-8?B?ZU8rditvU0NUTldxQU5QZlpWcDZROWtVYStNcDJzWFNmZFNvWllla3dITWJk?=
 =?utf-8?B?WWJwSmJ6SDRPbFgyQlZxdmxQSVhJWjdxTW1UTCsyU3ovekk4YkEyS1BjWEc4?=
 =?utf-8?B?akJZZ0lnZ1VKNFV5eTZsMVIva2lNRTRpQ09TOERkQWN6ZHRxRElWZmRNQ09K?=
 =?utf-8?B?Q3c3MGs3ZDlmMERSRmx2QlIyQXREZG9HdngzSEpWL3NKMklEY3BwOXJmWlVF?=
 =?utf-8?B?Ti8zQmM4dzQwc3NjZDdrV1BBcjhGZ3g1ZUtpejVXZ2lhYWlrN09YWkRJcU0v?=
 =?utf-8?B?aGQvd3g3UXZFd3ltcXBjaUJMbUxMYW1acDY0TXVlcUxaUStRMGhZWlFub2hU?=
 =?utf-8?B?Q0taUWpsdWpLcXZIU2pyVmorbGc1dE5wOWZXYm1YVTcySjhhRm9pRnFNYmlh?=
 =?utf-8?B?b2xIK3J3WlppMGNrbGphUzVCVFhkdnN4UlBpck00bnZGWmg2ZE5jZTkzMGhl?=
 =?utf-8?B?TXNUeHUxQnMwb25RVWxkUXgzL0ZoWlAvYVlEVCtQNXZndDRRWnhjc0tqaEVk?=
 =?utf-8?B?QnBTVkdDaHZYK05kb2lIc3dqNWhFS1ZmRXJPRG4rU1lJRk5TNTgwQzBxQ2xG?=
 =?utf-8?B?UWFEZi9oZmdXbFFRQkZpeXFncEpmRHpsaGtEK0Vlc2s5VWlQSXVIMnpwZHRR?=
 =?utf-8?B?L3RmREVFU1pTLzJ4S1VNakNtM1NHODMrbGtnSS9veHVJdVU4ejlmcDdZZkk1?=
 =?utf-8?B?MEFmL05YOURrS3Z4WnM2K3lJYWRCYW12SGxZSU15YXhlMWJneWFtSUhPR2wy?=
 =?utf-8?B?c1RJUWFCQTNtOUNvdEh3T3NzOC9xM2hMTVJSemJRTWVrOVdCa08wdm9jWFlB?=
 =?utf-8?B?OWl1Tkhxc01yU29pVC85UjhCYjF0bFV0dFQ5eGd1S1FLUXY5YlNlU0lhRmFE?=
 =?utf-8?B?akZpL250R3Juei9wa1ZNVHdydHk4Tm5zc2UrcUVwZkJHdm5NYmxpamtVU0Zn?=
 =?utf-8?B?SW52WGthK3lSUHhxRUN0d0pEa0YyQ1pCaXJpSDhqZ3U0cXQ0bHNxdjFkV2R3?=
 =?utf-8?B?Ym1nYjFpTnNwU1oxdWljbDhPUzczb2ovTXBBRHhGd2VOWTlNRG5GVTNIdjdP?=
 =?utf-8?B?YTlEMktVWm1KVmkwbEF5UVBNNFZTRTIzdkRWT1pMUVVmNHBSbktYV0F1TFNx?=
 =?utf-8?B?WnI4RjRXUHFPbnB0YVkyWUtFVEQ0VHlvbFhiUHV3T1NFb0s5REVYbkpQcFph?=
 =?utf-8?B?UGJSa2QrWFd6VnhSZHc4U3RhY2I4Q1dPZExHMzM4OEVPVjdXQUJSME1OY0gz?=
 =?utf-8?B?SWp0WUg0TnU3OVRRT3VMODFLdkFobG5ybjVvNjJ5M05xbzRjeG9XUjV1blp1?=
 =?utf-8?Q?ntbRKqCv8whAdMrBv2YUlKzxkzPV6V8vBpiSWH+eka3Y=3D?=
X-Microsoft-Antispam-Message-Info: 3IU4EofhMg+xJ8qm0HAKx9s+9vbUXIzMSwlYhXmlMYNzo4Pd+HK7X4kOC5GVkJbYG7BBh/NHA7aVwlrpzAvwXhMAO0wV6VpQXKc4sMnI8AzwyGYUSSPLItB6r2AAFjRcsgcF/8GllnPiOKWaZ/LF9mjMaN7QHW5I3P7eMDDfD8ox/OWE+kMtMJ3moOztXvNN
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;6:D/5XCYrtGF3WeR7pkmMS0yK02kdxARHsN8pX/WUg1N/aRpm3oxxfQTxuOtsf1ZzyZGO5d2qP/7TQJrpjJERmTY35uLyh5i7wAFMpw8sL5rY20yZ13Y4Y9e00KyoUhAFf4sIQ7yL+UXfLpYj/EXLDIR4PUXHEsX9hCAjW7ceOyXIJ+tdxUldUtj/H533pxRh0Ent0IjceRBDEnM6KTJ4s+8VNsJkUapL+dTZGiWbrPLVF8D32v7EVCQABD1N6kPtdQs3QXz+RmPhiazdLH0CyAdrkPisC2+F5CixTh1WNCsONl122cmDuzg9Ugyym5/+YjicH1RNXPzp6XwhWkU1Yj8N68sRaxOHWnppQG8yI++U=;5:+0KFTl9FliWN63YwKdsOJh4zg/CRdqdMA5SBtmjceivsdLOnoqGwG6Te1/0xT+BmZaezJv4YfW5V5PZ1fvhCq9q8/Im2BzZSJ09EiB7tP9NYLWtk6fT+/AzsoXjjnyZtuEFNyK9b/Uo7aV/jvK76p3tLRheeDZTInmQh3nBPsQg=;24:G9HVqPya0ShjSLONjlA6EY/6DjnErP3TCmL96jHMnKZJdtiYFZFnTzqiwtkgorqTZquXLJbzUrngmrZFnB9B7fNF5DFfjU+YYwteFDgvXKw=;7:jxqaF5zs97UEjMeGrpykRQz9lcLmIW7XzWEFfdJUZMnID48+oiwac86KPxVYF0/TyHMgljuL6f+MbumYvSJZKK28PVTiQTn1f6K6gXCCxQfzp8M5FwzgCYW25Zhk48b7r5TIhAxPZ6BCLoGO3bse/6Lcy2XL4ar0DlazFHO6MeY2Fh22Mwx1XHshTX1yJLzNd9aefGafvz7dhw+8ACUeOs/b9KdrL1vnA44Xa2Qgzm8QbQWidPHD9ng14UxzMww4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0696;20:w2tCbBsS04xImxPBYTN8c5xtb1KrlOQTryChpzKVCA7daOZLj3NiM07dVBNHvy0i71LaNzUTwR3VNN5Io8F+8pev2ixXf2REXz6gKYC74F61iU7mv8OScA84AWEbsRztZk0bKFlTBrOthlopkLFltHiFR632vQ8hHVfY9F0/qk3SCh6yCnKXxxbn0X9uFUAISFnpkRZJqE4kxELWVuI8z+/63CHOjQRSZfGRuq2XCRH+96PG+aVpRDIK4vvzbb9s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 23:05:38.9579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5f0eb7-a8c3-4bd4-e044-08d58a001abe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0696
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
 drivers/iommu/amd_iommu_debugfs.c |  121 ++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 1d941c5329be..47bf718f6178 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -42,6 +42,7 @@ static DEFINE_MUTEX(iommu_debugfs_lock);
 #define	MAX_NAME_LEN	20
 
 static unsigned int amd_iommu_verbose = 0;
+static unsigned int amd_iommu_devid = ~0;
 
 static unsigned int amd_iommu_count_valid_dtes(int start, int end)
 {
@@ -92,14 +93,84 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+static ssize_t amd_iommu_debugfs_devid_read(struct file *filp,
+					    char __user *ubuf,
+					    size_t count, loff_t *offp)
+{
+	unsigned int obuflen = 64;
+	unsigned int oboff = 0;
+	ssize_t ret;
+	char *obuf;
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
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(obuf, OBUFLEN, offp, ubuf, count);
+
+	if (strnchr(obuf, OBUFLEN, ':')) {
+		int n;
+		n = sscanf(obuf, "%x:%x.%x", &pci_id, &pci_slot, &pci_func);
+		if (n == 3)
+			amd_iommu_devid = PCI_DEVID(pci_id, PCI_DEVFN(pci_slot, pci_func));
+	} else {
+		kstrtoint(obuf, 0, &amd_iommu_devid);
+	}
+
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
 
-#define	PRINTDTE(i)	OSCNPRINTF("%02x:%02x:%x - %016llx %016llx %016llx %016llx\n", \
-				   PCI_BUS_NUM(i), PCI_SLOT(i), PCI_FUNC(i), \
-				   amd_iommu_dev_table[i].data[0], \
-				   amd_iommu_dev_table[i].data[1], \
-				   amd_iommu_dev_table[i].data[2], \
-				   amd_iommu_dev_table[i].data[3]);
+static inline int amd_iommu_debugfs_printdte(int i, char *obuf, unsigned int obuflen, unsigned int oboff)
+{
+	int rc;
+
+	rc = OSCNPRINTF("%02x:%02x:%x - %016llx %016llx %016llx %016llx\n",
+			PCI_BUS_NUM(i), PCI_SLOT(i), PCI_FUNC(i),
+			amd_iommu_dev_table[i].data[0],
+			amd_iommu_dev_table[i].data[1],
+			amd_iommu_dev_table[i].data[2],
+			amd_iommu_dev_table[i].data[3]);
+	return rc;
+}
 
 static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
 					  char __user *ubuf,
@@ -113,19 +184,28 @@ static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
 	char *obuf;
 
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
+				oboff += amd_iommu_debugfs_printdte(i, obuf, obuflen, oboff);
+	} else {
+		i = amd_iommu_devid;
+		oboff += amd_iommu_debugfs_printdte(i, obuf, obuflen, oboff);
+	}
 
 	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
 	kfree(obuf);
@@ -142,12 +222,17 @@ static const struct file_operations amd_iommu_debugfs_dte_ops = {
 
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
@@ -210,6 +295,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
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
