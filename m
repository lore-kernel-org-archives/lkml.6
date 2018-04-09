Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246408-5-9874594164300685597
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
    1523246406; b=vM/gwCToRXPRu7I1Ubr6yWoASww7dSXog6aGRddkvqCSuPZlRl
    1bw2wvAsYxKTyie7LvwhhiH3jUYUSuehU4TXfQhBCidBrpJSp14elBB6r/fQRWIq
    ACMt/3ahfB3enHtXABL/0qLmBEzFEFqdYOGQ8J4i66B+3JxDBBzODQXaC80h0HBQ
    BiM8q4kqZ9A3LAU3F8uaBEQqKX4ZarTTy8to4eGj9C+R4uuNT5z8OSJRpw9V/Ujg
    VGc5kyfTFnU5peQ4xxU3v4SY4IE19UTryQxr6iML3fMQ6YuFZDAPRcgj/2PTmyMr
    juit7cFPjxGsRUpbcVgOcPccd20vfrinFMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246406; bh=pTS+Dgog2x
    H/j+k6vxdzD43SwoMsgD5coCllED9B994=; b=t5tAeiRSmER9/xSTAEU1kc3jOs
    ZgHD0jCImDlYaTBi6SBcVYnQk3rEGnppduOPiCk91/q8UtDG3ZlP7xZP9L+hNJo1
    heXML8c9HyyS2HU/XAYnrl8ByKOB/1YCMuPtfrTs5L6NnachkQThQHDyiuZ+FzM5
    nrwfDnFXTgSzP4GR0tNiDxqhZwlXfK5OXUOFKC3ThgovEPPPn0zPDAMKuinBrgRy
    MXdCmfKBmN1cTV6HRPFTI3lXkfMP8UmSz+e6gHt+eIG5aeDuNUKC9L33KCIjK89c
    OgQWzyQLfOXfnD1aC0zSrfEg+B/iVyDgREYivrTPZHV+QuXMEtyAoQc0bzxA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GkipOyKY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GkipOyKY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBD6X+uiMlMGpHWIovxPGi8wcCYldNnI0+1hGrKoqbll9bWLNY//KEbocaH8UKoJ00zZ/6JpWf70WPLZQ5LZPu63aDEckoZVG4XagXEDhATcYHCtwNZL
    7hkPVo56Ww2cQJyUdbgFsrGkv10RU1sNEhNQOJ9lpT6/j2tYzSEWTy5CvbGz89HGIhu+gruVLF5O/DZwWLx0QeaCI5GfuE0jrhzOuWT01fwiYNjKoJucmeVb
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=Tqf2YcDcvnV-e9xK7_kA:9 a=2G-oqGg-JSECXvxw:21 a=D0hLVKkvous17Jmd:21
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeDIASd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:33 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:37278
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753596AbeDIASa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 061/189] Btrfs: set plug for fsync
Thread-Topic: [PATCH AUTOSEL for 4.15 061/189] Btrfs: set plug for fsync
Thread-Index: AQHTz5gnMKh/GHPDBECrqyLEm1tWEw==
Date: Mon, 9 Apr 2018 00:17:33 +0000
Message-ID: <20180409001637.162453-61-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:JdGUYevYeiSBueNtQHa/cZALvfmxkkwxc7pOj3ot0LWtb3+Y3q9MGV/rASAXUVOGpI5+cYD8+TvGK74D/RHEwBHtWswXw4TWkcgStGBG/t9QTFzSQbOx/bBMpQF0+zELm16FrBMFUdPoDoT4Ya6aaCax7u/NiB5d4en5NUp0+mhQc9bxGkPhWbKc7Yp8oYXOCC+4O88gtdnTHwDxruwyndgE9ZLotoGgkReA9Ykj4pSq36beOi7lLmfqVVAYDriz;20:qngk+11WnU5/NETjWbzTDUYAMeprG3u2FstaacbVcxIPaTP18NJ+B3l8Gpcd6Fixk8NIUVq97d1IafaRKy8IDPzAnpy8Byoq8JmEUZtxdSTJkzLJcDewfR86Xz3oZWeu6GnUajpIFi2olKaiDk6Sl1BeJG/hM2c+eUVNMgUTaec=
X-MS-Office365-Filtering-Correlation-Id: d610d605-0d99-4b89-d960-08d59daf6aaf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046B05C560DEC811A4B3F00FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eTyYfB7w934pXXJn+ne0eN8pQcEpZK8REkLoJPm9vdSnDwYqYRwtKWMdY/qcKZzSeB5xEgbjdC4/VS01d4cAg2EU/FddIofY5ZHAU7zSQuXtlNLR2u+x/CFgyP2O1bg9UllZjInntIoQhQ2kVeYCL8+qcG2fDk/qIVruSYcplG+y+Ttsm50+HBgGYsCRHV0UPQLe/94oUkmOCAT01oa8JyVWMPjUve9OAORTb035rIgdSNqtP1l/+3H36Sq0JFkwjxlpvzp2JsOgC71KzdATAxAsiAD2eq3lC0gpvAaZ+l+O4dOCcLZzQ2RJVwysvwwS+QWiRhrdsNu4SQlVdfesk6H4/k8RJpVZZ9oX4G7gYju6OsMSPrL5OEvugKxS37pOAgMcEv+tYDhW2MHX1XTu9eOHxjji8SNZTTYkgblNsv8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d610d605-0d99-4b89-d960-08d59daf6aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:33.5872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index eb1bac7c8553..4368033593be 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2019,10 +2019,19 @@ int btrfs_release_file(struct inode *inode, struct =
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
