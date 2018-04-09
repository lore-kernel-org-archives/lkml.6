Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244372-2-15982646681192628307
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
    1523244371; b=SxRJREJA0QPnZNfJXBpwGW8mISKXA3JXhbgwnuyh1bdDQ5y5Yq
    1fWAmojn/YEXoxIjtWNNMYUJFqhihh6K4bPZsljEBAfAzun8wRaqWiM9KJXT9iqa
    pJ+iWlwmpuoeRMUwMtOmz4ypcKj1yTvB7Zea8oIPI+BwlzkBh6rMEx7tpUCLy/qo
    MneB10y/PVsoUzCUUcznV5RcCOR/GAyzOA1dfuQ9J6x4+bRWRSGypTmba/O8Enqz
    376w2gr05A0+xiyd+I2Adap1T31QpDYqDLh3VlXVtXuWPlwmnGsL8frPi92dmpYX
    vjS/lKYRFBYs8qEhCqug/9y9d1PCEI6a6hbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244371; bh=eiskCYjjoa
    64bvej4scXpvFJvoTeRxBwtJOuMAuGAaE=; b=TZh/SYUubDOqMK/JAYdg2wRbag
    ++N2fkurGxLhKxvpXh07tLCMuNPupMhRScnheEDc/Cb9rtvEsxgn7YPpWBr3vCIz
    64puGy/m9skU0hhSGQcYieEOJGP2v4Ff2ptedo6PRpXH1sNkXFdX2BK3SDrFCNOj
    HjK2keXFw4qH0jnMEDR12bIORFG6bFJitu93nNFs5fYKPUrZs0RuRe2sHUMJefck
    E2QrKi+EXDDw/H4QBcXS9qPim4K0JD9yj1JZQ2rs4FtH8Tko/TCJ2qgRN8aLU7Eu
    7mCVyxk73njQ7zDQLcP2bZI1z4nXTWqYKQy4a+hPybsvkQNHISPDfJLUeocw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IzRl46yF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IzRl46yF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHGS2KHQ88ibN7DlsetQJMCeqLyWXEHqBCIJ4wJIvMOYo8WZIA48+yM6oXN4ZXP8Xz5ZvvmKi7dEqKIN7sFs9m4QF1G0BbDHueyMitpOK7lQU7bAQL5v
    pwXbogX2Aa1sKooAMRlHwrFaUVq8qZVrJRBedylKTX11LSDh8mMiKtPMq1U0DioWlu15xkRFRHUM2Pu6Wx7ZTC5yXbAYWG8wHE30JCk0JITyTDpTOv+yC9PA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=OyVWofH8j1v_oT0GuxAA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeDIDZx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:25:53 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753280AbeDIAWk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 022/161] i40iw: Zero-out consumer key on
 allocate stag for FMR
Thread-Topic: [PATCH AUTOSEL for 4.14 022/161] i40iw: Zero-out consumer key on
 allocate stag for FMR
Thread-Index: AQHTz5h+C9Zgf5NizUWQQq0nydOBLg==
Date: Mon, 9 Apr 2018 00:19:58 +0000
Message-ID: <20180409001936.162706-22-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:51piHkjzHUFTZOdau/X5G4TW1s43v6Ap9DRdTbfZXZDv91DJpzwdxmq90pHrrIxGjQWpF3CnwMVIc7q+ISDAcW9hokWiGfEnzSNe26On9U1FlaypjqWbjA4RdeGcEBSLLJIM7z1iVaoZmXbC//FJVEHOdnhOdaRDk/L8CFyksRAA1fVTyBPlLXyKGiIT2gCeEPGctMYTczf52troenVTYT8JVZhrGjkiR+UI47Kv7Xq6XKOs1NVMdi1425WhKH2H;20:DjvPMD/RaAa7bTdFvLpvhS3DWIC3wPCDnIR69M1RQFNB3nz5pdmQTpMyaLWlByCF6vi86KCLSSQAxi3GE8KXNq1lEkpVZukYE8bNXDYUhDSERKGCyT+lfH6a4PfGhGT53OonTXoSX+I6N2jkciklje0UckzmMJ+G+822oi06s/I=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: df0d12ee-1be0-47b3-b364-08d59db00041
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966EFDD974108446BB01641FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sI+Ht+0BnBj+j7kobO0+n3VAX7i+Efz1JSuEFAj0ScYLUbxHRDxd2lM1NUapdlxYWQPMb5zGfZ1Xol+fkhYNpJcbVK1dXHxs4UbA11XSoRQmblpGVLmVIC0OeZqG6B/W413ZuaKv0Onqvn2KsNJZ+y3GDstJaw1N20hdmCP0H3OUX9v5ExFy6Kqy1cxrRuRRQ0xET51E25IxMR8lbqyLdTzp7PMwYUfoZ8/yYsL/j4JRar6SooarWG7HZSfJvehtiLcDdIe4vmielgxsxBN14h4+g1x+zRpxFP7dGLNkShNeKnKIlOOkse4LmNvw1DZ3ASoI8jdUweMJ3M/AkbcNWjQwLUC34rcoHGsffcYkSqQq22PIlw8vgebCSKQ065yBruIoNkZPadjKQR+d79QtIRbcW/mHpEMcrlTHNe482Pk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0d12ee-1be0-47b3-b364-08d59db00041
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:58.9730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit 6376e926af1a8661dd1b2e6d0896e07f84a35844 ]

If the application invalidates the MR before the FMR WR, HW parses the
consumer key portion of the stag and returns an invalid stag key
Asynchronous Event (AE) that tears down the QP.

Fix this by zeroing-out the consumer key portion of the allocated stag
returned to application for FMR.

Fixes: ee855d3b93f3 ("RDMA/i40iw: Add base memory management extensions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 9e7ae7161d2f..b7961f21b555 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1656,6 +1656,7 @@ static struct ib_mr *i40iw_alloc_mr(struct ib_pd *pd,
 		err_code =3D -EOVERFLOW;
 		goto err;
 	}
+	stag &=3D ~I40IW_CQPSQ_STAG_KEY_MASK;
 	iwmr->stag =3D stag;
 	iwmr->ibmr.rkey =3D stag;
 	iwmr->ibmr.lkey =3D stag;
--=20
2.15.1
