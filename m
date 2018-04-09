Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523233938-2-5344165918801947753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233937; b=e63o6vlcw8gXlfL32kwXxIXBXdkWEI291YoLLAozTL3jlwb05O
    dJK4N5qo3ZgJLAlODzfi7WbUIU/TQQR7wxg88VN2q8yr6mXtDEzt2mLkm58pDLtJ
    FG2w16lpk9K/EiHherXj268a0yQhWXMZmnIEbIhmEmM49/IZhVJ3NAHrLtyyxLMk
    WSLkV3foQfZjWkEl1XEbC8MqBj07wIwBqGWbCCptllMc/wp2PgYbMCUOmsAUUvYa
    4NGyBbvpvAuTd9RTVixptNc2yTQP8sfdZLwoBituMySLg7U25HQaKU8rkkVmYeQl
    2oOypp8Fwnsbly8IAtc02mCPxzWap/T0l/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233937; bh=9C791992Og
    CPWpWMPwqr3g+O6JZUao+IoG0Od02ZA1g=; b=fHvAmMJV+6Knev/OJKCQ71A2ON
    dmeUomya+lbTJhv0ZlfCv8qg2+bGcfqMP8kyI8HFVd7gG7WOBusq2IjeDwb3fi5k
    miBTJ4fe1BfaWh5gBUrgtb47xkzdDuw627DCXWHTVyoyV1zw1Ep4qc0tssF6feCZ
    iqDNzhKvklINm7fm0YJ/iTjXYr1cey8ymesCcmlEkbvq+ezPXNRfHNWRFeBb7oFx
    WT2Yo7j90/pDnS5cO49PMg0ID4xjE4XaquOIJ5rw73d8b6oI97s1hEt1hdexximk
    x9VpqL1ZRms92cesY2w6D02XRKUFtAQmOrUSCJmIJGFwWLRDcrH75J9vjEJQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c23lzkE8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c23lzkE8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDM1bMeKWU6tDGe2J26mkahwkrOT1lJwX6VMtrgLAnDbGwcA/J172fpj3gFZ82rXRarigw3r+kLUeqbLwEbmxOlUPW7ONv/azaO766KjbLxPD78+8lpY
    Rlbb3cQ25Ny2W5ZSIPRmAOFCXrqr0/Cex9C1JROcVTnRlnoLYLRUEJKh9riQgidk0+I2Iw4RdH8/+r1bv7snKt1DhT6wFVJG+Qn9f6fLUq/5ZyxfrQIKG8vA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=WbdEzcPt15Yk3ZsB5OIA:9
    a=qUAhAXJI77HiJuwZ:21 a=9Cen-JY9-J5teqvO:21 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756439AbeDIAcK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:10 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756413AbeDIAcH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 195/293] powerpc/perf/hv-24x7: Fix off-by-one
 error in request_buffer check
Thread-Topic: [PATCH AUTOSEL for 4.9 195/293] powerpc/perf/hv-24x7: Fix
 off-by-one error in request_buffer check
Thread-Index: AQHTz5lBPAh1Q+LS2US5Ki4v92fbtg==
Date: Mon, 9 Apr 2018 00:25:26 +0000
Message-ID: <20180409002239.163177-195-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:J9769E28BJ/u1tMMQWwgAufRwM8tjciv9lmqWAXusBAg8qAxHB1vCeNtSd/1MXfL5NquVRHl1dnu/Qls40zvIUyuWD01oir57Od0cQv39j8mwSTHgEy0JkfbK3qfv+hCv2zlmHsIWWhh+dss7newUReMtLHYP0KBBEeJSf+hTDL7WvZ8c2xuMrUCoK2p+283dm6MpR5IV0bI/qbwCZMxVphGUpmax8g1XO8gewgMN7nbNvI/yakXGea0jEl+AtcL;20:KECM8bLvbGSP4wiZQmcXNjx2RVyu1AFBWzL1ZsbAnyi+w6zMzUiCW7Kr8eu6adn+UdhBEAGtlqhH/R4T+kAj3I4vyC0aE4rnAlflLv1IGOGy/uwOja9M/F8PJG7+RCuCvKPV8FC0qHS6wlxWQ5ixpQaA1e3FJUIFEMAzXqXSTjA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32adcc6f-7992-48c8-2ca0-08d59db151b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087066988BC76538783624CBFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NW6x9VErKczmv8U71EnWnpe9uMaLAFBpjS0nHSqrtLqsVaEN5wxH5++m/ck/XkU2KT0onozeOH576zvgW864Pk1uy3ZzuKSG84kXTSpJYHklaBCxcSfufz8hN3q5Rn2r489EdRnlmxeRXGSkMRjuPcS/CuSlkNCvAWF8TxhtNAsH0gW82Qkno+Ldkf8M6MRkxOYhOwtRTZGSEM9c2QCzPdNzCEVAYW0IIK18cmprUy2RZTxHH0gIUbyR+GUbIUKW4VpumBfeKuQ7Am/uFlI5TakwF/+ie67gIhGfLMMxyLxPIrsTyEcTNqv3RmsXtU/T4Rtj1dQTlv3vk9L73S7daZ28JC5zAumCVPPCo5DPXa0zwJw5BlkFaz1rOH7nDOyD8kDjvFgCg4NV2UcrY3VAdoqijs2lOw6B7/Jcs/iAb3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32adcc6f-7992-48c8-2ca0-08d59db151b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:26.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index 13cea4e8c56d..9fc2be138e32 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -166,6 +166,10 @@ DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
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
@@ -1107,7 +1111,7 @@ static int add_event_to_24x7_request(struct perf_even=
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
