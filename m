Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E17D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZdvuqhTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E17D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbeGSSnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:45 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:53956
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732498AbeGSSnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOqdNrkdooP0f9d9fIJbFP1BKltT8yHxDloMJPrd2WQ=;
 b=ZdvuqhTy9eig2ps/jy82Fdsm+3ODH7YLufCgbWQ0bcQmf/nr86wpXeH5TIWXd95Kz7XrhkODwG19yh90xhy9qLh6RA3i2RTT+Ee7OLUD5fiMPD73rPl8ue5sGfQvbrlMgjksaDN13qzGl5stop1TeULqKXCAh0b9g4hnByHEX2o=
Received: from SN4PR0701CA0019.namprd07.prod.outlook.com
 (2603:10b6:803:28::29) by BYAPR07MB4712.namprd07.prod.outlook.com
 (2603:10b6:a02:f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:14 +0000
Received: from DM3NAM05FT026.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by SN4PR0701CA0019.outlook.office365.com
 (2603:10b6:803:28::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:14 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT026.mail.protection.outlook.com (10.152.98.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARq019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:12 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:25 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:25 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHx9dA005630;
        Thu, 19 Jul 2018 18:59:09 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHx9YI005626;
        Thu, 19 Jul 2018 18:59:09 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Date:   Thu, 19 Jul 2018 18:57:35 +0100
Message-ID: <1532023084-28083-3-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(43544003)(36092001)(189003)(199004)(54906003)(11346002)(36756003)(48376002)(6666003)(1671002)(126002)(86362001)(4720700003)(316002)(16586007)(109986005)(107886003)(486006)(426003)(14444005)(2616005)(476003)(446003)(336012)(42186006)(76176011)(50226002)(105596002)(106466001)(26005)(186003)(4326008)(26826003)(47776003)(50466002)(551934003)(87636003)(478600001)(246002)(8936002)(5660300001)(8676002)(2906002)(356003)(7636002)(305945005)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT026;1:7LVL1xGYsXb7kWuI8F/uN3gKeldI3FYafJDtjMA1r0TyF80yH4KXLa3MkGf5d49GO/cU27k3gewGB6xQhUfSDh/nWNdRyW4TcaIa45GrkXHMuKb3ePVcrtfFkXtF5T4S
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2570b47-fc41-4f0d-fd23-08d5eda15688
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;3:HYsuzk7/uQHOzxjdQWP8KbTXQYm3DxdAI5HBItqKhf4t6C52feUR4TgcR1oNZqRzPzjjPaEVvdMAfLs7Cy/LEAYy87dIJttj6ZVP+SXNcRsajUpK2h7NQvWGw5rbmc6F5tnaso/biQh0Qef1ypTM+Kr3pQsEdjC4vUyeeIXpTLKIKel8+MkMUrGBK8eVWpT9v8lO4umjz3h6zoTF4B2Vx0jyTxnS8bS28p5gEE8rbsula9bDQJBdrQx5YmcxQlY1D4+W5BtA5MfRXjBZpAcDHK9zpGzi9oPd5Kuf5sASvFBYbO9eHKOnz73j2cXHUPa21nlU6KnJ1LqoqHB0manmgNSjEGf8VYWNZOyS15ZGHII=;25:WJYQ2tLnhzHhG+hEkLWQzlS1Vkd7gz4L/KDJGhFDSKxGJcOUt3gJFoSI7y7IYvPYQAohn4VJr9Yc9qSg/GtZdjndNLkBsNyrAHOMqb7S3aXD9TqvL8sVjPplLwtYiYKF+e+AETF1KhoyKvXWHvsIRL58DfrVsuTSSt3c76wZ5XiD6PMBk9Eg+y99DKxhtuYxV6MUhmz3GDgHTSqe9IRV4R06vsuH/NQ7YExiPk5pnxd4sM9wcpl69GkOTO77eY1mpl3zoovwmUbmlaPR6rg9uM7dBeaMNgDDMR8EhoE45gZuaMRypnD3aNVeC6p/AsZUM55lI0lF8VQ7yryfZfYiTQ==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4712:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;31:ZfGzyYY49PniPmxMc1a/wGB4QQfbMik0hZKW18TtyRcLjK9CxPhdBxUIpl98xrnwkX/L7otzXnc2hRrQ3E+01i1lVDR6LPhNewmJm3OEphyip9PeGXy9+Wy654t7LHrjg8Ga1bIXFYEidVjCp2UJcyz2t04Rm7cO84QHdqxSvM7eYtxi4OrMMpXs0HRgWjzZj1jV4W1ElSfojKXpAkR0MhCo+IOd/Rm93WOIzDqC3F0=;20:9VE70OqRmb/2iXJLJebK1eMRW2kZLsShgGvSsQEOj6tcEyrEu1QuJLd1ZPrAk+XR22XuEGB4djKGyunxQnVn2ScYnItVJ6YJPyh6cUDqKmp2+y6ykYaii2H7RMrywqprt24TIjfwYOTuCxY/905sB9hffMKxSgSvf34cEacUYC1HcvzUcVLY9Qm1x+6hVsfVu4qDFmu+BD9unjIi03lkiO7pdPvFZJgOEGNKF9hRPDxu8+L2nMmaow9vluyzGCsk5p+tBwa0IGbKciTnkIKoD/YmeaO6MJ1K9pX3V4FsLFrr/j0Ieox8C5R9nWk/JrG48lfUM9uts0uXruKm7/2oxKX3eKc6NKvqIY+Nylwdj/2Xr7VF+ArfbfOPI1+fUiJi3J+fzScf+K31omOjx+RmPn5WOVwn5wWF3kBs+gyAhQppHy9v84XcetMQltqLUiWm17NqFf8tqb0zC6TMCtwX2lIqfNRKy+mM+J/xjzWou95NAfnNBLt5++kd6je80qgL
X-Microsoft-Antispam-PRVS: <BYAPR07MB471270FDC14F264EE352BEF0DD520@BYAPR07MB4712.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93003095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4712;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;4:RhyoKoF5l+j2Nfa0shFU2p5KvFROTIIt3ah5JxsMGGQZYXYgp6taA+LT7iUjgz3KNYKbEcHfR2z8Om73H3C2VC30HwY4Vuwi4iizmRYneJrgbs6eBW83PuniqQpWl9QOPF9D1R35CTK9iEUpcpxC7hbh6Ux6RYUnRZN9uz7sH8T4+QjAfC5PQCjrR7Nzt1jvuzU8m4wbNhSuFR8hHevEoPIdOI4CFpNYrOyCSn2KM4Tr3+DifgaO8TKW1XEN+8yjcMXCk4OgS/7vuuuPxtwbhL5hFB1xuFf3qf7xMD9nyhvzf161JGLv9ElteAQED+pa
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4712;23:ANr4Hw/1rsjzETTW7UsOoYb7utkN5cbxwITxWLKQJ?=
 =?us-ascii?Q?78FV7N7B1L3lIFI3U9FcIOFdwBZIoRwIr20ykup/uMfD62BweQ6//eZSGBmL?=
 =?us-ascii?Q?7Ap3ei/wAYBrT0VltoTuHxO50tT79Sgl7WgllFhPIbes86VEMKQohMFAQ6L0?=
 =?us-ascii?Q?4Z+a6I6zA28s40kK1B/MiI2ovPxVBtinaXZJYa3WKDXJ+87xiB2CwHInv10m?=
 =?us-ascii?Q?U59OLYqgYTNlVEvGylyYOq1Iv45o6urQHEnZ4ETWvh4FZ1JbzYJILZDMIQ/A?=
 =?us-ascii?Q?4JxcXBU0kJBI+9tkwfYU0002jo/1W2OSNrzlUbmtcuRj14Db2+eE2J4sO8T+?=
 =?us-ascii?Q?JwRo318TgMVmrZqgQjb5qeh5rt5nfRJYrXBtbzM8Pn/zZ/sTTETY5I2Sa6uX?=
 =?us-ascii?Q?rJlccTjK92WPZdDnwrk9wnHmj4xY6AvPJeBZpQMCpLSkJ99QymuFazSM9Lkw?=
 =?us-ascii?Q?OPve13OEPsJnHffeWJb4CQcxQvdqy67w5GHx2kRUpWHQIsiBdOUcW71OBysD?=
 =?us-ascii?Q?EAN/DKcB9Sa7GbV29licteGbVHbi3MUV1WFqeiyFQbDDUUZVg4n96oO7TH1l?=
 =?us-ascii?Q?H60Jrx1+f7NUg39bkT0WImZ7365pu3bPB9hI64wD1Uo6OmF62iGffqgLRTRD?=
 =?us-ascii?Q?E1qOyy0E5SPNormdgCTyibq0x6DtOilk+WPWNFAJg1mJBVJ3nmoz3Jfw2d9a?=
 =?us-ascii?Q?g7Xby8IvThQTktaz+rnO3JprYMOwwCV2/g9SAcz3kC1PIM83Kuwt+IY+mOMB?=
 =?us-ascii?Q?ih++6yOKIaWjyq7Ym5XuFP7gko+mbzWE65+KWb1qG2CglhlaEgBoSYc+ARZD?=
 =?us-ascii?Q?p+oQASQJai4Azm6C4MgUX3SBZcuoQdw1LGsY4TBzafgEHHBzx50ta0D8y/xI?=
 =?us-ascii?Q?jjr6eSNJPwXM8/VD2X4nnrk28oWymovChl5h3R+qGoRZtUHlVePtOFkjYeFn?=
 =?us-ascii?Q?K9DQ6HE1ReShaZzj40wxSQxJh/pVjz0hSK76mi40i4vtml2AdIn7RM3NGFDi?=
 =?us-ascii?Q?d3WSMiYuFpp7F2J77AwAo82uXgCyMyrCypGCDz0CZJS/AD9LsL31CPFZWx2R?=
 =?us-ascii?Q?GXPu4iBugkRuB6CZyjlkGc8PXM82IyPu4WM1H2zE49+TMGB2TzoXhH7fKNex?=
 =?us-ascii?Q?fECTf7xNBwASj7FLnbhv+2FsO9JhVMToZr/1gSyJC5GRa9kdW0Zeq2pq1tKa?=
 =?us-ascii?Q?BCkMjDOnRpc4PwhuyMo0wKcG0GlnhZBW93X?=
X-Microsoft-Antispam-Message-Info: miLGv3qsaNgNoaM/FOBftnbljgEbUuHVu0t+XiwnUT86gfRx54ARktx3XTqBYg+0ZdjBoKBz6mSrtO2C1hqWNuKoS6g4COTydtoio/oWp+5lJSknJ5AG2chBQDO4hjtT04OTNJHkvqty8SfinbPMDGbzcJCNqj0VojlZCdHmt9yx4iRHu5ifgLrf6m2uqS6+rDionsSeNUENO6qk8DwsBOX8sVp90juBOKtfGsMZvjvjvQuzfnk7ohNNsMcWdp6i8+pFVPfmUReG7vxanTRW2aFX+Gv/wrUMft+nDOFgo8gvs1L6Xxlx9c4xCjAJCh+Ye837ufbF9qVkXMypvchsCtN+6h5nkjRMWSTu1Gu/ZLwcSigOWlQfdouHOLqJ/R7Fbk+pfPzhsc1I5fyiwVSVrw==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;6:OKbVcIu8CC9SBQoPW99mkILvzXiFbQAxRsDYXlpJL9lXrX3jA5paIYiOTHj1CZDykInLwroeKImcxAChXO2imrSVpCad71O/EVcCGnrc4scIataYxpvQv6vue8eADu9z9GTltBnj+sI2mGyqjHZXLHj8Rn3tHWx8aogN4vLFN11XVYk3+lBJG65/hGsPh2a5z7fTRU2Z/S9nJhkeozg4v68U4wIDlbd5arDyLlZM9Dclk81iaUjPzSOLMWrjIMIcVfJSYwEAXW+rLiawzahh5TwWpCUgpMeTEc5qn4yYFFdqFQO599zBOb/jWVYBmEbBjNiUNByaHiThYlCJlQQeIOHZaBYpAW5XKNfX98rlOwTBCC51N/fKwAOC1jNKV+xs6kdxtHpIhI/hzDHpSTo+lFQ+iAmVFr5sEcBf6BYjI0Jlias22eww7VvP4A8VvqzdmNNneef5c+7l3K4Pn2mjkw==;5:yTUPcVl3GDh8eus2TlHcNjwx2fSaIRcM3G6rN8PJ8znLBrSyFQUCvLdGpno02Fh8PknS9aa+o5bTKAOvACUqTajDblBj++sjt9n/1M0lUNYlRWnVc+tnxrwBRdG+kCThccaeQ+R6JAgQeT5PjaRQmRTcTsIF2kHy2ZnXMzlAD8M=;7:NqpgDtof2WIYP9xwjTXyy5pnXcpdSljXsOfpB8BkZMDYe07XOWuM8mN3ns6XhZl0fK7HworCSYRvq/tPzOElh12EMulLhD7Gsp34AaNsIy8vDtKXDfj5IMpEUYEnX6MSrjK58JvXq0C3TE2JtvU2NoXIq4XBl13RAeVQmRamNtTXp0YSlustbZIqp20J73hf9O0wSgay7L5qAUeS8+JZ+ZvuEj3Uv9OiWs06YY3GiJXyvv7NHm7wyOC0ZciPN85N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;20:w7mWHSLJZOvTVQoMn67EcAaLNKG3n2MpEQawP7yJm1o9WizQ6XlvIwrIuxcqf01JY0IU8Z8IFt6YxuWPxnq3K2iFNwpRm/1PaM4UOw0z/99ugx0w9tOIUmX+qVcSJIpTWzrcWCgzVcVYvKPJwwmfm1U4qyNIBWA+RW7nEnzZwyABZRFV3DCpC7G3SqWyl/4iA9l2ChgdndBzXRk/+CK/3UKw/vZq8ylmd25VKBaOSl4LPc6fozFwfV8d6kUFobJ6
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:13.7160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2570b47-fc41-4f0d-fd23-08d5eda15688
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add additional functions that converts some fields to string.

For example function usbssp_trb_comp_code_string take completion
code value and return string describing completion code.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget.h | 580 ++++++++++++++++++++++++++++++++++++
 1 file changed, 580 insertions(+)

diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 49e7271187cc..b5c17603af78 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -930,6 +930,73 @@ struct usbssp_transfer_event {
 #define COMP_UNDEFINED_ERROR			33
 #define COMP_INVALID_STREAM_ID_ERROR		34
 
+static inline const char *usbssp_trb_comp_code_string(u8 status)
+{
+	switch (status) {
+	case COMP_INVALID:
+		return "Invalid";
+	case COMP_SUCCESS:
+		return "Success";
+	case COMP_DATA_BUFFER_ERROR:
+		return "Data Buffer Error";
+	case COMP_BABBLE_DETECTED_ERROR:
+		return "Babble Detected";
+	case COMP_USB_TRANSACTION_ERROR:
+		return "USB Transaction Error";
+	case COMP_TRB_ERROR:
+		return "TRB Error";
+	case COMP_RESOURCE_ERROR:
+		return "Resource Error";
+	case COMP_NO_SLOTS_AVAILABLE_ERROR:
+		return "No Slots Available Error";
+	case COMP_INVALID_STREAM_TYPE_ERROR:
+		return "Invalid Stream Type Error";
+	case COMP_SLOT_NOT_ENABLED_ERROR:
+		return "Slot Not Enabled Error";
+	case COMP_ENDPOINT_NOT_ENABLED_ERROR:
+		return "Endpoint Not Enabled Error";
+	case COMP_SHORT_PACKET:
+		return "Short Packet";
+	case COMP_RING_UNDERRUN:
+		return "Ring Underrun";
+	case COMP_RING_OVERRUN:
+		return "Ring Overrun";
+	case COMP_VF_EVENT_RING_FULL_ERROR:
+		return "VF Event Ring Full Error";
+	case COMP_PARAMETER_ERROR:
+		return "Parameter Error";
+	case COMP_CONTEXT_STATE_ERROR:
+		return "Context State Error";
+	case COMP_EVENT_RING_FULL_ERROR:
+		return "Event Ring Full Error";
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		return "Incompatible Device Error";
+	case COMP_MISSED_SERVICE_ERROR:
+		return "Missed Service Error";
+	case COMP_COMMAND_RING_STOPPED:
+		return "Command Ring Stopped";
+	case COMP_COMMAND_ABORTED:
+		return "Command Aborted";
+	case COMP_STOPPED:
+		return "Stopped";
+	case COMP_STOPPED_LENGTH_INVALID:
+		return "Stopped - Length Invalid";
+	case COMP_STOPPED_SHORT_PACKET:
+		return "Stopped - Short Packet";
+	case COMP_MAX_EXIT_LATENCY_TOO_LARGE_ERROR:
+		return "Max Exit Latency Too Large Error";
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		return "Isoch Buffer Overrun";
+	case COMP_EVENT_LOST_ERROR:
+		return "Event Lost Error";
+	case COMP_UNDEFINED_ERROR:
+		return "Undefined Error";
+	case COMP_INVALID_STREAM_ID_ERROR:
+		return "Invalid Stream ID Error";
+	default:
+		return "Unknown!!";
+	}
+}
 struct usbssp_link_trb {
 	/* 64-bit segment pointer*/
 	__le64 segment_ptr;
@@ -1292,6 +1359,27 @@ enum usbssp_ring_type {
 	TYPE_EVENT,
 };
 
+static inline const char *usbssp_ring_type_string(enum usbssp_ring_type type)
+{
+	switch (type) {
+	case TYPE_CTRL:
+		return "CTRL";
+	case TYPE_ISOC:
+		return "ISOC";
+	case TYPE_BULK:
+		return "BULK";
+	case TYPE_INTR:
+		return "INTR";
+	case TYPE_STREAM:
+		return "STREAM";
+	case TYPE_COMMAND:
+		return "CMD";
+	case TYPE_EVENT:
+		return "EVENT";
+	}
+
+	return "UNKNOWN";
+}
 struct usbssp_ring {
 	struct usbssp_segment	*first_seg;
 	struct usbssp_segment	*last_seg;
@@ -1568,4 +1656,496 @@ struct usbssp_udc {
 
 #define USBSSP_CFC_DELAY	10
 
+
+/*
+ * Registers should always be accessed with double word or quad word accesses.
+ *
+ * Registers with 64-bit address pointers should be written to with
+ * dword accesses by writing the low dword first (ptr[0]), then the high dword
+ * (ptr[1]) second. DC implementations that do not support 64-bit address
+ * pointers will ignore the high dword, and write order is irrelevant.
+ */
+static inline u64 usbssp_read_64(const struct usbssp_udc *usbssp_data,
+				__le64 __iomem *regs)
+{
+	return lo_hi_readq(regs);
+}
+
+static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
+				const u64 val, __le64 __iomem *regs)
+{
+	lo_hi_writeq(val, regs);
+}
+static inline char *usbssp_slot_state_string(u32 state)
+{
+	switch (state) {
+	case SLOT_STATE_ENABLED:
+		return "enabled/disabled";
+	case SLOT_STATE_DEFAULT:
+		return "default";
+	case SLOT_STATE_ADDRESSED:
+		return "addressed";
+	case SLOT_STATE_CONFIGURED:
+		return "configured";
+	default:
+		return "reserved";
+	}
+}
+
+static inline const char *usbssp_decode_trb(u32 field0, u32 field1, u32 field2,
+					u32 field3)
+{
+	static char str[256];
+	int type = TRB_FIELD_TO_TYPE(field3);
+
+	switch (type) {
+	case TRB_LINK:
+		sprintf(str,
+			"LINK %08x%08x intr %d type '%s' flags %c:%c:%c:%c",
+			field1, field0, GET_INTR_TARGET(field2),
+			usbssp_trb_type_string(type),
+			field3 & TRB_IOC ? 'I' : 'i',
+			field3 & TRB_CHAIN ? 'C' : 'c',
+			field3 & TRB_TC ? 'T' : 't',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_TRANSFER:
+	case TRB_COMPLETION:
+	case TRB_PORT_STATUS:
+	case TRB_DOORBELL:
+	case TRB_HC_EVENT:
+	case TRB_DEV_NOTE:
+	case TRB_MFINDEX_WRAP:
+		sprintf(str,
+			"TRB %08x%08x status '%s' len %d slot %d ep %d:=:"
+			"type '%s' flags %c:%c",
+			field1, field0,
+			usbssp_trb_comp_code_string(GET_COMP_CODE(field2)),
+			EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			usbssp_trb_type_string(type),
+			field3 & EVENT_DATA ? 'E' : 'e',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+
+		break;
+	case TRB_SETUP:
+		sprintf(str, "bRequestType %02x bRequest %02x wValue %02x%02x "
+				"wIndex %02x%02x wLength %d length %d "
+				"TD size %d intr %d type '%s' flags %c:%c:%c",
+				field0 & 0xff,
+				(field0 & 0xff00) >> 8,
+				(field0 & 0xff000000) >> 24,
+				(field0 & 0xff0000) >> 16,
+				(field1 & 0xff00) >> 8,
+				field1 & 0xff,
+				(field1 & 0xff000000) >> 16 |
+				(field1 & 0xff0000) >> 16,
+				TRB_LEN(field2), GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				usbssp_trb_type_string(type),
+				field3 & TRB_IDT ? 'I' : 'i',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_DATA:
+		sprintf(str, "Buffer %08x%08x length %d TD size %d intr %d "
+				"type '%s' flags %c:%c:%c:%c:%c:%c:%c",
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				usbssp_trb_type_string(type),
+				field3 & TRB_IDT ? 'I' : 'i',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_STATUS:
+		sprintf(str, "Buffer %08x%08x length %d TD size %d intr"
+				"%d type '%s' flags %c:%c:%c:%c",
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				usbssp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_NORMAL:
+	case TRB_ISOC:
+	case TRB_EVENT_DATA:
+	case TRB_TR_NOOP:
+		sprintf(str,
+			"Buffer %08x%08x length %d TD size %d intr %d "
+			"type '%s' flags %c:%c:%c:%c:%c:%c:%c:%c",
+			field1, field0, TRB_LEN(field2), GET_TD_SIZE(field2),
+			GET_INTR_TARGET(field2),
+			usbssp_trb_type_string(type),
+			field3 & TRB_BEI ? 'B' : 'b',
+			field3 & TRB_IDT ? 'I' : 'i',
+			field3 & TRB_IOC ? 'I' : 'i',
+			field3 & TRB_CHAIN ? 'C' : 'c',
+			field3 & TRB_NO_SNOOP ? 'S' : 's',
+			field3 & TRB_ISP ? 'I' : 'i',
+			field3 & TRB_ENT ? 'E' : 'e',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+
+	case TRB_CMD_NOOP:
+	case TRB_ENABLE_SLOT:
+		sprintf(str,
+			"%s: flags %c",
+			usbssp_trb_type_string(type),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_DISABLE_SLOT:
+		sprintf(str,
+			"%s: slot %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_ADDR_DEV:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d flags %c:%c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_BSR ? 'B' : 'b',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_CONFIG_EP:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d flags %c:%c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_DC ? 'D' : 'd',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_EVAL_CONTEXT:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_RESET_EP:
+	case TRB_HALT_ENDPOINT:
+	case TRB_FLUSH_ENDPOINT:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d ep %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_STOP_RING:
+		sprintf(str,
+			"%s: slot %d sp %d ep %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_SLOT_ID(field3),
+			TRB_TO_SUSPEND_PORT(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_SET_DEQ:
+		sprintf(str,
+			"%s: deq %08x%08x stream %d slot %d ep %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_STREAM_ID(field2),
+			TRB_TO_SLOT_ID(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_RESET_DEV:
+		sprintf(str,
+			"%s: slot %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_FORCE_EVENT:
+		sprintf(str,
+			"%s: event %08x%08x vf intr %d vf id %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_VF_INTR_TARGET(field2),
+			TRB_TO_VF_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_SET_LT:
+		sprintf(str,
+			"%s: belt %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_BELT(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_FORCE_HEADER:
+		sprintf(str,
+			"%s: info %08x%08x%08x pkt type %d roothub port %d flags %c",
+			usbssp_trb_type_string(type),
+			field2, field1, field0 & 0xffffffe0,
+			TRB_TO_PACKET_TYPE(field0),
+			TRB_TO_DEV_PORT(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_ENDPOINT_NRDY:
+		sprintf(str,
+			"%s: flags %c",
+			usbssp_trb_type_string(type),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+	default:
+		sprintf(str,
+			"type '%s' -> raw %08x %08x %08x %08x",
+			usbssp_trb_type_string(type),
+			field0, field1, field2, field3);
+	}
+
+	return str;
+}
+
+static inline const char *usbssp_decode_slot_context(u32 info, u32 info2,
+						u32 int_target, u32 state)
+{
+	static char str[1024];
+	u32 speed;
+	int ret = 0;
+
+	speed = info & DEV_SPEED;
+
+	ret = sprintf(str, "%s Ctx Entries %ld MEL %d us",
+			({ char *s;
+			switch (speed) {
+			case SLOT_SPEED_FS:
+				s = "full-speed";
+				break;
+			case SLOT_SPEED_LS:
+				s = "low-speed";
+				break;
+			case SLOT_SPEED_HS:
+				s = "high-speed";
+				break;
+			case SLOT_SPEED_SS:
+				s = "super-speed";
+				break;
+			case SLOT_SPEED_SSP:
+				s = "super-speed plus";
+				break;
+			default:
+				s = "UNKNOWN speed";
+			} s; }),
+			(info & LAST_CTX_MASK) >> 27,
+			info2 & MAX_EXIT);
+
+	ret += sprintf(str + ret, " [Intr %d] Addr %ld State %s",
+			GET_INTR_TARGET(int_target),
+			state & DEV_ADDR_MASK,
+			usbssp_slot_state_string(GET_SLOT_STATE(state)));
+
+	return str;
+}
+
+
+static inline const char *usbssp_portsc_link_state_string(u32 portsc)
+{
+	switch (portsc & PORT_PLS_MASK) {
+	case XDEV_U0:
+		return "U0";
+	case XDEV_U1:
+		return "U1";
+	case XDEV_U2:
+		return "U2";
+	case XDEV_U3:
+		return "U3";
+	case XDEV_DISABLED:
+		return "Disabled";
+	case XDEV_RXDETECT:
+		return "RxDetect";
+	case XDEV_INACTIVE:
+		return "Inactive";
+	case XDEV_POLLING:
+		return "Polling";
+	case XDEV_RECOVERY:
+		return "Recovery";
+	case XDEV_HOT_RESET:
+		return "Hot Reset";
+	case XDEV_COMP_MODE:
+		return "Compliance mode";
+	case XDEV_TEST_MODE:
+		return "Test mode";
+	case XDEV_RESUME:
+		return "Resume";
+	default:
+		break;
+	}
+	return "Unknown";
+}
+
+static inline const char *usbssp_decode_portsc(u32 portsc)
+{
+	static char str[256];
+	int ret;
+
+	ret = sprintf(str, "%s %s %s Link:%s PortSpeed:%d ",
+			portsc & PORT_POWER	? "Powered" : "Powered-off",
+			portsc & PORT_CONNECT	? "Connected" : "Not-connected",
+			portsc & PORT_PE	? "Enabled" : "Disabled",
+			usbssp_portsc_link_state_string(portsc),
+			DEV_PORT_SPEED(portsc));
+
+	if (portsc & PORT_OC)
+		ret += sprintf(str + ret, "OverCurrent ");
+	if (portsc & PORT_RESET)
+		ret += sprintf(str + ret, "In-Reset ");
+
+	ret += sprintf(str + ret, "Change: ");
+	if (portsc & PORT_CSC)
+		ret += sprintf(str + ret, "CSC ");
+	if (portsc & PORT_PEC)
+		ret += sprintf(str + ret, "PEC ");
+	if (portsc & PORT_WRC)
+		ret += sprintf(str + ret, "WRC ");
+	if (portsc & PORT_OCC)
+		ret += sprintf(str + ret, "OCC ");
+	if (portsc & PORT_RC)
+		ret += sprintf(str + ret, "PRC ");
+	if (portsc & PORT_PLC)
+		ret += sprintf(str + ret, "PLC ");
+	if (portsc & PORT_CEC)
+		ret += sprintf(str + ret, "CEC ");
+	ret += sprintf(str + ret, "Wake: ");
+	if (portsc & PORT_WKCONN_E)
+		ret += sprintf(str + ret, "WCE ");
+	if (portsc & PORT_WKDISC_E)
+		ret += sprintf(str + ret, "WDE ");
+	if (portsc & PORT_WKOC_E)
+		ret += sprintf(str + ret, "WOE ");
+
+	return str;
+}
+
+static inline const char *usbssp_ep_state_string(u8 state)
+{
+	switch (state) {
+	case EP_STATE_DISABLED:
+		return "disabled";
+	case EP_STATE_RUNNING:
+		return "running";
+	case EP_STATE_HALTED:
+		return "halted";
+	case EP_STATE_STOPPED:
+		return "stopped";
+	case EP_STATE_ERROR:
+		return "error";
+	default:
+		return "INVALID";
+	}
+}
+
+static inline const char *usbssp_ep_type_string(u8 type)
+{
+	switch (type) {
+	case ISOC_OUT_EP:
+		return "Isoc OUT";
+	case BULK_OUT_EP:
+		return "Bulk OUT";
+	case INT_OUT_EP:
+		return "Int OUT";
+	case CTRL_EP:
+		return "Ctrl";
+	case ISOC_IN_EP:
+		return "Isoc IN";
+	case BULK_IN_EP:
+		return "Bulk IN";
+	case INT_IN_EP:
+		return "Int IN";
+	default:
+		return "INVALID";
+	}
+}
+
+static inline const char *usbssp_decode_ep_context(u32 info, u32 info2, u64 deq,
+						u32 tx_info)
+{
+	static char str[1024];
+	int ret;
+
+	u32 esit;
+	u16 maxp;
+	u16 avg;
+
+	u8 max_pstr;
+	u8 ep_state;
+	u8 interval;
+	u8 ep_type;
+	u8 burst;
+	u8 cerr;
+	u8 mult;
+
+	bool lsa;
+	bool hid;
+
+	esit = CTX_TO_MAX_ESIT_PAYLOAD_HI(info) << 16 |
+		CTX_TO_MAX_ESIT_PAYLOAD(tx_info);
+
+	ep_state = info & EP_STATE_MASK;
+	max_pstr = CTX_TO_EP_MAXPSTREAMS(info);
+	interval = CTX_TO_EP_INTERVAL(info);
+	mult = CTX_TO_EP_MULT(info) + 1;
+	lsa = !!(info & EP_HAS_LSA);
+
+	cerr = (info2 & (3 << 1)) >> 1;
+	ep_type = CTX_TO_EP_TYPE(info2);
+	hid = !!(info2 & (1 << 7));
+	burst = CTX_TO_MAX_BURST(info2);
+	maxp = MAX_PACKET_DECODED(info2);
+
+	avg = EP_AVG_TRB_LENGTH(tx_info);
+
+	ret = sprintf(str, "State %s mult %d max P. Streams %d %s",
+			usbssp_ep_state_string(ep_state), mult,
+			max_pstr, lsa ? "LSA " : "");
+
+	ret += sprintf(str + ret, "interval %d us max ESIT payload %d CErr %d ",
+			(1 << interval) * 125, esit, cerr);
+
+	ret += sprintf(str + ret, "Type %s %sburst %d maxp %d deq %016llx ",
+			usbssp_ep_type_string(ep_type), hid ? "HID" : "",
+			burst, maxp, deq);
+
+	ret += sprintf(str + ret, "avg trb len %d", avg);
+
+	return str;
+}
+
+/**
+ * next_request - gets the next request on the given list
+ * @list: the request list to operate on
+ *
+ * Caller should take care of locking. This function return %NULL or the first
+ * request available on @list.
+ */
+static inline struct usbssp_request *next_request(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct usbssp_request, list);
+}
+
+struct usbssp_udc;
+#define to_usbssp_ep(ep) (container_of(ep, struct usbssp_ep, endpoint))
+#define gadget_to_usbssp(g) (container_of(g, struct usbssp_udc, gadget))
+#define request_to_usbssp_request(r) (container_of(r, struct usbssp_request, request))
+
+#define to_usbssp_request(r) (container_of(r, struct usbssp_request, request))
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

