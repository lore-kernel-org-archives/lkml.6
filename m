Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482416-2-12114525975616260817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482416; b=wXz9ATCKD0bh2TZ3r0ZaYYSm3FsRVr6D8DwSubPkCxz6XBb
    2usSMa+j30v++ep2xrLMnKUgAQpNWYJ/Fv31GrYvsci8nX4c3gApziJtdVyuZn2m
    8fqQhWq52YVI99aaotOwyKzXarHQketAmQNRGwzm90DSh0h55arZGx2K13IgkLpC
    vBTlaqDxlhv/TCv9Dhpo0azqvJvdViGyWSxo4FllVmKFOZaPlx6H3zUSQXx9tW/T
    6U+DDHdxKQaSERODwNe7D/3yktgTbrcJMsru9ADwVawTKv0AlAa0qFDnDh5ReW6B
    qQ113WcPLUNbZcihpTLbfcRQrwvsE8f98h1r6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482416; bh=/5CBLA
    3uqNdu+lXxLeNblsVZ86eIzC9mwpqtrRGMqoA=; b=M0eYS7HB/+A3U6y9L/DfVM
    lg5jKoy7OP44rg9UgASL2P8LKvNgEg3zbICrGgoAzyoj7crvWh4ainFiq8FPgU57
    6STnoURbbndQayRPc6agdbInscLSNJViJnqA4iW3FX0DCSV8bp2vl8fPUqOMzgbY
    q7DOYxqifyy0kX9yTSDk5sbdVZxExWr/7c+LRoOvKaIjUEjignHNTkCCkgI8sd1g
    /XfyVO3WJ0MDWyFmbe257O0R3RHuJnnjxWw/oCAwxLoby6m2kIigZ6EIguAPM/xF
    X0lGoQQWDmCwl6MS66s3zEaqwLtPbEXXnRSGI5P3IIua4Hs8ULWavxUEOuzUNiNg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nW7hwnaj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejvdejnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nW7hwnaj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejvdejnecuvehluhhsthgvrhfuihiivgepvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965679AbeCSR75 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:59:57 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:39072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934916AbeCSQET (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 206/281] iwlwifi: pcie: only use d0i3 in
 suspend/resume if system_pm is set to d0i3
Thread-Topic: [PATCH AUTOSEL for 4.9 206/281] iwlwifi: pcie: only use d0i3 in
 suspend/resume if system_pm is set to d0i3
Thread-Index: AQHTv5ubLrqTztjM4UWHmoHcTpR3RQ==
Date: Mon, 19 Mar 2018 16:01:57 +0000
Message-ID: <20180319155742.13731-206-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:s0r455uYUqml/lvHuuJSvR6X5qurE69EXPxmtyjZcWm6/OgK4H3vPVVHGO3aRP/gSpjbGx4vjoOwTax0bRfymRrTAnlmiNO3HDu+E3Sb8ElAIJAMhzrG+uxdgKPm1u/0Op9hDwBOTz7MQAS5XFgq94sTyFXOir/EsJHDzpQu1J0dnfq6jSTTNsP7Ntbc3Ll4PdzNIz24kCO9riFP0etWFI79BrSKK/fn8o84YWfNZ4/3eyd7c8657ByQlCewHYFq;20:jod4bp4GFkBHT/NzKGBzPEDpAjryDJngOCh9VEPKlWULrCLu+/2v/gSAcDocylLzf+8w8k8RVz7iL/Y673hQwrAT1Gj7GTErbAWIaIQNRaGCNaXFFFSwT26tFSncFkpAdodFX9sNbo5dUkZSn3UfvL/jdQd1wqV6/ifW3ARjSPQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47335c40-7fd8-45e8-4cf8-08d58db307b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07274A5B91DB5CBB7124C8F6FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(6306002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(966005)(3660700001)(15650500001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yHBCyA/0GvPhb7qDEDCupCd06fK+be8P0wkJHcsTUgnzP1Hhz/qAUDuV7c6obTNSWmsEHJm3QfnkWrY6m6KGoLrrIjT16Fv1l1f88wDVycNDiVKutuq+RIqwHMNI2h/qEJNxEMlztRBIpHsmUfwTWk5oDgnyXWqiofo6J4hzKmCNeHdxFEXYfHTWJe3pBxQzgOETHGiJYJfSbWxcwiMzr+u+JRUwxlx5Qt5k2mi2Kp4rVL8Q2mLjfTNV27TOIbAR9xRDqHP61u+vj8KmbVRDlIVgK3ATaCNKNHd0PSsEpoHFyH6qRYUX8YPJSMyEoHsE1MU52Cct0ckCH8FTpEChJg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47335c40-7fd8-45e8-4cf8-08d58db307b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:57.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit e4c49c4937951de1cdbe35572ade40c948dec1e1 ]

We only need to handle d0i3 entry and exit during suspend resume if
system_pm is set to IWL_PLAT_PM_MODE_D0I3, otherwise d0i3 entry
failures will cause suspend to fail.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=3D194791

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/=
wireless/intel/iwlwifi/pcie/trans.c
index 10ef44e8ecd5..fe32de252e6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2824,7 +2824,8 @@ static struct iwl_trans_dump_data
 #ifdef CONFIG_PM_SLEEP
 static int iwl_trans_pcie_suspend(struct iwl_trans *trans)
 {
-	if (trans->runtime_pm_mode =3D=3D IWL_PLAT_PM_MODE_D0I3)
+	if (trans->runtime_pm_mode =3D=3D IWL_PLAT_PM_MODE_D0I3 &&
+	    (trans->system_pm_mode =3D=3D IWL_PLAT_PM_MODE_D0I3))
 		return iwl_pci_fw_enter_d0i3(trans);
=20
 	return 0;
@@ -2832,7 +2833,8 @@ static int iwl_trans_pcie_suspend(struct iwl_trans *t=
rans)
=20
 static void iwl_trans_pcie_resume(struct iwl_trans *trans)
 {
-	if (trans->runtime_pm_mode =3D=3D IWL_PLAT_PM_MODE_D0I3)
+	if (trans->runtime_pm_mode =3D=3D IWL_PLAT_PM_MODE_D0I3 &&
+	    (trans->system_pm_mode =3D=3D IWL_PLAT_PM_MODE_D0I3))
 		iwl_pci_fw_exit_d0i3(trans);
 }
 #endif /* CONFIG_PM_SLEEP */
--=20
2.14.1
