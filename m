Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523238424-2-2339737311631690354
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
    1523238423; b=GG6BwLm5uYrDuq9FXsAPkO+uZbNrfIADd/WQAaPiTM6yn8v7hy
    iFU8MpHkqhBojZze8Un7Wm39LoHkkaz+4LE4aTztpCJmy5p2TtDYWDFpylEAPxjD
    X/gvoi/oyYgM2jmGUjrUwcvTsD/4sPLWxoymP+Liay7ra4BwpOI4k+ZaC4zH4k4h
    IGUWv38RmxIDzO16YUmJvvnephL2n9+zF0kXIuvkuCiZn+p2fuZFQphQxtSvZLPV
    hveUC96CSLdJE0h8AmwsCMO3bt+shUgJp+YUQ2p+1GJ0agt3V/zZ4oLSex83gp93
    j/0WJgd445eDt5h/zhxhBjK8awuOGZTpovWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238423; bh=Rgif/5t24p
    eR0hMieAoeNq6NwDO/Svq30odsXpRror0=; b=YAqAkwvXAqSLVpijpzj7KxhrRQ
    U5PMv3O2z3/7zCzA2D3gVgtVVGNAIIT32QGJ83pccAD1XZNvzsfVvcwOkowwyc13
    iNM3RCzvvNS0ulIYsox73ysLpnsYI2uvVYEKWYJMHHHKUo3Od6MkwGGN/UqdMq+R
    I28K/6HOVp8744RGDj2b2vXpZ5QPcGWGHLvkZS9mf+6h3UOO1eddMVV6NTi5M/tM
    FBdxFOX0J4cqxCQr6BgiicBEsbXERfk4UlimsFhC9ixFqE/PKbBss/Q6m7cd8qFx
    vLiZ8txNOkc7metbnQNSu6+Yi4pP7mHC7Nk3yoAWC6pbosrq3M8CVx9EKpRg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FnoWUnBn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FnoWUnBn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIoNavAWsGF2t05JVC5CBW66cY6gVo1qJBOLgQKrP+hxvfSRpvRjjvST3C0YNRUdw4I4pzyJ6XF5GeemOPMBn2l4uNBDdbg9P92GfXqEfSJEgM0/dDSr
    n5DW+9bb229O0KFd6AjLsKeT0o+YdUnrbas3S1KdJQ1Z5dgGEXTFcGNOtNGE9KfOPhhEHUd2liMEH2c9iOmoeZdJiR9SsOcB3AJBP+eEMTmpBgodaLZDayQb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=ZwCpfEX3OczFsJB-QfsA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbeDIAeH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:07 -0400
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:2685
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932425AbeDIAeE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 265/293] IB/ipoib: Fix for potential
 no-carrier state
Thread-Topic: [PATCH AUTOSEL for 4.9 265/293] IB/ipoib: Fix for potential
 no-carrier state
Thread-Index: AQHTz5liy9DqsAehuE2WTGShZGlLvA==
Date: Mon, 9 Apr 2018 00:26:21 +0000
Message-ID: <20180409002239.163177-265-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:m1Emag/Mb8FYm5oNeb3xzQT7YihBFfMj9MOM2jVOmOmvpQCIJSSNx4GM7rWCCPFqfafYHnmdi+QxVTIzCB4HkbXRpgPCFjToYseWAqFh6HxEbsdCMjcjtTYT/26DzCaySD1RYihcyCvYOi/R6qHDFFMJm+f94BsRr8SyGt1qKChzt5OXscOeD1c5jhIIomvLSVAg+MZ+bHDw+NjqiRtfmqSd32DTyndVcGRJrxhcM1DMfaxqqEif3Vi8Nxd7Pd8p;20:xa7IHsj2zREkZRtVI2xmYN2j/iqELOKdYKU0rpxVVc/tiMBQv4hr8P875uHBXqrlxtRYbwi3mcz81R0Hp/UwwhPXj2Hy4T6+eHNE2rj1vYp+xl9zc0pzVljm8l7ky+LT6yQx+uTQu7tG4iBPwWFJB4zy0Gzke/CX4PY/qBJGK6c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab16fb03-3db9-45a5-55d6-08d59db1967f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09840C1636D9731972A4CD34FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zAiImUJTqH7K4ayz9+JcPLC6R29plWVpTBsKeqBM7RgSWlZDKNh3v1ROAMaO9xzAa5VrerRS+QPHbR5jwpmvb2IWfUF+kn2Du1RlBhb1uFGdnWKcwHM/TBIRh2I86WHEJ8CWFHftA1dITgtb5nvJiDlv24TJyJhNwYDrL99n5/5jvZZ074qjtdjR1KpcFE3dkHuFmlQdDnfwAahNdzHNOj1UPFGtHzd/OfVuAfd/RrXVwmZuXOuol+44+rvhgmAGh6SLoZfsjEyjRywrLW07IwKWM3sQZE0kgoHhzngElzKKTrRKDRQv5SAS4XW+LoJazhcidZFNDXCabU3rYIkixqewuHdPucOH+WZ5lVdH7Xqi2bmSAkMfNSfVzcO/0r6tXxfaCV/HGFTiSJoyjzNy/NjX7JrikWy+M1ESRAybSIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab16fb03-3db9-45a5-55d6-08d59db1967f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:21.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Estrin <alex.estrin@intel.com>

[ Upstream commit 1029361084d18cc270f64dfd39529fafa10cfe01 ]

On reboot SM can program port pkey table before ipoib registered its
event handler, which could result in missing pkey event and leave root
interface with initial pkey value from index 0.

Since OPA port starts with invalid pkey in index 0, root interface will
fail to initialize and stay down with no-carrier flag.

For IB ipoib interface may end up with pkey different from value
opensm put in pkey table idx 0, resulting in connectivity issues
(different mcast groups, for example).

Close the window by calling event handler after registration
to make sure ipoib pkey is in sync with port pkey table.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index 0df7d4504c06..17c5bc7e8957 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2119,6 +2119,9 @@ static struct net_device *ipoib_add_port(const char *=
format,
 		goto event_failed;
 	}
=20
+	/* call event handler to ensure pkey in sync */
+	queue_work(ipoib_workqueue, &priv->flush_heavy);
+
 	result =3D register_netdev(priv->dev);
 	if (result) {
 		printk(KERN_WARNING "%s: couldn't register ipoib port %d; error %d\n",
--=20
2.15.1
