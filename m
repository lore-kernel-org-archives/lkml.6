Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489970-2-10682366306116540856
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
    t=1520489969; b=c9UW6D5PP3bEdaoqFDQTETWlBOxpCQKWXLOswbQB8vrftBS
    HkeB2EwzIzCMlW9dVOosdsmbjBgVwo6ZR59J5rg+RzfIWVPUxTGMRr6IOU3WRwGi
    oKSsg5qYOj343Q8gfoW7+M282/n4ew0vjJqBJrWGTIBnWUFIWyCPytPVlqy7Ufer
    HrwClY94Vlarf4e9M6vViNXv972r+6WXPwet/oODUuSKa2sdJrGsLoubLKRP7QsL
    O0ChCuvz5IlegIeSSh8ZQgbUfiqqHggbWpWoEIByvARosHstmpkKSnIXeyg/RsXU
    20E2aPi5tk+NjJ0GFbIjEeQOs6v+hflDQnwC+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489969; bh=KGFtB7
    PXTZzvlhVSb1cey2+Jy3nsKCKkX8WrkgxKMSc=; b=li4wP6fs4H89PaVQYpJMwv
    9r+D+ioeQHX9oL9S4I3ZjpiWm4QLRv4wePVFa9OyXM/U06yDtKA+3us867ICVDyq
    Q/zwwnnJ5JNcykfuFaGzXq0r0ZUMgjKCnw3D/vW3FcfEB9/dntktfK9t3Qboax5c
    t6YARigoO+qe7vndWCA1HvZa/KYv0e+a/o9pVRY52155dWUlCotxIvlMa3HUJegA
    LMXsJnlA4Tp1qPP9howrKmmwp/ebNgNMdKP/64puEkA/cWKURWWed4kCkAgn0Yun
    rqU28olzESxmvaQD99+sqAifaQzBAE6ViH/tHqIbGeYS846rfNqi5DjCVgpo4N1A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RFVmW8AC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RFVmW8AC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbeCHGS4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:18:56 -0500
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:45079
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965209AbeCHFBB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bernd Faust <berndfaust@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 059/190] e1000e: fix timing for 82579 Gigabit
 Ethernet controller
Thread-Topic: [PATCH AUTOSEL for 4.9 059/190] e1000e: fix timing for 82579
 Gigabit Ethernet controller
Thread-Index: AQHTtpo2p/IEI9fHOUaXfElRcIdfew==
Date: Thu, 8 Mar 2018 04:59:17 +0000
Message-ID: <20180308045810.8041-59-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;20:SRVs7dZtt4Z8g/8RLw1C9XsG194QeMUl9IJy/v+uHZWqXqeZ2oR/qipoCKyz12u+xnw66s6NEx2p5T42VS63FIEPYGzQE/i+t2GWoqxd3Rv1yzK25zhype1WoerJyLfJthg7J9EMdrYhgoWxfGFiu0muJ006LlcwN0N0K4roRLI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5eaee34-05e3-4573-1bfb-08d584b18f10
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB110935B9E6E31C4DD76D2D95FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(39060400002)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: cS8qwZfPnGtavTEvGz1sHc2GfaNtSCi99+MIRkWTg94HZVXBTQ78+BR3MCp158DjCDzkcsCWrOa9y0x7IQsvMcwYSTkBPiOfmx1tBYtJmJw43MQGgRHQnDaKrELf/nMnR6PTtV6qqqBBluOyAgHhP9sf6WJW3ZtDougG8mQPkePiphhmitj38sCa7aY8G6x4AqSY0iEWnBf/W26/z6C/7d2nfLvHkHM07M5Fl+FEgzcMhiMNiOk6h4b7MmqS4CCSGQKVfUmXopAgjURHjb1h4ptS2bCI2vo+hi2KEYIUjRDBFEzTim30Jw0fa/vM45k9vsuzRIK5TXFBQCK14MluBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eaee34-05e3-4573-1bfb-08d584b18f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:17.8776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index 0feddf3393f9..528a926dd979 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3528,6 +3528,12 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *ad=
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
