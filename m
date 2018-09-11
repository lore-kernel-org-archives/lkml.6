Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BE6C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA9A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GYQtlleU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA9A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeILCgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:36:37 -0400
Received: from mail-eopbgr690045.outbound.protection.outlook.com ([40.107.69.45]:63584
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727419AbeILCgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YegmdnTSv4ch7+Xdjr1vv941EScAafPDsrXlryMNAII=;
 b=GYQtlleUHp9aaygt9lyWIDnpocbdlkJ8JK6N9Pnhh9DxH7qhyhIqEfYqlpZkjP8F0C8ZylbTweADa0FuCqw5QxREwMDwwYAVSOqI8w9zm68jKw5fTWR6puLxWscB+P2ejSHOw7AeWhO2gweAci1JXC65mawUK/j+r6umFCHgK9M=
Received: from CY4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:903:117::16)
 by SN6PR02MB5119.namprd02.prod.outlook.com (2603:10b6:805:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 21:35:20 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0030.outlook.office365.com
 (2603:10b6:903:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Tue, 11 Sep 2018 21:35:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Tue, 11 Sep 2018 21:35:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJa-0000Wo-Es; Tue, 11 Sep 2018 14:35:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJV-00052s-Ap; Tue, 11 Sep 2018 14:35:13 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8BLZ8KE023972;
        Tue, 11 Sep 2018 14:35:09 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fzqJQ-00050U-Ot; Tue, 11 Sep 2018 14:35:08 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Date:   Tue, 11 Sep 2018 14:34:55 -0700
Message-ID: <1536701697-23949-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536701697-23949-1-git-send-email-jollys@xilinx.com>
References: <1536701697-23949-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(438002)(199004)(189003)(50226002)(126002)(76176011)(4326008)(6666003)(8676002)(336012)(36386004)(39060400002)(7696005)(81166006)(51416003)(81156014)(5660300001)(16586007)(110136005)(316002)(106002)(54906003)(7416002)(2201001)(36756003)(2906002)(106466001)(14444005)(8936002)(446003)(48376002)(186003)(77096007)(72206003)(26005)(2616005)(426003)(63266004)(356003)(107886003)(476003)(44832011)(486006)(11346002)(50466002)(305945005)(9786002)(47776003)(478600001)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5119;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT004;1:6v7tdu8xbVDQ9NGVxm3n+P28qRKgTvY7hWt+HBdGRpUBrosnGY1MWykNCF8Gu/H0qbRj/ebiX6B3bCrII6e8JwKcEDN3xQs1b0adJ19oJCkD1IxXriGVR3Xye39h/7EF
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb7f2cc-9bd1-45ca-0358-08d6182e78e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5119;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5119;3:FfvU5QSHBQ4Ho2SoNxcpTR7XyOO2+1hXFWN3RfUXXrJek+07Tugg9986hUOiFFaViXX2uuCIZ07NNUJJUuyolgFTRuPIgncbYc/zggCEboxHzCwAzumS/2pAk50cRDKhlchCZAbsBvOrgrWXljnGsA9zTbJh5cyIXnWwnTZGx0fHR7iIjffWt6RNWdfMrB5mRu/w+y7B0OK2uVrtiHVCSSrrZHllFzTDkn17NansM2fs7J/P6b9O3CqymUwqO9zFutxj5R05r4j3IvNbEQ2M9XTfFM4qAS1ffodzeUlSRZzEuEoMgkD/nix5LoGemDbRUWINhecfAEZJXR4noZmvZ+Y05d4cAAv1RNdjm3zvJnA=;25:yWBOAqGe4S3K0iXJW6Kg20fdonZhEQH3rGv2dVItSVq45eWDszLXVwW1+cg/928cs7XDCr+O/hDzm+SXShqQtQCHrAwZBbnCb+lGYmgNkZFVCKveNnweJUnqBjK7mkE2KamECKeRr2Aaz9hHGGn+8ictLFV5H2rzmMxBsly1fOaZGge66wv5CEw/hy6nB9A7xiSXczDPHIHBHC3kA6kUV5H1J5chPP6eLRqd7j+kRQTOGNKwbIDuHXv6/cxMl/oyEOuk7pNS6fMlLQ0Sj+UNSKkY3d0f0opKhjdMpb7Lsmi63lDalEM21UB9PClrwTYyq7CefZvNJV6UApkp0Cm3Jw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5119:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5119;31:W24teLMgQuGaZg73z/4N1PAVGAaQy9bJp6qwmyVyQrNADkyeCHpAPctfnzuItS4cJ7gWZNbQmmdgBMEPAXQll4QP4HLLtApaIbgTo5n7UJJ9xURTHkNMpIpDsM9LXWG4MBDVwcUeyhdKyNwgybc5acudSMNe/zJ75tiBaV+eoaoxTMypTKHpcOnbUuWZMFxoQLlD0t1YmGz5kihT6qnr0gNMfidi03J/xtPRqvD6gE8=;20:7spkfH98w42G+UFRzmgS/+/jm+nBFu6xuQCJQ5i1cq8RlPFUD41eA+vXc6pegVOfGCNOrBpq/UovaQeJqs5JVRJYv9r+1uVjWOqPDBWogDMqEK74w/k4gxoXYeYBCalPYDfg2ttGzhO2kfZGHddHMRRwE68x/WAANF1DWuJPVri0G8N7i9TLNSX1HxXgyfk6GCoJ0D8oHWejwBpPa2WFneCXKbwgwvIcSIdJtU+MZ351i3Ih2YC77dXimLz2Qa28orGdQXsKTZLtdiP4Jly7W6r+sTX9Whod8M0IoPY8mfjRLcPzcux0hMgGc4saPOfxevcxo5H+FryD+0iKJqQbD0pdWKH/u0OGOdfCX5TibDEtFXzDSlqTG0T51f9jSF9c1xRmgrpm+DpeTxDvAVC0ibiyuqqsQv4BXP1oQ/mXMm+IYrIUlEvTOOVthc6NFsRTv1XM5YbJBVOnwc9NYh1Ttst5+fswFD8ysMw5lHgbCARAfnqQQ/8dqUV0YJhnnjdT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB5119DE8BEA46CF4E6D208091B8040@SN6PR02MB5119.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:SN6PR02MB5119;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5119;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5119;4:RxQZ5r+frSjxgRQEqd4joCzGweEHoe2zSw4rv6Icjg/YObJtrXqOmg8LQfbDzLw08H1ewyrW3cb6aVjbDrdMtOVeeMEDAiHRUXzGZiSLlVdU0zJJLHvYydIf0/UeURupEJaaUzKdC3ECQ96BOTpBceGR9Wgk/rG2M/FZWZ+RRIZfWxwe2scNiZrYZqwNESDZebtU5ddRqVWn3kLUrTF9g03h43FLsut6hysTJsIS4ttO0TtusQV/CD6DIkjA3wcotAglyiLFGqluUq4SolZ2acRH+vzHPfKwbLRBlOWAbiVBGMurjEVmAyoTdBMYeOnE
X-Forefront-PRVS: 0792DBEAD0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5119;23:4KoUiJYl+uRy7IdONE6BN4Iq/7Mx4Wt0YFLHCSljc?=
 =?us-ascii?Q?RRclrNOSAFkJRDkUHjwsDVsORZoofrjx3664Uzc6syRzelKaJywcMWEYzIbZ?=
 =?us-ascii?Q?UmHpAP1c+NIv/sSAh65w9cVQNU6BGLb6xjcSelnW1NZl7zkSXvjEt8Ys4Jv9?=
 =?us-ascii?Q?5ghQuhQuBmphbeGIlv3+PWhldGgpHnrs/3icL167HPF2+FJjO5B5xf+XQLGY?=
 =?us-ascii?Q?9/2FTZGsnVWlgyJ/5KTTIC6ZCW4ddPN4mI59wI2UnUnpR1J984paIohPEZFI?=
 =?us-ascii?Q?JEX2vMr3YMAWvwkffp/WC7/8cqzJuZ/SE9lXMC7gANtGVwxT30hN6sIKxQwP?=
 =?us-ascii?Q?ecJRK0jzhGqXA9IHOIQCNoZG+qTyQCf6Tp9u6pRMrV2uwTMR+WxauDdNcTtA?=
 =?us-ascii?Q?AoHQhcQMJwCgaauyVewurmecdbcmSFE+OpyjTYqWOGCFnwAdkzRuyG7ymj9t?=
 =?us-ascii?Q?xNK1Jd/lIDrYg5uCeFK0lioQ6kktBU74pTX6L8TSRxDfet+IoDHnTrBNJVwa?=
 =?us-ascii?Q?BRBCCZrEFG+IKjKQnDoBG67UwvCs6+PSN1VWG9PuxI3HTVamvnqtJyXnhB/W?=
 =?us-ascii?Q?VYduXN8XmGgWELZt+LCYh00zSpevJjXbFAS4DRCjseQL+CnTFv/dP2itwMou?=
 =?us-ascii?Q?tcNI218btBoid6qeMBUD2uXJSQRzINTWczAhzfONcOz3k8hn4gJLFE4sH59I?=
 =?us-ascii?Q?8jYFAYyx9u6vSAZ+Tv3qPdwb7V5R32XoaZZOdfSWIFXEm/5O1zaHQqZNw+hG?=
 =?us-ascii?Q?3j69tyze2rrYsGhpX8+dSqjIkkkauNXyl1LO5ACgEQX+r4bBL4W34ngHW+9b?=
 =?us-ascii?Q?9JDhNy/dMxGW3IrCZpyezgHM2l/Da/TFPu3nVnOUR3ObdKahRs/ASrmb0xkn?=
 =?us-ascii?Q?/GLdcA0zrX4/A62UlsebTj7BSQhQu5ngMRGRyz9mLcCbGWwPaDzek7n12AT9?=
 =?us-ascii?Q?EkZwcceSSbGpVVarmFy7v+iF85vUUTtZV3ooGrUvWYHYP14b7NwX71VJMQ0b?=
 =?us-ascii?Q?aA+ujrDEBkZPE7IG8RWKgTUmqWj1n522xqdFPuJuuT88IyuVvZ53uN5j+jyp?=
 =?us-ascii?Q?ASJC3kvfrpm5jtmu9WrUz0vOX7DkRl4Mwn4dut7pto/kUTzP6iyF1QwaEG9U?=
 =?us-ascii?Q?66SvoKLxrsyaMazNZL3cpQ6ntDCrnQuXx1Rdqt5W0Zdo7UAKYQnc2BhyU7LL?=
 =?us-ascii?Q?QzEde85tc5+FZBmSFzW6o7oYs+kndEG69q6Dx5sqVCr7k/AVWR1oxegEhVQP?=
 =?us-ascii?Q?RsyxjxMqM3WUIzIG2fK/XwvA8Rw0X2aMYNiE0Q9S8KcsSmBbAoMUV+g+HZPK?=
 =?us-ascii?Q?oiBAfFGQkv7xBMANPgiNKc=3D?=
X-Microsoft-Antispam-Message-Info: nfLIYpVqKu5Y0DOV4aN7btCvzsrdPvIw6GMqCnF3f0iD29oCWhe0ckpQHU4hV9L6O4fCZdU0YNx8mybUa+E6It9myynaZSKsBEpojoEC5/BdsEZEDJrguPcIfExPj4W0QBNMVBPmI61IaSjiSoICALCf2vXNUSOkmLJ2/InhRMlvGXWEtTCsev9RjzvGmYMnB96sWAGHLCLVNhYcoGxvAxGh9+3VhVVpccu/yiQMD85c4hjwfTa3967gm06WOxW0fRbc114baQmX7LXct6z1XCtDATn1ikqC1YKwi8AH5ULO5zU691ACavtC1v5FZLpkw2fF4ypqNPtJuW6cPg5g5GECvviuxXDfqiURnl3Wurc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5119;6:2DgTpT+vvUhtW9/Jpc+UQl4MNCO3Kd7xSv41XdKbjroOA+CutxW38kgKTHZYILSGKv6vnFs76vh8dFE/znsK/eASmafz25ht9qaq0JzkcKrkdFMi66FYJg5hDuF9nXnth/jc8A0k06cP+q+IF1S2xE9Vbrg0TKpQCEzlFCOI0GxAQjZ3FmBneu1vX9+cnXGmhRs/11oZsQKOitLp9EN/tcLGmQ0UV0gk/ZDHDf59jLTyRPlNJ2WmlKFHdfTGwFZCssdEa5+mzv4yylrQ7nA2slUyHx4B7QTDK75H4qE54/1FCheTTXeKamMiNElJyw48SoQN/UzH6q1Whc+k3fwr8ga4HgGUNt+XmbABFQboDqZmbsLWiiuDGzN860wZ7h0oacgjIbn1r0FN+wEGIc9PKmXn5WPd+By4tDxQrJAnG4vk9DP6kZl503X4zr0gzpgFokmOkY/0nAO12UB1HPy8nQ==;5:D0WsklVy6iPCnhZ9sjOQGK6wmdagg7+zd37ZuNuhMFAv29yxukR2q6hUH9UCJXfIvHIUWc2yWq5oANTDpk8a/JlxtCvDIKso+0HYgkZ6wO/yEpTJYDKydsNZnQoIWOSVB/7PH+MlhkLYwnpfBVjdYKJUogaf0TO9F7Hk4bk5hdA=;7:gTvYXJX0acX4B4scLoqXzbsH42J84wL9gcrIjmoZBo6w4ixVJW182fBebjC07nHO+gWeNuvNKbKQvwY8SPDCnSq2ja8vWdwGd+v8kwIEGAa6jXTaWAyqqz+WCX357ycU+I0rC+oJkhEug8s1S0Ub1hl7qFDpL4cB+tH2slU7rM5zVmSKopIQSXnJftD1i6cinuROtuALYN6KlTXwIjO/0C/oUjeO0bE2oFbV0WKAF7I72XzpVqdNdIJjac3Yhwi2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:35:18.8374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb7f2cc-9bd1-45ca-0358-08d6182e78e6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP power management
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../bindings/power/reset/xlnx,zynqmp-power.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
new file mode 100644
index 0000000..925d17d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -0,0 +1,22 @@
+--------------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
+--------------------------------------------------------------------
+The zynqmp-power node describes the power management configurations.
+It will control remote suspend/shutdown interfaces.
+
+Required properties:
+ - compatible:		Must contain:	"xlnx,zynqmp-power"
+ - interrupts:		Interrupt specifier
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
-- 
2.7.4

