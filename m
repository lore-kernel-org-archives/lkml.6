Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-642949-1523804561-2-14216959674396117346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523804561; b=RMEbM8LOenqibFv62eH9u5Gtw2crB3YFfbvIH744pE2mitg8xA
    calQKtns6yLKtCwPv8MWepxbC9aszh92gikO+O2qGHVhdMXjda6YRLW7C2s4auZl
    RulY+2RKqQHkPojSnRuH0xNmNeqyzz0usmY7QiHR6cpp5rPdFPuj4iRtwgTKA1P0
    VdWPkKa+/IjFXdDescHC3CjQbpWbcHsRrWzhrBymZnz6xQE+p3c3X2uklF9nIZQQ
    1EXFgFto4rdkrEFRJXhiuVrHBSM8mdkBi4s/MzCzKHucKeZtUQWJc+8BeDbI/N3O
    tLuFeQc9BMRgni+K+CB81ZZ6qTxXeUbBMAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523804561; bh=PO2GzKitZPmzjnbR3cswjQTJqRfuZwQHBJdbW6DOBYE=; b=
    ALq3clIcxRIlnJN+ujPxqXjGCp4PlJc/8C6MkSDWqOxyh2iScOVK0eeD6gw499TF
    r4nD3/b9wTQidWRbUTljSmYST7WIzHktrqvn9KvwH42lXNHH7HdVTPkOSMEbJmF5
    NRw6gv8htJKiVdsghVJnT4YMzTy8bFvLoG/QBbS02ZnnpFs9lnEm+RuIBoTvG5xY
    MZm7WRNId6MOKOR9ukDxuWCRHFCy4VWwX6Umnq5X4mZJoTln55xQ31AyoyPuPQsI
    ew/fopvpxsUIjKhq8+VI4ofL5m5Zge8YDAvjIsJIYUtBzukNyvf1nDXmqEXRX7Q4
    Zlj21WM8O1bJ6fYzA7c24A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N6El1O5D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N6El1O5D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDFhFDtMHbQPBoOgLkBQR29eBHTsgo9sn0hjsPFHyTcdb/5rOt3YtaOBQJQPHcry/9fKIJwAicrGZMYK5PZXCjmJ1b4oPOJ3v4wSMBoUXmzqcUyD+qmm
    Bo/Pz63AwBIxPlLa4pNQDqv32DhPZQna3GRym6QPgd/lCH3j6NRBMyzZS8ocuuZye8gzsaUUtqPBLJUVXkLjA9EdmONigSi2HAtns+SSFXrXuRctDmU+YEF8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8 a=HNnV8wynyWjPsn33IzMA:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeDOPCP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:02:15 -0400
Received: from mail-cys01nam02on0105.outbound.protection.outlook.com ([104.47.37.105]:18124
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753144AbeDOPCM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 11:02:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Nicholas Piggin <npiggin@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "user-mode-linux-devel@lists.sourceforge.net"
        <user-mode-linux-devel@lists.sourceforge.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH AUTOSEL for 3.18 059/101] x86/um: thin archives build fix
Thread-Topic: [PATCH AUTOSEL for 3.18 059/101] x86/um: thin archives build fix
Thread-Index: AQHTz5t7x909kkBkwEiiU8YIjndzhqP312aAgAoe1QA=
Date: Sun, 15 Apr 2018 15:02:10 +0000
Message-ID: <20180415150208.GT2341@sasha-vm>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
 <20180409004042.164920-9-alexander.levin@microsoft.com>
 <20180409142911.34fe1065@roar.ozlabs.ibm.com>
In-Reply-To: <20180409142911.34fe1065@roar.ozlabs.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:fNpTZRHFJQi+DC21sauE7wFnWIm3ivEvwvn94PA3y8DhiGdtE+XPauuqO71gPpS/lfvt3OWDpyy/o5sRAiHOgORRrCgrKBmCM2pF13xdcHy13BLruLT8xfBgD7DrG5HAcRKPMuRimqxwhBX5gHYYgR1cISZYGRu4fjUgHr/Jv3j7XHoymitccaELzYc6ghqB5cM/f6exLGx7aXrU9bn8YtdOExUGBRSgwNKTGLLP02oaMxpANVSlzPxFyNzLItZW;20:dG8wuY+2XopeNJ2Kk7vAy2UWalgKDTlJ2rpWUj7qy1+BgGInGNb1euDltSaYNhE8TNqQY9IeW6UxVtruBrabcBRetoeIJUBBnOXBEA09HrhnDnKysQW87T8FPhCxbMB8PPOL8BBg+l8kcvbTXLx6yVG14frma4k+80aKJq8K2v8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101577109E3F25561DB97E46FBB10@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(376002)(39860400002)(346002)(39380400002)(199004)(189003)(76176011)(10290500003)(446003)(25786009)(8936002)(6486002)(33896004)(575784001)(26005)(305945005)(86362001)(3280700002)(3660700001)(186003)(478600001)(14454004)(72206003)(2906002)(5660300001)(6246003)(99286004)(33656002)(54906003)(102836004)(53936002)(7736002)(2900100001)(6506007)(1411001)(105586002)(229853002)(10090500001)(1076002)(9686003)(6512007)(3846002)(6116002)(81166006)(81156014)(22452003)(4326008)(5250100002)(476003)(8676002)(6436002)(6916009)(39060400002)(86612001)(68736007)(97736004)(33716001)(66066001)(11346002)(106356001)(316002)(486006)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: othNkbeyrOJ/Ep2ARZC87nK9JYiLp8lckOtzHR8CiarCgwkft3Ry3vAEohFHt2g3lHIAQeoa0ePW3aLN+V4YuUKCNvD8LEIwegsjamAjDTK3ejYgsDIL+XQE3prUOznqGeHRNaVenSSE1YTmTNDwAgWnRIUVoSGnLb6zNJzHCEDfDRwAKBjC1MukKcK9ZQFS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50949BEA98A8144B81B840DE6927EEEB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 90581eb9-3a27-4da8-5308-08d5a2e1dd34
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90581eb9-3a27-4da8-5308-08d5a2e1dd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 15:02:10.3597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 02:29:11PM +1000, Nicholas Piggin wrote:
>On Mon, 9 Apr 2018 00:41:22 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> [ Upstream commit 827880ec260ba048f95fe646b96a205c394fa0f0 ]
>>
>> The linker does not like vdso-syms.lds in input archive files.
>> Make it an extra-y instead.
>
>I wouldn't say these should be needed on kernels without thin
>archives build.
>
>It shouldn't hurt, but no point risking stable breakage.
>
>Thanks,
>Nick

Now dropped, thanks Nick!=
