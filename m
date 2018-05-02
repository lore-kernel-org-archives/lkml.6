Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeEBUy4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:54:56 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:32384
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751045AbeEBUyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:54:39 -0400
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
Subject: [PATCH 2/2] Add GET_ID SEV command
Date: Wed,  2 May 2018 15:54:09 -0500
Message-Id: <db130e762c9752700688c2c073b994af560fe6f7.1525290220.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a5a123a10172efc267d6d018094f643d373f3bb4.1525290220.git.Janakarajan.Natarajan@amd.com>
References: <a5a123a10172efc267d6d018094f643d373f3bb4.1525290220.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR2201CA0073.namprd22.prod.outlook.com
 (2603:10b6:301:5e::26) To DM5PR12MB1370.namprd12.prod.outlook.com
 (2603:10b6:3:76::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1370;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;3:IEeiATEmikKvYgZWOzXAFQT+9SUWp0WLjgltEhKkDcxCFhal9+GfO+RwcDXM8JwnyelPo/zNSGfWw7xnwZWu1XxZy8qOEQdqGG1HQKogUXb1HJ95JD7c+do2UvkkHq9HWxG8u56U0pB/62B1RRyLXhwVZ8Fx03c/5JXAF9EDyBCH0d78idC20M0ZW2mgub0wPiVEAjniaAmtDCLm9IEZNZITNmIfcL6hCq6aqhs0TAMzLVbPgH/JAyTnOfPU+Kiq;25:a5vP4pQC9D6D/vZvckM1L2/I4AUfQgcDNhRABAqsQg/CFB9V5CntizESJSUbOMmwKg+yoq6znXwKIQsRLlV7qVU48Ey8IlwvylKM9Km4w0E1L2gWfA0wMXyRf6OpnNIsfwg7vERHo3QRci79mst6Zof/Jl8MN7efJJKaab8Ska2TU5FsNJNmOVoZiRfl2EhcP5mfy9pQRcMqFN4UAXYohb6ZzirYNcz6MEFfpU/GBUw+eo3Br6GmeexRDz19zrSl/3OZCYHr3313nQuWGE5QQq+8M1Z+9jjf3slPItX+rUSJJQ+HxXBwEjaSUOE9WlPRHqClRpZjMJyV+18G+E1+Dw==;31:iQbX/cbnAzwJxV+HezRXz4YBXGgSG6r1t9M9QZMcpE7gkXhUX/msSmJRnhdbt5J4SYzOa4aeVob+e5zUhin0wO8WmOXoqgv6Pz7X6ASQ46cL3shLHRE6q5F4mfBjZGhEnr5NMzKKRSCDMWyfRofWeKZyDGcBK4nwPvWygcij2Li42femIuzxV1tbguYWDLUNn8DPIcNiPOgVNqL8oJIVGKl0OI0V2CTVOFG8gYY+878=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1370:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;20:DfdOuuz52NO6JOequjbg/v+wPtOJmJZSxxhcol94t41KHM6r1dAZhoDhni7EQxh8/ZMDn3u1wyG1aXmackT0QJuxlABM7/1tD1TxnHiDaVSn2n1FCujmpeRqpC2zJIHqh78RXi+NNqKrBgWZqorh6j3fNHnZtSchAJouQNNlOVUwNNNEH7Or+EZZg4EI/EiiURg2JaCNBO5rj70Zot6BJ9Ix+QUU+FBZw+aQVgb2DffcWijB4krr5pfVf67Pe5yQVq8exYrFAMmXvwb4XQsxTzumlx+zS6J5H3nffJ5oIcDF97qPVA9xGJ7TUDiytMwM/95/mmOJU3L9U7NwyrE3ey1cReqOnp6b0jD8DnFoU6j7tUNlNNZuEoOi4NngoMxHAnXKBFBnAja53RB7k5nedzDQqnmYZNx5t0wWYS1zOGUWCnIdmc+8x/Eo52b74+5ksgfhS8/Ji4EuvCss3GKyzvaes7ThgslmWPWG1CBM4siZW93UzendkCHmVP00oGat;4:cnu+6BsLF1ZfYghq03z8DbjcmjV9a8Y8JgxQTl6RliplIL1M9RKrU1F8HWm9RNhXQ2gV8Vp8hOkTvTU009kMe6AkYvwZroExwc0pvuzoGPD33c7a3tldgKdDETjF/V4dL98MqEDB0juS0CqlX0LBgeC+5EFZ6y7TZPh1ULhG90ArwfdMCycd4oUUFNKJvMuIcJoTyxT1K1YSyDeI6M8OGCasQNPOK/JNx+oVUtMMwpToZIZrcpKKU/6FLlVm8aAY3Jn/Np/nnhdAUa1u3lBJeK6APODMtGXHO/z4GWvWp86WkAtZdSdHKpIf48+3Ylhx
X-Microsoft-Antispam-PRVS: <DM5PR12MB137005AD52D413618EB320BEE7800@DM5PR12MB1370.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1370;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1370;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(25786009)(72206003)(966005)(6666003)(5660300001)(50226002)(6486002)(50466002)(47776003)(36756003)(66066001)(6116002)(48376002)(97736004)(3846002)(6306002)(68736007)(53936002)(4326008)(478600001)(81166006)(81156014)(16586007)(76176011)(16526019)(26005)(8676002)(386003)(86362001)(52116002)(59450400001)(305945005)(118296001)(11346002)(476003)(186003)(105586002)(2906002)(7696005)(8936002)(956004)(316002)(2616005)(106356001)(446003)(53416004)(486006)(51416003)(54906003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1370;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1370;23:+vI1FArrJUiQ1tIrIQazzyTQ+I4bf6JsfijFN6ZtS?=
 =?us-ascii?Q?1DIOpHdQQmgpXaMrTgKsaDGoDlWnkp5TmZSjcEuAxUERrhrlOKOssVXcEYCw?=
 =?us-ascii?Q?Zk3SqvKIVvOh5tWi514PNpbOT9zz7+lymsUqYRSxFTIS1CR1iBvNMqussp40?=
 =?us-ascii?Q?93Msk/Y8H7IHK90zUg064d3Sm91JiACJZwb2eCQpqsTrpnipp7fXuFkYD+um?=
 =?us-ascii?Q?Z2LKmSAePFu1EbnuMjsRdp3PZiRTBvBBf5qM4oAhDf/K0sU6FnbEN8ASCCpk?=
 =?us-ascii?Q?wqFZrsUYRjNDSL6h5sAlHZ5bP1AsAN7j/VaysDYv2IgN8IU+YSutQqiu31ed?=
 =?us-ascii?Q?4ADXYTAJAJwTL3F8RSnaxQbLL9RWsddYQScY9kudlz3yJ3Me8riP3bSu2snK?=
 =?us-ascii?Q?fwUdPL14JZexr8tQ2lk81VS8G/Z7sdJ9mBeyoZGCNkqFBlDRnhZ1nok4WkrG?=
 =?us-ascii?Q?xKMm6heUaeO04g5zQ1jc1OVFGbzpxd6as5N6PUQjtTZCtO5HUIas4zp5G6Yp?=
 =?us-ascii?Q?mgxQ8D7E6ja3YwvrRJnwRHBnvFi8D0urxBJlOqt/vj7zxGinEZpVTbIqROz7?=
 =?us-ascii?Q?G1fabB/dn0PKFjeEPsucIz6KStUIpns9UL0d4QSjJ2Rdlj52+BgASpLd+5aV?=
 =?us-ascii?Q?t3joWv6zzM4r7c64XhEdfuv5NulN3GkHYcSTm8v8RY+D6QYGoFEtSZBhe9cA?=
 =?us-ascii?Q?LA6jm+dgYorzgnKNOgBamgjqfhZsrebTuM9JSeAa7rxqSz6KcoXHSfwPkJwh?=
 =?us-ascii?Q?j8qoto8qK/8gMTqplDYl3xwAJGqIBscCgpXtqh7JI7DgLwpnuEUiY6FsdJCs?=
 =?us-ascii?Q?ukhQ8hDXT+4JA6IH965oI4AtSu3xZninXCK4T9LBIfUZGbraB6uxe6LiZbaq?=
 =?us-ascii?Q?edDbynjWp7llUgik4ZGPc3eDtjzZ4dawLwYCw4OMFd5Wqj9H45TT1oFXRUlA?=
 =?us-ascii?Q?sPY2wseG/4QO4GBi44gBvjy0cDDtKwD4MkNJfhmmcafalXbBajyQq09yrA07?=
 =?us-ascii?Q?Bm4eVFQ72W4H7xOrAJ7I6fTZFoIpllMh1CT3aUJnRa3ktOtF+lT8vZV00+2y?=
 =?us-ascii?Q?/H/c7XeDZLQEeB9mOWmi1sRajujtFbwvvfOz5zGBscwlQaBXWKaFxbbCXq1j?=
 =?us-ascii?Q?JtiDCuWI5yP92xOZm7r8qd7XaKsvEcDBxwkme1M6LC7oLYWxPp67u/9o/Xjs?=
 =?us-ascii?Q?+c7yy5lC+y4K8AmSIt+OeW9KOrJcyzejAtllDFYHPLkY/dv8kQYm+Opz6iJy?=
 =?us-ascii?Q?aAWM40ZW5dqvUqlUSzObbdjqSDXoG67U1+Mv6p2DJx58Krn2EsXjGapF4MdH?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: OaygzQrwrOQNligt2ezq1xzPXIU9mjlcuM+UiIKijuiWfh7aorBxXcyYPtUiZp02jB0M+wNFfpgYktzOHPBqp7lpt/0Nmdm3P2jCSsu9jlXgFiJQMwV0E5V+SW4P6Ibu8ZRRi3lFHSvkTdqPS6Ke4YhEaTWr6da3lSRJ8CXdFhh7b8MqLH7ppvH4PQrknO1N
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;6:ZZXQAMw6TlNxUZDsfWfTn9QJFK3Dgt/Tfcq2GW7LqKuiNtGN1tGnH9x1mZqzTWKIoygRvMvMBC9vHXmMOb2i09j3gcwu43Jn2GrL130VXrbK9M+IZMjNAiqr1g1btB6ASyypubGQ6rQ4qglRpAogCW0LEUo5rQUJEJdVQZcKb0ayXOryqJJFx7wJE4tN/xCKam/Q7/1oMB/wYXV5Mpa/dOEo88EYb6uf+0llBumOUk9OZbQYdv6oJ2C8f8BYdMGxEDW2sH6T9FUjnfUP3rwNINJwYt4bqR/rm4GmnKS0NyqFmUONuxsyOLe0DBaiUMzZJTlPchQlp1HERFvgSdhdfYTXFw2R0xaQv0tpxDBgOam4fZ5/DKwlzep3RG7ujXiyZb+t289VZs7rbAQaF+bT+FkkSJhSmrKqcO0k5+84DTTr4DSNNcGxHJeniGok+FQzCxtvRnSLmZqxbRupaki1cQ==;5:8lI/Kn4oLiKbKRQsVxO6kA+pyc9UegkjnptTgq/a++6cq8NnzqA9SnM8uiAybJEIJg0OVRGQbN+MDcaZ5PQQZgbnl0YhAc/R4tADr6siRNQdMTc7wHF7wmunwkjSabqCcvB7aH0kFLM6odLrx9vOtxjzEtkDCVEaQw0oR0fquG8=;24:YOxNXX4YkbmugXdoqMyqlHwJZUsPrC1JuewIBRGzmaqWUKxgMAVDCFTyU0gBxLFTcPFz49NOtPT8w4zj0CZXbyuWCOZfNQWZqFrt+HtyW0w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1370;7:mDuWDFATIaSL6X5G7KR3F/eRTf9pm3jUebk4/9luJaXLoQ92p9k96hBfeNbxNB3O3A19SFqT+ZomATI5yamZdrHkWX5dNkj+VSpoH87hMo1uET5bmF/gCj7xHkmv5PinbdmSpp/bCJLNRw9kW4WxmSai49UHTb84qFcnp1w4SbO3q2H2T5HfJObf8UIE0nrMZ+KCJUn3v/oJ2eK5lrz2TikU8aTipPpr32IcGUk87KBEeraZ3XEiF1bnGWjZPA9H;20:pn7BXZSaXflAIIJp7avIEioUIsW9owGNQ0T+AGR2Gyu0eI7CCNmQ3mR++89fIM4Gljsx25W79SQZMCA5apYUcGqMCg2WP2SR8M1sS5NmYYW7uIZ591h766GZ7sqXWbvEY9R9ot31Ch5bAEetJlJuf3+0bc91xw2GwgMbaKBUCK/fPwZfKPktpf6YLxca1Xw9ui5+dQ6g3KCH8AWb7pb2tlxq2Lv0j03sVYzZFtnWij7h0PP002JzF18KFyjXec0C
X-MS-Office365-Filtering-Correlation-Id: 886730b5-2d7d-479a-afa8-08d5b06eea93
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 20:54:35.8681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 886730b5-2d7d-479a-afa8-08d5b06eea93
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1370
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
