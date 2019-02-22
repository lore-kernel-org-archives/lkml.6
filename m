Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C55C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427712070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="j0INJcXW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MKgOINk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfBVULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:11:45 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58318 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbfBVULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:11:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MK3dg5018272;
        Fri, 22 Feb 2019 12:11:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=proofpoint;
 bh=bqLvoBC3LJV5FqzJ1Acj5Yp5RkhlK1RWrHEdCYS0OV8=;
 b=j0INJcXWM+teRJQbm3tX8ZGc5tP8rwLu+dhVaRi0ZZbSbgji7co6fnQZKPKKVTWac9K/
 CGgQsDz8USi6+lLfv+2VIwxxQO3jFi2vjZFJbBUxImgNFqJMkelXvUGw78L0XihZf063
 8R+ofjIoEDfpxU9hPXgoL8lg7FUPtnFv3XFgBWQ+iJnLTlB8kdh1k6NjIMinKsQ49HmC
 Gb80WLcFTtyoc9Iwhd230L+dEBCrTvKHNm1htjkDpNBfJDDZJbegMKyxKtDGC4se7MNn
 vqBqooGBV+fpNgi7qVT7w6d9twWOJRrD1yCWt9Ly/aPwHpwqSfyVUUufvliFWMJoCUGD 0A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pthombar@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2051.outbound.protection.outlook.com [104.47.50.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qspmmrb0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 12:11:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqLvoBC3LJV5FqzJ1Acj5Yp5RkhlK1RWrHEdCYS0OV8=;
 b=MKgOINk8Gu1KU/AHcrA0aaXwX5RClCCV7EzDWqwxuTTlOGybriR9X+AWdP7Gj6JbAVXb7qqIHXeTErrZzXODx/aUxCfnBBpk6me0Ci0Kv74ZKZr4OmxiGrECOZAPP69gS9kO6CWT/4SlhXWt/H1vikBE94+YXPBxs2rJYG7KOuk=
Received: from DM5PR07CA0049.namprd07.prod.outlook.com (2603:10b6:4:ad::14) by
 SN1PR07MB3982.namprd07.prod.outlook.com (2603:10b6:802:27::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Fri, 22 Feb 2019 20:11:33 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by DM5PR07CA0049.outlook.office365.com
 (2603:10b6:4:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.14 via Frontend
 Transport; Fri, 22 Feb 2019 20:11:33 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1665.5 via Frontend Transport; Fri, 22 Feb 2019 20:11:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKBQYw023795
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Feb 2019 15:11:27 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 22 Feb 2019 21:11:25 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 22 Feb 2019 21:11:25 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1MKBP1I009448;
        Fri, 22 Feb 2019 20:11:25 GMT
Received: (from pthombar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1MKBJsO008607;
        Fri, 22 Feb 2019 20:11:19 GMT
Date:   Fri, 22 Feb 2019 20:11:19 +0000
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>, <linux-kernel@vger.kernel.org>,
        <rafalc@cadence.com>, <piotrs@cadence.com>, <jank@cadence.com>,
        <pthombar@cadence.com>
Subject: [PATCH 0/3] Cover letter: Add support for high speed MAC in Cadence
 controller driver
Message-ID: <20190222201118.GA14791@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(36092001)(426003)(33656002)(81166006)(81156014)(8676002)(50466002)(86362001)(1076003)(5660300002)(8936002)(336012)(2201001)(105596002)(106466001)(316002)(42186006)(356004)(186003)(87636003)(46406003)(53936002)(478600001)(26005)(26826003)(16586007)(23726003)(69596002)(97736004)(305945005)(126002)(97756001)(2906002)(110136005)(476003)(486006)(47776003)(58126008)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3982;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17f51fea-3fee-4890-9575-08d69901effd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060);SRVR:SN1PR07MB3982;
X-MS-TrafficTypeDiagnostic: SN1PR07MB3982:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3982;20:eFzF0kKgYqQcV4fxqYeQGoLnsDzlA3ZRop3MN1WeLGN3GEzBoRtztFMeBCK7EEFStw1zCWK9NBSo7qoIfTogxlHsyxq2Kg4sIWkFlAS3rSn2iafTPgPtpwajkc97eHc0XxL3R5M90+5Zmle7JYwstBfp8y9Te0VcAtNkUn4566JkhMEBVme94eNB0s4gh37opBBvQp0AlW53mZXJAxHOYL97uFAVrWFAHd/iL9raNqFGTKnVnSIfCUACjTlwXv0xu7GurDMXiNtn/GOhSVEcU8hND+4P2qJYkanISC8vR+UgIG1P7KfTv9BEj2v0s8WBXzSczQY2Y598yCM8ZrrA0zs3HQFUl8bOv9q5jCEn33dCJRZKckKSnKuiqebfPgLPyP7aOaJTGyGqiBK4KqFhnyxbH+MtyTCrQ4wtYC8pJ3GwWY23bOY9uF+a6w64wkYsv6/L5zTzB+7iN9twVmGw4+w4pS+R1gkMjWg4jV2PdEb/Eurv4rqiVvSoZmSUnGac
X-Microsoft-Antispam-PRVS: <SN1PR07MB3982F06040ED4B1148539C20C17F0@SN1PR07MB3982.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09565527D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3982;23:PlSjALnU2paBg9LoPvAU61hn10LAZ8N8UEgAy4xSV?=
 =?us-ascii?Q?yL3X30dhmBPQuD4FZFD48UBx8jPf+F1wLTBGPDhpxcqwmTzZNYNtLAs6gV7z?=
 =?us-ascii?Q?O5gxiCu3zr4jAakAhTXFS01q1pZMeIoMQGuowqR4Sl04qe2wBP/5SQUPbDGJ?=
 =?us-ascii?Q?vLW3IA/yXwam8b4rN9Mlww3kQFLdbgRl+3UKawMgRoiSMNVbijBWK/1wHyRw?=
 =?us-ascii?Q?8vozRELtAJI3kVPBC2kMb2CoRL6zm6eHY9Oi919mUBr25I4Sl3S3BydmZQtp?=
 =?us-ascii?Q?MiuiITUplUvXZNwIQHr64nfIqR2og5w7UKxYAGS+jWMLSdM+eFoQ5BYI/Eqt?=
 =?us-ascii?Q?swivPRxOkMvBabFPpp24bvD/mPx0F/u3o2anm4aVxwAodCPo8Jt+I6KaqO3w?=
 =?us-ascii?Q?ac4Kynt8r89GBGRni4YzIEBhB1DeRzBQvurfNuiO3onagalYtAbcKGOT4HXv?=
 =?us-ascii?Q?tOUl6ekw84lFJHjKvAgzCuVZAw+3iRL0t3NhOL+/gHICD7fjcQl82M0LrKbf?=
 =?us-ascii?Q?XLwtE/DN0nkVtNK6ueSM+EI4QzSMJzSpR7l73R0m6TDv0athiobxkGYz4ExR?=
 =?us-ascii?Q?f/mLS6ow5v4+mOhnOeA5vwcz4QNf9d5q6FnH3xHG+3fJHrHnLJZCCcnJ1O2p?=
 =?us-ascii?Q?NgXH3iVZ15NCFIiSsBKJUsclfuw2UwWUvdcQop39SesuoBDlIl054pLE9gSD?=
 =?us-ascii?Q?vEcfiOpdyRqk9KFZrlbohBLqTm6Czxa2Cujtxy1tuAK9ol3qDnaj+cD1Hx/2?=
 =?us-ascii?Q?6tMF/qW8JkEWQUX5NhJQOMnUkl8FfW4fjq4tIIF3VeVzJl58JHXd8TxUQLYr?=
 =?us-ascii?Q?IFpS9anGw/8T9Kgr5n2SEUe33MMs2dspRlX8M2bpxT5MKWbGhObV0+SyzRaR?=
 =?us-ascii?Q?n/FN2k3sCmSNXEksbIVg7AQXwZF7AzgZRhojjuYzE15nZ8tflMzdVb7dzIIq?=
 =?us-ascii?Q?zrv8C8qeqzReNTzrfdCXhxTD9jQdMF83doxrOwe80Lp/w6eTjxnAsRyh3Thq?=
 =?us-ascii?Q?J0bZ+t9+wPbWhFB11VU5Rj3yrPpfLI0se6GEkiSHma++0vOJvuCxKbb5xmCQ?=
 =?us-ascii?Q?6dhyoeF+Zref7IVeVWi64nbGdSRrbuIlYiK9QnQ/zMUrAB9QcaZ3NfcXz+ww?=
 =?us-ascii?Q?DGJ1N6rOg8=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m1advTdWOI4Ke0SszoLggh8UgKJ946nmqCL+c//8eBlxiICmaPCLw7rKxVzGAx+OIIYsMKeYg+/DI6ywbPzKIjSmZDOhDsA7Z0pLJ1qwF/VsPwTeEsxXb1viIORGjaEXe0RUhSPXrh4Q4HqWfn2NUtf9atJQ0IcH/5WyxEDTzl2R3pP8DcBCVPsBwLJjaN2lYJfJtkrWj7V73f8ognPMcdSX0N/bPlqFu7gmBdrj2Q9wfP2O/DNLJO5avoYHE7gu0LQTbzRLhYW4u8PpnEoNwSda7mv9pGfNvIgoRGgODdMzY9yA8M3OgvG3IK02ckP8yfM0eGosqyfaFIyuJmIlUyTMd8zwlM3stHJ9RklZ316VAqPHOogKH0HOnDYmq75PnkSgsjlx5J33nYjS4O5O/4x+3sjICs/Kf2jZC1QBYFE=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3982;20:7kfmrgOcYXsGYG3QGh1nTqFNt/9NVQBx9+S2RJ7RmUqcY+bn4Xelg5jOAUuuGkb4fxg0KQYoDBx43y2UT+kHG1Awfz3Acrmf4//MGz3k2MOlX6g0fX1fvFdR6/PGiH3OvyA52RI6neZ20Hgkr1cDpnnaqdTUjo5U9Vo9c5TJh7GqRm/+aKDRp1bkzQp26o/0ww1TSZwDmlqVfDd0CE2BXFCeKIDZ6iYXUpa5JDJ1KVnB4tNEhsjL3MC+vkeMO6Cm
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2019 20:11:31.6091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f51fea-3fee-4890-9575-08d69901effd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3982
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=561 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

This patch series contain changes to support high speed MAC and PCS
in Cadence ethernet controller driver.

Here is the list of patches.
[PATCH 1/3] net: ethernet: add support for PCS and 2.5G speed
        This patch add support for PCS (for SGMII interface) and 2.5Gbps
        MAC in Cadence ethernet controller driver.
[PATCH 2/3] net: ethernet: add c45 PHY support in MDIO read/write functions.
        This patch modify MDIO read/write functions to support
        communication with C45 PHY in Cadence ethernet controller driver.
[PATCH 3/3] net: ethernet: add support for high speed mac and usxgmii pcs
        This patch add support for (10G) high speed mac, usxgmii pcs
        and usxgmii interface in Cadence ethernet controller driver.

Regards,
Parshuram Thombare

Parshuram Thombare (3):
  net: ethernet: add support for PCS and 2.5G speed
  net: ethernet: add c45 PHY support in MDIO read/write functions.
  net: ethernet: add support for high speed mac and usxgmii pcs

 drivers/net/ethernet/cadence/macb.h      |   68 ++++++-
 drivers/net/ethernet/cadence/macb_main.c |  309 +++++++++++++++++++++++++----
 include/linux/phy.h                      |    3 +
 3 files changed, 333 insertions(+), 47 deletions(-)

