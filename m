Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD92ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7D420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fqSdJ8Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7D420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbeGSSnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:51 -0400
Received: from mail-eopbgr720044.outbound.protection.outlook.com ([40.107.72.44]:31566
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731732AbeGSSnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLy+qirH91cpp6DZ+/iPeCDQSBqNUfs/LfU1qkbsIeY=;
 b=fqSdJ8XjqZpPVtEMU+KlvpYi6o1ERLXOpuayQ24TDGWrlxBBblwlVvjY2iOXMkb2sypWpf02vkhbrHMbA57mI+vsqLP5xPzpInMhzIBVkbGDegEqlQVxt0n8ATX+TE0fWKQfL8oMmUgL9rJrNDFKUumHDW/1rtn/9vJDjwyHlQ8=
Received: from SN4PR0701CA0006.namprd07.prod.outlook.com
 (2603:10b6:803:28::16) by BN7PR07MB4707.namprd07.prod.outlook.com
 (2603:10b6:406:f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 17:59:14 +0000
Received: from DM3NAM05FT021.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by SN4PR0701CA0006.outlook.office365.com
 (2603:10b6:803:28::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:14 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT021.mail.protection.outlook.com (10.152.98.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARr019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:13 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:25 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:25 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHx97e005647;
        Thu, 19 Jul 2018 18:59:09 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHx9DU005646;
        Thu, 19 Jul 2018 18:59:09 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 03/31] usb: usbssp: Add trace events used in driver
Date:   Thu, 19 Jul 2018 18:57:36 +0100
Message-ID: <1532023084-28083-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(199004)(189003)(36092001)(316002)(16586007)(54906003)(87636003)(42186006)(50466002)(48376002)(86362001)(50226002)(1671002)(2906002)(478600001)(26826003)(8676002)(126002)(305945005)(446003)(6666003)(356003)(11346002)(336012)(14444005)(26005)(47776003)(107886003)(5660300001)(109986005)(4326008)(7636002)(486006)(4720700003)(186003)(51416003)(106466001)(76176011)(36756003)(426003)(105596002)(8936002)(246002)(2616005)(476003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4707;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT021;1:TxvypHp16aYf7rJyVBCV5ulUotUnkMzd06aCw4EayIanUNHUh+zAgbEuzhDHmXwlvHS6YZ1FaIjRSJcO7TYBu6c9KyeFUDP5dqcNCwV55oE/yseY2pm92dZMKgjd1opp
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb7be1f8-3cf6-44ac-7ae4-08d5eda156c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;3:di8fZ5x7tziWU5cog7akSn41gUSCL8N4vOcERtR6osCg5YGw1Z2mKHMRw1qElXYqJh2WMmZZCWmdNy22kRxDBIHHUdjy2FEpN/gBO4i2/hZvNLNeqGATtEAngYpM0XXXsQIDN7wSeQWQMXDtO6SwK+PscqE6fhqPwKsEYc4JH6hYJgDP0wdbpk/T9hfC7w719PW9mUF7i/LSUbEf7RKQebJgkcgYXmzxzazUUnhalqGQ99GK3J0AmbyzuDLILVw9S+ht/S7rBgYn6eOtiYS8cJqHlP2XPRRNuDKnmKKl7Xq1a2g6p14BdljLV970n5MHzze+/zBDaPWimCT5m612kbS2DObVe5bvyCDBAoNa2f4=;25:rwwORfL4foOxz5RRYr+UiDxxmNG0sXuyz04J6w8Y1Dzf1QED1AiDyLvcbucMcnnb6WdRVqcL+loPV3DLj18qV0ZadSk85uG8SLgOJj7I3/YkTFHBq2FAGdByirb9YRg3KUDjNp/Ixf6aB+rFwcxHHWcLwpC05TT0yjKFSWEM75UnXTtCxaX69kQK9xhaIdgS72ZILBVLrDMY6seTEnOVJCQZxYxaIwUKkTjJXTZWisUHA6gIB03wCEU/I7efP1m6GryxyZc/6coElrJjN80MAdjnIz4fDOqgHBekG70pxzmqVgtjomv9lBuIUvQNn/6Nbjscd/5fii+aXS8cl6dodQ==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4707:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;31:k/CrQzjyhTGbg54lFC0prXf3xGRaHRK1IQq8jzDpgEi9TwEXVUqTU1q6xmA90hP9P15tliHUtndQJv2S5+vSTetX244vkbpN3wHTYyX+iEQPicfiLaOVyq/gZeWJV3a2V22XoQHnhdGQ/+w2r3BJJP4ey7DJlBOYhhG4rhPYKsD1+Wt+9IKDLcYYPp5ZJTC0IY+ujGw37jUN7sKq188GdGt5gZohXm0fNzDu9cPJi6c=;20:kmoSPxIe5LYwqbfPP2CRJc6C8gil/lxtShppGySNFYX7jSPok8kf1H1TNdS0aPVDrsMZ1mQwlVfPEQVp5dfyWE71OGfGH4Y0SO42ncc8lf1uHrvwB/moRkcHWt8BjpNViBRJJ4OPEbMBzba202WNpVLCDc8CT7B+1kq7iokTnlPKStkraRCWlFhoWNDsMKIwbZlUwOgKT0ZIMRLBw9MDRptrWiaIbXtPmUUh5nc/xAZobDq5fDAw9dNZlU+L92kRtUfuh31s1yWipBA0UOAZCJm45ZSTmTL64cVq31Qmk4mXVAaK1GKRkwXvCYGeH07wOXaU0gCmrRkUSLigggJGF6scpf9ZiT8sj1Fvi/J8hA7La80tYOhq/EAG9EPu++YHnaxLwSCdX/q0Q3tpzhPjoRXKDvKtplRW8/7xqobr7AZlddnjS98l95ZEIiGopDJynwWKznupkofysP2qneSwDpXSMIuwbByIHVYO9n+uMtWVTBS7C+fLuw1lOIZqFnrl
X-Microsoft-Antispam-PRVS: <BN7PR07MB470758BD787284D7D127FF03DD520@BN7PR07MB4707.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155532106045638)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4707;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;4:tEdaUvLGm6lTWXodgb4/131GPARLDbKb6wJ0GKbVyWWgPgBBM50u8l2c2eUe2DBl1OqmiSlMKlE9Bfs7GasPKmXB26Ru4hAigz01mJajshVI2qAcC0Cpq+KXd+6nbOTBwSX9d3GvxFSQtRXZrg9IBXZwaG/30pSC5Kp8EMq6/bs59wgi8HhhBKL5VqSoR09veGqcTM33Kn4viB4IXS39uxv9RSzZM8d/I7MWLJFCMUcEVz22sibHxBUYb1Sq+7yBUo4uOE/XmSnEecRM0A3pNPg0/97xhX6SglAXA0wgN9vxeizGlzoLEfC38EMAlBenIcgHeUm9f2PKQunMyD4dxaIT2n0wbydgU3URwQgPLAU=
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4707;23:LTNVASR+XHZet8uFMvcmod/CtPvqE91vSfosi/Ym5?=
 =?us-ascii?Q?TXXJ2Rvf5vr87oEKHhLHO95UglNOfnkOqRcFoytyFvYRC0KvNcp4DlGpT+ds?=
 =?us-ascii?Q?aClvu0dfoYmojldYp5XC5cBCyDWdMu75+kOhPOoFbnE3ftSmeiRz0PYm4lwT?=
 =?us-ascii?Q?wOG/A5Wa9baaI1mPv63J6icleSHk2uUFDgx6veAaZr4y8K+dXF57UlrlcoHL?=
 =?us-ascii?Q?Ji5hTvS7mx0xdoo5KCwTTBFkP7L/FQ7bPVK+kRrTtD7ebNBHnCL+0ZI7EFTV?=
 =?us-ascii?Q?cZsYh7+j9LERIIU8OGD8JJJSKANS4R9ee+tZs3ccDI2knj3Ty9oI5ZOXB/ip?=
 =?us-ascii?Q?Id7irSTjFJd/swLGyo3kLbMeOvtSNr8qFPrYN4shcd36eTv0L6PHwro5ChU1?=
 =?us-ascii?Q?LR6kcXlkKf1AEcNRmMgLjvFO6z4Xv2tnbiYSA0TivwtgHmLzXUZdNpHtzUB2?=
 =?us-ascii?Q?ygBcv8bCNHcf88R9Cc4uJO8lrL94S3qxK6QVx4dLolGGCFIUG4sgtNptmXO9?=
 =?us-ascii?Q?1g9L1xm3wPMJTbriUE+i2LOrVxLpY1KRxlfK7FpLiwqTkSZ2EHtunIRcYoD1?=
 =?us-ascii?Q?oaPBYGRLNLVomvnRoIQJoqJ9BhBL+gaX68Z5AW8QH77QWePVV36lDb3ekVoK?=
 =?us-ascii?Q?wslaMaY+HH4/pOR0i2Pr5bobh0jVzEhxrmOdwHaJcZDjVpi3BmgWgpwaZrL3?=
 =?us-ascii?Q?RnLaOT7b4Us9cTeqOTkJ9oYBR3DVDcqLM/2j26osCwxeLjluqFkSpXOyrqvp?=
 =?us-ascii?Q?3qnYCSNxuMdjDtn4UsNK5z61wrs0tQ/BuTnbVfAm61iGplyRI0/kpVFxKRcB?=
 =?us-ascii?Q?yy0gs+f0E2RANsIn1vfQt//hpNWtUoa6mTW1LW4aanppRFk4Q6nyZVl2XrQ0?=
 =?us-ascii?Q?SkMvPv4bnQ4eBDfc654O2cvHj8YKT1Dd/Nfai6zkrOzGVGwCAHpie1hV75ZG?=
 =?us-ascii?Q?PFJmvjPfuGdqNGakjDJsYK9kSUc5k+Kq1CwUjUOj89v/Jwhw/zHumVgUm6n7?=
 =?us-ascii?Q?Ry9Eu4wrTFafHBP8Gh7hdt9GkzuD5/qtKvv0qQV7fxSjNM50+y7+oLsG/0lK?=
 =?us-ascii?Q?B7/ApQvhzncKCmcusLvJc8oGeVkrzCaFfkEmZDjpy+OxIdOh7dch7Tk+nedg?=
 =?us-ascii?Q?9LVfARRBjXrJR/XheaNfZXuojdHKp5Yzgll6V/7gGZR7SwMBIGG0Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: sZRZdpkZhbWX29+WWNndP/PcIHK2E5ArNHUEyarVsSXRcrr/FgE6coNWcQerUMpVeqadH8/lKv+mkpgC0lUUIv+fLdK5Z95y50ikgui3RMkr2qOX+MQMk1WpvRiLNE2oKMn/IuxaWkZ4xvSU6Im0Wpm8cLtFcZCinmbMAG5RchhLtck7nRO/EDXoSP7ldwOFoUxCXEAqLHVqYLj0irn5hA7eXXCDKsTXEjHlgT/v5zusz6HPthKTCikgAeo8PDG01CetHxngv0xjX88vERQyJPvpMXgKWW0ceQUrfLIWi0ENa9aCWHpsmGKKCAngZllOf3Tf9ckV0Lb7fpW/4mFO035EtQ5Nv2R8xuNPnvgf1PgsCcnPutKzVho1Ngj6xzw+j3hQPUuQXgGMWx1UUh1rdg==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;6:trvph5ofU32DAuPa2NsISFEImINuRrllNZvi7LUj3wc6aNoxEiBMFX8dnoagBkZs0184fFKvh4MCkauSwgBIK2g91c9b0oRGoRohXjAeLDTQc3Rolaxo1wp/ScjmdCn+25iajUeLZ+nVdwSDe72Ew6Py+ZT7b/uVkNddOl/7OH92dVdpkvZIs2i8iDLGDJsmIXybSJqVNCekNmzPkbd8VT+3uC3taALSay1EfP5SMwGTHch8YMNRpVa9+vvlXf00VKeQZNeQ7RJdD0zDTZET4jQuPMKp3/2aNJtAep+7gX0hbh7o2+KPku2TO+ylQ3Ech9LxQ+glMTflECmPE6IA+PQocpjVF2HGd76HJemNe/bNFE//RiSzasDlWKcMsLtt6PnKkruwcv1teBPRF79Tb3jQntg+pSXLy3jQ7mqAqic9FYoUVKBcQCML3kFEMougId1AFHIC/Do890K1FMlcUA==;5:T2T8lRxhciba/Z7gXxL59tOhiATM33gzqggNLOkXyQLN3VX8V0NOwMT6TZqu4t8Wden1WhXnecA050EVRM8HNeEg4PY3HQLXY/If+13A9/IsljhWcwm6GYMymq0B32No1lsSiR//uNcS7envEdpU2VtX48cAdU6k4Yo8VG+S0w0=;24:Lmyq7TMHxHtgRlEZ56nexLbjU9Q04N726dms99eOIbL0NIzJtVgjKRQhrHotKX5YUGKsK5WBBXJmUFb2mN8brnKYTijDGHAP2+LPxBqjqGc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;7:e2pkS+icU10HJcWi6oeQXAjcogIYE9yRPqwYd/1qUn7RFlE2GhfllWMV9BBT7PcSkbI6EgbKQbr3W/4YTpJjIM9UopeDfyKVmpeGJ98fAL8vClTCX8WZyuqDkhxzx4vafS17IdcQafiSd0Mvq4eYhYO+VeyPclmIMb4w5naJS+00nWerkRNbXkAjkGSe24BI4PQP6SqO4aadXr68V/Ru1hL2NWTPWkdXLrQwKokgK/CHJbbGHryioJw8KborCQkP;20:Hbqm20YycSZtYXLI4X0745aEht8DaWGWeg8JWWSRGqUi+xHpD3+flKJiPA8YcFnCWKRv1FplXFS7BDKA9MChkIiTB13F1qyOcvL06AKl58qizykPEH35lk6BUWdat26pvnJyHd6X6isyKqb5thA1PVXWJjqJKKBqnSohhjh8nC1D9loUGiVBOhZLetzmsNBYmLXT2aIbG6u4ubKiWFCLG76FhqQhPBOj0r0fapzRKVIk3n6+lo4hcl51NO4mNy9O
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:14.0761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7be1f8-3cf6-44ac-7ae4-08d5eda156c9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4707
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a set of event class. For each event class this patch
defines some trace events.

1. event class: usbssp_log_msg
    - usbssp_dbg_address - debug message used in function handling
	Address Device Command.
    - usbssp_dbg_context_change - debug messages related to contexti
	 updates performed with Configure Endpoint and Evaluate Contexti
	 command.
    - usbssp_dbg_reset_ep - debug messages associated with resetting i
	an endpoint.
    - usbssp_dbg_cancel_request - debug messages related to the removal
	 of a cancelled Request.
    - usbssp_dbg_init - debug messages related to the initialization
	and unload.
    - usbssp_dbg_ring_expansion - debug messages related to ring
	expansion.

2. event class: usbssp_log_ctx
    usbssp_address_ctx - debug message related to address Device command,
    that can be used to display the context data filed.

3. event class: usbssp_log_trb
    - usbssp_handle_event - debug message related to handling Events TRB.
    - usbssp_handle_command - debug message related to handling C
	ommand TRB.
    - usbssp_handle_transfer - debug message related to handling
	Transfer TRB.
    - usbssp_queue_trb - debug message related to queuing TRB.

4. event class: usbssp_log_priv_dev
    This class event  tracing at least part of an usbssp_device lifetime,
    and for now it already exposes quite a bit of valuable information.

    - usbssp_alloc_priv_device - debug message related to allocating
	 device.
    - usbssp_free_priv_device - debug message related to the freeing
	 device.
    - usbssp_setup_addressable_priv_device - debug message related to the
    	initialization of usbssp_device object.
    - usbssp_setup_device - debug message related to Address Device
	command.
    - usbssp_stop_device - debug message related to stooping device.

5. event class: usbssp_log_request
    This will help us figuring out information related to usb_request
    object.

    - usbssp_request_enqueue - debug message used during enqueuing new
	request.
    - usbssp_request_giveback -  debug message related to
	usbssp_request_giveback function
    - usbssp_request_dequeue - debug message related to dequeuing request.
    - usbssp_alloc_request - debug message related to allocation
	new request.
    - usbssp_free_request - debug message related to freeing request.

6. event class: usbssp_log_ep_ctx
    With these event class, we can track what's happening with the
    HW while executing each and every command. It will give us visibility
    into how the endpoint contexts are being modified by controller
    which can bring insight into problems while debugging.

    - usbssp_remove_request - debug message related to removing request.
    - usbssp_handle_cmd_stop_ep - debug message related to Stop Endpointi
	command.
    - usbssp_handle_cmd_set_deq_ep - debug message releted to Set Dequeue
	 Endpoint command,
    - usbssp_handle_cmd_reset_ep - debug message related to Reset Endpoint
	 command.
    - usbssp_handle_cmd_config_ep - debug message related to Endpoint
	Configure command.

7. event class: usbssp_log_slot_ctx
    With these event class, we can track what's happening with the HW
    while executing each and every command. It will give us visibility
    into how the slot contexts are being modified by controller which
    can bring insight into problems while debugging.

    - usbssp_alloc_dev - debug message related to allocating device.
    - usbssp_free_dev - debug message related to freeing device.
    - usbssp_handle_cmd_disable_slot - debug message related to
	Disable Slot command.
    - usbssp_reset_device - debug message related to resetting device.
    - usbssp_setup_device_slot - debug message related to c
	onfiguring slot.
    - usbssp_handle_cmd_addr_dev - debug message related to Address Device
	command.
    - usbssp_handle_cmd_reset_dev - debug message related to Reset Device
	command.
    - usbssp_handle_cmd_set_deq - debug message related to
	Set Dequeue command.
    - usbssp_configure_endpoint - debug message used during configuring
	endpoints.

8. event class: usbssp_log_ring
    This event class defines the events used for tracing the change
    of all kinds of rings used by an usbssp device. An usbssp ring
    is basically a memory block shared between software and hardware.
    By tracing changes of rings, it makes the life easier for.

    - debugging hardware or software problems.
    - usbssp_ring_alloc - debug message related to allocation ring.
    - usbssp_ring_free - debug message related to freeing ring.
    - usbssp_ring_expansion - debug message related with expansion ring.
    - usbssp_inc_enq - debug message related with incrementing
	dequeue pointer.
    - usbssp_inc_deq - debug message related with decrementing
	dequeue pointer.

9. event class: usbssp_log_portsc
    Track the port status each time we get a port status change event.

     - usbssp_handle_port_status - debug message used in
	handle_port_status function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-trace.c |  13 +
 drivers/usb/usbssp/gadget-trace.h | 482 ++++++++++++++++++++++++++++++
 2 files changed, 495 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-trace.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.h

diff --git a/drivers/usb/usbssp/gadget-trace.c b/drivers/usb/usbssp/gadget-trace.c
new file mode 100644
index 000000000000..9994ad09eb4d
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-trace.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp.
+ */
+
+#define CREATE_TRACE_POINTS
+#include "gadget-trace.h"
diff --git a/drivers/usb/usbssp/gadget-trace.h b/drivers/usb/usbssp/gadget-trace.h
new file mode 100644
index 000000000000..667246c344ba
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-trace.h
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM usbssp-dev
+
+/*
+ * The TRACE_SYSTEM_VAR defaults to TRACE_SYSTEM, but must be a
+ * legitimate C variable. It is not exported to user space.
+ */
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR usbssp_dev
+
+#if !defined(__USBSSP_DEV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __USBSSP_DEV_TRACE_H
+
+#include <linux/tracepoint.h>
+#include "gadget.h"
+
+#define USBSSP_DEV_MSG_MAX	500
+
+DECLARE_EVENT_CLASS(usbssp_log_msg,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf),
+	TP_STRUCT__entry(__dynamic_array(char, msg, USBSSP_DEV_MSG_MAX)),
+	TP_fast_assign(
+		vsnprintf(__get_str(msg), USBSSP_DEV_MSG_MAX, vaf->fmt, *vaf->va);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_address,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_context_change,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_reset_ep,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_cancel_request,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_init,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_ring_expansion,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ctx,
+	TP_PROTO(struct usbssp_udc *usbssp_data, struct usbssp_container_ctx *ctx,
+		 unsigned int ep_num),
+	TP_ARGS(usbssp_data, ctx, ep_num),
+	TP_STRUCT__entry(
+		__field(int, ctx_64)
+		__field(unsigned int, ctx_type)
+		__field(dma_addr_t, ctx_dma)
+		__field(u8 *, ctx_va)
+		__field(unsigned int, ctx_ep_num)
+		__field(int, slot_id)
+		__dynamic_array(u32, ctx_data,
+			((HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) + 1) * 8) *
+			((ctx->type == USBSSP_CTX_TYPE_INPUT) + ep_num + 1))
+	),
+	TP_fast_assign(
+		__entry->ctx_64 = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params);
+		__entry->ctx_type = ctx->type;
+		__entry->ctx_dma = ctx->dma;
+		__entry->ctx_va = ctx->bytes;
+		__entry->slot_id = usbssp_data->slot_id;
+		__entry->ctx_ep_num = ep_num;
+		memcpy(__get_dynamic_array(ctx_data), ctx->bytes,
+			((HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) + 1) * 32) *
+			((ctx->type == USBSSP_CTX_TYPE_INPUT) + ep_num + 1));
+	),
+	TP_printk("\nctx_64=%d, ctx_type=%u, ctx_dma=@%llx, ctx_va=@%p",
+			__entry->ctx_64, __entry->ctx_type,
+			(unsigned long long) __entry->ctx_dma, __entry->ctx_va
+	)
+);
+
+DEFINE_EVENT(usbssp_log_ctx, usbssp_address_ctx,
+	TP_PROTO(struct usbssp_udc *usbssp_data, struct usbssp_container_ctx *ctx,
+		 unsigned int ep_num),
+	TP_ARGS(usbssp_data, ctx, ep_num)
+);
+
+
+DECLARE_EVENT_CLASS(usbssp_log_trb,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(u32, field0)
+		__field(u32, field1)
+		__field(u32, field2)
+		__field(u32, field3)
+	),
+	TP_fast_assign(
+		__entry->type = ring->type;
+		__entry->field0 = le32_to_cpu(trb->field[0]);
+		__entry->field1 = le32_to_cpu(trb->field[1]);
+		__entry->field2 = le32_to_cpu(trb->field[2]);
+		__entry->field3 = le32_to_cpu(trb->field[3]);
+	),
+	TP_printk("%s: %s", usbssp_ring_type_string(__entry->type),
+			usbssp_decode_trb(__entry->field0, __entry->field1,
+					__entry->field2, __entry->field3)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_event,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_command,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_transfer,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_queue_trb,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_priv_dev,
+	TP_PROTO(struct usbssp_device *priv_dev),
+	TP_ARGS(priv_dev),
+	TP_STRUCT__entry(
+		__field(struct usbssp_device *, priv_dev)
+		__field(struct usb_gadget *, gadget)
+		__field(unsigned long long, out_ctx)
+		__field(unsigned long long, in_ctx)
+		__field(u8, port_num)
+	),
+	TP_fast_assign(
+		__entry->priv_dev = priv_dev;
+		__entry->gadget = priv_dev->gadget;
+		__entry->in_ctx = (unsigned long long) priv_dev->in_ctx->dma;
+		__entry->out_ctx = (unsigned long long) priv_dev->out_ctx->dma;
+		__entry->port_num = priv_dev->port_num;
+	),
+	TP_printk("priv_dev %p gadget %p ctx %llx | %llx, port %d ",
+		__entry->priv_dev, __entry->gadget, __entry->in_ctx, __entry->out_ctx,
+		__entry->port_num
+	)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_alloc_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_free_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_setup_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_setup_addressable_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_stop_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request),
+	TP_STRUCT__entry(
+		__field(struct usb_request *, request)
+		__field(void *, buf)
+		__field(unsigned int, length)
+		__field(dma_addr_t, dma)
+		__field(struct scatterlist*, sg)
+		__field(unsigned int, num_sgs)
+		__field(unsigned int, num_mapped_sgs)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, no_interrupt)
+		__field(unsigned int, zero)
+		__field(unsigned int, short_not_ok)
+		__field(unsigned int, dma_mapped)
+		__field(int, status)
+		__field(unsigned int, actual)
+	),
+	TP_fast_assign(
+		__entry->request = request;
+		__entry->buf = request->buf;
+		__entry->length = request->length;
+		__entry->dma = request->dma;
+		__entry->sg = request->sg;
+		__entry->num_sgs = request->num_sgs;
+		__entry->num_mapped_sgs = request->num_mapped_sgs;
+		__entry->stream_id = request->stream_id;
+		__entry->no_interrupt = request->no_interrupt;
+		__entry->zero = request->zero;
+		__entry->short_not_ok = request->short_not_ok;
+		__entry->dma_mapped = 0 /*request->dma_mapped*/;
+		__entry->status = request->status;
+		__entry->actual = request->actual;
+	),
+
+	TP_printk("req %p; buf %p, len %d, dma %llx, sg %p, num_sg %d, num_m_sg %d,"
+			"stream_id %d, no_int %x, zero %x, short_not_ok %x, dma_mapped %x, "
+			"status %d, actual %d",
+			__entry->request,
+			__entry->buf, __entry->length, __entry->dma, __entry->sg,
+			__entry->num_sgs, __entry->num_mapped_sgs, __entry->stream_id,
+			__entry->no_interrupt, __entry->zero, __entry->short_not_ok,
+			__entry->dma_mapped, __entry->status, __entry->actual
+		)
+
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_enqueue,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_giveback,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_dequeue,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_alloc_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_free_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ep_ctx,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u64, deq)
+		__field(u32, tx_info)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->ep_info);
+		__entry->info2 = le32_to_cpu(ctx->ep_info2);
+		__entry->deq = le64_to_cpu(ctx->deq);
+		__entry->tx_info = le32_to_cpu(ctx->tx_info);
+	),
+	TP_printk("%s", usbssp_decode_ep_context(__entry->info,
+		__entry->info2, __entry->deq, __entry->tx_info)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_remove_request,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_stop_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_set_deq_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_reset_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_config_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_slot_ctx,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u32, int_target)
+		__field(u32, state)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->dev_info);
+		__entry->info2 = le32_to_cpu(ctx->dev_info2);
+		__entry->int_target = le64_to_cpu(ctx->int_target);
+		__entry->state = le32_to_cpu(ctx->dev_state);
+	),
+	TP_printk("%s", usbssp_decode_slot_context(__entry->info,
+			__entry->info2, __entry->int_target,
+			__entry->state)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_alloc_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_free_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_disable_slot,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_reset_device,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_setup_device_slot,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_addr_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_reset_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_set_deq,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_configure_endpoint,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ring,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(void *, ring)
+		__field(dma_addr_t, enq)
+		__field(dma_addr_t, deq)
+		__field(dma_addr_t, enq_seg)
+		__field(dma_addr_t, deq_seg)
+		__field(unsigned int, num_segs)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, cycle_state)
+		__field(unsigned int, num_trbs_free)
+		__field(unsigned int, bounce_buf_len)
+	),
+	TP_fast_assign(
+		__entry->ring = ring;
+		__entry->type = ring->type;
+		__entry->num_segs = ring->num_segs;
+		__entry->stream_id = ring->stream_id;
+		__entry->enq_seg = ring->enq_seg->dma;
+		__entry->deq_seg = ring->deq_seg->dma;
+		__entry->cycle_state = ring->cycle_state;
+		__entry->num_trbs_free = ring->num_trbs_free;
+		__entry->bounce_buf_len = ring->bounce_buf_len;
+		__entry->enq = usbssp_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
+		__entry->deq = usbssp_trb_virt_to_dma(ring->deq_seg, ring->dequeue);
+	),
+	TP_printk("%s %p: enq %pad(%pad) deq %pad(%pad) segs %d stream %d free_trbs %d bounce %d cycle %d",
+			usbssp_ring_type_string(__entry->type), __entry->ring,
+			&__entry->enq, &__entry->enq_seg,
+			&__entry->deq, &__entry->deq_seg,
+			__entry->num_segs,
+			__entry->stream_id,
+			__entry->num_trbs_free,
+			__entry->bounce_buf_len,
+			__entry->cycle_state
+		)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_alloc,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_free,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_expansion,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_inc_enq,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_inc_deq,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_portsc,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc),
+		TP_STRUCT__entry(
+				__field(u32, portnum)
+				__field(u32, portsc)
+				),
+		TP_fast_assign(
+				__entry->portnum = portnum;
+				__entry->portsc = portsc;
+				),
+		TP_printk("port-%d: %s",
+			__entry->portnum,
+			usbssp_decode_portsc(__entry->portsc)
+			)
+);
+
+DEFINE_EVENT(usbssp_log_portsc, usbssp_handle_port_status,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc)
+);
+
+#endif /* __USBSSP_TRACE_H */
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE gadget-trace
+
+#include <trace/define_trace.h>
-- 
2.17.1

