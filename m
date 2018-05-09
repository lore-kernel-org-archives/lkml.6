Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965463AbeEIQSw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:18:52 -0400
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:32352
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965157AbeEIQSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:18:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH RESEND 2/2] Add GET_ID SEV command
Date: Wed,  9 May 2018 11:18:28 -0500
Message-Id: <8a10f3890c47d60a998aec2513fee6ad0c27dff5.1525881878.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <8adf44db473ccda6ca626ecdaa058d524af189b7.1525881878.git.Janakarajan.Natarajan@amd.com>
References: <8adf44db473ccda6ca626ecdaa058d524af189b7.1525881878.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:404:121::16) To BN6PR12MB1361.namprd12.prod.outlook.com
 (2603:10b6:404:1e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1361;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;3:DimcSKj8DuIAjSiY3ld+75PvSm8nayKyvaKFWkZ/yhOKh3MipgUEYrrDLPRRhYlUanUjZxJ4d25cw+s2bL3dMQCs7pDmLtzzCAr/NeaJC8clp0cg+ZPT4LVRph3pmRhuOfU8pquoJH7E1EnYfDkkJOPou9sbyhjKi44VpyCxXtuEZzPephN8tc/gd24qGlsjVZQRAShDT4fANLHuOfNznYjVEFkw8AATZP8qacfsfDY0kK2nl59bMZXvg2S9WY8N;25:5fXqgdnJQljTxQUnqd8zQIOWvhMoXEMtMYHJIu8pBmndjNEZG7rqzxYm4pj1NhmMmbov4mgE0Q9EGhbpSOqcbuSOdcrzEiCPmwTwvTMcIYg0IMh5F8R1zrbZvCnC7AbHnKzu1qViAq8Fbkrb56Vmg+1rdXdiL8A8c6Xf8Xj/lw7NC9Wl+EdSepRsaXnDTnj2yjs5nygpsM7MWE3Y4ROZmYvWjPvOsLVvgnrkGqmXwMweB8H9727eygia0cbBSVt32muMpuQOhieeIJQBdKppGCij3OT2a0EK0ZSeR2mIEcY2uWXjlSKqMU4tvQm/qdh/8KEVHOpH7duSzeFYGEWz0A==;31:aivVEpvMC1uHQQ1IZwTyLJS4ZV9wzmCnkJbbKgCUKoiWHnpU6zstDSaNpdELypRalVSg76CtDGhXX6ddoWUlnDyG8n8i9liV4jdahyuDRRcauhaQwc+bquKfI+oBxZN11meboTGjJFPMW+8zdUlz5j+Qr92kbUmyd4ILEzIlQ3sWlfnW9c0QMA3QhqiUwLhM2YtCeoUpuDHooiZTGXK8LqAgmdB+E2P+0t9hgKUGzrM=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1361:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;20:2hrI64/k/Ng476Q5meJ9VZ3v+5m139xpWA6OLnVRNVr3Gi8RkmTJgYjtHE0pAF0N6JoLgMEJZIjV2EIS5nUj/LNeCMFMUoq2V+DWcuZlH+KM6g4rT2wiVmrbnbdv8Ntsnk75h3LkEEmsMV/v85l5pw0hP7Jd7tOIqvdDG5soacczfvUY+nmupm6SZDqe9kz1oTxEsVxxwy2USWBlPdaLjNXXF4NE+pvZjAuwHeoPz87sl/KqJrNTQZFCQsYIcCxF7DzmbNQpKox6AFpuZa/m94krnOi7tadGE4iXDthib5T919SiZldnv3nE+uhftVGgeuNLKwHGFGHmujlFIE0DCi7SJjfCd5sx1NgcJLIHtaVAKrJaBqDPyIXMoyqo+yUsqKzPkCUPA43QixftTJuRXB85W5kqrhS5vWSpuFazkO9W9qBAioKiQ1EX/SmruuSU3QBq3cmGBHjgk/7XpbY58pDySrsM6Yp4Pwtq2Ro4pjAKLR0yheNtOILD7NWJ+DKK;4:JnC8lG7fjA0CXX4X2UnaHiRkRdIAHMHPV0vZhZXy14CvcXferUoi2g1pGArT1dG2dXuCV2rweure3Al/eIJtVgU8c5JhkNUOMwAqKEDNEokb3Sg1Q5bE+Us83UmbJHovvY4n+n+wciNQV/JVL0OslZoEeQOAGWHmc76FvTr8f8CDoBNcYWkyVxGM7Ww+wBv5t0ym4Pa82ng5tAoAboiA2QFxLtlfl3I9RQ6Q4siary95emak98oaXbzgHUXyr+fagmSgGUxbBbDI6H20PVTBfZYhA+7feju8mCw2Zq+JOWScJ1VvVWM/PA4avlDiYU1E
X-Microsoft-Antispam-PRVS: <BN6PR12MB136154CA1F8A7BAEAFEC1F20E7990@BN6PR12MB1361.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1361;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1361;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(39380400002)(199004)(189003)(72206003)(52116002)(956004)(50466002)(59450400001)(5660300001)(305945005)(25786009)(6486002)(97736004)(53416004)(48376002)(386003)(6666003)(76176011)(105586002)(11346002)(446003)(51416003)(7696005)(106356001)(16586007)(3846002)(478600001)(6306002)(966005)(8676002)(316002)(81166006)(68736007)(81156014)(53936002)(16526019)(6116002)(47776003)(50226002)(66066001)(8936002)(54906003)(86362001)(486006)(36756003)(186003)(2906002)(26005)(118296001)(4326008)(7736002)(2616005)(476003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1361;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1361;23:apeeRxWVzTK6P8zj3gTs16fFrzqs5clGQ2IoBwpVc?=
 =?us-ascii?Q?s8MEjx4WdQZ2vbNW0ArmFNxQLfJ5LMK0PE6cZaQzj4dOT2ATuLutqQ/pFwBD?=
 =?us-ascii?Q?LD2TwdPegnnnKRQVRzSkxLuUcggPTWxqRl29pS47HSs790/f2s0jKdvcPfco?=
 =?us-ascii?Q?04VjLDkLTBNOrhxJVG2FQPffaz7t1l+seE4dPKypr5NmrucHpaQp2T1lgTOk?=
 =?us-ascii?Q?3/8qUJQ4iHA6XOUnczT1gOUK/aa9SDkbF+IPwA3Rd7HgMYtY75jxt4RTvNx6?=
 =?us-ascii?Q?lOpfW4Ml+CA8b5mzQzOHx8Jq9BVorPd1ZoytNaPlht2kMrWbkTS1mSQ+Gp13?=
 =?us-ascii?Q?6MyX1spPdCGpUhSoWvXDx+E1Fy+tkiIz1MVz6jvtq0VIMia0AGgYm7kS5EVA?=
 =?us-ascii?Q?lNeD6TLyTHf85sYzdVRvS6eHH6/td+o42zEV6n6hOPaCL1f9D/SNAMEHdFr/?=
 =?us-ascii?Q?7MRJ2Xm1ebw7PT+m5fFwDuGVve6SfpxBc+VEX9/n3Q5kKRfsuzQAMqHKbzox?=
 =?us-ascii?Q?n0uq0dp2In8jQQg23R4a9M17Qk67X1x+GoUbbzLpZ+lqcHsfkaoJ9tbM7AwA?=
 =?us-ascii?Q?vV1nKYCy026MmaqbcTMYzcPWyVIEEtdHcL1196JrnFq72qAmdo1Y8zq2/Vr0?=
 =?us-ascii?Q?oWKIsYL0MQ8rUObJJsdVGWkYncnx3WO1eFrlLpq97EOrclg5msB4LohrY5XB?=
 =?us-ascii?Q?d2gTebmLLH0qbskVT5H3rNH3pCD/R2gIYv3abgoLBMhEjJQvpy0bYn/lF/eB?=
 =?us-ascii?Q?Md4cxPmQc5348/e/aEm974Tu7W2krAiTL16pUJ283Dzd+OI4jwgp/lEawEDP?=
 =?us-ascii?Q?Vr76PF7r9b+/ebaMnI2chI3cWMb4/bwRj/JRdLCWISXiurWvASUxpVIBLFIe?=
 =?us-ascii?Q?XY6EySZ7XWoL8a7jea0E+628pVF3CL7nI079BZykJRjB+czc1HQadkTeE8in?=
 =?us-ascii?Q?H6fq+Vj7zz5NcOEisXRhN4mhs64XuCQkkUnL7Am7eN82u7WepS9JYUV02Rwh?=
 =?us-ascii?Q?bkfQLX/fIhRi9ZnLnVjx277atCyTlKZYTQro/ibXA18wgqofy2/u6CqoWhZu?=
 =?us-ascii?Q?29cGmWnFeWRw0hux4Qghtl3uhy6+2vj5aa2wepePdXUsjI+G6BkXvZUJwsri?=
 =?us-ascii?Q?yq1ZTF80XoQ9HtG3vESrpJfJ61n8r/Fsw12cnqi+HrZPZQfS0oB+7jYSjaJH?=
 =?us-ascii?Q?VZJiNygFOjo+gpy+rHCLTvikBbm6r2IGHRdBwGgiyz/VmS8PNW2bFG0SnLMK?=
 =?us-ascii?Q?CiV+6q51tPfahqlk29iOoWzU45wf19O8rgkExTxqnma5B80myjn117/yGiil?=
 =?us-ascii?Q?RonP5HqUQaS5q4yDvGK2Lo=3D?=
X-Microsoft-Antispam-Message-Info: l1gN56DXkTP+yNHvSwmEcMp+LxC8VfbkaYmX/+OlTebtYhwDnt4nrIX8GAZJtByJye81NId8CGu7mSxsyIZAi1Sn5d0BWsACSXPGC1G0YM+rD66bgcct7ToX6t8vRzZkTzhqEbsOKO2QzRoUS8Dr51t2hht2Vi/5b92se9zovl6bV0R+vSUL+T8W7qrbjKs8
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;6:JnZsM9YLVTNlOMSwxShYfIg5PSEg15MKP3Nk6xmwCVUZg3W/yY4SOvopWDoBtgMV428GH9fa0y1D8VLv1Ml6ZEBuigI43Uhlrsuqc9/T9Z8kEqg3bcOKbmMkHrAEKFgY3q4rHCJWH0uAfPOUB10sxdfboydmi+eGvvRPyxOcl28GZjY7XMid0kceTMaI1jTvEGWu2Z72YXzLLciTDn7S+KFCb0zy9IBDrp2Egl+eWmF86/Ugkqb99XzXX9BYZLkoZ56SW/COqdQ9uiX75G3BIrNkgyED8AvevUgPDUV6wXLH2xL+Ud5a3Ma19eOYe2t6xdL1neytnyo+b//KN39/DTCpnuR10WiO2LsvDqnqnqhOd37r3n5ijmyU06LsApkW8XBCrptM6aEB+S0CSV3m7C8nhIUs5PEDQS5KD9ICdNUp5OzVNAhtyaR7N9wo7vV48WQ1z0fmkTKN7MXGtR/W1g==;5:598ROrrvS7sxRQvlS6yEa7XwI0WP6AIeoRmINWx8Aoyqlze2OJX9xGWKRoxuzi1qg+AASNa2l0KToOdjmz137eQ/zmuX8kuOR0PzjSFfKGXbgwIjWh8OJw3fwLQUYYqSiljvclOaoyhhT/qLzhG1b2ixe6XcCjLtSVzbnOVok7o=;24:36DFMy32EEThqfPcYLGJsNSonW+A35+7YMj9WJDHAdQJgc5mR1lgU8+Ftw0J9bBhvxFY6RHflNahj54Dl0fErP88qej58D0bUJCp1/E6KXk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1361;7:rJPYKNfHTJOCm9nUzJlQpPZ5hKJAApMjjJvSm/JVro07x/0KrDpKfty8nui1ZepvBTamEKI27u4LN6tiZWLmaoCPTM+iKWLBELj9zkDH9s0vMK/ebwuL6HV0CO6ABUhALgOBNvZ6IHaQvqlET3PYZLnuP4M8A2TuLuUylopwYLXK6SfKvgtz13UCo9GyduZsn/u5Xr5eQ47ECL0nmAcBg+0P1FUaMsSkii3ZjNNIx0F2tfqHuz3i/TIIMGqnFkaj;20:CMZEMadQd8/mbu0Kz8HWZshA3As51XwhFZ8GY5v2vaDbaiI1zHIl35+fdFT37kq9Gsyo1pD/WrHue6/Bnu/OFEHS1g245Xz+OWix5dC6y5ea/haDcEgt8nYUJ8VZsWDZ5nmsG7uSgX0t4CPN/V1qurq4rfchRW7V6F0bUubBNDPDvykeEzycSMlKQC1Ktgt/JabLIQWed/RD3cZkPrr7FZ2gnqE8QcGor9OgkOUE2OucbaIzCVFrWWVqzHah0ntn
X-MS-Office365-Filtering-Correlation-Id: 4c8f9014-4127-4596-8f17-08d5b5c88a73
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 16:18:45.8804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8f9014-4127-4596-8f17-08d5b5c88a73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1361
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GET_ID command, added as of SEV API v0.16, allows the SEV firmware
to be queried about a unique CPU ID. This unique ID can then be used
to obtain the public certificate containing the Chip Endorsement Key
(CEK) public key signed by the AMD SEV Signing Key (ASK).

For more information please refer to "Section 5.12 GET_ID" of
https://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pdf

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/psp-sev.h      | 11 +++++++++++
 include/uapi/linux/psp-sev.h | 12 ++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 1c78a2e..d33a763 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -119,6 +119,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_RECEIVE_UPDATE_VMSA:	return sizeof(struct sev_data_receive_update_vmsa);
 	case SEV_CMD_LAUNCH_UPDATE_SECRET:	return sizeof(struct sev_data_launch_secret);
 	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
+	case SEV_CMD_GET_ID:			return sizeof(struct sev_data_get_id);
 	default:				return 0;
 	}
 
@@ -508,6 +509,46 @@ static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp)
 	return ret;
 }
 
+static int sev_ioctl_do_get_id(struct sev_issue_cmd *argp)
+{
+	struct sev_data_get_id *data;
+	u64 data_size, user_size;
+	void *id_blob, *mem;
+	int ret;
+
+	/* SEV GET_ID available from SEV API v0.16 and up */
+	if (!SEV_VERSION_CHECK(0, 16))
+		return -ENOTSUPP;
+
+	/* SEV FW expects the buffer it fills with the ID to be
+	 * 8-byte aligned. Memory allocated should be enough to
+	 * hold data structure + alignment padding + memory
+	 * where SEV FW writes the ID.
+	 */
+	data_size = ALIGN(sizeof(struct sev_data_get_id), 8);
+	user_size = sizeof(struct sev_user_data_get_id);
+
+	mem = kzalloc(data_size + user_size, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	data = mem;
+	id_blob = mem + data_size;
+
+	data->address = __psp_pa(id_blob);
+	data->len = user_size;
+
+	ret = __sev_do_cmd_locked(SEV_CMD_GET_ID, data, &argp->error);
+	if (!ret) {
+		if (copy_to_user((void __user *)argp->data, id_blob, data->len))
+			ret = -EFAULT;
+	}
+
+	kfree(mem);
+
+	return ret;
+}
+
 static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp)
 {
 	struct sev_user_data_pdh_cert_export input;
@@ -645,6 +686,9 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SEV_PDH_CERT_EXPORT:
 		ret = sev_ioctl_do_pdh_export(&input);
 		break;
+	case SEV_GET_ID:
+		ret = sev_ioctl_do_get_id(&input);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 1d24962..827c601 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -55,6 +55,7 @@ enum sev_cmd {
 	SEV_CMD_PDH_GEN			= 0x009,
 	SEV_CMD_DF_FLUSH		= 0x00A,
 	SEV_CMD_DOWNLOAD_FIRMWARE	= 0x00B,
+	SEV_CMD_GET_ID			= 0x00C,
 
 	/* Guest commands */
 	SEV_CMD_DECOMMISSION		= 0x020,
@@ -142,6 +143,16 @@ struct sev_data_download_firmware {
 } __packed;
 
 /**
+ * struct sev_data_get_id - GET_ID command parameters
+ *
+ * @address: physical address of region to place unique CPU ID(s)
+ * @len: len of the region
+ */
+struct sev_data_get_id {
+	u64 address;				/* In */
+	u32 len;				/* In/Out */
+} __packed;
+/**
  * struct sev_data_pdh_cert_export - PDH_CERT_EXPORT command parameters
  *
  * @pdh_address: PDH certificate address
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 9008f31..ac8c60b 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -30,6 +30,7 @@ enum {
 	SEV_PDH_GEN,
 	SEV_PDH_CERT_EXPORT,
 	SEV_PEK_CERT_IMPORT,
+	SEV_GET_ID,
 
 	SEV_MAX,
 };
@@ -124,6 +125,17 @@ struct sev_user_data_pdh_cert_export {
 } __packed;
 
 /**
+ * struct sev_user_data_get_id - GET_ID command parameters
+ *
+ * @socket1: Buffer to pass unique ID of first socket
+ * @socket2: Buffer to pass unique ID of second socket
+ */
+struct sev_user_data_get_id {
+	__u8 socket1[64];			/* Out */
+	__u8 socket2[64];			/* Out */
+} __packed;
+
+/**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
  * @cmd: SEV commands to execute
-- 
2.7.4
