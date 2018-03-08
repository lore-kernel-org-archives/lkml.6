Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490332-2-13243286912182657747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490332; b=U3xOykZiJJPGCqwMrsxm5a2rOQyH9kZnnl6Zy6cjDIiieqj
    NTfU49/jllH5OpD8iZDInixs282VCYGF1Czb+1fr4OPkbbEJnHxi7cLwuSXumf/d
    VjGHNXVAnNAqJPh7B4tLyfGbJGrMgOaHck+C4r8SzMdbLEhPDQyExwjCFEESVtrk
    FrGJtzFI6Ou+1NypCtJh/Meg1HckA4Aetn3NLa5HMqN/MCqyyyC/TkNfifvopW3E
    W/JeUFgNqCwloKKa/SxIyKt9cWT7GUFYgNinqFAZxjpqF58lj+AhmaZ4o3DjGXrW
    tmTmv/qKO9Yf/48dyJQLr2xFrADALkzGt3FmxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490332; bh=ax6wzc
    raW9jegr8SdfvgrxRlDAKOyvPhA+iGn2YgQbA=; b=ZIGQbLdNLftCBgyI+xlnoo
    M4AJjvGl0iqHdtmHv7P3/7lL6yNGnEaZ1JA0rfnt61ciXTRcq2RAFfGrnyzrQyjn
    kkcZRM8BMLcxcgsYeSyhta0XXwD6uYxWycESS5j160pj0VIY47FCZzfJR/d3qAzv
    GLR08dVK5QMJhJTi4dknKrfioTMESjVYrfzqIJmp1om5Nv051UE1yoN6QcJwcJU+
    irylwHWnWNpEN4tGNG9UpF/9r32ebu5a3LDE0t0ljLWknjKHdeLzlMqk+UvHWrnV
    h2NGqwmHCf01elskBoovnrP4uNX8sYylidl1aT4ZJ2ELj7GU/qAxMFYTbl5f8M/g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAYpQ/qB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAYpQ/qB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965025AbeCHGYt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:24:49 -0500
Received: from mail-bl2nam02on0102.outbound.protection.outlook.com ([104.47.38.102]:47872
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755325AbeCHFAo (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Ahern <dsa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 038/190] net: ipv6: send unsolicited NA on
 admin up
Thread-Topic: [PATCH AUTOSEL for 4.9 038/190] net: ipv6: send unsolicited NA
 on admin up
Thread-Index: AQHTtpowPAjT+SaZaUCzC85ouzFCuA==
Date: Thu, 8 Mar 2018 04:59:08 +0000
Message-ID: <20180308045810.8041-38-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:jbKaKZjg6R4qEOFIWQEIqYeXtEhiVEpHVt0tV4o+coowpGDoZm3DClna+O5rX1NKkxELSWm4HQS2H8ASdBIyJy7qjHj5liDYrx7cMqD3OCD/08T0hU1/gqQumsHZDFBp1Y7jf933SHaAJ+JJT2Rs8o0hhSnnZxCkdU+zkPOIfuH0e3CUIY+IBg5am0iLCHCtE6TnjKKSv2zw/jyR872/QAWEgV4lkuu0ht3Y5r/NKzylvk5HpTEwJc43L/zl8yf2;20:SvtZoWFiG67VeoZHQUHbprAMxjOoBc05GXo84/Z3EoQwb3BYdItzp2L9KaQO/TPy5K+UFdQmEmzie2Za3HdTKSSvm+0BRExFvP2AAYqYAgfS8S4QNpBqqlVGI3BkuTu3eHV2Vut2uIV5q0+alEUwxYEDRmJZVe7/RMZ2H+Gos1c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3011f326-b494-41e4-28f9-08d584b18988
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112F36267CDD71D2D5C3681FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AoYSpJqSCeDrIE1QM+N7XHTVw7sNIpju48wDI5eqw2q874Gm/YbzKsckj3efA4wjsaX83DfddnKdoxUN/WWru08NWb90OZqemQF0c9lwfshrBxUzRLRjhanqw+GBatN/nMfOPAgsCzV5vIWQ62PPVe+9ncWzkgFJRA219xUijC8FuaVkyJGr/Ts8xHfUhfWb/yIIvG2wz+NkzD4SqwFzGtBqjRHp2de+mxUCyvom6QZF12/9ePBoa+JrxvcjAvH2nQ7E/gsj3O+SsyVUja0mVBn++DvY0GKvzdh7ScvX3ycaMxTl98oQCMYa/avr6oKCKhtZoYGMq52N1XetZrmtuQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3011f326-b494-41e4-28f9-08d584b18988
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:08.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: David Ahern <dsa@cumulusnetworks.com>

[ Upstream commit 4a6e3c5def13c91adf2acc613837001f09af3baa ]

ndisc_notify is the ipv6 equivalent to arp_notify. When arp_notify is
set to 1, gratuitous arp requests are sent when the device is brought up.
The same is expected when ndisc_notify is set to 1 (per ndisc_notify in
Documentation/networking/ip-sysctl.txt). The NA is not sent on NETDEV_UP
event; add it.

Fixes: 5cb04436eef6 ("ipv6: add knob to send unsolicited ND on link-layer a=
ddress change")
Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ndisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d8e671457d10..41c22cb33424 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1723,6 +1723,8 @@ static int ndisc_netdev_event(struct notifier_block *=
this, unsigned long event,
 	case NETDEV_CHANGEADDR:
 		neigh_changeaddr(&nd_tbl, dev);
 		fib6_run_gc(0, net, false);
+		/* fallthrough */
+	case NETDEV_UP:
 		idev =3D in6_dev_get(dev);
 		if (!idev)
 			break;
--=20
2.14.1
