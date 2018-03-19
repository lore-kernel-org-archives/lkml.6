Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482433-2-5174580392993876119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482432; b=uWh+mL5XkpJHy1E+s6yp8H2SyqV3b80FqjCQ4IH7I4ogZXo
    8FJZdHbIWBTSl/595JFVkD9P0kdWGopAFjXJrdZ2IkD4HsUfARTignpQD670TRWg
    kdnwRi+PzGSJHOl3ElVS1dzeeAveg1uh1SE9KGmkgC0QWMlShQMUy8pEkRAqHMxo
    oGtB//I8q4BYEU9VhDclozbj+5+dbUutWiTcny2vySLwmfN62NoEPe8xUYCNkwjz
    AP4hAPBOiIlIE3oqA2lKCMuKkOkl1tH9C56JvntnDZz1LU66cuRumIdfDS/hdwWn
    bVGCmt/g1G6fdseAB2zqSsCtRg3AbbL8cOfvnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482432; bh=Ry1Ol7
    C7uGWSDVFBUFXumYDh9cHZdnYCk1uaY5tQQig=; b=ZPTizJy1RIV1ZGOrTtZv6C
    Bs3aIWOFIQe6fO0kYTFuaOvainsOGUdPVmjm77rh+754XFnCExsm7xPr+YJZRk+m
    hfxPopgrYTWtKxL8xUR+Ob+3X0jsx5dMyDW2zqELN9tnVviktbxV47HSRkVgSxB9
    sVIHBFAe2kHqjsPogy8bCmjUgoAgRhSE3CWhTa+dKuqN6/1UmQwlvzo3lBmi0fo3
    3EzwBzeq3PLan+iW6v3uaIEdPOVhFiz3EuUzyVWEz7ScCOVSiEyLl1LKraAqOek6
    ZjgNopy2hTH75iuIY7Urj/kgC+apKqGq8RT3MQ5LSzvAW3+ahXxIyMleZPG0oLyw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PUkLq+AD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefudenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PUkLq+AD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeefudenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968445AbeCSSAY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:00:24 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:29088
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935071AbeCSQES (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 205/281] iwlwifi: tt: move ucode_loaded check
 under mutex
Thread-Topic: [PATCH AUTOSEL for 4.9 205/281] iwlwifi: tt: move ucode_loaded
 check under mutex
Thread-Index: AQHTv5ubaxAQ5Ffk+UmhxnhMKyqNPA==
Date: Mon, 19 Mar 2018 16:01:56 +0000
Message-ID: <20180319155742.13731-205-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:ymu1HYO4cnxG/zwKoi2SRPViDxWbqBThBA/mvBKEzufb38I0n6NDcg5hCeltZQ0bBs89NsSWOojZR7DgujJwbWt8qTtBeV+JNxaEMjrdChMwYnqsgreJig2q2LzcEwRQ9g2x4TvWG/zW0MbGHD+eguqpVpAbCz1MnayWFvlQEkBOMtmD8uCAMk0yPlGEi1S2/lGzl1jqiW37JW3XV7/tCSv9fB2xhXsmNJekrGR9mLuQZrVCO5KpOwFGda/j/Abt;20:gAVVqPnKSBBSWXkyCEr5Og2YN+hb2YA4p+NAvM7aaMDpptM6TYykMQuBNRkbEUBqTkr2AMCawIrz5xbfNM+jBVy/CPvFCymx9Im16TIuQXUPImVqMhVniB0GTk1oX2ThBLMQ2kzzOeH57QRYC0hPl55AVhBWjn9lTTbFt16mxHY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 013c35a6-2e9a-4350-7939-08d58db30777
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072705C9E01CD949C25D661FFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dB9S1CatJq6K1NmwVCHjbpzUuYh7zZX/jb+k7gMTQDRp2fUyab3zXdLC16giucXyQykB6JGUNr6sknuN9F/YhFLakURxtUZELzNXyKcMIFfSZEYbfrT9wGNUbCStE7Z2NyzpAbnR+LmrE4MVcdPSSAis4hN47IUW8HsaLPFlYiF1/JoarrKBC6mX+ByXunNkqdgFacCIXB+7JCSHp/nrdDr0WDZ0jC+JI3slxXKE6s0ri/k3wCnKkFGwNO/f2SIxx+Ggjttat4umS9Ct6fTiJnNEVaPeuFINoeJE3GmAqwZqCVFU5EKqqyKDoPKLiBpbClvlp+YerRC87ck01gdRYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013c35a6-2e9a-4350-7939-08d58db30777
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:56.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d9954405758a0cbbe258d9b4d4dc12a06fa48a28 ]

The ucode_loaded check should be under the mutex, since it can
otherwise change state after we looked at it and before we got
the mutex. Fix that.

Fixes: 5c89e7bc557e ("iwlwifi: mvm: add registration to cooling device")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/tt.c
index bec7d9c46087..c5203568a47a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -790,11 +790,13 @@ static int iwl_mvm_tcool_set_cur_state(struct thermal=
_cooling_device *cdev,
 	struct iwl_mvm *mvm =3D (struct iwl_mvm *)(cdev->devdata);
 	int ret;
=20
-	if (!mvm->ucode_loaded || !(mvm->cur_ucode =3D=3D IWL_UCODE_REGULAR))
-		return -EIO;
-
 	mutex_lock(&mvm->mutex);
=20
+	if (!mvm->ucode_loaded || !(mvm->cur_ucode =3D=3D IWL_UCODE_REGULAR)) {
+		ret =3D -EIO;
+		goto unlock;
+	}
+
 	if (new_state >=3D ARRAY_SIZE(iwl_mvm_cdev_budgets)) {
 		ret =3D -EINVAL;
 		goto unlock;
--=20
2.14.1
