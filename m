Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121393-2-6157328437407992006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121393; b=X24oG4rMLA4iiYRHTau9rVOBQFpsoU5vT8AXEtU7Rc5If24
    R4QuqgsXTLbPH8ByTWy5CUwWCiQlWOnJwmvAkH3yLh66nPHdsE/lTIZ3QOFKmOYl
    tv4Z2jydRUA3KHsvn9IPKmyID9/mwA13yGkJWqzBz0o0IR7qHf97Y/4G7fkE3OrP
    HpIN72ERXY4aP5LjJGChtfpxvD5dCWtlK5ZMbSNgkhvgn5yl+9WOINigKmFdSQzx
    FkRW5Ip2GI6hg1gNc/o977ShXJEdUX9+QXUGQE3dQGU4dpj3F2aOaUtTZvXK+rjF
    Zzic6PtxD8QLGShf/r9ZMNNkBzFvp8Bgz3lddRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121393; bh=JZJMGv
    4IFT4NmV2XQFD1w0wd3cJ+PcLAVlL8NOpErds=; b=Cu3/eugvBcJFBMRXhDIcG5
    Du/fo1Abmdx2OGZAoiht8AvBigqc71EVoYk7ylDvf7/f7bP9xVBWX3cLjKBJA+gu
    r+rFDiIdEWEEmJc5ehzfC2gZ4iolsfzJZ8Cv/fgWk+qeEt+/eQHvxrABvdmypX40
    1gY/It3ON7zKeKgsWZK4WKChrpejq6l0Ol6R8OXoN33KkoWWL/irg22lHm7NZzQM
    xDcuSDHiU9PFxxAweRUFSfFMGarFDw0uQ64K2b67+Woe7FYTAPq8E6rTtl5AgED+
    uwWt9CgUhCmxXTp8DZPT+Tp4jUm9k9KUlZ0IEfhpo3wq55NYtpa+7Sw1MI62dolA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Js8BU4zV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Js8BU4zV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbeCCX4Q (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:56:16 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933898AbeCCWcy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Gao Feng <fgao@ikuai8.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 066/219] tcp: sysctl: Fix a race to avoid
 unexpected 0 window from space
Thread-Topic: [PATCH AUTOSEL for 4.9 066/219] tcp: sysctl: Fix a race to avoid
 unexpected 0 window from space
Thread-Index: AQHTsz73/P0X5bkOO0KFo9zMB2xmUQ==
Date: Sat, 3 Mar 2018 22:28:34 +0000
Message-ID: <20180303222716.26640-66-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:+69PQ6AJIDXg6Nx7KYeNddUrXwn4dhscZ2Q91VKewQ6R+UhPul4/1StzxrEh+ymvVkTYsg0P1ss9jjzaYW8P63udLRnrLo2lpaHLj7IDCGnCI/smkZkvOEKRSefzmf6d+K/W2p+4zkBJR+4DBv2FGmyHT1mk3qIaFF3yU4Y0chnKrVydHahcqVXjUH5QZa4UW1uw+fQbx5stZ+r/LvwXRXj63PWVdEfj43zqYSUYo+q27QBJLFHiElZKW8HRuXBJ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d03ba52e-f34e-4b63-d0b9-08d58156b336
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1098378CC517A4821F163D5DFBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(575784001)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mHjOcu/qBTu1LKyOzi9E8KHraqgjeICS44iGM2EJZKiV2L2/SCYHyhhrzAQ+uI3iQFtEMQfgq14TQqAmAJJDgodO4/Vc8ZqSb9tVpKniYSh29/1FiGezlMjgTrwb/bk4TC6J563sfVIYF8BhFv86A4vqMVDbMKMNhp1OpuSu3Go=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03ba52e-f34e-4b63-d0b9-08d58156b336
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:34.5256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gao Feng <fgao@ikuai8.com>

[ Upstream commit c48367427a39ea0b85c7cf018fe4256627abfd9e ]

Because sysctl_tcp_adv_win_scale could be changed any time, so there
is one race in tcp_win_from_space.
For example,
1.sysctl_tcp_adv_win_scale<=3D0 (sysctl_tcp_adv_win_scale is negative now)
2.space>>(-sysctl_tcp_adv_win_scale) (sysctl_tcp_adv_win_scale is postive n=
ow)

As a result, tcp_win_from_space returns 0. It is unexpected.

Certainly if the compiler put the sysctl_tcp_adv_win_scale into one
register firstly, then use the register directly, it would be ok.
But we could not depend on the compiler behavior.

Signed-off-by: Gao Feng <fgao@ikuai8.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/net/tcp.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index caf35e062639..18f029bcb8c7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1265,9 +1265,11 @@ void tcp_select_initial_window(int __space, __u32 ms=
s, __u32 *rcv_wnd,
=20
 static inline int tcp_win_from_space(int space)
 {
-	return sysctl_tcp_adv_win_scale<=3D0 ?
-		(space>>(-sysctl_tcp_adv_win_scale)) :
-		space - (space>>sysctl_tcp_adv_win_scale);
+	int tcp_adv_win_scale =3D sysctl_tcp_adv_win_scale;
+
+	return tcp_adv_win_scale <=3D 0 ?
+		(space>>(-tcp_adv_win_scale)) :
+		space - (space>>tcp_adv_win_scale);
 }
=20
 /* Note: caller must be prepared to deal with negative returns */
--=20
2.14.1
