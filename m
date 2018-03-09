Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeCIAvc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:51:32 -0500
Received: from mail-sn1nam01on0079.outbound.protection.outlook.com ([104.47.32.79]:43151
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751024AbeCIAv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:51:28 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 4/5] iommu/amd - Expose the active IOMMU device table
 entries
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 18:51:19 -0600
Message-ID: <152055667969.63229.11784633364919979184.stgit@sosxen2.amd.com>
In-Reply-To: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:0:57::15) To BLUPR12MB0692.namprd12.prod.outlook.com
 (2a01:111:e400:5951::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef92cd73-c42f-4760-6f72-08d58557e143
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0692;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;3:vicxqEkVqlGyMzAq961tjryCGEPVQIhGhu15JPo7NNAtSyWx4Y3leArMC7WhdeWTdim1Shwdqs0ao1yKhOLc0cJGqxhXJ6Pg9lktNhwPFvMv2dCGiiPZKv8RJ9T5NFlXqqPzsZ8rFvyE1ZRLD8coj+eMFwiKkRaGwM9OuuVqXyYMTVXHT/Uk+5czqJxjGcw2hTufFjdx/UEg34AFf7dxAZcSIiebZoh2HUCQfuIUL4Dj9af292Jc2eY+2BKxInfV;25:AYmydO4Oxaeg5mlqiuwmk8GzQodbBk1a/SrRnTitrh1k//4WGXz2flFGjZHxtSBVNDhwcPT5a1lH+JnrodN+cczNUjRrUgz6ZDZV8lPSvYfZptl3ei3aM5/69NtiGewn3W67JG4c3Q8pKboc3/qByIV+ABL5Nuw19rhEwOx9SQ3l0HlEHtEUnSxMerXja8VCQJJsfoXOYfJBdjzFZJvP6SrcUkHQMJ2LYtP2ctrwwMb7l37fkrZ58L1AIEFORlvJtklpvyn6GUHM+G4VJquvK0v0Fst0hOtJ7sglmkHgt9Ki+6LOEh5UiFoLRT1j6MXsYrbaoMi9HPOrzVGjoKCH8Q==;31:+S5B/dv47f8uH1hGAxT7Ta2dsbYZD1iD597ssYiRnaBlVdilhoTHGqbNoqSGE5suVsHNF5Lw5fUZGX7FjQLk+OXnzdIIfI9kmqBiQA//DbzlqVxoGeYL4yv91Rq8K39mx1NiYvESFUvJJnTNgBycBc/Qy7DVHCAPVls+QyKUV8GNdA1NAxEPbinDwRrAFBpLYjw9w+fkj2hBLL+YVeLfEPmLnD0JNtLoJh/Y2tx9zaM=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0692:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:od9hvCMSkJ6p+JqGT9F8j1euPZajT81PWqhfSfspCy2gZ5353UZ/NC3fZ4oIjrqxl856jyD+mx/eugBvS8HFQMlSN6NgtBqjWOjFo501no/g6Bd2jWpC/TDh9uBXPB+/ExlQxbtFwjtDGfzkKwhQTnKQri45jebZjEusEMNf0KR9Tc+O5ovz7H/qa+XD3J0DlGln+YwzxW08KDTz9cPjWU6nrzmQwoOXTD/g/vQ1S9Ia7eliEgMaN0QkKJNCAHX1W5MHhD2AKspvp1OV++zGzbeWIqyoZnkHYAqBYEQywzUumNnU2IW5yvoNWP84QCiUOYW6qjdUfsTo7SjKdBQMoaEaTZJV0W85uDiNFc2mzjoeahChd5/oGWyzgT3A1QVICrdUc7ofgbnKjFPHjKwheoH87OkcZ0CDl5wsqfIkUoX4+dPWU7kNvMx4sWahTBJg3LELAtjZaeaIHlkze/w2Yz3IN3lolu0NyEqCkNBtuFS+QqNk8Yif3xd1nBHHIhJO;4:SDlu351Y1doUH51WGcTCoPQA2h/+YUJod+WXKOmU53148ps+pXMthQeI98Q+JZucTJj+PpIoNc94Ok0lJvmc48qXYFk2/Sq7D12Nbm0Np4GrlpGAqR90q8IpZmrJMNkCOc1KdvVCQZsC+HpAvsA1DJgScIX1vITH8EwMQf8rnCNqGLk91JT+SYKs9CnKqd4/hjUydzXBJDbEA2PwQMQxcF7YTTNJHZi+8TazXMJ3nIG4e/t8t82yEEPuSRKcdHjph2YsgtRPS7edpwl7CoYZrgm3I9T+WVSEimOXKNSDOnO5PtsowsqQ0X/vnFojBA7Z
X-Microsoft-Antispam-PRVS: <BLUPR12MB0692BEFF91B92D096928295AFDDE0@BLUPR12MB0692.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040521)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(6041309)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BLUPR12MB0692;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0692;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39850400004)(39380400002)(396003)(199004)(189003)(316002)(55016002)(58126008)(2361001)(76176011)(2351001)(2486003)(23676004)(7696005)(53936002)(26005)(47776003)(106356001)(230700001)(5660300001)(25786009)(103116003)(66066001)(52116002)(68736007)(105586002)(16526019)(6116002)(6666003)(2950100002)(6916009)(53416004)(97736004)(8676002)(4326008)(81166006)(81156014)(186003)(8936002)(386003)(50466002)(3846002)(86362001)(478600001)(7736002)(72206003)(305945005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0692;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkyOzIzOklqeGFFYzRVRzVzdzh3WjJMOVBuVHNoUzRa?=
 =?utf-8?B?OGtnRTJySXp1MHhsZHNBczZ3UjNSYWRLUklSVUFmM3IxTkIyci9MOVNQNzdJ?=
 =?utf-8?B?dHR1QTFGK2Q2OU5oV0c5UGJTNTZNY3VvelNzNFdxdVdhNFljOGtwRjgxdEJr?=
 =?utf-8?B?TEp1OUxCRTAxa3R5Zzg1WmRRVTBYZ0NMK3E0OGV1R2gzd2NWVWI1T1FMOFYy?=
 =?utf-8?B?YitlMTFDeGRIK1VUc2IvWmRUNS9pR0YrR3BvSm5vRmp3SGwwb1ZHMXpRWW1R?=
 =?utf-8?B?MDZQS3dKR0wxQ2ZiRTJXMGcyV0d0ZytMdk1HK1YyV0s4Q05KN0xFeEM4aU9j?=
 =?utf-8?B?bDFZVElzTGE2ZDEyT2RYR2lwK0d5dWJKSDN6emwzb0Q3eElwdVpVaFRCQlBt?=
 =?utf-8?B?VXFLTVE4WS9yUzNJeFdIVHNxTHg5VG0zcld0Sjhxdk5FSkJLb3dSYmtSTUtu?=
 =?utf-8?B?RmtSWWJWQ2pOK2hONWJQNDMrYnUzOG1yb0l3N3NycGsvMEsyLzNrS3dPVCtL?=
 =?utf-8?B?M05uWnM5OEE5b3RhQ1FmYUVGV1YxY2R3RmpqQnNvQmg2ZHFrU3pnYkcxUC8v?=
 =?utf-8?B?Ym8vVDYwZXBDbEFlSmpjVFZiOFNrNnFwY0ZHR0pYdHdwakV5dUNrS2V0bXlm?=
 =?utf-8?B?ZnkzK3pCMG5QbjJzZmxPb3Z6MDBqTnAvRTVUOWNlVGNlcnZlaWVvQzlreFIv?=
 =?utf-8?B?c1NqYjVRSFR3aSsySUN5TVFCMkdBTjkzTSt3TEgzOUo2VGlsVjBnVHJ6RStG?=
 =?utf-8?B?SW1MaUJnby9PY2wxRXhvQVZxVlBxZ05iK3ZVc2JzWGpjOEFwdmVyOGZUV3Z6?=
 =?utf-8?B?QTVlM0N2K3VGaWFiTDMyMDJVZnZodmxLYTdLVmVhMzVRS2c1MHJOV29LQlA0?=
 =?utf-8?B?elR3TnhhZ013cFdiWDd4Y2xoZVFUZjlMUmRaVHBHT3huZFJFN2N6d1IwUnpE?=
 =?utf-8?B?ZUVZVVoxK2Rua25Xem9kVEpCTmxXazVtWC9YSE8wWk1XeXpkQ0FkYXBQVE5o?=
 =?utf-8?B?ZCt4R3VVekRvMmNvTkkyNlFmL0VMeGJuSEtjejFWRTJYU2QxUVZxVE9kbUdG?=
 =?utf-8?B?OEVnSzR6T0NqazhzUmhEOU9lMlg0eW10QnNnZ2VDTXc2eHRTVk5CNW1pUzhO?=
 =?utf-8?B?Qk9oaGNLVzZwUjB4NWx1WUVpSTdCU0NtRW9vZDU1ckt2aDU3VENPajZtbnZw?=
 =?utf-8?B?T3ZHSStReTBRYmd0RDFyYVZLaWp1aERQaGtnbmFjWjRSVGdFTkFVK2FldDY5?=
 =?utf-8?B?OHdRQkpxaEZTQ2NRZUhnWGJGRlhmc3dyaGtGZStEWWxmZ0U4RVBHOFpzaUUr?=
 =?utf-8?B?VEJEWGlUdkIxSkRNVnUxUHZob3BjdTAvZHJOZnlaanUwK0xLUVNNaGd1eVlo?=
 =?utf-8?B?cnNueStxYXdOSllZanlmYlBTWThSV2xWTHoyd3ZjVk9UVUpoMzlXVDVhQjk1?=
 =?utf-8?B?UW92Z2d3NFlBZU1yaDR4MEJoUDhHUFNkaE1vRjB3V2E3R2h4QjRiRmljWExr?=
 =?utf-8?B?Z29OMlJjSTZLSUZJMGtGM3FVcTYvS1QydzYrRXFrNWxLRm1aQlpKbHUwV0Fy?=
 =?utf-8?B?OGVmRUtCTThzbUZoamRPREcvQTJxS0E9PQ==?=
X-Microsoft-Antispam-Message-Info: JldR6IHNISlaGTih6kFOVQt4JNMHr0Hs+OECl/x8OQ1BBBfqxV1tv/0a82D89E3LK/Wwy0i5EdUmPPhWfPom623q3LTL7povMXMz3iVqsQuqC617UVIX7PsZlqg4dr8eblDoa/uxhvLbyv9M1kq4tnw0QR2CHxBRN/06waxXNcJeDjIJuSVPA8eqv2Ytxwdd
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;6:QeDD332ax8nJulw3EY93aUB18Ouxc/g+aDIFavix61YYuDjjtk8ZUYzRs4TmYxwo8VVpIYqneELzJfvxUIjx4RlY9eoUmtfhKNMeJZRTa43rfhNQ6EZGfZWgc0poxkrK5e2oCjomaTwZ0JyYOwW7qlSJVxE0IW/p1Sm3XngSf4tY0oolGfOIgXg2qR7REy04Bk672xKNqZ6/1Sh3ow3eXdPgE/mF5ajkwycEn9qGE+Pa/lW5cuTpUuQRMiBZ3ZV7Vxgvh+luKXYgfh8QSs7ez7cK3bGb99ZcfAYks9/GxfIjtkXT90L9jpyGacv4wu7M+eT7O6bRFB8jy/DvBVPTzr2vvh/ljq4mnumaRRUxHjY=;5:+JwlyRpJyObe9smhW4VdeX/oFVhQ9mMfsVvVfnFb4NZGCHW/sgEF3av6/rlx7ardL0a0zGO3LpgM/Um/2hDJuRgMeKLa2zaCuTddR1YnfGp6nv92H6ussspMgofRCtj+zr9MLHYJYEeyXqJsLFDLxIsO3yNv3kx1w5grkd9UO2Q=;24:5nkgLxRx5KAePZjBs9hyg++RtcmIzjHIvfvZyQOae8pCJYvQ6YaDV78UAupt2Af55joAJRgQwu9ASAMqeHGMMXFkuAfQr/3igvBhNQsNwjw=;7:7Km5kAgWHy6jyOu4SLh9VsKYXwDm+VbsEH0Bbuo8DYeRHh3nRzLbf2EkQJQL0+3EvYeUuM4OGktUejVmQlX680xMKgJtWpPN2I36UlS00A/5sAmUqskbAUHgKshvSiRyNRJxXFaOvb1teon/1fAsxm6Y1UT71KTKjdjAWrPzHIGyFVfq3+VKHroUZqt/q338C99ssmRlVDxEknjtSzYZAvyfwXL1atPnaeZ08GiagVaS8dXv29GYBnUVYYoZEO9e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0692;20:Qjz5qpCZO34pIZx3+Et4KqmeTLWDYQM2XaD7gfQ0eP5vIBTg/b1Mbh1A16QkOv0Vjhlp7H1GBFHNeJcJDKPORZs8cUdsDGxj2a+n1hLZLvxd8pbn76t/ymjTfIDVrpysZzD8XudTRXTDPlsk5jeQow+cXAhRzhaZJW6WCe1kk0nc0X/QFeXM7ZBuEDGaVGkpN3n93EAJU6HUWTTLxvjn53WLQFkDgfYWAS7WGUSA6Vh1QgY3BzAsQRm/S94jvoUH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:51:22.6985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef92cd73-c42f-4760-6f72-08d58557e143
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs entry to dump the active device table entries from
the IOMMU's table. Active is determined by non-default values
in the first and second long words of the DTE. Aside from IOMMU
devices, this output should list every device reported by lspci.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 79945ce1199d..c4e071f7a5b9 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -81,9 +81,66 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
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
+	struct amd_iommu *iommu = filp->private_data;
+	unsigned int obuflen;
+	unsigned int oboff = 0;
+	unsigned int istart, iend;
+	ssize_t ret;
+	u32 i, n;
+	char *obuf;
+
+	if (!iommu)
+		return 0;
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
@@ -134,6 +191,13 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
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
