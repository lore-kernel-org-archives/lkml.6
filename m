Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240895-2-10445038832671835919
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
    1523240895; b=sZ1I9u0Q0g5K1aQ04CtPPELEyNx+B7dUuAUZenLEob97rsBueh
    BUa7R8KHD2jARM/Kh3XaPtPGdZcVHEgjacyft7GcM7yDWxXEvkaFmP8/VVCHfrDD
    M8d64T5RUPDP+K1RmYuRsWc5cb3Cg2NHZWRnywEKe41BKoBrVtdCTfDC8ETAQvlJ
    KTBp7dNNkBP0nI7pF1HcNFcBsri4SOOMNXgdniiubF4Xs+JqKVfS71UkKxIlAk7x
    o7fPbQYICvJ212EKcnpjpceL89JgvxIVe3yfUZYYSEs7bViw08bZKwPlymvSi7XU
    JLizzMjLrU2gWO5SGlvuRtiqHuWsl8ebNfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240895; bh=uTsHEYP8Or
    4RxMO6Uw4IBY5YjNNMzCTziwm2aofW7Ro=; b=tGBJaQPAkmxlATVTTULxftYhwL
    dOSa/IGlDDDwiOeK9gR1SX6LA9h1I9qUTZHjnQLgd2rf5rpX4gXRkYzIzAbXTYZI
    lXDIEAxFH48eADWvbDRUSXJnY9eTjlhACF68hXHFaetj0XsRdUGyteTaSQWlUNBL
    5NF/6L0hKJezb1/vNQMLZkk+mGX3KYLSBkmr61a54qdzvyoU05n+iC3ru/Mlbfw0
    9+J3NTdJg7voVle+ztt9WuIsFpdcKNI3Ik8lpnTBHDVB51oubj5yy9SimGzjOwhJ
    t6JQDw5LlzRZi0dWMFVSEekWAgtgCuC9ck55f5pW3SLc9PypkxWPenteEqzA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D1xxBDHe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=D1xxBDHe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCQLW4aQYmUe7WDVjoxDHyI08QETGnf/Dbfw49SDluqz+pTnIuEA/rL0PngqF1o22tGKUQRzG9wsjnmzwjN74U2QjG2Faonwre+HbEM2mkD4USRmXh5T
    70NlBeCeCoc7uqRjps8idCwsw6UZIMWiaKU/HnSVryFNGXuLOUF+gWcgWzVeyIiOqU9ADtaiz6smqvcX+ZfkedXMmpnzd8fQwPs9GoK1Sh+/R9XMoux3c/38
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=CPxpi2WGvsGK3a8NPGIA:9 a=SxCuCgR87lfVDBlb:21 a=VxgbGYZeqBbnqiq_:21
    a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755897AbeDIC1y (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:27:54 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755896AbeDIA2m (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 087/293] rds: tcp: Set linger when rejecting
 an incoming conn in rds_tcp_accept_one
Thread-Topic: [PATCH AUTOSEL for 4.9 087/293] rds: tcp: Set linger when
 rejecting an incoming conn in rds_tcp_accept_one
Thread-Index: AQHTz5kPPJxfzy8YCUmDEMtHlXNu6g==
Date: Mon, 9 Apr 2018 00:24:02 +0000
Message-ID: <20180409002239.163177-87-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:9hEK1UrWDp6p+X/+cGfHTIX+MxUj/crLUi24jmIhfucgkoCmfky9GesilKSwDk4oE76hKZP2eNzcLZqHnxlTe/xa+MZLPHqeAbcGf/6PBdFcC8utFCDmbC8+JMN96V08qdtrhse6+773iR2pRgKLq1tYRs4LtUrVZJ17RToWK7QS4m5Tw13EUGl2chpJxnDWDEDJTf+8IuB/xaPw5MNUskyAfiryjXxDXkDFyR3nkEK2fUKGPlIZ1aWpJBOZv/ay;20:TBQj7yTRQhFZGPkYhl+SdVQ/o9KaGe0LETKzVsa3bk0ReV3qOLKCzUMMZDPXyN9U2BXB+V2t0YdPuRQr9Ogyb+Lr5H/ByiswiZkZiHLcW3tFEjuXKqot7uCffA3s93hCUBB9xfLR2QZst9FSscGcHsciLqLNrDXPmWupFj3uD5E=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49f90bc0-0651-46db-29ab-08d59db0d4e8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807BB81E2A729A4DAF8F38BFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: P8krccJQiWzDaiXqKuS1A+6e218Cvhhk6n3KomZ0d7Hm8IsrdJaeC4o+wwG7ZKqjQV3rEILEa5E8vT2Ejuipmcf41NG01H+xU3cMxBGm3wmcCIWPx8U1mJKqeoPsCrbCCYEpKa2Lk6bS+iWfbP1Tfq5f1bFTmg8tiv/RmsUgvYBp3fyRr6Pbpvy3xlfqd3HxhkdYQQMwqlASfAtvGA+aMZrTNZ6XXqddx1g3RMjHHMO1snlEPPLO3ptSlSe2UiSJxkEY4DO8PmZzV1A01OaToezTB0DjBt/BlKxmEC4tqp5xwBeFnir435cqGxXfm1SeqZYD3mPsMS4xknO+0vlr25d0pgWcrCMXigPvk0Qq0sJ+FPaJxl4cjPODGpm4ZvO2AsztkfSnRMVg8K/oFlfLAT6j9lw5Fi9yJvWZQBfMw54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f90bc0-0651-46db-29ab-08d59db0d4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:02.5656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

[ Upstream commit 10beea7d7408d0b1c9208757f445c5c710239e0e ]

Each time we get an incoming SYN to the RDS_TCP_PORT, the TCP
layer accepts the connection and then the rds_tcp_accept_one()
callback is invoked to process the incoming connection.

rds_tcp_accept_one() may reject the incoming syn for a number of
reasons, e.g., commit 1a0e100fb2c9 ("RDS: TCP: Force every connection
to be initiated by numerically smaller IP address"), or because
we are getting spammed by a malicious node that is triggering
a flood of connection attempts to RDS_TCP_PORT. If the incoming
syn is rejected, no data would have been sent on the TCP socket,
and we do not need to be in TIME_WAIT state, so we set linger on
the TCP socket before closing, thereby closing the socket efficiently
with a RST.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Tested-by: Imanti Mendez <imanti.mendez@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/rds/tcp_listen.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 185a56b1e29c..1bdf1932c8bf 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -116,6 +116,17 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(str=
uct rds_connection *conn)
 	return NULL;
 }
=20
+static void rds_tcp_set_linger(struct socket *sock)
+{
+	struct linger no_linger =3D {
+		.l_onoff =3D 1,
+		.l_linger =3D 0,
+	};
+
+	kernel_setsockopt(sock, SOL_SOCKET, SO_LINGER,
+			  (char *)&no_linger, sizeof(no_linger));
+}
+
 int rds_tcp_accept_one(struct socket *sock)
 {
 	struct socket *new_sock =3D NULL;
@@ -198,7 +209,13 @@ int rds_tcp_accept_one(struct socket *sock)
 	ret =3D 0;
 	goto out;
 rst_nsk:
-	/* reset the newly returned accept sock and bail */
+	/* reset the newly returned accept sock and bail.
+	 * It is safe to set linger on new_sock because the RDS connection
+	 * has not been brought up on new_sock, so no RDS-level data could
+	 * be pending on it. By setting linger, we achieve the side-effect
+	 * of avoiding TIME_WAIT state on new_sock.
+	 */
+	rds_tcp_set_linger(new_sock);
 	kernel_sock_shutdown(new_sock, SHUT_RDWR);
 	ret =3D 0;
 out:
--=20
2.15.1
