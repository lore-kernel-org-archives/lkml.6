Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243983-2-10203262558016831422
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
    1523243983; b=eRM+kYJQD0ojBJLHBkkFK2oEv/VrsZaO7PfGaqEsavDUNehwIa
    giKlho51ZFB9awruxN6c8PjdhIufFq98N62c/4eK5I3jQOudjjvebmmNVaonhaRG
    by2TV6KenQPnljK1NmWumDu5gNBIDX8O+qqqpoWTHzlttRKwYDwIeAFHKeRbPVT0
    pIer/d3U1Og3iudDFyBYVwtOJJgq+LEE9jLK62MeGYJflXmG/WISalnu6KRO955I
    QdObeeUsqu97cRj2UDaYT9GZYEK0WpSrAhW6GUthgZpDJXwcrAyAoSyHsxEIqrpT
    Y2PL5ae5sYt+0WdAFLkYRmZyRh7bFPYFCCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243983; bh=m6hsOats1s
    MSyrWQZSDQqEoMNjQDkn1RFO9nUycKQDU=; b=Q0oTzAi18Nqhwh+otCpDtC1uqZ
    Zm5Has71PP63Etvksnvq3hk21XW4TUJakEt1pvHtbqYt861bW88usr1qTi52mdQ3
    zCocSdYvMNHZHRgwdUkFPJeP06Y2OOgdtatwUJVMzE33M1LbdVktiIJHAmR3RYyQ
    eF1Pc8y5y8VtOdHDPHqyPUC4Bikrp/CosVmGpshE16Dyo0AeY4KDLe4sy5qwJ5wt
    MmQzF260BAM08Y6rkdN0zS472QqGy4xBBoPmPKN2bybsYeQ9g5LpeYuvauVxITyD
    LHtaccYN/EZwFZ1knsBKrycqtjymohzGhbiadhluXlJePNzda9gCxI7wxDaA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DOJmiYRx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DOJmiYRx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP5U8UJxQNQcnrBqRl5quI6ZDAi1lDbVH28x1W24rIGD/um6qP7rlPmKzdPEa/X14wKyveG56RgZE9ixfBRpSpog0AHzJnqoDB++2Sb/R+eV7Q4cMFEj
    D1mWV+W8tKc94JSyKm7V8pjtHn95/ICaTRcxJlUhmug/hjQRx/1lnGaV5Yg9YgKnttMFKBbAM/yiCR0XpjhzpstBstM+TDIQl2bpkZ8BM/vO0bTBVey8XHJp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=Tqf2YcDcvnV-e9xK7_kA:9 a=2G-oqGg-JSECXvxw:21 a=prCzMAxulp7vZNzx:21
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDIDT2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:19:28 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754814AbeDIAXE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 051/161] Btrfs: set plug for fsync
Thread-Topic: [PATCH AUTOSEL for 4.14 051/161] Btrfs: set plug for fsync
Thread-Index: AQHTz5iP4dzzTaEonkG84+kCCMIHlQ==
Date: Mon, 9 Apr 2018 00:20:27 +0000
Message-ID: <20180409001936.162706-51-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:yyejgH5+BPjo4CvfXq+5gBzZfNaXWh9ZVeGBY0qkE8snzhgroZoZa84r3rj2WnmmHx0LY6F3XZXS543Bnukhl6LNuCjdB7wj+mRBbLAJ1hB4Pa4T1GcS09r4dAlME/O7LX8i6hEIpdmulkWEomGwqr8KQ4F696nbAVBG/Cph2CjE37rjcY7hT8XQLslsfU37f0mQp1PGZepd4zjtaZFE93qsd78r0Ap52PtRdrkICkHbNlDqVcvanQaNhrXupJFa;20:oV5JLs6sWE7j559xVHs9lxG66/aTWiu3hEjMIF9ApGH0bzcXsGzwdxKnMa8SfMfYuOZm3o+SCG7VGe1AOY3A04QosqrhVXJ228lDUxFW9Jnkn5uZa26eVRNNUA5b8kLMvw/reSV+JUSAi9AdfSiotpjRl4yMvnz/rPpRGC3phUs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a7eeead-d1b5-4950-677f-08d59db00bdc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101432606C84050A0963E862FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(575784001)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: f4MmOPChXZdec4lJL34N6qlP5akFyk0AJw1iosG82pnxaW9D/JR+uExN5VnfkiQmYZt3m+aBD3BubnyFZ0PXMh7c7pspSdVqAhGSIpzIp3UIKZfjk9Nu1qzrz4nU7I/CJ9Nphr5dBdqdXNq+nOSSSYZgT8haRbF2I10DIeNhzE16HtbKUMQoGmqeOQiT3pnC9dVcnyHrogIz7Zzzlnp1ggfVbJIWRonXX9Xa5YX9Raq/kz3IOj47zEUTZ88uzVQ5K07M7pJZEA8VhDvFDQ9Z5bpC7jUMlb9cHOHpfnDDFIW5QnM1/r2DXSuK8CnHOxRHOkNqBv8tbTYtua/yCkAtz0FHw9eHnmYk3JSfA8xLHb1im91KyTNJP4Onkp0JnGtLNO000o/uNb0C9RJJSTXZcAwnJlz+WKCZn2I8j+q8IWc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7eeead-d1b5-4950-677f-08d59db00bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:27.9100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
index d564a7049d7f..5690feded0de 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2018,10 +2018,19 @@ int btrfs_release_file(struct inode *inode, struct =
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
