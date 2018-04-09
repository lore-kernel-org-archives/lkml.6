Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238710-2-4411105390100391498
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
    1523238709; b=IzdO4XhnJTt/nMY0RQylfwlGKJoWqvCqQxyDQvpXJqW65czsGx
    +j81wLwVb/IRYu4Y2alr08UY7I+P9MLO8PNvjuZ4Xvw7pn3Y05CD12mN9oSnByP8
    MqIXyIeT7dmdCZcozzgfjPbiW+OavPEzvfskbw9XGJM5FWlnjHWSXSg+JRPgOl0z
    PnYmtVND6ZYvHfGnIyxBFUGvJqt5fXHanhk1u1NCdfnrTEyzywDmGMOxrRhElnBL
    I3uRDAEwtfBAphfWEPRP2qayfQQZDA0ePocoL+LUEnURdReoOhRvvOjiv+Yu54UI
    WPq8Or8NjejwTZQ5hcepb8yczwdOHsSc6Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238709; bh=N8lRbqw7JB
    PRaeu91F1CymaiZdzzUEzlL3D41wOd5/o=; b=XYgidTjy3a/gpIgzxtpHjWpnbi
    ZKmgtPuCMypTH4mbeV0OrRqZEfSi7FvdVY3W+iDQvnc+6wYtqPVoL+k6ofbQPTVy
    1AEIhvptjoq3wjTgDO+GPvZOj669P5A97L/hepZD6yWYRWUO9BSvUtFdzjur9mS2
    pFta4IKyliz3PkvjhIM1LXd2pkO36Nr0SmBMvEoMITmPOaX2kBJafcMs0G5VAk4j
    clwwKZ9QlbDDby9BxSqg7VAQePUCZ9I1h33fNPLWvBY8ZpW4hB3HSce/NPlpB3Dd
    JVbhrRycZi83SywVJd17EA96p3w6OJajO54tO0wRFhteEax6Vkp5mJVa6CwQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q7rYNKri x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q7rYNKri x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEEhsSuVzeVNxl2Kt3W1s2YRBXtLWiZQRVzpNh7TITCUSAvy4O9GUW+3XLq8/La0veIsoqFA3UIKlrC71RjzI6XNgJny1yt0fT4ud4PBCeq1ABVSedDX
    lWMJ+vUdMOs0GXKWdN2tLBtyFIYid2mMIx8VkrnwraGjRk237bbKg7uIu0XjZ+y1TK1Gi6J+KpQNTjKFEnInM8MdrbjmTIi3jVr31v0QsSB4aIyWV2c53XkH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=_Wotqz80AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=3QStbVbEtIqWIzV9RIIA:9 a=wPNLvfGTeEIA:10 a=buJP51TR1BpY-zbLSsyS:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757469AbeDIBvT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:51:19 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:18358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932337AbeDIAdu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 252/293] tcp_nv: fix potential integer
 overflow in tcpnv_acked
Thread-Topic: [PATCH AUTOSEL for 4.9 252/293] tcp_nv: fix potential integer
 overflow in tcpnv_acked
Thread-Index: AQHTz5lbD6h6XD8nZUu+KDXJgIOJCg==
Date: Mon, 9 Apr 2018 00:26:08 +0000
Message-ID: <20180409002239.163177-252-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:9E9UIMG7efc5P1YrckQ1OVpApQc6ah+hIaKgv8pmSf7+7xTgwAaXSVLyplU1dKhR2tSYD7Xy+lSHNSRN8PwFxDzldbZav2rTuX+YhSd/wbj5SXYNl6a0XuEcgEEoM2SIIZu8eRlnPHw/0A77T4HjS8i6dwAKcVmFq3ik6mntFB4p5FUTmpf+GHwTaMnTk28oJdS+lTbgFiBP17YHhTV4rNdzATchk6+wKUO37EnVNYgL27LCPJlF22z2u1Q9ejt5;20:PxOO8IriLI8wivPGWHRK/qB/23aTHDnbj3RXkkLvQZtUMkhQSx/7RGE/RpY3bi7SqOGG2hko0cw3+Q9woosAGPB18EhY0iAfsgwvRFBWEG5JvpBwBH4/c0DQiBkQArEiH6cVkTdU8VfyIlLYSQZExIqZwk0qiD3FocfkO0mzZVs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50875444-2038-4ef5-e225-08d59db18f36
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806AB955AC2893878F60296FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: k3wX0z7VDg3nc8oSJLoiFWOwM0XMgb/UCgJ+02ltEUyOrQNnCri6UMPQhxL5HJ3YQVVyXJ10IDdrsf7rqUHw45PJBVS9jC+36Zvb1CKLmfqyAbEPPBCqcDIAnOQd62iMVG5UQ19T86m0QRFki53LdFMSCjTf8mYrLGsOK58+VITjLz7Qe1KkD581aa15s1uvrAl2j5exXP4ojXiBeo21Gu7wLiRg075Q5tGOf9/DvZ6TXqATPcC0QNRsY8iP6V1XgEyb7isNSWmC20/riBjmmWDfDY53IJjuo6/KYd1+9dWlNGoLcqDQ/bjFosMxf50d9l62MVNQa/kxCKWSPE7zDGhgHkPxLshOPRjb6IRseSjyvKd1hFXD+MSFr/wzXSj9Gjb/Ms+/Fg8qZJGrv1rr4QjIlKSj9Sb6X++b7cBCyIw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50875444-2038-4ef5-e225-08d59db18f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:08.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit e4823fbd229bfbba368b40cdadb8f4eeb20604cc ]

Add suffix ULL to constant 80000 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is used in a context that
expects an expression of type u64.

The current cast to u64 effectively applies to the whole expression
as an argument of type u64 to be passed to div64_u64, but it does
not prevent it from being evaluated using 32-bit arithmetic instead
of 64-bit arithmetic.

Also, once the expression is properly evaluated using 64-bit arithmentic,
there is no need for the parentheses and the external cast to u64.

Addresses-Coverity-ID: 1357588 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_nv.c b/net/ipv4/tcp_nv.c
index e45e2c41c7bd..37a3cb999859 100644
--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -338,7 +338,7 @@ static void tcpnv_acked(struct sock *sk, const struct a=
ck_sample *sample)
 		 */
 		cwnd_by_slope =3D (u32)
 			div64_u64(((u64)ca->nv_rtt_max_rate) * ca->nv_min_rtt,
-				  (u64)(80000 * tp->mss_cache));
+				  80000ULL * tp->mss_cache);
 		max_win =3D cwnd_by_slope + nv_pad;
=20
 		/* If cwnd > max_win, decrease cwnd
--=20
2.15.1
