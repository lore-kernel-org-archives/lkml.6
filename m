Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246716-2-3808949051498124435
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
    1523246715; b=XhJVjCQ3IAy35TfeMLBdZOwcnUC2WjBbVm9g0Y0LgKUguwzt20
    CA9FAG5aVmXMtpH4MGPyIFSf340H0tYnzXzaTRNIz3SFPMW9eP3LQorOB0NxB+eB
    DJ3k4980Qgbt5yU3w/0knTH7jLnzCX9wIS6WCRXHmNlpY0hB3e5Ew37DaPgHIWs4
    CZumP1j3DBtK8ac2k5kZYR8xgz0J+5nRfpoWdEYeBUPrOABOzsVm/7MMLpjLZ+6Q
    UgeKicqHS6WfaVTf5FH/TVOcjX4JG5nZJo7lBSaQxdVWzqM8Txu9tDQwgi1Y964o
    9nwQKoYulhO9TSyxnkGo0QP2yxSfh/lzvy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246715; bh=jIsOdtafxr
    I0goY36MDgoEJutbk9T0Taji8FwyD64o4=; b=u6lQ0/sBS6lm0aosak9JHVXI62
    NNV/tpG4E2Piz6MJEogmQGwcPvZt1Pp3B6c3fft6eOjcaqAwV7R5fac31dHZDIRG
    JDnTKU7qRMTfIDUPJZowNKISIiZBFTeTOA7Lsk5brvk6tnXEQzhjoQDcTyW5FoI4
    NCQw2V3K9joym5Ngd2Wki2JfUj0hNQDdM8fovvM+SsbFK8CReRbL6OvJ8FwvlocQ
    gdHPUC5rbdnq8WkenhfsENJWiHzW0VWlscxIxaoc8pqNd5tQYyK38mKxBNFyilx7
    QuQV7TXCUhqRLNRW9jRYSBwVFtPBVGFOUJOSsbQhF9gHhGB3IlcxEQrh0bCA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mxcB4+Fv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mxcB4+Fv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK9N9Z5LTXNdNExRitXHmJ4hiCqZgxKq6eItQS73dixj/C/cxmwCxp9qI5RdxnMmwGbHhrUsZpTnGXyfx/SE3qilRb16BKe3jJNYoJ35V2k7aIYyhx+z
    qKaHRPcE2A/N9o8men9wS8jkHoKfuzVKQqlmpMloLOK15+FQYiA75XG/vj1iTJMYkW1HZi7UnLtevmCjuAc9jDBMZSGF1Soj64u7PLBWZXiyR1O4VAn0qcO9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=yMhMjlubAAAA:8
    a=nHWDPYwPWMGrVEW4zfwA:9 a=wPNLvfGTeEIA:10 a=Fp8MccfUoT0GBdDC_Lng:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeDIARz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:55 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753239AbeDIARw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 039/189] nvme-fc: fix rogue admin cmds
 stalling teardown
Thread-Topic: [PATCH AUTOSEL for 4.15 039/189] nvme-fc: fix rogue admin cmds
 stalling teardown
Thread-Index: AQHTz5geCQ1TIBTO1kuePnH6wPXU9g==
Date: Mon, 9 Apr 2018 00:17:17 +0000
Message-ID: <20180409001637.162453-39-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:xQSaMe3cbnc9AoLkwSM2dGjOZ0FXa4bxEHJhhQQ5f2lYTqJLAaZGlR7lHcbpkNK3phN9ptgSa5HMLsUW2AMULlZt6EbHYicKh4aLvnuDiRk9z3m0Ey5nbHTj2mtUvlQvEzsH5xPGspJto5P+hZeQfLgrmDnD5PLPfbeb+d2tvYM8sM5SqyG1VuL2tYkqXJ4AmNDSVrLAJUrVadeuy5ODsFR2tpw+sM10tVb98W2sERTixU/zm0Es/YOFSKckGcoX;20:2zD3zlIFLhqVPixJhNdlwVwwp1Bsh9hdln7mkaWk+XDv4gaNi6E8udJq7bMnO4jXzNlr7uQdkwqwyEWcTaJsiPWY1FMqdDeBjCtBH6hpswTxU1Tx143bHX+NpTtphzSJQxuSIAu6d+Yp7vEteGj+q0XMDh8hwYc2m956IYBr1pE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8ac3382-d7d0-4217-de1b-08d59daf517c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10483F03E6D5DF356A0609FFFBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(39060400002)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(53936002)(107886003)(68736007)(102836004)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pl7vFSvpaYfQYB2jAL/qAKojYqAMquHz5av1xkr3ereMTTxp0Wa5NligT9/eX4nw+hZmbAX5scqHge1sV1b+UHfC81sDc44bs4T2BpgUC4sk8tSAAmmwhukBdLZaqNyykEsxuHaDByxKzG9/8MwJ+zwtCyodU/e8xKQZVHZZoHOVljBCYJlyoKuM4SdJzFE0SQi/Pb3rgqmbfaISyVNQq6dA64YA4LoZR5N0/YIyFcpMeEUP+w1TiIH1h2t9E9V2UA/ugnI9+orevT+N95OCzXj9iS0SyJpnrKtgGhzKnDaaOBYt8wYk3pmduCiVHQHg1xOhRrA4l1I5XZZmY3zxN8JAIMkn5krijEc8YOe30Y63dQAyzB5i5oeAZ2CrvXqzoPoSQlb+YWHfTVdcgWuZhZ9PzhmCTLRvqplsEFN8Yx0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ac3382-d7d0-4217-de1b-08d59daf517c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:17.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit d625d05ef0f0914a706d824fab85472a42be6659 ]

When connectivity is lost to a device, the association is terminated
and the blk-mq queues are quiesced/stopped. When connectivity is
re-established, they are resumed.

If an admin command is received while connectivity is list, the ioctl
queues the command on the admin_q and the command stalls (the thread
issuing the ioctl hangs/waits). if the connectivity is lost long
enough such that the controller is then deleted, the delete code
makes its calls to initiate the delete, which then expects the core
layer to call the transport when all references are removed and the
controller can be freed.  Unfortunately, nothing in this path dequeued
the admin command, so a reference sits outstanding and things stop,
hanging the delete indefinitely.

Correct by unquiescing the admin queue in the delete association. This
means any admin command (which should only be from an ioctl) issued
after connectivity is lost will detect the controller is in a
reconnecting state and will (fast) fail the command. Thus, a pending
reference can no longer be created.  Once connectivity is re-established,
a new ioctl/admin command would see proper device state and function again.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 794e66e4aa20..8f9ddd0e392c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2921,6 +2921,9 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
 	nvme_fc_free_queue(&ctrl->queues[0]);
=20
+	/* re-enable the admin_q so anything new can fast fail */
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+
 	nvme_fc_ctlr_inactive_on_rport(ctrl);
 }
=20
--=20
2.15.1
