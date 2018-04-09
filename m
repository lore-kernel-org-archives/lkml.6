Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238827-2-6875225659735418131
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
    1523238826; b=p6GNFCmuPXYGYUxPpNPtDoW0BUwM0jPoyQjAX+EOQ2cn9cl0V7
    dggy2lYdgVl3CyJ+2pq3QqPvBKHUWqeBWl292er3w4dCBPSGXBnrwVvZ5N4blrr9
    LAxf/Gla1roomubF52mrlogiPxSsRekcpUt+X/FMN6T3f9nMT6bydu9Wl7+xHIL2
    D/QdJjurfo9ZVF4qQR6AtrmWJ05JbXft9xFp4+3ZsdRPXTwLfN07bT//CKNlS6/1
    wFWZ+ayTUnoFIdnOfCyzM8muJXosLEFLe/0VSNNHk3zTCdoRfCRWIzzCdAarai8a
    b4glTftJlGGRP+kreEJDrAlXJAniMY2+qlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238826; bh=tUu8z+A88H
    eXFDtej7UfnfUO1gRu1Nt/tb4I5pwUdpc=; b=dinkLR9ysxYblSvL5Vp1vYzbax
    iHGFvot8ZfmqYbvrZHq6k6fS7j3qdkgbZCpCAtVVrh0olZm1XIw/GVuArZAEv/Fw
    7OAh6HMikTcX/jmrwbKRfRKSIq5VfGbLiljJgEkgVNpdue6RGXAUshUs2S7JIXwN
    I+Df4DuHXDhCkIKagSQ/8JmoFfLq6Y/UQQEircRchTLp1Hr3K8c+NxILOpgZdg8L
    RTQ2jfudsTmX9FNVqm50zDl13tApdEntvyyNm1NMEgYyhP6eO+auWbefPi5PTSTO
    hUrtWhFRW2FRU+R+kl7YejEqn6I4hERIu9g84lrMPtsC+ers5r8HZLV7Bj7g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c3qm4mqU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c3qm4mqU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG+FRp54xz1PzB9Cuoh1sMhYZKdKE+PSflUfdGBsS7fjwgBmemgumtMiZwkV/HjTYrPzh5soeo7iMI84c3aZ6nMqo2EOTnkBPpjEtSvWTIe6Su+Su5rM
    i/XGTBA0sFLiw9emRmxTtP3ZVGMBvM57OjvNDQqKhoiv3qvGqSDotM4sRh1MSXQktHX0hh0XmdmriAxvPyGBKUCTVZYnesYVA5Iyblddi3Pa5gNDHFK8R9KN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=Tqf2YcDcvnV-e9xK7_kA:9 a=2G-oqGg-JSECXvxw:21 a=prCzMAxulp7vZNzx:21
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeDIAdP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:15 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932234AbeDIAdO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 237/293] Btrfs: set plug for fsync
Thread-Topic: [PATCH AUTOSEL for 4.9 237/293] Btrfs: set plug for fsync
Thread-Index: AQHTz5lUR9EcxozUwEieeYV7B5sNrw==
Date: Mon, 9 Apr 2018 00:25:58 +0000
Message-ID: <20180409002239.163177-237-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:52qXwZ7PSYUrR6DOEoFFNeoa6B0diZ98w7NpVWp6+McR7FDDzbHRIn0wsTRee2L2tMdzzEvEhxnU+RJbgFn4T4peGJJeXO5gpVwImKsJe0IH2aGpo/n6vb+tvOIJpV+PSoICtMwtFz7pDK6jAUWdjZfCElaOSDrRckeL3yK/3826x2jwXZzoO99fv+71OHlBNNsgBa6w43M4EpF5qQAMjR8REZx9CgDGnlxkqARRS+v32rZmu1GtOHrq8Vq37420;20:5uayxGtse62mtuQIpSNxIDWHIw4hXxuD1+53LrNP1usr0wGmWeykpyubsgYmZXLOPo1Ffc3lQwyGc9B0vdAsDCtDz96kZQsiIoO0BQhus9qvfOgjB99q/rMhTOK1VuQoXQ+jxLGlRdRovrWv88WThsIp2Zs8P4JXLVHIDxyE8y8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a42b6201-d18f-49f0-fe41-08d59db1774f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090221211187AA28DB65853BFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QjokkwdHcBszMIlGuItmZjri2k5rDN9WYz+bhlFnWK6dIPXFDXYrpY84NoskKx8Y1AdCV510VIsUg7dgV2eTXDwv96X3BSDFpBiuFfoptcbuGxMMz0buWEN4D1t+nSivDN/9B6JXY+3uF+9ApWGS5+tpamM1652Qlb+9Hw2Xgq7cRFhM6ZngHPcrlr77aDA2Pm1IWgGFiE3xBKDfrUmg4dwxMY3CkgBSp50OVIZVxEHm3MDLZ9P558LBZ2L9dWp66StFPSpoVxHnXUh4VL6dID/47yikIkbTFJRXdireQ7xlL4oIkBOxjCum/phyFGW7T8wAYT+HmspQ1aDB04HMN5I7iMnPAsKXlf5aVhwWiNBTNMVvKc7ehSlo4wUuuHK1gUDaErwMis4m65UPV1pwHGKoJU7AP6dMvWUpNO4E9ho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42b6201-d18f-49f0-fe41-08d59db1774f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:58.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 343e4fc1c60971b0734de26dbbd475d433950982 ]

Setting plug can merge adjacent IOs before dispatching IOs to the disk
driver.

Without plug, it'd not be a problem for single disk usecases, but for
multiple disks using raid profile, a large IO can be split to several
IOs of stripe length, and plug can be helpful to bring them together
for each disk so that we can save several disk access.

Moreover, fsync issues synchronous writes, so plug can really take
effect.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c95ff096cd24..437544846e4e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1912,10 +1912,19 @@ int btrfs_release_file(struct inode *inode, struct =
file *filp)
 static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end=
)
 {
 	int ret;
+	struct blk_plug plug;
=20
+	/*
+	 * This is only called in fsync, which would do synchronous writes, so
+	 * a plug can merge adjacent IOs as much as possible.  Esp. in case of
+	 * multiple disks using raid profile, a large IO can be split to
+	 * several segments of stripe length (currently 64K).
+	 */
+	blk_start_plug(&plug);
 	atomic_inc(&BTRFS_I(inode)->sync_writers);
 	ret =3D btrfs_fdatawrite_range(inode, start, end);
 	atomic_dec(&BTRFS_I(inode)->sync_writers);
+	blk_finish_plug(&plug);
=20
 	return ret;
 }
--=20
2.15.1
