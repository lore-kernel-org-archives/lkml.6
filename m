Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234334-2-12189858908075868372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234334; b=HgiLOPCB9xRpVWo3gXF9QK/kbWCr3g6mHg/sx4wTu6Wgn4LQmi
    zUEjB0Mrb7uYKNE3jYVxQdmdNQf9ndzqgKg8lfeCg24O/V3NBW3w8CavY4zTYq1p
    1Eed9I3h9CvHe4gc6gYsOW62omzjDkZeNDN0tGf2ASNG5WsIK/91fCsBT34S3EiZ
    X7wB0wtGt+qjYsLywq+oWXJRwYm/484bGd0d3+xpwLOJmmX6KCZr3gVCiCjdjRV4
    jVCB+VSY/WOMb+apCivZnbZ/SwA1KE1JCnF0Anh0PhZ1XLNuM5vaITVSUP42g7WO
    EC6ZF8hqrnDd89/gHjx4MpuYUGsKTAnCJ/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234334; bh=hepAd4sxb2
    Am5n+ZHPNqanFTBlUGgR/x8UzT1v4ak9k=; b=ltkhymbRb8iM6sAX1DCd68s1b9
    ndR6nW+uLPMQcd1GliHDUJP6+jDxiJ0RArJdaO8Yf1f68FgCUwDOU8OU6oFMuVpw
    EeKFgs6b898AoW2OsUoYEJZ7c9TUkQrzTW/iwjP4rlHvmuYl6Mz4U9oOU2r9SaJ1
    ocDfTwFZctAGTJpfymcF1S5G6XGXK297I0FzSidQ0RtK4yUQfCRb/ikP56NIgtOl
    cv7Xjym7XOTXFLT6y0Kyt/26u3I9nTDrTfLHN6h3Xs9LXTKfZpcvT0nhwo2NQa5R
    3OxCZ4IWmn5Lq+Qn0WqXwRxLBaFLWlf33J0LFSOsVMB4Cz0Ne1YB6eW5BHTQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fAcipMme x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fAcipMme x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOqeUuCFrzbPLK731f0oVbu4dYSzX10+9pyySL0AJqfaDAjeZSpXUGGzwjL/DP2qf3SskCY4J4s6MEzqxu4VCRcZ8XQmHDLfdSeMmzNoLrpBSDt2PYJW
    m0wwa7bau+jkGpwklO4DBvfYrHtO3AKTdD0G/bEN/kvWTu69Zm8iQsofquiz5S40EoIEMuzYfHr2q9+9O1838HIeGWk+GENRlU+xF5LK3A5/aP+2xTLNrfWs
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=gXLdhW2jAAAA:8 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=98M8BWyZpLcfewlxYQQA:9 a=uLeawkheiNOiJFPd:21
    a=yCE3bErIF824xLa6:21 a=wPNLvfGTeEIA:10 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933046AbeDIAiu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:50 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:43760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933005AbeDIAio (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 135/162] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Topic: [PATCH AUTOSEL for 4.4 135/162] ntb_transport: Fix bug with
 max_mw_size parameter
Thread-Index: AQHTz5nTWqoAfqJYUkeju//C5Jp+kw==
Date: Mon, 9 Apr 2018 00:29:30 +0000
Message-ID: <20180409002738.163941-135-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:UOa+kAUpxjmKb8Uq9QqC9SZOdvWTem58lv7tWL6nvWamJtPzjgT/TI19TO3/q3fa9yvh18VvR3xtcGn7JS9mj9Z9Qmcl5V1nfwxVfPGG1w6NQ27TQ5wIWwsPcTyOJB19cTEwq/SwTNEdjzQpDyaqXJAwlcoa5vU+VJTxyJZvY6B/mr+qcbr6tSYHpO5gb4RuAyaESLTLs/9pYeBPGBBtY7iVmF2LxqtpmOqRD2651ozq8z3qVufPqD+QXlQHB7kd;20:tmDCpepLvbxC2SxoAhizV88s3Fb1iLSA35xD/xuPOtNZCyrqNv3tEyn3aZ3JX4D0D2olqE5HY/C4WS7enqL5THXjt0YzNyYR1SPFqUNrvsuLEoReeTRPhK9V5m/wg6Hc4Ez/qI1Eh00OadAu6izFHdMWihXcmukCutV7+HsszWs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10d26830-3186-41bd-a926-08d59db23c99
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10958A81973F423DC83E3933FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(56004941905204)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: KrlPenI6ISFHcGqAzZheGTeXr6So+jY1GtqXsgIbG9JlhcNK3H+X/lEV1PfwkCL3YYMqD0/weQV1kcMrsf27COyGTSqLyZy6XgfvCukROaRn4n9v3VPZMC2M8wo4IzEmqdRypw5oKmCpEA1b6UsuBkYmg4CjpTOfURkfqe9aoq0O0uH7P2a2gdmZs7z3IoKLkz/3x4vV6EcU8G0ptCNTZ6nlgmm0FaCYjEMqdnXYjAOxMnZMgCwXdwg+JmVS+yu0Wly8+e+D88qAXs17JydEputDY29PVtWL+X2S3IUmr9boYEATiA7J+lN12xeK+PqNUfQysW7fsYxLYFEdfOOtE3JGbKSDvBPx9bWK5/ZS+vtq65LMUgPKybruesK/cYKBr/goUOJHd7LWVwHEkHbCslkHtnalFsj8mVlw5W68nGc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d26830-3186-41bd-a926-08d59db23c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:30.5994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit cbd27448faff4843ac4b66cc71445a10623ff48d ]

When using the max_mw_size parameter of ntb_transport to limit the size of
the Memory windows, communication cannot be established and the queues
freeze.

This is because the mw_size that's reported to the peer is correctly
limited but the size used locally is not. So the MW is initialized
with a buffer smaller than the window but the TX side is using the
full window. This means the TX side will be writing to a region of the
window that points nowhere.

This is easily fixed by applying the same limit to tx_size in
ntb_transport_init_queue().

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ntb/ntb_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3bbdf60f8908..49f3fba75f4d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -955,6 +955,9 @@ static int ntb_transport_init_queue(struct ntb_transpor=
t_ctx *nt,
 	mw_base =3D nt->mw_vec[mw_num].phys_addr;
 	mw_size =3D nt->mw_vec[mw_num].phys_size;
=20
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size =3D max_mw_size;
+
 	tx_size =3D (unsigned int)mw_size / num_qps_mw;
 	qp_offset =3D tx_size * (qp_num / mw_count);
=20
--=20
2.15.1
