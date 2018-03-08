Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486307-2-11770935844337623522
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
    t=1520486306; b=mT8mtZTX9Af0pteuO60mhcQn65QPuaToY1r2S3uBQK8OjfO
    ZE/fQOH1oYUl0LnkyxbTQBwfOq4h9QhJbkmWUbtapqRB9Yp8DUbIB/+PiKY7/X9s
    h45LVxCO0F8V/RIF1k57MEnwZgqYrWLkOZ/umNQIhG8UFCEh9FCCMw+RdhlqRP1A
    lfgQU7/TazNnp2yHRU+iNNZHVIys2iIY8mXF6C4aLb2E/vm9qbplAx+OhhXQrKdr
    FJTHwBruGeZhm3bqZJ2o0wVmDYdseMjL/mdm55zJNkVD6jtGDvDlyS3MnL++W7qF
    IvqTn8cEOhaMVCwZUPhdHPsvMBJNFZ+N9lwOKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486306; bh=EWU7Xt
    acpp2A3pTCxiS2fgr0wtY/iDFNjAjiU6wmbOc=; b=h3CJToOgasDUGxEeDdP/b0
    etJTeIO5iH0L4D9q/USfN5G8+DWt0GWCz0DL95HAlOuVYyHGdFzmltSCRMtSXqjI
    dd5uATXZRR9pBbJrrArK17zNM+wuw/v7JeuAdKp5joDtHTz2e6n43KSXTwAHdsYM
    +t7tOMcYYsAHgZ/6je7QABHulXRhPn92l+J8afmJNyU9fs4KtwHjLVsEc1fQt/Fw
    QrvNnmyxZPJ6BrqFCI/tlkzG490ZSHgSn/nKUsLz3tYEijCYmANak4cAWi1gNHlC
    RWtORr/wO2bAP+yiXV6IhHijdLk3ixND5OPM8uLqU7qkh3ZJR7BScnoETz8pdrwQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wm/Tfxab x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wm/Tfxab x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966795AbeCHFSX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:18:23 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966445AbeCHFIi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Ahern <dsa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 15/53] net: ipv6: send unsolicited NA on
 admin up
Thread-Topic: [PATCH AUTOSEL for 3.18 15/53] net: ipv6: send unsolicited NA on
 admin up
Thread-Index: AQHTtprCSUBWk7LdykmfQn3freIutw==
Date: Thu, 8 Mar 2018 05:03:13 +0000
Message-ID: <20180308050230.8876-15-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:fcR5U9xTdUOeHXMkaJTQ7av/9ZCJ1xE1E+uXkdFcMp3bEFJedO7H0kpba4smfQtGAmHJPnnU8KKsFADbkQbo1JiAYpopZqqot8E/OK7etjdXRF6F+iH+UYdUqfGwe2IFSHJSeDNealC1TgOQ6L6W0HjnCwqU7d2Xs64LwSJKn85YoEX9rce9CrE89QHq4yOfuOvPOdUzP/N4XcFRwjKwJHb0TXDBkfsV6P/AjPN2WyITWgPooAwOi0O4Kc1wXkaM;20:MwDfBefiqelf7Zny/lNuyKhGtV1jOkbfjFP3jaTNs7TGM5QzcO79cNiwv8D5CjbEaPQ0avsomGJ3gdg5evy+Ypaau2tw9bsJLgr56C5SvbCEJ+k8ulMKeWkC6FBpkTVMx1Mkrygz/g4iZngq43TIKPDRLr4f3ZEncTwDDX/3Af4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 171ab953-4bbf-4ccf-3f66-08d584b2a5a6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871FC4BF2DEECE25B234AF3FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(575784001)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 0CEk08bQh3EJG7R29M3E7bXZ7ZnWdPOUe41CpaaT9iZhcqWCnGEP+5MYNXKJRD8FV0K1iAg8EMKkbjU4bMsLOJ1v8HOy0vJkk5eFQCZQTnfl6ZMGawsFWUVqIdmaFSWX2X1QAq95qk/nqa8/QlSxMwSk+zR60gNRnmHg/OF9l8A6T7DzWia7rVtvgeY7bBi865DsdFEZVBcRrYZrCwNTMFKXYfW74wtrMX7+kruFIYXtktAVhpSzTLH9pD3qZLPVAN0ix9XR0fepPzItZdvOvBAj889SgTt4lthg2b38UyB70QmYSkNsm+n1PW41aiFeABhmCEHQPWgk1CHG6tOH0A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171ab953-4bbf-4ccf-3f66-08d584b2a5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:13.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index a46c50423aec..2e9e0af9e759 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1646,6 +1646,8 @@ static int ndisc_netdev_event(struct notifier_block *=
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
