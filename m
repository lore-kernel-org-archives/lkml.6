Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488809-2-187772522144757179
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488808; b=s+dA35EUQCONZD32IfbrDXPnd7z+Q2dtjS8ow367BM7ofFb
    iicaQbs6nxYwH8hd+xnywx+J9BFc1rndFT3ZVk5JH6oIHVrtWtVGTuhyycW2hsNG
    PtfNawgay0zkvFFA6BE35t+tmJ84DVFW4gMb54RgsMjN/dVI/UEMKErDDGMDzrVi
    b06H00UaAkB/m1i+vUnMQZx7mL1nWhZV//9eL1VHzNEy6vqKk+ploapiPQQd2O7D
    6fWpTBV4JLAVLmfxfVO146ZcBM5rMwXaVKwgLGwgkWBFFdexsJvl1U/oqNNNUNaA
    VbRvV+dgPCmEG21jXtoJJT6mfmMdwiMd/thLNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488808; bh=GYyltB
    5qDYGlD2Vm7+TQuk6fmqIsqtccYaXsNEpcLZM=; b=f/ywfZyb/MKhQQig+TyNuh
    nzJNww2v4p5vrbdA7w6F0moTyj8b/6OjmyLdjbQGWcfMae8vRoe1c46PP91fjTOa
    sVrdVPRKHWAjlyBPxyslesLW2RS0GXxW1iCFSV04bZzCXmIjOywP7gYMKn+HgF+d
    PSV8hY2s/4jhOBjg1naycyR8ArVxsA1jseneSuUPofQ4ARiCsjAfTIZCARRnBMQ+
    RNlyX55SKuvThZGUzzC3/uXaDLj0UdqYOtCSBG3N9hpE8A9QAOzvTuRs66z1IOTV
    /UJMBqYW5wVwEf7iajVQpuRHpI3Ihc5wn96hrROOZiqqPjQ517WgOVXR/y6Px2qg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YFPW/ze1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YFPW/ze1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965412AbeCHF7v (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:59:51 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965983AbeCHFDT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 132/190] IB/rxe: Don't clamp residual length
 to mtu
Thread-Topic: [PATCH AUTOSEL for 4.9 132/190] IB/rxe: Don't clamp residual
 length to mtu
Thread-Index: AQHTtppJIB1ikTvVQ0SP0/QRFLUixg==
Date: Thu, 8 Mar 2018 04:59:49 +0000
Message-ID: <20180308045810.8041-132-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:aKleTktG5Yy6AVfAjrU7u+K43AXK3GG8LdaKbXwz55j80wif7xl67H097Eafje272+HBA+yiZ+q9SUbT5dlm9ygy5RiN7qnGk6k0yFokGnvfZ+bJuiMib/R+Cr1Fi0LNde4RmhZevwbtMc5hb2nJau7m5mRAGjaxHSjEcp93lw4MGkGEXz+lrzcJ4Lg4n0WpRX5CyYOpHjgYUWQJXiaQs0OPevzcIDjvAup/DNEVu43USz5JDlinoYiALen/0139;20:b8pQzo8E4pRqRNdncOhZgHNYJWEv5jg6IdU2hcuRKDkNFO4cNi9I+iJ46Ey02sTBzMQ/TK89ENo2AuXRFgzvmCnl0w27v+27cMM7S1YUZSiPVmcSP/sL/MfgejmTycqVlsfDnly8NXvBqhvWCxrujDPy4wFfWqK45hZmJPWt3hk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19c26208-61e2-4bdc-cd7d-08d584b1e5d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10137628149BFCB7342020C1FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(575784001)(8936002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Qb6JMHE4/T6qv4/SWjdxh8CHmFs2bp8Hn+FwWUAFVO2N8EOM8gNAyYCO7Dbcjnyw8mD9WbB6MBB8/JDuRTzJgqSRiAYHKbnX81/kqy7Vxe7k02ZWgH73SorW1GYt8apSQqf9WnqUUeNk4Gupy8A5YRcUheZ6zFnksJ50jBs+sLayw/CKIHJWCCenDjd2j9BrOwF+a5gQKLgj9BOyEcpxWGlx7tU/PnolhAwUUNoZBppsviBX5X2Iwo4JVZ/xe/QmoM9QGToU7tosoaG44NgSBK8YQN/do82bOGnrvORR/sJgt14k+YmAyTKohkmkgIgosX3qqc6Lv0zMD/nguJn+Tg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c26208-61e2-4bdc-cd7d-08d584b1e5d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:49.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit d52418502e288b5c7e9e2e6cf1de5f1d3d79d2e1 ]

When reading a RDMA WRITE FIRST packet we copy the DMA length from the RDMA
header into the qp->resp.resid variable for later use. Later in check_rkey(=
)
we clamp it to the MTU if the packet is an  RDMA WRITE packet and has a
residual length bigger than the MTU. Later in write_data_in() we subtract t=
he
payload of the packet from the residual length. If the packet happens to ha=
ve a
payload of exactly the MTU size we end up with a residual length of 0 despi=
te
the packet not being the last in the conversation. When the next packet in =
the
conversation arrives, we don't have any residual length left and thus set t=
he QP
into an error state.

This broke NVMe over Fabrics functionality over rdma_rxe.ko

The patch was verified using the following test.

 # echo eth0 > /sys/module/rdma_rxe/parameters/add
 # nvme connect -t rdma -a 192.168.155.101 -s 1023 -n nvmf-test
 # mkfs.xfs -fK /dev/nvme0n1
 meta-data=3D/dev/nvme0n1           isize=3D256    agcount=3D4, agsize=3D65=
536 blks
          =3D                       sectsz=3D4096  attr=3D2, projid32bit=3D=
1
          =3D                       crc=3D0        finobt=3D0, sparse=3D0
 data     =3D                       bsize=3D4096   blocks=3D262144, imaxpct=
=3D25
          =3D                       sunit=3D0      swidth=3D0 blks
 naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0 ftype=3D1
 log      =3Dinternal log           bsize=3D4096   blocks=3D2560, version=
=3D2
          =3D                       sectsz=3D4096  sunit=3D1 blks, lazy-cou=
nt=3D1
 realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=3D=
0
 # mount /dev/nvme0n1 /tmp/
 [  148.923263] XFS (nvme0n1): Mounting V4 Filesystem
 [  148.961196] XFS (nvme0n1): Ending clean mount
 # dd if=3D/dev/urandom of=3Dtest.bin bs=3D1M count=3D128
 128+0 records in
 128+0 records out
 134217728 bytes (134 MB, 128 MiB) copied, 0.437991 s, 306 MB/s
 # sha256sum test.bin
 cde42941f045efa8c4f0f157ab6f29741753cdd8d1cff93a6b03649d83c4129a  test.bin
 # cp test.bin /tmp/
 sha256sum /tmp/test.bin
 cde42941f045efa8c4f0f157ab6f29741753cdd8d1cff93a6b03649d83c4129a  /tmp/tes=
t.bin

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <maxg@mellanox.com>
Acked-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/r=
xe/rxe_resp.c
index 8c0ddd7165ae..0d25dc84d294 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -471,8 +471,6 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 				state =3D RESPST_ERR_LENGTH;
 				goto err;
 			}
-
-			qp->resp.resid =3D mtu;
 		} else {
 			if (pktlen !=3D resid) {
 				state =3D RESPST_ERR_LENGTH;
--=20
2.14.1
