Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240077-2-9384632572433705951
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
    1523240076; b=XHD/j2mrvnm/aLE8g/r5Iz1u5v1CqG/bD+WGomiQoUWkCklVKl
    edYi3/4Ho4MF06Cz4La+amY3M/vWZCSYwLK21enH81dSGNTW6aaqhpCtRf7Petye
    hkgTcrBI0r4+eKEgzeONtar0Lrq9qirP6epoi6InbZuPdYlr2FhxO9HLNeDj1yaC
    RpAHoBgVeGD40/04LNMLLyYoL6wfaEZuheeDnlUE6lNR8SXnWN0FvH+j4tFRlZnK
    l6gz1OgPDhAGALQX2xF4kpeO/FCUFswAgfI4QJ23VnTIMpvti2KNXGAYfbDYWfKy
    6C5axUuGh1MgkfYIUP/C7bJHzr+BiCAK5DlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240076; bh=QiD4znpClI
    jrSye9KxOhgn+m/BqnBV9fPatTFkIAihk=; b=I7UY7dXu/6ppNbvoo2FJEUS4qy
    VBD1E0mpH5kchiKElSxQxKG2lz/a6gC1p3+qT1d9Q9vzH6XmmMrGR6pGnb6QO/sB
    XbpXFkocXLnKpelegCoAb6KSUYtk+FCBE+bdueuLDkPxrp0jkAD3sI1kuAwmnD7Y
    yE3ANsIKQSlCk8mAsLUbAiFDI/5sl49PIH7f3kOqzgbzE9EqG7GR1RCMBlG7rEgs
    RVQKU2YRSLOyEMYnjtOkfI5+5rRYLxi5TWGZp4uHjKixe4Nat23onf4ctEvIvsev
    X0sZe4YIHJZ9MBS7TlVlnylEmXI7ZqeLaWhY8GQXy52qtkgMORQbJsXHAUBQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=io1bdPnl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=io1bdPnl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHRVbjHwMKDL8JfNOFTnS/rOXf7/Z2QyxbbCQnXfr36QKrAjm6kX3sc54tzCTis2mLUQkskI+nrsV6ILUel68K1t6q6ifmgvUK4n8Rmy4MDNmy+2r3L7
    F/Gw/O6LpMlnJzq8Xr1mv8SPBRMOmpIjaJgtMMjrJD+EIeTWb8I0vhebkM2oeHRmMQRCBLGT8MYL6Nj29nuNmzSRQb4+Vd2u6Z+YdNeuAZbAFnjpND/7JPWt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8 a=iU4TNklKuN5JFk1He9wA:9
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756126AbeDIAal (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:30:41 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:52647
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756095AbeDIAaj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Gal Pressman <galp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 150/293] net/mlx5: Fix driver load error flow
 when firmware is stuck
Thread-Topic: [PATCH AUTOSEL for 4.9 150/293] net/mlx5: Fix driver load error
 flow when firmware is stuck
Thread-Index: AQHTz5ksluFClyHOqU2dRqshMzSuFg==
Date: Mon, 9 Apr 2018 00:24:50 +0000
Message-ID: <20180409002239.163177-150-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:pbrYGEZ4UejPDMbba1ou97C298pcBXgdTwOCCwxnydkxokBLdqfCNogTjrxLmrcU3I/O7Bv8UKFbsIRyTxFTIldz3O4Wq48nFOzk5tppdSRm/YsRPh7RruY1OmnEDSi5N74Ognh0i1Nrh6gUHF1wqqHvJxi8Ga2MSZFji8W83AeeEVhWRtrossxTi+F0iyZpz5c9eYBuBDsyVy7SfFdsN8nUwiSFWLXp5VpcfdACs781Umfa3U3PJvZ5WqPuJ6gM;20:nc4WQS6pDngq24Dv8sMhjcMWRoK9hu294C3yymEKncfLGL81ug4ZPBul6KkulowJUnnJo9QkvwbIbmJoWuQ9zmmVCvktmVMrKWna9m1XdBf6jW1LaQE+p3xLuer8b5B12h3qGSzaBKN2YKpdgJn+n2Af1Vfx3TmGanvW+iG3vbk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51861d38-43ed-4099-7443-08d59db11bbe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08071C83F6A91A4EDC2E33ADFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7YMG2i5QzfhRb8AZPqRbi++Rx6rCL0LIhc+jZuausE2FB8WUBq3xeQgknT93j2yR9+RskcUD5oXzEkS4EEpjNhXunhp6YM7rvyMxgrs4LIGe8YmFuEp5IpfB6RXs4YVvOy1YRbUSVZX2kPxQ34rlyEzTvTEtkbqbgYGI8g2JYJBlJpOJ9kk2QXeFmxbnZgnX14Dwc2GQ5Ra8gbyAuMhiUxcPtHFKiZ0xCnXHGDvNYw1HSpGmnwYlsXGDkSpPXuLY/X8LimIaoMBLcWrZNjWZVwMAnOf9cyFOPIu0hTSxNNcxlprKCtex4UsUdwubb9UmZQJDvWUZS/ZCbOKHtOrUeF8lX7c2nKQEG8HVwUwIftoOQb7vsM2yelnAbng5UQgaHQQjXjrYW9S8q2yaW5k4wJvoA0WiyWlA4on6XLajfPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51861d38-43ed-4099-7443-08d59db11bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:50.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gal Pressman <galp@mellanox.com>

[ Upstream commit 8ce59b16b4b6eacedaec1f7b652b4781cdbfe15f ]

When wait for firmware init fails, previous code would mistakenly
return success and cause inconsistency in the driver state.

Fixes: 6c780a0267b8 ("net/mlx5: Wait for FW readiness before initializing c=
ommand interface")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c
index 981cd1d84a5b..9405bf9e5974 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -963,7 +963,7 @@ static int mlx5_load_one(struct mlx5_core_dev *dev, str=
uct mlx5_priv *priv,
 	if (err) {
 		dev_err(&dev->pdev->dev, "Firmware over %d MS in pre-initializing state,=
 aborting\n",
 			FW_PRE_INIT_TIMEOUT_MILI);
-		goto out;
+		goto out_err;
 	}
=20
 	err =3D mlx5_cmd_init(dev);
--=20
2.15.1
