Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x225Mi4WPoC3i0zk0K8Ld6qx03ZPurSIRPH9C+LaoSQ7ptgXNOURA6rWtDV8XqD7yHYY84Oax
ARC-Seal: i=1; a=rsa-sha256; t=1519154483; cv=none;
        d=google.com; s=arc-20160816;
        b=uSpzj1bI6DUJs17qiXOJg0iTqKFdL1XM0Bo4yb+nBSWRinpUiHToOGivHYnK3crQc7
         T2cifYmQ2l0v5wsFP0ZhEQu+WzvJ/lz93W39Je+2ko28tGwQ0/H2p7yXoGSA4Ez0cZwb
         eRm5klQ+xWWC8jQb4SDoXGCjNLi1Zshe7q5MpZLNSaC9Ay8CvxDe9w5U80FQHuEMntEx
         TatZNVs6SVhV0h4bpaRWybf601EoJjKgMWZ4jWfFITyeDfllttBsza6ZJdMwGOBjiRuU
         MUZWtuT+cvR9hmOYZMAlf+Xz7KutjVDALYirOwGHoG65UY/fS/mt1LFlMFy4z2qCpMy5
         huSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9Tj3mfAGlWlD3ATWIoow8xXHFFAKn6vcqJrP6n3uu5s=;
        b=s9w+f39FjBM0vGX31VnEp0Ja2OCUuFQ04C+om+MM5f/rUa64ZjFskgR0yfjWlxHrBS
         5kWYSQMmvTvQV26Gdrce1U1OVUa1Qs+ypLgUq74HMRfDJL1LC2GR180DbsbRTHOfNASu
         sfdEAEoXoWuEOT2XLwJat+12cb6AL3l17GL/pd9aTsD5d9gbgIwOfyD9G2JnpL10lT0k
         r5vQ2T1cd/jY0JNmbdpEdGdl3l9NsdEbhlThJJt8b+fxB1/ncD0H5Dxo2ofj1MLZ2uOu
         OVYuQptYgnemnW4CF0U0ozmwycX4nUsGnMAjxxMogyEoeOmFSujetKNLRg0Rfo+9Iol5
         JgFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=bk8SsyBR;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.75 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=bk8SsyBR;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.32.75 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
	<gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
	<sudeep.holla@arm.com>, <hkallweit1@gmail.com>, <keescook@chromium.org>,
	<dmitry.torokhov@gmail.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Jolly Shah
	<jollys@xilinx.com>
Subject: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date: Tue, 20 Feb 2018 11:21:04 -0800
Message-ID: <1519154467-2896-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(26005)(36386004)(81166006)(107886003)(81156014)(2906002)(186003)(8936002)(63266004)(36756003)(316002)(72206003)(305945005)(9786002)(50226002)(7696005)(8676002)(356003)(76176011)(7416002)(51416003)(478600001)(336011)(77096007)(2201001)(47776003)(39060400002)(4326008)(106466001)(5660300001)(110136005)(2950100002)(16586007)(50466002)(6666003)(106002)(48376002)(54906003)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1332;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT045;1:mOnXeNDJI0vKz1vbZakdEiFSh59A1KTX/ZhA5YVbKbesi4cevhqeQhg8l8qCOHATGOy/TtV/h/CDdgRmOJygsazyqHxaxaSEsU3F9KtZlg3CJvNZZgVrwgbgwYBglc8j
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d60bc09-373e-4a4d-4638-08d578971f55
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060);SRVR:BY2PR02MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;3:ZqfUfjUosDSdOYFXMZyYDAZz7zi4dy3/JeoTz3/LbhAYwEpRLV87QjB4LvPE3V6xpPLRPf94G2CFX6vfV2W1ENPX83kGdEveqxouKoSurqxMTZNL/hBcsdsREsMCNFlNPwYb6SPJoDlX4F71PsZ7CIcvXpViosDpyhBJgia/060pI1JBz9cdMMzN7unH2hKk+S3dI/62ZqHq9u14lO6UEUFFBP+DMmrw/RcwJm7/TdaNQipfrKUuBFssnAtL51YIJ6iNWzl71Z/+4kgbspQZcwatEeZMO8NS5Ct6AEVDjusixPXc/iNVJ5c5dVabUUkH7dlHL1KNnYbqAby2s5YtT+HmhnkbEZY1yaqAkPOEtj8=;25:O/1fnZORKkY8KIJ479c5Cm/NaaC88DCSHKa+gSZmztplyjSvRFGGkvFBWrlNFy5hWCFiKZT543dKi3tzl//IdFLuvqX3/oEt5qOy0qi6GrU8Yck7s7zNpFc41HpRSQXOWUQcjbdqNi6l5gVKFv77uzLhkCUt262zODf1icItX5my1ROtnuqzKAGh7OwEPrBmC4x2YHUhT4Bf4ymERRsotmRJBxOuMUc9hCvLYJFxvhzcWg1z7+xKAVugGfDm0j8PBVFkaG3IekMxXQbVjQS24bA7OZj9cbYH2gYFJIn2167S1N2wfBMg7oJujnM6hEY/jjhT23eBVvpmuo7ngc6X6g==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1332:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;31:lkk1p/GPVxgHZ83l1RcCJ9iwVBdc0j8PWB7YtfKT8q0EbkCQh175QHMxMiKk5d8kNh8cV5Pxb0zYSPCQNYaZMkjwwPzQFRseFIA75RBPqx8I3unGbAGWiYUMU8qg/8EY1RlG4+Q1ej4VdktBrZ+hUlM5xZVxolmKpvvOknrWOvFz/gF4gS977gSzOmZxb+c+aMBO3KU3Iwk4BQiIgx7tecMF8AgPL99LWh2nnkGTDEs=;20:3EbtGVeBdQMOGudcfCtQdygQJHw+/tABozWG96ZFyAStXGLfELlKVeHx7GMHD3wfAmkET28o3fRlypv2R3URJ0oMIkiu0sMQsbESwXmv+5Qur3AOgjmcDQoP02CRLmSfvi77qqCV+eje4u+qSnnt08JhFj+m4oVc85sH0XjxmJeTDKSyXh6LcKb+Vl8xj/I43NHBZT5PELNCp1IwefNtUXovR4XHiL3UfhBS5DZ9sWj1ET17yQZJjweoh1HKp8Ho1sYM4PoyciaJhnBVyEsz6++LF2rAn/rHDAK7C1rQFHgWHPkEnhv0Dmn9OvvNwb6WGiO2W63u4VtIhu+eKJOBPFMqY5cV1gEImMBa4JVQSckBpZpnMJ98EFFFL+O6NgViOTgKkZBNfcxL9UjjKPAjf0lZ/7knNot012MtcWcDPSzls8PdT59RbsNadJMvg82Wb0N0Y32f9mGA1XlUhRYjwlKdDy47UL2Q8w9RmuVJ4VNiD64dTPa0aCFtFXxWnnfs
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1332DCDFC9CE4DFD0BB42590B8CF0@BY2PR02MB1332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001058)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR02MB1332;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;4:R+kyIYyqNLyT56HlAfLKXatJa5BvD0K7q6i1HRCGuIVd+uXItcNJ5EWIr+IMMP+eVA0CAlBc/HG37SwQghSCVjyfnauxM2dV148MIX1pqHLXLTWOd+astqxgYNLVh9lGmdoDzYz6/gxMjYKNsMoy34e4ehnqFtEjgGD1Cv3pwcihHfnPqcoVzfVvLfRS2PcpTjmxH1l2tVVuBnzP+DuzmHWNUY/0WwzVSMeETk+bGoLcPliWvL66alHnTEswMMDTXVBzE3zz6SWrbCQ9dljxpmlA32SRNTxGoMGR+xBH50xuh4+yS0owqAxUVXexTEtW
X-Forefront-PRVS: 05891FB07F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1332;23:mzYuNYEqA4Rwy6ZacKDL/j0DF8ljEj9M6mQZ/Qe7u?=
 =?us-ascii?Q?IWZx5ktqq+qZJIFOsO4VRJuKaSEOs0D3ZyHdi9R3Xexc3UogGQIcLKz/0cdC?=
 =?us-ascii?Q?ow01+BxlZodyY3wHgblH2jYlLhiDzKgcoHjYEfS2EOSH9yTXd9/ZGqc+cfXw?=
 =?us-ascii?Q?5h/26T5K24zTBf2gJjlYAxhAcPbsdurOOJJsyeWn11hOp6LyaIa2OSSqfZ/H?=
 =?us-ascii?Q?uYqAGEm4lKiu0J3CsUx1ybIPyH3brCZ1ELYzl7kaIBFm9OzbH1SfC+lKj2h3?=
 =?us-ascii?Q?Lye5rRxrjxglBi2/5ONtQwOfzME7Wc3NvxzS0ttkngQPGSsJxQUyeLo5fp9T?=
 =?us-ascii?Q?siGS9mYdD1eCqY8NEukz4KaNgBK2Q1/xHWe+ZLkk306yaWlF2XC5DG47/H3x?=
 =?us-ascii?Q?i7qPZm5lr4fprRHqTX1BnovZUTwkl38z6vkk614LXC1r6MOOFiQj2usG9LV2?=
 =?us-ascii?Q?sAmtYDfpU/TfKx224ObKMfio7EgTVHB+3ltZiNC0cI8dRpTIiN1AZLs2CLUp?=
 =?us-ascii?Q?dKwnGPqCvvssniTIiErO8AAV7qQUNycUi/Vga3QeupL5GgFtZN1Sw0q/WDkJ?=
 =?us-ascii?Q?4l7ZG5BkQXPkCmyyuMZ/1dH7kulW5HYJXq6mfDFCR/tbJeSZGGd5Tug9eFtI?=
 =?us-ascii?Q?JGl+YMNbUU6Dsg7PXWes0BlR0u6l65wvahx0r/0wS3DnkTFPD7tfQV/B9TWE?=
 =?us-ascii?Q?1NP7W/pjmqrZmrrEaR5ryq/bhnx1gekRgE50sHQ3mJJkhDnJ/+YqovfwfOm+?=
 =?us-ascii?Q?MolQ293vEQxwn6bELdlnUA/KBM5ECCqbgvH7b/bylejTkAGWBu+FcNhaIhmr?=
 =?us-ascii?Q?7WWoDSy5K+dzLF4Ybckc0dkWLXb6lrqNAqiP/3Tjdhg1gIvVIRDFeOPwFjLQ?=
 =?us-ascii?Q?i0DkF19a/N+Db4oZyYmT/fFTYyrpRVW4mVii9zls83mMUiFiu9f7+JKvkpFu?=
 =?us-ascii?Q?vX93oa0DOH4fKODomQma9t5HqluExHprRMbJBUfXKi+BeCotFbmB/5+9ZNef?=
 =?us-ascii?Q?SHeX+mxfvioaiSZ3CGTlDW6II5hOzsnQOKoVzbQ2LxKIsarmLHPh3Iig2qUj?=
 =?us-ascii?Q?hdih7On/t01yCFVpXlTv9q3ebtotpubZzIEbtmH2jMT8X/FncVKTIdwCK9+t?=
 =?us-ascii?Q?0+F2nXombwmBHS1ODrdikOYoITFLsunxZIndPchMwqfmly17sDaTH1TzpqVW?=
 =?us-ascii?Q?JNR6n9TlTtyybI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1332;6:9MkkulIfnjjav9zEzlWEg6QN/TYqrNzRXrM+W3g3V29f86aVEqTfcspx4N5QMrqwD787w9wtTlS3pGXxuxHOYOmmB80RsZNfufpe4sZjQWJUNG1yaSqU8ttIlKAiW/vCqSeutBD5Ds08uhn5Na+bL54ebaaqG4iTcI76G9cKE1DSkRDZi0mDuqFGODhjbaSW2GCLdgs28XOmELFVLaPSv3lEHmCy4E3rI4lTIjHoAevSzyZbU18X/KUbFIqNcbvbVxay53mdaHK9UexsNLE9DI+k4BOcPtJIw7dTAp9Mh6Pk6v6hWct/G6qRBvjY2/2A7P8NtQVdY6P5zuiJqaiOYqUjyRDd3lsRbC/9zjddcQk=;5:NrU3KcWbOaYmvFM/K+QHz814ezydHx+X4S5NgHy+ZrToTPZFTWQ2eo4lvzhuHTR2dHbset9Hhb5Mh+Wf6E0AeucfrL07/6KU0Jp+viWfL4cG2wJRuxv74hz8XnUPnnsLEo6WCHEPlhCJCPiFEkVf3L0x4P4X/EkaYGI9Xjp7hY4=;24:s/gWlSP8CmeU6wWdOoQjsgaJczPo+TenGGKExJW+5j4288IgKuyO9soKcjDLQEweWjdcBunBFiVGWCnRNbLHlkuI5QxStknXqzYRtJ+fsQY=;7:o60lSa6njC6inCi4l/f/EyM3mgjWkN0F+Co9T8HPpXVdgnmu4v+aIn1naM4HWfHsg34kKmemR51g054vHxVkX7T4zqTNpRCQVv9d7xozWF1r02Mwks84AtA/6sp+kFAMeG5YD1y7DkhjEeSuba2CP6j7BYeS9Xn3bKs02/NUKB7PQOClocn7Q+t3IaQ1I2wfogVMGFzwk3NW21fPJNQhZOZBomoXH8aP2gbRaiC9r6eXhjNrftFNS+i4ivHxVt6r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 19:21:20.1995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d60bc09-373e-4a4d-4638-08d578971f55
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1592948931841332945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..99434ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,24 @@
+Xilinx Zynq MPSoC Firmware Device Tree Bindings
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:  "xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+Examples:
+	firmware {
+		zynqmp_firmware: zynqmp-firmware {
+			compatible = "xlnx,zynqmp-firmware";
+			method = "smc";
+		};
+	};
-- 
2.7.4
