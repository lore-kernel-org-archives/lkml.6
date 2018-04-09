Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243765-2-3710148232011018997
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
    1523243764; b=PX8PXjlVLWfJKTrxjgLsp7jiFxncPjbLRxgpM8Rs/sO+D7w3OZ
    /38Azi2fSsX2a1wCwcsY3xYEBA6et4BEd+GWvlp9rHxehiwgdG5AgQ/xJXxFyUKG
    587yROdDdl2g/jOAkEU+LqpmwClyLxPPTO1K5IgifX7bZpibSPqunq6PT+VVmeo0
    6dDbKjKqNJxPXlQ5H8Ra85XhNX9YVmDJ6nfdZua99QELfJpt9j0B7Pmmc0/z5DiZ
    2f1Tq0EAxBxW1e3NJeAFKzPOCLs63vVsQQtSXr9gnTiq6J/8p5FF0cQ3dUGbCVFd
    Emu4JO13jYmqGoXSImrAhtDsqW/kVEtSGBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243764; bh=auDUzu2A1+
    Q1EPnzBc/Ut3+v2gKFBvC+XIkihtGDw6c=; b=cssT19cPlm6fEr3qDRg73Ho26o
    SPApXl4l7WGsxlr4naD8Arkxzhc3cabSPE0ovTv85fIYkcStQ9LYs7HnSkTdBwBS
    XvfpIQZwHtdTk/CeE6b62uzg3rLb6n6SYPID+ndt0OtIvWfZoMK2xgRpfxlUjPLR
    Lhiau6DUy9t7LZzHYLmhS6RkboOgS4bb6pALqqCRN5b522Lr/PVC1zWjVSJkwGZp
    DewGdUUrGIwvjqzx4XL1I9pKG1frFZbftDbQxjKJ+UCUNdHoBiVnwT4FwOQt9lZL
    1DKDmKgYmfVQQVXQPIO0FxPWXvbB6zW4AGMozJ1io5Xze1QDElbfN5qnO/sg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eKkCqQS3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eKkCqQS3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKPr19IvJxnMzfhcQ9NTcHCKfgYktIYXeagQ8PWFkw7aus45o/rpZqE6Ly/Ox7ZgjsPdL0Y6wDwA/rYcWa7/6OdV8guYmhA+Hidw8/rzbC+heV0StUPH
    oSIu1CGP7TEGfDOcfkkS1/yIX47TfkFkMzBfTANuSd8Q/vxAwsSPW3ES10qOfWba2ZWIsgVRfGMHcMDh6Rcyw03hLvUYhZnpffRvF5atzaJ/tUANf91OJPTz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=K6fn2rewBBjh1KMvdOcA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeDIAXo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:44 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753655AbeDIAXk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 062/161] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Topic: [PATCH AUTOSEL for 4.14 062/161] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Index: AQHTz5iVvXl/C3I73E+j9RFbje+woQ==
Date: Mon, 9 Apr 2018 00:20:36 +0000
Message-ID: <20180409001936.162706-62-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:Az15l7O941mJ/8ClAoZBmOu2avd8ytECKFXC4sRMki8w1kynYBxCXEP5lzGxULupe20IaXi/JFSGIb+/eHakfTo0Lzbjsx8Ogm7EG9YXNUYyzwBmPsSkWWK7uCBdKKPy73sWNVGOO1E6Blbuh6n4A3xE/X1lDzY+NTr/IZZVcKVGI/eLOSJIxCE9RGZcQigbClcjx/Ew29lvLWgXyqigA/w0rIcVJ5uLaxwY9+K9AJoFyLpi03Bmxwj04hQUHXtZ;20:2i29dQVv++ebTyJyRh9V3Fj8/ZO4LXO6lCK16T16MkBFcqnoKDirxe42eOqsIqUdvp0j6HkWOHfV9sdpHGHI8yGtaPqK6XnJJHSiE8/So1hqFg9qMDE/LmfpZ+7KYoXCBBs4x6OWIQvHp7jNY8f9JLg1oLU1d4IJu2XnosCu3z0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fde5d2c-37d9-445a-1c5d-08d59db0233f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080EC18CEC38C4E334C9156FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0rxj11Do5D5al0uL83CoCL9YG3mBnJVSaIs4OJBAG02+0QHrrrUBDZ7JTsSu12Ygf+O3kIT97GtP4tySx4/kJQ4n0x+sWSocluaJ8GyaCToslgBzJSo3DadSVTuMZFctpuphOhdb3MQfzXyQdpD6IgxXycvVhuhceu3JTZM877wl/oc3zx9MutUxLBkx9yleyzYycfAZhzaxKpn61rVAtV4WUpDVfcppZ6dK2zliLuT90R4/Dp0XoVX7r3nbnSp1yIly25s7gNcyqpb7F81pTp/GGNY5XZzv9OKHypTr/eiRzfgOIqsYqMIrEsG6ntKyFAaoLYnoYy/f/uUYA/7BT6hi0f3nDkC2/oRtcV+BASMf7A1AcO8bU5+NwqkmXmG5vxthmrcyG7JjfUJp9RywRmrpp9IHEWD4g+OWaYy5Rs8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fde5d2c-37d9-445a-1c5d-08d59db0233f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:36.7379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7ad81482cad67cbe1ec808490d1ddfc420c42008 ]

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kov=
aplus.c
index 43617fb28b87..317c9c2c0a7c 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >=3D ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile =3D new_profile_index;
 	kovaplus->actual_cpi =3D kovaplus->profile_settings[new_profile_index].cp=
i_startup_level;
 	kovaplus->actual_x_sensitivity =3D kovaplus->profile_settings[new_profile=
_index].sensitivity_x;
--=20
2.15.1
