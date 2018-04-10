Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523368295-2-3934440635114814982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523368294; b=IAw7LlNF5Zhv5RwW1optO3Wi5zoCU9TWXtIxjP5cfrTMOspbsG
    rxcpnHggILv3CiMQ7ggsRpL8LCNSXhUFjZy4GJRHC+23DSYn6owzIkgKmi/zx6qB
    MKUFI69E83l2YbzIzpFI+J9IhpjWuBx5JJjnRwwHxHVLiw65gaYkqitt1KFN8Kj0
    DXdI1BCWVscBoZz56hEHLBed9ekE69A91YXSr3vnDsN7n1JYxAE02+A37HJkOLk/
    Wl8Q30bzniZx5XlaIHN54cNAjIfSJZhTsDjHUiTdb8xCQIC+ab64u8Oc4lSeMKSn
    9OyF7+eJv+XG/7woWms1Xe/8OX1ppHI/nhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368294; bh=1rzxh5PIAh
    s6ZBtPgYzbUqFJYTCUHG7K0rxgWdmOrtw=; b=CWMdEsB+jSDgLqdAAQZyxdhjc+
    t2oUaD3O5Tdd+45z/haUf/fUX9SGiv5JiP5kyFHRmaOYspoe1EVpfRzK+j9j9ROD
    cwMC16HOxPvT1HR2SGoP6JkjZxBGlp5GLrqcb3qgBy+MZuLGMzxkvIuhMI7kjyzD
    LEtf+yBzBptHGrrm58hDIeM/mtRDv6C2GrrFJb5dtQxA1wqWnAzEA35m/tJBhkes
    LmjGGmlThwNTL6Kg+Uud1XvWkUlre4c+tg+d0TCKxt3a2OsFgOHkWcg9vdge5zyu
    1MEwX+UBD8gSfPwRjQDN4tbVrTziRSJuyJgQr8Qq81froLLaZsZm4cXrUePA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eb5nuRSp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eb5nuRSp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIMiy3xVzFB+Wf69paqZQpxDfuZgwnS+d8grzBd8x2g60j28gVXrj0oBjvpbnkIb0GLYAYEjBOKqXwbBGKrT5ExVv3uQdC412PAy4ZUsLK2B8U//TTM4
    BLJsE8O62b92+Kh2H7frRhEr202WNBe4JD33MVnWE7f45ogjEunUd0XE2kwPOM5Gtp+rKJ0P5x5Sx18IZfPeh7l3zWB1AJQ85AGXaM5q6aJ0hSo8uEqYHbK+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=CJ6425Bi3zgA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ZNyxNIxsH9A7wj_SNroA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeDJNvR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:51:17 -0400
Received: from mail-bn3nam01on0135.outbound.protection.outlook.com ([104.47.33.135]:39351
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753957AbeDJNvO (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:51:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        David Rivshin <drivshin@awxrd.com>,
        David Rivshin <DRivshin@allworx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
Thread-Topic: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
Thread-Index: AQHT0NL8TGhdTvwwK0SaOeShsWUDdg==
Date: Tue, 10 Apr 2018 13:51:12 +0000
Message-ID: <DM5PR2101MB10326AA61D3319DBFE51CDEAFBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180405200916.27964-1-drivshin@awxrd.com>
In-Reply-To: <20180405200916.27964-1-drivshin@awxrd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:oXB/FwPZqTp4YSLun/2Wtg6NlEB7ucD29qLYWSpl63/b5b+bXEqT07nzMYxgvTRPYWiDrrVSOaQrcHGA9q9NSlmwYpAkQQQs7+00cuflSV1fp5JggmxjpvKl3KFh0KIlj95uJsKl9jClMXDv25GxJC52M9HDs4I7s28Pkp6SAR4tAwzx2b6DSoNKiv9JQj4xrJYQSpw70CTvpL/b0qhsRHBNPmBHTym1Fyn6SaJ/s1HAenas2vP8kmmd0ZjldSYK;20:ZMcsjVwFBAGkgolUAV/c9Pt+XjyIKYc0eM9wwSx4vgJrxF90fDKQZtvDR5B6rUxpL5QGPvv4UuSFQvhCFwY4vqXVFjWhSJw8/tqNT7jL6J4USgjCsGyyvez1oKN5ugzxf/acDoRtySU+lmaii0CxrqmupP9sjCEDFEPZRfErync=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045593BB02BD3E073DAB77FFBBE0@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(189003)(199004)(6246003)(25786009)(2900100001)(4326008)(478600001)(10290500003)(33656002)(3660700001)(3280700002)(229853002)(97736004)(2906002)(8676002)(8936002)(81156014)(81166006)(14454004)(105586002)(66066001)(5660300001)(1511001)(72206003)(68736007)(106356001)(76176011)(7696005)(316002)(110136005)(102836004)(486006)(54906003)(6506007)(22452003)(99286004)(6116002)(3846002)(86362001)(8990500004)(86612001)(2501003)(26005)(5250100002)(9686003)(10090500001)(53936002)(6436002)(55016002)(7736002)(305945005)(476003)(446003)(11346002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uIl8l+g8n1FlGtGD2M6xc5It+V/OAwmKDsCQPObNTSChlvigsMPyQayEdxdDtRZnZOZq5QB8eVC2gOnSMF2zLGiy4XxZXeejJzAXVjCWauElzlW5y+RHnTdT+iJN1C/6YYgjqwOtWJlSQrZb6jsaGmI0LYr8zB1spPeF1qAgZjnUOavGefqT7luO+v2qgUhTY3UywmcYaZvZCsSEy0ucRbCnTdsSuBhDKwt4VU1L3TU7W1BR/j3jPMXauT5OxkVNk3vwxXLPzd+Z/oVQvwzAchW3u1FKemaDsbavhgUiawoL7Y5aJRUYVfcS2fiS9Zhn0rssoKLssc1fn4HeSOnWoa3hVEeZUTxNaDSZzscRjwx93wx+jvBTW1j8oEVGoEbmp7CNEb2iwWOHRIK7TSnn4jGVDm8lZSovM7l+pSTdbkc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3df686bc-014f-4040-338d-08d59eea1f2f
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df686bc-014f-4040-338d-08d59eea1f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:51:12.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 834b2964b7ab kgdb,arm: fix register dump.

The bot has also determined it's probably a bug fixing patch. (score: 97.96=
82)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.9=
3, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Build OK!
v4.4.127: Build OK!

--
Thanks,
Sasha=
