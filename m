Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682218-2-1034249223135608939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682217; b=wobOZt6GVzrSyE5qgzMSX8jSLUMMMEtRp4tAlL+KD5HMGQU
    ze0k1mHbSJiuCfywIlrXbOFbRLg+7BhuSsNKBb5pDrYzbWwtMr8Uc5846hUitY5i
    Zqt8yixgcxqO8sRQMAkClJTDv6dP2bpkZr2WG34qysG96qEj9gBzhYVxzTyu+AMf
    jl7PIQZjLDjSBu37jk+0vvFy6F00tPvr63FbI0NWT1EOQENa4il8f37xQAIjzaz7
    LwOWlMWhyVNBQ4rS+qp7m134kNvfTGhGU1JMTOp5zpn9t64AKbWHKxY24bkex5Aj
    QbKzj6h6PQHjoE+gFHB32gbDwR/FOwQKIz3Kxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682217; bh=nAQra2
    U96HB+9qSLGGxtF0FpUNg9udKhz2YhQQyrfZA=; b=Qm1aHJ//NQAIHdlUcY5Ocg
    AW0qEw3faqAi7uRCQ+Dr/cHv6e0GIRKNmZ1Ylqh6nBSJv3g6UJUTmpzu8cNfHFxq
    kD5lBWjynCjy6cxcB3ghwa+QLibnL8u4xdQWZBaHsd80JyQIL6ZdxyX0L+GPhyZL
    gmCjnu8mzmqerB5mrRrbE+jdkziBICLEWwhC1ZMpdSrRbLj5fG9Ra/i3zhgCGtwr
    MWND6W8g4ft677pxj76TeaHnxLaL2jLi+OE+LpczqvYLgWhs7vxcZ0pyCyextMV9
    1O3R49bMkruwM2oWhvDcK+CKNUfPOB8W9xAQ/hLdCfx3Ip5mXqWSNFQ7BMTr1psg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FyUTTKTA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FyUTTKTA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeBCSXa (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:30 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753451AbeBCSGZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Felix Janda <felix.janda@posteo.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 40/52] uapi libc compat: add fallback for
 unsupported libcs
Thread-Topic: [PATCH AUTOSEL for 4.9 40/52] uapi libc compat: add fallback for
 unsupported libcs
Thread-Index: AQHTnRlbEwGsmUqMo028hTYiBLyf5g==
Date: Sat, 3 Feb 2018 18:03:55 +0000
Message-ID: <20180203180303.8490-40-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;6:sO2fvGDv4GYF0zgwvDfg9eF4MwrcP1d3+gFzlCAdXDqpyjTjrLxFptQngqjBT5OkSN7pNdZn9h3TRD67ei4SmGpJGdBoSIVCw6TslvGgILmgXun/82TnHbqq+P9/Ve9JhkPKNhGou9WFYj1o82lrIM4VB3ZuTexqFkMjrlJ9UlhSHqS/TUldiNqFQmeXzeJ5RiuyYAy0CNIyTEuGObgCTL51ggonesF0zcNOEYuAvZYAc9EwUJKdCor69vVuq9HkqCw5hJK43149mar1+xyRcuXNweIedsAriIGgc3UTlMzfLKlYN+jEREGiypHXp8nVl2m8NabTAHBW+CiyvQB2f3kWdX6O/MeFzGIEYyZKTJJ/Wu8AvX5RNHap1zv1VSCM;5:rHLAGfCvE2sI6sAsSLIyHJc+Vyg+Ic6nYxjYhjlzvTSlMxj8+HdvUb0ctK6FplPtJKwR+XLqMeks2Y3M/dAQ8tWVnU1z6YjDrB4LrWJBc4jm7VgdjtuM8OGPMB/4mtitjeRzI26DIrkD/PLdX9FOvnN6nX5kHG6eSAoYsxdZp2g=;24:PiLybH251EngmuDED/1UbNfzg1/Mz4zyQPXTWVwnhjW6oCdkbRYdKtYaKQUrjZKTICXQmUjw6HP0s2hzasLidRt9KDsiDJmeMp5atpHw/9I=;7:4Q0IFI1F4841ovrAA5trykfZ527IJA8sxPvPGo+xpoRdVg5cNGGIbsrknjtvqDHjdr5D2lRewW3brcnum+VV3yhMpBltW9lGczFGE8vawzfqGzocUCCq0w/d9hVBuddwm/DuQ0ujhC17wYlg29wZC5NJHElWX+Bh70GzUH7BLQY1iY0Kp4fJ8+4HvfuFv6BQfsfPlIsn9+i/P45namTGXLBtzuSWBhYFfDvjCjj19ZwwGPKMFCK2D3P1vNw6nN77
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3a6d48c-f92e-4edd-5ecd-08d56b30a068
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB101228115827F240B79D6D08FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(6306002)(76176011)(86612001)(86362001)(575784001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(966005)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: QkuIU2bPSq+hH8cNw6FpvraR3I2UeECGhJjhdk31nlZiAvNLyifzTeFEZSI82+AAeA3QYN6ytSl4CtySr0r2fw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a6d48c-f92e-4edd-5ecd-08d56b30a068
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:55.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Felix Janda <felix.janda@posteo.de>

[ Upstream commit c0bace798436bca0fdc221ff61143f1376a9c3de ]

libc-compat.h aims to prevent symbol collisions between uapi and libc
headers for each supported libc. This requires continuous coordination
between them.

The goal of this commit is to improve the situation for libcs (such as
musl) which are not yet supported and/or do not wish to be explicitly
supported, while not affecting supported libcs. More precisely, with
this commit, unsupported libcs can request the suppression of any
specific uapi definition by defining the correspondings _UAPI_DEF_*
macro as 0. This can fix symbol collisions for them, as long as the
libc headers are included before the uapi headers. Inclusion in the
other order is outside the scope of this commit.

All infrastructure in order to enable this fallback for unsupported
libcs is already in place, except that libc-compat.h unconditionally
defines all _UAPI_DEF_* macros to 1 for all unsupported libcs so that
any previous definitions are ignored. In order to fix this, this commit
merely makes these definitions conditional.

This commit together with the musl libc commit

http://git.musl-libc.org/cgit/musl/commit/?id=3D04983f2272382af92eb8f883896=
4ff944fbb8258

fixes for example the following compiler errors when <linux/in6.h> is
included after musl's <netinet/in.h>:

./linux/in6.h:32:8: error: redefinition of 'struct in6_addr'
./linux/in6.h:49:8: error: redefinition of 'struct sockaddr_in6'
./linux/in6.h:59:8: error: redefinition of 'struct ipv6_mreq'

The comments referencing glibc are still correct, but this file is not
only used for glibc any more.

Signed-off-by: Felix Janda <felix.janda@posteo.de>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/uapi/linux/libc-compat.h | 55 ++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-com=
pat.h
index 44b8a6bd5fe1..774cb2db1b89 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -167,46 +167,99 @@
=20
 /* If we did not see any headers from any supported C libraries,
  * or we are being included in the kernel, then define everything
- * that we need. */
+ * that we need. Check for previous __UAPI_* definitions to give
+ * unsupported C libraries a way to opt out of any kernel definition. */
 #else /* !defined(__GLIBC__) */
=20
 /* Definitions for if.h */
+#ifndef __UAPI_DEF_IF_IFCONF
 #define __UAPI_DEF_IF_IFCONF 1
+#endif
+#ifndef __UAPI_DEF_IF_IFMAP
 #define __UAPI_DEF_IF_IFMAP 1
+#endif
+#ifndef __UAPI_DEF_IF_IFNAMSIZ
 #define __UAPI_DEF_IF_IFNAMSIZ 1
+#endif
+#ifndef __UAPI_DEF_IF_IFREQ
 #define __UAPI_DEF_IF_IFREQ 1
+#endif
 /* Everything up to IFF_DYNAMIC, matches net/if.h until glibc 2.23 */
+#ifndef __UAPI_DEF_IF_NET_DEVICE_FLAGS
 #define __UAPI_DEF_IF_NET_DEVICE_FLAGS 1
+#endif
 /* For the future if glibc adds IFF_LOWER_UP, IFF_DORMANT and IFF_ECHO */
+#ifndef __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO
 #define __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO 1
+#endif
=20
 /* Definitions for in.h */
+#ifndef __UAPI_DEF_IN_ADDR
 #define __UAPI_DEF_IN_ADDR		1
+#endif
+#ifndef __UAPI_DEF_IN_IPPROTO
 #define __UAPI_DEF_IN_IPPROTO		1
+#endif
+#ifndef __UAPI_DEF_IN_PKTINFO
 #define __UAPI_DEF_IN_PKTINFO		1
+#endif
+#ifndef __UAPI_DEF_IP_MREQ
 #define __UAPI_DEF_IP_MREQ		1
+#endif
+#ifndef __UAPI_DEF_SOCKADDR_IN
 #define __UAPI_DEF_SOCKADDR_IN		1
+#endif
+#ifndef __UAPI_DEF_IN_CLASS
 #define __UAPI_DEF_IN_CLASS		1
+#endif
=20
 /* Definitions for in6.h */
+#ifndef __UAPI_DEF_IN6_ADDR
 #define __UAPI_DEF_IN6_ADDR		1
+#endif
+#ifndef __UAPI_DEF_IN6_ADDR_ALT
 #define __UAPI_DEF_IN6_ADDR_ALT		1
+#endif
+#ifndef __UAPI_DEF_SOCKADDR_IN6
 #define __UAPI_DEF_SOCKADDR_IN6		1
+#endif
+#ifndef __UAPI_DEF_IPV6_MREQ
 #define __UAPI_DEF_IPV6_MREQ		1
+#endif
+#ifndef __UAPI_DEF_IPPROTO_V6
 #define __UAPI_DEF_IPPROTO_V6		1
+#endif
+#ifndef __UAPI_DEF_IPV6_OPTIONS
 #define __UAPI_DEF_IPV6_OPTIONS		1
+#endif
+#ifndef __UAPI_DEF_IN6_PKTINFO
 #define __UAPI_DEF_IN6_PKTINFO		1
+#endif
+#ifndef __UAPI_DEF_IP6_MTUINFO
 #define __UAPI_DEF_IP6_MTUINFO		1
+#endif
=20
 /* Definitions for ipx.h */
+#ifndef __UAPI_DEF_SOCKADDR_IPX
 #define __UAPI_DEF_SOCKADDR_IPX			1
+#endif
+#ifndef __UAPI_DEF_IPX_ROUTE_DEFINITION
 #define __UAPI_DEF_IPX_ROUTE_DEFINITION		1
+#endif
+#ifndef __UAPI_DEF_IPX_INTERFACE_DEFINITION
 #define __UAPI_DEF_IPX_INTERFACE_DEFINITION	1
+#endif
+#ifndef __UAPI_DEF_IPX_CONFIG_DATA
 #define __UAPI_DEF_IPX_CONFIG_DATA		1
+#endif
+#ifndef __UAPI_DEF_IPX_ROUTE_DEF
 #define __UAPI_DEF_IPX_ROUTE_DEF		1
+#endif
=20
 /* Definitions for xattr.h */
+#ifndef __UAPI_DEF_XATTR
 #define __UAPI_DEF_XATTR		1
+#endif
=20
 #endif /* __GLIBC__ */
=20
--=20
2.11.0
