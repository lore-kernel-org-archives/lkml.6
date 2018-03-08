Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488137-2-16091571532459401770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488136; b=eEnSKtd8Yx/26AI3c1eG63F6K6VBZVPuCfYSBWxo7Mat5h4
    FA4o79N9y4JIN+hT1E2i/uIQ1A7GEobQnm6TmUhbVRtCSwjiI1lF0ql0o4j1AwoX
    RKURIOsTttQvrUwxpIJBnwPUMVHZO7PBY4EerEW8YhnyyOITmDx/UEM6628SG4q8
    uhjFBR+kdz3pMiT26fLOmT4FF/AIUa9eMw2hfs705QSatsXeH2hfmLG9drLa01Ja
    hGAq7YScvD7620Fbq4oZgFi8mZBi87GiFYjUCXr5Q2Bm0nl/EjTtcAtk5NE2osTA
    3qswOe4W69SNrZ6izpCRUAdDZuY7oG/VGXSs6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488136; bh=PzSh5X
    MJ74+nodVYczV8tUce/ljqOEqumv6ME4toIek=; b=Hjb0tBiZqdwQeGuAzGnMxz
    a9AYg9nCX8sYC9Vn2qf6p6sEt0O248aqTteFJ9KW7ycqOTaCEhgS4pE7hnBA8fdw
    SsggCAk2+KbGvF1IpbBBzIvHYxFVfBXNFhv9O8bpa+/Fmekm6lSS88rYSDuBfLJ0
    MSbJmix2hw6JsuooKdrEcyPTA+T1/XIq5yeYzErpV6T65EykhoBR1Qd2JHLSEcQb
    10T7optSUexXQWveSjv95Fb7X1r68/Y1ERY1u+Um25bRpevqADxPtL3/V7VLfJnd
    Ez6QggLr5B2QacFWgNKO2FlVyFYhqNvy5Cs9rZZ3wUHkcqHrw9EcNwFYOfxZBrSw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jKOkcXOw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jKOkcXOw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965395AbeCHFsk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:48:40 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935572AbeCHFFC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Anton Vasilyev <vasilyev@ispras.ru>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 184/190] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Topic: [PATCH AUTOSEL for 4.9 184/190] RDMA/ocrdma: Fix permissions for
 OCRDMA_RESET_STATS
Thread-Index: AQHTtppXoC68Q5QJUkWHe0aYz7j25g==
Date: Thu, 8 Mar 2018 05:00:13 +0000
Message-ID: <20180308045810.8041-184-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;20:S5WTLJAYEDWLFGwUHkoADZNz9c8tt7uOg2Y2ORgOV2+LNi0TmrZhih43CfqEkAzvlDYeg9QX+7jYZHo9BcQrabUV0tU7Ra19CV/vXskwivlCXqXT+D5IxFgqZPE+5IkZOevmLfsCDpeSf8SU+EpkM3Rq1KINjjKSG2PbhIpLFlc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1c8e410-5f94-4dd3-2206-08d584b22496
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981B69D0A4DB4268DCE7D4AFBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(4477795004)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jn1DZzURza5p+IDg2tP3rqNtJxEX4CNE44TgJUEnDcV5wmTRtLH6WeUY3t8U/VqCb/XzthRxOjfHgdB46ztvu0tl/qADkF6ldcoXbKeGefNEpmhvgZiX6lxxrdkP3EbYWBmx+zzQzrzt9WeLKBElhzQZUpQMarpgTMJRzNA0JdO8uX6F4ITH4lDMpfC3Rqqo6zUCEW/+oaIYm4M/BkxM9dKHZ4qfGuyKA0HP1G1zOqh7/qFCxZe+eUoxVzvfe9PTQf2R2iKqJpmWh4qdBl/n41vxw88QgEbB5MCiB7zrdwuIzbdf9/gbUpmLJdUiSbeei2vrd4t5mjcRmnF47gVzlw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c8e410-5f94-4dd3-2206-08d584b22496
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:13.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 744820869166c8c78be891240cf5f66e8a333694 ]

Debugfs file reset_stats is created with S_IRUSR permissions,
but ocrdma_dbgfs_ops_read() doesn't support OCRDMA_RESET_STATS,
whereas ocrdma_dbgfs_ops_write() supports only OCRDMA_RESET_STATS.

The patch fixes misstype with permissions.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_stats.c
index 8bef09a8c49f..265943069b35 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -836,7 +836,7 @@ void ocrdma_add_port_stats(struct ocrdma_dev *dev)
=20
 	dev->reset_stats.type =3D OCRDMA_RESET_STATS;
 	dev->reset_stats.dev =3D dev;
-	if (!debugfs_create_file("reset_stats", S_IRUSR, dev->dir,
+	if (!debugfs_create_file("reset_stats", 0200, dev->dir,
 				&dev->reset_stats, &ocrdma_dbg_ops))
 		goto err;
=20
--=20
2.14.1
