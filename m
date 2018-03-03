Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122389-2-12570798287600805362
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
    t=1520122388; b=A86pwwUI5cCRxIWPlu5HaFbmjkDeRrLRtfWiGrcDxPeGUk2
    w3U0fmzLRE5onaEefU4wwAy8BK4JKRaC8TwWMPLLa0bHFZey2hVVNqchlIBZjH3k
    wYHX/XNSSbNEm1v+ue1zgT4SUT5lc5GqYy2CAt8doqBcwzOAs4yS5yikOReke/y2
    IKCynwuVIfxsaOYT9YYVYYR+KspgnMXITvNjpBJggSN1R9qbe5QQ5Fl8GGRV1QsH
    GHnQurAYk2FFRZlZ0zS2Mskw1oRUB9udwCnjZypXZgMddzOsoGkaId6L8RoJeiTy
    qiwvl0488PXRHL01N+NjK5oRorFqQKsvO1AY/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122388; bh=7WOAcy
    t7RBmRIITdKt6ci0JZchcHFbT2D9RadklB+ME=; b=WNxX29yd7ZR45K26Z19ppQ
    1ca2noVTJx0QZJ03SrRsSptM9LO+byTJRvLaa8gqQTeB6VxkjaT0JMytkavgtv9D
    1yRWpZyOdNp9YlmvvyUEFPPvRqvszvpfmZnNH/bZlDa0t6Y7oplCMGjoNE6UGfI8
    iwJzjGxTZkTGnJKcSwBMwMDOSNl04TqnqCh/a9vc/svCuNGuFQHTuyw5TnHwNdqZ
    40GttT8mt9vHw/xB5FMNgnyswF6P0S09VrnVwNypuku5+An4YjRdgZIzlfXfcnhA
    a+87VkpiQsPStDDBZmPL4NQujKldiC6nzr8BNMLU/iwOrTy1oPyI/tc916El453g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sb7V4j+5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sb7V4j+5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeCDAMv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:12:51 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933509AbeCCWav (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adiel Aloni <adiel.aloni@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 73/84] mac80211_hwsim: enforce PS_MANUAL_POLL
 to be set after PS_ENABLED
Thread-Topic: [PATCH AUTOSEL for 4.14 73/84] mac80211_hwsim: enforce
 PS_MANUAL_POLL to be set after PS_ENABLED
Thread-Index: AQHTsz614tMmJIcyXkeyyPk/Uhojfw==
Date: Sat, 3 Mar 2018 22:26:43 +0000
Message-ID: <20180303222518.26271-73-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:S/4NXuCJAw8v5fAgPaf0DWZ14WFA5yXdHc6ezeRABkzX7i/gMYdaQzd/LP6H1BH9M1Q2/eIoe6ciPuoOKKyXDfN+810mODzK4iv7tZmkgIvB7ycbnDf0gR62/7sNSVjp02evXUW/hbQED9h6gPxxnLFSfXMwyCCn8TBBmsUO4EYUoT5sXOU9RCN0L2hqmwW2/p8jUlfvEt54GFeiBQohB9JNEAOoHfpIpE+ggECGz8rilzJJb+tbIO5jfAs3jXhw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6677c2c1-d639-4d5b-a234-08d581566997
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115FF16A96B9C5342B9DDEBFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: rXS0t77Pv9wjwMQJE2xXDFEHqbA3JUmhIjHIeWHcRszAtyoZsmRlO1w1SGeH/eX4oemXg3NdbalwMsapEWPntPfeiWnQc/IYY64g7r91h4inWUoe69rMDW4KWvN54hXS4HCIalBRNcY2EWR/tB33j7Yl8Ugx2l44BWpa+129uh4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6677c2c1-d639-4d5b-a234-08d581566997
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:43.1661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adiel Aloni <adiel.aloni@intel.com>

[ Upstream commit e16ea4bb516bc21ea2202f2107718b29218bea59 ]

Enforce using PS_MANUAL_POLL in ps hwsim debugfs to trigger a poll,
only if PS_ENABLED was set before.
This is required due to commit c9491367b759 ("mac80211: always update the
PM state of a peer on MGMT / DATA frames") that enforces the ap to
check only mgmt/data frames ps bit, and then update station's power save
accordingly.
When sending only ps-poll (control frame) the ap will not be aware that
the station entered power save.
Setting ps enable before triggering ps_poll, will send NDP with PM bit
enabled first.

Signed-off-by: Adiel Aloni <adiel.aloni@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 052e67bce6b3..afbb5a813d46 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -727,16 +727,21 @@ static int hwsim_fops_ps_write(void *dat, u64 val)
 	    val !=3D PS_MANUAL_POLL)
 		return -EINVAL;
=20
-	old_ps =3D data->ps;
-	data->ps =3D val;
-
-	local_bh_disable();
 	if (val =3D=3D PS_MANUAL_POLL) {
+		if (data->ps !=3D PS_ENABLED)
+			return -EINVAL;
+		local_bh_disable();
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_ps_poll, data);
-		data->ps_poll_pending =3D true;
-	} else if (old_ps =3D=3D PS_DISABLED && val !=3D PS_DISABLED) {
+		local_bh_enable();
+		return 0;
+	}
+	old_ps =3D data->ps;
+	data->ps =3D val;
+
+	local_bh_disable();
+	if (old_ps =3D=3D PS_DISABLED && val !=3D PS_DISABLED) {
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_nullfunc_ps, data);
--=20
2.14.1
