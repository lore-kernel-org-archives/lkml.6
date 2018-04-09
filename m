Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236726-2-8875843985009653006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236725; b=dGRR4LGRVvwLLO8yyH/QkTcL1N5O9h+iF6MeSHrcq/brGdBdZf
    NoqGSCJhZ1zu82gopdoLzR0E0w1An3374rz3S1F/ZxRi5qnSn3jckXCgaNlBqXpi
    1Oq/w/SH3vDlIwrDG+zPVleu/lZ/E/HoJufD8z7AjSPwoIZaORZQ2dJGoByxON8H
    za3DchJBpEDPOoWFxI6QG/bpeztl+xhWFDudNpdU0GuA6STeHaxRjSQSIT7sxwqR
    KJsB9YviSXDb9Bu1XCdwhQO/sPEhYvGS5zioGHnNSoB1oK2ikD7OjGBG+Pm7p67h
    b2zqWz5aeQEs6bimfBY6n52E1470myIlQUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236725; bh=E0axDY/jva
    qF2Q9PFqMXorU3u+/Wul/TYIz4yhShMgY=; b=rMw4WlATYm6Zp7KSNg+dENW9xH
    MtKT+gZa3OSDCBn0pfpolEJ1Fz7XbJh8jCZAMAc/XGC6mLAZZj9Ywmu5EREG+huh
    IPy/78EgCBIgU/P71gy2JqEna+TuQJOZdYAQCeVWXgAxraVbfqIRYLBBgfH1UKMP
    YOOjoZWuszrq4w4bbfiaO09xvFFoB/sarvcd+PPMspx4UF7WOCMiHimiX2DoXJRa
    8J/VpeFc7bgpB3om1tC6hQtaCJpnSJ1agDoZ9PoFWjugI5njoC/6hCEEUFvRf5Ap
    OpkAH8hD5vlkxf+6seYFkphqM8HfCjm+7TH/pNcZgME00/grH6Yqe+xAJznQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H/ijBaC+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H/ijBaC+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHqcoxPCFTP68nwfVo+4Q1dUhlWO3qx0ykS3Uhpxc/DbkQykhH0kKFxeDBEPIvwiR3CxrkRvblqdcKR1R4FeTY6wngCr3ucJUZJFmd8lZGU+UU68FEnq
    5Vc0E6xr8rd+MaHL36iRioYiqn6qg5b0WHZCsCyMUZs/K1/iSK8huamK6/4bEakzn4rS/4aX5ivPezK7llwUVbgg451iHD/2Ms8ctC5RglKcaNFZM8mLhASG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=WbdEzcPt15Yk3ZsB5OIA:9
    a=qUAhAXJI77HiJuwZ:21 a=9Cen-JY9-J5teqvO:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932839AbeDIAhs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:48 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932823AbeDIAhq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 098/162] powerpc/perf/hv-24x7: Fix off-by-one
 error in request_buffer check
Thread-Topic: [PATCH AUTOSEL for 4.4 098/162] powerpc/perf/hv-24x7: Fix
 off-by-one error in request_buffer check
Thread-Index: AQHTz5m/pWiV1HL4yEeMbOiFqc9YDQ==
Date: Mon, 9 Apr 2018 00:28:56 +0000
Message-ID: <20180409002738.163941-98-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:V6+a7tdPWRLwtQveGLshGDjQ3KEz1lNXsHOxvYcpPTtMcSaVfBFUbJla44tzs1S51BnSOZxMAVxLmal8DNgLX4cjZYpagc2rhwSkbMGAbnmQ2H+DeMkC4YNOqeAcyIfvjrUzmiSTmm9T+pb413YrBEgpXM/vIDswkPpZPEn7lo0fh3CrTUsPPWZcS0uuhvSVY9kc0yZoHdnqXM27tLT8TLi6B9cT7npec7DswKZznJ+USJI7YPQzdEmXcFwjNuaL;20:2BcgOqlrR+qh4vOGfw/e0tD+2UE69OVB8lKQ5jkh/LVpfyhbXHiMpoxFXT3psh+nly1YZK3iawN8DA+0hprahesdE0i4b0KLdzD5hADznq2QCvGrcc2b5PxsSl8TRM43ZDfKNhYxo5vnuxxlAoOou0F9Nwn9SN+c9bH5VwR3VZs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a6614d5-90ab-4fe6-f2a5-08d59db21b33
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031FA7DFBE43EA329BFC4A4FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GufQSjtJJIjerPCJmuqPvLXA6tdXsJ+wHWt6VXSgGITITV1/Gx6zUwHX6MGgv/ELp/wq6whfEz2VjWDff8wP9WHSdHezK92Y9q07ITKac19HAdIUu2DTc97Lq/4erKeDGopb/57/Xvdxk0KVCKLlRnPCuRjDYA6JQ979aiCOwqVH82TYaNwIMBHv1SS/bGUklcsL7emrORebkvkiG4UfpCsUBe2RbbOuIbxVJoQbBosBlaPW0vvNmQMHL3xAhQ/EYtXz6AOAxoA1e8USTGiMU1PsxIf5o7Iu9dKhAqV+oIH6hC5v5wJmn5mUmri4fyjhCX8cZlGgxp2WZ5N4eOn7fldYRd/DIX8aT2CBFXQFlTZBkBzlcaugkgW0EkdnFLphmaLX4ytmwU+6z9gMimqb7zswWoqmqT1wIpTHZbhKQyM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6614d5-90ab-4fe6-f2a5-08d59db21b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:56.7553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

[ Upstream commit 36c8fb2c616d9373758b155d9723774353067a87 ]

request_buffer can hold 254 requests, so if it already has that number of
entries we can't add a new one.

Also, define constant to show where the number comes from.

Fixes: e3ee15dc5d19 ("powerpc/perf/hv-24x7: Define add_event_to_24x7_reques=
t()")
Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/perf/hv-24x7.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index e267f4c3e51d..8e80882d8f6d 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -160,6 +160,10 @@ DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
 DEFINE_PER_CPU(char, hv_24x7_reqb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096)=
;
 DEFINE_PER_CPU(char, hv_24x7_resb[H24x7_DATA_BUFFER_SIZE]) __aligned(4096)=
;
=20
+#define MAX_NUM_REQUESTS	((H24x7_DATA_BUFFER_SIZE -		       \
+					sizeof(struct hv_24x7_request_buffer)) \
+					/ sizeof(struct hv_24x7_request))
+
 static char *event_name(struct hv_24x7_event_data *ev, int *len)
 {
 	*len =3D be16_to_cpu(ev->event_name_len) - 2;
@@ -1083,7 +1087,7 @@ static int add_event_to_24x7_request(struct perf_even=
t *event,
 	int i;
 	struct hv_24x7_request *req;
=20
-	if (request_buffer->num_requests > 254) {
+	if (request_buffer->num_requests >=3D MAX_NUM_REQUESTS) {
 		pr_devel("Too many requests for 24x7 HCALL %d\n",
 				request_buffer->num_requests);
 		return -EINVAL;
--=20
2.15.1
