Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493813-2-17747377073086482761
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
    t=1521493813; b=U9pmqXv9V0PL82syAxldl9OLZ4X23g5wxwgz8pbJRfZTEpQ
    uTBHheDDTW0Lo7gRSn8h5bZXk+YDJn8EcwVgKIoljzHu6NWFtn7qJnJbHrPPn/TG
    FnIux5tTzcttbF1w2T7JNq+FTeyB70h6zfP5gNIe1gOB4mPCEsGB6ABIwU7bFYlr
    w/bltfYfsQeWDnH1lki44yJdiul3XwoPs3NP2B9UqJW6e6BJOYqrbkrcUOP39guZ
    OGqOClNt7zdJxVWBK8iOMZSvbsL1xxEfjevrrGjBUvpBChUUgLntpoDvZd7k56fV
    YgEXtJenDiB+QEtVO1MY+MATtBZ/NF+rQfglHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493813; bh=NSOWBI
    lHGu6xvDOOJsAcJTQ+KnWHMe75bY5LaWQohxc=; b=ciEvSa4zT90JOPFoEdkmiR
    sLNxJRV+dZpwuXbGR5kSpcd5rNG/fm7pQ9IX+91q/YbuENl5S4z1p5ekMrknbTBP
    oXP2gvrRnR2RgTlt7emUiO9OEXw9l4n0faIyO+yW5qjhMn9IahI9gc5oWV1FQpus
    0ZViegy5CcehZVRJM29BmXmp2tQ+EldGuUTvW+hCuIz7le2Ypmze4o/FMvUorMGD
    eezqZDKdotB7wsnGC8FTjEiSG3w/jGUT9PAOSBoQAe3TkNaDIHDDOkPsR43ctix9
    /arh2Z9L/PyGQs05f38dE3BhkIU0FrePYwJ09lu+XFgHgqXJt8mKg1o4S+mJ7n9g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FnGMp+em x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudejkeenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FnGMp+em x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudejkeenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeCSVJX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:09:23 -0400
Received: from mail-dm3nam03on0139.outbound.protection.outlook.com ([104.47.41.139]:24320
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965154AbeCSQCC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 148/281] ASoC: Intel: sst: Fix the return
 value of 'sst_send_byte_stream_mrfld()'
Thread-Topic: [PATCH AUTOSEL for 4.9 148/281] ASoC: Intel: sst: Fix the return
 value of 'sst_send_byte_stream_mrfld()'
Thread-Index: AQHTv5tycVxF4h+ANkCr8CRTZZoy0g==
Date: Mon, 19 Mar 2018 16:00:48 +0000
Message-ID: <20180319155742.13731-148-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:LQbdE7mNkGJXpcCIWoApp5uD+ScN16YfTeInMPMxBWkMWHao+FyLwICa0kVqBVcxc7+9XYTriTrxRhKFRmRFG9OWV/dmAzMJdxEXeFhF7pypqpOvkkOVIa0nBm4qHSapn1IjLk5y69XRCn+Cl4BoWgRJa0TcRTDtK+6G+/+f5h3tpMGA7UsxUEnzPM4t8PC2hzy/QXQUyNX7dOQPtGdG2tOSmpn6kvgxO4uC1zGQ3KB8LTeLDvqKlZF8K3UNzbIE;20:h4Gq+ca2cIeYZZSpNUs7z7e23fnyb5lp4OCLRbpEd8VgWVMpi98ezGmaWcTAUCPbSkBQRxoUb+VNpMmhh3+Fwx9/rVUD5BRbF3EUAacAD0zzplkmRBQOlzJMI83J5+dbX2xCdNY6KYAjEfTZ5VSR2JhWvkSyAsC2Mnlelh55N+s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf7b0937-eff5-41b2-adee-08d58db2bfaf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062D912AA83640F85527360FBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(59450400001)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(86362001)(81166006)(81156014)(8676002)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: X/h9IzO9gQxvikQvM0GrQkHVM+QtuZEeO0CAmzt6L1oOD/7l0BYkKgPb8GkfmxIVAyDvxsNTFuxMQlo94lsfoQfCaeU8gNpoyy2gd5oTFq+uSCazIATYjlx5DCi/eKZ66Ov5sJyzOjMWV76XolR/vrwe7ysJ5ul4eAfUa8GOCy1hAiklP3XemiN9OjhcgCYzwTWXIVbho47+yVtO85agEgbFWuR8lSCPcNgYVrPLelrul7GRcb02dcZPzaPCJNMOOrT8OusiJy2A7Vi/Ka2OLVqLYlc4K2ZWCRFMj6mKavzotACQMVKoqrsM+lhdL84GhbHWahmcuW/0IzeDd7753w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7b0937-eff5-41b2-adee-08d58db2bfaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:48.5635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit eaadb1caa966a91128297b754e90b7c92b350a00 ]

In some error handling paths, an error code is assiegned to 'ret'.
However, the function always return 0.

Fix it and return the error code if such an error paths is taken.

Fixes: 3d9ff34622ba ("ASoC: Intel: sst: add stream operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/intel/atom/sst/sst_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/s=
st/sst_stream.c
index 4ccc80e5e8cc..c798f8d4ae43 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -221,7 +221,7 @@ int sst_send_byte_stream_mrfld(struct intel_sst_drv *ss=
t_drv_ctx,
 		sst_free_block(sst_drv_ctx, block);
 out:
 	test_and_clear_bit(pvt_id, &sst_drv_ctx->pvt_id);
-	return 0;
+	return ret;
 }
=20
 /*
--=20
2.14.1
