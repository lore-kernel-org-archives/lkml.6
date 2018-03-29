Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438920-1522314380-2-13249314370597859848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CN'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522314380; b=RC6F6wU/4v8cPg7B6hoq/LmXPZa68YLvDuaZZ5gD6zJwbZVDHF
    KCbGAYytkMuyiFvSiyRLr6khrhr410gva0BtEUEWuZTSDWzYx8l4vpxMLm1NRlaa
    X3NLuGIEw4TCe1Ya1rumL8fHNGbmAoXp1fGiHMk++0a6REUH+pqWfM1rxlWfsMgc
    cWOLPi380YeVpTOmd3Yjx9obomjuoOtViVMHSiEDJh/B7oXB/xl0AyB5yyobuWya
    4LnTSnObZbDZL9oHondkvjUBV07izCgcmawhVqdMPfj6MdZ3Vravq+7YgFf3MhHj
    wHKMegocmFJSia4wOaXae+DdxgW/wm39iHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1522314380; bh=eL3YovTk2P47H6wGHUYJ0SWIqMGqP0
    mm4sb931XdSEQ=; b=kqhOLMOpfWuUwLKcyubt2rczqcu0k07J4c5nT3iTQlIFZz
    2so1Ckw7YtnA0Nx1tbld6YxEiWzwIUyqftwVyrVdF5Ii6HuP1s/9ttbYntdO7Bwh
    HMDr+pVOu5h6vucNk9f0KSVKqbkktUZJwC4/lI1oTW5W6fT3acspgEANhiQ4wU7S
    mEKOBVNFfA4uesGK09C33OSSPyWWktej7N6tTwWfp0SbUMOlbB576p2YhjQh5Fyk
    j2E1wY6HipbEEYElc4uFBgynSx5ZMOvO3YHZcAlhaEPSa8apQOJ2akEKYHsCL9qg
    4h7yLfz7RVb1zdCT2OkFnxn8Rhxv5gTrWsJNZCig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=iuBZhtRp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=iuBZhtRp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEaUeahAxna6hwv9VChV/jlgY7BE4kFNdM+0MIfLW3gXCv9FdUiQQuGtL42z8smZHFCzSa31/hrjqKM8YVHvXcMrj4Khdxk08GTLOmMfLM5fXqrrCCNh
    pZ0uJD2BZ1y+7hoQ5gyS+OL/eh9HkyVc7hOY341eVmxjiZ0QsWzFuWlcFWtHJKTQhB04e091eAHfbX2ibXdjvzku497jTqCfV+srlmya7s5pRXGqBO8yC+KH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=32wYES3LoMUA:10 a=otyTMIrQUO0A:10 a=YhaGW6iuxlUA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=GxQisCVLOtIA:10 a=swAopTDVAAAA:8 a=VwQbUJbxAAAA:8
    a=XfiFXyRviR9cf3Q6zuMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=7aPqbiTMDNvH6kBvy-t8:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeC2JGG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 05:06:06 -0400
Received: from mail-bl2nam02on0078.outbound.protection.outlook.com ([104.47.38.78]:44175
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750946AbeC2JGF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 29 Mar 2018 05:06:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 29 Mar 2018 17:05:49 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: chipidea: Don't select EXTCON
Message-ID: <20180329170549.3f74135d@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0154.jpnprd01.prod.outlook.com (10.174.224.158) To
 BN6PR03MB2628.namprd03.prod.outlook.com (10.173.143.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4acd828e-aa06-479c-4a27-08d595544ca6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2628;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;3:7/7UXTU5J0KH0JQJblkjUPKiXU9F9lV7EyKRPs+ETx5qZxG+LkkkN/3PH98g+2lDq5JleYmgeTu3NxqUCWnaMsi0iej/VE5+OAbdphnmEbtfslWfEmggztkgFXhIansGDU+11kQLBKifj9pPeJDmG23Vw3qk4PiJcvwZW9JhfFhvjiIfwnlA+gtOoo9UOuTqwSReykPsHSB/C9HewVqanV56IItD0aWrImzczAgOIDfKCXb7xGFq4qom1p13tJNf;25:+kzSXXEf4lU9GBeVazUKmJKce9+Xbmv+GH75CL9toN1NvTAjSYKvVHExeZDbLPobRxR4VofTPZ9N5YzkIw8fxEN5S9MZ9SzqswZ4xeemIN+H8Ta/yJX9Y+3hziWiuIDIfm3RsCQBGhvc976bbENNVpecaGxZJinkQQDM2Hvi1DcsgQSWAukrKGOd8M8yaLU++wLpNS2m4YiqBWfKOA5oD6EwHArM5GwpzANcjvZciIOviEBdu1VqgRwNRcU4Ibx1RABBSoc5xpp/+tCOPG/nf4m+tDSkkZ7LnijY4C3393UtWdL2ixGmfmK8RG0y2/YLdW+yO3wqBdDxN07iqxWd9A==;31:Ruvjvt1iRepHKWODnPcg8wSCLrz4uB+7riedmVmP9SXrGHEqB/7sRH/XXkO3kK1m7SS9aBo8MeRp/MqC30qQSS1b+0ukhtPl6mwScndaTmTjEI4EbKf2k02Vec8b7pRn3Dh2rgUuXnvqF/8e7xD4/axWbnAprXSaRrf4KDtT6AJ9f0ei6w7QCJ5v3YEgwaULBy2H1KDHX8YjdrIve9FjCUaq7dqJdtlBBtGC3ViSJnY=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2628:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;20:wL9n56WWOA7Li20A1RI8x5MRwjWYc3w+a1z/IGuD7GjTp5YgtwAA1hfKGA3i65zXxCzNmEARdSayhpj1JmJX+pYRSxkr9XuBiTT7QWQhN0dWLEcWWnzXnsQb4mon6IsuwqEiu61BM4XMrnIf3vvAIhxrbMbqQNEmMaSuKdQlzmeAftYxDbMYB19HQe0yFLsB+GJix+soRG/W2YYKiqZzHiYEXEEsShirwVb5LXMkQ6gnS3ZUEW4rMjCGXmGLtR1zbbDZMwqK8hA71GMC4v4lEPa3zH2BTUYrWPQrYJ6Q1YG+6t3zg7nj2YJ8kS/rCf4FBLMjxos9H29afUvGWUTjsPcjZXZEvNLucggSzhPCHMYIMiwjptYRR3rTJ0wcCxH2Eac+QUKrs8+02al7B192CT+nEnMhooJVXfe5iOWUC7x85xBFJ9wMWgLL71avNX7n6dv4Ce/AywIuXDCHW25HgZ5PcgKKvaKM1jeaPzX6J950RUvynI7wc5Xmt36Y88za;4:avjioVGuUlgGJvM5LJDISeedp3InSgIEmXy7v98p/ArOJ45KGgEPllYbajAsT2Q3v8PQ5ifqRApnOAl649gCAct73hXU4xLe7kRe+b5u7mtzfQdjsvy7K2oSxpuWQh9cFxtQ/iODDq8/DwjwSNbuY9bCW4uE9MHUB2Fzh3onf0Mi1uOuoytOlvOSg6LIK2pHgP7ujiE2Yd7s/oj19edvPWvprAdkB5sDHJNCl1+UmDeCLqprvG2ZcalobmTXXYueqgCKORwMdKuXKgi7zSdZaw==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26280E9365E3F3AA9688EC71EDA20@BN6PR03MB2628.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2628;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2628;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(39850400004)(376002)(346002)(199004)(189003)(68736007)(52116002)(110136005)(23726003)(3846002)(8656006)(6116002)(1076002)(8676002)(50466002)(478600001)(6666003)(2906002)(47776003)(66066001)(105586002)(72206003)(8936002)(26005)(386003)(16526019)(7696005)(7736002)(55016002)(25786009)(575784001)(476003)(5660300001)(53936002)(230700001)(86362001)(316002)(106356001)(486005)(9686003)(1857600001)(81156014)(486005)(186003)(81166006)(97736004)(50226002)(4326008)(956004)(305945005)(59450400001)(33896004)(6506007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2628;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2628;23:MGJ6z5QrdaqisQzjJi8LpbF09fVEVt4OYjtxhF1RI?=
 =?us-ascii?Q?wgxO2ko0PmJAXxF5+ZiBHARGepkq1KehKWx45SKEVgMRF0Kz/SWng9tTuGyc?=
 =?us-ascii?Q?0kEm13uOxIXXrodXDkgX4ftarj8TIkJwuGCiarvu6/YJ9vN69+FCAZ9QZVzB?=
 =?us-ascii?Q?tbE6ORSS1tiTCh2dRUaVDFpKw/hnrCBgrpt5H1ElDaankdAjzW/nuSBt1xKa?=
 =?us-ascii?Q?TQ6hygKGM/NEs6KbVJQtg+VBFAkd60oE20FVE6Zjcd21U88uZpMCt/i7PjDF?=
 =?us-ascii?Q?yea6hbiG9xt8zzelN/SVGZ9IPddIfu4FnMKGm90tITmvMsMsz2r2XXMX/Pa6?=
 =?us-ascii?Q?GtZKJF9qb9Yyj0SBZvwilHwVwQ2O4dEpgb8FLv1sNjmpZeEinQuiC5pT2Rd1?=
 =?us-ascii?Q?JV6StQJ3lxUOMCt8A9fJ1IPrPPVNE71+wo4oSs78KDslmvXUKKsipIZi2Jga?=
 =?us-ascii?Q?CbKQ7BwCw1Vqq2BIqp0GoNoDkrkHVSoOpuGSP5jVKptCFE0hLhmg0Do9Lytb?=
 =?us-ascii?Q?Pz4FV4l11WlO6uf9RIHXFk/MD9qc0ITtAwOBghcU8YisdAcLVb9hbogjiFFK?=
 =?us-ascii?Q?gDyEoU7QoNN8brGCKrYNLLXaN7DgnahcgacCHB8bB7aEFkrCRoFeYXWXlk8z?=
 =?us-ascii?Q?XaAi1DBtosyhpjzhMf0Oj2KSk3CVk62dy2dOElY0740lWswDZpGZ1eMjWtZa?=
 =?us-ascii?Q?r+cWo1vPrcrYXp3QgUF8Xj9doaQ6id1PVUyYnJSZDWeG7bNDzYBS7oss7sPf?=
 =?us-ascii?Q?ruLd8GYYbGor6DVTfYfxSRY188++ww71dOa8Y+6wH8jOSUD01ngM//UwisIP?=
 =?us-ascii?Q?NpKmaoTI367dvxkpAUQly2+hdDzzNLiLaWZZB0HRg43EMTYcW8ly2qS5Cqmc?=
 =?us-ascii?Q?AJ4pGxRyc8G4TONq+PaLati/ng/w3wznCZ2CqnEKAJfs2joudDavf+6vX+ia?=
 =?us-ascii?Q?jGAtIyUUE31/W1TznOEMjGdSHHq8DdtNaUaTSLQcyHv0pzU9xKlO4Io0gzl3?=
 =?us-ascii?Q?iUsdgRdlNV9n1Egisy54d4z0cr1VmsMrIHR8fVNqsGJmVWJ6jF3MEacyssAB?=
 =?us-ascii?Q?2AimRcJVto64tJXAm0/l1KI45OR5FjVX+YI2u95QCp5bD4D0MMKyO80YJakG?=
 =?us-ascii?Q?INrPxgExNdWyArLokcgEeXdxLN+rrI6Hdp0U09OOKvM0aYTd4K76wE5qfZ2m?=
 =?us-ascii?Q?93qdmzd75jM0YiPTwF4UxGINxtLIdvWxc//8twye7bUECZOwtN5j0OZm0ORZ?=
 =?us-ascii?Q?zeBddA7UcA5kVqeZ5iPgFiSGUJD5A86kN5yRxHO7P1km4DUN8DdNypBormms?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: KWwWUOMLTlFyBC5U2kJqUzbtV2m0MB8rBO8zpnsEsAgM9f4E8pGohY+L16oFSyOhi60vxYPEXimYKiHzDLQs3vvMu2JG2X7LoJKh8IPC1WU/WZcQml6xqiPpsJK9gZjTcWJ5+ZafbIs+JdtQA46GM2fenq3iOVdsM1mb2Zyx34MDgE7R3zDGF6XRBuiCXRSV
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;6:mgltB4qSOG19oIOHyTIZ2cNF/88m3TyIHuVjcT7Xla/kdtZNwyNDAGzGeg87lSeX/srbUs2qHPGdm0B/MmZ24uiiJ9RQ4L1sq3RFbn21IIuvjol+ijMCyWe7cH5Qyj207GMw2U6Ci18YUSYo/el65jVtIl83hR7lUIpQNK4f83fVRC7zNzkSoaLjLBtVqalD2AN+7zld9gkDu5OAItqno56B+XMDtasnpdc5nctxHIHlIGUTwuvRGw8YVM0H0nEgbS2o/BoZfcJeXtnQixdETqrlOVP0HGjE+f3epJPSccUgWd6puPmt1paMSi0kwmFiuK8c68yLsVEnKrVwiWyr5tD0Ld6LoAdxBs5GsjH5lFrUmUF3QNb13OHexWUleHuJyU6ABv/s+YeM7sgaujBOzQuYF+hPKm5f2zEzM4bEi6gJLPwp2S91Fgdi+uVzTsatqCrGJF7g++tz5DNt6tL9lQ==;5:OnRuKFdkBnhIndAFiEdExiB3jEIIBsYZj9kl3RPbJb9lEZrIx7z7YpKrDQW9N9w8xV0syQTix7mB69XK1slRUuwkGHWPrfbBwPgbQmFDt4SQpEP2/dqmKgYktMJ4cEYZotRfympDZ1doyhwBAOJJZdMnJDw1bdIOdM2aTPxgvk8=;24:5xQ9hLMV/QYuCa3IB8HoeJ1dPKdFdKzDB+jwwdYvIXFlu35w/EL1dY5hXSEcnA+Ktz00YvFyJFTrGQ5tsCgZv/RabOp6FmlXcoBmRtB/ruY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;7:nGM9nlphrmSZmjlP5ourLxEe/ZteVhqnhevBTTfty4JcoD4bNo4qntCZmS/Grnea1vOptcPaaJ9NT2gChP81qMmrlG/l9AWiMTpkPrEgGfS3E9hqxpKId1k0BdW4MWnKn6l610yGtbpJilp5dyItYA66zuZlodzPFf5qblw/0l0MNMxWTwlnxD96LP7W/Thfc4Mb3mYhSMW+fWJ3KFs8ZQEGvLKXGamd9pcGU1ZBQ/hY20YYfCgh/0utMjwU4qBz
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 09:06:02.4679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acd828e-aa06-479c-4a27-08d595544ca6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2628
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Not all chipidea users need EXTCON, so it's better to avoid
unconditionally select EXTCON, this could save us 2KB kernel Image size.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/usb/chipidea/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 785f0ed037f7..97509172d536 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -1,7 +1,6 @@
 config USB_CHIPIDEA
 	tristate "ChipIdea Highspeed Dual Role Controller"
 	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
-	select EXTCON
 	select RESET_CONTROLLER
 	help
 	  Say Y here if your system has a dual role high speed USB
-- 
2.16.3

