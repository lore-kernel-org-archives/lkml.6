Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498421-2-9762587259992172586
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
    t=1521498421; b=eGCAsN69YLvHyF9MxBDGFvFiRmAKSVZjL7Cly226walwoDU
    lgFZ70ztcmfCe4WXcxus2wxhzOpzc+HwQCVMCzWNgK2m3u61vwxjMHOIz2CLIO8K
    1Hb50GYGpcRPgvl/P+2B2ZTCXGmj++3Pkx3msDDKMsNBaVOaKHCb1JHHBF4YO6jD
    DoQtnFlhRqkEP4ap8xk4hhyhIEHxPLywUCZaJ9aPFEIhjkKQ58BEt4vd7OYl/fgK
    LAwuQw48yz2t9gtW1QZLIdqTd9Phs3IV0kW174Q6RPEgLmrElme8LDg9Oi+0o8Rb
    IDlWfaG9Hx4/UMzpWF4x/ZXZwa5r29zFpnvvfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498421; bh=LEpSlw
    TRvS9NQcgrCJvRPhp53AfQXDrkKT/XFvh8/ME=; b=JvKKfkagRUbf3gvjy87/Ve
    WU+UIk4ZCSGb58TE/VTzoU+geCDQ6WE1OwMsGJDT2F8bDbz/hMFZn5MPsghyP3DG
    jOqfAhsO/I6pljy1fYoP2RUjrHnqyinvS35NkEkVhwbDe3CVS+WtOyG+0nb5rzpQ
    jHsE/1E2JXcJZdiJ8w8l6cEJ4+V9yTLe7jqNE8eqc7EqJMGjqj8UZUMZB3wbcVRr
    foI0+nGfomXQmpRohZjX9HKIL+RK2gpFApRmzK+9kPDpm1QWtZFeaBZqKQNxhOsb
    UrgVtmJ+8ctaar7CMU4vnapECEQYr2O3Eet0o0C27xqc2BiCVZhfMDEGUvv7Kjzw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G+2LgRK2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudekudenucevlhhushhtvghrufhiiigvpeeghe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G+2LgRK2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudekudenucevlhhushhtvghrufhiiigvpeeghe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936518AbeCSW06 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:26:58 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:43108
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933849AbeCSPs5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 069/124] ASoC: Intel: sst: Fix the return
 value of 'sst_send_byte_stream_mrfld()'
Thread-Topic: [PATCH AUTOSEL for 4.15 069/124] ASoC: Intel: sst: Fix the
 return value of 'sst_send_byte_stream_mrfld()'
Thread-Index: AQHTv5mxHLo7ccw6Yke94fpXwd/nBw==
Date: Mon, 19 Mar 2018 15:48:15 +0000
Message-ID: <20180319154645.11350-69-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:N6VEHthUBL/PAXXTQG+d1nKZ4y1f1IG0DF5fzQnIaoEaD7hcw2WMOzG5K3ptxAEotoAW2SMw9qRRW512DV49yi9kqHUKCQBbouTUqufhYdOSwBR2X+g0uJCltEtYV1QEWZtiDdc9rB6gQdELe0LklcUxGOLcWawf18vYo9RYaP1HHPrpVI3lvdaBUzGs7fuUDu7UJ3Sn/7EkgVvLc77sBtdkjY8FJM8cNshgJyE/mMzdLHG8BbNKQy8BD9CEIBvL;20:DqRdyLAwk2gBF4u75L5y+/35n3KrHooj86EzydRtLhqASYLk9eCqpL6Zmp3nCvgH7oSMWJBei4LuUXOX3W1aV4RURP9O9/ksYWsaVISCUcYR7VhsoWcl7vJuJsKDxzfLFZd+GSJxVhKww6GsEUIEss1mvDf/bfMlddbTe4z4uq0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0716e18e-2d95-4fda-e2a0-08d58db0eafa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09192969BC0DB57C272067DFFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +AUmdOnaIGb+LJxZN4lOZJmZUtzAwlXPMAmVROoFIsojPfHjh3FwvRF84dgWTWkp6LOT0/dYw1fP0Yh6opLVx9np62mQnjFmnqN/AzT5VTWfQ9+Mvvoltj4Nsw2MsEsq9/HsRy8L5Sl3a7zECA/ctCXEzkWX7P/w1iYC31KAFPhDMLOAo720p7nvbSRiF1pCZayNuqYzdTsNFu+hyk+z5ipMjGQ90YUiYqkzVFD8CqbJujW5DjpgjWyDm0qcEA2oyiejs/RrVYzLkCSUr3BtJOql0QsNO+8PhizACzHlUTxJrs0P4CV1HlhycHrH9PfsXuwzDobCDssRRsfPcWKlJQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0716e18e-2d95-4fda-e2a0-08d58db0eafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:15.7177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 65e257b17a7e..20f5066fefb9 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -220,7 +220,7 @@ int sst_send_byte_stream_mrfld(struct intel_sst_drv *ss=
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
