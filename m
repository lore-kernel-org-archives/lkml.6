Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237903-2-6394774863973513267
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237903; b=Gz7bZdy60+G0Y6LXv32/zzfeSKPVSxVdZsIKZvdGMvQVE0NFkA
    i0xTYMF5pOxoQdJWa+uX9UKjLOUM3uwlMHeJcMw4eEKxV70SdTwRJ8bnjo+nKNSv
    TD3tS6MKKtGD5pU/XJkajchNlZivCmV5VWcHD2iFojHHO6cVteVvgPwWYqQ8EZ47
    YhEYJPe4Enhccv8nAsasVdSHTmykzBdvp3La+Deyn6UCndk74fwpq080x56aWCTf
    X2Cv2kNiX+jlwDx0Sf9h/8DlAJNdfNRapSiWNgPqRyoWRyA0hVtJbC+gIKS8ZM9p
    z6cp/CudBtTvHnAaUmoPBa4lR+qAvmBqwAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237903; bh=+v9WQtyWlt
    Uw9XglfKcpnLZvZU2QF4CRnInjPt8Nkac=; b=LSx2TgeMjZluij3oGHh5LxALAV
    KO7SHfuZ2Q1o5nup+eQMftmQ2UW6vHk4IIxMDG7bfd2ZO1c8lQYW2YG3HyhhJtmM
    A8Lhs1j93Kyikg1zftwb0czHwinbqP31PT8rvQV/KmHtmnwIWwr4p5xtDwMj7jGD
    LcGYwuy5QVIv0Wfm4/vJBk1LhKFWCv0cbcJ5aAujOlZh5yh2W1EZ3oENYhbqkXW7
    iyjjj0A5z19gfAMLx/3L1QfUETHvQJjEVks3TuqYTSaIqYuzM/9zckzHeXtrKCU/
    fO0WFEOjkMtM/7jbqGcHVJbfHVpZ1TPPstfETcJcBRBlGZ6sitN0iUay2vLw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dFoYXlNs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dFoYXlNs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAQ4bCdI4XQ1FynZq+PReosuBVMWq6dcqMMxAogz6oXrNtH6CPtcm973kWvWcYd8RrEwzn82yPdjvo2F2DCqAhKc5HdsSi9MYHGuHtQ2+OBT1KiMyEA7
    cPJT82w51iRxUKNkDga1sZWDgSFTV5aoVy9TwH0R/eVGCuQ2gYGF2/Utgyd+Xe9EJyE5oHOMXdj8B/PhOZ/Mxq71FrgfoCFBYayscrCnL6KDouaPk+jbwxab
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=5HukGGecSq8qvLx4TT4A:9 a=wPNLvfGTeEIA:10
    a=T3LWEMljR5ZiDmsYVIUa:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbeDIBhx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:37:53 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755917AbeDIAfD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 015/162] iio: magnetometer: st_magn_spi: fix
 spi_device_id table
Thread-Topic: [PATCH AUTOSEL for 4.4 015/162] iio: magnetometer: st_magn_spi:
 fix spi_device_id table
Thread-Index: AQHTz5mZSV6az/i4KEm97ZNde7bL2g==
Date: Mon, 9 Apr 2018 00:27:53 +0000
Message-ID: <20180409002738.163941-15-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:8aMS6GhfuwaPXt2Mz841pdoFG6QkI/Lp8vJEFMTdpYJ/EOBY3erZbcik4AueLBXZw4fyAp7SmvA5drXr/s8CTTRWBg5UZAEsyoAG10XLpkXEUJNM5WOQLGNGzccRVo1SxulEiHH46yPGYP+GdnqPgoab/0s80tcWYPrWJwXhXhf/v5pfqVblc4FRrO8k62M9mElRIc8KpYoZBX1AO9iK6rLZ1DGdJq3EIB/vkiVaOE/rCv7sUjtd6pR2ElW/Vp27;20:6xBM63Z/L51qDlbjeCRHBlktDEVhs+/3H5wtUzGSoqmajkXlVzJ9Pgc5srV0j623ipaGXHh+ltRe6A3GhABCNq2wIzrI/lG2M2iduAJ4OoGfE02GLdmhywLXl1GqRN8zLAgCrEuBtonWP4rtk4FlAG/p0YeR6m9lHjHfuiZn2Ww=
X-MS-Office365-Filtering-Correlation-Id: b69f0778-323d-45dd-929c-08d59db1b973
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013622673D8135FD176F406FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(2900100001)(22452003)(39060400002)(316002)(110136005)(575784001)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Q2JoHbLwLwdnKnzyfxInWIoLM1+gWXkdoMC4Ook8pWmMktlxw1aNMMS0qc9n441c3xP8EZL7DENaH7pGWJRqP/Ui9Iqm7+zntTZsk77Dwggo6ZSodNrGmNcvto7t0Xs/6U2o1TNx87wSPmCQv/XmjnDoTMzu5dv35jbnC8JrkEnLcBEaMc1xM6eUzTzUzGiQnFV0ffDH2zwB4kRQ8gErNlNAWO9XSM4fizsOw1Se5IaE4Ky71IqJXTsGWfzpQdvCtbLSdNEbXmVQtV+6d/5rAMgsS8iMe/TuqoFviFCn4PC210a2F7ROGnOFVqA2o7nTCvwq8vY7b2MYFL5Z474MULTkOQ1sbGJkIEzj6bNPod/OdGnWn6kAv0k6gy54QNaoFY4W5tkZ2uwXXihKTNJa+mavkVhPmLdGWHCm9cnMgs0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69f0778-323d-45dd-929c-08d59db1b973
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:53.8016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>

[ Upstream commit c83761ff0aac954aa368c623bb0f0d1a3214e834 ]

Remove LSM303DLHC, LSM303DLM from st_magn_id_table since LSM303DL series
does not support spi interface

Fixes: 872e79add756 (iio: magn: Add STMicroelectronics magn driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetome=
ter/st_magn_spi.c
index 6325e7dc8e03..f3cb4dc05391 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -48,8 +48,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 }
=20
 static const struct spi_device_id st_magn_id_table[] =3D {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
--=20
2.15.1
