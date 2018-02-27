Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330745-1519732178-2-16478852318955981818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='fr',
  MailFrom='org', XOriginatingCountry='FR'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519732178; b=a8s32UfXLzga1nB68ro9hYtlPvQCTft8W8FYvfAESLXUZxs
    YCWa4vWcw6oZimfCz6Yn6la2mWcMSMJ69W8QEhfYvuFCSOAO0gIJl29ud0ViYfFy
    x9UNdbqh1WNL/6Z8POISnbXfTixsNqgiKM11psQgR+q75NnNP64DsI8Xq+CsI+iY
    1y5KIqlGpbmWKVoWYwK4Y16TrozxZdviE2/9yPLood3bWOHxdv8Rou5G+S49Omr0
    pnwa7c5vDHlmjGkUoR+ai2FGBB/itf+tmGkohQkFcbKK9L8cNnVrTAF1OIDPPgpI
    4MTlDspfsAy2B5BoSBdhGtNV/4IaL1UWEQV44vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519732178; bh=3ed2+rokE8m9UEZgJdEIwUvBuRzp2lXcHgG7YbhVlP4=; b=u
    CS4qozgFmpXO+KQcnVjXeH6Qq1FDb0v736YVbltFp9v3T7Vx0uTNM9JXg8XHJ+j+
    kyaB5H5wqX60VS1SzToBLFOVRgFc0b3vO/p9lAg1ajLjuboJnyO4MEm1hmkXFdW4
    qS3RccrUDEORW74YgOqud6FnXbwADpL2SZtWLUJESL3Ea9JgOav2gL/oe+pfk420
    CEv/jj3D7ff8nFfWEkXPT5WEa5yx/n5HUFH6TYBGrI81FT643/6dFP7RfFB+FRob
    Wwn+gDlH8SU3QAoK3p088txBlJFEx6VJcVOrE0JiZywK6n+Sa9+VPY8H6MVA21P8
    v2kMc7fjfnLpjNXvRxsGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=actia.fr header.i=@actia.fr header.b=UChmRI0V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=actia.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=actia.fr header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=actia.fr header.i=@actia.fr header.b=UChmRI0V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=actia.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=actia.fr header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeB0Lt0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 06:49:26 -0500
Received: from mail-db5eur01on0041.outbound.protection.outlook.com ([104.47.2.41]:46796
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752107AbeB0LtY (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 06:49:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bassem.boubaker@actia.fr;
From: Bassem Boubaker <bassem.boubaker@actia.fr>
To: linux-kernel@vger.kernel.org
Cc: bassem.boubaker@actia.fr, Oliver Neukum <oliver@neukum.org>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] cdc_ether: flag the Cinterion PLS8 modem by gemalto as WWAN
Date: Tue, 27 Feb 2018 12:49:52 +0100
Message-Id: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [212.194.216.83]
X-ClientProxiedBy: HE1PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:7:28::17) To VI1PR01MB1887.eurprd01.prod.exchangelabs.com
 (2a01:111:e400:7bd9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d461e8cb-320a-44ce-d899-08d57dd82375
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR01MB1887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR01MB1887;3:SQB+0CdZqAMlbEjgVRuSUliqVURQUZDn23QeLMfCpAcJnDpltnCvjCOU17vIguQbP13489BRcth2+JSfMJ/iA0mtyvGkGSwXz4pMSSqS1FsVqbFX3qAxlWP+sfM7CCoq3VhsPLBG0KtHaZpvFPtoqq3QcnDYdBDkKcZkdiTjYDFiLk0LiDlcyKccJXoMkFQMBimG8/y8vGqBexe6viTEyHkytbXSZQSBClgO4vWY0ErvPQOIepnJ0qjb5SfEeG/O;25:WEMj53kA8F0kIIX2X61sVLG+/nHbV9qD32kYn77+6Q5XnXBHMVUKOCet/GH0NmISjx2gaRtMRhFzJJILZYtUrHVf3yCJqYlg0+uHTWAMzwgrumPHhXQN3Q+270NDTJ0+qml5fk8IyEc1DLGrAH2KO5NvCxpPJhMGoQ/o3zg6zPJpEjUBCjO8SfxOV0zvDavRnLsmwOPQTCD48v3kYoFnrcErMe3PNUu9N8caAP14LED99V68Z8+v+0bGM3dvl4ogReJgUK+VkJYWL3mejtzkxDj+8fiwTxaLt2JAZyUir9ocrsRyo2sgbRt/CAG090OG5CY0J1FdhQssBqildHS2+Q==;31:fLhwfspFPKpVX9m2iyeOcbrn1JXeoi9LCMhSkA9NHxVtLBYLO/m6Iq0J030d5Z8s3W96ubRif3Yz5ClTry+Af8FA6uop4AY+sjiAEoaukrhZKwOb9fI8G0GSoOEsqOMcvT650leXRYDTqUkmCzw1t6XFvvozcg0J/cMYuigmmRqyItsfyrEqCBSW26xnFGMmkb6Fumu+AGXLY/PVDO/wGde2gnalb/o/rhy7xvO+vj4=
X-MS-TrafficTypeDiagnostic: VI1PR01MB1887:
X-Microsoft-Antispam-PRVS: <VI1PR01MB1887165C6160A0E3C7EE54A89CC00@VI1PR01MB1887.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR01MB1887;BCL:0;PCL:0;RULEID:;SRVR:VI1PR01MB1887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR01MB1887;4:q8ri2xuPfwZ4zRyTkFB+0bykAkOQoY7C+NTmRYyRsByBSp1n+YhHpiOotMbYt7hTzgqEY35gmQJy8lhqdBACXGztzF02DG8SMGvqh/S7CocdPxzVlB2mCDm4wasSNN2d3T60MfjhYIINJSkD/agJXWlma50HHsCp6u9B7Axkhxnz7P6BgazONjRPbvDf0j1NnHe5ohlVJ9gpT7uonHGD5/LP5dDhk5XtomRkuNSrYo0JvdLZIVFGsiQj308OCAP34nK+/4yGrqsoFZA9ZrjT5g==
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39850400004)(396003)(39380400002)(366004)(346002)(189003)(199004)(59450400001)(2361001)(6666003)(51416003)(6916009)(5660300001)(4326008)(36756003)(74482002)(25786009)(68736007)(2906002)(6512007)(106356001)(3846002)(6116002)(2351001)(186003)(8936002)(48376002)(16526019)(81156014)(386003)(316002)(53936002)(81166006)(16586007)(45080400002)(97736004)(105586002)(478600001)(26005)(8676002)(66066001)(305945005)(47776003)(50466002)(52116002)(86362001)(50226002)(6486002)(6506007)(1857600001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR01MB1887;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR01MB1887;23:l656JQjDLkNQHQ2BwTyjiZeGbWM7RX9+17njHU50q?=
 =?us-ascii?Q?UrNUAIRAHT85hTDYeQdydVJ6KSy8KsGiEh2noiP5vc3p3U7uvy6B0DqX104m?=
 =?us-ascii?Q?OlNGPH0cHg3Ppp/mYecT0pwOIpuEQHTEw5iRJJpARzGgniVwW62/O5t0S4DD?=
 =?us-ascii?Q?eyeSBzAzdHu3j17T1xxwtF5sJmY+32ywTGRcgDuyW37pjXu3bUGQxV4auPCt?=
 =?us-ascii?Q?O+3/hB2cWWdwgBPDS/bqi5qWKy/uYcEP1eisvedDMm4la65udsAE5SCJ43hI?=
 =?us-ascii?Q?drPO+ElYhyvO/95dYL2My3Ie16XtR7IYDDJvy06r4TSkg3KHxm2JPQpKyt39?=
 =?us-ascii?Q?o8j5PbBshmUWRvo1UzSZagVJwC7iGPqAIiMyOddDamg/2DABf4YAmn76gxsA?=
 =?us-ascii?Q?Prh4Pjky6rG2hrudLYIhE+B/USVYXApQe4h0N+jLtT8mZurSXE4xPt7ORFNh?=
 =?us-ascii?Q?x/EcWYwHOyZSPXnvrApAKuhKFwMiyJdIeO8OI1rjKstHRYhOHq1+Aqe6XMd6?=
 =?us-ascii?Q?7SiEe6xZ4CVxd06Y1g4PJrgS2+0L88VJ2I4vP+mE7VjhymCeu7CMf7yckNuS?=
 =?us-ascii?Q?IY+Akl3QXOp8av/pSN6YFchcTCjFWz9ofniuD6XSf6ylXzujIstw7aRLsVtC?=
 =?us-ascii?Q?m8nj+rIH3UEimhgl1wbA7KuXPt2NWOStvlW9SoeCtz6tO70hTE1KM+47R0nb?=
 =?us-ascii?Q?v9ObPy8M4bsJ6I8urbHJ8UTk61kNrj/hzld0ashEwhRmyYMAGdCl3iOKnFQ7?=
 =?us-ascii?Q?tY+LGu0bT+DbrhKUfQDyOp3QfKp86PBuqh8mu1H8VKDxcPHBGtzbp0ggOISH?=
 =?us-ascii?Q?mqnG1cwnMQ9mEP92bfUq6/85IpW9HqKxsmjfs8/AucxIVNtZo7oNUVXGpMny?=
 =?us-ascii?Q?eH8Wi4i6p5WpRwtsAdwgMbqX4UO/K2SQpzvsGn+POwIVj46VrkrBzh4Mch87?=
 =?us-ascii?Q?jqTTknMcBNDXjtSIClCATdbcSHXk2CFoNgmN6QjMJXwVcJyovmtP8CbBo+qI?=
 =?us-ascii?Q?lvgv/Ktv1pVzNV3xKRPhh4+ZnnU8mUBG0CCO0v49AY10kZ43k+TmNLdtmLRP?=
 =?us-ascii?Q?8VAvRCGWvxv+2jCRUjqgEWeM0NI7eleiLnnZBepECh9+yPYo115kY2B3VB8Y?=
 =?us-ascii?Q?07UC1KyCzpDaHNjmjI9rAwP+WsZOUMZz+rDgqixmnCoiIbWQnZ3DqSh0ruqR?=
 =?us-ascii?Q?rMUo1kWcOoxymMV8dixoERdPHS15v/C/s0z?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR01MB1887;6:MtqGI3iEYvS/LoQwH5BIBV2f4mMkmPFYC0lfKMqcnX6AUHO5/5bdn7b5UvrEK6hlwGlU0y5fbkdgQ57XPTZJX8Huji4zZ8CE3w4/XnbKQCzfY8DsUvC8fgi+bnf4oUEk6MPe6e7zie9lQcCnpGfpT4wjSPB7INi1aBXPRzyolfvqlEc7i5a+K/isgkWV3u0dVG7IY1FThhZn5zfOqJPM89jLrDnhI3cEceR8zXrYe5fAYbtyFC1cul8SUQDSMI8xpQaIH8V4/1dsZAnDBW0x3imTzHe11WOWWWLJUAajDTqMfjKCiaNlixRjtVusGCJ4LMhEVfsBSK8b/P88DBJ4R3SIYh4uGjrlblMICDFry1o=;5:KMhHmzOFNiDcT7wl22z/UPDI+DAoXrLU5MK+uSD1G/ZC+tGnN1SBu2AIMqocVqHkZ8Qn+7f93Jk/bkOnz1mosLYrtLvRUYH2xdOlmlZX+0FN7SLafDWOGQ7rcyHgjXFNin4x2zOUu698Kaaiu3lkspNv1ksFbECO3YJzqi0qjwY=;24:Mo215S5MPya6EmaXjlGhWSPn7uOCgfQVFWpuI6YkusMoa+ZkWiqZ0NouiY56Nts0H/jdPpAfAdyK+rLyV8P7SINY+2QG5Byb4VpsuNFRl4w=;7:ewgLWbctTpbWXEx8LVFiAkjdpQAfpFmPOy6jxUAbihxZbAW28aucPYWx5JUeWPU1SLoEP4SRhOfsFuFTVmSWbdvISBw8xjXSrMEc3YieKO8FcfFI15apQBfX1KII9ohiTVtbi+g6Zu2RsYkaMjfu+ZqIAnSdLMW2fEFSkVpv0xv1mgvaliBDv9yh5Cd1zoV2nUnWg8N1gbHxLWAsolIhvkK4aX4GV1C6fDHgWBWetTupsrfJw0p9CKMRnJu5c7/e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: actia.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 11:49:19.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d461e8cb-320a-44ce-d899-08d57dd82375
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 86314f06-03e8-4460-82f3-a44f992a19c7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB1887
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

    The Cinterion PL8 is an LTE modem with 2 possible WWAN interfaces.

    The modem is  controlled via AT commands through the exposed TTYs.

    AT^SWWAN write command can be used to activate or deactivate a WWAN
    connection for a PDP context defined with AT+CGDCONT. UE supports
    two WWAN adapter. Both WWAN adapters can be activated a the same time

Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
---
 drivers/net/usb/cdc_ether.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 05dca3e..65621fe 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -562,6 +562,7 @@ static const struct driver_info wwan_info = {
 #define MICROSOFT_VENDOR_ID	0x045e
 #define UBLOX_VENDOR_ID		0x1546
 #define TPLINK_VENDOR_ID	0x2357
+#define GEMALTO_VENDOR_ID	0x1e2d
 
 static const struct usb_device_id	products[] = {
 /* BLACKLIST !!
@@ -896,6 +897,12 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
 }, {
+	/* Cinterion PLS8 modem by GEMALTO */
+	USB_DEVICE_AND_INTERFACE_INFO(GEMALTO_VENDOR_ID, 0x0061, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long) &cdc_info,
-- 
2.7.4

