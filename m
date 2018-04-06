Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2139197-1523045221-2-4053656747492681822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523045221; b=RXdkF8LVHQ737evoaHi9Fd2s8QsZ92dRQ6XPgxiH3wCrJnkDvs
    6foTqWT3QyhWC54tK7Kv6KO3Tm0iBDowtHwNrGXZEhPruAVHp6j0UFcFPQRWt6d2
    Pssi6J2AjfVBVvZGDGZOUAmS14z5LA1ODBiZJewid9YY+rMxFRNUvPrmwtBlmGCX
    CU7pd55EHfFib4rZMkLcbr2ZBjYbfQLvkQcv2Fuw4PqD5b3Xtyq05qveaKwLwSyE
    r4nEGMX8fTxgLuehniJ2ce32k5NKAqkQlqb3EKqtY2iYzNsSrV8SeIKzERwYpaqA
    cB/vOFvQaADYYuDRaWXMIx+7ukfyNj0ElIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523045221; bh=d2mbiyj/+U
    OGytAs4a9anhI/H68wAjyU+G71IOFwboc=; b=YbxyVzS6tPbfPao8WfZI7Wt3m7
    PT+leDA4Bx1sEK7F/JJe/tf0SAD9079/uL37q0mYpw6MvIULR8PbeXfqklcRCQKt
    HvlCNn4MLgAHO0CUnfMurcscCUnG7oCxefgZ40IoEFlVIdqmW0+g6WO4gf/Pe6A0
    92/kR4JgXH7qYvptfFQ3uezeDIFFN1UNH3XGTG9+C5xUEO3k3PMDzh/45+YYDF3A
    a7gEugw211unTPXeNv0PR35wqzrx0Gcdy9eyyZL1aS7i0JZ3ebxwhfWj0IZuXxIV
    J0Gfffydz2xPYF08F3bA0MatgOCqi5AQAXa5MyH5IhLboovFQi84wMK1b9Gg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e8iAlZGk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e8iAlZGk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHCClEUsD+A1W/Tex12N/08Qwu5OoCkG/bq2ETDBRMLGYGC9sF95hLgnb/13OJbnZPx5x1Dgc3CNCNay9PMvEAEMb1DKYBgsI4jI3F46W5Sf/WxVt0OE
    OXaWbxqTvNgl1+VpeCro501nbP8KZTrLBawqjDsg9BhaJrH3Y4avGrO15XG8jAjKy51XWOH2cgyndZ8plguu4wAGOo00lqhKLHjABtDu4p+EPugNNegys9cf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=fhm-pjx9chAA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zH1xJuc9CYu6ccsto9YA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeDFUFX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 16:05:23 -0400
Received: from mail-cys01nam02on0120.outbound.protection.outlook.com ([104.47.37.120]:5024
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751538AbeDFUFT (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 16:05:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kernel-team@fb.com" <kernel-team@fb.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "stable@kernel.org" <stable@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] bitmap: fix memset optimization on big-endian systems
Thread-Topic: [PATCH] bitmap: fix memset optimization on big-endian systems
Thread-Index: AQHTzeKV+IARkB1iyECuwbgNPg0w6g==
Date: Fri, 6 Apr 2018 20:05:17 +0000
Message-ID: <MW2PR2101MB10348BF4123D24A55DD2817CFBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
In-Reply-To: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1131;7:ptbLww89q3jx046FtqPiCH6q53a/7h+itsRP1POpOgrs5bRQmGlHsYBMy74nX2tY2UX17y/O7Mp/S5HbqiCOhlLWsJ5ZyNI2KzC5DS1hvd6AzxfJrn3E9ZDzn1qNMSXEiVS+mi7HxkRR9JExCreVn6BU4VJv8OGem4vyBLq9QOCBaQpaXKZHPDe0GU1p+87Gb2lT7b4nFFyOQ3NvrNkjd41r+aLN5jx7/oZA5HBXO8y7KDwPR9wkSooYTjM3KrTL;20:oAkcxT8IXRiUY+zcJZb6TQUYXYQ/GejGG4k7otv4NeksuYS9xuskSSPMvckE2jhXwi+H+rkIPBLBZA2Po/PsmQTIDXCqhHOoTgXN+ojD/YQDJi5kmgVU2a/mitHmiAGcePkSTUlxf9m3n597m2KuWiZOyRCQP6Rn6bIw+7sl3V8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95cb74dc-7700-4065-8b1c-08d59bf9b7ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:MW2PR2101MB1131;
x-ms-traffictypediagnostic: MW2PR2101MB1131:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1131E46B963BB32A3A1D18D1FBBA0@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1131;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1131;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(366004)(376002)(39860400002)(199004)(189003)(76176011)(81156014)(6506007)(2906002)(86362001)(4326008)(2201001)(33656002)(55016002)(25786009)(53936002)(9686003)(5250100002)(105586002)(106356001)(6436002)(6246003)(2501003)(10290500003)(3660700001)(3280700002)(478600001)(229853002)(446003)(11346002)(2900100001)(68736007)(97736004)(102836004)(74316002)(86612001)(99286004)(22452003)(476003)(1511001)(66066001)(3846002)(6116002)(54906003)(5660300001)(26005)(110136005)(10090500001)(486006)(7736002)(316002)(8990500004)(7696005)(305945005)(8936002)(14454004)(8676002)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1131;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /WH+R4geUO6q3OusCvIoLPqbfha0UGt4JQ8Wci68jIzHwi7rJ1LW1bxJbijso5UDZmEhoZIrz0hXTkt7ULIgtLiGYkLI0mCfgbtoqzq/QbtUyGge9wKbO83Nx/4f3KW6MNnfoetPkSN3yZGBA+Ah0b14OMTqJSZ6c1hdeACd7t70bhl7V2ItUbjhVpSLXTr5wDA0KJLYfk4vhKRFCFt/hknjtKttb3IhjnvVxtBpyihvt71hFVirvQCJPVMoBRLP7wy3YPXCGCGJYDGdK+1Mo9oBbEkSxKuBsnajXJihVfWlkrk5IkxwJA2K2L/WbwWBNAryStsuEvk80DzaMexs6I3VTk6Oq+xQ5ECzhrxDgePes5y5+NcwlVDEU8DngaxWiLkQKoYsJcYwQzL1nIhPmK/bpZZq+xMMuLK8euYAHUA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb74dc-7700-4065-8b1c-08d59bf9b7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 20:05:17.6982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1131
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 2a98dc028f91 include/linux/bitmap.h: turn bitmap_set and bit=
map_clear into memset when possible.

The bot has also determined it's probably a bug fixing patch. (score: 65.40=
67)

The bot has tested the following trees: v4.16, v4.15.15, v4.14.32.

v4.16: Build OK!
v4.15.15: Build OK!
v4.14.32: Build OK!

--
Thanks,
Sasha=
