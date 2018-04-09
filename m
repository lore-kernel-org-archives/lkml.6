Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523245156-2-17690976227976033935
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
    1523245156; b=SILAITj99qoE0H5TlfKhrLkmVR4cyt/bvAcgr91dhX/So2mLFe
    BaP5TajN7uMY3I2rfIAv+NeS78Vih3aDJVaZDKg0E2qLCsHPNGk0PgxL66Rsvgcu
    alByvOrGhLFr4mOt+P1Noa+RcUW9jl2BX9Nj4xpm2nBmORIKvbdsyyHKdVxeP6ut
    T0FlCQOU9imGs5uOvhizXnCG8fwhXGtCHMUFPU75xipxn4+d+tOY5DMaLdeRcOwa
    Cph15SncyHB4gal6gN4OiKeG3j1zdUXBwcjtU+z6MU+LFsLLPb62JXAWYE90taNP
    dR2tA/O9BZt5mtMH/pfWSYzM7OCsxL1lMs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245156; bh=Qf7bQBL/Ua
    UX8BGW/3qb/Yew+V288WVI0D+FCCTY9MQ=; b=OtIeSLbU5L9XacNf1noHZKaag1
    zcq8GwKh0bjk1zDwWiyk6dgj/2MLuWJXjMsItfIH5Hu3ftU2bEfRPQDqHgRsYD/H
    IUaiupthHFJd3BQLItZh+ZypfA1FpVuTolx9a7mAjNBt+i0UQ1Bo9DC1jKj3HNm0
    oQGRCWf+Oj/D4gQ4aObdjvGQda9otDW1n/z7zzjTExe/YoJpnV8GhopfrO/18Chm
    CMORiWcH0k+UZT+SVoUleD5DEDtgV+JTbEhP9kSLI4qpDHqKjX1tdq4OcbZbhYYW
    fuzqF+vdZAUdn51Bvg3bt3wrrlaEPprWQVNG8SyuVz8H96JYmaSFyzfH0I/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H5aqRqJZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H5aqRqJZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdVomKVKZPoE+ZvzATKhblgZcMwt7h0e5YE425DYyjBd/9C0jMp9vQHJ2nI8focUBmtKoLx3yNsUAuUi6hPDVbP+5E4CF9EmlEMR9omMyEAWPoc0JBM
    RF93cJVLSmY4ghATGZXA7ji+GTmJjK9oqc2j5fPX9CKoXaA3BbsNemK27nLQo2I0ag7PkCbiPnWgjDzcEEFB42rjur0hcK4J5MmSSAIkxGZn9QvUoJgzqaZS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=gxzQ0pS9mgwA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=21XtWswpCqTP4RPFR6QA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeDIDhR (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:37:17 -0400
Received: from mail-sn1nam01on0123.outbound.protection.outlook.com ([104.47.32.123]:45039
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752775AbeDIDhO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 23:37:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mfd: twl-core: Fix clock initialization
Thread-Topic: [PATCH] mfd: twl-core: Fix clock initialization
Thread-Index: AQHTz7QLIMsAyO5FIESw3GN/4hgp5w==
Date: Mon, 9 Apr 2018 03:37:12 +0000
Message-ID: <DM5PR2101MB1032C6631C50973FB0297134FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180405114636.16294-1-peter.ujfalusi@ti.com>
In-Reply-To: <20180405114636.16294-1-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:kv9CIPCkOmHOaN4gIQyQtNE959+L11MbW43wn9ecsRwco/WXYJibLH625nrThOQugMwsd6XfyEUB2sAmnK8wHREXWo+XqVU4Y01/F+c4/ixAWN8nhQJbjavZhh2CmUQxF6BQpL2zSpea/r5dFNvoxz9NBQ44OS84QBA5YtytBPvZ2n/kDTNy+/9FW+7SB1rCDQHtMnRCcMAX40IGKvG5Y0TOwcZyIXQAZTA5vvwxBs130AZNwuor4hqVn5Ftcwg0;20:VnLTSMLJacYC5LIWXmto8RNzH1EUrNXpRn48NJpCvkci/C85s31r/sbHB/mELNfMB3wii67/ulvxGycDjknSoH3u2oAem1HIJ8T1o3r8ngPSAO295ar/Ot1hmGIZ3qanzjXYT64SrFtvZuo9dIyKXc4R/phX5SFUI89v9nbiwpw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f504f895-58fc-4e23-0768-08d59dcb2e5c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10485D297EF26283A3FB78D7FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(39380400002)(366004)(199004)(189003)(8990500004)(74316002)(305945005)(106356001)(2501003)(478600001)(5250100002)(72206003)(10290500003)(68736007)(102836004)(26005)(6506007)(446003)(11346002)(10090500001)(8936002)(486006)(476003)(5660300001)(81166006)(81156014)(8676002)(33656002)(66066001)(316002)(76176011)(4326008)(105586002)(3280700002)(9686003)(2906002)(1511001)(2201001)(7696005)(99286004)(86362001)(229853002)(54906003)(3846002)(6116002)(110136005)(22452003)(86612001)(25786009)(2900100001)(55016002)(6246003)(14454004)(97736004)(53936002)(6436002)(3660700001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Qk/lVcIqPnrt7znOx6cyodoZJp6Zrb0YCsJ73CbvA/se9j5cyqt78GQJB36NduWgNwRuM9bZ4xjGF4uNM2aoI9AFPrP9iylii85vh9QESja/tFh/zqxBkRYZ0KZJkKZhdFspPDngAnLqhFWEfu4FcsXyGXGnEjJO6jwIeZQPI7CEwcfI15P0z4Tjn0YGDIthpvelu0BB/en26CyW0upgYtKJ8l0dR4R7wrb1dKMRTJX8ll4t4zS+AUKet34FjVdjB5VdGGZbLwFVqobwCvzNS1kTsCK0ScQ2WjQ061g3b3pTDFoVsUpd+uwGMA7jsP22N/gePf4LTgpADcZBAiYWmkxdXnClRGsZiPVRT7LXMLl3weypwHrk5uf+NhZHr5C260TQuPOmN+P0bBF87Jo1gDAZSgZVxN85Xr2+BKT8VJY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f504f895-58fc-4e23-0768-08d59dcb2e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 03:37:12.2935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 7e2e6c5758de mfd: twl-core: Do not create dummy pdata when b=
ooted with DT.

The bot has also determined it's probably a bug fixing patch. (score: 99.01=
31)

The bot has tested the following trees: v4.16, v4.15.15, v4.14.32, v4.9.92,=
 v4.4.126.

v4.16: Build OK!
v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Build OK!

--
Thanks,
Sasha=
