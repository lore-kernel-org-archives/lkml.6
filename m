Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237827-2-13849528911084606269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237827; b=fgycIPfmRGeE/TIJhS0l6SFypo/myN0OCuJ1EuYlCuJKjBmvh8
    oiL/B+iweJ/5LIWh9NTXkI6s9hLoT3U0yclCOw5JXv3PeAVGnPof5bChsZuKk7tl
    w4kGMMHlcr9jcw0mKMPUx781pAxtug95qzWKtvoFP85qtliTQfPgrklNieNpOMvc
    AEl3z5kOhp4aKXms2pjyRrF8t5CqGczh5o8snsIrpQOYrbKWS1z4nQ4xjvCQdfMV
    m08IeBSkgYkJMOOlRd9cfBHghD/L6/UV+VCS7UsCyHCVIY0U8iwoBc/f9hWhIi31
    cHz56Bqh+Zl5oAYK8I4vmlEUVupNPLp6s0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237827; bh=Hj1IYhqL68
    jUFA0ME/bCW6j30j2T0hKXTqUh1pXutXg=; b=NdFbFha2IMUhWS7T541wTZ/QkN
    9qVhmHWcF5BvItX4BxG+yag6VdnrYSEb5bVK1l//USQJDb7RpGDes9D4BFY7RWFF
    1Awh7PiM7d/dbru28D4BYli1rOyjg4AW3b2twabc3jAaAH4wytSxMBJyxusXqzhY
    GHV5VSdyTzDZZQ+fKWlzCLjnBNx/m2Z3kUo/D3Mpctlz3QmsAGwPugkghj3lUDep
    C59NNTrJmTX7v1yhRb1Yzqsm2kCqYolD+ypgPlnWvoTcIvA8H4wKGQnz+YQV4K/r
    Wd1EA07wDl0D/fcN8pvmIry8ajYvqBtPlbSECPsUbq+ao1fXfOuVVphMMaNg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nAHLqtsN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nAHLqtsN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF3cdyrlvf05ugtQhNqR/YPvTcvtlz3t8oqQzzyeRojZoXbi5FSLY4mKlMtcxGhjkA+pl+4N1BtjWM4KbbiuEssEnyooPIQa+pTef2mmomSxoMg7Pkk1
    hbsLrBl1mez26Mc6WuhhE9S3i8XqbEdtEteDEhOK3jVDeEqbo++HWkZaDxQ+yUWL9WvQrmPEEGtcIBInj1OXRAYaq0NczRtJ9iMK22naIIHWgqjUtAUtRCd3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=cBQ9SC8uRl-JxL1Nw4AA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754839AbeDIBhC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:37:02 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932569AbeDIAfE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 017/162] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Topic: [PATCH AUTOSEL for 4.4 017/162] cpuidle: dt: Add missing
 'of_node_put()'
Thread-Index: AQHTz5maZS7fJ1KZMkaQBBHNb9UhBA==
Date: Mon, 9 Apr 2018 00:27:55 +0000
Message-ID: <20180409002738.163941-17-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:RJkRhK8lu5vPkNjO+7WauBTpyUOPyjx1+bsPQ9BXpNVXpGeoCRWXQFaWYlucT/pSjqqSU5CmQpKwWF/WvMY2OSgVOJO7iuWQw0ybU4OpWFux70QGUzI0BPVKPnfFIo5u2KY9zc3ClUkwCOGtq976UMEcBPXGGv7Kx/DGkbFd14Q/ovZe89GIryaIZUEKsDYwxqQd0zIBJ0PSuGzwkUNJhTDBw0zPtiNTc42h0HUNJmIXwRL/Z/quKWYjupE7t6a7;20:tPlvMwDkEmsuHPParYI9jXQPQ/nwwAYydpsjcN/1lV9xdl4veVchCjOIM1EkyVDZddWMBRP405erUbRM8b0WpKD0i27ln+IgyammyzMmC5uEMAsno33mvkHqO91T4uM5dJBluLjop+7dliuJCwEwIcPdtlm+JR7ex5mqMLBUQr4=
X-MS-Office365-Filtering-Correlation-Id: 4a21d2fe-2fed-4e1e-7712-08d59db1ba1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013B7F4AB746561EC346529FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yOF0Al5aeZNsxT3EavW/QU2TSw8op9aDNa5Dla/L5JdTgR8MuH5gbe+w2UquQP/XXHYU8vIAOaKsGunM6lOVuEcGC4XBfDO/AWc2y5+rj/ApucAMRGly5Z2M+BINN8er1KnEQ9YX8EDPaid1YKWd4oge6zdA+WphIA30N+DemBmGyzUO5To93Uw4oMDBUVPEQ2oZFrdkcHmb1V609gbPt6OLIaVcN3Atm24uzhEAKEnzFFXVLZUnIzf+V021H3+M71ogmS7xdwSTre4k0RuscA0mfQv2w4Ow3YTTfSTSGP1hWRMgvCUqASs8tAbpREZ53wn678rd5Iukyr+SeCGB7eiAGy6vRRLpmDKaKPrtGTodAZ9kpTMr29Edyowtqgs4m1x5D1cjjugC4Zem6sOq1+zk03i5aAGuWPA0ZnvCIfk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a21d2fe-2fed-4e1e-7712-08d59db1ba1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:55.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

[ Upstream commit b2cdd8e1b54849477a32d820acc2e87828a38f3d ]

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd (drivers: cpuidle: Add status property to ARM idle stat=
es)
Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/cpuidle/dt_idle_states.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
index a5c111b67f37..ea11a33e7fff 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -174,8 +174,10 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
=20
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
=20
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
--=20
2.15.1
