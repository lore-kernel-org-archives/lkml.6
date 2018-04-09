Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523244463-2-14511436020597317611
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
    1523244462; b=PsqRuvBh76t3Ft9pCWW61DFEAj5nJBsxrm6azCkIi6oRggnrsO
    G/ziUh46pI2gpcKMfoB5UU2yM4hLi8kOep7OdxHYme3B5X6U6WJIGdKtf0WebwrR
    DmvAVLQYmWhkg0BYrV05uVK3CfybiNSMiZkHBzQiu5Jdlf4yL5VkmLieyF3DjYCa
    h9D9CGixsSlf/1MpeZDAclyG7S1/hyRi8Lq71Jncism/6QNpMTchQXf5bDQ5W+qf
    /FEH6vaiO5PoOGl8yPLumWJVP273g2lFQ4MrJIVtXENRgz56++xJI/TC/ALJ3kEP
    9E6h4WGFff8BnqpXP1RIo/gqksHYMb+l/fnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244462; bh=94rIDVm4Tm
    hiU7MtYukdxLFzyofvmvYPiKd6WlrmWm0=; b=YeO7Vw2+9iuj/Gt+OPdb3gY5Vv
    xBX4pb0mW1HHx8Jwn9XRaTxG9sBjKfbWTm4eGnTdTg+buK00B5mfy3EXoAopmuj5
    QpEpqyNjKislVCR7zfX1Ot6cOg3MZD6evux0bXL/DL8bAphAzZbmHJv9cX4EIpC6
    T59PPu5sjW+0amkE6OZif0usAajLE/NE/hZ59TwyXIhv/J4hEhHFpetclnz8wDwi
    LsSASJedX7gtqkre149Dk20etfeoi1YuC2aGTSYbqlSBFKGbQ2oB/c1NtGyXV8ms
    VjcHML93AHHrNfFSorTO8F2lKtn95aJ5r1ZNffFM2dCrtLc3a+h5StkNw5FA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PyhZcGap x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PyhZcGap x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDgXsxmDovh+zmfrLGclH+bu80INMCjSz5F1Vg3FMJEn7x59vBCZTndibhwufDk2w6OKUNV3hPdHYZhKlcLLyc8iX7b8cqAvMAuLmvzUK2Hu/7K7tuvR
    aqTKAc0lvJTG407NNQmyFTf4E904eH6EZRzNlz/zG7aIuwwZbVhffx4kXZFfCx1Feha+9KnwT1hkOLCqVhvyXzhl9AIi0PSAwvSfwABuvKr78khX2JhUTEbn
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=meVymXHHAAAA:8
    a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=txkOq09wrb2B0RYtGNkA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeDID1b (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:27:31 -0400
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:20813
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754617AbeDIAWH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 016/161] selftest: ftrace: Fix to pick text
 symbols for kprobes
Thread-Topic: [PATCH AUTOSEL for 4.14 016/161] selftest: ftrace: Fix to pick
 text symbols for kprobes
Thread-Index: AQHTz5h7Sz8myaZ1+UeLa7qb/SN4jw==
Date: Mon, 9 Apr 2018 00:19:54 +0000
Message-ID: <20180409001936.162706-16-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:fODtCZZLy944M+OcDLO+Rl7SuVK5e8ZuFFHM2U+TTYS7Gyk+DdtlX5H6xNf3IQrUV3Nq8XWZWwWIcF7HrgWQn9/juqPAG7u/jwG0ftvZ/pmVDQjsJX/3v7UlPIvJSgr9by3+CdoyK1Ak32VbmSUjsonKuzVPdjL0A8vmctfoBe/xG0eA/SstEdCVtd0+cr6YXprkHZVwaJ3AVVSCgmvTBN/Butv2W1j2L337p7xV+CLHxniinj6nbcBI6t+c9Bjo;20:pc5yQsthZyEzv4EfW9ZrbCHZEuWGOKj6IFntvF1SGFIRZkp5OZap9uXVC0RJyTM3wNRsWcB8CNa1QxTdva9vHpQscgSpQarIEvsnGb2UGR9ILBNTwACPYMiG6UzxJm8uDYD4+7Mn+v5dlX0Tp47CLvUJHiDuSuapE2HIDKoIxVk=
X-MS-Office365-Filtering-Correlation-Id: 663a641b-82a1-4c1f-7b40-08d59dafec21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125C69AE79A477C363C6121FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: T5bp1p41t1vd7rjA5OWQqT52bwAugWQk9eftKAJId6X0+1C5OVHrmV6dDs4JIzsjl/hUXA6UX9XVbQjxotKI6IqhzxfV7wlUkCIBFbJhpvUtJP0LzQfNu1rY6Uzy3YW9lf5GXecIy/vzj/1Kr0Mluai3DJuT/QFeVdagLAuicNRMW4w5/8GYN8CtPE7pp80WodPNx2wl9pSVQSTyr/SOl4X6d1KowfdDyZBxcW9nXTlNL4ZRzB2Eo5xkEPi2GA7hDvtLMIvr9qN5KPCW5Zpi2N+zqpSCuhlxZ4nH/ASJDT3++E9SS5fSqfAtz4VokeX9QNvGC+NAEpfO/VS6pvcOpHJc5KF2h81e3wj5XparrSgw58QSsBY5KN6dShXuO73713Ln4CFZ42VdZkeIVjklH+Qjq+Ixv1RRtjR09lPVkNk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663a641b-82a1-4c1f-7b40-08d59dafec21
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:54.6606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 5e46664703b364434a2cbda3e6988fc24ae0ced5 ]

Fix to pick text symbols for multiple kprobe testcase.
kallsyms shows text symbols with " t " or " T " but
current testcase picks all symbols including "t",
so it picks data symbols if it includes 't' (e.g. "str").

This fixes it to find symbol lines with " t " or " T "
(including spaces).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Russell King <linux@armlinux.org.uk>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.=
tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index bb16cf91f1b5..e297bd7a2e79 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -12,8 +12,8 @@ case `uname -m` in
   *) OFFS=3D0;;
 esac
=20
-echo "Setup up to 256 kprobes"
-grep t /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
+echo "Setup up kprobes on first 256 text symbols"
+grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
 head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_events =
||:
=20
 echo 1 > events/kprobes/enable
--=20
2.15.1
