Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2164689-1523445319-2-14180959952480447680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fr',
  MailFrom='org', XOriginatingCountry='FR'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523445318; b=eMc1YRksJmKp7wcQP6cSbGNoReXAuCkbEJDdaK8/SDYxM1LWlG
    cD5l1ykCdTyPsVeXi7twaeSz1v3NxltxXCwlHykI6oWa/7tqJPlCVvaPrrXk7rHK
    uf7e85EnOMrrZUUbo9iVj5+mgaCEIL9+AZressN2PWVFPwe5l/LO5Qmj6IDCoUyp
    B+vXK/Lkj2a0HP7vRw8si86KxfmU57XyCbPs4D9WfUKCzlnopjHPB0uJRvg9oItH
    8ni7UaZ7DqZ0YwTSUxYY7RRxyLNbrqiU9kaidAQ+/R+9Q83qYTmWMXy76JjYV8yC
    195j0hcm87Q38XnrPtAVjZIvPrh+0lUqIVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:cc:subject:date:message-id
    :mime-version:content-type:to:sender:list-id; s=fm2; t=
    1523445318; bh=9+3avcUCkc9RG/LzpPX4iekpLjM9GoV6yoRf3rkZj+M=; b=n
    xQQWJQIcleRUChD/KeFuGZq094/0U4gdv8Iu16dv8g9X6qPdMvS+CKIaBqbhWBlz
    yJDML8Tpar+KujIXo8uaDu4mdCsMoAxF98kMiwaPPLD+aIiAkjILJl0I2I6/V1Xy
    WiMaAlNyrslKa3ozt94MEaGU2F40rNPBz1kOpLNADjLL73hy+GOj67YINEsEtYSF
    JZMfW4W6/tmOxjqUqDQV0NXIOjUAwCcewdROSur3aGgvmIdcSoBATYX2dnTHTbXL
    YXomUbvQdIbeR2l7g2HXbjwRNnEV5xYNXDjBqeNdvV5g6cwNp64MgeOG6W5xkxS6
    pb3kYBgL6UluKy672kX3g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=actia.fr header.i=@actia.fr header.b=FPUQ6sA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=actia.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=actia.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=actia.fr header.i=@actia.fr header.b=FPUQ6sA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=actia.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=actia.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFIAUjMDkim3cDIAqNH8wTaGUj1zkMu5RQZDOAj+gWkq/7MqHRyO7Z7hKZE6TsyEWdaeLv+7faZG0Q1jPq1D+PBmbAovAcC1oJ2rd9iVbKGaOS3S2dL6
    PcPLNWMMDCm/hCqcsbpa8ezkGSREcGQjtSzP+0iGBFWE4SEF1y8Va+g+Db0G95LMkSp9gD7bTxuBaoaeu2VulkfcIa/qZwCpTQPO//6+exwVUNNdB9Or6der
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=U_RixZQe_u8A:10 a=p1BUEZb4T3UA:10 a=F2LWg3YqLVAA:10 a=Kd1tUaAdevIA:10
    a=zD_0B01lkrIA:10 a=VwQbUJbxAAAA:8 a=cIyNVj2ZPKj3d-H6nUsA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeDKLOp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 07:14:45 -0400
Received: from mail-he1eur01on0044.outbound.protection.outlook.com ([104.47.0.44]:58592
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750801AbeDKLOn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 11 Apr 2018 07:14:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bassem.boubaker@actia.fr;
From: Bassem Boubaker <bassem.boubaker@actia.fr>
Cc: bassem.boubaker@actia.fr, Oliver Neukum <oliver@neukum.org>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN
Date: Wed, 11 Apr 2018 13:15:53 +0200
Message-Id: <1523445353-7631-1-git-send-email-bassem.boubaker@actia.fr>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [212.194.216.83]
X-ClientProxiedBy: VI1PR0801CA0073.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::17) To HE1PR0101MB1707.eurprd01.prod.exchangelabs.com
 (2a01:111:e400:c517::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0101MB1707;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB1707;3:Mjf1jZUm0Jj9XUqK9ciimTkR5twL3B5BbzBM876ubMOceNd02ejcDI5UiHMgoCEpDAnbVeNKvq8x3/DGAqUSGFBuiPNKWz2d66Km+dCsULUX2Ou/G4ZVit+t3s6m+h0EHEDJ5f3BeE3+SjXHxceqxyE5hjvUY9jVlFoEPuS6OdqiETaoMze6Pz/iPFUxPWSbkpMuay9xdu7g7TtcOo8j/xJ4raPHi0E0LZ248j9e8uvONMDTqgHhb88tsldPDLaw;25:T3lnCTbuTmExA4f4MIbdi1+kla0LPIcQ4HpKDBBP7pqs6t1xA+UQ4H5i5Ma/MT+BOiZmMfI2w8E4uJTkWJkoCDNBwPzudp7JkFJ5UF1lZH7+n+i40a8tSW+ei/MD7hfJL/nvBsSAHuLRDu0JZ7D2Dt6tAUcIH7LRhhXssWTLbDMS9oQf64/fM1PhXcVieff61dQYa0DetpSiDAn8m8K+rA0rngyNbDrew6gs9jO88Fl4Bd2zieEX4lJrg30k1S+4e2wEGKl3ULltK+9W8NdRwvwv5aHvaVKPWPWSp4jdYnQrq7aqZdT/NIBQXryQHXBkzsqHmRq83e8CGRwuil2Yvw==;31:eVWJWTl1N3Na/EiRfdUpj1OtIoMgFuTGG7vBLv4dk3zbFoCNwJW4OOUR8VF5CmGY8v+OgSYF3qkUdEoJ4TQl/z4Pr+IahWBoGDUOTuDtCF2WRz7e+/ZFPgaoAyR0mey+EnN2poiQT7PyRTn6MffGezjY5qAsJ74wLCwIKOsLJE/qwqXau/wFdqWjt/4px7/f0bWEzX/IP18Kxh2xtZf4MbttoENO1AbYDT8ItZJegSk=
X-MS-TrafficTypeDiagnostic: HE1PR0101MB1707:
X-Microsoft-Antispam-PRVS: <HE1PR0101MB1707CD5BC5625AFF1E9872549CBD0@HE1PR0101MB1707.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0101MB1707;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0101MB1707;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB1707;4:yrPyZI6IZlpZuZUVa1wGC3EL5FF1jnLgh26IIXu7noo732/ZDmcZmyXTfXnWPzBsAf7ATMWBoZoy3UCOU9SMFgMj++QJhW4o/Mf66s3wmUXQyOEeOR90GmS3M6v6CQM3nfco8Iww9yEjq1PP1dATBmBcAEBRm9hXMh2GoUZ7idR+22PNsqWbTfk5O012ridaeciR/o5/7SJH5DrxvMIoIXyJSBUobOQsL/fNUU+4TLly41y3w/PWAcFV+q0trFfm83AzWQS4AlSuDnJ27MvdRg==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39850400004)(396003)(346002)(39380400002)(366004)(189003)(199004)(81156014)(68736007)(81166006)(8676002)(1671002)(8936002)(50466002)(66066001)(6512007)(109986005)(3846002)(106356001)(6116002)(105586002)(48376002)(5660300001)(4326008)(97736004)(47776003)(53936002)(486006)(36756003)(305945005)(26005)(2906002)(6506007)(478600001)(7736002)(386003)(25786009)(6666003)(16586007)(16526019)(6486002)(1857600001)(59450400001)(52116002)(74482002)(476003)(956004)(51416003)(316002)(86362001)(2616005)(50226002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0101MB1707;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0101MB1707;23:Fa/Wqb8ul8P7bTkaQAEZlkzBg1066QUyeyfDA3r?=
 =?us-ascii?Q?pbQBieswUOcbirdOpsttdxj8Se5UE1MBNJck/U+JmXsk1lv1kFAbt6oUWd6o?=
 =?us-ascii?Q?trelCzTwfgvD20YsbsJhXUgEz1+uargslTFYpeitrZkVJGtbSsfj8tajBgBo?=
 =?us-ascii?Q?o8SHsDOYCpgoM44zw4eF19yTZoRq2Y1LVPRqYUj8KI2jk04Jn348n4Tox52R?=
 =?us-ascii?Q?LdEcBFvzSerJhSBGpCHfLw7b5PuwuTsGKcsJHE0MKh6P2riS2mHxGpG3GeBL?=
 =?us-ascii?Q?u0RKT3/+0u0BJy8+raM/aCMlT0Qggeme64SJyrtP7x08fQfJ9Gd9H/8gHqFY?=
 =?us-ascii?Q?DQwgwTpTW5rQkujR1afMxI5kbtCNA+iFnuQseXhAKWvsP5roPyXI9eKkAanO?=
 =?us-ascii?Q?GzrGLxV8rhVWyzd3FFYDMEX2qlpD0icaYknebwT7r5Kwbkx7tDlYlauIqJ9x?=
 =?us-ascii?Q?5bT2iSLemXI0IezkGBVskB14PBi2QvUTZylojLCJk2nwRcirv4BHJA5kYMp8?=
 =?us-ascii?Q?NspIoKHVF0uL3SBkisC5oMHxBPcCT45G4ZwIy8fL09PjwxhEW+5TtFAgPFMx?=
 =?us-ascii?Q?VmgUqjVw0wmIJvRhRFFxU2NJNXcpCXkkbWS8bODDOMx+BxsjM4ehH/0Ikswb?=
 =?us-ascii?Q?f4L125F3N1+LlXIku/+VY+kirbvc+wRzos5mzSSvuUSF4jz9lbXkYwi+LjcU?=
 =?us-ascii?Q?R0b97Amq0sFl6lf/icnElVCiH2Ur8fbsCd+Y8csqY5pc92g1unr9l4y4adZ7?=
 =?us-ascii?Q?++XoZHdD3zapmFKPI4F5aXMb+C9D2mJlMJq10HJLuK3v+yCqY6nPrUNuAfPt?=
 =?us-ascii?Q?d8mzKUk/vov84zStOwzu3N1S68lnA2WPepDpX5F6kbyya6DrZOdyUnUZt3HT?=
 =?us-ascii?Q?DesFs75g0pXG0l1gpawWsrZnCfO7QnjgUn875gBf69zJNThK9766bXznxgmb?=
 =?us-ascii?Q?Kt4y8GKAu2LmGp73Y7/i5Rp8nkywpsF4STGYUWnc0iCTU+qNFT269sMw9cAb?=
 =?us-ascii?Q?2gZpZk2cAfyEjZoKXGTgergPSe4CeJSzvXGywI/bOCaoHJt6rxZmOaHU7Mpc?=
 =?us-ascii?Q?etq9K51ytz8tS1BSJ/mSCMIpoH+K9HpKOqW/knPqtQuDe2HHm5ao52PdVPEt?=
 =?us-ascii?Q?0qLjifOXYs50ecXUnHGTUD7uGOA5juVdduXAR/CBNTjAyevvbfYPEHqmk02r?=
 =?us-ascii?Q?nOoQmiAKpxCUJ3ZLJ8zmTfxcNW2dQuGcEaLz4QUX+Bmj7xLv0fUm0gZnuPA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: AxdlbuE4G9Rp8fHLdpfYIxVzFMIZ5wzkEX8/6Us6Yhw43eByf09MqhZp0yMuwOkL2U7HpBYhQpZadu9YuavJwDyq5/RuEHxInD8IZwE2ze/owEDeHlGW2MHkmNLgvX9h9IzooXud+uegFPmPI74HHSQE7GkJRua2tQzGnB1wxMvxixeRjI/w/h5k8+fr4vYL
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB1707;6:PWQe/sj80O0LaJsCy6UmWozJ4/0t8rMnvdut745huOYuwkYY85VapgQOmYHcE30dmbRWHNbrrH5Apkik3KRIji3y4ItwF1DKlX4pOL3FVsgiNaCYmDsRMbzX/kM9FdGik/ucr6Z/me2HuKR6FkSVmNo+NbrOvqdLibHFaHrNs2tmInQYNVTzwzYYV/ZQ3w7FcH4gyMPKXBsn2TU/VO1UM+IX26+KJH2/ZV+K9/pkcXZkG9RtzTYSXUHBQtSCObUUQOuJoq7Y8cG4vK+FhhjMBgqFIlMF5ev4AP+5DO1UvYEdyGTq4bsIi7wH5pV6f0Bux6gAbVuQsA7+cHstAwzLOn3fdQ+0+3spHSy4E2A6KwkujWp08bow1jaA6ccNfJqVUc5i5VwFlcqqJn7GASOoCrXWdu+of1vTuM7hNtwhVgXcfjNLNe7mJhYQ1715rnYKYwoztgCXqtgvoeJP8KzmBQ==;5:EZv/QhRs1LSBha1DEcISv6Eyc985LWwPEw+XWuO4r3ZHlYVT4WGBcwkAyq1eSBxEnEF3HdRWlJgzsj3JxexiKonQdTQmg4by8zLxP8KfW31H7LPX7NLYITFbN9Td1/Won2jbVhciyKDQf1n7T9JPQndrP9P9qLExDwrmpU0Lpkg=;24:3AVunOns+JbeABwUeWqLUR+TtaO6LWMVHN/aEEgUXds2d6e6iGszmDFmGQckXa7SndROTSaBlX4/wbOGc7mChiDt5u/r3EFbI+s590aAEOY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB1707;7:RdkFitdttTbQfddcaDVAGmATkFbGR9E9239CsuKERQFegZE87jvvENpH84obMjONkLfqJaLGXRR8uWbnVmaJd1SUSUqsBc20i6UbA4OFnOiGdVEYztRGuPXSuRroIlskQI400Ru8+s2Sq6yGuuXvXXJRd4l7hE9wNuqGPP85xfiVSLlI58xVbAdzY9wceU+CU2060RwC0UzH5WDgUjNYLUSNwJnSh+ig291HGb5GFTtcGQWTNqpQPbunCkcEAbo5
X-MS-Office365-Filtering-Correlation-Id: e32de2ce-6159-4dff-b8ed-08d59f9d6b58
X-OriginatorOrg: actia.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:14:39.7607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32de2ce-6159-4dff-b8ed-08d59f9d6b58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 86314f06-03e8-4460-82f3-a44f992a19c7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0101MB1707
To: unlisted-recipients:; (no To-header on input)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

    The Cinterion AHS8 is a 3G device with one embedded WWAN interface
    using cdc_ether as a driver.

    The modem is  controlled via AT commands through the exposed TTYs.

    AT+CGDCONT write command can be used to activate or deactivate a WWAN
    connection for a PDP context defined with the same command. UE supports
    one WWAN adapter.

Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
---
 drivers/net/usb/cdc_ether.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index fff4b13..5c42cf8 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -902,6 +902,12 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
 }, {
+	/* Cinterion AHS3 modem by GEMALTO */
+	USB_DEVICE_AND_INTERFACE_INFO(0x1e2d, 0x0055, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long) &cdc_info,
-- 
2.7.4

