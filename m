Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487773-2-15614603282675913584
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
    t=1520487773; b=MWc0MEeegnqprhFqeO18uPgf5lbDh0hqxxNrFx9cCE/pTaJ
    geIl/35v5taJAG4iqvgO9vVv7NKkHDeDVD7L3tvu/a83Z12yNRF3IPeb/iKuPamd
    NTQKUzxlcNNvDIJ018LgF7P+A5al+FeviKYuheJq0vlaaY1bit1XYx7QSj2VmRxg
    pmITm/BA+9raC9Chc48g7vhg6+BEjVsyPlepygoNloBQexZVw9lI/rK+07WG6zMN
    tIxfWFkwPWzab45RhFwC8UzG9RNZiZ09dypgucBHQJOJdG8yT7jC7W4dcfUHzBZO
    8C3lO7kw4RPfXyKD3O6svQ4edV0h56xJG79pdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487773; bh=ym8fSJ
    gRGL8hpJ7QBym3uC1M49zbaNcEVpwgpVEr0q4=; b=p/0u5yE/ic7kDZX1M1kJXh
    N+LNTVvT0Yf7ht90IpQ1gSRWASDP3t2CYLSsiZeahU30/8jhAXrycf+VcXIrutCM
    WUX9exv6mexLKf8mDKBraTTaauC5jxiIZ/4NkskI45NDwJu2hvbt0Xt+XGipQZOW
    /u8jaN3rAH3Txzg4z1NqSJQmpDCN8fxJbv5WfKhbcW17oHx6hXkH9YVISgfsprZ/
    gagANsaAxmAZ4kBPlj9u4gZ3B7l1+RaHGokI8vKfKBDruEGsRgda8MVYNcwTNWRv
    astpaYUyhxrITho1H1xiz16PG/0y54eblTvmPR2NlQLwXw2tvnUVlgLlwKxRzPBQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I0KYD0pS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I0KYD0pS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966217AbeCHFmX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:42:23 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:57824
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966212AbeCHFFV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: David Ahern <dsa@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 022/101] net: ipv6: send unsolicited NA on
 admin up
Thread-Topic: [PATCH AUTOSEL for 4.4 022/101] net: ipv6: send unsolicited NA
 on admin up
Thread-Index: AQHTtpqHP4d1vfBaOkylbigukQpDXw==
Date: Thu, 8 Mar 2018 05:01:33 +0000
Message-ID: <20180308050023.8548-22-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:xOwyw2KIVKi1/qS5CVrF3EbamWodJLCuWvVsW3luXXYJFPtP5rxDUpV0lAtrm3iM4oWIaTIVBNfemvDQ0PCxJwaNcTX91w97JGlX9mbfm+v/C9t3vX1dvsLlsm+ysZi1ZFBrum99Pug5Ulek+uVkFeolGQlJDCkgHe81Hz//kevzBBf/HkGaxYMRbpIbVXyZpWuIK5da5Shm5/fcYbR4+984E0deCyQNGGzT9t1n/YN1ImDGwxYsiQJmVK9P+T0e;20:MtIps6vRAVn18R/AB32pU3cIUt2bUM9EM9HUcFyh1oQuULISoFLj729y44Ckn2l9An79X0CNhAhpbGcqKJ8qm95EiZRr5qWAifHD0Rq1lraU/GxorHk/gisVdYytX/1JD1+Ppea8neRVlacTFNwwm/y39MYmnTnNb6p7Pnqlruk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d8202e3-1378-4097-4e84-08d584b22d17
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07273F07746230B6604805DCFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YvBr5uzhutMEcYXQ1q0wi+iPHZ5nQWMf323BzVFpTIHhCP37D/Epos+5G0iUm2E9IKvTqF5Ok6vVGOKPFhZ3w4+1k7QuIa8qQhjjC6ABbdRepZsRtkm94QdP/WG1Qnrw8/ZMwHg8hJoLo6LvPOPEO+v6lTttF7ilrfM4T6o4PxBfOeNcQ2af89p2cd3k8qHIgq49twLDZ76jIj/uVJxTkXF6ASsRHHF7n4YX5gUGMpCkprNd8eCvP300op+dEBC7ndvj83rZ1XEHUExzPcvOUQVQ4yHsZA6gGBzt2B+lxjhJkO+gLf6FDLvScZoAEZeHiDCsJ7wQ35ABes9DFirr1g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8202e3-1378-4097-4e84-08d584b22d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:33.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 84afb9a77278..55810e4899f1 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1686,6 +1686,8 @@ static int ndisc_netdev_event(struct notifier_block *=
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
