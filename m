Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683407-2-4376621699947145052
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
    t=1517683407; b=Cu1GagQuka6Ik7mZw7pmTv3tr89F1Lw82z8rXS6uOshUgpS
    y5Ln/ptyBtv1X/bDa+4sTUTpv3eb8BnzlVM/JLpYF/Ynla3lalNOaGopwpKpYogd
    EGU3Irk8fg2AR6WBfJtyNXKkWmXLD5jdDPvIDflgqKcGNpSPQqGFqYWgt3owQTSY
    dmEJM7GY3mmriAA9okINyZmXMVgKt1LismMr//yJoTqXh1iXhOwuqkmNRFHPaHRi
    O5PPAXdNHqKgzq5UQw3u8WXot1+aTAo7+iIfePZItvZauC0OTrHk//MIP20YmLKM
    QvF7FZmbkzIoocByOhue/HItfy6c8h18TCjfn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683407; bh=qdSqW3
    JJf0YtYuk5ebMwg2fmI1pZtaIZjfXtjUAFG0w=; b=G6JIhwSOhNZFrXH5RfFkih
    4nXLG4iRcmwXy2dnE4iEiLPeWmAyB50MGe58PTidnMDiZBzE+vSiI6DkbmsY29jI
    RXXvY6uCACo6cLXjkg+Nw8nJpNU+g0t+ycRe6hT+QYepbK+CwcqNq3IR3aHEyDGB
    l8DAeYYiw+CuJPG4AhOdlT7Qs5R5wpbsTxo+rn3Dbd2m1Xzh9hWzo6WG80yAognF
    lF21CThWM1KAbxlfCYuBLz9kZeQd/OPxxsVHjPDawyEewqi+L4UyqW6f/CY42dap
    Ro+Oyw1GqdEkbKITSkWcX6n+dAifri02ZJtdcCEs+Owvwxt9XQD7c7I1dPD+w2FA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bu2xK4XU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bu2xK4XU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755189AbeBCSnW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:22 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53867
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752651AbeBCSDI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Felix Janda <felix.janda@posteo.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 083/110] uapi libc compat: add fallback for
 unsupported libcs
Thread-Topic: [PATCH AUTOSEL for 4.14 083/110] uapi libc compat: add fallback
 for unsupported libcs
Thread-Index: AQHTnRj/P87g024KWEORlq+LA1aT8A==
Date: Sat, 3 Feb 2018 18:01:22 +0000
Message-ID: <20180203180015.29073-83-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;6:MwhdAEBZxQ3B2M6lg+IPqraOuci1IUCYtdKtnL8K6bri0N+AU1MQe+RMHMFZS7enN+lydOfaMH56QtgqosqD6JjRltO14SH5q6SFUXtszUucQWowpAxIuZEieiBW/MCcPjoY//IqxBFalXisPG7r+KjsWvNfisK5NvbEjhSz58OgXYbahVDv71lsThG0R3iE9Mi5VwgBRLzVu3wE9frahYReSkauxB9QvgNacr0N28gJo9GjlGku2OY/1NgxyfWPFt+jxwToytIrNP5MJZ7AZghW3Lbqzt5PDdH3eAmZ2cJVxB4jvnAcXSqBhWmPGlfnzloPEvRCMwmLufAvD0EC5sMhHxqhaHotTmuSNHt20aaWGNbamtSpo+WORXj88/b1;5:OeFi/wzmPDN+hZWE256gtNVijUOIiGaxot7Xwjm8rj6z/piRIED9tMjD5WkpeJILWlHnz0wcO0jfquuus8hn8APfLRykaDMdARsbqPmoppCkxe+/tzDuwBZgC8XdgQlnDAPnHudIf5GnPzi7VHpzLDsibimD8FFvUXwcJN5oRkA=;24:wQmcMbDVsKjUNX9drM5gA/isln9oot3DZgKLAVfy20EjAhQhtUY2Klb+tHM4RxwvRD38TsGbLa2Aikpq0uCRIjzxElFmtfU/tz+K+8j3Zpk=;7:8Ma0D+qn+vNscZw8P2yn2d0qBizUuc4vLHmu46g6glas9sdoQ/W1Hlg3puyaKToXjZWkw5mts3oIVE2WkM+mLWbFKN+qwWBitcaZo6Z96LlaHg6B39KYyX4/vDPayNBoZcLoHDMAnuOn6oVjuqgniyv5H2UXBe+uhZo9imxBQ2FTU7nAMAeN2E5rGI9hoh2yIiIZsTXjroTAu7+rLp5tGCZhaJlYYgB1CcjjlFB/mPBcVun5Pvzx8H24IziyzyLZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2186e88-1ac1-4c2e-1501-08d56b30409f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB10419BCFF8FA310B7FC63859FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(966005)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(6306002)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: j1Rw0pCI9aVvd6UJ1jZYg+L+h8drKyW1carX37jr/fwrqLFEJJZUPnsAJ5zNsF1xzl/BZDVHhOjozvPSWaGerw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2186e88-1ac1-4c2e-1501-08d56b30409f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:22.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
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
index 282875cf8056..8254c937c9f4 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -168,46 +168,99 @@
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
