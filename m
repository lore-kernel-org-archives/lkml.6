Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239581-2-16961857241397518115
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239580; b=YS0AVxsRRCmwhBJdTOaQL4X3oaCiCghu8+qkhrrLkvVoJpfYJU
    MAwTket+TlkkfakuZ4DOZnC2vLHOOWiLh9Vy13Bn4LGM3RxzNVYcNAY+N7l7VMdZ
    GhxeOB6hFYHLAeap99r8g/L+W6xxwurexlTHdoSNrnxLwqtx/ppyEgFHNqmlbt8Z
    GUijQ2bCAU/fOB0lyJSDPaJA5uhl2louizfcuQnFq6xsBi388zUPweKA8Y9HDdqf
    QUufTDosA08i0sLeeM7ZvqdL7JOlQ4nBo0Aae1ICpWyb8Mj8r8TFva0H5JJ7I0Qn
    MUP48tjfHXoJFmBmPbP28fF2J0pj6rdax2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239580; bh=qrZH0SDKBN
    mtAU7fU11I8LTHao8AvPmDHn56LgmNTKQ=; b=mwGbt622AH97cuxyafbnlEzDED
    7HCr6P/P23znpqq4g+35Ewobf3nzSdpIORCtRGKqMvQD9+VY11yBivAheUj+ZebG
    fBzjb1v+a+/lmmuNHyKbH3gA8fJOmdUuHinbXvoO1QlphjNAEladgT11VhjtXp6w
    hfw3qPbpWH8AS5c/ADSAvG+977hphECwgVvOqy69t2LODv+7JzHKU8gsNiudwO8+
    71PM9N0ZK8iDKSjmqwbonKbJvFEiPhN4ASrm31b6ruL20VF8Okp2slmMOpwubUx3
    oqvXQ7V9w3oaLHz02XFqIRH17Z4wkUw2F/zJv8SP+365UHDinQ0P2A14Mx+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WOyKkpOO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WOyKkpOO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLh6xY0cYLEyB5RE8mBfUlrg74IFNvI3FleUhZCQ/UVK5JAw8xGNnctR1teQhA1w37wIcq6zBm9bx54dIZh1Y80qQRXsKfukAGSvsMHfoZRJCx8AH2R2
    kGXbXrHl1S+Uwz6Yn4ACWKEDxPrun9c8h8/4wvbwFXWScFh9jUDqrcFt4rlS0Sjo1jDQs8GCxdVuhhJE2A2X7PzFq2dDfCWcw7PeMYud5m8w/Ycy6M1JhzG0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=_nRENZP6EVmDCUYpHPsA:9
    a=icesty6JxNeAZ2qf:21 a=YU-5GDpSCsRv_mPh:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756310AbeDIAb3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:31:29 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:40886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756294AbeDIAb1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 177/293] iwlwifi: mvm: fix deduplication start
 logic
Thread-Topic: [PATCH AUTOSEL for 4.9 177/293] iwlwifi: mvm: fix deduplication
 start logic
Thread-Index: AQHTz5k5N+UyM3ftQUOyDhdpn1FCrA==
Date: Mon, 9 Apr 2018 00:25:13 +0000
Message-ID: <20180409002239.163177-177-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:XTJJkSwL+9JiGHpupkVUM+r1mXEZtV7b9qip1EJ/jtFqGlKSIem3HGYfudvk4F3qJzQGqoRixwpxKiohBR7SI7HuIhSNLemCg0c6fYy+RCCdr6HP1+MjYZHknlhG7S4j6PDnAc0rOMF3vmSIkK1jRnFjyslyst3pM6l8xL7ruaBijSmezd2+LM7GPtPVARliHPoVafeF/RR/awe5pqRYgKOXOyxTY+ch0QBU4/C0mGZD59ZE3svJ9wLuc8JaSAI+;20:y8/m93qW2H+WE4Xgf8Kj6YLcy+Csx6cuziIfPvQdR+79H7t9/Lrh+nWwe2vDngVu0sz7o2Nlx8+AhPADRDbPna7oQFC05LbJBjwVDtb3omQz1LFe9UULLIjwPrXnjbb5+w/llWaTUK+N5OpN91QY6xNfvA5Gz/ae+9yQIfQscDc=
X-MS-Office365-Filtering-Correlation-Id: 450a94c4-c100-4c5e-6d67-08d59db1388a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1126DE2DA39CBD7E97CD76A2FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Nd+MdnmMA/mAnzsBqiaQgGw0BGUWWcoyyL8EW/2QIsDL7cnC7alIBY75G9aYkUwr3C0lebr7bk8k1NW9Y389Bbn5x2j6FKx6PxCHiCdvrD7ta6VMhh/ELVHKVFRAzxslRlR4XF2iYvbaHDx7AXjWYS45jQWdpXkyMTe1IZKD3peZLNHxoEKIVyCh0sJ56SG/R090kch27VqnC9hfbcZzBOHPnlZCwepHwe5/vmWLc6tUOj/py6WxABpF2u0FS1YgbreSNiCX0OyPL2enlt4LwMzVULk9WC/gjSpQo18DUNJdUZhDbBQKPa6iP1XaCFmmJYlhNnQBT+KYNtyOlD4VQ85Op18rqKo43j/JpsX0vwEX72LEFiYEdbcw/CvU7T9wAlv9EWwBxDl8Uvw2YhaQtrVV/VFCTjtGPmFtXZXjTRw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a94c4-c100-4c5e-6d67-08d59db1388a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:13.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 92c4dca6f5fd3d29d8c1daf02e210dd48dc756ac ]

If the first frame on a given TID is received with seqno 0 and needed
to be retransmitted, we erroneously drop it because the deduplication
data is initialized to zero, and then comparing

        if (unlikely(ieee80211_has_retry(hdr->frame_control) &&
                     dup_data->last_seq[tid] =3D=3D hdr->seq_ctrl &&
                     dup_data->last_sub_frame[tid] >=3D sub_frame_idx))
                return true;

will return in iwl_mvm_is_dup() since last_sub_frame is also set to
zero, and sub_frame_idx is usually zero since this only covers the
relatively rare case of A-MSDU.

Fix this by initializing the last_seq array to 0xffff, which is an
impossible value for hdr->seq_ctrl to have here because the lower
four bits are the fragment number, and fragments aren't handled in
this code but go to mac80211 instead.

Fixes: a571f5f635ef ("iwlwifi: mvm: add duplicate packet detection per rx q=
ueue")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/sta.c
index bdd1deed55a4..8efe965cab0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1259,11 +1259,24 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
=20
 	if (iwl_mvm_has_new_rx_api(mvm) &&
 	    !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
+		int q;
+
 		dup_data =3D kcalloc(mvm->trans->num_rx_queues,
-				   sizeof(*dup_data),
-				   GFP_KERNEL);
+				   sizeof(*dup_data), GFP_KERNEL);
 		if (!dup_data)
 			return -ENOMEM;
+		/*
+		 * Initialize all the last_seq values to 0xffff which can never
+		 * compare equal to the frame's seq_ctrl in the check in
+		 * iwl_mvm_is_dup() since the lower 4 bits are the fragment
+		 * number and fragmented packets don't reach that function.
+		 *
+		 * This thus allows receiving a packet with seqno 0 and the
+		 * retry bit set as the very first packet on a new TID.
+		 */
+		for (q =3D 0; q < mvm->trans->num_rx_queues; q++)
+			memset(dup_data[q].last_seq, 0xff,
+			       sizeof(dup_data[q].last_seq));
 		mvm_sta->dup_data =3D dup_data;
 	}
=20
--=20
2.15.1
