Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240627-2-12227441633300063731
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
    1523240626; b=DWwMrmm2AFlAp7wC+EimpNUHMJdv/RpyKw3yRBEZVYF1/FQ4Xl
    iYb6yHmiLIdx8DbPSUMepHhx9Yc49HXuWKVOHhD01ckXRKa4XN70wgsrx9CwqbZC
    5XJiKPeTYf6JDHuW3zGSxtdXHBq8pwUdjfJnzb8IkKuFpP5izztt53Oj0zkGTdNP
    FbLwy1IGlXSj+hNn4stGocWWKu+3jpd2CmAQUBK+R5c/p8fijWI3NlX7ARkDrLs9
    73suOZOaXK5jymtWHvNI/4eP0JNPUWTgrBdC8tRZD8s9QdInm4npdVJ2sCx8NiKt
    Lu2/XlG7mzV/VSRVD1GMtnAh4sjpywQSHcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240626; bh=XCQwH4ME/z
    eruJA/89ZUJSlZWRhBgrVxZQlIg3cokYg=; b=Ad7zpdwA3o9IkGt+kB3EiER1tL
    ZgpzIG5v4CpNJV0O3h5nBo+aGyOOQPcdT8n5u/tiwBXRR6sTfzR1m2TyMa5wGP9l
    h9HZecVniuxEitbkOoNxgL5hKf4pWgvSEvnxRTGpt7YjrmpmY2M/f4aeff7+f2Iu
    oBFzLlOX9s4D7nTi86Y5BuwoxOq+zF9OjYQgPfIFxJpjQDk0v8wvfMTjVoq5X+6V
    f72bEHLGkyzZG0FwrvwCs+6v8MCaAcIX0L7kEyd+VUq/13lZp8ENOKYmQeo+kJSd
    kteFA4yMhARrg3GHVfzHcIMuSahm2SfoaGUbB5U9+Y4wzW7oxoK3cwomYLZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hANtXO3K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hANtXO3K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEpCvh+M3yqnDkyfsn080qOheEuDqieegMBQaLLv8w4N5KzgQE1PvFEjTskB7RWUvloF72RvdFfEvj6Pg6HWA5b05QXxRbDPK5pJutz7HOpOMHHAA0RJ
    afqDHRuly+nPWJudG0Ci1UWMxNqw95Q8JspU8tqXURmHBMd5MPPKuSMCahzQMiPqSVINOyQm6KbGNObgBQnWC/TRvhKukZdOGioivqyV+9xOXFG5UYjdD4eK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=ANsfm4Edz2RPiPj94ysA:9 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756005AbeDIA3h (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:37 -0400
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:6816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755032AbeDIA3e (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 104/293] arm64: pass machine size to sparse
Thread-Topic: [PATCH AUTOSEL for 4.9 104/293] arm64: pass machine size to
 sparse
Thread-Index: AQHTz5kXHAEHOY7AyEC7UZigcYN6LA==
Date: Mon, 9 Apr 2018 00:24:14 +0000
Message-ID: <20180409002239.163177-104-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:KrdURTtXY2v/6jtwu4mE8J7f9CbM4xnB1ZitKtjVMp57662kyRFeMQbGYpuEQOMZnXa+/1gIJv5L5U+ZBRaks7vtPJMWbHrDk/5DwxbRI6JegHeZFC27qcwW6OMrCnLhZLvTP8eDA33xp11zlunMufxkqcZRx5DNxMj9b1kdsFQ1aCX/ZTLzl/hMaMm21t4uV6HT3DzIL8T9YsL2L4KPoSuD7tfkANtTfxNWSdXNyAc4PPquxPnqBZ/vidVKvvzY;20:yNmIpOse8jHlLorO0ZLHDoflQJTx3YGSpQHTv4OzSNlfhiiqTO1AvZOQvWZvLcCc7sR72SAHtQnJKMicF5AvbEN/xY1jtGurvhnxPvLDbP40zPEcRG3QzHV67qQtQLqURLyE79itcQoy4ra66e0oHsJBp6J5ta+m6OGe0y0Mpj4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd50a7ea-8cbb-49cd-65f3-08d59db0f644
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096786B004199BC9E2F39047FBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(575784001)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(6666003)(5660300001)(478600001)(8676002)(6512007)(8936002)(39060400002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: REzNTb/vZE1ag5pvhMcVHLKfSetLoHSkrh52YYAf5mMJfnmmqWMQGYdP0MIHH6Ngs/JT/mjqiHuv0jdHUtN4IWPHKO3vhqtPnhIJDz28NuFgHZ1zIvAG83cEIRgRW4kIKP4eW2nHOQECISAoCEvxMrd5aDhxqht9Kiyez9vnnlMVcC1xMMa6TntKQJontlTMnQyYQrnIKI35S5PCusslm6NNwZJQczREseTpJLr1cw7JWgFU4Q4+9pW1dngdeM+THaWFyAeF4FbXF9DEglh5lvcjouTWT0oUqgcdkTmulocBAlRroLoNqgQTFN4QZy5mD/a/SRtP0aL0PGECABpAs6FTdS1WkArTMTGU/Dq80jHhGWrCuDsVGVs9erjjqpFlnEvoEe8+2DP6WpkqdfmKc5tIn3GERVZt2fPNqzsUQQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd50a7ea-8cbb-49cd-65f3-08d59db0f644
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:15.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit f5d284900c0f960e318a063f4c40826b6e3aa6a8 ]

When using sparse on the arm64 tree we get many thousands of
warnings like 'constant ... is so big it is unsigned long long'
or 'shift too big (32) for type unsigned long'. This happens
because by default sparse considers the machine as 32bit and
defines the size of the types accordingly.

Fix this by passing the '-m64' flag to sparse so that
sparse can correctly define longs as being 64bit.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 92110c2c6c59..bc66f4b6a1cb 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -58,7 +58,7 @@ LD		+=3D -EL
 UTS_MACHINE	:=3D aarch64
 endif
=20
-CHECKFLAGS	+=3D -D__aarch64__
+CHECKFLAGS	+=3D -D__aarch64__ -m64
=20
 ifeq ($(CONFIG_ARM64_MODULE_CMODEL_LARGE), y)
 KBUILD_CFLAGS_MODULE	+=3D -mcmodel=3Dlarge
--=20
2.15.1
