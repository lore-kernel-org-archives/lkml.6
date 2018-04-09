Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523247007-2-9852365209206119016
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
    1523247006; b=tZds0JQXdQmZUXM3h9p7b5sdXGZ0vCb9xPiHv8kiF0s4IE4rcx
    X1uipYKgMWcR4eyFitsCisPIDmKykx87nwNG7tSg73rWzOvIvpS5Dpcl8FBR44DQ
    Tr4F5mZwjwSQy6sP3zr7wUYNcyMSDXkznrMThPTO4DGZN8pScYw686VnKdlWdr5H
    eWJdkkqEwtVhwMtW5UFOX1GmW6heymx59+r7h+ogWAaPu6x68RIab4olSXPgNuoH
    b1C3ZI2kHsb7a0S7Pyvde/HKjfhKHxWBlIs53Zoo9lOPWIbivvasMKyHI6hqFhI+
    ACdwsf4O4bbkauJN1ODKtvaQg5NBENMbzShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247006; bh=1eMbP53AQY
    dSX0Jm5PD3UOWH21KGytsTOBa67eHjOi4=; b=TD6S6p0HdTn0k8cG4ImOE/fkxi
    eSo9OpAPquvAYJesWvrhBOTJv+e+F/q0C2iwTnrwYMRyl04xTLQ3F9O9bikH7c5o
    0yfJb1+5K1Go/5sqQjkkpVdGIkeYKH22gx/WelucExKbz9QLp73M1ibLVwpHBsh3
    dHQa9TdEYyTu4UBJjwP14g41KWFFDVGtieaGwOV2jnQANFZVY2Vt6LT0eezUYv9Z
    bnZsd4Z7KPdkwhKGnb52yJVtZAHiVM1Fx+3mD+ZlMzdxn9yvmZWrj1xbU4d2dS1j
    oskj2+/E9gjw4wGVnoCozSrPdEuN5jIzVaJ9xSxeW+H3sPMZpO6GgPoDM3Ig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PoDfYyrV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PoDfYyrV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHVplhgd8kV6S6GXQKybfvs7FAgCcqO2rOHER49JxKCbCeG7S0fDJrejB/x7VD54pi/t7wnksWm94BIIZ/RZJhMzIEzLCNFGjMEjZNI6NcuAQAHUV9On
    r6U22lBfpiNXkCURBEYDS88NZmyI87O2QpVXYUY+N71dbIriBB3BJuHk1ILpyqb9iWjLdv2Cl6bCt00oz3xaAIx684qNGByByI0XFWZ4rxJ8WjHATSCGzUnf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=D31QgfloAAAA:8 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8
    a=yMhMjlubAAAA:8 a=cufhOiw6ZOseUkg5WgAA:9 a=wPNLvfGTeEIA:10
    a=I6paTPn9_Px6ARgSWtWf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeDIEIa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:08:30 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:48974
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753068AbeDIARJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Hutterer <peter.hutterer@who-t.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 024/189] Input: synaptics - reset the ABS_X/Y
 fuzz after initializing MT axes
Thread-Topic: [PATCH AUTOSEL for 4.15 024/189] Input: synaptics - reset the
 ABS_X/Y fuzz after initializing MT axes
Thread-Index: AQHTz5gWA08neQ0NqEy9YpA+Lz1XFg==
Date: Mon, 9 Apr 2018 00:17:04 +0000
Message-ID: <20180409001637.162453-24-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:T3t1LIVxt4ogQvEYnjPkM2GvVph7zEH24o7HxPg9dig8nuHJgAc7rgPEa7baN2Aa9e25kDRoljkNQr+82oe9lbaq6zDMA2gn9mHj1bPh59XM6cukLlBgsEXEJ2qRlDjx/V/hI/OB5xiWVtE2atdvCLLVk2J3/WDzMUWEGnnBhxsoYoxfGgVP9zA2bRWl8rFUIYFfnIQ/7I2XYaswLXNF/4MbYHhTevERlz6CgSLuTkbN6g43ojmfR94/Nxt+rwZC;20:uxvYFHODfCs/pk2ZVdgjXCSMiD7vofqwdJU5diYxT1Lrq+wRC5EQPvmldBTXgcnFwCL4JNjPsZq5pO00Gy7OOYHlErlmiel516uZlI5uaHjoBUPFSpGHwGdfzRRAc2niN0ArgvgNcPpJsElZKWh+GA+DagNaVwi8id1hFTrAtZY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84be3156-8d21-46d5-4b6e-08d59daf3957
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11270BD30759E64919DB2CF9FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(107886003)(486006)(39060400002)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ufvAdm1k5k7EKzLvYnNy0vvEZBH7fvGIkZ08OgC3vAQN271eCFcvVT8DaRLBGU6snTBqF9ZwFCdEp+tj7sB/Ld9ty5wbxmhObhHr7YM15BNBwox0w8l2skp/e3xNrBDWGdxDjVUc6wQX4FzkXw9/gswIkuz4AfgHxiqqv4fgCK8UeJ8Jv2W02Na4sM3hJBqcc2LZiucYAq2mmnEgBwbLJAJH4Px//sBmA7tVDFJIuDCN1mm/YQFUsqbg5kOVH8oytYGWkMb08HYclyIWZgTXS/ivlpiUYhrC48Wfz0cs8o59goZNt4hkzO6uYNERKvWxXpNqNS7t4+Te/hm8NyawF+a6q9aZHMXMGAGwxghzY99AatlMHoCPpKVIHfEHfLfGCw6vV3HGUm6+1OZhI3bNpc53PiFXZTP/RncqKNrV080=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84be3156-8d21-46d5-4b6e-08d59daf3957
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:04.8247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Hutterer <peter.hutterer@who-t.net>

[ Upstream commit 19eb4ed1141bd1096b9bc84ba9c4d03d5830c143 ]

input_mt_init_slots() resets the ABS_X/Y fuzz to 0 and expects the driver
to call input_mt_report_pointer_emulation(). That is based on the MT
position bits which are already defuzzed - hence a fuzz of 0.

In the case of synaptics semi-mt devices, we report the ABS_X/Y axes
manually.  This results in the MT position being defuzzed but the
single-touch emulation missing that defuzzing.

Work around this by re-initializing the ABS_X/Y axes after the MT axis to
get the same fuzz value back.

https://bugs.freedesktop.org/show_bug.cgi?id=3D104533

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/synaptics.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptic=
s.c
index ee5466a374bf..a246fc686bb7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1280,6 +1280,16 @@ static void set_input_params(struct psmouse *psmouse=
,
 				    INPUT_MT_POINTER |
 				    (cr48_profile_sensor ?
 					INPUT_MT_TRACK : INPUT_MT_SEMI_MT));
+
+		/*
+		 * For semi-mt devices we send ABS_X/Y ourselves instead of
+		 * input_mt_report_pointer_emulation. But
+		 * input_mt_init_slots() resets the fuzz to 0, leading to a
+		 * filtered ABS_MT_POSITION_X but an unfiltered ABS_X
+		 * position. Let's re-initialize ABS_X/Y here.
+		 */
+		if (!cr48_profile_sensor)
+			set_abs_position_params(dev, &priv->info, ABS_X, ABS_Y);
 	}
=20
 	if (SYN_CAP_PALMDETECT(info->capabilities))
--=20
2.15.1
