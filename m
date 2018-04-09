Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241966-2-2356915636813967525
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
    1523241965; b=RKF7bYkJ/VLy3RgaIQuKFz3rPwiVECc6sDaqh4UfC87rPZRB/7
    iczRfcvNTyxsmZVM5Ka/Wjh6TiKj1TP8CHGc3T1aOR2Q/MamJ0WUPx5SW7aVst6X
    guIWyt4wRejjPC/tZ6Ep1Fq65zs62ujEeCxzoVRiLegdQk6bdEuD8Zjj25B2T9i6
    Kbcqi4hBndqCqsyY8FnGdVKjNmMIjMQRi3FyWDuoxyA1VE5jpnvQQmV5D3zKNADE
    gp+CReuI5ZFIkVpmLFor9dL5z4MiAHD+nBPqtLoxfu9PLmGMgqSIvmfeaJsYhzg+
    GKprPSRuvROYyFhJrY3XZE6fk3ejRupUlCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241965; bh=Il2UN7Ldpd
    Vf/fSytyAluCmonMnpmPQPl91QoGD2nXg=; b=Ckz6YS0Yn9R+6z1fF95SLprJ2i
    BLHIvZQmNI+hxU8LMA0hQosP+udk1N58i/hiHUuMHUZgzFd8o7teU/+o4YmiBcNA
    QgkdxGPm3G38333K0LimHHMiruC65HibC156aX7EzC3kVBcpkJ1yd3lWqNCTXd1W
    KyLvFdJadZVwuKN/mLSvWk9d2uVfBl2owddNhJ5xf/SsjrgiT2wv/FjWRLeLhDe6
    SM1P2/++cxRiWdrSdkHaFY8kP5d0Nuwzn7m+4s3/OODroGJrevStenNLDjDJCPAP
    d1BMdcKizT8+CEX40v1UYzgM57hj1RdjuMgEDIjd2px0XR3NZ1FtFaTnEarA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eJzTtcq2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eJzTtcq2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrpRy+y8aL08Rr9G8jIarsqP2JF9kwH4cZKKSPnvOcha9pbPEYlQTr9fvgav9lgGAML8e+Sv5u2q6wqF2yhoGVzhDgnv0mnslFIa5KXdqSLolYRN03C
    LQB2ABI49C7Rp1a8kVMwM3xZ6Rd5RKOlYM+Q4cszkL8Wq0n7QmV5H66s/SqUbpgIy3eYpgujfkyvgkFlffA7CLuHV2dr4HvLflTNm59eHe8721JxII8N48Cq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=FOH2dFAWAAAA:8
    a=yMhMjlubAAAA:8 a=IbFtamc9Q6F5muXr8noA:9 a=3O5B1PkIbO4IxEKX:21
    a=kPIMloZYuvdWKp1b:21 a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756057AbeDICqB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:46:01 -0400
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:9607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755411AbeDIA0m (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Wang <jnwang@suse.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 011/293] Fix loop device flush before
 configure v3
Thread-Topic: [PATCH AUTOSEL for 4.9 011/293] Fix loop device flush before
 configure v3
Thread-Index: AQHTz5joHY7lHbXYlk+OWISM+bLcIg==
Date: Mon, 9 Apr 2018 00:22:56 +0000
Message-ID: <20180409002239.163177-11-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:Vn4QDmO0euWbGkh+9TVQ+4vB1I7X3AVUVhN/GTiaPbB5tsZ1SyHcdAabI45hM7voe2uREjEqHuatvNHR4H0RRuPDvo3Of4w4qAdq1SZ5KZZZuQPP6D7SwvXa+CUy9sbxo2/yU2ccTymKdy4KD2jJdkm8rxbFDDci6v6sBmx0OMlXNL9RbdGHh8mA7KN0ZmnEI+xZgdUqm5kd7kAD7EWakejqMnzKKMq9Hx7/lO2K0bcI4lQaNeBG3NrTu9N39P/E;20:72PS5fElzSu/tuq5wO3xFR9TPIUps8JCPJzccidtqP/WRF5ByLDBzq9fmNNJuFmEdwLdUZLN/ypvswBu8hzWc4yJzejKRWN1jhN4AIojrrIvihSCcXMNxHRAV6PrtQnj9amAiYmtIXPKNHPhn9EPkv/lJC2Lg55unKxvl4w8Kog=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9123ff0d-baaa-4d4d-cdd3-08d59db08ddf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015D172941A431DDB40A6ECFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(54534003)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 38xNPMGOpJpvAkDq3izW/7ADs0VNkjmHnDM0CKKUhO04h3VIV2/8gZtixbNA7x/RjNE+uCoh85YdGzKRi7wL2Cef79FkLxccNuKqogiY8CmI8j1fJOtFGNQpLm9vKvaR1R/dhkQySkLjxX5gv0tOzs5sYM3yCiarV6D7iRnCkD26/AIttZTFBBvK0XxaI+OlYIfF0SAqKTDS9Ug2PmGPZT9jkjF08Cob5X4whX6SIoeliTRTMp/nvNx4cQIFYFBbHWy3nF2VT0ItX6j90s58/9T2a/dWTmCsOD3JH5RW9YCBljAPkrRlmC6G8E+I32CDaukmHK6kCZjsklFc8BUot2Rq2LT4ax4Ivu3KOm6b4nnwXNbz4cy1H1W20KHuW9z//bWAmyOwTgY+NQ3Gu3ujDoHNO/rOO4o9MY9TOY2yoCI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9123ff0d-baaa-4d4d-cdd3-08d59db08ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:56.4873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 68bfcef24701..dc318b9100c2 100644
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
2.15.1
