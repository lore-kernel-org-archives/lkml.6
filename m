Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236947-2-2207677155936074838
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
    1523236946; b=sTH1K8zNPwB2plOSX+gejPXYFrAfI9tJp7LI/OUAwwSj2eEV5T
    t3U2gPYSyIKS3Hg9mLh9gnoF63vLS2bECoBVQiAZGi/vNN8dsnQhRKsMvySe1nP/
    Gr4NkEKhQBZ1TAPifVHUiOA7xPW2LnCHhX72XV2wzYEMafDiHl3CDfc1rnNnLCFr
    y6DmE8uu6ztfMqUkgRU+hHNHNazUTrUCzZXhlEPrNQRtOzrkeqhoMLR8v7EjnOaS
    J2WMIvQ0u6ZZ/mpnlANhjS8aree9J+fJlkZwUKE0rRoJKleWBjjKCVUfQbxeShDo
    P5SS1OOB5Up9iaR00YULaujHubEBl9zk8tZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236946; bh=oeSc/R3EaR
    W2F+r09RQgj3iuTiz2kTA4tLOQ7uxfqPo=; b=js/CO/HM1WEEiXaZ5e91J7k28w
    cLmjq1XCOQ8WSAez5CyKDX/Yy1ShsgZdQaHC+RKmv6yb1GYLGBfssRraBAB7/K3D
    NEY+YguyNuBLubbnyThKCAJb0c0uzJbAP2XYmu4HqtVcrlTnvIga3r6h5NeNHdvi
    9dofuUGn7B26kOvEfa3JTdKR26+WACtDDkVmwJyAOgEA2UFWvoHYFj5bQahIyvvq
    6SurQIdViIcNtRxpE742pptfj55sr5bJVogiwHF41BE2J/ZWIgVlXPaBIiGIspBK
    Z5X+fG7b+jXzm/2ofo/xKGrDchXbEvMcYDJd/iIdRbenzZzLyyCrQYXKLp+A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j032zQlD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j032zQlD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFJksOicKljSLciYrrWHHXhlLtJ7OIYJTbC+d/MBXd6h1JQxeAT6oPQ2zrnWJX9pMJj+9e8pdApaVOMhOQVCvnc4didZGboBtAqtR9PwJbPafcVn3d6G
    mWbXzDBWqnY8+keBA46czapHkoO5rrG2NWLnO3O1krgcKzDYVf7kQyOpN2A296vtOb7jHTr4YI6VdpLoyzk+VJHpwNCN3IW1hc9RHq1k2uijc3b0JYVLsMxT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=P6JkxrBpAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=V6zmTZ3s7WTRQaZwyNkA:9 a=wPNLvfGTeEIA:10
    a=dwOG0T2NmQ8MtARghG3a:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756503AbeDIBWI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:22:08 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932738AbeDIAhG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 082/162] sunrpc: Disable splice for krb5i
Thread-Topic: [PATCH AUTOSEL for 4.4 082/162] sunrpc: Disable splice for krb5i
Thread-Index: AQHTz5m3BqZaD0wUqkCJXMXACJ6t3w==
Date: Mon, 9 Apr 2018 00:28:43 +0000
Message-ID: <20180409002738.163941-82-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:jbqWxuj37mFHt5AR5dniQOZVZimp0yiOPTd/zQMR5meM96/D3dNKDwCc7a4fiaBYZKewCyCAzBY+yaaXrcIGRrO6NbPkp7/1bnWozR5Kg6MYeUgwMzDHvl7bj6SDmOn3YgOMdAn026oMkGh6rXVpWkDJ+nEEyN1wSneXPpul7bnh5+Fk3ezW3GmBLwJdZU7k1QFmM0RF3JXUscO9h82gzP9MuOaQWMWLDd23N0IZApW3apZHVie3N0I4N8e+SQFq;20:M4NafIPqgnBX6RfeEdi0UuTUjL9QlTUOCI7LSNrPiN2fKu1n/pj3xwldgXaPp6NqIoTWIgctzzlJFas107Kc2blf49FTYIcqHopyRl1APE5TLa33KmpGaMzOFDqmYHRhsyIzfKx3cLE8jFLDAAgac0W5XrebK1/tJCySmdxJaL8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c34ffe0e-1e36-4e45-a022-08d59db203d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10312D156C99639192A5B66BFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: slR39RqjS2MnvCuq73IKvuVQFiBBB2EpczeRbSZU8yjhysbnpTI4gpaiGH2F4K2nbyrdidITqDmbk7yjNGIhPM9SRKJ2wixZ9v2rwxLG/t/882YTR2kwEphE+I/MFLxVmFnMWuYFT3wAwTRLjrQVTvtra8GgVMjkCdZM10W2Zb88olIk+ueY0dlBeYdiJazCRyP3su/p3GWtDxlBD2D4QDNDrSgwHdM2QATJT2E6upTZpvVsTClPcJCiymxFUdsZqe+oj+pUSFIKp039JCHCmMyU1vuJXn58CXkKRCR+E8gkslFLUsNs529uc5QkXOqGPZNe134h5i9Ud+QBiZNAmOBKWI/NyYxS4jiHHGYKx/9w9wYWI8gDgkWphiISx5X50sRLfQt/AO4seFfzX4wnkcpH5GzIKcbceGkDz9zJqGo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ffe0e-1e36-4e45-a022-08d59db203d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:43.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 06eb8a56af23ae32e90fdd6b27fec30930364b52 ]

Running a multi-threaded 8KB fio test (70/30 mix), three or four out
of twelve of the jobs fail when using krb5i. The failure is an EIO
on a read.

Troubleshooting confirmed the EIO results when the client fails to
verify the MIC of an NFS READ reply. Bruce suggested the problem
could be due to the data payload changing between the time the
reply's MIC was computed on the server and the time the reply was
actually sent.

krb5p gets around this problem by disabling RQ_SPLICE_OK. Use the
same mechanism for krb5i RPCs.

"iozone -i0 -i1 -s128m -y1k -az -I", export is tmpfs, mount is
sec=3Dkrb5i,vers=3D3,proto=3Drdma. The important numbers are the
read / reread column.

Here's without the RQ_SPLICE_OK patch:

              kB  reclen    write  rewrite    read    reread
          131072       1     7546     7929     8396     8267
          131072       2    14375    14600    15843    15639
          131072       4    19280    19248    21303    21410
          131072       8    32350    31772    35199    34883
          131072      16    36748    37477    49365    51706
          131072      32    55669    56059    57475    57389
          131072      64    74599    75190    74903    75550
          131072     128    99810   101446   102828   102724
          131072     256   122042   122612   124806   125026
          131072     512   137614   138004   141412   141267
          131072    1024   146601   148774   151356   151409
          131072    2048   180684   181727   293140   292840
          131072    4096   206907   207658   552964   549029
          131072    8192   223982   224360   454493   473469
          131072   16384   228927   228390   654734   632607

And here's with it:

              kB  reclen    write  rewrite    read    reread
          131072       1     7700     7365     7958     8011
          131072       2    13211    13303    14937    14414
          131072       4    19001    19265    20544    20657
          131072       8    30883    31097    34255    33566
          131072      16    36868    34908    51499    49944
          131072      32    56428    55535    58710    56952
          131072      64    73507    74676    75619    74378
          131072     128   100324   101442   103276   102736
          131072     256   122517   122995   124639   124150
          131072     512   137317   139007   140530   140830
          131072    1024   146807   148923   151246   151072
          131072    2048   179656   180732   292631   292034
          131072    4096   206216   208583   543355   541951
          131072    8192   223738   224273   494201   489372
          131072   16384   229313   229840   691719   668427

I would say that there is not much difference in this test.

For good measure, here's the same test with sec=3Dkrb5p:

              kB  reclen    write  rewrite    read    reread
          131072       1     5982     5881     6137     6218
          131072       2    10216    10252    10850    10932
          131072       4    12236    12575    15375    15526
          131072       8    15461    15462    23821    22351
          131072      16    25677    25811    27529    27640
          131072      32    31903    32354    34063    33857
          131072      64    42989    43188    45635    45561
          131072     128    52848    53210    56144    56141
          131072     256    59123    59214    62691    62933
          131072     512    63140    63277    66887    67025
          131072    1024    65255    65299    69213    69140
          131072    2048    76454    76555   133767   133862
          131072    4096    84726    84883   251925   250702
          131072    8192    89491    89482   270821   276085
          131072   16384    91572    91597   361768   336868

BugLink: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D307
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 8 ++++++++
 net/sunrpc/svc.c                  | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcaut=
h_gss.c
index 036bbf2b44c1..5a52e37dc395 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -832,6 +832,14 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_b=
uf *buf, u32 seq, struct g
 	struct xdr_netobj mic;
 	struct xdr_buf integ_buf;
=20
+	/* NFS READ normally uses splice to send data in-place. However
+	 * the data in cache can change after the reply's MIC is computed
+	 * but before the RPC reply is sent. To prevent the client from
+	 * rejecting the server-computed MIC in this somewhat rare case,
+	 * do not use splice with the GSS integrity service.
+	 */
+	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
+
 	/* Did we already verify the signature on the original pass through? */
 	if (rqstp->rq_deferred)
 		return 0;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index c5b0cb4f4056..2221a52870dc 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1084,7 +1084,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kve=
c *argv, struct kvec *resv)
 	if (argv->iov_len < 6*4)
 		goto err_short_len;
=20
-	/* Will be turned off only in gss privacy case: */
+	/* Will be turned off by GSS integrity and privacy services */
 	set_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 	/* Will be turned off only when NFSv4 Sessions are used */
 	set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
--=20
2.15.1
