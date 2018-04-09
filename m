Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233141-2-10667150951488890796
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
    1523233141; b=dQl/F6KCz/L/oulBH2mt1wAlfpsUWbUH7pUYwIQKAr4GPauYWJ
    s7+5yvut88cVlUj8rzRT1VCxwd6CN7rsrvqpXjlf+1yIG6h6UBd5hJOSDOvT7E6K
    6Q/39JtcIHuSX+XvrNoDelXSTCszTSnp8hlUpusujzdSFZDnuVz+cCOkXL1OQSv+
    k+6hIu/5/udJhpaLoAPta6J18vOriejuFFbzTEJMkqgskJ3QT3hXLOY5/dtbCKaq
    lnAsnjNQRRko+7i6lGFDQkxSnlp65aRsy/Ec3Tm7tUNxrNQKbcjHsCbCGqx93FUF
    ETL2SCMTAJ+nKbMWyhwzlOt5BL0QNvyLNePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233141; bh=kx2obDl6jS
    EpFoiD/RontV0PhWfDoseJIl1yBnOt0+E=; b=Lp501HdGoBrLwNIdI8kqygaYOQ
    RyVkiC2kh28aaRtTsTQsX6aH5yZh9X1m2sdqzClr5Re/jjSdQ4d5wmHmb6M9ofom
    NWYkD1toJ/mEtZ9qbu/kNXvnjv+mKiTMkPvJlc4L2EhkOUTiab68RgBcJv78GlQS
    CusVH0q1xGhPS63wlkzN6R5Hwrpb1M46+pwkkrIjs7qPpYMw1qltOyAnCYsdqNe4
    w2/lHQ/zvLDwMD/xblGwF71pU0sCA45FGBQYZT8MZCjTcGcl1h+yc+kihc0g2bNf
    X4Zwyi27v3uHdWa4sDItWt8Q6b77OkymcEhKTRowfNAb3LegaxNHKWazKPYg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z4PiY51N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z4PiY51N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNSQirMXvrFYALVyprUkYjUUYd44dq//HatDaPvri7RuP+NdBa8P1rI5nFKzenXDhPO5JaFIsfWG1c3tD7CmtU9NMVqbP7SSu5Dz5phqWFkRxs2lzsR3
    dqInCPhy0vwm/jkWVkyCV2c7tjOqfQEA3Gye7OOF9a2EoeURFOBwOxPC1hu36agonaa5tuu2See1n6z6SCJJk6NJsRpxxqiMN4dgzgkRCKg4Qoxfqrld1LY3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=DLP1Ash1zv0ZgA5rJrcA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeDIASz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:55 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753744AbeDIASp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Amritha Nambiar <amritha.nambiar@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 080/189] i40e: Fix channel addition in reset
 flow
Thread-Topic: [PATCH AUTOSEL for 4.15 080/189] i40e: Fix channel addition in
 reset flow
Thread-Index: AQHTz5gw3CXPEncl6UyTMhLOaz+6BA==
Date: Mon, 9 Apr 2018 00:17:48 +0000
Message-ID: <20180409001637.162453-80-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:4YtEflVHSaF15zleJkgd8SYDaDEtVkFZ8KWRyP1w4tQMT2ScSr25BaAoBewwI7t5HqggCPRUuvG4LLQuK9pGA61BDwrt3SgZnsEQVBHpnez7S9Zra+OT7bUhnzlG8vxEMiyPJZLuzJ4d/twx26MLGPCKwbJULUTpb0t+X/arGj7a29yilXEUAiuaCwRrWwNEviWCixVMgs6EXM+rXXRad6z3INVPzPzUPcwAGGsWpHoOM1J2VESYZnxvUZm+v8aA;20:nhIl5rdpDgz6rSVWs5WfK9JHRVHkgYCp+yYBRzI2DHOz102hHFtV97U6ZBBC9tNB1qD32qDaH7+wFH4aDk2VC7juSlE4r8AUEBGp2VwUKjoKbiK/INU+Bh/gB4K/P3lH1fQeI/yvsYLxdElVNYgWeWYEUR8BJYpwF2wlAJJ6/VU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: df28b3c7-7c44-44f5-dab8-08d59daf70fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11284CAE54AF9CE18F6A7D0EFBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Svdc7NLc0fUPTyeYMy0Eelgh8N7hAYIvvVpYH3ryLT8HCXIwSPmFG+tvXWF5M9GZOSCQAfpMrw1TnkcO18izWMc53Dj/NsSJLeLAEAgC3Nf1q9EZ6TKPk2wT7XyS/N5Pz8htxdkFRpTXXo7GahvX6PF/nqZE8ph6ImQFpn92iUsD/n6xG4w6TaLQQO2POi+6tfofw9XTZqnipHyZ1ku5FOkser4uEopto3sWQr35qfscSjFExQoeJDjtK3rba/GCW+RTjTOGDM3Dw1AIPwCt9cNQ05UTWHAHVdkMDmIZlGLsBkhcrGwGGg839nkv1tkjm+Ja8PilXOWolQKHUDl6fCh6F7ablrzOaBX1YvktlPS7l+gU1+wKoDqwWg20jtlCl0BQ7+xjLkLdOM4jXAcBa7W8yHa8WA/D7jiJLlxpBxU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df28b3c7-7c44-44f5-dab8-08d59daf70fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:48.0547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amritha Nambiar <amritha.nambiar@intel.com>

[ Upstream commit bbf0bdd41fbf71a008325bdcf0df63ab088bf532 ]

Fix recreating the channel VSIs during the reset flow to reconfigure
the Tx rings and the queue context associated with the channel VSI.
Also update the next_base_queue for the VSI while rebuilding the
channel VSIs after a reset.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_main.c
index af792112a2d3..973bad818e81 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9077,6 +9077,17 @@ static int i40e_rebuild_channels(struct i40e_vsi *vs=
i)
 				 vsi->uplink_seid);
 			return ret;
 		}
+		/* Reconfigure TX queues using QTX_CTL register */
+		ret =3D i40e_channel_config_tx_ring(vsi->back, vsi, ch);
+		if (ret) {
+			dev_info(&vsi->back->pdev->dev,
+				 "failed to configure TX rings for channel %u\n",
+				 ch->seid);
+			return ret;
+		}
+		/* update 'next_base_queue' */
+		vsi->next_base_queue =3D vsi->next_base_queue +
+							ch->num_queue_pairs;
 		if (ch->max_tx_rate) {
 			u64 credits =3D ch->max_tx_rate;
=20
--=20
2.15.1
