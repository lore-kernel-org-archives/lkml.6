Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968346AbeEYUYF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:24:05 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:55968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968304AbeEYUX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:23:59 -0400
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
Subject: [PATCHv2 2/2] crypto: ccp: Add GET_ID SEV command
Date: Fri, 25 May 2018 15:23:30 -0500
Message-Id: <00cb51b73bb427d9df36bcbb17ed85c1802d98c6.1527274270.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
References: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0019.namprd08.prod.outlook.com
 (2603:10b6:803:29::29) To CY4PR12MB1368.namprd12.prod.outlook.com
 (2603:10b6:903:41::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1368;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;3:zo0wNkmgpxEPabZLkNI5cZGWzGxGZrNzuWLGO3TxUPCPtdOx6zdml40k9rMIDnODgX4lDhYiZiOSSYgmgkwemtOjmqEukP9q18Sp0/iBdMCMASl/YzXmE63VhS4FRW72dBD+2Wx0tbTCNsdM43HyjW6+rerB4ui+HP4sXzyzAEsDCvlj5Kg+Ua1Mc3Bs5ogzKhbD9LufVF7zieezMGqbKqKsAfxVx3Vyoo/rDxz9JS4k9hMry7WlNUS4/atwvvnW;25:SzRSNcK4DtV0SRqxNC9w2AgBBtgT0mLtBRIKZ0mQdjXOfQlHwg7on1+NR1USKDbx5bbpDJIdex5VlK0r9gEK1kJEmW6QGZJHiD6zhief/imyXT2BnfY9en+z/L2smK8IjC/Q2BBAQlW74zIdNvEgrV+gggq40tRhvTNbmcJ3CHKAHDYtf5Jwh281nfxRc9Y6bx6TUZJOjuTXsG5N8zGnE1anDRBP79npascM65JHZdxN/WD7qtfJ+HMG7mR3l6Gt4HGY7skp3iaDeoZi/vD8yeSjldxO0P7/vTVf6sN/e1KfJAmw3RxmE+YSn+5qL4ecG9tKk4lfUTVpWDLvgTAHPA==;31:ZAjAunSiOANA0+8FLX1lomkqCYKAoLeM96VfRyKH7HhcANLki/81mcLOSronc4MbBkgtsHtV1Smj0lBR21SRbgqFFMgrtKFUeXOAyWnxWR6x4HR55O0PEhwX5PlL7Hs+t5n/GGvIkNHxdhKHKdYFJg124j4VUcwS9n7MLsy+ISfrsA47lb0qTHngG3A44LGUtvRsRM5aYXgCPUoTMDFf/twZ56ou8alP1z41PXVBGP8=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1368:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;20:ZbfbZR+nVM5Nnze8g8cTTx/eS4yiP8khRDoRSbR10+NDEeZjWA2oUFTZr1e5x85w7ED9nARpvqUYcbOcDXmGyhPwnCPFcqpp7lK582HqE7aW+ieOuLR/qQ/fTAve65Kuf2xIj5PvVkUxrYZuV5rXCskf3szVLyR6VIWAiYiLryLapG398l5DoKyVgJaex3n4GQ66Lak5+42+WqdrVUPJJC6o3SFMfWjWkOnESlEDI8RTiIptrhT7zvm3ptQeDzNm+sRuDzmVxePaGjikXY818AxrtemJGzce6jiFdzQZXk6oTYfycp+eJlmWA8Po0vvI9SFCqp6ku55aCqOz5+c4M3pmJNdnV+zmxVrQPXPGOziiMsfm2fh+QyaFJRnB/iMUidtHsA/KBnq4rjSEgddv92eXPVYZlFYECeZuUDTyaRVRxJ88F3HJ7Ir4WYn8GuCT3rM0kAgcfxrfmURda9yIUgeyHnfUe99GPSaRBZfA1KDGygYWb9X63bjqcL3uxS4z;4:42/boFv/K5iNx632f7In221qYfqZfUdFvXSvsgkSJIihmJhXRawuL2zlRfCLD6Hv+q3twuBS6dUA5AgjG79mRLifA/QKvxM5EgooMY3ih/7G69YKw+mW0qV9Q2cDtdqD0RlcVgbOFtLCBdOqfjFPNdY/78AE/5gHl+uBvZGonJrclXIZIc+PtWLUmPs8IbVqhLbJvECcUCldP1ICiKr3uSLV4reua2mFjZpXjiTVRCyQTdMOoxEgw+NyQzkua6kdP7DuV2yHp/WFcarXpsivWqPoSt8P3c/32USTnlc6tGUCaWZFdIKE+aabARt2eUYn
X-Microsoft-Antispam-PRVS: <CY4PR12MB136827F4C9287A2E96BD32AEE7690@CY4PR12MB1368.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1368;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1368;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(189003)(199004)(118296001)(50466002)(59450400001)(72206003)(6666003)(106356001)(68736007)(48376002)(53416004)(966005)(6306002)(2906002)(4326008)(305945005)(25786009)(6486002)(53936002)(3846002)(5660300001)(105586002)(97736004)(478600001)(7736002)(81156014)(8676002)(486006)(36756003)(6116002)(50226002)(81166006)(54906003)(316002)(8936002)(956004)(2616005)(386003)(7696005)(446003)(51416003)(76176011)(66066001)(476003)(47776003)(16526019)(186003)(16586007)(11346002)(86362001)(26005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1368;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR12MB1368;23:FeJJA8tCQ+Gkf19AYfmmkCu8wFO3de57QMMkknLHF?=
 =?us-ascii?Q?1qOvHu7Cz9OGQr0yMpqPeiN+Jcoj7xzvPEpwBFRY6fgBsJ8i3lvc2X9zxrXl?=
 =?us-ascii?Q?qgwPR02/d1H5zorV4go4BSHq6oaH/p/DK3xkAwi5UwwuGg/YSM9tjnJNJYXI?=
 =?us-ascii?Q?wd74kp1TovOcxP3xBKe+UrXuP1dOt0cChAzYGpwWTTTEHJc/t8e4pyydDpyp?=
 =?us-ascii?Q?NlTNJzEj8DBK9ParfKvKV/ymkm+WOhkujRRYlxVmZwMWL3N3EJfxbn0U2S33?=
 =?us-ascii?Q?SkvcoKoDiLsh1FZaGDqfPyUbBDS7jDfA+SK74fxuwSC8H/s+P0fs3SkPu8Bd?=
 =?us-ascii?Q?7TXoSQq9mO+XXfAXT8eWJ6PxHwqfqsdJ5uqnCoOl4onDiuIcGe75K8dKZCm9?=
 =?us-ascii?Q?NdvhyOfNhFMS/X5J6wMbSRseXSLwxiglQTqtSrSatHJfvGxrVxEXElllvqFF?=
 =?us-ascii?Q?45coqVdHLdr0+c6Vfmtv3ZD7A7x0Xe8kTTjcbZ5YcGIHDGkOzNIdxH6NXXgJ?=
 =?us-ascii?Q?RXCbLAiHP486Fb/2E0sCugLmcZ/SaY85edqMnQ3/5PPORB8yKaTlTsVSRQQt?=
 =?us-ascii?Q?wqjrPlnghmFgEtiayXIIOqpg0WdU/pcPYnWdx3Z8FeO6+tRxT/qFr1jXdo/V?=
 =?us-ascii?Q?jr8RQrzvsiNcPVwfrXaACOCxvhKi1Y0ca6YXyl4eLXy+ImEc6eCicYa8eKCx?=
 =?us-ascii?Q?UG/W7BTxkUdCx3cRFu3E/EqqRgYzn3abE7zgYHjTwWlhWrKnL5uO5HMTZUgc?=
 =?us-ascii?Q?iYgSq1e1ElGd4XsMhohXsPzUN6B6h12/evDgk0aDALrjxCSjmzWYChoTCIQB?=
 =?us-ascii?Q?jhCVuYIFQos0YGgTdA7TK6hyDt3CVLJniizTUVutMTwK3/jEjuTuXtZJXASc?=
 =?us-ascii?Q?BSQ6mTOyIz51yXdik/uVXSB9FJnGQlPcc4yBsfY+HjDV6AmGOv8zYrlwX8wb?=
 =?us-ascii?Q?b5eQbmOIEpbLzNhKvug86tUz/Qbli0nDXq4cFEE6ALbsT5zvdsPFQW0eD5Uu?=
 =?us-ascii?Q?9sMdk8AAgBeyGKuIgIjzR+6Ywzdofdz4YmhXUsJrUfww5W4EquMG2jhaJup7?=
 =?us-ascii?Q?nN/4fxAjrINYqLZiVXkEtQ/9Amolg35qFhWNN68q/QCmu1HjWvsbFYlIkjfe?=
 =?us-ascii?Q?hYZZpwdR401InRDdIyxhoaI6YZzPGu7rcCd3Td+OKyqMBFncRwrqCCLk/hvu?=
 =?us-ascii?Q?WfkSNaa0k2nrGXFWcIjIRJH8oLvCf4OKbJ1MOOQThL24Vql4+6lMbCj9x1BI?=
 =?us-ascii?Q?utwQrUCOiiRMwL0ul9hxLiFO0/EQMlDQD2Bejj/Qns7eNoTOjr64HqcQxR2i?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 9RnxVooekFlaMSa7BsnBCd1RrM5lYZqCwRpTCyriZCpeARcdv/1EqrJuY6r74dGlRZW3obXXDSjY9OaZjg2ddCB6f2MK9ZG6JwgankHKSHDtwqqk48Nt7kyqvJZsL0P1F4vw99nM7gwAcujFdd5daND7pP6+Y46lE0DMjq9HBA76P94IVZpZrg3S2SYQFaRl
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;6:Rqg3wAoUMIKxRkMoEiSswxIES20UxCfKHtq0tpJ5GB10s+IafSJ7svsaaSliUwahAt75UTuXAK1OPouMDGlWQqFXHdX8FKr/vTgZbsCHfEcLSpVEHPDaq8Jjg4Nv1rRvrfwZMWPlWSUivM2MlutjGOTrIJdRFsHmLjUCfZhy6G3QhP7ijxmINVFKou/N1KsoMBn0j2LVspriy12tArtFwQltOfRDQFVqEYXhl2EPzz1lNBpDSX6sVWSSVrcr6CWvc0Sjeo6cJ1ET/Jcbab3lwhATfWCFyTtjKKzKD8R3WNN/+YOsa68FgekU7lVaSgj2ZCx+OI5S+bh0g28KEBmRpMsZSz8jAjW5LeTzf2TKz6Ws4dtuGkl5Z+5fHvmfprdyDHa0phVaIlENP8Ygr6LWS20yJCCfaW2yzH5g/sWNSlJbelqdHr6tdJKBqok7cnSapm8h7PlJIiGLBGpA6GIIhA==;5:rD0vQeoMIQfmn0Vyv5e0z3J1bns1rbQe0hbLN7fEP/6XPhnW5QJ+SOfYNPSlfwnD9KSFp1RFTiOydnnKJJMiD/03NTs/vCp1htOhJyxhLHRv4eYL4HAnytG2eVvobOdIL6iFkKOuotMzdcOhqyNpo79n3IdxNpgbE2wyIPok5L0=;24:uK5E1ZpuoReyHqKXToyx95Ti0e0uwUqBcPTcKBbYMRep6a9W/EdQhaF/WOssVIgO8qOvti2sG8x4+c+YU/hsKUu6pUnLcqLAarRaNL8FHdg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;7:GawWWWKy26posl3qeQi5h6Ln5py9vajyxQC+dfYI79G5wHta3vpeUlcdr/fM4+IkD0qyoXxFTyomJ1PaGKvkRheQEpT8V63JvO1vAzDUdpJ4DTLY7BWtaTIq5VISBLW30knVGJAirpgJqKPCHDVGhChKqq04Oaj4wmAAhfTUwn7KPT+rvJ8412XRSA7KgQEh7uhCZEHgTRxpUMIBnewZ9c1v93n/vlyDnor27iGM/KfgaymycReivZit3TCeH5LV;20:UEd9p7YR/1VWDAXB12t0pGV6ojHdzHPLLcOZAPwdeIjdcxKwFeBZeRdDXTokJhmSr06mnwNx5AnDIHhu2C14u9O30oAc/sgnR765wHMTUayatEG9ND5gmShf59Ghs0bzftRoWekFej7qjBnp98rpKlSp+7J/7k+2GVCUSxw3N7TvxRy7we4FWiXNvA+/Tm7V1UaoJuYA3s934agsG0bTQKwVj7O1BLewQVGD04ywPn4+GD7C36duZv+6RTu1Mmvp
X-MS-Office365-Filtering-Correlation-Id: a5d8f227-f65d-4994-f699-08d5c27d7062
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 20:23:54.8933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d8f227-f65d-4994-f699-08d5c27d7062
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
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
index 12838b4..ff478d8 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -119,6 +119,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_RECEIVE_UPDATE_VMSA:	return sizeof(struct sev_data_receive_update_vmsa);
 	case SEV_CMD_LAUNCH_UPDATE_SECRET:	return sizeof(struct sev_data_launch_secret);
 	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
+	case SEV_CMD_GET_ID:			return sizeof(struct sev_data_get_id);
 	default:				return 0;
 	}
 
@@ -510,6 +511,46 @@ static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp)
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
+	if (!SEV_VERSION_GREATER_OR_EQUAL(0, 16))
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
@@ -647,6 +688,9 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
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
