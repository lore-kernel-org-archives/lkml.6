Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCNXFQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:05:16 -0400
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:24288
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751769AbeCNXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:05:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 2/5] iommu/amd - Add a 'verbose' switch for IOMMU debugfs
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 18:05:05 -0500
Message-ID: <152106870503.67212.6777943766050730991.stgit@sosxen2.amd.com>
In-Reply-To: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:300:ad::12) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48c805a4-960f-429b-1dc2-08d58a000934
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:uJnLZLT6/LrMTRQ8k4cxuPzc0eZiOi4bnHd3mo2TKVG/tZXu3AHxUe0yvE/2lM5UNodHDhBWJn0szQHEdmtMJTWi+0DZLVAylI34rBVd7csIdoxBdT7Y+VD1lKhcrJ2NNpEX/CiwX1wJuJP6iSPvRaysbdpsRWqwP2UGv0SC8eCAs8U2Irwb/wQfEwS0RbwZLY2n7uEpEfYeNUTNlIJxBtGhGW7gl4uqcqXQ2894AG0IkbkYpFMmn5yhptX3OZ+E;25:rq8+h2D+KAsQ45rn5ASzhGyEf60HJJfkhSlF49158XGe6WZqjf9Lb9Yks0dq3K1gGfjO80PRlALCG3A2I1tonhieDN3dYpMV862bQ1CPvTro/9r+gvJcbdLOVEtnQDPOh1hPpEAgB+n16xeVugmuYhQp5gRt0t3QtlOWFYio11VRgv9iTzB/aUMk13pbwOaRIz0TK7CP/y2410Ohyk3DmyYP7Nc9d+8YlVRsDxc6k5ngXJwd1Vll/WnqLX8FNHbrHVWSLwm0m4eKkm7AorcCfTJJ0FKN3+9yBc69kwWtABtTtVVX9mmZNqI8lBxoiJcOD7bAqtUL2ia2ww5Mz5bUf+XcXNDdtT8/MmtIzP5ZYiI=;31:VUAMKJqc+yh2Ik5ci0cElwUPB0kE3e7JKAS57/CUlQTM4y0th5kRu18O6w7CKQBHs9DqkHJ9I3mQmRUP8iV17o79sKXPVme7kfXwYu54P1ZdL8Df5gDZW7IK5HZYbq21+jf4cT1kZBtxBp1nxjdpt1TTLgfi3JJUuxS/NyEl41Wv7LQfaR9/7j1lYiUc4+h7bcc1QfR8KAhX1dIQpIsGrD9CDRZGh6mlIOH3R56fiY8=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:2xIr0VA6OdRmSTN3tQCmGTb5RSIAhm/dXK42sekhjW8QvxFv2bE0vR6CsAm0ijfTEciKucMMNTMVAt/5zl04k/yaF9qBOXhdfWEs5cQl2nO32KgwVRrXOgt0t0QYzzzmRaIhBwGnGQLsnuOLIZiVs3NgofAvOyxxz5HQmilGbK64tUNzV+m7YmUPgS+jiUFoDkwsUeOfQDVfmejC4X6g3N4bNq/QEzbN2+T1d1x/H7xOLFCKmBW7lfI1icWLzTXLoTEl/wdfUQc2gCqXeaWn+ollEluKAV+4TKybDzoJLCBWuDgTX3EuwBLRyIOxFXjJSq9/FuN2LjaqamfK+Jr5sNWzrE3+9SNInuHm7Ap8i5LM1msxcsYjeLAX07apa/93oMxqcc4sUlbdKv9ze4818DoRhca1JI05EniEfMwQkyZRF4YJuNW/QBAmuQAzlNsVG0kh2Q3sie9VOrly4J0eukbVY6qIji1RmW9vHH6ZARFQkk9nhBY0E6dolTRo3fcN;4:h5RYthKC/CGF3C/af+vow3ZiRTyp7FFcx9g1i8zTEuHuYs+ZMpA53weVBp+6+YG0Ci9q+aQ12OQ/mmgLABULMGHXRNqXtkYx5QCyyKDJ0GWDHtYHSJ6ZaO3OavaH4FBmbyE1l4zKZj9Z+ZK7JkgSwwUwSMecw2U1udGcMwypiPIZPEij+kGOuxqbq+deTLrmcyiW5ukXxbHewh5INvSOdtCVjKKMxMuB+0nKUpxTLI66q9gJA8+Smms1ySoxqRO/J4FTK5rdV63H2MlgVVC3ySXmi9QjESNFw48KPqTlTcAWkfi00ChicrHw5z3tX5eo
X-Microsoft-Antispam-PRVS: <SN1PR12MB0702097846F487BE6DD624A2FDD10@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(366004)(376002)(189003)(199004)(305945005)(386003)(76176011)(186003)(23676004)(59450400001)(2906002)(2486003)(53936002)(55016002)(4326008)(25786009)(6116002)(26005)(2351001)(106356001)(66066001)(2361001)(52116002)(575784001)(58126008)(3846002)(47776003)(86362001)(68736007)(7696005)(478600001)(7736002)(6666003)(16526019)(6916009)(2950100002)(103116003)(316002)(53416004)(81166006)(8936002)(8676002)(81156014)(50466002)(105586002)(5660300001)(72206003)(230700001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOnBsVHNReGN3blN3S1dlYk56ajMwQmZxYW5l?=
 =?utf-8?B?cWtVbXYwbGVoYUlzMmd5MXMvK3BPZVJEMGttTTU3REtBNzllam56c3BMMGRY?=
 =?utf-8?B?RkVZWEFna3FxSU1RTE5PRjZ4WGxUT3phRXBTN3dQenJTSVN0YjNScTQxSnNl?=
 =?utf-8?B?RVhPTlVqOUNaUU9Pc2xRUzBqOWhxZUN2WjRHNElGM1Z2SmVBVVV6SWhYLzFm?=
 =?utf-8?B?STFVQnJ4a2F1WGFTOWhKVjl6ckFVcGNZaUY3SVFTbVY3UXY1OFR2ckZ3dzlH?=
 =?utf-8?B?R3o1bVBQZFI2NGhBTUFxZ1BaZWEwZEdQelYrN1FQSmk0NGorOXovWUttR0tC?=
 =?utf-8?B?Y3JGeG1mcytkQTJ4M20xUjhDK2Vxdm4wNlRDZE5HNUw3Rk1hellyaWh4MkxB?=
 =?utf-8?B?MXVZRExBblFqem9OaW96NGx6Tk9lR2xYYjMweFphMFdnYTZLdFpHQzFQTDZj?=
 =?utf-8?B?d0k5TWV6NWVjcm9URmhHbUlacmUwOHRoQlhWa1dsM1QyTHE5dDNHU21EOFUv?=
 =?utf-8?B?YXlOWVBiMEhlZ3FkWkNMV1lOOUJWM3ZNcDYwMEpMdzMxYlAvWHZnS0xtcmR2?=
 =?utf-8?B?YWd1WFRtWjBqbm9SQitmUEpYYmVlVWdMNHJJMEtIdnRFSTlkNjJsZkd6WEZz?=
 =?utf-8?B?MTNTd3M4V1E3MVlMN0JrK21VUGlOeEV1OEhWL2JXOFlqQktlbjJnS2tPL2pT?=
 =?utf-8?B?QjRIZ2VOS3dpMTVuTGRDZ1lNa3kyK2s2eGlvakQvMm9vN3RaRTgvSEtaRDQ0?=
 =?utf-8?B?YnNxeDBEcE9FZ3NhR3IxNlowRHpTTm5hYW5KUi9FMURkU1BpbDI0WEZKU0l1?=
 =?utf-8?B?bndIaW9lVU9lY2hSY2J2TXgzUUlmckxZT3FRVURjVGp6cW0xcWdCWkg4c0pq?=
 =?utf-8?B?YkhzTWNMbGdQRGFORm9TWjdtRzZobGRGcE5sWGRmMnlMcElTZ1Y5MXFvdEw1?=
 =?utf-8?B?d0htdnBtM2Vjc0kxREFiRjBPdUhON1ZRQlZsTEZDQklWdEdZUTlJMmxLYWdQ?=
 =?utf-8?B?MUVZNzhXbHNEcjJkTjhIWGZFYnNyOHpnQS9mc1A5eXdCM0I0dnFmUnZuUjAv?=
 =?utf-8?B?WTE3U2JGNDdWbGNsQUo4TVRBM054eGluZnFaQUNjeXZOMmFUbXFDOGJaUkE1?=
 =?utf-8?B?MHE5S05KU284OTlzMEFvVUYzUGZZV3daVzNTQ25rTzlZMHZ4U1ZYTFY4bUVH?=
 =?utf-8?B?MnpXTzZQRko1TEk2NXM4YzdWbWcrL2VEODRxZFZ4MEVVTENPZlNpTWhlZzZz?=
 =?utf-8?B?RUltQVdIdW16bzBGM1kvOTBlay9EeS9UY1k1OE9ibTB3NG5vQzVjYmU4RjZZ?=
 =?utf-8?B?R3RUTERSM0xVL0ZNVnM0MFVLS2orOFJRYkJXZmQvK08yQWthMTlPV1p0QUdS?=
 =?utf-8?B?QmJiYmtGekN1RldZeUhXczg3aGdHbXdEdHFEVkM3SFR2Z2dzcHJyZldWWVJS?=
 =?utf-8?B?OXR0d0RhS05jWXZoTjV0UzBybWhvak5uSTl4b3daUU9PWUluWGhBaHl5UHRi?=
 =?utf-8?B?bVNSc3lzQTB3Z200SlJoUkNoU2paTEs0QURtYVVWSUdqbW9XMHFIQ0c2ZU9l?=
 =?utf-8?B?ZjNzaStCWlY5dVdwdjI5Ym5qdVFIWHRCMFVUOGM4SVpPeElSWmEvMTl6S3FR?=
 =?utf-8?Q?7AWJiAGG8KnbXlNncj75?=
X-Microsoft-Antispam-Message-Info: 4v/4yNyCgkx2/QY6n7zwmpHyZK8wp9kYtMSLXVojCJphKOB0oSHbI0ub9Fc+0L8jzoJV3y6moHFwOY6wPQ5FexXiceFHJ8aS0eBmhiqIjGoIY9CH7skiqL7Va6YLM5KRcmQCDXq/Nv8vb7poc6EgkHUbK5cQfIqfEwNUQ86kKc8kr+KbHnoIOR4aBnMDucDV
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:rQ5l5T9lNM9WBOAZfuVrDqlQfZTFTgXPuEEEOQXwsXPnelvNGgIySVqnBlRCW4+/KNRMB2q/8ltN58fWwNqHGLHKRkAHmVJ2UlvDyhRRrN9oA//x57eBdJru3ZcTrUp2LRZM56gtqfQeAlIpmRRuL2P5U2iXLc/+MU0dpbHTnkmtFDNxi/CA253DZeV4HuL1erEVIIi1nOLNn6iw5Vcnb4EhMP2OZSsi04D302hUmgAz3XDWhsabKYEFKL1s+mGOEmydGI5Ho1eg/cIc1VeohNezGv1mAXc0QSyAlGquRvVrVURAAjobbscCNnuvAU76tzngfW5iFXTFB3Uy6+IEM2dGyPbnaiUyOt+lGmyxr1A=;5:/3HGcl1aZJ7qTlHpJ3yGkIjCDqltJU2MMCNFm0HSc4plHQf77VRyo4kprAko9z5dSLwAjWC+FeGsOVoAftF3qm4FlV9l+3CyV4N/pxN7rwSCE6TNKewCV2Uew4O+e1N9TB46PUWjuJKivKzBQ/FUa+1/jjBg5z6dteTC9xIg3ug=;24:kO4jm/IomyWrrn05zKb2zVACVjXHULi2VqZvDAYRh59JwYjIRifrvabVSlPQKD3ZY53u4XCKQXbccT6IcevS1izD5WkfdIRxEUoKEqmeW+c=;7:uZApVFZnGxfibSAivvItxuSZFE9akW9D0oC9AkulHKjvrXbLfn+M+BT/qhkYgP8/9xUpsW3x7VKtN27l3A50MWCoVIhS3nhV9Mh478TB6SfEzQ/qJdKqr924TFJw9EkqMOndcFnmQy6Pbi99xQdI+UZitb9HykQysqU5DRYw09nMXrdYUx5m/u7g5FzmR1qYdkB12UZ1GoYqIXtC/y9eyX1H2DRUg6duRbB4yehRE7H8RnjWIm0wu9SpLQauR2VS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:ReH7DOLLwB3nLpH0c2IOSQ2Wkh1TRieNz5NTZdFgWczCHOrCtaA0KG+Hmw3rwjl/zz9Urar53QXaKyx2LtOUvlq6tcJLCydhU/SDPnpQE5jlh6jFybAr6WCE9CgwnJmWkLEn0KaQ5r905glBhvlGvmQT4H64MVScOfiSzoYPJauETn8Z7aGSiQUF3/7WUtJZ3T521DMducmNfVU4RJiui4IoMcvRF/iLPNlvfbMUXlH462BvuDBkzBRWqff1u6eV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 23:05:09.3867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c805a4-960f-429b-1dc2-08d58a000934
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable more descriptive debugfs output via a 'verbose' variable.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 4f0f05a89a41..170863e5e86b 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -41,6 +41,8 @@ static DEFINE_MUTEX(iommu_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
 
+static unsigned int amd_iommu_verbose = 0;
+
 static unsigned int amd_iommu_count_valid_dtes(int start, int end)
 {
 	unsigned int n = 0;
@@ -72,7 +74,10 @@ static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
 		return -ENOMEM;
 
 	n = amd_iommu_count_valid_dtes(0, 0xFFFF);
-	oboff += OSCNPRINTF("%d\n", n);
+	if (amd_iommu_verbose)
+		oboff += OSCNPRINTF("# DTEs:  %d\n", n);
+	else
+		oboff += OSCNPRINTF("%d\n", n);
 
 	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
 	kfree(obuf);
@@ -90,6 +95,7 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 {
 	char name[MAX_NAME_LEN + 1];
+	struct dentry *d_verbose;
 	struct dentry *d_dte;
 
 	if (!debugfs_initialized())
@@ -107,6 +113,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
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
