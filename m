Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481843-2-8623093141302831658
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
    t=1521481842; b=pNmgBeBsWc7M7mA0DnOCMMbgh3KcxyGXiFwvCQsbVYgW9xT
    65Vz3o70I+MWQGCVMGilVJ5Lyi6RF1g3cWwD+PfaM/bDbVDZW3qBeXMzZqmmmpJX
    VVgTS4lV8ltBrng4SSv2lFEpoR7a2qmKrr//TOC7+NwtB2CCdpo0Tlvh9HpMcJ3F
    DOE5C1f9kNyB4DBXQvhP5utARMw6jUHKDJnK6/hJVLyZUkIW8+Fjwsm8wjV8Rwgc
    vXC1ZyRknzQGt/8sI0wWILMJOsT9d1igEw1TFcVlZ/Nv5DH+vRTo16b1hN8YwPD6
    9EjyGOQOANuxGC2a1iaM8/xAxD46BnBbtUMzmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481842; bh=x3RA6f
    KRqSzs7PDYPvdGSMm9hIA44/2lzHmLAT+kfKs=; b=jkW238rkmcaVwgGHEUoLvC
    3WIsBRYyOEP6hQ0urSIT0qjHMZCPTLyOw/WI+An9Be1XGew/sYixLcUI1DW7CyMk
    f3Aqc1m5WvS6ltXS2mrbpUPlJXFU9tmIFkFmjI4bQY4FTVYUEsvTogiVIdFXunFH
    PUQ5rQVSBekUcCFy6hTUqIPY4xx3vMYlhWXA0gwZxsSyq4Xg2FxNzfL+/qcpqno3
    LY4QpCLWKcrrZOTPCQHQ+JQWszqgp/iBm6LyZuMXvbeFpdoz/G/IFmCwuFRUzK/v
    Xck59GNDxdHL0JXofxu8z7YNwzxWpGDPiuR4YQOIvf6CSoLbSGiUnyjhY0krG1mQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ONlj3FQZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejjeenucevlhhushhtvghrufhiiigvpeefhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ONlj3FQZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdejjeenucevlhhushhtvghrufhiiigvpeefhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965722AbeCSQE6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:58 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:7948
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965712AbeCSQEy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Wang <jnwang@suse.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 227/281] Fix loop device flush before
 configure v3
Thread-Topic: [PATCH AUTOSEL for 4.9 227/281] Fix loop device flush before
 configure v3
Thread-Index: AQHTv5uqs4OsYbWTQkCjyldzPF8pvQ==
Date: Mon, 19 Mar 2018 16:02:22 +0000
Message-ID: <20180319155742.13731-227-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:RSs5N1RDqkXegay68bjlOu2GP5fjxPinB9pR1ur14YCONcsThCD/BivTnigv4lFGyoAH98soCw19UqvEdTk0dPYG3Db9PRrI4bU/rxSjvDbMxCDF8zZrhI3OqyOfyOnbKJFmCOMSLOdxmXctOtd0Q2vFpanWpTOZ7VTWryMq6apUvG8+bGfPWZMuIh3n8snre1phnmXuekV/xNWDTsWgX26kfnAH+AsAsIv9vEb4BcF9gMiCyh9mVdBNG8XbNnRE;20:Kn6m6tp0h9yNaGJRhyGSo5xaZvr6oGPnfKJ3qVnNdeDGrfMS/T37gKequ5qvViN+uIv+SuSbUg4HJhCit51G+1ySuHQdKc2Jy7Pj/aDrt+C9HvpBmnGV9GrDd60sJlzF3tLKt9RAzERS4GaE4orMhmNH6YMsYmPQjNsZS1+oqYc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9289b586-b5eb-44d8-9ae1-08d58db32485
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08853E6CB50798E56DF92B7BFBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(54534003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qNUlXZkyG86w+H2NCsmyffGHsc+VQMweUyKXDZ/t5C2GT04TNgyHWwNUoZP7YcYAyt4qTwtaCITOR4+9zTpE2cjp2yWB9HDg6secwkhVRHT3eu0VcSt05VwDc+0qweu1cTKsVS2869e4XCCVOkrBqAJbQDUzTbrRLSUybuitk9vLzJylW8wU78UUUhH6hnPh8ToE6G3n6ZuHQUocR5/nNOUY5EvgJoGPBVpzfeK1UFFRNx1H3vjFY3KXrI340EmW0HVFqOUXKq7WCrUGQ9nRYUghar3WMWAIml56J2By6I0uxUtiSxWEi1yOT32f/zEtE32yv212j7rr3ajXlVM8vQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9289b586-b5eb-44d8-9ae1-08d58db32485
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:22.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Wang <jnwang@suse.com>

[ Upstream commit 6460495709aeb651896bc8e5c134b2e4ca7d34a8 ]

While installing SLES-12 (based on v4.4), I found that the installer
will stall for 60+ seconds during LVM disk scan.  The root cause was
determined to be the removal of a bound device check in loop_flush()
by commit b5dd2f6047ca ("block: loop: improve performance via blk-mq").

Restoring this check, examining ->lo_state as set by loop_set_fd()
eliminates the bad behavior.

Test method:
modprobe loop max_loop=3D64
dd if=3D/dev/zero of=3Ddisk bs=3D512 count=3D200K
for((i=3D0;i<4;i++))do losetup -f disk; done
mkfs.ext4 -F /dev/loop0
for((i=3D0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
for f in `ls /dev/loop[0-9]*|sort`; do \
	echo $f; dd if=3D$f of=3D/dev/null  bs=3D512 count=3D1; \
	done

Test output:  stock          patched
/dev/loop0    18.1217e-05    8.3842e-05
/dev/loop1     6.1114e-05    0.000147979
/dev/loop10    0.414701      0.000116564
/dev/loop11    0.7474        6.7942e-05
/dev/loop12    0.747986      8.9082e-05
/dev/loop13    0.746532      7.4799e-05
/dev/loop14    0.480041      9.3926e-05
/dev/loop15    1.26453       7.2522e-05

Note that from loop10 onward, the device is not mounted, yet the
stock kernel consumes several orders of magnitude more wall time
than it does for a mounted device.
(Thanks for Mike Galbraith <efault@gmx.de>, give a changelog review.)

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: James Wang <jnwang@suse.com>
Fixes: b5dd2f6047ca ("block: loop: improve performance via blk-mq")
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 402254d26247..2c4e324add4d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -612,6 +612,9 @@ static int loop_switch(struct loop_device *lo, struct f=
ile *file)
  */
 static int loop_flush(struct loop_device *lo)
 {
+	/* loop not yet configured, no running thread, nothing to flush */
+	if (lo->lo_state !=3D Lo_bound)
+		return 0;
 	return loop_switch(lo, NULL);
 }
=20
--=20
2.14.1
