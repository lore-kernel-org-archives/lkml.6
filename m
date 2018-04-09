Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237981-2-2144837866451637873
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
    1523237980; b=kvEuhqjxjK/yVOml27iglfQrvDMJQBglqTIqSfDeRUkbBJAvoW
    /IPNdX7RGhQPMKChdAEWJnzLVVgb99ioxcYXwWUXSCLs67l9hO3L5FOjAK1JLh4/
    A3GtQRu7dJuQHjJ+e3pEQ7Nl9fjhfvsCaV7d4OXgW6n0DT5NGHrxfxLuKf+9PZjm
    9yf4FHuI5dvb4XNHVoPXALWKHKb5xdmbPrPybUVS9NQnIL9eF+SlIA/KtMOqbXed
    TritrV3XCXmlwnYgciFMUyXW8JSIgZx5Th8Y8gXK0VZJ302AMFVk8AGIa0CnoJyE
    0/w21UhEHXZExRb2NsYoOxEFQtGpxpovBXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237980; bh=XDC9IIrTUq
    +xOcipMoOpSPITaZaD3RhGcsJ+6aHvkOM=; b=YoSTQ5AYErlTmkFAPQtvYvuwkB
    2a2kubogXL0i25msSniCpj7UARzdC/1vc6wU3ig3IV14J8JcUN2zSwD+6etYIPma
    jKXlLqUYdKyZR9gNrVnyVLlzS8FJ02vsDBLXbtruHQKR+gfXEBmQRf3P3b0BybHR
    BEKMVbXbO+fvJQsYDCMEAboT1fIgmE6QSD1Heek+Q1WCJtdkCn0KDKCYhQxK0JRe
    UeyMVaEsTONMWUOnvieRAEAVz5JmwXgntbI5/TAx/5EHh2qF/OUb5EbO4SuEGBeL
    ZwGxugPxP586Ini6k8Y7DK66M1lJMZtp8l8oM3lBOv/7PhPA7UnX//ebH3Ow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GmWZr/6f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GmWZr/6f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBOICIJxDcn8hFVp4rtjzwYEYJ45z/5ZyVwhsvzm1w3FxibnQwi2wH6C+FnFBDP2WIMuI19EqsU8c79gzdzXHH7KaZjz/Q/efMTZHkDdZreJx76T+FPI
    AFVip5Tgp4lMjPKgsKnWNF6ogwa50H860B0KTRL9asUb/pHF7GN1pNkukNffZa+aiBeUjH/LwTlLdvqG5N69GLZCjAW1RVFn4imdHjJrV/udiXvGUOPzNBDe
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=FOH2dFAWAAAA:8
    a=yMhMjlubAAAA:8 a=IbFtamc9Q6F5muXr8noA:9 a=3O5B1PkIbO4IxEKX:21
    a=kPIMloZYuvdWKp1b:21 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754897AbeDIBjY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:39:24 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932551AbeDIAfB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Wang <jnwang@suse.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 006/162] Fix loop device flush before
 configure v3
Thread-Topic: [PATCH AUTOSEL for 4.4 006/162] Fix loop device flush before
 configure v3
Thread-Index: AQHTz5mV2cj+WUr5dkmPNNDxHfjH6g==
Date: Mon, 9 Apr 2018 00:27:47 +0000
Message-ID: <20180409002738.163941-6-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:bs0y9TV40oOKGcV3Z79KLiLdPf3RoUrjbRXlntDOlbTyvd8Dm4nSiuD8r8iSImkEoAnoT1VB40IpV8kCvraD3qChAhjHEaV/rdO0bswf5LYekbs5C5HH/vONiYRYt2Vi4wAGdUG5e0DVgLTtzb7mXFVTf/Y3WFOfEnv0xmo9Zv6zlVZVXYMrBFxpOEE2lJ3dW8c/pvrmd9Yl25cQLJ8cFiDQ7u3wkh6lHsjSTOJDEa3TrT27rYl7sVJHAIcdavLF;20:ZmILy4fhn+uur4U9X3MEXomOmkkGSJmvKmtLySQRp6bKLOP5op5Dl5c3JbUiOWP24OCX0MFnmIGSAKAWnUhIkiXnIa7Dhx7ri7uPILQdhzq60DiGMhB9FJe1GE/+c7b+wiCbORP+uWCYxG8DODmZtLO7arDeVoahAnYkWdNlqW4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb2a8255-8327-4e62-44f2-08d59db1b619
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080694B627FC98A568F447E9FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(54534003)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: twVf4Y5Q8HLTm1kZv+SUAK6eNYjydIWFzWyICjLyYu7C2mOpJPFF0HRsRjjRC3CkfaxuNIM0bEFvMAz59NKH2srIyOJ+lXdHauC8fY8YJyRZSxW8EgR6UczetjKqYR84VhYU4N++kALo8/jSNVGGM8mA5jes//qHNMZV8inre0UhCM3xebsKhEiqD+Vc4aQlfLoNxxu5XTIVi6UNYhzJkyxS9reC9XkcPjg+Txhcfajd/ykiHLQkVfBl9iCrWejCb2MYu12Xw+gk3tFYkZFO81Ord/RsMB44/WaF9gvU+DfQqLhMp3aNMwD0SQmu27fCX0mLcTp0lji1962g+1arbzT+g2BA7Umx+XBYTcNS3MQjgqzDPKISHvMMOe2YgHDPrkAy7m+JiTurF22sRRzKCUr3K5zJ7/8SdHFx9U7JAsQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2a8255-8327-4e62-44f2-08d59db1b619
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:47.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 3e65ae144fde..1dd16f26e77d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -623,6 +623,9 @@ static int loop_switch(struct loop_device *lo, struct f=
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
2.15.1
