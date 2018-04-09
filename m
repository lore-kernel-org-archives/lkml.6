Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244334-2-9638087055977340963
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
    1523244333; b=k4aBSL+UKBR8jDfsmoe4w6wRn9BH/EUaU1HMZMrhIGO2t3jlgP
    ls07/WCD7b8Z4u/nq5CKrNwzjLIs6zfXZtOtjU3mHUXAdFiFhsH4Rh+2ZyabqVIv
    Es6O8gZWcngJ9moP4djB6jkpFbUramw0Hk/3rpw782lPEsfrWz5E/cmymWfI65tk
    h9CnLXwtf3h9vi2MrFVhE+Dj8pR0umoLUWSu05bDTQsbSPU/j1JNax6PFHUWlfmU
    0bLrZ2tpgtWIev/tDT0q9/Z0ie4PGuqcTRgG1a11UB1LjEl99eYeOFS2CNJmQAcy
    TcSf4zB2ernpsvqpclGbBHfZFVb2GBeGWbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244333; bh=Efnd2MRltG
    CABucCEZR3ZyG6PD2bybN7herY4qiqo5o=; b=J0ahHUaw/57P3L0jovpBDYS3Sn
    0DY0twcMR9Mqx4EfFXZsOZCQo2nJjfKf5yDTxQgvuTegpES7RhyBeZig+xtLp78h
    6OnC70n6Ud1QZj7mZAUqEX9E5oP0KztHhcixzyxVDJ3+661x964ZHG+wERHhL7bE
    CXny8FtdpESrxJk9eTWox4eyv1FYk7JJsmKoEsqXcARf+pGw5P7+8Wdbzd460xwW
    2HLRlT/BrRNaftXwoH1Ypo1Gwm8s/CudGDLBBSf1Ym/9ErsC6UNMUWhQtlkp2a5S
    Ow1JJnBQYkBrSD4c6kRYS5C4TOGXq2dgcyoH5PQxs9VdH7OwjEYfmxxSkbPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rg4bYR7r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rg4bYR7r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMrF5aO0HUdK/Je2xNADm7NkvLuOlwgKPgz/fI5oj8ptIoGG8z/xZVeI6Bdduu9xW9w0Gg5YYgWx7E8twzgVTCjmN2FNp/FZzYSADWdDdUoU+eyUUzXY
    mvxa5LijJNUii610nXDf2k0qYD2ZTsyJr3KDYyNXdwehiuITa5cmzhhJ5Yw/9poCU1izhv5eKGq2GLRjUTbJDRGqnodTnCs8DyddkeIl4nY2Jt+OacbFlA3A
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=AxAqW-uwn50A:10 a=wRwT6uffUbIA:10
    a=t_PdEiP4ckcA:10 a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=xQp5KPISSQHezL6feeIA:9
    a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeDIDZM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:25:12 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754692AbeDIAWn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 025/161] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Topic: [PATCH AUTOSEL for 4.14 025/161] tools lib traceevent: Simplify
 pointer print logic and fix %pF
Thread-Index: AQHTz5iAdshqWctDSUaqU3W7bp62aA==
Date: Mon, 9 Apr 2018 00:20:02 +0000
Message-ID: <20180409001936.162706-25-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:/3YikyVRWELCZHhk4twk9bC1Hpj4Bft78OGa9ThrkakDFomUruurXcOwxVlduBOj85ZlZ4S4qxUfjR34H7q8RoWVdTlJJgOYQAoXMedRzmx4VVIqegO43RjfrEtwUd2MFkUuKj1+CzKqHa6yAjWgFHW67EMQ9sbhDRl0Dcsh63Tg09e0svIB8GoEBVRqTdyB8vvs4E6p0QSm5EDC+DALnWQQWVgKDNqZyJzfLP8L+LsDMdXwlJx/r00m/8dxUVdw;20:0NzjbE2M+8CM1OQ3aw9f4pBOKgwfd8acDmHKWOeogjH2vf4ZEz4mWo5IocC1LA8z30xZN2mVXrtFRViyzjXK3iHZb5ET6LZ4evrzLs/P1VY+Uei4Aw4ZG1pZi4uLJ6EdafgQ+GmEQvkC33U9I15u8DYQ5QqRC3/LPb0n7xweP8Y=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 369a9bff-2a9d-496e-318b-08d59db00143
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966679C662130757AAE4532FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(6436002)(186003)(6306002)(6666003)(2900100001)(966005)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6zvo/VrxjuHbrAEu91VTMlSq812MGpGpBHEvZnXN4tw6yR1UHuKHHGq4m8EmtNxHosYXaOF4/LEHSjgsBBsm3TPLsnYZD/IyuQScme+Kl8Y09spOzwmh/L5d8OHVH7M52knrd/Dh+YxOXSIB/j2e9xB1zeMCTRNH00vt/YUHLholQZURkbJLCWizKSPABKM/E+s068kmPVwfBUiLhrUTqjjBf3vqYqpc1pYBFlrCmF8HT2KrrFuQvRgepa4pZ9iuheXs/qtnDEOpoevgoYEjrsLWe04f4TGhxvQCuQa1iBZmVIQbOamjXiAJo/kBMX0D6WNhe3LzL+lT3/BhEqKrqOLWIDvU4bMKIs/h2l74KfPMvqiPLWVbbLM3dofCRcfg6jyuwWknshxo+Xr5NPnLLa5r2vDEQ4XKCsTAeu1nJfA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369a9bff-2a9d-496e-318b-08d59db00143
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:02.1917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit 38d70b7ca1769f26c0b79f3c08ff2cc949712b59 ]

When processing %pX in pretty_print(), simplify the logic slightly by
incrementing the ptr to the format string if isalnum(ptr[1]) is true.
This follows the logic a bit more closely to what is in the kernel.

Also, this fixes a small bug where %pF was not giving the offset of the
function.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004822.260262257@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/lib/traceevent/event-parse.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/even=
t-parse.c
index 7ce724fc0544..9a17bc27296e 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4949,21 +4949,22 @@ static void pretty_print(struct trace_seq *s, void =
*data, int size, struct event
 				else
 					ls =3D 2;
=20
-				if (*(ptr+1) =3D=3D 'F' || *(ptr+1) =3D=3D 'f' ||
-				    *(ptr+1) =3D=3D 'S' || *(ptr+1) =3D=3D 's') {
+				if (isalnum(ptr[1]))
 					ptr++;
+
+				if (*ptr =3D=3D 'F' || *ptr =3D=3D 'f' ||
+				    *ptr =3D=3D 'S' || *ptr =3D=3D 's') {
 					show_func =3D *ptr;
-				} else if (*(ptr+1) =3D=3D 'M' || *(ptr+1) =3D=3D 'm') {
-					print_mac_arg(s, *(ptr+1), data, size, event, arg);
-					ptr++;
+				} else if (*ptr =3D=3D 'M' || *ptr =3D=3D 'm') {
+					print_mac_arg(s, *ptr, data, size, event, arg);
 					arg =3D arg->next;
 					break;
-				} else if (*(ptr+1) =3D=3D 'I' || *(ptr+1) =3D=3D 'i') {
+				} else if (*ptr =3D=3D 'I' || *ptr =3D=3D 'i') {
 					int n;
=20
-					n =3D print_ip_arg(s, ptr+1, data, size, event, arg);
+					n =3D print_ip_arg(s, ptr, data, size, event, arg);
 					if (n > 0) {
-						ptr +=3D n;
+						ptr +=3D n - 1;
 						arg =3D arg->next;
 						break;
 					}
--=20
2.15.1
