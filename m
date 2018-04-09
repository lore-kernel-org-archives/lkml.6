Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236574-3-16584207401377084252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236574; b=XhI1NkKOPz7gaqdB8wf4pGjdn/wAt4XR+L3EV1pp5q4JLKfems
    J2lvipk93gb21/nRKVtJcNr2Dt0gp2ebmlfw3gq9SwlwiAQ12TinqlQpBoagQ1Cc
    zLNjCTwS8dj4cdKRmFaipy7/597WSyMm47nXJFWIH9iW4GVLlFBgqLOWWsj+aFtz
    O7h1O3QMEn3KK72DeAVCHI8VKScZRx5jDOsA44GN7Oi11CfwCExbEGv2aYGiTQm6
    vdBX38Bm5KPvZG5Dra9WB6sBJsvNdZ8h9FJYKfO2Dgdl+6ZNryoRAyUfa97SdkGo
    EiKwUDrynZGp2IHasyHMVAKyDbJUehPOGzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236574; bh=zV8a/dUHWy
    4g+S01k/YOl/pwoYdrJFEFAKyLDqsiwos=; b=BIjNG2O2rfR9GHOLDKunj4OIDx
    98/wWKoIm5BnsN9wdP2mkVP4/UHb8bYRDSfRac977JIBy5gFKXZf93hIqkIZAZNI
    eBy74fyl2FvLTtViw7kMwdhwP6+vrLFl+cF70zf2FmYOcM4q4P+ToWg4KpqSvsNu
    3XY/pvULOt92eV/jDXzkEhUvv7dsYz/KdwFASeeXFmtIDvy+eByB6Z7Dv1zBW/NS
    44mxVTJRn5gKP8J/SHMwFRABkA9JCCsrE4lLoVmx9wDz+aXzfdcFL2O5tJlqf5o2
    SiMt8s5kM8NHira8KzyigDqpGuB3RDAS+Rh95UdpMkFFUVRX7lKsNfRF17OA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EHrn4cUu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EHrn4cUu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHLZohiUw5l2RyfCqexZZE8D1xYnXZGVXdfIAzpV+FTQ2q+MVLER52hhknYK/bsX8JJouGyRnTDwvNQZ/NeZrkmUSiQoM6q7s4zQu7fr9e23TDh/PJxt
    JTisKPEQ1ANGLar+A46QWE568bJtqPCzcC3H64kx8j4FeD+86HFc60bUq8K6U3u3va1AVKahNSFiHUR+reGuUFtzFYD3w1rr+zwD9YAoe/uiTnTZe6Nx91lq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=OLL_FvSJAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=xZ-MdF6L0uY4eguhJAMA:9 a=wPNLvfGTeEIA:10
    a=w64Ph-BE0T8A:10 a=iAXQAx-9ccsA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oIrB72frpwYPwTMnlWqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbeDIBPn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:15:43 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932876AbeDIAhy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 111/162] PCI: Add function 1 DMA alias quirk
 for Marvell 9128
Thread-Topic: [PATCH AUTOSEL for 4.4 111/162] PCI: Add function 1 DMA alias
 quirk for Marvell 9128
Thread-Index: AQHTz5nGhAT7YyfixUi/4/hsy11sJg==
Date: Mon, 9 Apr 2018 00:29:10 +0000
Message-ID: <20180409002738.163941-111-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:fzXnOS8k52rDkS+ejz7w7YBXfUCxyQo2NG7tiacSV8ujLXTr+qHaSPHNtCW8Z9DmnQzCJ97NPjJa2/SHN6+CiHSeUXAHcBc32CR667tAWOO3u9Iz4TQK58yD5571aNkayy1OvOLBBwfVz0bjss51umIKwR4xH32XgcF43bMKBVwEePV/ZCR3bY2H+hQYUfsmfQTKQXHIhY60QwpAY8MspHfE0RFvDJ4FNBIYCwQwGZELiB6j98MuG/m8TmK+avtn;20:NY0UQKV0Rflgv5OLlSZ6W1d4oHWhy4X5byr7JHOwnNYl9ofopuebwauN1vK4RAjeWaddGEh459YSeJhe67RC8/hU7XLWRDjw4S8SYXjAfhG064AryVWnTV6ySr/GW3/L7H4SX9PBKhFRe/BZricNjkQJdmQja+WTxCZZcbn3vfw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91d1c594-1e12-41ff-ae8d-08d59db21f5d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111059E96F5F904656062364FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(6306002)(186003)(5250100002)(105586002)(966005)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qd8KQyOBC5dr/7YutcN5plp8Y4AYk6P+Z3VVdBogotlJ4pYFtmD0uvjzTV6LhWOEEZotrJXKq5RzKpzvFwRgsGkAUaLNyy77Hgn44WDt1ldsaZpRrlLfAEmTbK+CNAPenSfEQ5GpeD7JdaTX6p0JrpmBQtnXfbYVdMUyvyGCJGEfbWw8mfrGlp5q3Z4kUTgyMA+9ez4wizIYNJRZhcyRX43IhkJBaUuZDx/1dqKGetlVuOmQujZ/h/eO6/wX3gxIyK8dd8IxyRRbcfR0ug/GzixQreTqFDTZJO8jUP7we1kQbgwLoLQbkSfi3KmpcfGnLaefJt1u4rY23RHhhJK8BhW8ayNUgnRXArNZmdIsQu/5NOZzBDiWQ6wsUB6rX7+H/t248/rvJf2Z6c4SAgFnzNnaMldrwnYSgFhxpeAdjMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d1c594-1e12-41ff-ae8d-08d59db21f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:10.0367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit aa008206634363ef800fbd5f0262016c9ff81dea ]

The Marvell 9128 is the original device generating bug 42679, from which
many other Marvell DMA alias quirks have been sourced, but we didn't have
positive confirmation of the fix on 9128 until now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
Link: https://www.spinics.net/lists/kvm/msg161459.html
Reported-by: Binarus <lists@binarus.de>
Tested-by: Binarus <lists@binarus.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ae6aa7b385c2..6373b6fe422d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3614,6 +3614,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0=
x9120,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
--=20
2.15.1
