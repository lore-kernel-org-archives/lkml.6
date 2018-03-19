Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475471-2-6397679105648550249
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
    t=1521475470; b=gBmRQHD61eAE1S4xLKRJ9A+CJZmBY8MUVgGzMBJZvg8fC2O
    TBe3KkjeWiTTqcBRMR0X6CtL0C2gh0W63oo9U6FnJDD1KRgd01GEu1JUetp764J0
    d/VHAWbUOOmRPzFtT5IhV0fr5Qd/clc0WNrfQDj4EBm6bVFaXnexMEhK/j7VAz7W
    OiZP7pRrBLy4JlclKKOHFKl5Qhi1XSn9ObL7DvsrLY/tSB6MuarRY8/btbKDeB8a
    ++PegfarBADe4niUN3qTz41c6O02l1GIRHl6ng1VjvpvZY9+eTU5LtRXHdyc0hVN
    ++NSiOHCGMUD1lSmpFBikbg/MDCQHfViGIzFS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475470; bh=tCWD31
    jcO1PncTXnOR4gzMWjc+AcqLtZfny9hW4OXFU=; b=SUG9+6mXnSkkwjWowr/b8U
    9cE07C7nWRZk6wCzoVJ/a8xIfijzBb8LPa/OYbLO9Abz7z/Qz3TvtoIe6A+w+bRC
    D7cYrORPJWFY1ugv2LS/bsivToPWQmmEGAxDwSQWqhescV+immrnls0r3rf1PEvr
    rpTBgtC1iwygvi1s2VeFgxyzOwyDBZDdZLqSR5JZrb2Po9YQFy5WwTAUqikOcwgS
    IhZdc9S5n/NV0I0qOIKDDgzS8ZbgR9/XfcF4Zl3vfsIb9jkTFObMoI/ikNK4O2a3
    +E/UbyymnKy+/cLXyS+pc6E0S7LexuWFr8aZCEHanRdaaAYViU3ROnodKAVIzIAg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ANAlHFgb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduheefjeenucevlhhushhtvghrufhiiigvpedutdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ANAlHFgb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudduheefjeenucevlhhushhtvghrufhiiigvpedutdej;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965660AbeCSQEZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:25 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:29088
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935068AbeCSQEN (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 202/281] iwlwifi: mvm: fix firmware debug
 restart recording
Thread-Topic: [PATCH AUTOSEL for 4.9 202/281] iwlwifi: mvm: fix firmware debug
 restart recording
Thread-Index: AQHTv5uYVRkxt9TwuU+4IC6a317HBQ==
Date: Mon, 19 Mar 2018 16:01:53 +0000
Message-ID: <20180319155742.13731-202-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:WkLg4xNDl95uK11NO0jgBJqmcUVxGJZicuSc2jD+UbTV0RWx8z4Oa6EagD9bT6Riuj9ShHX7AIXQ9em7G4ylsWtWrORszrr7F12yEBMOU9WO8ZixDK5jlNetGtY6muSOQQ+FX0tPNRImMoPBGyRJbIs6ctBpfy9DAj0ZENk4uqBA1Z7i8ZWm3ucJzAE51Q8fciuFiXl6Sil/PErESgC21hhUWnejbNjKrBvh81NDup8+D5UALalrw9efHG3UbWX4;20:29KuZ+/zzZ+qQNcZaMm2tWHdiLhtP7pQGlWLTS8HSKDU6KBsLLOyhOWtqCBx2HPolfM+4l1QGukvr2OGtYGnXbOlBTJ8vdIGxsJko5zgv8bnxEqlRt3zjFVJUrdyy/qv4Df7hEJGggGKxLcP20eoGR3v6cORgQ/PKHcyhIHbu5o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff66de21-2430-4710-ff8c-08d58db30679
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072705777EF14390194473FCFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LVIGBEEaAAJXRltHRAd7ubVyO5FMEJtLbCf6bxYDgkDYpf21UqFDScfO1P//Cfs5QnmimzNxTKRJJcllmLcs/JKVIDSqN9tYVjJnB4klXb1DBLI3r7vS6t1Uif630qDmNw5E5G0zaJiFke/U0WGsI9EEwjkMqG8KQCWlwOA0LXnDSRElxN8RvBYcHykfxrWuD0Sf+/PKjONkFgPcDQGjyGJ9U2gYV9JeGpkBbVV28+akDUCcHsd/rmTi4Tvm+5mkJpWQvv+YD6uZVJXgTIon9TO0aMQ8BosSqlYIkscqfQ6kmc/7ZR+I3a2EEWQf4I3P8AD6cbtrNIXIF3Hgeh2EDA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff66de21-2430-4710-ff8c-08d58db30679
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:53.0938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit addce854f164a68da9cb158e2e7e447705068549 ]

When we want to stop the recording of the firmware debug
and restart it later without reloading the firmware we
don't need to resend the configuration that comes with
host commands.
Sending those commands confused the hardware and led to
an NMI 0x66.

Change the flow as following:
* read the relevant registers (DBGC_IN_SAMPLE, DBGC_OUT_CTRL)
* clear those registers
* wait for the hardware to complete its write to the buffer
* get the data
* restore the value of those registers (to restart the
  recording)

For early start (where the configuration is already
compiled in the firmware), we don't need to set those
registers after the firmware has been loaded, but only
when we want to restart the recording without having
restarted the firmware.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c | 12 +---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    | 32 ++++++++++++++++++---=
----
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wi=
reless/intel/iwlwifi/iwl-prph.h
index 406ef301b8ab..da8234b762bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -369,6 +369,7 @@
 #define MON_DMARB_RD_DATA_ADDR		(0xa03c5c)
=20
 #define DBGC_IN_SAMPLE			(0xa03c00)
+#define DBGC_OUT_CTRL			(0xa03c0c)
=20
 /* enable the ID buf for read */
 #define WFPM_PS_CTL_CLR			0xA0300C
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c b/drivers/net/=
wireless/intel/iwlwifi/mvm/fw-dbg.c
index 700d244df34b..2642d8e477b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c
@@ -914,14 +914,6 @@ int iwl_mvm_fw_dbg_collect_trig(struct iwl_mvm *mvm,
 	return 0;
 }
=20
-static inline void iwl_mvm_restart_early_start(struct iwl_mvm *mvm)
-{
-	if (mvm->cfg->device_family =3D=3D IWL_DEVICE_FAMILY_7000)
-		iwl_clear_bits_prph(mvm->trans, MON_BUFF_SAMPLE_CTL, 0x100);
-	else
-		iwl_write_prph(mvm->trans, DBGC_IN_SAMPLE, 1);
-}
-
 int iwl_mvm_start_fw_dbg_conf(struct iwl_mvm *mvm, u8 conf_id)
 {
 	u8 *ptr;
@@ -935,10 +927,8 @@ int iwl_mvm_start_fw_dbg_conf(struct iwl_mvm *mvm, u8 =
conf_id)
 	/* EARLY START - firmware's configuration is hard coded */
 	if ((!mvm->fw->dbg_conf_tlv[conf_id] ||
 	     !mvm->fw->dbg_conf_tlv[conf_id]->num_of_hcmds) &&
-	    conf_id =3D=3D FW_DBG_START_FROM_ALIVE) {
-		iwl_mvm_restart_early_start(mvm);
+	    conf_id =3D=3D FW_DBG_START_FROM_ALIVE)
 		return 0;
-	}
=20
 	if (!mvm->fw->dbg_conf_tlv[conf_id])
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wir=
eless/intel/iwlwifi/mvm/mvm.h
index c60703e0c246..ed9bf8c759b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1687,6 +1687,7 @@ void iwl_mvm_enable_ac_txq(struct iwl_mvm *mvm, int q=
ueue, int mac80211_queue,
 static inline void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 {
 	mvm->ucode_loaded =3D false;
+	mvm->fw_dbg_conf =3D FW_DBG_INVALID;
 	iwl_trans_stop_device(mvm->trans);
 }
=20
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/ops.c
index 4d35deb628bc..6d38eec3f9d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1118,21 +1118,37 @@ static void iwl_mvm_fw_error_dump_wk(struct work_st=
ruct *work)
=20
 	mutex_lock(&mvm->mutex);
=20
-	/* stop recording */
 	if (mvm->cfg->device_family =3D=3D IWL_DEVICE_FAMILY_7000) {
+		/* stop recording */
 		iwl_set_bits_prph(mvm->trans, MON_BUFF_SAMPLE_CTL, 0x100);
+
+		iwl_mvm_fw_error_dump(mvm);
+
+		/* start recording again if the firmware is not crashed */
+		if (!test_bit(STATUS_FW_ERROR, &mvm->trans->status) &&
+		    mvm->fw->dbg_dest_tlv)
+			iwl_clear_bits_prph(mvm->trans,
+					    MON_BUFF_SAMPLE_CTL, 0x100);
 	} else {
+		u32 in_sample =3D iwl_read_prph(mvm->trans, DBGC_IN_SAMPLE);
+		u32 out_ctrl =3D iwl_read_prph(mvm->trans, DBGC_OUT_CTRL);
+
+		/* stop recording */
 		iwl_write_prph(mvm->trans, DBGC_IN_SAMPLE, 0);
-		/* wait before we collect the data till the DBGC stop */
 		udelay(100);
-	}
+		iwl_write_prph(mvm->trans, DBGC_OUT_CTRL, 0);
+		/* wait before we collect the data till the DBGC stop */
+		udelay(500);
=20
-	iwl_mvm_fw_error_dump(mvm);
+		iwl_mvm_fw_error_dump(mvm);
=20
-	/* start recording again if the firmware is not crashed */
-	WARN_ON_ONCE((!test_bit(STATUS_FW_ERROR, &mvm->trans->status)) &&
-		     mvm->fw->dbg_dest_tlv &&
-		     iwl_mvm_start_fw_dbg_conf(mvm, mvm->fw_dbg_conf));
+		/* start recording again if the firmware is not crashed */
+		if (!test_bit(STATUS_FW_ERROR, &mvm->trans->status) &&
+		    mvm->fw->dbg_dest_tlv) {
+			iwl_write_prph(mvm->trans, DBGC_IN_SAMPLE, in_sample);
+			iwl_write_prph(mvm->trans, DBGC_OUT_CTRL, out_ctrl);
+		}
+	}
=20
 	mutex_unlock(&mvm->mutex);
=20
--=20
2.14.1
