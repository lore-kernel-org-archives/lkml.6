Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233998-2-6178022112687134455
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233997; b=FK1v6mx+M1JWZ8PxdqsZiOEfCZtHBV1Rv7FUtfDzqG+YoKnVjJ
    pnFMcvEVpRPdy6NwljA7LtfU9Yg2bZMkh2fPA9GZUeRijdu07T4ZGFi3kmf6MLc0
    abG4/kPuELWN3h66zNQ6/4HxBUoz+tpBH8/cbqse240zwDC2JxnvUlTp3jW1PXRo
    qDeROWl6QsV8wI7DC/rCV3EJto7lA/lvEmRi8An85oadgx1wvJ0f+IRmBh3PFhRe
    AYevt11j9I/T2D4BFOL/A06Hr+Ob7p2MzVAgdx5fQykGipiUByaTN+ygQ7mmGEe3
    eGSxUaCLWxQ285OQq/HPWyQRB1OCdQyz0n9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233997; bh=K97QJA2rAc
    aAd9Hgzn3upJnXA77lrqzCgTa1jF5HnHI=; b=CYFY5qufY62gxQi0xDehH1Pl55
    BFDfe2H4RkEtgn7b6rTnyUreN2vsHSycrQEtqfgQjtdK38pRr6712WQMfB13gxBA
    WmTemhSrmqqjUoiDV46iHiDrK8mH5oG0hPRLXOyoQ7X689wgt0OAw4TA5jqMls6d
    Lh3UXew2/SNFgxiydh+hShhZARQ3s3LjdMI0lstVhKylZtugVGl5UHku+9iCyGpd
    ml4cE54n43U4+KFlwZrw/4c8NJaVtbGim+G05S9oKigCFVDjcOQ37FVLtsUspDMw
    xgdFbo2FZJNNqNJtAVCR1SZa6ILJkLFTWS9A1lk1ina7UZlGP1iIPVqaIBVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MhM2fwTb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MhM2fwTb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPymComehGrmVeHTw1m1dEYYGtmMeeTVH9OBQLN2pJf83LLJkf0OmoKftoH1szMX7hprPG+Emnb6Wyd2dJHKtIn/6dx8M/+1I6c9Lm34ymB+d+Nhounp
    STQiSu940dQ7MK2TkMWPuYkvlm3bNTEjy0QKKXIdwjqPxf0z1W29Grb7O0kQloQTFXSIJtTEsf5sppT6b8fMgOmOMHAFPq1SPJZWZcrf434NfBZBjE/fkc+z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=RW_g7ExWAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=1C7F8m05DB2dRtyQP74A:9 a=wPNLvfGTeEIA:10 a=UQnFI0IN6KXBP4Chuhxn:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeDIAdK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:10 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932234AbeDIAdH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jan Chochol <jan@chochol.info>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 229/293] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Topic: [PATCH AUTOSEL for 4.9 229/293] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Index: AQHTz5lRFvaMXW2pmUuH6Z1T7OmuMw==
Date: Mon, 9 Apr 2018 00:25:52 +0000
Message-ID: <20180409002239.163177-229-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:uIxRjGJlY+dtwal7IwJinG0nTdi/p56hsPEe4e0l165mVjxJY84V/LKhcyCdJj/GbVcb7Kj79wi71x++CyFa9TDnAGnLZb7xaUYswPgoxjq07SdHgFouacrEDxZYCbC5OiprpvEW8+JVsJpNcRzcNcFc0kq0Xzo24EcA9AdQsM8h3p2Kesj6Ept8ZT/eP2ZdkXkuUr9ga0D5vihvcrNDKbo6T4o9e6272v60IPoaRc76m7S22uz3si5Q89gd9G2x;20:U699/znQ0Eiv6RTv2juIX3FgQDmB09x+Hxlyi7Xg3JILMyHov8PX5cXuzW+S+AmJarDg2N46Azkr5BUtFsOhU1fDdDpVZ8EJMORFdYvb1zHZ2luAKSbsZJxexnYctyah3xErzDiDm6IBxnTNb275MQ/JTe9A75Jk94DAe52CBWY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 21987191-12b1-4414-307f-08d59db17110
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902AF943DA0C381C6FA0948FBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: liNNY563FFCjn5iKknURqPmNRx9YQiAnWEQa2Jc3LbSI810Yt/udvJgWOsRV9Huae+DeOGFdrhyl2geLr1udCVc6LNjZNimw3yRUafSkGOPB4XK0ymh+HGxODkxCVEXCEIb1tA5zbUiRpiYhyE4tGVKSFEHQ1mgPZ8bRXYiBmrTFGVy9zFrgOkTICrthx7jUyrveyWPWRyyfSG9j24U8N2TIvOBULXYdRVCUpPawZos8zQC29pLWSjcMOqjAp+w8Rbr/B/enN8byKI9K1HmsMhNtQ5lvWtqW/nWt9Ywm/SljM3t35wkCVRfDkFnhrEDpy1lYd/arEZ2rD4z7gVb3bTJWrSjsif3Q/PunqoLhvBkEJtrLfkPontoTZayfyaaCPtHnvn7wqIGw3TCWSxbKho+/nm3XIiX4GlZs9UyR0YM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21987191-12b1-4414-307f-08d59db17110
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:52.6129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jan Chochol <jan@chochol.info>

[ Upstream commit cbebc6ef4fc830f4040d4140bf53484812d5d5d9 ]

Since commit 57e62324e469 ("NFS: Store the legacy idmapper result in the
keyring") nfs_idmap_cache_timeout changed units from jiffies to seconds.
Unfortunately sysctl interface was not updated accordingly.

As a effect updating /proc/sys/fs/nfs/idmap_cache_timeout with some
value will incorrectly multiply this value by HZ.
Also reading /proc/sys/fs/nfs/idmap_cache_timeout will show real value
divided by HZ.

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring"=
)
Signed-off-by: Jan Chochol <jan@chochol.info>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index 8693d77c45ea..76241aa8d853 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -31,7 +31,7 @@ static struct ctl_table nfs4_cb_sysctls[] =3D {
 		.data =3D &nfs_idmap_cache_timeout,
 		.maxlen =3D sizeof(int),
 		.mode =3D 0644,
-		.proc_handler =3D proc_dointvec_jiffies,
+		.proc_handler =3D proc_dointvec,
 	},
 	{ }
 };
--=20
2.15.1
