Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240373-2-84604172154397616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240372; b=YGP1Btpl2+pZ0QfkoJpiFOpmpjcorDDppDWnoyfE0r5odp+PMQ
    LRFc9musmplZQmkyOSYR4I0vAGbHSYd1xmAbKgTd8bBUizCPeSMQipBm680C6INb
    ItQx1FtpVGIyH0N20GT+Na1xbh496xAxEPnXqm52y9iG2AqWOED7YtSxIOe2ChcT
    kqEJQizcAFhyqaed9gQiDMzVzYr+pekzrpZb6mjctDFGBMW+1DatqWKN3a+0WZ8S
    p7wXENxuJi3uz7QR+/twkGpsr0UmNdwcWKNot2P3bX+6V8ewWwPqnX85LpFvPLYd
    voao47tdvUfsha6yt/68pnRbvnylg0wdQD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240372; bh=6bHq1JmyUQ
    y5/6QmEukOASDohBy4gZkJc6vBylb6tpY=; b=OkTM6Zi/LZnnRRk2prZ6o+2LSb
    V4AY52srJNivu1HNOHHFNszP/KZxuaxaQnPnYd8GMg1ej3HeJHP9sH9y2ygz2me7
    61HIFMq4zAner4EK67PV7M0b/ZCZyxL2VpbEyZULLSIxIfMs58gTuZAF3kPR23mL
    2N1vMJeyQ47BsGS2EpBI6iXGl4LShEviOVONU1+A66b4PcS2Wwi+v9EKEQcI0Ywl
    +xc47HJgM4s39egfth1GHjloQKdnOQoyOmcx4NwlZxuZOlQ+9RiJaZM5H/D8jlSS
    JdnyhKvmjB4xC2cmMT0bALXbUC9J7xRmYinqv8i+NMFyiq8R4dzVUxtXvKAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ifd4+JOE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ifd4+JOE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDQ0ZtvXb6dImrvXKgehu0lfi6HZHDFdnytFdQrW4sVcjcfc3hO5u8rfxtWDyfNeT/ZhvZ1ltj9nfAyFkOYsAETeX8A8XHAQ3zgF8sr/coGqiaRGbIZp
    CMmQqYAKA5rTg5dz1IEhI7wb9U4m4rNFsBIE51JNFC6Tzn/SbNnNScXB7uk/CRuq4wAkHC6aQO5H+eD8VJ3uVTi8cpO2yWALkXNmyvY4XKbK2cJ4tPRHwhXf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=rVhjSRTOvMNlemacK3EA:9
    a=mXUxsr8hAt8HMDSc:21 a=tR1x4k4thSJGFiCO:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeDICTR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:19:17 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755780AbeDIAaW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 127/293] iwlwifi: mvm: track and report IBSS
 manager status to mac80211
Thread-Topic: [PATCH AUTOSEL for 4.9 127/293] iwlwifi: mvm: track and report
 IBSS manager status to mac80211
Thread-Index: AQHTz5kh+zxMR5mtOU+URH4oo3TqRg==
Date: Mon, 9 Apr 2018 00:24:31 +0000
Message-ID: <20180409002239.163177-127-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:xkLR3/VxHIjHTBpoLyseKw+JK3LltQNpXmeOSObz9xlIaVdZ+484Rx9qW7wAibl8GZpB+cgrntjD27lQwrZQNpLn7Q6OoziosSJeoZIFSptX3EY8dMapm10sduYhNDM6eFCiYGuXydD57onP3+yLJuT/6L/p4fIICU+SUCsuYZyQ9BHLx4/M0E0IwfUsI3a0mU62I5YnWk8iJBDE0Dh76QY+asRt03uQkdMfFWt5gRvZ7LKGuFxRGbOfFPR7INee;20:K8JsGwoM2sMaExlffgs8FMs4a1NOELcFA+3T+x32oEdCyIw6qrw4iQaXuY/XgpF5jFCGVLZIoX3LGqsBT9W+mCnC1BX5+oJzZh4gToJxP0vXPMCEpLtjZ6p6IMedwtMvHqK8Ya0r3VyI2oHiTOr8JB9EBqq67OQ/EqBvqUKHR8M=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 133cf3bb-1821-4f28-d1b6-08d59db1119e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103265E174FDDD98ACBBE45CFBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iWyKu/3FFmpE8zBT/rCitQuC9F5c/ee8INtU3NkiCdmzzXKm+QuOW8J68VW7VIXnLaH/Y6LRzLPpiTV8JeC6ufdaRuo9Nr0unp3JT4X8N6aWIbQnEEQsQiuGZm/3CbtzVjaDpOU71jFsyExsHiy9gOuUXSDs5HfaCPHnsjfekYdjeBKHF3pTl3vuIJ+gh1mBDeJ7KNbM0BJjDaQ+BmK816bbgoGcgVumaPUR4e2VOWfASXmgG5GSUwcrGd5d99UyxxQ1gZoa5ThOZFB6CL3qDXZqUA2mNnTKDKR/++rktIsDLEtZIQcT7xZ1bjhu2nShao3OWR92iJ4DIrqHjlhFgsLSYxK6wroyxPi/Fbv1e3ymq4L0TFd4Hk67lKb+AwLMGMteyB6EnRLfJzIN3IWVXOgakPUqk7Hj9OCzP4+bXC8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133cf3bb-1821-4f28-d1b6-08d59db1119e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:31.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 2f0282db41194c0099a019b2761911d6c69cbdb9 ]

Shaul reported that when iwlmvm was sending beacons, it didn't properly
also take ownership of the probe responses. This is because the whole
mac80211 callback (tx_last_beacon) wasn't implemented. Fix that to make
IBSS discovery work better.

Reported-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/ne=
t/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 6b962d6b067a..ee8b12424d03 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1434,6 +1434,7 @@ void iwl_mvm_rx_beacon_notif(struct iwl_mvm *mvm,
=20
 	beacon_notify_hdr =3D &beacon->beacon_notify_hdr;
 	mvm->ap_last_beacon_gp2 =3D le32_to_cpu(beacon->gp2);
+	mvm->ibss_manager =3D beacon->ibss_mgr_status !=3D 0;
=20
 	status =3D le16_to_cpu(beacon_notify_hdr->status.status) & TX_STATUS_MSK;
 	IWL_DEBUG_RX(mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/ne=
t/wireless/intel/iwlwifi/mvm/mac80211.c
index f1231c0ea336..3d6401eafe52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3621,6 +3621,13 @@ static int iwl_mvm_switch_vif_chanctx(struct ieee802=
11_hw *hw,
 	return ret;
 }
=20
+static int iwl_mvm_tx_last_beacon(struct ieee80211_hw *hw)
+{
+	struct iwl_mvm *mvm =3D IWL_MAC80211_GET_MVM(hw);
+
+	return mvm->ibss_manager;
+}
+
 static int iwl_mvm_set_tim(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *sta,
 			   bool set)
@@ -4218,6 +4225,8 @@ const struct ieee80211_ops iwl_mvm_hw_ops =3D {
 	.join_ibss =3D iwl_mvm_start_ap_ibss,
 	.leave_ibss =3D iwl_mvm_stop_ap_ibss,
=20
+	.tx_last_beacon =3D iwl_mvm_tx_last_beacon,
+
 	.set_tim =3D iwl_mvm_set_tim,
=20
 	.channel_switch =3D iwl_mvm_channel_switch,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wir=
eless/intel/iwlwifi/mvm/mvm.h
index c60703e0c246..49e84efbbb0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -989,6 +989,9 @@ struct iwl_mvm {
 	/* system time of last beacon (for AP/GO interface) */
 	u32 ap_last_beacon_gp2;
=20
+	/* indicates that we transmitted the last beacon */
+	bool ibss_manager;
+
 	bool lar_regdom_set;
 	enum iwl_mcc_source mcc_src;
=20
--=20
2.15.1
