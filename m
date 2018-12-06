Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F68C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF820672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="uPR4pFas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AF820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbeLFNx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:53:28 -0500
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:13292
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbeLFNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkz+hqPm0OYx+KmjXSZw+Uh205t1zVXLn34PhJtSTw8=;
 b=uPR4pFasGqoqJNRhUBiiC7j4FfSt6n7xk6rK/iB4vIsincREpIqOEgACsSJXkAgTYpRqQ7gpkhKGaoprLJ9C3LApSgBfXbvXxneIdDb2E5hjY+LSHt+eysFr+wrB2hVCh3jf4DAdc8kQ8U+Niao9GNIQ0rUeGqmzwQ0WbUnfOsQ=
Received: from CY4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:910:4d::31)
 by CO2PR03MB2262.namprd03.prod.outlook.com (2603:10b6:102:a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.19; Thu, 6 Dec
 2018 13:53:24 +0000
Received: from BN1BFFO11FD026.protection.gbl (2a01:111:f400:7c10::1:113) by
 CY4PR03CA0090.outlook.office365.com (2603:10b6:910:4d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19 via Frontend Transport; Thu, 6 Dec 2018 13:53:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1BFFO11FD026.mail.protection.outlook.com (10.58.144.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.13
 via Frontend Transport; Thu, 6 Dec 2018 13:53:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wB6DrNnv008207
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Dec 2018 05:53:23 -0800
Received: from mircea-Latitude-E6540.analog.com (10.50.1.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Dec 2018 08:53:23 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] iio: dac: ad5686: fix bit shift read register
Date:   Thu, 6 Dec 2018 15:53:15 +0200
Message-ID: <20181206135315.22805-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(53416004)(8676002)(106002)(8936002)(356004)(486006)(86362001)(6666004)(2351001)(106466001)(44832011)(50226002)(5660300001)(305945005)(77096007)(476003)(478600001)(26005)(186003)(2616005)(107886003)(4326008)(336012)(426003)(72206003)(50466002)(126002)(7636002)(2906002)(36756003)(6916009)(246002)(1076002)(16586007)(48376002)(7696005)(316002)(14444005)(47776003)(51416003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2262;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD026;1:c1EkH5RdxqfJe5+7s6gmAjIitU1Umd9wSKlxL2IqWpda7QSbInyqTX07kTaiHkgyM/p6xTkOPYIoeAgHX0jeqIXYk1vxAFjbeosp0rmu3ltCxjc7AKlIptbHbJ/9aZ7Y
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc6ff826-1f81-4df7-6a59-08d65b8230ba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CO2PR03MB2262;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2262;3:KLz+Vw4YGjDNl7frr+irZLeeKTDBDo68OL0wzRQbMFPi+JkS6z8rRhlNuqv8LeKGnP6O6DMfcZv7ss9Hx6CfJKiDOEebFXiXIdV7Zr0N/LV/wTG3n7nF9sJHJaDrK337zODFJCmP2eEDFSzEihBvwjI52KQILwGiGW6gjrFnmWoicoOEw2dFfiZt6Ywak8kYz7UyN1YX7p/1I/2OUuNad6U2hY/1g3DbC11aLnxnExhZKCXhfVZYy96t5WfJttH5JZxAoBSvLa4QCqFEf0kXn2GIOrvJ/hwD8xFc4FuSVl3DVDNoUtiidEQo8QVvCcaBg9TTwzxBDgedllxh/8jKIWxWu02NnasrqP820+kjx0U=;25:w6oxiGWenp09ZxkAOMWnOGUE/kA4Eak7FKkDif/7USZAj/sRKi+81eDC8qT7wd9hcjFxUtHD6j6MxwxpU2WDznoIyr1YPKj/NXRzVTWJFrpzYmmmUyh45mZ0oH/XhD0GD/QEc9AJffKP2r0Wqo0vGjuWox0/5sd3PEEwaQznQpTnkvYC6uME/0hKAqQkVmGEOVUHmIILzHMEDJ97a0UEMp/QaxhyCgfc5G8nPBPVol/aEFur1j+65+9JwcTCxl7DjD5vbTLqump/394UbX/6dTxxuNCypFDVv4oYgNIcBRd5t1HYYvytnaLDQx6/PzLNTbvS3LTrqwICm8mYunG0Aw==
X-MS-TrafficTypeDiagnostic: CO2PR03MB2262:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2262;31:ISG4pmuRVzZ8X1OVDxQ+Eih9bjIRQRCdjaCUKdByV9xOORLqWZv6BYPKLEDkQxlnNNMLJNjXq01YvP9JODauqIQX/iNmYzjJiHyhtIOplMzw2cIMZcig87iKxw4higoHPC6Wm6pk9Yo/n77MtlwwZgnB8szNMX0VJbNBRvMArPJgY+eh8e01AynZFMVJHPrleXVrd0jLt8gGSvU6UT2SXVQ5Zg9EuJHfCIf/QKNmTGM=;20:NQoNuoNSAOSPLA7L7GrtaNzA+9tlgXa/9pfQzARU0bn4DvktINcsDq83ddVLdjXDXDU0PCBVXZXrTM0Jwz2uU1uYh5E5ZA4qnN3ZsPuk+qnedcTyYNmGkrZMDvKjbVh9/NBtBWfgqgrmjnXTF7qnFxqpKy662Fgu7D4V9jYJF55rwLJYTnrYJonvZzzn4rBH+v/WvvsmDlX8Hv0j76UXVYKJ2PoezCmmb5Z66wY3aSFlGYvEM+aQ+AX1/fVPHI9ljyKQEi6QUCabGikEctob++pCIEb0RYrEG0kZw1qRHkagFOq9qG20me/NcYBaEeJ78jXOpP9awWnFmPXRQJqJRujqG4bo8gmSSFRcjsANvzORCxrm8Xmgrg9Bp1ZNm6RwpvIEOP24v5JmZSTEwmhSsNsdYIfvZCGKnrz+Pb3zNu/iA1/WnqV1bZPHHSrV3DyG/xDUQKrEMKfzzPrGBH0TAxSTkihQUd+GaKFzR0jkBCMl+Q60hM3DGdU5iLHtZgcq
X-Microsoft-Antispam-PRVS: <CO2PR03MB2262872BB2003470BBDC14C281A90@CO2PR03MB2262.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CO2PR03MB2262;BCL:0;PCL:0;RULEID:;SRVR:CO2PR03MB2262;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2262;4:HmvBmt5lszKycpJj5dlnWDkdCqdnCbHdcbiOrq5yA4BUFFD10QgEXyVvjcDxHnUdHqf0pG6YJ4L565D90Oy5SwpfuEJ5ifiwUpEFcVCTnTsgK2/i3z1ZibPUYBOIt/wVm2zo3HBn4l9vCxqS04mkIrEik4EQs9ffqxndvP3ih09hqW4xv2Q45yaOB6tcG4LsRWX0qg+txi8i0Bg6fj0CVPNEA570jkPkrs7CdKcEwZJrhEz4b6z/PZqjhVBBOHxGq7PWA4hQHwmEGPJsSOBD6w==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR03MB2262;23:y+XmcK949T/5mAbWORSWt61WdqaZ3qN63c9DPHDhQ?=
 =?us-ascii?Q?H+YgerDglkMzmsgPisVp7ULtZ+mFGSE+ZxY7BWJaOuInqVrni+xsEhDNJzJn?=
 =?us-ascii?Q?rEubD6wzrIOMqxsXZSfn/NSZApuOeDI69enOx47fFQejnhGI2OqeHWgqCnBI?=
 =?us-ascii?Q?0OmChUoCHi+LBiJDceXGU9nEMCy2vn/yR0KVEbLBYCmPGvn+F0WdRF9WOdGY?=
 =?us-ascii?Q?A4kOwyHgd7ZLbNLbj3MyOMbYFYgHP4ehr+Or2N3EOBcj+soSGivQZ0N7nJjE?=
 =?us-ascii?Q?fJt7BW8ksv6aWaC6yp+ClAZ3kQguVjB7x8hd7nPE6WY3VfLTqSTUuJnyN5rx?=
 =?us-ascii?Q?BlcuD4FYN4k4fgLOxvM7eCy4ZdDe5ozonQh4IxBxyBv6PBqtRvjkOU9kT7A9?=
 =?us-ascii?Q?5sHV7LKb62TPbv7ClFWTjuCOLmaUdWW+wxUdarJQ8Dw+AvQ9d2IM6RAQ1+Eq?=
 =?us-ascii?Q?3rdjyFOOEW80UqqwPn9FRR1JimuIcId5pD6OCHphcCUXuUGe5lS1q3EtSV0I?=
 =?us-ascii?Q?bWmAGt5iiphV2I1rVaOywSYMo9t9DSrrncMvf3GOFrkToRazI8Ya4gMEpZ2J?=
 =?us-ascii?Q?m9pXbXvHp0xuAUraTqS/NZN6WPMfaxoKKX2LVYv5RfyVySOxvg/7PAkz56HH?=
 =?us-ascii?Q?rq3MFRQC6p6X96XwY/LK8XQEl3AOIc9Wn1pUCBymYQigGDgcyadAcROnikNT?=
 =?us-ascii?Q?oiZkx8i4Tk9iqAig8dqYQmighrNMlMYYVwZcC/6yzF+ZQM2zqJYrIqRe2994?=
 =?us-ascii?Q?+TveXo3T3T7qNrXc96TS0PquEjRKfPZ9JhN7uOl2okykxgLnGop1pvT+WXX8?=
 =?us-ascii?Q?REhFd6bKbmWvkubAuj0Jss2i4WxCjh4TOjfKID1pvqXULz+E5UVwiuB44UdR?=
 =?us-ascii?Q?XepAZt1kAOmR7aoymZBOD/idKYPbN1vSC7ygP6e+OkeJcAPftD9QCGMIaikO?=
 =?us-ascii?Q?3eoU7vFAbM8Mh7hLDy051tjTBYlEfSYnzjc9oZeJWBL3QjqsbUIOHZZpCecA?=
 =?us-ascii?Q?KFbtLPwTrBKgJS9+V6Z3tLiVd/Oi5Wn1yrKUvFrLNz1Q30jElz8wvv6Bko7+?=
 =?us-ascii?Q?XXbAAvlFVnVAh7KYh1rmzAk250l?=
X-Microsoft-Antispam-Message-Info: 6gujfHZp6nsT2C3yYJQ3I/xkZBXMeqz5KXoflOhILxVv91FhqIt88kp9EReM9StpvmvixhmT4Vyw3HRiMVEmZqfcpaxkCVKyBLj2wsvHNTIzjAmG+pZtrF0UNZUDawK5Ef16eFBXz05k7j0KXX73/Eygfg5U5xfRricIdZtpCeOmitXKM8fO9Tnr6LNihaaahRkLF6T7q9gfmLbhkXH9FJGrD7REYip0W/bMo9xTJq+kF80P8aAnZXiE9o2oo5i9Rh8qlqRQ7JwaT2odf5auKFoLFkuDAohihZF8iCYcjMTbVWovTItD0qXUooPpdWbdsYqiVFjYvHD0XeCFE+T+3Ju8neyeMuiKIcdsswIifD4=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2262;6:mpSIIiNu41pB6Vb8aqud9kWCaJX+W74JfHpNSTHB0s/cZncBSSDXali6PDCAl0FupS+IKBMRoN0urJNVTKoryss5Bw4vy36SgOR3J4FcQe8Gc6+2bCzD4wxbsJxPt/8TxkLVZNBPGrTC0G27RCcQktK7aWXj+VGygTXqHJNIdgl0hKy6mLeKukLxAPzEeFA5BZ2Yjh1ados8vV8yqziz+bRZ+TrjP2MqlBjN5D5ZnMwSkdW9GFxWOsSiB34GoXh9R+lIVmy73QdvUCg7nvmaS+LoySF93UaH0MY4O24lT+bsPzZKeSAW4Jqy+zqSxaM1T8VMy9UiP9A5cA7G6L3k1hIxRiuZ1QaxBnFmlDDjC5Cmj6+Q0qcHCKeDGLHSmNf4KTxHy4UjyshPo0/sr97qO+uDN4CegZWAy6l9xr2G3sEU3N/I4pEpJ6xnkEPW7bmSW+as+d0pzM5A3B34bKU+rg==;5:jdQJZ0ZouLBdJGQTnIi8xBdLo/FI8/+j1oBonmYA2wJC2p7kZa/aILRMHf+ul42tKWX5d027Yh54kqTQgoRfVb4zmG2H0bQYBvRaI7+sMmXzGL8v3kcP3ZV5hSlvVlISdM3eWiqEK8XEjPN9uh+rvcUi1OjYNYzICv6Wglalvm4=;7:ompaAldvICtJWOaVyxVQrq1pVzZhOfj/jMPX0pI/+v9EA7Zvl8qKhOKz/LfDx4PXRb3DfLT1N0Chz9C00Jec+s1wE+plfhtQZ4d/CUj/k3CaRCZAFaeFM4C6EIQsObVBmb4aTriViXm7M0lI029jhA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 13:53:23.9653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6ff826-1f81-4df7-6a59-08d65b8230ba
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves the register readback issue with the bit shift. When the
dac resolution was lower than the register size (ex. 12 bits out of 16
bits) the readback value was not shifted with the difference in bits and
the value was higher. Also a mask is applied on the read value in order to
get the value relative to the actual bit size.

Fixes: 0357e488b8 ("iio:dac:ad5686: Refactor the driver")
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/dac/ad5686.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 54ff76b93366..a332b93ca2c4 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -128,7 +128,8 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		if (ret < 0)
 			return ret;
-		*val = ret;
+		*val = (ret >> chan->scan_type.shift) &
+			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
-- 
2.17.1

