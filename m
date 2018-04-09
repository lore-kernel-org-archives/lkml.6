Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523243030-2-14613697682967687650
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
    1523243029; b=hd03lzqICjUKs7/8xL8Z+TbvMBG+WhV0s315gziUeSEaPP6yiz
    7lyKMqdeDDyBaqXJ+isrlaGDeejqeYazAXvFh4xQhPWDs/bvw3+I5P+J7pk0lRx3
    x96ZfBIZBWt5x3HcQOssEahIjazZDifQtYFnQef3JXzQER4rWAGgREn9uYHnhstc
    mW6EIrBx64wg6YJLGZaIX9VDdniJcLoxOHNdm1Waa7NGUk1HR3qtQnq38B22Fwss
    UalpVt6iC5MziHfA4fA9pLzGOKTKAHbi2FGjNL+SuI4Q/qtnf8zee55kLydBHVay
    3hK96YfFZv9+pRQlnoRGMv/AOa+DfCKfCFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243029; bh=zvhmGgXOI/
    lO4b9NHhX+WZ4rzYaFveKUUu64lWvYCOI=; b=TBhtTK6p6wRJEf5dK90EK1wi9Y
    5kI4MI5+3dZlhjxYf0PxaDs3O2+DXJX0MGnjT3Hj67rcLzrZMWhg/15W+GpZ2FSx
    llNSNSxUQqxSUY1en+m+DWhLd5J5CwKOejefgFrk8tD4TjArGR9O2JiciCav++gP
    wYYkoWxu0z91dTSDfv7mUKpB2bptr+erD6o2L6n5HMdLx2rUbWVky1rE0A92WGZf
    kaupWrQrnhKiWC0Qm/sXws/4vb+KV1iPs55+VqJkoJ5a0omVe0QSQmybEhJf83y/
    4wh98lSU+rha0JOHMVDgTcRkZBt6mmpzCFtnVyndEeyc2xnIMRaeAStKVGSQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3lSrDlR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3lSrDlR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI+MgIyC2pIRuKbGK0SeAFooMV75v//N9n2sMwPP5p30qiIJz/omdQIKqpTkcbLMNL2R0/3aJ/kadT7hN8ZTSd565kB51R5pREg30ppleWpV9vf4r/Me
    B7aRsYfcsBOjaqdwiggl9IDNnG007Z0rghr7X65V/T+VHJUOK/QOIMTii2bvlZWoc5cagftBsuu2DyhIX5utYg254U+pf2ZGtLn6lJWRKB8kZiuP4szp7/hn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=c9-YKhneQnEnAsZYHM8A:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeDIDDf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:03:35 -0400
Received: from mail-sn1nam02on0136.outbound.protection.outlook.com ([104.47.36.136]:19528
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755097AbeDIAYx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 109/161] IB/hfi1: Fix for potential refcount
 leak in hfi1_open_file()
Thread-Topic: [PATCH AUTOSEL for 4.14 109/161] IB/hfi1: Fix for potential
 refcount leak in hfi1_open_file()
Thread-Index: AQHTz5ivrM+zK9JbsECxT+DJykjAkg==
Date: Mon, 9 Apr 2018 00:21:21 +0000
Message-ID: <20180409001936.162706-109-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:eLYKjq89GghhwxrEnt386W1idAjl5wZenb6XGXdMn3AIi1haN2UbuRg4Q8MBuMU/OTwxCUKQl4njNyn48egOE7ciMhQNujnNqSXyMm5HPqW5LIrewLxR22+KWxbOi+8Fa0HWqDkxSPPEuLP8DHITQNDmueqxyDcqT25QD8fgEBY3Xy/Z2ez0fIzRUds2LZoUB6BmwZTP5Zwk5XeKeCEKgjH7qJZqAptpRPC3pV4zHY3+vNqZOxdS+54HU3fK/jTs;20:7ITSAOWyQxbw3lsrw9L+91YfrohXQm02+EomNLncMaMXZ/TpV9M9GUla3UyR5lsQ//au0ugKw8i/yfGkYgDes0cvI2aMdn+2+EZGGLYC4SzQ2zQ6BM43/ahMNh3GanPc2ZWgYq2/hpqasPDZitPPPdQRSfwilevHeazE3SYlmvk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a5dcb9a-7a6d-46b9-81c1-08d59db04d50
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09833B434C40C42A2DE74F94FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rVkxZKbOCtyMyiEWFf0rs8YfK4ocrxncNRs5lnfZp1KdPktqaz5PyToV0CI/Kvwokq9ngRSaOWYHP6AjJof4Kp0haImhJTQyCNutiyq6OO8ALTeTdIN0E4JyocuiXk+J6EZ7szX3phwg29UgtJJj0zEJGg5OEKUhTHsHy0Bv2B4+WWyhcyY5lCW4RMNByvDjB5KcRH9Z5v34XcW8ij+ihmFUWZJKylS9KV2wmw7i+zHqGQWw/boy2Ejr2fy7BQWv+V/ZBOGX4048+yekd8kpP5g1RwqBeXhNG0vfuNMr3uNTk1x+Cp//lEizesTMWRburb5e1rTOBpsIm/QFiuRom//I6ItZ9x0DFir79uzepG6tHLFQi3wMs1cmjoqiKwK7T+X6vmEXVnVI+Ipqsm+8RgK4ZP86qyBjSHdOe7E+eJo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5dcb9a-7a6d-46b9-81c1-08d59db04d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:21.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index fd28f09b4445..ee2253d06984 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -191,9 +191,6 @@ static int hfi1_file_open(struct inode *inode, struct f=
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
@@ -203,6 +200,7 @@ static int hfi1_file_open(struct inode *inode, struct f=
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
