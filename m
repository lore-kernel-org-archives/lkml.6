Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123922-5-14945716767173695221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123921; b=sF7yS/mKRU8uU2D6Opjt0PNujdfiYamSxj8FpK7s1HzW/vp
    5avU4KoEkqcnnzARt89ER4YTuJxrTUYsUbuXEHYp5qyk//R6u6zSQwT5PfTuDsSm
    JRtbfGXitIZZZcHbIF04jwBjwanbWZwhDeFg/kAXh3YwASe8vGM7dh7pSMUYodSw
    LCv9K2FCG0OS+O1gWYvP23PUCtb2ElTYNRmx8/QoFiNLoJ+JsovkkH4Z5miSDSeQ
    KlBdx53XBdhqgx3S3n4gYCBOjNce2vdC6yRtirDXWoSzvppwEpCj9nIYxyQNkyhm
    eBqqSJZyJiDjBKsj+TDIVkoXaytbNzMIFPvG2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123921; bh=0WOmIc
    Xqv/S+4QSAGlqhm+oo+0G+Qoi8OhfHjg8/itM=; b=XICWtAH3lr429O1yxrPQR6
    NVV4NSZKs/U03z6sH3pv7TCERs7FWLr9ULVK8Ib8n9mswruj0As6dlpITwqcBaMM
    I3kZRvlYTpXoBNV5vu2xgh+Xmf0OFYaFSArd98PtqhbB+xVeh0GoKsxGur3FLINa
    f7VCy+MbEzU0q88hF0wEgdrkIPIr8fIfQsZGCWRUJkOXVFo783hKE83WimA2hjkW
    +wAiUaDYhx7q9LubfsRPfqJc5Fwvde6EvFzJnrywfMP+EOaITYohFZoIjJDoGaZV
    GLO/OddsjNPR/DizAFmIXdac5CjHlpAevEYTL1NHA7sXqYyozNVsEbIVDOo6nWsQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D0mE49Zm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D0mE49Zm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeCDAiR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:38:17 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:17369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932437AbeCCW0x (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 064/102] iwlwifi: mvm: avoid dumping assert
 log when device is stopped
Thread-Topic: [PATCH AUTOSEL for 4.15 064/102] iwlwifi: mvm: avoid dumping
 assert log when device is stopped
Thread-Index: AQHTsz5vwbQh7gdIIUuoKxzCmIOKFA==
Date: Sat, 3 Mar 2018 22:24:46 +0000
Message-ID: <20180303222318.26006-64-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:GUojLkn1kdaqheIJZKS2QOUtZrDNTN0LmuAMH1W863iiZrmCty3LP61lW/JkonBY6SUsxclwGD7nlp2AhsE3ugdtH4UkCmxTncLE6wsguXFrW5daLXRKYYrur+wE5kpV7TNwdWOdpCDycBB2ni3bN7gN3347SqYhuj1yrxU1wrd2ihkHo3cKAAIc1XjVyEQeGMmhi9yoQBy8hdO0HzGmM+/GXg7ejBJ4yGK04FA1h6/Z4Ibq0UOlN50vCCtP1B36
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 813e3b14-04e4-4842-09d6-08d58155dbdd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06270BFB232AE728193A7EFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: irrWqjt3vti/vLJgpx95G7NTsjtOLqUDmfQptl8+QBJXUaD9cSMdR9PmgPHfGO2cG8J2W9ejVsAGkgvyYNTTjlcqYyawUes6I41LDJnB19hV3fshrnSWkLDZQKJaoi56psxY5yfgVPloId6B/KpzwUnzHG/24djPzFrev07pIbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813e3b14-04e4-4842-09d6-08d58155dbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:46.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 6362ab721ef5c4ecfa01f53ad4137d3d984f0c6c ]

We might erroneously get to error dumping code when the
device is already stopped.

In that case the driver will detect a defective value and will try to
reset the HW, assuming it is only a bus issue.  The driver than
proceeds with the dumping.

The result has two side effects:

1. The device won't be stopped again, since the transport status is
already stopped, so the device remains powered on while it actually
should be stopped.

2. The dump in that case is completely garbaged and useless.

Detect and avoid this.  It will also make debugging such issues
easier.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/w=
ireless/intel/iwlwifi/mvm/utils.c
index 03ffd84786ca..50255944525e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -595,6 +595,12 @@ static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm=
 *mvm, u32 base)
=20
 void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
+		IWL_ERR(mvm,
+			"DEVICE_ENABLED bit is not set. Aborting dump.\n");
+		return;
+	}
+
 	iwl_mvm_dump_lmac_error_log(mvm, mvm->error_event_table[0]);
=20
 	if (mvm->error_event_table[1])
--=20
2.14.1
