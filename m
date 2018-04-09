Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240866-2-4051491086042820681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240866; b=v6PpGC1U2NFp35xsZ0TXPrlmz/zG4lIZidueabHEdtcU3IagZT
    pLYEt31IXBzTVh3gyrM+gaiqnsnUsAvuu9G7Hy4BXBuzqFA1Vnr82Gs3iCbUqafC
    NxhQAOBNW2qQze5pIqonCfALwpK5rPSWolUq+DhHou8juTS8rEWV0XahuDlNC8pr
    bqIghkwAYwwadNCH31uO4s2bW5SjhWCRh3aZcTv41y9ndKQLYrHmNB1e9CIlY7E/
    Qnni19hXX9kmGeWFL3jJCq4ON9Okj+BUfdECxN8LByTnEaQ+5zdPPrZEBzHtnvA/
    otNj7K9uaArIdWBF7vmivJq9G3WMVgwLYDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240866; bh=6PJe70N0eE
    aHYtcq/jxVcmnIkhgH5FDHBOL00zuwDsw=; b=UnlkGEeGqtTgdRXphkNg16uQ14
    fPazRyM+yhb28y8x0ogahWBZ7WnCkhKbFWe+s0Bm4l9Cse6yh4Hfn6ARt5GX//53
    IXnXeHJrgut5Jhuq7DxXme7MFbE+tvZ7I5HWMpk7hZwXq4ppcLtBPJBny/8m/tLs
    bjTNaUn9EfattGwyBOJr/DfkDrDuGFi3G9lNF6v/QKF3UHjxDusegtIzw1csix5d
    NR+bzHec7zxZycSJCNafgMHo26XwaG0oROfFg/ZoSDnr9RsA/YV2BzRgKEztmkf7
    SiV4LAyS7EpfgYYTz3hIdzMS9v0t/+Ux887OUiQpXrLJFHrZhN8NMgtJOXgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m/luptnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m/luptnC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLrXD33tYOoQpYhVFAFTbRfLYDalzj1dHky2jXySsQVbI0dxUPOljVyaj2+uS8P+pEwJj+yOCNHp7/VnyRcgF8tTOafhdsqT7OpIYSG7Y13gUa97nVxi
    OJbXvqniHK1s+ULc4P/F5G0t90uoZvRk7ByVff8BA/thtmANj8Yo5IUU5vkcL0lxXDcnr/jQtOqx4pFrBVBgR/VjrgtC9aQHvOpQL6LhxvX1QNmXT3pLUg74
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R5C9hjxsAAAA:8 a=1XWaLZrsAAAA:8 a=P8mRVJMrAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=Xs3aoZ8RMfsy61njctYA:9 a=wPNLvfGTeEIA:10
    a=KpS7wOGxO9l4JKx0McS0:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755907AbeDIA2p (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:28:45 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754337AbeDIA2l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 085/293] ip_tunnel: fix potential issue in
 ip_tunnel_rcv
Thread-Topic: [PATCH AUTOSEL for 4.9 085/293] ip_tunnel: fix potential issue
 in ip_tunnel_rcv
Thread-Index: AQHTz5kOTo2hW1SFRESfKeiKN7G8Aw==
Date: Mon, 9 Apr 2018 00:24:00 +0000
Message-ID: <20180409002239.163177-85-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:wZq4bqrmAbHEQB3NOnKRl7YhIvfv50qvQJP8GOweEyJtfK8Pu3OpojExUIYMvPuv5pimI9gPQLiKXP3y2YrpO/17RyQiANqGEL4Zn65S8DOgpArbkkprQm3jvXkwLjG4HIPpW1KsUx9voX9tCnD8DoCyeCZ1ERPX9KNd3IeaWFpzJqiFEsTcaVM0BGMaRhWOiyLbfG0BC8Cr43//NFBZjoWs2aM5xrEORhRBJmmGRZ1TYLkCD1v+kl3s4hblvmrI;20:IvSsixOOFmIIZJ8lEbYeVYAWq5zVdL/CgpwBMHZcVxA0yzG7CoN+8BR+NUpOd9J1jUhRmIw4s9QrcUQivmjJVKCKLPjL48RrIELssVHu4JvCdm+4szAWQkka/VAGJH4ilRFCz8nBcAPKFRCEW6y2JQoZEDh+XPMRBdtW8323oZk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a3faa4f-89e3-45b1-a70a-08d59db0d443
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807ECA7FE0F7EFFFC8081B4FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: HFWJbsX3FMgkg8QEMfc7qgNf5pCmzNFivCt5woaROs+yZLc0Yc3xSi9IAZU1KDjEwqkLztdClQ78+9E0KQfEXVwvfALySYyK+q/OiuU4ggK/mLjDQuVY50QrcPreLFaDmOSL09KuLsSjUQyB/Sb6uwmFLF94Tr28we+nhBXW1CD7iZP6AxDjGXskSv+KfegaGUDGTzKI3axAb91WpV0Ve8knCNYpG5kOu/v+IFpuu5hiIXg4X6uodfCCJjpcCS6uLRToml7u801FitQMwH80V/9e1z0BnCRReUho7FF5qQ0/evRavXlliNOeikuz2aP4J2QnzM+9mFQ50Up3BoDK/0j++6jkDpzsNwh3w5we+35I2CIryLbotxwEIYVo8z36PdlRwMU+W+4PBX/c3XtMcurpDLNFhwbc1bA+dDwgH64=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3faa4f-89e3-45b1-a70a-08d59db0d443
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:00.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 469f87e158628fe66dcbbce9dd5e7b7acfe934a9 ]

When ip_tunnel_rcv fails, the tun_dst won't be freed, so call
dst_release to free it in error code path.

Fixes: 2e15ea390e6f ("ip_gre: Add support to collect tunnel metadata.")
Acked-by: Eric Dumazet <edumazet@google.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Tested-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/ip_tunnel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 96536a0d6e2d..a665eaab5db2 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -439,6 +439,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_b=
uff *skb,
 	return 0;
=20
 drop:
+	if (tun_dst)
+		dst_release((struct dst_entry *)tun_dst);
 	kfree_skb(skb);
 	return 0;
 }
--=20
2.15.1
