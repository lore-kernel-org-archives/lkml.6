Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234505-2-13624031157033745422
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
    1523234504; b=b1lyY1eHMnrs1AWQdTgBGmsnYhKA+6zoskYShJRw9aF3i29x8J
    DDPJ+Lun1zAHRKhzRKBLlKMy+PtF+6n8wlKg2yHrutwD78HGY1Ykhs4cnPUzOKKz
    Q/5bS9YvAVYDrjqJgIBqts0figh+ns+ff3xh8pktnPiVXlXzjJlBFOs1W/ByFAz0
    86VNa2Qo7Y1O+UTt0rR4gMTJXyd9bbd2pNQqHX6/JmCZffLtRbl1GT8Nn1dRLbZW
    MaBwUJIvfE+Pf/SZ3BOmaoR59SlytUX2A+qw2KbbBJe8JSTP8CIKHQ8OAQoee5dx
    1LQTV9zBgL2x+osThmG6F9x8X4B4Vysa8pUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234504; bh=8prdsuaJhN
    cbK06ThLP+k9VieBB+EqPazA+Vgi7QONg=; b=TBqQohd3OO1rBz6Dr0q51SWqjv
    +9XL1MrrH3ceH+u2P82LoM4TukM4FKPlo1GaQmPKq3f3zjpvJD2NxIZBNQDXW9FW
    huW0LK0Jih6/7ymX9d7U8RPsKXeqDv3zcLvJrHWUWD9LCqeOcIf5OQ79blgAk57D
    5XLlxsAlhZLnYVXzBAXLPGhYpQT7x/wzYmupNtWHap1ts3HJY+1MRxbjzi0GTpNN
    kgHC7kxN/nLTBh23nA5j3y9lOYDkAbPFvbalW2RetbBiZ8VEZHqnkvKpq4j0hFqE
    uent1566mVR9BYu7aE3HVY/1xPfl19k/pjrKjScSP8M5fYPheCg+JCfk1WrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YjiX+DIq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YjiX+DIq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD75sklNY3NqKKu7OFMpPUXG1bYKg0y2uhoYfd4D1RxUAH8pyM3/fZAHNr1OREf5KnvvwhZBqKURpt1jihUE0v7d0omVIBtxV7P21IMda8MRgkMkqRCG
    Vxj8yiY2LTCYU9G0Vso/OjbNHPjyoPrbF1Y0CTtjdngZr4dTwWh9oIMzUpq2X/H/jCWlkJ3ZBEbvagHm+66ajkuoNzC8rLVJnRYJeEqlKSob/HKNp74O9B86
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=RW_g7ExWAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=1C7F8m05DB2dRtyQP74A:9 a=wPNLvfGTeEIA:10 a=UQnFI0IN6KXBP4Chuhxn:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756354AbeDIAlk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:40 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756318AbeDIAlh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jan Chochol <jan@chochol.info>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 071/101] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Topic: [PATCH AUTOSEL for 3.18 071/101] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Index: AQHTz5uBSNMXLgjv2kmAhTk7bWzQdQ==
Date: Mon, 9 Apr 2018 00:41:32 +0000
Message-ID: <20180409004042.164920-21-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:ITAkkv7zEV5PaJV+3kjHVmIkKh0xolKOMPbprryT0a2YNl/WCZaIoqACoBcOYNMn47xK+qSEXbHA7H+K4d/HjI4ykBGnWNGUab+yzVzGhtzhDVhpYodh/43kBLiiGvuEDcaXAllfpUHUeF2feZ09lQOWbT2FF5YJLhayMqcID8otOHwJ7Bbxy83SJKJbun1mR+lLshadp19DTPywtVorc8aP7ZWw6YpqOCZ9iLP/niVXat7wPpQOpFASWargS6wg;20:2M86t9iYS4GkWaFT6e+HGhseCPl174FkAjQT5/DB3XIam3Ej7o3+elCqlOR4WSLLkN51u6Drfm8zlZQFiYLPMAFn9qCO2ndNyspQAEQLiHGMaqSsXFW+hRqjDZBpd3+HtgaO5usW3cL8v8V9jDoy6AGWvpI+lDjYTKahpag3q0k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67cd35a1-fade-4231-a6dd-08d59db2a40f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901888ECC1B138573C8E332FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Y8DCFwArrK5GLPwz9iNw3fppPf+H+ru/uahTSgvy3LdnMDTgMQspes9CzHKoorvyoQ6qABCdyYfLDYB4hy58fslPkuEiTvwJFYmfj96DaeJOE3bdZdiWUZAc7SL+vk0cppF3lfn3TVBymbt02jFUFnx3RGot4KypMKs1lUElQctVuFkPogZfm5TQI9tz7SQ1z04u7hn4RGxZVSQtCg9/lhEAwizeCvLY14YQEUbIW0tHNGnTer+sma6m8gO9BHosDm2ROkDCLX0LpOMFkzeq20ZIl2AkI7cPDdGF/SKflOapYeA1/JZh7C/OMbyQWB4w7kUKKIAhHS8o+SERGrXMQ1qAGlxXYMCx8BQixX4chR4VKR2taqjW32OXVhHTVfdR9ypQaayErNAQLyl2XLZFXI1foJG9U3FUaFyzCyzbcAQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd35a1-fade-4231-a6dd-08d59db2a40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:32.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index b6ebe7e445f6..b83056329370 100644
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
