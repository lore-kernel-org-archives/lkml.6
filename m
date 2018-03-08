Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489588-2-2811610349701841948
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
    t=1520489587; b=nB9P/5lTbSsJE9GWjCCshGl6BzvBLGg7xozvHdCjummZJDJ
    GW3EQ2vXCk8coXTOfk4Rlz55LErrrnH2Nv/EPnJZgs6FqRobsD6ZN9z285fXTNzV
    IX/F+PNk+wWJMmZDr8qwzgJ1sxg9Kotn+wg6GQYbTelE5WAssx0yAS2pgfvTDClH
    lVAwnUumjQUmOEG5R8zaUMIM8swnKKPqGiP/qcjJF+tTeOd0xI3lITRxydDAlORh
    YtJiBKbQd1m5GHQS45h8ksPhq/D5grDRBwQcUKlCv8E2CUo2eJla3tWy7LBav16d
    DNJBOgyvU3gFwAsRlqcCXH11Zia2f4cTOhCmbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489587; bh=8BoLK3
    XV4UCUs/V8cvDZKW9KqZljvmxGoqUhEsN+T3A=; b=JpYMTYhHu3TQUfB1s/FAZP
    +rdCoj2FPGPAtWDJ8eqL6AAHOGO7NsTTnK2xlmX7CheMv73japbqymBctGJeDGZk
    J4Hjq7RvNPnfSogiX/vQ5S+lbg+TveCPQETITCUVqMrobTyz5YoAv6VTPmL2nFt3
    QAK+N+q/GrS22CRBrtBvyek5TF/0KLB8GabGsB5UPHsj/sdA+W/Mc83TaiebDafC
    CXMGMy3nekxngIC2yqZk7LYdMEoshx2/5vWb8wvN+lvSJMN8fL6M+O0g5jLcmh3o
    p6AcRJydmcGv8/o/AuGwgDZcjWnMIORgRsYaQC58fLs+h6pc+0MVIiJOvpioisQg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b8d5VKsW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b8d5VKsW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966029AbeCHGL5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:11:57 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964955AbeCHFBf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:35 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 082/190] netfilter: nft_dynset: continue to
 next expr if _OP_ADD succeeded
Thread-Topic: [PATCH AUTOSEL for 4.9 082/190] netfilter: nft_dynset: continue
 to next expr if _OP_ADD succeeded
Thread-Index: AQHTtpo85TY0UYjxaEySUNbMjMDMpQ==
Date: Thu, 8 Mar 2018 04:59:27 +0000
Message-ID: <20180308045810.8041-82-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;20:6stdD/J0a07PFmYxIY/A/W0HCiUuC4iEqMLslOTAP7PUXC3L04soFiTHSeD5/AmzxUDC4S4Fu699YY9awBpP5bxoLgrgrtLCl3pF2Wiogj+IuJjbiJafYdIBfLjT7bpKMputxbLhr2d68EPoLc3dD+cmFwpu6BN9GzRrIHe+/xE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da0b89ec-2a81-42dd-c859-08d584b1a734
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099957EFD826429CFAFBAC8DFBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(85827821059158)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(39060400002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fu98sUM2A5mqDQOTtXqyHQ0vQ5PzPzs0PAZ9/SxIJtCDOnxk58vkrlycr7VVW5lOIlrGSiH5+Mp5gUWw8FFLRxy3Av29ya/moaCSM9rwkzGgTt3ctDiAKCTtgDlsP9/zDM7vbWm5Q4sklCQ8Z4sw64sauswQAJfWbpWR4+MIMDlMDqByGtELfpZZ7O2+qDAQO6RCE+Tz1TyGU1ssW0EbbNmkO1g02FTcHC/wtfL5oeIBAouUp+VeocAUxWl6M6PoHw0OazJc7zCOBLEotlGX0NjtkSd25WoYQa8lvjs2jL18pEa/yj2vKP8CLcbASXx7gtWzuW+NqxQUsMgu6Ua5Tw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0b89ec-2a81-42dd-c859-08d584b1a734
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:27.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liping Zhang <zlpnobody@gmail.com>

[ Upstream commit 277a292835c196894ef895d5e1fd6170bb916f55 ]

Currently, after adding the following nft rules:
  # nft add set x target1 { type ipv4_addr \; flags timeout \;}
  # nft add rule x y set add ip daddr timeout 1d @target1 counter

the counters will always be zero despite of the elements are added
to the dynamic set "target1" or not, as we will break the nft expr
traversal unconditionally:
  # nft list ruleset
  ...
  set target1 {
      ...
      elements =3D { 8.8.8.8 expires 23h59m53s}
  }
  chain output {
      ...
      set add ip daddr timeout 1d @target1 counter packets 0 bytes 0
                                                           ^       ^
      ...
  }

Since we add the elements to the set successfully, we should continue
to the next expression.

Additionally, if elements are added to "flow table" successfully, we
will _always_ continue to the next expr, even if the operation is
_OP_ADD. So it's better to keep them to be consistent.

Fixes: 22fe54d5fefc ("netfilter: nf_tables: add support for dynamic set upd=
ates")
Reported-by: Robert White <rwhite@pobox.com>
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/nft_dynset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 31ca94793aa9..b9dd4e960426 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -82,8 +82,7 @@ static void nft_dynset_eval(const struct nft_expr *expr,
 		    nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
 			timeout =3D priv->timeout ? : set->timeout;
 			*nft_set_ext_expiration(ext) =3D jiffies + timeout;
-		} else if (sexpr =3D=3D NULL)
-			goto out;
+		}
=20
 		if (sexpr !=3D NULL)
 			sexpr->ops->eval(sexpr, regs, pkt);
@@ -92,7 +91,7 @@ static void nft_dynset_eval(const struct nft_expr *expr,
 			regs->verdict.code =3D NFT_BREAK;
 		return;
 	}
-out:
+
 	if (!priv->invert)
 		regs->verdict.code =3D NFT_BREAK;
 }
--=20
2.14.1
