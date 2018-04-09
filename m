Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233922-2-14974616606686764982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233921; b=YaoTEkDOEYwHfSOum+z4NJYpFJ5xocK6XBz/ByFkHwB5V2KAG3
    MmWIlAqRIDgOmgEK8wu9XOPvCdHDWp6Q39uDXUBVBeIpCnsZxrUktYR8wqGKnxbb
    QxiM9D3s3dgBvZQfZVfSgGSlY34MiDgG/MBnoL4T9FErPlO2wRR+6LxxqI9TtG3s
    Njc7F24NUWwdVyw0UOqryAE5LgfNp68BR+3clmnXMmv7FsIIR9//9pin4EpNTk73
    h8kkR2BZXFvp0kzx4Z0V3vbRHleuMtgmFI8OEs2N1YVGSbfNCAvL2NyTw6+BP42j
    5kr++GdOCp57iF4RcsP8zePDmnWS8+Ohd0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233921; bh=cXHkeH6C9D
    Txw/tU4hldLPoQuV9wazRPXfuzBwDFwVM=; b=gtxqdBR9RCSSILOtTSs5EWZijM
    LSa3rxl7P8KjbXG4iCsSUJ/TVhMlVmo0DkTs4oExLRKcgHR3qEpkLCunOd8ykRBP
    HHPHDe2257DJN13ZjQ/A0qgY39hI0WagpQuzpPt0pwefk7GCAzhUJzBpFVsXUP7P
    vc/syiRDoqXcAKADyOEbWDhNqbSzv3oDkU2dx6vIRxiJDnVi4nXbR57KfW1WaW78
    N6xP+BZBVlRs02g+Ji5n8zLjJQcBCuArxo1JvH/9zloVPWE30NfqPHBXl6fCIBBt
    wQwyF52KAxqga4viOS3zCQmiU3SVvI+oKEv+JmmrgjdrrZJtVVNcNpPmLVVw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g3F+DiOZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=g3F+DiOZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAo/kU/5pZg9qb58DVWbIe6BXgXWPPZiswlWF6eANaproJYgmXL5yVkaD3lDNzsL44JjtrfYD5PeRfoFChSPxDE/lRJESHYbK13vL1fqE1JxEJt0yFUB
    6cbVOnFlhfRqTPn872bjenhqdw1iT0/0fiaKr0OAKhKt2LSgy7e/a6zfaIwij7TFrzK5Y21Yo4ZbeCa2V4176P+q0gciCaw6PfWivwWtWBzhYgunL0s7MaAu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=X7Ea-ya5AAAA:8 a=3HDBlxybAAAA:8
    a=yMhMjlubAAAA:8 a=JHwVl60Cq_uDeIo_v4sA:9 a=wPNLvfGTeEIA:10
    a=f3QdawHiMRSDlnPgGXNW:22 a=laEoCiVfU_Unz3mSdgXN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756361AbeDIAb7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:59 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755010AbeDIAb5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liping Zhang <zlpnobody@gmail.com>,
        Vishwanath Pai <vpai@akamai.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 182/293] netfilter: ebt_nflog: fix unexpected
 truncated packet
Thread-Topic: [PATCH AUTOSEL for 4.9 182/293] netfilter: ebt_nflog: fix
 unexpected truncated packet
Thread-Index: AQHTz5k7albMrjKOOUGj2/DewwfaWg==
Date: Mon, 9 Apr 2018 00:25:16 +0000
Message-ID: <20180409002239.163177-182-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:kS9TpIXGu/WhAHYNawJB5jWOgK/3e5MqGp9+bisu1a00TX4pJhaMJnjOTL4xajYzYhnK9ew5KrDg+dkcjVNaOkHYOSKjta/yWJGoLjYrwnQr55lVcD33FthpOceDmZM7VMbyUiwik1vfa9YDFWe753tSzK664nQiRuU/hYjPOceL2fyNQnIqfVqX9ynln4wyqcSoeaCKrvnkJ1KmdrX0wcgCVRCVOeGPud/yaMzRaS9YZC3VsSwZBbGvOcqtoKVb;20:ftcOM/oVZ564vrjNfhyI6ELezWAVI5Nb7gjfpH27vusM/wI5Ou3Y7rQWFhX58R6skJagrGxIAWFlPJurJv9b1HxAYCh2wz/s4RYt2XCM29Vyvo6LR2ROjUh+oxJ0IzfZJ5e6FzBXjx2IbDIEEHygnE4e8aTJx0BhVDFmghUh3A0=
X-MS-Office365-Filtering-Correlation-Id: f986f4b8-c9c1-4c5e-94a5-08d59db14be9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11263E3763CBA11F64D42076FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(39060400002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: IspximE+rWgot/iI1l7/BoeImAckiGqxjnnkO0vRbzUAx8aMYwXL4BAU59BjIQZ80tozTSRHdGYsTvK5WmtIOZyH2hGDlU6hl0CZ3fVWjBSj2524H1jo3upeiK+rgMOIRf4di9TRia3Ly32Oy1Wh8RIs9HhX9F3hRuwOePxi61Yi+gIoXfrqPn7B3BNEa04Nxs3c3W9D9on9vVFzDG1ylQQXCCpX17QdN+W+2cOJPCL3aeu3Q1+tmn8wpx8yBHw2dsKF8lerbKjDwZoMSkwaXOmiE+nEAsE2CjJ/dIA73rvJgDLeRV55Jv0GDtgmrHdyapA+lUdVFDSPGJhM6XOapdq6fCewFuZ8qnPP38xiBFDu6MBfEuYVnqXHmJ0cPBN2F6YQVBHAvIJxUC28jdiKOLxmFoiMBLnXgtlt1gcza68=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f986f4b8-c9c1-4c5e-94a5-08d59db14be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:16.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liping Zhang <zlpnobody@gmail.com>

[ Upstream commit 91af6ba7ff16bd7e5919aedfe70aad73a3375619 ]

"struct nf_loginfo li;" is a local variable, so we should set the flags
to 0 explicitly, else, packets maybe truncated unexpectedly when copied
to the userspace.

Fixes: 7643507fe8b5 ("netfilter: xt_NFLOG: nflog-range does not truncate pa=
ckets")
Cc: Vishwanath Pai <vpai@akamai.com>
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bridge/netfilter/ebt_nflog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/netfilter/ebt_nflog.c b/net/bridge/netfilter/ebt_nf=
log.c
index 54816150608e..16d3c8261b9d 100644
--- a/net/bridge/netfilter/ebt_nflog.c
+++ b/net/bridge/netfilter/ebt_nflog.c
@@ -30,6 +30,7 @@ ebt_nflog_tg(struct sk_buff *skb, const struct xt_action_=
param *par)
 	li.u.ulog.copy_len =3D info->len;
 	li.u.ulog.group =3D info->group;
 	li.u.ulog.qthreshold =3D info->threshold;
+	li.u.ulog.flags =3D 0;
=20
 	nf_log_packet(net, PF_BRIDGE, par->hooknum, skb, par->in,
 		      par->out, &li, "%s", info->prefix);
--=20
2.15.1
