Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2092709-1523045137-2-17141242210688201510
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
    1523045136; b=wDGkWYFcJL8Tjdg/9itjYBkLrimSjTkIrGMyi0dm01ftyfCfh1
    DPyPEsqvq7QZDTzXtPN5Fx2B1bJ8brzfiqkzKk16yCS/S8uy5ErXLoIM3u9br1DM
    xLhEd3DeHhQlJdEReMOP00r4vHaq04o4SWKo5D2wP3dtJ6/lt2L+CJBIytPIXIta
    gpbXG9vWEupx7UWT1AfpTsAEtYSqmY3Bvry8g3BsuMhshLQbenks242xrFuPl8Td
    +rTY5xDvJZszJl89tpuByebwOSVgO3tUZhDd4yOeybYAM4RUPjhluc0JYjO/+OxC
    1tJ439fR0B7gmYAwEvgxbmxMzkz4k5W/CkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523045136; bh=4f7WHSuC4q
    FuPgVAJpYoPyybhjVWezDSZy4hB58PwvU=; b=A3kjAUUkbVvXaFVN2y6oiKjrXd
    0oKXT+gMgbBdbRaTrg2vJcuq+g5IxBYO3MFK2xf9kVdHDNLCy1tYjZ0+vPj8BQZg
    1tZut3vQ3m4q6awb9L9wwTg9SzHV8MwuQTHf5isvm2PBdwGCrip41gStRtNAIKFu
    fEA3Wp6x1YvJsCm3ljtaaDP6/QE5bbItelD/7VpffTjNWb64TfOtYXCXIUHaEWA1
    hErpy9mmDW9Euj5cgTMv4X/bLzJ6HPT5eiDavYFiq6rxd4RwPpWCWJt6iwwcYyMQ
    XMD5EVCDzJqw8qvicSEzk2KTEe6PrMUvu/av3jp/v+AIAMT/Nq6DEG5Fd2uw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C5Sjuluv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C5Sjuluv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG+wBryQD908r9wumzsx3Vrks3lD2AdoRcuXpeNtDIu/0T+Z6Vmk2jQEWkxB0M6qvkdCPpOKHldKl1YcSmYMU7YA/f41NF9ezZo3ZGX8gBrjyiGMBmxT
    YbW21g8MEkI7C6pXWKN/dCSimUmFe3AYm3jzQ+AvBIFqOBWm3gF8WDvtGg1uFLyHy/DJGNyQ1jHYHzXZ8hsapLg982sgggGyfu1PAYjooTaZ/DNAA0Pa5qA0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=RXD64KlYVJIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=JfAnV-S7M-7dO1MNHKYA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeDFUFc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 16:05:32 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:63408
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751934AbeDFUFa (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 16:05:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/sti: Depend on OF rather than selecting it
Thread-Topic: [PATCH] drm/sti: Depend on OF rather than selecting it
Thread-Index: AQHTzeKbRGPkT//WzkGUApv/k6SfjA==
Date: Fri, 6 Apr 2018 20:05:28 +0000
Message-ID: <MW2PR2101MB1034D8A52505BFE74A9B443CFBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
References: <20180403053401.30045-1-oohall@gmail.com>
In-Reply-To: <20180403053401.30045-1-oohall@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1131;7:+w50ePz9on1LCygWjDIq2dz1phphCLAGWjOukSW1401hR3t9Ncw29Ln8eJ4gjKctbn/SAJLtp4zSd1B1IlxzbBFI5ImpH7ADfrOgfEJK5wHp5f9zyFFqgkx7ztP4dc6XCcUe9C+QH+xWyBVfVvNF8vtYGKDrrWcQ2tTHDcFo16kH2hdCtVxzFrQ/1W7mkwLplesEVZN8Wnxj4nVans77XSryX3MTPINJ2cZjW6PhjzWkGfE0FquTwefk5DfsJYJF;20:KGC0rVDW+yuLukYilsTtyVSh0ITLKeq/wqSkIXQE9175aSDXTSRqUVzB+UHQ/x0HvoV442De7jPBIGbetqgjFmfzlxtXWnshXT6xMG0dHKdldAYYrMBywarfl11xrIjPheAntNXyfY0Vw2HI5ph/xk63g4wpMNQD5TiWab1WWFA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4db04b93-9e69-4efc-baf4-08d59bf9be28
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:MW2PR2101MB1131;
x-ms-traffictypediagnostic: MW2PR2101MB1131:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1131264B17FA9DCEDA8B39D5FBBA0@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1131;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1131;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(366004)(376002)(39860400002)(199004)(189003)(76176011)(81156014)(6506007)(2906002)(86362001)(4326008)(33656002)(55016002)(25786009)(53936002)(9686003)(5250100002)(105586002)(106356001)(6436002)(6246003)(2501003)(10290500003)(3660700001)(3280700002)(478600001)(229853002)(446003)(11346002)(2900100001)(68736007)(97736004)(102836004)(74316002)(86612001)(99286004)(22452003)(476003)(1511001)(66066001)(3846002)(6116002)(54906003)(5660300001)(26005)(110136005)(39060400002)(10090500001)(486006)(7736002)(316002)(8990500004)(7696005)(305945005)(8936002)(14454004)(8676002)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1131;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: q4AEy4bDWVDRDSG/rq8bEYAfW57bQG3ZdjpVl2DWUiLFNyrYhgakgGMSzMsfXV+ZZjti5gq8s4SlNeeHkfyCdalujRAmXjC1xBlfaQY9oBGyYfiPPl3AfccIujRkws3HSVMxe07sej1P8ps/sDi6nEyY6UbGzt8d08s4JW+EeIlwpqRb/wQrMbXQBOtm8J+5BtaQNL50RclZ9KtZa91sIlHpLBB4bw2+e2gLWQJllZA8TRURwnma6vt2LFOxf4exZSbmLpB0wxfBvvzOR/Zr96mffAFaVU15TcOiOmNTOYlpM7KPaVtsFAl+fvfXGmARveYICcY8l1HMVe6MfPYDOSKSYTcbwmVfRE5yiZqUoMivYIZvmsUcySNlt24OVHuvyZpjjsUfQrYiL9yGMGlRQ4gQW+S7sbxyxyuZhrtlUS0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db04b93-9e69-4efc-baf4-08d59bf9be28
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 20:05:28.1134
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
fixing commit: cc6b741c6f63 drm: sti: remove useless fields from vtg struct=
ure.

The bot has also determined it's probably a bug fixing patch. (score: 96.67=
29)

The bot has tested the following trees: v4.16.

v4.16: Build OK!

--
Thanks,
Sasha=
