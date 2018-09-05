Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20111C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5252086D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xZmClAFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5252086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeIDLwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:52:32 -0400
Received: from mail-eopbgr690062.outbound.protection.outlook.com ([40.107.69.62]:40047
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeIDLwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyCQgK1DUSrJlIX13A9ABU/aaLpOcIS9ShAaaYX9OnA=;
 b=xZmClAFd2LJmSI/2ZdbkdUq7vuOIUSau3mRzO0+4mvgn1YkGycusPU+kFiCxX33mqI0Yxt7/pOS4XJtQvwFgLbO5AsFb3dUwoWjpUsGZMPFGhc423GhvmJa6AYEVm1AIxM+6G7S7G+Ln6+lSVljktAiqtcRuz8hoLo3q43v7+ck=
Received: from BN6PR02CA0045.namprd02.prod.outlook.com (2603:10b6:404:5f::31)
 by BY2PR02MB507.namprd02.prod.outlook.com (2a01:111:e400:2c39::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Tue, 4 Sep
 2018 07:25:33 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR02CA0045.outlook.office365.com
 (2603:10b6:404:5f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Tue, 4 Sep 2018 07:25:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 07:25:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48196 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5iN-0001RT-8m; Tue, 04 Sep 2018 00:25:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5iI-0008HN-4o; Tue, 04 Sep 2018 00:25:26 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w847PFAK015698;
        Tue, 4 Sep 2018 00:25:16 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5i7-00086x-Cp; Tue, 04 Sep 2018 00:25:15 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <atull@kernel.org>, <mdf@kernel.org>,
        <jollys@xilinx.com>, <sboyd@kernel.org>, <rajanv@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [RFC PATCH v2 3/3] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
Date:   Wed, 5 Sep 2018 12:54:48 +0530
Message-ID: <20180905072448.12488-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905072448.12488-1-nava.manne@xilinx.com>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(2906002)(8676002)(107886003)(478600001)(1076002)(36756003)(7416002)(305945005)(39060400002)(356003)(63266004)(4326008)(5660300001)(8936002)(106466001)(47776003)(50226002)(446003)(48376002)(426003)(486006)(2616005)(126002)(476003)(11346002)(76176011)(7696005)(217873002)(106002)(50466002)(2201001)(575784001)(26005)(16586007)(6666003)(81166006)(81156014)(316002)(336012)(186003)(77096007)(36386004)(110136005)(51416003)(9786002)(921003)(107986001)(83996005)(2101003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB507;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:wJ6KEyDWyea+niu10TyzW9iX2TOkMJd3jS0QT+uDMcacVREg/JQCh2dllOqVrigIVKseUe+iNPFXnv6QZ1BjHpFleCaPiQ+WxsdWAsehRrCQWnPwb+9a/vYHP8BT9+60
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbadf584-b625-4d3b-66c4-08d612379946
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB507;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB507;3:aNiQvYmFvXGd/9efPKEpbVaQp0abF0z5dKNsrXlHaDomj/QjyssITvcNXdDWTMvjEdh9N++L2KglG6JyNswFiPuRr3rVH4fAzUnDulh1QyMfiHe0EF4wAmsFnwtTQkSKs/A+sNhODjssoA4R8rIR7CyBEmzKwtupz6IxV4SINWqneh3GorGUxFxHJYCuzV0MQrYbSsxwQ2rUUjE8eqAYgmtm0ZXahLMPuzYP08aqhYtgdBtG8yI4MEtQS2aQ41xaC2Et5e9gQbWD6oT3N7aYClk1vtBK6FP5SgwwpB3Ioy9MwNXWvg12SkCPDV3ezp/qlYSqYUmsjDpf+Dw6S+kYYgebgVHS3bdwaKzmDbCm2OE=;25:7WUS6lwpK8brLDAtwPKnZPvkDbwPVIRdkBamebymVJAXluuZTdOr8esMqTfKlu1qKUxhtnCuwkO+Y+SflfOYRGnsI5Ce+c/5JkmE4Z0u7+0moWVshhr7zzccIfsRGD01wzApdqK9+CCC2xveW3jV108gUoXaTQ3PI8en/XsoYLqHPEarIB1kN3W+OVv4upudyMmZTUB02tVrT7e/jqouL50qTAvzW8huC+vdkh7QnPgWqzXDcanWVeNt3J9nu+Pv5FGIVeIQJU4GPcZUwzl8lxG/IwDKimV3zsCMIS69wnz9rnkKhzgJxom+aoR/TxaanjCaqKUvz9YJYOlN+1EFXg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB507:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB507;31:91tDc1JHDn6CkA0dz+B4l92BvbQO6S0koK6qF5P5AUcqMzHQVYlxct9bWbfVH/TECx1UC/dXrA3orlRv4YI2pKbWdS2SKhivlIDy4RIgnjV6jrEa+u0nEsDDySHlXWzcaPOiOUcNwklPSELjOSNRr7Bxy9GMhS94I3Ly3JnOf2JniqvNq7JuEOQukk+wc/m6ThtExbU/9+jjn2dam/y3vgn4Nf+6+o3PC0ruwVnMb6s=;20:iefzlvy+GeaSnzNsHVPZ1uYt6RXDYSmpSQjWYMC+eaDPekOjifZBIj/Lm6xOzJxWVKwSD6I96JiVcrFR/aMRQ55Tmgiee+h6DkflJD2eA1J8eIDMxObphprISuN2HxTZ6oQingnSfkLNbBE19cM2bHlqcjOcA+LllKuKHnxw42YLNFVd3iHaDXQv5ovjjfCcd0GH2rx/HvUxToD/ZPMzJLdY7EWnR+wgtpe30EeBAkfHRW1I3KrNIdQE5+4nINxm9BwIndSaKj+rPC6JbJxsE/cxE6G0YnUn0hc4INDRmJzV9Q8id1wwUuNHQKnw8YHooujpSXASutmQj59+maV9iyt4zL3wM7SI1uZBuASgGIdAn9bilfBV4P2uxjTUaV574JkOZ73P2MsZZchf1q6U61HWnBrJk2jAb4e+K/K8wpiqMwzZ8YrL8gap0ZxhUUBrYQRIjb5as+3GqSXAKKZ0Y9sGqbPx5fpZ0r+96XVrLf7aIY+/JSXs8wPJOqighO8C
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB507095BC547B6EA0912EBC7C2030@BY2PR02MB507.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BY2PR02MB507;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB507;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB507;4:NjIVIs8W3+hSGPa9p4yaXiluzZGhFTSXujzluBNHh+vtyq3G8U5j759nWIXEmUUyvYGaQ8HBeMbaFLSHuGYBpRLOp2xKPln2N3rFCAy23rNy79fyR1uv8kVsywXM26lliZZCgqJd6+WkNVeTBIejFkGGql7inUUlbWaxkOXBaolj4x+DfvLIzwsc6z9y/dpbE2xrjcnJBNe8G8VCYhfakVjw9Po54rn7KabrK4Cli3Y5eL7LRT/LbxEcXKBQJGXeo8dPyL+1P6jZRvhXwrbBszcZE1D78yOoptBJsQ/8fce+heIqXY8viwqseB4QesHE
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB507;23:95sryhP0YCu2+V+Rc2/gBVvFjyFOCmXPEEKG5yeLoc?=
 =?us-ascii?Q?1WJuO0VI1RtbLV2XCxct4Uha9hTxABEDh/kcquDJXtZ6VG1+eMCCGDsv1J+x?=
 =?us-ascii?Q?SRvW9PSCCAuURLnyOxUfMfFBk2ElfmLCq8EZG56V44G0kuKNNztSpVz1UtTA?=
 =?us-ascii?Q?4Wz9h9Z7wSRBprZ/yB81FND4J0OKxNgC+X1hgkMjy9lhOsIjBIQt4Wxa+TYQ?=
 =?us-ascii?Q?BuRs7NaWjW97CDXiYukKn+f7m4LixH0QnnovN8uf8aFx0vnTkbuFzv+iP+qG?=
 =?us-ascii?Q?6L3W6nItv5IVWnBKlWYqqB4qpkpohDkLMkhWmk/AWaJBbqTVp2yfMPoGUcnN?=
 =?us-ascii?Q?72MlF3ymwDuyGkCT0oPxBWs1KsK9Sub8PawicpzPhtFd63YCGzFmkm9E2Tp5?=
 =?us-ascii?Q?RIPTqBIVLGSYJBgwCxaAjWIV9man9+C7VxBUEPxrZnYGZQKVsB06zrrHdz4C?=
 =?us-ascii?Q?6VTwmIGE2jigf5+uVcxYxml+HkF1zZU5i4SgjSLfsyJuserbgw9ocl2a0R5C?=
 =?us-ascii?Q?To4y9PuA8c4XqAEu95ibaPOY43wei5Je+dZ6hlAx8fZ7kayiuktESEOaK/Bd?=
 =?us-ascii?Q?O5dC1HUX/4DTv3XtwzjBVDvcps0L9NtMbWDs9A0LmMktX2wXA79ElDS3pY3P?=
 =?us-ascii?Q?CEX1Vs4/gG0UN/9MAAdvBsmdMPZMjL86PMlbr2O+fu+gkLZDQxAImnoFXuMs?=
 =?us-ascii?Q?vx3mF6g6RQ/XH8+TvWhe0xacQkcHpyu4vwX6f/0kJeGv78jolK7H2yQK+ULh?=
 =?us-ascii?Q?ALyHNoTQBLIEB3gGp9oVg4VI4CSDqcHwYaqYxBtBRpwv1jo12bXS1KIknJ8N?=
 =?us-ascii?Q?HTM/UP1skQtJ2Bi9JIVae58n/TJ01F0EXeak2ZIfWo0B/8kOmAHlPKX1EWZy?=
 =?us-ascii?Q?bIFJMzMr2PWLWoU3r87PMxU6C2CTk4bGCyzgAodUOId2kdFMoPQVjioJkpEv?=
 =?us-ascii?Q?jMeXL/PpSgiKK8PUtNdEh9GpnRMTcwtXg6ZRANf3xZAVMmSV1lSXfvRuSrFx?=
 =?us-ascii?Q?RvIY0gbmT4HaN4NsbZwI3JM3431okoth+TBDVoWdxHS+wD2kLIdzJT/Gsslq?=
 =?us-ascii?Q?+eaeMFXG/iJHAVCjf4PpGg8+1NRszC7mBSUmARie7sZOBVh37crMpvV+1Gxq?=
 =?us-ascii?Q?d4o+7g0tM7GAH0rZTz1Z+L6cClLYVlD+zKl8hTfsTd/h7CwW1k92shwnQwWM?=
 =?us-ascii?Q?Zt4165pfgE067PeuDJsyWTMT1XT9QqeG/0uAjz45H88j+/xI807eVnb9Tew1?=
 =?us-ascii?Q?rLJAkZV4ow8hoejob0UQwFEvaocGTjr+U2Qi4nUkkiIWXliijCbU/oSNbzYV?=
 =?us-ascii?Q?IL8EProAYIVySpvOMleH8=3D?=
X-Microsoft-Antispam-Message-Info: QLIUv0ylHCxSmmZGcfxKh+JH1gl0AyR1vSP1ZRnWZrwbtvmvL2wgWaZN7OBvUZeA/dxAqZVrqXxo/CKxunE15hRFGQLjxfC/v4v+1j9M4MAV2cmRaKR5lgZWeKY1rRZ6aNFs1cidpUrWX1kNfY5MhI1q8VCVjK1+Nhpym9OEGD/YvZ0IlUSfsmzx2dGhEV9ov9mw/PFPnOAINmQGRhW8az8gu6KWYDZGC3YPkDAfFxSFPYKFD697uCvOsC5atPxOMYx08iLnOKm5OmmFMcOBmr3zwY7V3dPEwfm+q5RS/lxLbkk8tPyasVeVA8sQEO61ra7Oa2XBL6CPGHwylP+EKzTiabLxti1OXou6NlQEZbQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB507;6:7MvHl2yTu4OBUv96lrw2Cm6jk1aAmbLFu9hbuAjQjKIVi6QHEF6R0YMCIQweOYNbbndSce1rIdHC5voRoG5+EDU7g9BZyes/NYf4eYNZKmUml0fzPZ28x1lA/Tsqt/oG9IYYIhjqR2jckcSFmzX3v+2WZnbURkAGqDOGm6fX/F6ZH0foAhup4Q6EPi7Qu0ZcJnyPwq6wbQf4Xwvrxxf7vOkqWqI+YW0ClMziNUDfOOS1MJQ6PP6DBGAIkSUO7VAlsxx5W35e5FvG2kakDdYNYiUNmRM84jueGhQ4hKmJfy4dVbEEKAA2vCoRft9oE2rXtkRFgehofcnv/1E0bv1wES6YE5HQGhtzX4ZipGDZERwPOnhR885ztVieCbNPPpdy6jI9q0ssyIuctwtxRZ5cpsI0P931le5a69On+9G3EXCImJv0Ta86wuRoSwbWKg4QtFnBA0gytxJBJIeXjYk5/w==;5:M/LoSnZD7Vzf+G+xdDJ1DfPxhIJoWYj8YY7OmMyZRQCmla16ZsnVGuPWlrZRjv8Rl8XbIRvk2eZNHJZrfk8N+MEl7tAWaJ1cbFrMUW9Hjz6haQuLpxcMI/675GSDx3F/Qg68A1w1SbYOE4Js+qIy8eI45VV8xKibs96WhYFeuDg=;7:XVlTWX/FF5f1jXuGIg8pt7L8Sofn860M9bFntw8Nr89DZYwMXPKRLzNaR2bYTvd73BhJsl8523RV3BnOnhiRYSxD1S2ym3KMwADK9fGGWFA7aAoPwNZKZUiTvk4GtQSigCRWyd9HxMzV9wr1iljknIeC95sYebnydcAGDfwFLUTrk81+tty8+tO2b4aJF4VG8UqXqhqip1U+wkO8qiwrS2nMLNM4QBNTRcb7bmqrtWWFFffv0RnEJiWTvoniBGOi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 07:25:31.7439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbadf584-b625-4d3b-66c4-08d612379946
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FPGA Manager support for the Xilinx
ZynqMp chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Updated the Fpga Mgr registrations call's
		 to 4.18

 drivers/fpga/Kconfig       |   9 +++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/zynqmp-fpga.c | 159 +++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index ee9c5420c47f..ec37e9abd0ad 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -56,6 +56,15 @@ config FPGA_MGR_ZYNQ_FPGA
 	help
 	  FPGA manager driver support for Xilinx Zynq FPGAs.
 
+config FPGA_MGR_ZYNQMP_FPGA
+	tristate "Xilinx Zynqmp FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
+	  This driver uses processor configuration port(PCAP)
+	  to configure the programmable logic(PL) through PS
+	  on ZynqMP SoC.
+
 config FPGA_MGR_XILINX_SPI
 	tristate "Xilinx Configuration over Slave Serial (SPI)"
 	depends on SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index f9803dad6919..a7cd98d7f721 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
new file mode 100644
index 000000000000..2760d7e3872a
--- /dev/null
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Constant Definitions */
+#define IXR_FPGA_DONE_MASK	0X00000008U
+
+/**
+ * struct zynqmp_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ * @flags:	flags which is used to identify the bitfile type
+ */
+struct zynqmp_fpga_priv {
+	struct device *dev;
+	u32 flags;
+};
+
+static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+
+	priv = mgr->priv;
+	priv->flags = info->flags;
+
+	return 0;
+}
+
+static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+	char *kbuf;
+	dma_addr_t dma_addr;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->fpga_load)
+		return -ENXIO;
+
+	priv = mgr->priv;
+
+	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	ret = eemi_ops->fpga_load(dma_addr, size, priv->flags);
+
+	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
+{
+	u32 status;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->fpga_get_status)
+		return FPGA_MGR_STATE_UNKNOWN;
+
+	eemi_ops->fpga_get_status(&status);
+	if (status & IXR_FPGA_DONE_MASK)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops zynqmp_fpga_ops = {
+	.state = zynqmp_fpga_ops_state,
+	.write_init = zynqmp_fpga_ops_write_init,
+	.write = zynqmp_fpga_ops_write,
+	.write_complete = zynqmp_fpga_ops_write_complete,
+};
+
+static int zynqmp_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_fpga_priv *priv;
+	struct fpga_manager *mgr;
+	int err, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret < 0)
+		dev_err(dev, "no usable DMA configuration");
+
+	mgr = fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
+			      &zynqmp_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	err = fpga_mgr_register(mgr);
+	if (err) {
+		dev_err(dev, "unable to register FPGA manager");
+		fpga_mgr_free(mgr);
+		return err;
+	}
+
+	return 0;
+}
+
+static int zynqmp_fpga_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
+
+	return 0;
+}
+
+static const struct of_device_id zynqmp_fpga_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-pcap-fpga", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
+
+static struct platform_driver zynqmp_fpga_driver = {
+	.probe = zynqmp_fpga_probe,
+	.remove = zynqmp_fpga_remove,
+	.driver = {
+		.name = "zynqmp_fpga_manager",
+		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+	},
+};
+
+module_platform_driver(zynqmp_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0

