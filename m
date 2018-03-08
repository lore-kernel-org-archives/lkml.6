Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487562-2-18102141778767122758
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
    t=1520487562; b=EbVQJ6+JZCMH1Hwycf0mtIKksGpTdmlZComE7BsJaCviNy9
    6hprB3h5wEBxnrQysMluIW6rGZMublH0HzsPNH0Z0PhQjbaiVPQgOgHcnSHjbgDI
    7xyYoFS3oF7Fsb60B9tbv/fboaqu8li9eiNm0yJNdxjtvmQcuihqcJUt2y40JX+e
    pF4YbmdMTBbxyTV3KbkyAwFQcgFYW/TSnfKxrPFqP3Ii6gbWChIYBDNPszwLTQ0L
    DdabJ+U21f4PfQoR5yUG7LCOAubiXt2M8dL8SNa8HL+shuXb2E3A1K7kQjxogLwz
    5cirUjIPmEGCw7C/LhkS839dQiZSVLz0fM9cGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487562; bh=Wj9u0E
    cqoxMEn+mcebMA+nCXT5lL54vvD+T57zDzowk=; b=tvptPvrrAoTHlvPj1pYV+J
    oytsIwgR0pjgwA23IJLneTbgBUULw982c1wNE9uF/F4aRMud0D9xJQNk00H0ujXV
    yKr5ugkgAF1GhM/r2GFRwsxke5o+lJLtaJEAcSmwaTT4HaRAKm0nFPHhC1ROsGQu
    bt1rSmb5Ktp1IWZmVZVS2jK0RbeUE8TR6D/OGeN1WIAbD++Ocyj24BYWP6JoKgD5
    qQQJ0QauyIANv+LtpW1KLTIA9Qt8qa0TLHVtuUEgL6xgVgFMeQ0ixRN447nLcDMt
    Lctdx1TP5/vTwlc3u/IZcuQrRV+v+L5NdgKAKPuGdEXj1JA2reLdVToUX8LYV2Vg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eAy9KaPe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eAy9KaPe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965558AbeCHFij (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:38:39 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966074AbeCHFFw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bernd Faust <berndfaust@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 034/101] e1000e: fix timing for 82579 Gigabit
 Ethernet controller
Thread-Topic: [PATCH AUTOSEL for 4.4 034/101] e1000e: fix timing for 82579
 Gigabit Ethernet controller
Thread-Index: AQHTtpqK3SEXiBf3lUu2J4TAimkgQg==
Date: Thu, 8 Mar 2018 05:01:38 +0000
Message-ID: <20180308050023.8548-34-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;20:4TrSr+qIWd9twH8Zrb+q+B81Gua5YjxTXTbutELW2oUMIWAnBJatOYxMAFL6FIfM0pu2YeB6ZBJat+O1iuFIJ8JN+sj/6OBRtQvfxrGSY1gHW4xGkCa6VBmv1A+GWr3TztUffJKj0m1pJVEnnRbKlKknV9w+9lGGMGhKSvByC3Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98034649-0b2f-49db-c831-08d584b24226
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB104617DFB5EE5653DB0B4A87FBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(39060400002)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: l0JEaIYWtroDemYese96kNj6iFQCUF96Tc/2YxTvlJ7jhufpDI0e6Cwz4tdhGa1qur++mpkbnB7Kg6i8rCynjsKQ1ybCIlJCwHnFleGaZ+GfJSaRgNLTloh2s07BPyS+gA/6Gh4P6qTOntdY3edT4eZX0X3Kaj8slyzdO7GpcgEwPigsvIKDParlWd4p/lqe+55EJUjagQPJxDRvyQV80u5Evg/qRoaiOraczdwxuOQ0mdCXqHUEqYZLlkVvv+Wq+h7B5S10nx2xGPk3w978KWTOUx+eax3+zVne6yRZHKC+GtgolfA7uTml1X13IuavjEKAc29zP1c0IA3lvGc51g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98034649-0b2f-49db-c831-08d584b24226
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:38.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bernd Faust <berndfaust@gmail.com>

[ Upstream commit 5313eeccd2d7f486be4e5c7560e3e2be239ec8f7 ]

After an upgrade to Linux kernel v4.x the hardware timestamps of the
82579 Gigabit Ethernet Controller are different than expected.
The values that are being read are almost four times as big as before
the kernel upgrade.

The difference is that after the upgrade the driver sets the clock
frequency to 25MHz, where before the upgrade it was set to 96MHz. Intel
confirmed that the correct frequency for this network adapter is 96MHz.

Signed-off-by: Bernd Faust <berndfaust@gmail.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ether=
net/intel/e1000e/netdev.c
index 5205f1ebe381..e356e9187e84 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3526,6 +3526,12 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *ad=
apter, u32 *timinca)
=20
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
+		/* Stable 96MHz frequency */
+		incperiod =3D INCPERIOD_96MHz;
+		incvalue =3D INCVALUE_96MHz;
+		shift =3D INCVALUE_SHIFT_96MHz;
+		adapter->cc.shift =3D shift + INCPERIOD_SHIFT_96MHz;
+		break;
 	case e1000_pch_lpt:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 96MHz frequency */
--=20
2.14.1
