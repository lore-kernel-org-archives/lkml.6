Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234297-2-3183031963388295276
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
    1523234297; b=lsvGcQQ/YpU6iuov2Cgx+Mo+DuBRSFaeH1abMMgH1LALI+hJ70
    wP3XDq0/RM29cY/OfIugiuXYcF1A4oKl11cRlAStIlaQam+/cC91s3wNaSW38AB/
    8AG5HpMLvXZ0DRPj1UuSkNwbCAkTv6WXdtdaFbaJKbdI5WYu8ctaUGTVTUxaFHAO
    hEbKh9S7owBDJ6ynX6z+5QGhoEF2u/QJfJK2+APbNvj4ceDBlCdaFx7ZhrB6T4Xv
    4fd6ZnIdrY77Ghs9wu5w5IzC0QGW/buKBW7xCJQXbvsfYH978c0nlfLDQw1esTjM
    nXRx3m3nLN3OBaRlXKYf4ZTPnkWWcZkq+rKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234297; bh=a99L3KJgDk
    eEbaOClUHoODr5tj94bhI4dzhYwnP8/dE=; b=l5MAe68QNMN+Wwf5++DvnPdGuL
    VeT6ot/7eLxtrG7A4+k8SR93ohSqizW++2SWpyvwax7Isk47YaX5MSd+h1IakSKr
    QnSK+uhuZYnbv0oIXTfVuqH8KhiG10iikq8OsVlGPFdrSsQ7G5BjcqgyoYXVVwmb
    g8A3Lcy2Kz4TKoB48GxEFtGVwV3WIXeulZwPZgZKBIProt+jp9f2V3cfFf4mHj2e
    2SKOEkeBrHey8gTQS2n8Msfz0F7yFD1rXfa7LNn4tjlBh77sXyzUWfGYZeOwaIpQ
    2KAH8GZbgIMEI14B7NGvfxKjw6S3oiX33XxKPIN3CLP4KhuA03mvIfph4K9Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ShbF86r9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ShbF86r9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBDGWVyzkW0C3OnwDKZIt6ZUK6RZW3ArZ6iUdZgPUp5mkjWk+Zt6/xRiNpD3GigKstaz3al5DiZlQjrMXP0cG9/CMYlvzcN2htBZVBbOcNol3B83NPMA
    ordqA+aFg04Tigku78pKE0Q2H6qnQ3FtVlwZ9/6VlVAjSuml8mVlqjppQ1oFya8zlZGhMTBWYCfZGlnysFWnXY74BN9tEBB77rvk1sWtBseY2tEObQUIWgV9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=RW_g7ExWAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8
    a=1C7F8m05DB2dRtyQP74A:9 a=wPNLvfGTeEIA:10 a=UQnFI0IN6KXBP4Chuhxn:22
    a=vzdIw8kzLcqZOxdJCU6L:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932920AbeDIAiC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:02 -0400
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:39808
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932906AbeDIAiA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jan Chochol <jan@chochol.info>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 117/162] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Topic: [PATCH AUTOSEL for 4.4 117/162] nfs: Do not convert
 nfs_idmap_cache_timeout to jiffies
Thread-Index: AQHTz5nK+ZsMTeb4u0S+nJSP/B58Zg==
Date: Mon, 9 Apr 2018 00:29:15 +0000
Message-ID: <20180409002738.163941-117-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:xYLYhtTFWLULa/ptyFrlOau9zYeRFV4qqxE/c5O+DtXqM+Js9fmrmpeBNrSE1+5Ev9eN5sN2+q+14KZt9ihUjMRckw7kHUCaG7Viuu9hidA35pbT3kFSk2hHx0UnTIFABrkLnwBo7IxJ506zzN5tRyASlvVZeBSxH57txwPGGtbbtlL4ff9wN+2pKxDQ8B2F/6r68DNsG3NwSPRzORF96KpCK/VBx1DtxIXsr9guiVTLtYs4DkWynxshaHdQAx9o;20:EioLgjxALnxYNaSxeaEfyx/23r5JF7SL0ATvihmDobXPQYmv1JMZZSORZncfTaBS3VP9x+RTuZb25Ye1NITGKcu/b/vKZxYEJXF1Pj78l3TsQI/169ZigEmvb9jr6EDdGaoMREN6UjT1Fgs0nTn+buTVLICTcqT6iXIHxHwSNH0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfca625e-c8fb-43a4-5cb3-08d59db22152
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111074B19D3017DC9A160DFDFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: +16xxWwe8DS/19OpU/ba+9ET9A56A1Qab/QdoBE6FcKlYYXr44f1sWYWH53HVbrGzD+hwY2NjJB6NbPbSSMxaPtllHBVleqBMr63fiZiu8vPzcX19svEy8IzjLxWsV9SrAY86SORaicLT3mcdM+tfKCyqA//9m75xrn33LTVCBROXY+OiB+MigDyzNbiTl+3Dfbdwh8qbigBjHtRLdCkaFVlTl/j10VkG10oVn8COjPKKzrVd0Ce6+WsZLIx04GETeLtNyixU4713eb591rB+dbx6YvYU4I8fQ21dGhM8mZkEUowAZDhRfgqJzQ73Z/DpkBrBJZCEt2Kxo3QmbrVKl0jpwAga3SfdgUY+Pdvit2DBL+TpS5XwAh9+uG+Xli6oqaLBa/PfhTa1Ql5OHAYH4eBJsNsiqZOMAiYXTnRwjQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfca625e-c8fb-43a4-5cb3-08d59db22152
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:15.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index 0fbd3ab1be22..44a7bbbf92f8 100644
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
