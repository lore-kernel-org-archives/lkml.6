Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239807-2-5722050832745228218
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
    1523239806; b=qEYDqwDtrnfMnfrR2y3TvvZjEWioPN6o2rFJWrAFM+7f+39GRD
    l6UzyC/Y46QmFH3nTzBvR3ASy1qMBqmTIC2GEh1TL9QYDcAOz+jZw71L+KduYIZ3
    YSHoatQnbipjK5xATPvspMuzVwEQ3PmZeXQRGQcV9ZC77jmPJXWRIJIA3FX4kVgh
    7/mN4qHfvXksjes6zNosqNZ+i7AXLtkqqpGZ5H/Z4KPF6vflO+pwrHmhjSlZ0mss
    T9JIYx8N6zQjzNmLowkSMZtdER3zteTYqql36o016YayegETpYEvHG34WbrUifo9
    O2yNu5R2hY/ZDTAmWCYIQtlwefGvyMDVuLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239806; bh=vza3czM7Du
    1qCmqW71LHHmU0QJBxlwpiHpGjf/xYTOk=; b=d8owR2MIu1qQdTNxDXHCYG8Qvg
    xIGXUTL8zTNk9qOTy/Xbj91AE/NxomvdYNKHk9PzHgNTlBAM0LizQKpmRko1ZbcC
    OgDwygRaQz4sUDHGC3n8El2OM8iZUUexajiuZYT6beUq8VFMoHRcX9E2Hoxqapts
    X4oQ6OtodDSoFYxl22eFxfvQtKRE8lEeUL/Pdp40ILZx4tcKUKH6/ntDn/xOt++n
    PYtIaQTxXAVozU23z3MQIIzbDyF+CRdwHbenKTXsNqXsXv8UcIUH21fctRw6vc1M
    hmYo2y19QYQFU6wQN66w1kH0JdDewS1sbo4DglqJ8GsMeNdkzLrfOHeLHtJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aHAxEoCB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aHAxEoCB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNtH9TTa4o4Sahzo5KM802Y5xWVqCOn0gzPhpk875GOQxlwoy3nzxcITGiAK2PP3M1w7vtCn7HJgoOwAzC1r6dAdU5rWscaQOjgCvzcMm9+Ug7UU+buP
    b5CkH9SVTZ1Tm1SBlcDpu+O+2OBtuOHrM3inI032YO8xgG4R6LKJD7lqrNxHJaNeT96l9MPHyYSxqd0090tAgYo7XdnRyPCNjpsnNziF65zZOEEuQ5n8BqCI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=P6JkxrBpAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=V6zmTZ3s7WTRQaZwyNkA:9 a=wPNLvfGTeEIA:10
    a=dwOG0T2NmQ8MtARghG3a:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757578AbeDICJs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:09:48 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756229AbeDIAbS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:18 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 164/293] sunrpc: Disable splice for krb5i
Thread-Topic: [PATCH AUTOSEL for 4.9 164/293] sunrpc: Disable splice for krb5i
Thread-Index: AQHTz5kzjr7qH0QUOUaXE8f2zk9U/A==
Date: Mon, 9 Apr 2018 00:25:02 +0000
Message-ID: <20180409002239.163177-164-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:DoKDj5kwu2IFdgFaks5ixMa9k7OTk9aQTRyNtaiMaYshR+9uVS14Um86zIqmB+DnlAq/mvfZ7vdmvqeNB+STx0hTv+Vhlkr8ARX8bH+LzNCNOjIiEQ4gSGTnILhWWOh2Z0tyRpzq/SxRd2bxMxP5DFXA5XKfebhKJY0aiopbJlje/HRPO0Y6AqSWZwjohN0hPB0icOFIht2/vPg3d7AbQdeyrKNNnK8kI+mFGX6xjhZcPQZKcbFLp0rGvnVHKYmd;20:Awe/IATEawMbrhrR2zevY/0H9w5Msj3jsnmZI9/dhAi7N2V4P++nwz6DZ0eqsReAh7JOeicw9Ymih+iJcTnonAYxqQ6SJ0D7girDYHNz8ZEzFArMZVhmYVy3s036N27A6qvMlFbWLRLhfS1KhikWI6bs1GwjkiEAZtQKvq1wW/4=
X-MS-Office365-Filtering-Correlation-Id: 5eea997b-370b-451d-7c63-08d59db133ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917E34AA88C6AC119D53509FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: w8fmaAqoWWFl8xVbRxuthaB2iLfsRu5Jn2UjM0pK9K58/o7bHlf7Z2WpLgEQamxm7Hgu11gq59iukckIXeqVTcBBX0sW2gGeJovwWH24ZC6E7Fb/JdEv6mAMI7bHR1zLx021mgDC32iSD5nrQJmb/yzYvIYvjJfHtJ0ygAa6tfGRKXqEp1ZPZI1BfaQqkEEjiT0P7iwLHcptGER5u6kncbxZR59DeLabbC1zZQKL7PgRRPR83zlGwiyfpVzk0Wi41V6GkI3JNrMNRMBSFXhUxXZkReUNf+Mow+gc/CBzQ2rIo0J2/BsEqKYDk5PLaY5aDoEOlvrpIRhW5b3xtDhW7uCU/msigTgdxpks9bQumG08fBWfXF+CTPP+/gygFRwr+STyoe9gtOyTyTPnLtZYVkPFl4zG2Ozi/OTvt5oGzS4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eea997b-370b-451d-7c63-08d59db133ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:02.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index 6a08bc451247..7897e1ef3f20 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -839,6 +839,14 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_b=
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
index 272c34551979..3e1d677276c1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1159,7 +1159,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kve=
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
