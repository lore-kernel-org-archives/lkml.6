Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966372AbeE2S5z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:57:55 -0400
Received: from mail-sn1nam01on0079.outbound.protection.outlook.com ([104.47.32.79]:43136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965571AbeE2S5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:57:46 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Vishal Sagar <vishal.sagar@xilinx.com>
To: <hyun.kwon@xilinx.com>, <laurent.pinchart@ideasonboard.com>,
        <michal.simek@xilinx.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <sakari.ailus@linux.intel.com>, <hans.verkuil@cisco.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <dineshk@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vishal Sagar <vishal.sagar@xilinx.com>
Subject: [PATCH 0/2] Add support for Xilinx CSI2 Receiver Subsystem
Date: Wed, 30 May 2018 00:24:42 +0530
Message-ID: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(305945005)(186003)(81166006)(106002)(478600001)(44832011)(126002)(48376002)(486006)(81156014)(54906003)(8936002)(6666003)(50466002)(47776003)(110136005)(8746002)(36756003)(4326008)(2906002)(59450400001)(8676002)(2201001)(26005)(7416002)(9786002)(356003)(5890100001)(336012)(50226002)(7696005)(63266004)(36386004)(476003)(51416003)(107886003)(426003)(86362001)(106466001)(77096007)(316002)(5660300001)(2616005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2101;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT008;1:AmPtrN+HGuVQ6IgXOJhnHOdcbMDKyVpdnaxJchRiPeLXYEVV55CMaU5mUTrv5JL5LlcfiUHKBTGR5sybAfG9Iix0I729LNhzciRdQcdun46VJLvVEB+yS/W2amYurMh+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR02MB2101;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2101;3:Ct3ho06AG59jlow+g+hdjHZE8s70odsTx21GKZpIoRO+tV0mKzrgyWxYbqaLumb5te5uZ1EyQLq5aKhPp3lXOHt6DS+ir/u+KjBq4+rSJkZZFYu9W5++8zsuCipFMi6mNdX74u/Rdxji3ydJJiwHvX2sZO7mbGahkQ4E6H7fix+1lXMqLkmsyvonRxZh0EWvCrUqXXi1nWt+Guhx3ru6JcEXjjnS4DLZr+QDaG5XiUOl7EDSJNkax1dnB6VcJ2dgAvE3c39xB5tPswaj+8XqG2xX3G1/Y/Hl/YUceYtkAkdKM1cmpyW3a85L4vMCR4zA3zQEvF8W/gegIvdjXmYARr1Hn4zlR57+Y/T9SPX62HA=;25:nNthtle8FbmrBLoisb6m1tJwlgoRV0ZlE1Dgg8D3vV1g9koAAbBkmMrNb7XgVY/V12p3L5Bs8riLEgvT4CFxkBFheCwiJmwcgTtqVQahOBiajXJ6FVfye5Sfw+2wAe8a5vrdBl8OxYShKkWBxwVPSyV1GZcfDrIwvBL6qdhEzu1WulCZTNlh9nQ2yjgYc1sJMtrcSd2jqG/dV++eQiKD+/bFrncb6Khibci3SMOkUsVukCPJ6SjASqvM0Rv2nsbmoSLv0kWMMkSSQ+9Rm4plvS3MfzKi1ivu8TUFd4vXlrvIBP1vAyIKSWqmTsnOOt3jJ+7Uifd1ioWgdV/9o7JIjw==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2101:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2101;31:D13Gp0KEQC9f35c3LqKPJGOH5XPXx1tP9ZkzL6hqel7cAwxOKhFImPp8lCA/jfU1HT0uMs0wZJXpBmSA9TVZbHBdGc+ZvviOYUzbz83+s/nzmo7l4e8j2bkNmk8tOe+E1KayZsvuYTG3qdXCNVCkPIJzuZZDkmsyHkfDIGG/PQ3C2T9bB2GkkKJvc4sYi5xBDpPu9bPKJ6aPGcy1vAuDesTbVKE9SHmF6Co0OlRn4zQ=;20:ZCahXiaibPMN3Lodxc1kKrJIGyCVo1icCZ6rbbnjvsjtdzso3sdFOVE/VnX8Fiy1+64bCwXGtxvCmT34O+I6vN0lcwAdmzdnEZ6fqmYWefSds7TF3JAYfUAwcY0pyRFLL+jKGH9+5BmK8pMiM0biOCMDiLF9Jj684oqMazkwT7UcMWHglQGT94VKpt9K2pkPm3jEA3kGdMnxwTjYxJToQcL+LUraDZBsiiwbQIn+AZwhmuiC9EG4IThRQ+eUF/p86cMkV8iPTz2tr1YvV/Q/QrqYeNGlQAn0JNyNAnDchNHvGTeysEvYKKCtUQIWic3Ja1tNDkpaTwEMWEJDR4OWpanwG1vRruD44ikBceQVhOjDbZZYdtFHhvQdcurxq3FoV/jxMjlcwAsQtDq34ILDol/Wc8bs0GoFQMD1b7ObSDiA1QeV0xQUrlM+IhirHHVKm7HqimUObX2w7LqTNSWImODOWbvEM2phGdraS0ck46kO0LwCD8dPpw0LR63vjiPY
X-Microsoft-Antispam-PRVS: <BY2PR02MB210189154FA5DAECB4010025F66D0@BY2PR02MB2101.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB2101;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2101;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2101;4:PXYtELnqCKm+0bI3xJqoKcegZKaxAiGPLNgNZ7y8LBwcKSuVNISI1BumBU/kZkdQI8qxVWUOR9m/ito2qPr4dbg9M4tx4VxHXhn9xoED1SJWycu3g6v0R4Lip2jGeNp88hNTKDejsghA3w9/LL3oTDd0x3LzdoTJvNf01lA8LBY7zSUewN0IXXcpeAvpf7xmM5UCaBnEkcVRpMjykJnDlsCsaX2FrnffvbmIwHRJJMSlY4+xxM0EurkONXUMs/Bs178oLppTMlx2L8hmNqrVtg==
X-Forefront-PRVS: 0687389FB0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2101;23:bFPODu8ttBq04qlGPYXZ3zRLQC5WKNKoegvI5Js6R?=
 =?us-ascii?Q?vFFayl2kicdVGD476WQ9yPw74EC3Qzs/ogK1O3E7nOFj+1GEXYgtCVf672Sa?=
 =?us-ascii?Q?wnaPQXqQhqJ1zFowWXorJTeK9DMG404BRkciiI5TTm53V6xm82XzEHWES1x5?=
 =?us-ascii?Q?WIMN2A9JyegA8CSJqxKRzoKQtiSeM3Rz6VuEYF+rDLRW13GuDeED5M/Dz4Wk?=
 =?us-ascii?Q?L71cmdgkGeVBQ7AoHO8HEPMRVKezDmNpLACCEgJdcpCiE72CC7c/gSTIvc4M?=
 =?us-ascii?Q?40O2lUiyxubMw3UmVMhVZNTT8Mnkp0rFjtqtjLnw6NhFap/TSxOsLSYVx0hd?=
 =?us-ascii?Q?inJzcSYWDED4USLCMG/N2qWlD3J8BTWqlb1GZvCvH8+7++X/kaL+uVeEz5vl?=
 =?us-ascii?Q?s+Wy1JF3Z7RSnL12ZncccN/7gjIJANzj9O8AC5OjsLAlZWouB9QiQcTyoJz7?=
 =?us-ascii?Q?TlnnMGeUB+7oxa6rBQEoqxUuKvUyoBwtqsll2ZjzKB66hD/SqwEEOr+X6i4t?=
 =?us-ascii?Q?vUWmyYaK/94rSUzwJOijEivJVII+0blXUYcNCea+2QKQInbMdtzqJVqipV9c?=
 =?us-ascii?Q?ogBPpheHumzqHQC5/v5HMAdSEakulEAsr4kJ1B7uKI6ZRluOUPpDNR1yc8aT?=
 =?us-ascii?Q?t5YrEuV2NXSgNsGCF85ohRDVWsDNO5TZVOOBdKTzQX+iOWLUWk9dp6LMUeFX?=
 =?us-ascii?Q?Qii4D8yS6H/fcL9E0+Fwz/enfRHkVHuWnA3XYBqPoc1kjrb67lBho6G5adpz?=
 =?us-ascii?Q?VRYAKKpv9mQXiA1z0iwcFDhz0vNgj6iryGhMD9kv6Xn0iavuv4NgY8ZR+QZK?=
 =?us-ascii?Q?YgAr6ppjj1Zjz3+3C57yTmpz1est9RrIOydcHYKNiqasN8OmzVQ67F6zSxSy?=
 =?us-ascii?Q?NUazhFqGj0OwGrWUyNySWW5QFwOIKVW71F+MdAoQzafQ8ZCq94oSS151YyxU?=
 =?us-ascii?Q?culoNQ8uCPIK/tN4v3F6i0veVFK4bMZ3pfT3PpHu/WYCVKkhjMqtscCVSYI+?=
 =?us-ascii?Q?UejNR5m95rgFvmw4n/+JfnoCuhunfu9hC3K66+rJT3NjlTcE9TF7/MZqjBFx?=
 =?us-ascii?Q?BnOTM1nH3GajB/gWKTCzwaw0Dk5M9L3h1eoDT8Fii2HYedeAXhpxW+ya49ha?=
 =?us-ascii?Q?VqUF4LIzP1AeTkvnG17TABhy14f0gzFr6QQumPSvhGU8HM6KFybvJb9vzAT+?=
 =?us-ascii?Q?ruiExjUqJeBvPA=3D?=
X-Microsoft-Antispam-Message-Info: zhLcufs3rhJUhX1Yd9JD5ZHUQ4aBMXsfe6GGu1ntlynRA8LR/VvNXnxBCdnGb/nrpRE/VG3Hwxri/UCRhX9v6QuNAzj2Tdttb9uRepY4JeCJWnriGATyujK9ko4kL47LEV5Q4QurKGyqN/IyDf20ItbnjVfssHD5j1RLIgNYK0HnT9FdnWZVMZVarnxLy90g
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2101;6:HbUurl/OI10qN/OEjiFBgBbegDeJLb8KFaH7/0WIDJXY06KjFhCk5x2go4rDWb4RnsH+Kb0uX0SfYZ9OAm30Dhk48iUYA+yVQ6Xh+OAkPB5m7VV7uzsL20T8t3/J3xsZZmXciC7tAzMUB5zM8Mn2rF4xt38jt44mkacXxZVlsvbNfZt+m8DGvJkqdvPWFxiH7Z2JRRgPaeUbQYnbG3FhSg8LUfHtZVXnbRqS+2zT20Dx9hbAxqJRsyQT8L1IZ1T1IcUyekVGfs7Kq5XXixtZrMtr19r16oFaL8D+68PeksN9CLORUNw+Ye0FAUdC0GQs/Z8Q4leKpbVmFg3hn5hQQzRlSu/KLn8x7Q6WVLJTpN/Oi9O37b9gP9NXzOC4CFDr/qrpBXUjKSX0dzNbdLZfQMM5ptseVXeZ/RDrucyUgvDQmHVSSMNobJe+wwEaY1N4PrvnsENcZNmSa0F/iWPkyA==;5:QN8oplJVQ0xMGJ1BLXgYpmcOftctZn2Fz1sx7YFElwYyP3COPVJluW/3UrSyitV+vU3jHMI+y/9VWYM/2sdzGxJq1Kk+/nwFsgdZPBmZuLc4ej/CvrxbrRwYBMbv337K3Ukwc7C6kMGOH3Que+RMqiCzBPFwegCXjc6c+rwIsKc=;24:vs+3J9cbOD4PKnRX+37khfiF+XV+aXHF/gaI5jcrZAlyDiKkuOlG/fLfe08+DenOtVxCtXdfmg6RS9YNZfRR+QM+cL3RGAF8uj50lZkFWDI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2101;7:2Ddse2dw1Z2VGELjZvsSMPGkwuQFeCEJeWG9bCmuKbW3tP4pr2H5JqXEXhnnBHYbhrGHC4BAKH/HX8KliOIKzfIQZeKdKl6ezj8O+wewONbxzatCizdbQJoAborRdPhCOZ/Gy2MVPdn0KR0jj6i6Xnw2lXYCPoDqdjdv7z6ZWpP1injI99yuzhVPR0dWF68Ela/MN9nHeaogJBXzePO8Vfo5T1VkmLC1eMiesPaMmw+6iurxFNU/nKBpf54L2705
X-MS-Office365-Filtering-Correlation-Id: 795775c3-99a1-4b52-e48c-08d5c5960e26
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 18:57:41.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795775c3-99a1-4b52-e48c-08d5c5960e26
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TIwFbU016391

Xilinx MIPI CSI-2 Receiver Subsystem
------------------------------------

The Xilinx MIPI CSI-2 Receiver Subsystem Soft IP consists of a DPHY which
gets the data, an optional I2C, a CSI-2 Receiver which parses the data and
converts it into AXIS data.
This stream output maybe connected to a Xilinx Video Format Bridge.
The maximum number of lanes supported is fixed in the design.
The number of active lanes can be programmed.
For e.g. the design may set maximum lanes as 4 but if the camera sensor has
only 1 lane then the active lanes shall be set as 1.

The pixel format set in design acts as a filter allowing only the selected
data type or RAW8 data packets. The D-PHY register access can be gated in
the design. The base address of the DPHY depends on whether the internal
Xilinx I2C controller is enabled or not in design.

The device driver registers the MIPI CSI2 Rx Subsystem as a V4L2 sub device
having 2 pads. The sink pad is connected to the MIPI camera sensor and
output pad is connected to the video node.
Refer to xlnx,csi2rxss.txt for device tree node details.

This driver helps configure the number of active lanes to be set, setting
and handling interrupts and IP core enable. It logs the number of events
occurring according to their type between streaming ON and OFF.
It generates a v4l2 event for each short packet data received.
The application can then dequeue this event and get the requisite data
from the event structure.

It adds new V4L2 controls which are used to get the event counter values
and reset the subsystem.

The Xilinx CSI-2 Rx Subsystem outputs an AXI4 Stream data which can be
used for image processing. This data follows the video formats mentioned
in Xilinx UG934 when the Video Format Bridge and pixels per clock design
inputs are set. When the VFB is deselected then the video data width will
either be 32 or 64 bits.

Vishal Sagar (2):
  media: dt-bindings: media: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem
  media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem driver

 .../bindings/media/xilinx/xlnx,csi2rxss.txt        |  117 ++
 drivers/media/platform/xilinx/Kconfig              |   12 +
 drivers/media/platform/xilinx/Makefile             |    1 +
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    | 1751 ++++++++++++++++++++
 include/uapi/linux/xilinx-csi2rxss.h               |   25 +
 include/uapi/linux/xilinx-v4l2-controls.h          |   14 +
 6 files changed, 1920 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
 create mode 100644 drivers/media/platform/xilinx/xilinx-csi2rxss.c
 create mode 100644 include/uapi/linux/xilinx-csi2rxss.h

--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
