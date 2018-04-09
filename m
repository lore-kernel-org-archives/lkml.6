Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236903-2-11752903287401838617
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
    1523236902; b=hYEwdB7Jck4bgJkTmWVgqhbuzDivxZHUaTHeZGzrcUNIWNFvNH
    FiYPX6lOHGoxeWxTCu1LYGm0U4lsSEsi6l+SjiW5Z29SCtZ4imh1whobw5x8+24p
    i16iNgwZRFlJcqEFL9jU+QWCAT9TCeF2aZHTdjygU0aM1ScRnV+Xwf2yIDgMQLdB
    MJCahUzfFs0sTXHTMeumKVhKW/lssERRx61k/DthVtgy90EeLmbgIS6HWiOQpSBr
    Oci2hB4kBTNFLbkfeA0TYXy0TCwCUQ29XFt87J/vfb8jC4ZXbqCbNt5rf/z6LETb
    JZ/v86Dt+6QuHpCXSHXnzCSo4vokcEjYhQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236902; bh=7qJW/yIGwc
    HOK1kweyKsSfSaYEvSs9k2OsCOVArFgSE=; b=EzNb3iWi9gprk8LvD10y6MMRRp
    EqS6pxrcPdOsPZzXUw2j6yMKBmQWDfD0oX7CRhYMV3aRz6MKg7CRQlq6usHVlVO4
    /DgYwB7/wnlAm6NmLmbUgl5cXC3yUDVMxXUzzQ1lcZyBT2ZYn8qCECRDlnm7o9UD
    22g4fCb0jVumPdOuwP7t7rfADAChjtG8gzeiqOnPlxr7Yn6rNEvoDnI0FlJYeZWe
    HxYrG0UuVklPL11MDeDoMqta1rEu7lW8nhWV/UT1Q20g0dL6+sbjhlBcfYM6O1y2
    l8kC1F48Aef0vOqX+E5NMAiex3jEYq8qMKLEmMHKugkAzubzHtryw4+iCNCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J5ilVsxW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J5ilVsxW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLCtWarGKT3uGKeJAIA+EU7EMV0L1MOmardg6LQAK6YH+7D0SoGQE04T+aAT61xY4r4LagMkqmRrNYhb1vKyAc/DnEqven9gxNbVb0o+2WH70nZrcNbm
    /5TgKgK6ILIL5lSjbquP/cDbi30O1EhUqy+yRVJH17zpDRRukRMgugPJe9GTjIHaVW3hzKpwDmocGOOrpd0s9EBx+v1QlCD//71CJB7IWkNh+4xuVKx8mycc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=X8tl4U4nn9uvCpgtE2IA:9 a=wPNLvfGTeEIA:10
    a=t8nPyN_e6usw4ciXM-Pk:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755803AbeDIBVL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:21:11 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932757AbeDIAhK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Goran Ferenc <goran.ferenc@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 086/162] MIPS: VDSO: Fix conversions in
 do_monotonic()/do_monotonic_coarse()
Thread-Topic: [PATCH AUTOSEL for 4.4 086/162] MIPS: VDSO: Fix conversions in
 do_monotonic()/do_monotonic_coarse()
Thread-Index: AQHTz5m5YFd8LuNn7UOsfh2ttKDoxg==
Date: Mon, 9 Apr 2018 00:28:46 +0000
Message-ID: <20180409002738.163941-86-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:Wk0UcKDUXf2NrkU8+T1lSdtPIgTEZr+pxBwV28r249fivuehbE0ijIp294U8USNa1dM62NhprPPd/uqoV1/fkQUB4tHmYmfqP8wPpzviYx0wtTE/GmApqHchbmu/Na7ApCqXXu3Ulx9mkPJlgjtD/QNH/4cDzl3mP5Bd9eTXSWiziAhRMQVZI/pPMst+cXylwxq91yYMlrwpihmlQPWrfJ+suGdnUS2IbXDqkeis09NLXrPqWYn+RdpjWB+p8qeJ;20:WLeweGt1wgCyY88EdJ2aSoDpDc0aO95wh1xxFr2CsNWpqTqQOj3kyXW/rKff5OQ+FLG8wOVEitky9/IhgX3f+klUx4jOGcQ51HI9i1Bt92FyoAIZgQEE68LZIxZui1Y9wphuPfdCfhdkVLfsuFP/w5nCIOwkyRdKsKOKe0dIJlQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f802f542-8350-4a27-ba7b-08d59db204f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10315C030260A08BCA6D003EFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(377424004)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(7416002)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2/twVTYnqjQmkpaJUtdS/z1tJUuqn7TouiyEny519hbpqRmqC+NkriR+WmCtAPH6VpzjKiTcLWVlLSlbJ49JQbU0k1a5HJ9jgSdt/Rk0K3f9Xh+YjpSPChtKEtAv3VbQN7txw30UG0sf0+FeD/dp2rJf7oMfS0tEMyOhUhBln0VI96UxUuEk+Q3KNqiprHXlD9IL7bb4EMw23E3tGmLfb/xTVsuXMtnNONIvxg/xXneS+qRTQGkm7QMhDfXeJU4WrIol9RQnn3ITfHfW7snZNCxU8Kcr/W0sxyrAqcdXN4w46Np3xk1bAghfR2bLZLJNEpRZ4WK32myj5Dgj32jiuPWIFNLYkfJfqhFi4kKhbn34+beFo91NcOjYVFDVlG1u9K/V7nZMZ8cekq48oBLM3+QfEUyY2Jq2NLYU4phbV58=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f802f542-8350-4a27-ba7b-08d59db204f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:46.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Goran Ferenc <goran.ferenc@imgtec.com>

[ Upstream commit 8ec7f15b8cca4f790df5cdf33f26e2926d4ee2fd ]

Fix incorrect calculation in do_monotonic() and do_monotonic_coarse()
function that in turn caused incorrect values returned by the vdso
version of system call clock_gettime() on mips64 if its system clock
ID parameter was CLOCK_MONOTONIC or CLOCK_MONOTONIC_COARSE.

Consider these variables and their types on mips32 and mips64:

tk->wall_to_monotonic.tv_sec  s64, s64   (kernel/vdso.c)
vdso_data.wall_to_mono_sec    u32, u32   (kernel/vdso.c)
to_mono_sec                   u32, u32   (vdso/gettimeofday.c)
ts->tv_sec                    s32, s64   (vdso/gettimeofday.c)

For mips64 case, u32 vdso_data.wall_to_mono_sec variable is updated
from the 64-bit signed variable tk->wall_to_monotonic.tv_sec
(kernel/vdso.c:76) which is a negative number holding the time passed
from 1970-01-01 to the time boot started. This 64-bit signed value is
currently around 47+ years, in seconds. For instance, let this value
be:

-1489757461

or

11111111111111111111111111111111 10100111001101000001101011101011

By updating 32-bit vdso_data.wall_to_mono_sec variable, we lose upper
32 bits (signed 1's).

to_mono_sec variable is a parameter of do_monotonic() and
do_monotonic_coarse() functions which holds vdso_data.wall_to_mono_sec
value. Its value needs to be added (or subtracted considering it holds
negative value from the tk->wall_to_monotonic.tv_sec) to the current
time passed from 1970-01-01 (ts->tv_sec), which is again something like
47+ years, but increased by the time passed from the boot to the
current time. ts->tv_sec is 32-bit long in case of 32-bit architecture
and 64-bit long in case of 64-bit architecture. Consider the update of
ts->tv_sec (vdso/gettimeofday.c:55 & 167):

ts->tv_sec +=3D to_mono_sec;

mips32 case: This update will be performed correctly, since both
ts->tv_sec and to_mono_sec are 32-bit long and the sign in to_mono_sec
is preserved. Implicit conversion from u32 to s32 will be done
correctly.

mips64 case: This update will be wrong, since the implicit conversion
will not be done correctly. The reason is that the conversion will be
from u32 to s64. This is because to_mono_sec is 32-bit long for both
mips32 and mips64 cases and s64..33 bits of converted to_mono_sec
variable will be zeros.

So, in order to make MIPS64 implementation work properly for
MONOTONIC and MONOTONIC_COARSE clock ids on mips64, the size of
wall_to_mono_sec variable in mips_vdso_data union and respective
parameters in do_monotonic() and do_monotonic_coarse() functions
should be changed from u32 to u64. Because of consistency, this
size change from u32 and u64 is also done for wall_to_mono_nsec
variable and corresponding function parameters.

As far as similar situations for other architectures are concerned,
let's take a look at arm. Arm has two distinct vdso_data structures
for 32-bit & 64-bit cases, and arm's wall_to_mono_sec and
wall_to_mono_nsec are u32 for 32-bit and u64 for 64-bit cases.
On the other hand, MIPS has only one structure (mips_vdso_data),
hence the need for changing the size of above mentioned parameters.

Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: Douglas Leung <douglas.leung@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
Cc: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/16638/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/vdso.h  | 4 ++--
 arch/mips/vdso/gettimeofday.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index 8f4ca5dd992b..b7cd6cf77b83 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -79,8 +79,8 @@ union mips_vdso_data {
 	struct {
 		u64 xtime_sec;
 		u64 xtime_nsec;
-		u32 wall_to_mono_sec;
-		u32 wall_to_mono_nsec;
+		u64 wall_to_mono_sec;
+		u64 wall_to_mono_nsec;
 		u32 seq_count;
 		u32 cs_shift;
 		u8 clock_mode;
diff --git a/arch/mips/vdso/gettimeofday.c b/arch/mips/vdso/gettimeofday.c
index ce89c9e294f9..fd7d433970bf 100644
--- a/arch/mips/vdso/gettimeofday.c
+++ b/arch/mips/vdso/gettimeofday.c
@@ -39,8 +39,8 @@ static __always_inline int do_monotonic_coarse(struct tim=
espec *ts,
 					       const union mips_vdso_data *data)
 {
 	u32 start_seq;
-	u32 to_mono_sec;
-	u32 to_mono_nsec;
+	u64 to_mono_sec;
+	u64 to_mono_nsec;
=20
 	do {
 		start_seq =3D vdso_data_read_begin(data);
@@ -148,8 +148,8 @@ static __always_inline int do_monotonic(struct timespec=
 *ts,
 {
 	u32 start_seq;
 	u64 ns;
-	u32 to_mono_sec;
-	u32 to_mono_nsec;
+	u64 to_mono_sec;
+	u64 to_mono_nsec;
=20
 	do {
 		start_seq =3D vdso_data_read_begin(data);
--=20
2.15.1
