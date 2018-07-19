Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD97ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D5620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="N0XA+jJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D5620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeGSSop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:45 -0400
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:44714
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732087AbeGSSoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAZT4by06k2NGHpV41t/NCOGGzRYu9ltFBN1xCvnDlI=;
 b=N0XA+jJ3PqyxoFljmvtAAbUPb0T+FxdrVfGhJ4tSswwc0CmsYtbLhtMlDKGil8VGHHhTbUmSsU749gfE4+l1tMAKnfZp37FbDnb/ENmDfOaqHUIiaPDpe3crgNI5og8ZKhncUM4XlEZFCXf8XVc4s/iA7g0Kr0YcdzEvOyO+PWc=
Received: from BYAPR07CA0032.namprd07.prod.outlook.com (2603:10b6:a02:bc::45)
 by BY1PR0701MB1333.namprd07.prod.outlook.com (2a01:111:e400:480f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:17 +0000
Received: from DM3NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by BYAPR07CA0032.outlook.office365.com
 (2603:10b6:a02:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:16 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT045.mail.protection.outlook.com (10.152.98.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARv019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:15 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:26 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:26 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxALB005703;
        Thu, 19 Jul 2018 18:59:10 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxAqF005702;
        Thu, 19 Jul 2018 18:59:10 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 07/31] usb: usbssp: Initialization - added usbssp_mem_init
Date:   Thu, 19 Jul 2018 18:57:40 +0100
Message-ID: <1532023084-28083-8-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(36092001)(36756003)(186003)(50226002)(2616005)(4720700003)(7636002)(1671002)(14444005)(26005)(476003)(486006)(51416003)(126002)(106466001)(76176011)(2906002)(105596002)(336012)(107886003)(575784001)(86362001)(426003)(446003)(8676002)(42186006)(316002)(109986005)(478600001)(54906003)(47776003)(87636003)(16586007)(246002)(8936002)(6666003)(305945005)(4326008)(26826003)(356003)(11346002)(48376002)(5660300001)(50466002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1333;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT045;1:aNxoA6f4sZyXaQxeaq6y0TOpxWuKF4A1kB4dJkQeGa366dlu9+T1f3qStlGL6qHRY0t5y8ipN7DM5wNk4cYOiewduJM9KrIBriZja4WLwAJdpfKc3xZN/JtFKSRJDXVv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c5e1d37-9d2a-4cc8-f4a4-08d5eda15812
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;3:LsvX5cP89qF5k76ed5c9jkA46XQxCuXRcKM/cKHMudJh5RIClXtreOWlRwBiBBcwZBpUKNMyvkGRjZTSQ70SArX6voizubwdZ3exARrO6s/Mkmefwq/8xsNUDm3l2S4lj9rnDoU5rfl1DyscI7nf6ChXChcxb7GkaBPWDKg7FHptanYxWbQQm0lE0WoAvq8oMoj5nB3hko+ObAY6/OLalsQZgRtFjglppJfOmRMQiav/iuzsZhhgXTBHwTY7rMRrPhfGRyiOAw7bYamNB7Biu++0cgxEwcpgQ5tH22JgVpSJYRu+gRahDfjdxuxHay9GXqZ99/bA9/jbGX9vqsf6WLrJKuPq771BppF9MlAS2Lk=;25:kZIpY9xTyxR4SdzOrk9MbQ7GKqmk5OokxcqAL+y2ZgkpvNOC50oSbYoj9Zxwe9B2660zg5chJJTs6AtCS1LjTD7qaCbWNB5n9b/EuFOFwl2q2+YUdBfBkfdlONm8pW3JEokuc/mco30VPTe+K7VS0/Q8R7oAlVtd+JILH5nKe19HkX6Q+LHtCyQSXsPeMD6tZ1Bx6P1XkgtGxxrcrlJ1GRqYExcUnK+6BhReS5fNzqsCCb6HH0jpRNxyIIYPky7Gp/OVHdq6WqGPsSgxAfeDj+3Zoeez4iYrqUEdl11sx0zXJzd5qBSY9/nXEPv90iezo51F6v6blJSFwNe1Gcqrng==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1333:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;31:W4CNfLoKdL0H/yx1ngXe9IxrlXSHVmPrM6P9xWf3rPZYTmeFoNutdzTWMQjAqU58rZd8gJNwPpr0797zVJheWzoqGA+UYnMvHcRabM011BVXsmu74of2pxcq0X+N4oyJEgp9LpAkkcV3kUn72WImfXPPq+pkqvVlOAZ71ScVye8dqBQ1Dz9YTZC6r58bC3EEVPwFGCDDEatS5Gt97ZwOjIQMP4VzTKEpLePpMke9h60=;20:xSUNWu/w8e+Uc8u7Bc1uXJIODj9SuLbYDblAlCnp231LbV77Qs5/WtqJsYOfD4Arg5Xsa6CJ9MAH0wT7G6sz73id14O1R91Tc5ViyUANkXChNPaFFlbsWVllEJcVe4GktZP8ds13z0QR4Wh+37Bx8Vjtkjr437hx1Oh74/mR0RIl/khPiFPTCRWxM/aW1xOYE3YYxJ0K8LTUBKKhfjS4AWOFZfjQuSYWrl+8fCD7KKFfOzufcyto47KzrO1cbcKbH6Sea6FMSamYLVapQqu9Z/AMbGpyd3MYDrwEtgSX2JYR0bpxMsXgwD8yn8wt1YyTD0qIpNcSNXln6kCVAda4cTEpnCTGm289K7+j8qrQFcB+Dy2YYRzgM0j0d6w8GwZZiOtJEuLh0wEvnPrVIxeeVoV5GCQz1CmH1RagrKc/SW3eDpPmyFpl5q4g1HZuNES4uteIVM/zDwuPT8sqEhd+ZUvCsh5k3XWZzybzk+T8hTrG3tYbIrNu6NTUEe77KpCe
X-Microsoft-Antispam-PRVS: <BY1PR0701MB13331B1CCCDFFB6DA1B3F496DD520@BY1PR0701MB1333.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1333;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1333;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;4:9y5tYZLVzk3F5ZcAMXqamfrSAf4JWtUChQUbwppKGmlJ99BteHdXpXDu0S+dJkAp121P/OKNWNEBeMUpDaCE5sdI9t0wCP54uNLYTVM4pR1jfLro4pSkxvpqIl8Ss05IX79uDhalpKnbwJT1o3+0SdwOm45TauQOWq1OGA1rQc8V4ks69afEnVphQ+EEaNKgJYe3AVgB0DjbEQVuksGU80CE2lTzkdVXCFtYSxXfimIXnjasINWZeqfv0DXMzYpMycFpr2DsC2k6EP8WSH5peLMWkI9sMh2fZMp91L9SZbxBxviAdVSe9ETPaj+7ShD1
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1333;23:sniz4w9xKzhcaURI/PyRXWZo4rN3rKSCHOHGA7T?=
 =?us-ascii?Q?UdHPHoHs30vVrIND/MUypcj0AkcFxC9qYKdPzziNAj7ltXQLifMK7IQo6G4V?=
 =?us-ascii?Q?fdNXL0GPmMsFcoM1KIRhlekb/OeIrJv4UBN0LxMCj+EUBgs89acI2GMRFg8g?=
 =?us-ascii?Q?16EZhO+LcmmnE4jPjf1zkv/FhCWRTiJdFbIgzRB1Bku9f7sIytGjAdeJqbGz?=
 =?us-ascii?Q?oVeqYDKkWvlM9vpAOBQZ2d0ozH/ayo/QtGtl/O5dUHUf2o9Tdx2XCpDNbrDy?=
 =?us-ascii?Q?6RMBwgy51x9rTJOYI05b+NRDcEt5fFp1PKarp7t4YOhrt6wYsq/a0RJfLHtL?=
 =?us-ascii?Q?97RXV5+S9uh5M04E0JGx8NxCnLB0snx6Qk90baRxLKIcMqWVB6OZoAV01Wmk?=
 =?us-ascii?Q?a/6PuX1djyi298ZdwLZ08SzbMTF1RenhbG1jeSolX5YmBm0iLLp+pLtPX0EZ?=
 =?us-ascii?Q?t8hKXcQZpnBnVtRdY1iSAWgEQ9XUnpiM6HG7pByr4RwiaPcBAkRnDMnENrc8?=
 =?us-ascii?Q?uy8N5PjOqXSJcfe1M1nsPTPy7qjtRY+0mV3BBCnlNfQrTo19dt/5K3EA6PU8?=
 =?us-ascii?Q?cQ+FiBCyN+wT2jr4NJ2S4nxU+d+UigG2oW3s/NNun62zmXW/OXeDHjKQ6MEX?=
 =?us-ascii?Q?A09nhlrvT8a17JgkP2GTmzAp1QUdWZjk1131HrCyO5TJ2FuSXJSX2xndCbOF?=
 =?us-ascii?Q?HOpMNpM/TXP7S9UzlIAcCdk4m3WZPUQUlCPt/NytM+AkxMi7z/aZxfrOA4wY?=
 =?us-ascii?Q?BH352x7quDh+Y5xuX0Gb0D+pJsB2I4nMDUcSeM+LjPqAeRjac5Qf/6TwyJQ3?=
 =?us-ascii?Q?Kwqg6R2ztbPOEJ/gV1u8uOQaCb6H4fflzpmlmwTEBH/nd+gDrV0ihfyrNzsD?=
 =?us-ascii?Q?Dvjc26btu85ke2JvKrP9YppGuhUIGuenPNn9lMhxQted1LIJ1YyjbJ00mjyb?=
 =?us-ascii?Q?STzmE3/sVhH4WEJmIhWjtd0VRfz1Hi0CQjY9eccdGQvv60akz0meXvPFwtoF?=
 =?us-ascii?Q?xRpzlch8948bT6jATHpXxviFGWY54Lo6xfotC/IL6222GIxL0CTX4RLjJXem?=
 =?us-ascii?Q?8GuhGm71waCC8cfXHfMsPf9Ge+oW0Wi+PH2A44pB0e/JrY1dL7o+4/Y52nvu?=
 =?us-ascii?Q?XephZIYtKdWmKG1ZMWj9RysfNogY+aJlQKeyKMJpu4tu9z2/zgImxz3rfDGl?=
 =?us-ascii?Q?6U0FJHz4i42jEIQY=3D?=
X-Microsoft-Antispam-Message-Info: 7Dy0UbeObxX49hwtzR8A0muhPv7vtCSN0u6aXd1H8pwR/n9/Hkh6/OJMckgOPOIqN9DHkZbUPX9kXkVh9vE9Up7kIMx/hTJ2mK7lv+e8rljkggaRFS0ZEVqWoSRqnB3sD5jP7cOwahyxpekkQeMbcMU3GnjzDrilEIeudW6G+fErf/tk8faeqxCY0CmjtyJ/Fy/Y/2W3xhSp/6QwKbzcbiHBafSvK3N/gIDrNYM0ckAMJc493anTOrovHbqpylvuyD/Qjg84sxkg8DqpACMJMn+9ctudwJ5HpfzI3C/JJdsPSXp9gYyF9oWS8ZJD1M73BO1iaHHuZC9r14ScAzD8dR84lDZd6SX++9zX1LsBz75f2TZfZBS8OSD/vhlBM5pq4HEhAA+Lu9XolvOj2WDzZA==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;6:KCdF387XDpFHz1xOYO+UB1g6GooPvLmiOC/DmzAi+55Fw3V06xrlpMXSd1cst/y/Zu97qMz38yqIRlT2cAzdAPWS8XCYARrJOtkBFOA6jOsTJ+7uOX8aYn8bEdVEp31xuAM0+Gb4hRZGcOq/Umb6cGkUr14DTrkSuveCPXvGmme9YyhaTBdgrqfy3kj6zQNdnBrupF3TW9aXrgVijxbouRC0muxOUpZBcACfzXl8mtvXCjiZhzXyXbqlj2142CCdVAMLcDSUaLnjktXAGauLuRskxHrEKkOuVb0+/Qn5cAtVT/gvVBWVBQwNUkzoRt+Y5WSnJZapHFRSVHtDFSD/MvZX4cd1OdnahSwdEK066pXb0DlZOXGN5TqmcgvumDarPua3bRqj/jIo+eJDxV6mcwtfXeq4rBNsgRIspNRCHDlVKb7iSVzuEDYsyU3+7A80Tq9YwjrJdnSuoBL/BpAXKg==;5:9ymcVM9Sp1kB8UMJb51d7MRYZSu6+hYinrWUbAARW/SpsAT7BqwAlm8emxxxFCRKIY8fugZSiC4BST2QwTsWVHRWi4Yhsva02V+AAAyacloD0p8wSCO6tElcPC/StBJOlupdH2qdAEtqLLRmzMi5icy5EIzCp2V0THV/gLrpkKI=;7:NQg+wCVT7C7Wlvx+CBS15PPQjKy4vjEx8REldZW00B6+URGnrRxNd+p0W1L0juEnzPH8lEfprs9HrJHmH96a0XAE+jjx9VzchjZJElfp5MHViYAzbe7JXZtzBkvTRdnGp47sIa6c02rymTXpVbO5mRzTnB0plcBQqo0NNdNkiWa0/2czwDdYanO2Tqwt4gjbheikPvMOYpSbw/wMEjbhgzmNQKBe9jejp1wIuZtQtKf96X9UCpJQiHHa6CIf/Mo8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1333;20:Ue8DT+1+ttKQYSic/ywuX7jTwPEYtaT9O5hNYrdutXwXxEF80PkhAPAot+1n7M7WgBL1o76Lie01Y7auL2qnPj99TsTBfRwXpab2JkOzw1tXNCgSYsnej1ZhBSyWFiZT87oQNRgdm6WL2z+zl98pPV47izhUbJ0VRYsBrbmkIb+wmkLI1qJVlFf3NJ4ayEZvwmKRE4fbZSa3M4kgDFU3XirBvEd8L9XDbFkolqR9C+dg633yrYFvzPK5K9FhMl/X
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:16.2979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5e1d37-9d2a-4cc8-f4a4-08d5eda15812
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1333
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some stuff regarding initialization of
usbssp driver.

It introduces new file gadget-mem.c which contains
functions responsible for allocating and freeing object
used in driver. It will be gradually expended with
new functionality.

To limits the size of this patch not all functions are
implemented - some of them are empty end will be implemented
in next patch.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Makefile          |   2 +-
 drivers/usb/usbssp/gadget-ext-caps.h |  46 ++
 drivers/usb/usbssp/gadget-mem.c      | 622 +++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget-ring.c     |   6 +
 drivers/usb/usbssp/gadget.c          |   3 +-
 drivers/usb/usbssp/gadget.h          |   5 +
 6 files changed, 681 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/usbssp/gadget-mem.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index 0606f3c63cd0..4f5f12ab6420 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -4,7 +4,7 @@ CFLAGS_gadget-trace.o := -I$(src)
 
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:= usbssp-plat.o gadget-ring.o \
-				   gadget.o
+				   gadget.o gadget-mem.o \
 				    gadget-dbg.o
 
 ifneq ($(CONFIG_TRACING),)
diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
index 86c0ce331037..478cb0b6a098 100644
--- a/drivers/usb/usbssp/gadget-ext-caps.h
+++ b/drivers/usb/usbssp/gadget-ext-caps.h
@@ -54,3 +54,49 @@
 
 /* true: Controller Not Ready to accept doorbell or op reg writes after reset */
 #define USBSSP_STS_CNR			BIT(11)
+
+#include <linux/io.h>
+
+/**
+ * Find the offset of the extended capabilities with capability ID id.
+ *
+ * @base	PCI MMIO registers base address.
+ * @start	address at which to start looking, (0 or HCC_PARAMS to start at
+ *		beginning of list)
+ * @id		Extended capability ID to search for.
+ *
+ * Returns the offset of the next matching extended capability structure.
+ * Some capabilities can occur several times,
+ * e.g., the USBSSP_EXT_CAPS_PROTOCOL, and this provides a way to find them all.
+ */
+
+static inline int usbssp_find_next_ext_cap(void __iomem *base,
+					   u32 start, int id)
+{
+	u32 val;
+	u32 next;
+	u32 offset;
+
+	offset = start;
+	if (!start || start == USBSSP_HCC_PARAMS_OFFSET) {
+		val = readl(base + USBSSP_HCC_PARAMS_OFFSET);
+		if (val == ~0)
+			return 0;
+		offset = USBSSP_HCC_EXT_CAPS(val) << 2;
+		if (!offset)
+			return 0;
+	};
+
+	do {
+		val = readl(base + offset);
+		if (val == ~0)
+			return 0;
+		if (USBSSP_EXT_CAPS_ID(val) == id && offset != start)
+			return offset;
+
+		next = USBSSP_EXT_CAPS_NEXT(val);
+		offset += next << 2;
+	} while (next);
+
+	return 0;
+}
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
new file mode 100644
index 000000000000..11bbf18dacba
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -0,0 +1,622 @@
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
+#include <linux/usb.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include "gadget.h"
+#include "gadget-trace.h"
+
+/**
+ * Create a new ring with zero or more segments.
+ *
+ * Link each segment together into a ring.
+ * Set the end flag and the cycle toggle bit on the last segment.
+ * See section 4.9.1 and figures 15 and 16.
+ */
+static struct usbssp_ring *usbssp_ring_alloc(struct usbssp_udc *usbssp_data,
+					     unsigned int num_segs,
+					     unsigned int cycle_state,
+					     enum usbssp_ring_type type,
+					     unsigned int max_packet,
+					     gfp_t flags)
+{
+	/*TODO: implements function*/
+	return NULL;
+}
+
+struct usbssp_container_ctx *usbssp_alloc_container_ctx(
+					struct usbssp_udc *usbssp_data,
+					int type, gfp_t flags)
+{
+	struct usbssp_container_ctx *ctx;
+
+	if ((type != USBSSP_CTX_TYPE_DEVICE) && (type != USBSSP_CTX_TYPE_INPUT))
+		return NULL;
+
+	ctx = kzalloc(sizeof(*ctx), flags);
+	if (!ctx)
+		return NULL;
+
+	ctx->type = type;
+	ctx->size = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) ? 2048 : 1024;
+	if (type == USBSSP_CTX_TYPE_INPUT)
+		ctx->size += CTX_SIZE(usbssp_data->hcc_params);
+
+	ctx->bytes = dma_pool_zalloc(usbssp_data->device_pool,
+				flags, &ctx->dma);
+
+	if (!ctx->bytes) {
+		kfree(ctx);
+		return NULL;
+	}
+	return ctx;
+}
+
+struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
+					    bool allocate_completion,
+					    gfp_t mem_flags)
+{
+	struct usbssp_command *command;
+
+	command = kzalloc(sizeof(*command), mem_flags);
+	if (!command)
+		return NULL;
+
+	if (allocate_completion) {
+		command->completion =
+			kzalloc(sizeof(struct completion), mem_flags);
+		if (!command->completion) {
+			kfree(command);
+			return NULL;
+		}
+		init_completion(command->completion);
+	}
+
+	command->status = 0;
+	INIT_LIST_HEAD(&command->cmd_list);
+
+	return command;
+}
+
+struct usbssp_command *usbssp_alloc_command_with_ctx(
+						struct usbssp_udc *usbssp_data,
+						bool allocate_completion,
+						gfp_t mem_flags)
+{
+	struct usbssp_command *command;
+
+	command = usbssp_alloc_command(usbssp_data,
+			allocate_completion, mem_flags);
+	if (!command)
+		return NULL;
+
+	command->in_ctx = usbssp_alloc_container_ctx(usbssp_data,
+				USBSSP_CTX_TYPE_INPUT, mem_flags);
+	if (!command->in_ctx) {
+		kfree(command->completion);
+		kfree(command);
+		return NULL;
+	}
+	return command;
+}
+
+void usbssp_request_free_priv(struct usbssp_request *priv_req)
+{
+	if (priv_req)
+		kfree(priv_req->td);
+}
+
+
+int usbssp_alloc_erst(struct usbssp_udc *usbssp_data,
+		      struct usbssp_ring *evt_ring,
+		      struct usbssp_erst *erst,
+		      gfp_t flags)
+{
+	size_t size;
+	unsigned int val;
+	struct usbssp_segment *seg;
+	struct usbssp_erst_entry *entry;
+
+	size = sizeof(struct usbssp_erst_entry) * evt_ring->num_segs;
+	erst->entries = dma_zalloc_coherent(usbssp_data->dev,
+			size, &erst->erst_dma_addr, flags);
+	if (!erst->entries)
+		return -ENOMEM;
+
+	erst->num_entries = evt_ring->num_segs;
+
+	seg = evt_ring->first_seg;
+	for (val = 0; val < evt_ring->num_segs; val++) {
+		entry = &erst->entries[val];
+		entry->seg_addr = cpu_to_le64(seg->dma);
+		entry->seg_size = cpu_to_le32(TRBS_PER_SEGMENT);
+		entry->rsvd = 0;
+		seg = seg->next;
+	}
+
+	return 0;
+}
+
+void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
+{
+	/*TODO: implements functions*/
+}
+
+
+static void usbssp_set_event_deq(struct usbssp_udc *usbssp_data)
+{
+	u64 temp;
+	dma_addr_t deq;
+
+	deq = usbssp_trb_virt_to_dma(usbssp_data->event_ring->deq_seg,
+			usbssp_data->event_ring->dequeue);
+	if (deq == 0 && !in_interrupt())
+		dev_warn(usbssp_data->dev,
+			"WARN something wrong with SW event ring dequeue ptr.\n");
+
+	/* Update USBSSP event ring dequeue pointer */
+	temp = usbssp_read_64(usbssp_data, &usbssp_data->ir_set->erst_dequeue);
+	temp &= ERST_PTR_MASK;
+	/*
+	 * Don't clear the EHB bit (which is RW1C) because
+	 * there might be more events to service.
+	 */
+	temp &= ~ERST_EHB;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"// Write event ring dequeue pointer, preserving EHB bit");
+	usbssp_write_64(usbssp_data, ((u64) deq & (u64) ~ERST_PTR_MASK) | temp,
+			&usbssp_data->ir_set->erst_dequeue);
+}
+
+static void usbssp_add_in_port(struct usbssp_udc *usbssp_data,
+			       unsigned int num_ports,
+			       __le32 __iomem *addr,
+			       int max_caps)
+{
+	u32 temp, port_offset, port_count;
+	int i;
+	u8 major_revision;
+	struct usbssp_ports *rport;
+
+	temp = readl(addr);
+	major_revision = USBSSP_EXT_PORT_MAJOR(temp);
+
+	if (major_revision == 0x03) {
+		rport = &usbssp_data->usb3_rhub;
+	} else if (major_revision <= 0x02) {
+		rport = &usbssp_data->usb2_rhub;
+	} else {
+		dev_warn(usbssp_data->dev, "Ignoring unknown port speed, "
+				"Ext Cap %p, revision = 0x%x\n",
+				addr, major_revision);
+		/* Ignoring port protocol we can't understand. */
+		return;
+	}
+
+	rport->maj_rev = USBSSP_EXT_PORT_MAJOR(temp);
+	rport->min_rev = USBSSP_EXT_PORT_MINOR(temp);
+
+	/* Port offset and count in the third dword.*/
+	temp = readl(addr + 2);
+	port_offset = USBSSP_EXT_PORT_OFF(temp);
+	port_count = USBSSP_EXT_PORT_COUNT(temp);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"Ext Cap %p, port offset = %u, count = %u, revision = 0x%x",
+		addr, port_offset, port_count, major_revision);
+
+	if (port_count > 1) {
+		dev_warn(usbssp_data->dev,
+			"DC support only single port but it detect %d ports",
+			port_count);
+		port_count = 1;
+	}
+
+	/* Port count includes the current port offset */
+	if (port_offset == 0 || (port_offset + port_count - 1) > num_ports)
+		return;
+
+	rport->psi_count = USBSSP_EXT_PORT_PSIC(temp);
+	if (rport->psi_count) {
+		rport->psi = kcalloc(rport->psi_count, sizeof(*rport->psi),
+				GFP_KERNEL);
+		if (!rport->psi)
+			rport->psi_count = 0;
+
+		rport->psi_uid_count++;
+		for (i = 0; i < rport->psi_count; i++) {
+			rport->psi[i] = readl(addr + 4 + i);
+
+			/*
+			 *  count unique ID values, two consecutive entries can
+			 * have the same ID if link is assymetric
+			 */
+			if (i && (USBSSP_EXT_PORT_PSIV(rport->psi[i]) !=
+				  USBSSP_EXT_PORT_PSIV(rport->psi[i - 1])))
+				rport->psi_uid_count++;
+
+			dev_dbg(usbssp_data->dev,
+				"PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
+				USBSSP_EXT_PORT_PSIV(rport->psi[i]),
+				USBSSP_EXT_PORT_PSIE(rport->psi[i]),
+				USBSSP_EXT_PORT_PLT(rport->psi[i]),
+				USBSSP_EXT_PORT_PFD(rport->psi[i]),
+				USBSSP_EXT_PORT_LP(rport->psi[i]),
+				USBSSP_EXT_PORT_PSIM(rport->psi[i]));
+		}
+	}
+
+	/* cache usb2 port capabilities */
+	if (major_revision < 0x03 && usbssp_data->num_ext_caps < max_caps)
+		usbssp_data->ext_caps[usbssp_data->num_ext_caps++] = temp;
+
+	if (major_revision != 0x03) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+				"USBSSP: support USB2 software lpm");
+		usbssp_data->sw_lpm_support = 1;
+		if (temp & USBSSP_HLC) {
+			usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+					"USBSSP: support USB2 hardware lpm");
+			usbssp_data->hw_lpm_support = 1;
+		}
+	}
+
+	usbssp_data->port_array[port_offset-1] = major_revision;
+	if (major_revision == 0x03)
+		usbssp_data->num_usb3_ports++;
+	else
+		usbssp_data->num_usb2_ports++;
+}
+
+/*
+ * Scan the Extended Capabilities for the "Supported Protocol Capabilities" that
+ * specify what speeds each port is supposed to be.
+ */
+static int usbssp_setup_port_arrays(struct usbssp_udc *usbssp_data, gfp_t flags)
+{
+	void __iomem *base;
+	u32 offset;
+	u32 port3offset = 0;
+	u32 port2offset = 0;
+	unsigned int num_ports;
+	int i;
+	int cap_count = 0;
+	u32 cap_start;
+
+	num_ports = HCS_MAX_PORTS(usbssp_data->hcs_params1);
+
+	/*
+	 * USBSSP can support only two ports - one for USB2.0 and
+	 * second for USB3.0
+	 */
+	if (num_ports > MAX_USBSSP_PORTS) {
+		dev_err(usbssp_data->dev,
+			"USBSSP-Dev can't support more then %d ports\n",
+			MAX_USBSSP_PORTS);
+		return -EINVAL;
+	}
+
+	usbssp_data->port_array =
+		kzalloc(sizeof(*usbssp_data->port_array)*num_ports, flags);
+	if (!usbssp_data->port_array)
+		return -ENOMEM;
+
+	base = &usbssp_data->cap_regs->hc_capbase;
+
+	cap_start = usbssp_find_next_ext_cap(base, 0, USBSSP_EXT_CAPS_PROTOCOL);
+	if (!cap_start) {
+		dev_err(usbssp_data->dev,
+			"No Ext. Cap. registers, unable to set up ports\n");
+		return -ENODEV;
+	}
+
+	offset = cap_start;
+
+	/* count extended protocol capability entries for later caching */
+	while (offset) {
+		u32 temp;
+		u8 major_revision;
+
+		temp = readl(base + offset);
+		major_revision = USBSSP_EXT_PORT_MAJOR(temp);
+
+		if (major_revision == 0x03 && port3offset == 0)
+			port3offset = offset;
+		else if (major_revision <= 0x02 && port2offset == 0)
+			port2offset = offset;
+
+		cap_count++;
+
+		offset = usbssp_find_next_ext_cap(base, offset,
+				USBSSP_EXT_CAPS_PROTOCOL);
+	}
+
+	if (cap_count > MAX_USBSSP_PORTS) {
+		dev_err(usbssp_data->dev, "Too many  Ext. Cap. registers\n");
+		return -EINVAL;
+	}
+
+	if (!port3offset &&  !port2offset) {
+		dev_warn(usbssp_data->dev, "No ports on the USBSSP?\n");
+		return -ENODEV;
+	}
+
+	usbssp_data->ext_caps =
+		kzalloc(sizeof(*usbssp_data->ext_caps) * cap_count, flags);
+	if (!usbssp_data->ext_caps)
+		return -ENOMEM;
+
+	/** if exist add USB3 port*/
+	if (port3offset)
+		usbssp_add_in_port(usbssp_data, num_ports,
+				base + port3offset, cap_count);
+
+	/** add USB2 port*/
+	if (port2offset)
+		usbssp_add_in_port(usbssp_data, num_ports,
+				base + port2offset, cap_count);
+
+	if (usbssp_data->num_usb2_ports == 0 &&
+	    usbssp_data->num_usb3_ports == 0) {
+		dev_warn(usbssp_data->dev, "No ports on the USBSSP?\n");
+		return -ENODEV;
+	}
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Found %u USB 2.0 ports and %u USB 3.0 ports.",
+			usbssp_data->num_usb2_ports,
+			usbssp_data->num_usb3_ports);
+
+	/*Only one port USB3.0 and USB2.0 can be supported by USBSSP_DEV*/
+	if (usbssp_data->num_usb3_ports > 1) {
+		dev_err(usbssp_data->dev, "Limiting USB 3.0 ports to 1\n");
+		return -EINVAL;
+	}
+
+	if (usbssp_data->num_usb2_ports > 1) {
+		dev_err(usbssp_data->dev, "Limiting USB 2.0 ports to 1\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Note we could have only USB 3.0 ports, or  USB 2.0 ports.
+	 */
+	if (usbssp_data->num_usb2_ports) {
+		for (i = 0; i < num_ports; i++) {
+
+			if (usbssp_data->port_array[i] == 0x03)
+				continue;
+			usbssp_data->usb2_ports =
+				&usbssp_data->op_regs->port_status_base +
+				NUM_PORT_REGS*i;
+
+			usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+					"USB 2.0 port at index %u, addr = %p",
+					i, usbssp_data->usb2_ports);
+		}
+	}
+
+	if (usbssp_data->num_usb3_ports) {
+
+		for (i = 0; i < num_ports; i++)
+			if (usbssp_data->port_array[i] == 0x03) {
+				usbssp_data->usb3_ports =
+					&usbssp_data->op_regs->port_status_base +
+					NUM_PORT_REGS*i;
+
+				usbssp_dbg_trace(usbssp_data,
+					trace_usbssp_dbg_init,
+					"USB 3.0 port at index %u, addr = %p",
+					i, usbssp_data->usb3_ports);
+			}
+	}
+
+	return 0;
+}
+
+int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags)
+{
+	dma_addr_t	dma;
+	struct device	*dev = usbssp_data->dev;
+	unsigned int	val, val2;
+	u64		val_64;
+	u32 page_size;
+	int i, ret;
+
+	INIT_LIST_HEAD(&usbssp_data->cmd_list);
+
+	/* init command timeout work */
+	INIT_DELAYED_WORK(&usbssp_data->cmd_timer,
+			usbssp_handle_command_timeout);
+	init_completion(&usbssp_data->cmd_ring_stop_completion);
+
+	page_size = readl(&usbssp_data->op_regs->page_size);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Supported page size register = 0x%x", page_size);
+	for (i = 0; i < 16; i++) {
+		if ((0x1 & page_size) != 0)
+			break;
+		page_size = page_size >> 1;
+	}
+	if (i < 16)
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Supported page size of %iK", (1 << (i+12)) / 1024);
+	else
+		dev_warn(usbssp_data->dev, "WARN: no supported page size\n");
+
+	/*
+	 *  Use 4K pages, since that's common and the minimum the
+	 * USBSSP supports
+	 */
+	usbssp_data->page_shift = 12;
+	usbssp_data->page_size = 1 << usbssp_data->page_shift;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"USBSSP page size set to %iK",
+			usbssp_data->page_size / 1024);
+
+	/* In device mode this value should be equal 1*/
+	val = DEV_HCS_MAX_SLOTS(readl(&usbssp_data->cap_regs->hcs_params1));
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// USBSSP can handle at most %d device slots.", val);
+
+	/*device should have only 1 slot*/
+	if (val > DEV_MAX_SLOTS)
+		pr_err("Invalid number of supported slots");
+
+	val2 = readl(&usbssp_data->op_regs->config_reg);
+	val |= (val2 & ~DEV_HCS_SLOTS_MASK);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Setting Max device slots reg = 0x%x.", val);
+	writel(val, &usbssp_data->op_regs->config_reg);
+
+	/*
+	 * Doorbell array must be physically contiguous
+	 * and 64-byte (cache line) aligned.
+	 */
+	usbssp_data->dcbaa = dma_alloc_coherent(dev,
+			sizeof(*usbssp_data->dcbaa), &dma, GFP_KERNEL);
+	if (!usbssp_data->dcbaa)
+		goto fail;
+	memset(usbssp_data->dcbaa, 0, sizeof *(usbssp_data->dcbaa));
+	usbssp_data->dcbaa->dma = dma;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// DCBA array address = 0x%llx (DMA), %p (virt)",
+			(unsigned long long)usbssp_data->dcbaa->dma,
+			usbssp_data->dcbaa);
+	usbssp_write_64(usbssp_data, dma, &usbssp_data->op_regs->dcbaa_ptr);
+
+	/*
+	 * Initialize the ring segment pool.  The ring must be a contiguous
+	 * structure comprised of TRBs.  The TRBs must be 16 byte aligned,
+	 * however, the command ring segment needs 64-byte aligned segments
+	 * and our use of dma addresses in the trb_address_map radix tree needs
+	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
+	 */
+	usbssp_data->segment_pool = dma_pool_create("USBSSP ring segments", dev,
+			TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE,
+			usbssp_data->page_size);
+
+	usbssp_data->device_pool =
+			dma_pool_create("USBSSP input/output contexts", dev,
+					2112, 64, usbssp_data->page_size);
+	if (!usbssp_data->segment_pool || !usbssp_data->device_pool)
+		goto fail;
+
+	/*
+	 * Linear stream context arrays don't have any boundary restrictions,
+	 * and only need to be 16-byte aligned.
+	 */
+	usbssp_data->small_streams_pool =
+			dma_pool_create("USBSSP 256 byte stream ctx arrays",
+					dev, SMALL_STREAM_ARRAY_SIZE, 16, 0);
+	usbssp_data->medium_streams_pool =
+			dma_pool_create("USBSSP 1KB stream ctx arrays",
+					dev, MEDIUM_STREAM_ARRAY_SIZE, 16, 0);
+
+	/*
+	 * Any stream context array bigger than MEDIUM_STREAM_ARRAY_SIZE
+	 * will be allocated with dma_alloc_coherent()
+	 */
+	if (!usbssp_data->small_streams_pool ||
+	    !usbssp_data->medium_streams_pool)
+		goto fail;
+
+	/* Set up the command ring to have one segments for now. */
+	usbssp_data->cmd_ring = usbssp_ring_alloc(usbssp_data, 1, 1,
+			TYPE_COMMAND, 0, flags);
+	if (!usbssp_data->cmd_ring)
+		goto fail;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Allocated command ring at %p", usbssp_data->cmd_ring);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"First segment DMA is 0x%llx",
+			(unsigned long long)usbssp_data->cmd_ring->first_seg->dma);
+
+	/* Set the address in the Command Ring Control register */
+	val_64 = usbssp_read_64(usbssp_data, &usbssp_data->op_regs->cmd_ring);
+	val_64 = (val_64 & (u64) CMD_RING_RSVD_BITS) |
+		(usbssp_data->cmd_ring->first_seg->dma & (u64) ~CMD_RING_RSVD_BITS) |
+		usbssp_data->cmd_ring->cycle_state;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Setting command ring address to 0x%x", val_64);
+	usbssp_write_64(usbssp_data, val_64, &usbssp_data->op_regs->cmd_ring);
+
+	val = readl(&usbssp_data->cap_regs->db_off);
+	val &= DBOFF_MASK;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Doorbell array is located at offset 0x%x"
+			" from cap regs base addr", val);
+	usbssp_data->dba = (void __iomem *) usbssp_data->cap_regs + val;
+
+	/* Set ir_set to interrupt register set 0 */
+	usbssp_data->ir_set = &usbssp_data->run_regs->ir_set[0];
+
+	/*
+	 * Event ring setup: Allocate a normal ring, but also setup
+	 * the event ring segment table (ERST).
+	 */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Allocating event ring");
+	usbssp_data->event_ring = usbssp_ring_alloc(usbssp_data,
+			ERST_NUM_SEGS, 1, TYPE_EVENT, 0, flags);
+	if (!usbssp_data->event_ring)
+		goto fail;
+
+	ret = usbssp_alloc_erst(usbssp_data, usbssp_data->event_ring,
+			&usbssp_data->erst, flags);
+	if (ret)
+		goto fail;
+
+	/* set ERST count with the number of entries in the segment table */
+	val = readl(&usbssp_data->ir_set->erst_size);
+	val &= ERST_SIZE_MASK;
+	val |= ERST_NUM_SEGS;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Write ERST size = %i to ir_set 0 (some bits preserved)",
+			val);
+	writel(val, &usbssp_data->ir_set->erst_size);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Set ERST entries to point to event ring.");
+
+	/* set the segment table base address */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Set ERST base address for ir_set 0 = 0x%llx",
+			(unsigned long long)usbssp_data->erst.erst_dma_addr);
+	val_64 = usbssp_read_64(usbssp_data, &usbssp_data->ir_set->erst_base);
+	val_64 &= ERST_PTR_MASK;
+	val_64 |= (usbssp_data->erst.erst_dma_addr & (u64) ~ERST_PTR_MASK);
+	usbssp_write_64(usbssp_data, val_64, &usbssp_data->ir_set->erst_base);
+
+	/* Set the event ring dequeue address */
+	usbssp_set_event_deq(usbssp_data);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Wrote ERST address to ir_set 0.");
+
+	if (usbssp_setup_port_arrays(usbssp_data, flags))
+		goto fail;
+
+	return 0;
+
+fail:
+	dev_warn(usbssp_data->dev, "Couldn't initialize memory\n");
+	usbssp_halt(usbssp_data);
+	usbssp_reset(usbssp_data);
+	usbssp_mem_cleanup(usbssp_data);
+	return -ENOMEM;
+}
+
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index d1da59306d02..69cf478c222b 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -46,3 +46,9 @@ irqreturn_t usbssp_irq(int irq, void *priv)
 	spin_unlock_irqrestore(&usbssp_data->lock, flags);
 	return ret;
 }
+
+
+void usbssp_handle_command_timeout(struct work_struct *work)
+{
+	/*TODO: implements function*/
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 195f5777cf8a..534fb75740f7 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -195,8 +195,7 @@ int usbssp_init(struct usbssp_udc *usbssp_data)
 	spin_lock_init(&usbssp_data->lock);
 	spin_lock_init(&usbssp_data->irq_thread_lock);
 
-	/*TODO: memory initialization*/
-	//retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
+	retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
 
 	return retval;
 }
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 5d8918f8da84..4a9a1ca2e9b5 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1682,12 +1682,16 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 		void (*trace)(struct va_format *),
 		const char *fmt, ...);
+/* USBSSP memory management */
+void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
+int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
 /* USBSSP Device controller glue */
 void usbssp_bottom_irq(struct work_struct *work);
 int usbssp_init(struct usbssp_udc *usbssp_data);
 void usbssp_stop(struct usbssp_udc *usbssp_data);
 int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void usbssp_quiesce(struct usbssp_udc *usbssp_data);
+int usbssp_halt(struct usbssp_udc *usbssp_data);
 extern int usbssp_reset(struct usbssp_udc *usbssp_data);
 
 int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
@@ -1698,6 +1702,7 @@ irqreturn_t usbssp_irq(int irq, void *priv);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 				union usbssp_trb *trb);
+void usbssp_handle_command_timeout(struct work_struct *work);
 
 /* USBSSP gadget interface*/
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
-- 
2.17.1

