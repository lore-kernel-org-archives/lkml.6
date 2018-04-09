Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245596-2-395056898425950978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245595; b=VD9HBjXVCL4nbNwxIDuUt5y9eVZjmR2ZSV87OzdYxj+0sRZK+5
    jSs3PdLyGkqtXb2QneyoXJKP6A5dqL2+3XjsvtnhcXcB7JoMprG6F8dWMq3sKBn7
    sEtj5sDYTvsB9GtD7Xu6c/zvodH1YDicScNWqIFnIMY3Ic+fkEQoh5DFUYGhReTL
    18NcRJTq4rprgsZ8qggcYF9VzIQJ6lpo5X9s0Xu78JOuRoelqbEi3iAlDn/NEzR/
    XIYJEuShRBdgyCXDzE1uGtfIPcOgCg2cD8eijwdNSoQ/mAYb8b1cQJxe61iGzETa
    has1JlwikkAlfUqJ8NZNNU4ZDDFYtGacu/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245595; bh=HDMM9x4mRj
    f4rceQpxDfjrYFXwj1bdbHnO058vbUK3w=; b=PwoMVsvFwPw0+dYu7kaWUbITUE
    mPVzyF6XXsDkWeRqeGj7GB6oIchnqfrUJpHQ6ERZ3YdSORYQQ/+d9mMbFxIx+WMK
    kmihgV/3keE9ANhVDXiFxaCLIzR1Xx8KsyMRkuKrQ7NKWG0DX44UUvRJNLMuJiid
    e8sr0KgzT1AI9Gawp991VeH0/YdLRQYja/zIfaGUYsNHeSodbD61K9lJpYRz5LsB
    pdx3Jh5sOoCVZfblCWAEKjjKg8qw1tf+ahx5356NYp5XBzMF8bkKVSoiJifxsaU5
    PLchwTxcAJoisI0Ff1e2dU+9plHxFQeQWreZltvKcGxCZnr7s3fYSP2Fud4A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iF5ayjrM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iF5ayjrM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLTMzDEQTomZAKBLIL1u6yAAp6yBPeXy83AqReljQpD72561qqRHPdwbmtwgWMbuQZEAIqF5JyC/ejnV39YvqBisgM9O8w7a5WjF+MiLl6FlfZXLbqew
    7iSeMC3cuzWXWjqXeFDIs32SMeoyn5Ny68s0wYZWCP30tDxwbzLyKUVV/cXeUq7N/qxVCKHY0a/yDfcYsmS24Knrn0dWxLLRHgOl8UcE6RGu76+A7FzxXhcw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=c9-YKhneQnEnAsZYHM8A:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDIDqT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:46:19 -0400
Received: from mail-cys01nam02on0118.outbound.protection.outlook.com ([104.47.37.118]:44776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754083AbeDIAUP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 131/189] IB/hfi1: Fix for potential refcount
 leak in hfi1_open_file()
Thread-Topic: [PATCH AUTOSEL for 4.15 131/189] IB/hfi1: Fix for potential
 refcount leak in hfi1_open_file()
Thread-Index: AQHTz5hKhPDLKs7v9kSV+yCkLiZhXA==
Date: Mon, 9 Apr 2018 00:18:31 +0000
Message-ID: <20180409001637.162453-131-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:FcT3jMG+yDxS6/9BnoCVv+ZBpIjzS1hXgRYFMbRX56LZPbOMY6Oznnd+/Oml9y4gywKgL+VPI4tptje+pkSn6YJzE9ysiI3fxhG2jUz+pgJpm7b3Qhh2x60tEirFDyhmuya95VmgMj3sauLK9jJt0Mx0v805k2SA62zVnTqwvp42mV9zvSgxklECbtd7YlhtS0TL4EZBZd68zbZXEyaE2RsK5lO4Gj5oj6EhACMOn25VSIJdYGqYsFvbqplYA5IS;20:qoZ8LDLP4P/1EhIK53gG9fiVktPar5SHruzh+ZG36RqYWJd1USPoycyVPzhaDOas9kdffj6gddtfubqJi+TU5iNUl/30wmccA3l0vx2p+HjmSJ4Lcxr6fyTARPRZe/XKYY8bBQQ6xRpdCdRdTxlOuvoq8YM3N/wp7FTxOk+T82g=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 420a4bf0-6baa-4e03-8bdd-08d59dafa859
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11104664BD8D06EFB15A0690FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: uX5ME2S5DTsX++y0GSlT/mY9ngP73IT4z+GZxPs3Z4JP/winin99pmkX8b9AzreuiXdfE26KDX0zCBpitddUGEXbUqSMMY+w57/H4dXHd57C0ZxFUWf+BP09quw/X1uNfposlNslE5nGFQYq1b03SKvkQP/IY3VwZc4PxJOgz24fK8NbyxYZuV/0PcssOntR/B6o7NKow4mdstBkW8pbde1qli+mhSGT2m81SqNsFKhqGCeooOxUwW0b+XsherAuYR1AD0mD6MZBp3CREj1h8vvgQWVg9ZqNoHuEXWlDo/5Bttu1WbFDLPy85cth0MrWbqyPihhYGDq3cysdFrj5nHQjQs+iadvb5LdnCTpl3OJg7qmRRXYka/teLOgQ4DD06o6yVdh065a792PKrv9RYSrpDp5JdfOknnxxz38y5OM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420a4bf0-6baa-4e03-8bdd-08d59dafa859
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:31.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Estrin <alex.estrin@intel.com>

[ Upstream commit 2b1e7fe16124e86ee9242aeeee859c79a843e3a2 ]

The dd refcount is speculatively incremented prior to allocating
the fd memory with kzalloc(). If that kzalloc() failed the dd
refcount leaks.
Increment refcount on kzalloc success.

Fixes: e11ffbd57520 ("IB/hfi1: Do not free hfi1 cdev parent structure early=
")
Reviewed-by: Michael J Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hfi1/file_ops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/=
hfi1/file_ops.c
index 1df7da47f431..acf0ba56c309 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -196,9 +196,6 @@ static int hfi1_file_open(struct inode *inode, struct f=
ile *fp)
 	if (!atomic_inc_not_zero(&dd->user_refcount))
 		return -ENXIO;
=20
-	/* Just take a ref now. Not all opens result in a context assign */
-	kobject_get(&dd->kobj);
-
 	/* The real work is performed later in assign_ctxt() */
=20
 	fd =3D kzalloc(sizeof(*fd), GFP_KERNEL);
@@ -208,6 +205,7 @@ static int hfi1_file_open(struct inode *inode, struct f=
ile *fp)
 		fd->mm =3D current->mm;
 		mmgrab(fd->mm);
 		fd->dd =3D dd;
+		kobject_get(&fd->dd->kobj);
 		fp->private_data =3D fd;
 	} else {
 		fp->private_data =3D NULL;
--=20
2.15.1
