Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234377-2-8223460074511168163
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
    1523234377; b=eLlud7oHuKPK/tisF6L8m0udW7WIrwSHKcGmOCEGAPADV03h86
    6inXSL3h0yYtDhGukYiVsV+kzgZrg9Ty/2+3ePLxP8CWWS0JnQIARhbpZdTPIK36
    hEKKPWMlIZKw+X7OMaoCAYh1B/e7yC1GzsU4wEZElee+6HjqZPE783Z8pOdkbBYB
    zccpn0UTbSAQxdajXhbPaidXhZrUpudodGSsu6Ek0IlaYN5uhR4I/gIF1VU81M5f
    Zi541sUG6F0I55uxox8hqol1d00Rvj0GfTfr6z7bXYZ7XMevAH4XGPup0Yra7RNn
    +kI/dPSyG/cEwcrru5M/HEKPUQnD1xHVxW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234377; bh=N4PvoO+GjB
    Twir4TLtORb8s+rDDPLIpx2FNqjifnyFM=; b=m69d67R1dnRWIVIX+qtgGRbpVd
    RUd2lQx1ItNxuUyl7M35V+8oU9Rv5c88Pl2vXf5KyenAcsnQCODxEccKCPOzaQ/o
    6+9JS0otL1ZC3wB/dpTGtI/QIhTp1eMJ3i4Myk8WiEYbpXPq54QqJsvRpt1ufTub
    af0LDZqRA7L7EM/8+jacrgWAfucElvNOHG4/IuaLb97LGOy1EJbWo78XOXIX0bBR
    AOOe2cT20vwWyfN1nRK5NNtpaWhaUxIqSyst206D9B+wW1tR+Z7W+5fuV203Zgs+
    W2imLsTg6GxGxymw+PHmRD7ch4Z691kOdjugwzCkKn1q3+2eaN5COuQP2sSQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l2GANd20 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l2GANd20 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCfh1ukgFYaTynRKcbXmElmB0GFi7o9tiKs56gcb1368ngFIGWlmOMx2Hnp6m2AqO6JSigPvuOk/biP/znxkxUKrMr0DmHjcBMAnweeOc3hxNM/ZAqno
    o/khCttAAGiXVISmb0jxc2g1mVqCHWKeTPxYmnPY2RMdzBku658nc+UzlljP9d12HWw+UX0OfciyoBsNtzZAvx+joIorO+CQS47X3bOZZ6rib2rel/luTUYc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=omOdbC7AAAAA:8 a=yMhMjlubAAAA:8
    a=gsqZSsGcU53TmyZKCsoA:9 a=wPNLvfGTeEIA:10 a=baC4JDFNLZpnPwus_NF9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933130AbeDIAjb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:31 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933113AbeDIAj1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 159/162] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Topic: [PATCH AUTOSEL for 4.4 159/162] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Index: AQHTz5nh1njdyeSiV0abDaDhuizbwA==
Date: Mon, 9 Apr 2018 00:29:55 +0000
Message-ID: <20180409002738.163941-159-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:dOqbeOGtrmIxyDaXpB4bX4aAy2RfHntzH1o05KuMSPvsQzzZ8KlPLtoUVeTZt3UN6p1wRO8ERCLlv7g05u3wjBaejdmkduZoqbAirQwpPHxiVrwef9psnAPSBCmg4rLrwe4h0hNkT7ga8rEI3emKigYWPCbIojcT2YIrMnRXwB8IJIt4bAIx41xLKwcjygO3Mctz33twhlKIMz/Cbn61e4MQi+eXszDIpAaTfzEQBG488IYIAbk6TdQ6LeD+sPq9;20:MxTrgFp5Q/s+BktFm433JDwrUl+wwe5k3ocbKbvwRNWLNmWX5trl7EYxV+KC155gFOYcmy4BRQhmEMq89UwVAomcCO1/g/rQpogeg6+zhQR1OhVlezudHvVm3mggHFbGiCvHn5a+MGp9Meq9T/N9Rl3nSJPkzN89wGdlbL8BTvc=
X-MS-Office365-Filtering-Correlation-Id: 46ba8a9e-a10c-4526-678c-08d59db2568e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125DC600490DDB99A80D98FFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(170618885588394);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(575784001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1Ahh+DiZhx8XgPXaPH8rbxmLO0ao2+DkgkzRu1XFXWamYWKlZf1MQVCGZokIzBy/JHB0N7gfKrSDZIgp6u8x4NZyE27wi1cfpURbHHmGBkaQGrJ4X0s+rHSFOVWOcNYIKzr4DvwoNzEAk0RLstpopxlMTlhi6702/JN9K48MhOnkjF8J8mI9qzdJRDr9iuUnK2dTW5ht+9giUfUZOA063fzgTA1RHLVWWebBfkxJNTFVvasYBbSeSdA/vzI6N667ei2NNs2lCc9eP4m9o1/gPDHSW6pMzy85+41BUkz1QTUE2rOBOt3O4E5kebBionGhj3173BGI0UwcuPPY6I7EbZ7NHk/NjkYJ/qXzt3mMuDepYm3JniKaPy/Dc8tz/jTCdfdZMJiBhSBWMZnV104fG1QsLEoMhaigGqaeoiOgOnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ba8a9e-a10c-4526-678c-08d59db2568e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:55.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit 0078117c6d9160031b866cfa1853514d4f6865d2 ]

A client that sends more than a hundred ops in a single compound
currently gets an rpc-level GARBAGE_ARGS error.

It would be more helpful to return NFS4ERR_RESOURCE, since that gives
the client a better idea how to recover (for example by splitting up the
compound into smaller compounds).

This is all a bit academic since we've never actually seen a reason for
clients to send such long compounds, but we may as well fix it.

While we're there, just use NFSD4_MAX_OPS_PER_COMPOUND =3D=3D 16, the
constant we already use in the 4.1 case, instead of hard-coding 100.
Chances anyone actually uses even 16 ops per compound are small enough
that I think there's a neglible risk or any regression.

This fixes pynfs test COMP6.

Reported-by: "Lu, Xinyu" <luxy.fnst@cn.fujitsu.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfsd/nfs4proc.c | 3 +++
 fs/nfsd/nfs4xdr.c  | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bfbee8ddf978..8f35f0a15bfa 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1627,6 +1627,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp,
 	status =3D nfserr_minor_vers_mismatch;
 	if (nfsd_minorversion(args->minorversion, NFSD_TEST) <=3D 0)
 		goto out;
+	status =3D nfserr_resource;
+	if (args->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
+		goto out;
=20
 	status =3D nfs41_check_op_ordering(args);
 	if (status) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 544672b440de..5ad02bdb62a3 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1824,8 +1824,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *arg=
p)
=20
 	if (argp->taglen > NFSD4_MAX_TAGLEN)
 		goto xdr_error;
-	if (argp->opcnt > 100)
-		goto xdr_error;
+	/*
+	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
+	 * here, so we return success at the xdr level so that
+	 * nfsd4_proc can handle this is an NFS-level error.
+	 */
+	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
+		return 0;
=20
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops =3D kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
--=20
2.15.1
