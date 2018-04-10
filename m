Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968727-1523368278-2-9540608970751766653
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
    1523368278; b=nBL7SHfcav9D0uoOsbtp0TeGlV5qv/qrQ0XwyHvbAajfJ149Xt
    X3nNjCCIcv0i06MFonaLoVkrppX1teiTyHnVyLR7UZVT15vL0oF61hy+sCOmTg3Z
    te6g/aY7Cb2R39cjRI5DX6PPAZGfoF732ciiXDjO/h+gK757eAFB/Pcdt7pOFIwO
    jo9JlKaLwNBtRzgAaZySgMNiuRYcgNNx4wTgdfOpxNvQzoispeZ8NIRB4Zp6ny9H
    u9nHzzcRs/tZQpaxUzcK/hsqICVW/XYZ3rI9KASDMj83jCY37cJDdiRFGpKM7LES
    xp6kSecKpk+6tJd85EfXUocZez0M3pe8QQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368278; bh=ARB/iGF86K
    4tsBAk4SypYhzsdhkqeMdpppmSXrzmhPk=; b=IXX6Fa6t8HO8AnKJxof9Te59Vl
    aBTUTNglCEbgpFe+qhO+FOTJfG7HKWA/nxPAgfC4zYYPAwj3F3LLrFFObwsuO5n+
    NVcazLOEWbj5WBaz3sCPf3KA6OdzHDclITYwG/Dt2W0tU8YQRVuB9Eqk8pbVxBf1
    cgx9ox5xD7alFesURJYJpwmFIxvsNGpmbZXbC/xX2SY1UDWzCPkNH3qhVv0oeNjB
    Sd2tBn7C0wdVsppPMol61bVb7B5jE4+X+HvdUgX5pl5aRAEAk8kMfOcMgDLkPEwk
    AExjlxncfdg9/oAlpOblwifGzBmfakb7/eRsjL07F756HB15b3Q0yB3JdRpw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YIIzeQT6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YIIzeQT6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH/UimQZQcmWagrEHaxA00+BdG3/g35eGAwzIS6nn+qkWnuatYr9+7TTOg4z1kzPPMl0WAcofWwY5WdvNr3SyGNqc/3E+/Yl6r2qzx3CLqq6C5MAX8u/
    pGgbA1Ceu0s9zK9DV5tRQU5aSrj/7auhjteAliY+2llhpLPSU5DBV7gfc83Kxy/kfPXb/4sq3Dc1Uo4V6O3EVjlDwq+1yeIQ9uqbj6LFodKHfdrj9ejn5ufy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=HkRb665pmpcA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ZNyxNIxsH9A7wj_SNroA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbeDJNuu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:50:50 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:6976
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754258AbeDJNur (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:50:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tasos Sahanidis <tasos@tasossah.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Input: leds - fix out of bound access
Thread-Topic: [PATCH] Input: leds - fix out of bound access
Thread-Index: AQHT0NLsaJpD5tRjX0m0NIXCb/qz4Q==
Date: Tue, 10 Apr 2018 13:50:44 +0000
Message-ID: <DM5PR2101MB1032479E64C7E71D728766ABFBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180406181242.GA225849@dtor-ws>
In-Reply-To: <20180406181242.GA225849@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0904;7:wj4wV3vcti32Yb70nEMj+4vKFdmmM2jcfrrkMRCnK7NT7lLpK8Go9O3lJMqVPIQTOuLAw+x+PDa0wYBCmuQSeGwW1fv7qqeox2PHJvFeCxYswoXYJUZN/skFyTCn3FoSIbHhcxUFp/w6z7PsoepivjH7QGn9LTn7O9WFXiRldoXXi1+r8BJOLMwptIR40rA6opGC4J8YE/FfdJXdgbWrlEqUtvA6iTUhEV7BDAR/CkNueS+IEngBcTuy34IstcQ0;20:RamuNRlccV7h5X2HSV1rDPZ0delLiHdVAIDbBoFDThFTMZUVoG4fDXZz58bdqNA8xSU3QUlNjiXx38cnT1cj7x8ddU6XGIZoMqWgsBWgrBbW/5DhIn1drmcmWnJScSoia57sTcFK8K4P8WO/xJSFpwhyu9PkyW3ejKGYQ3faF1c=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0904;
x-ms-traffictypediagnostic: DM5PR2101MB0904:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09045AF834EF577C5F28D8DAFBBE0@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0904;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0904;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(66066001)(7736002)(97736004)(478600001)(1511001)(305945005)(74316002)(86362001)(105586002)(106356001)(4326008)(10290500003)(81166006)(8676002)(25786009)(2900100001)(81156014)(22452003)(6246003)(316002)(39060400002)(33656002)(2501003)(8936002)(5250100002)(6116002)(3846002)(110136005)(99286004)(6436002)(55016002)(486006)(102836004)(6506007)(76176011)(7696005)(53936002)(54906003)(8990500004)(9686003)(3660700001)(3280700002)(2906002)(446003)(68736007)(10090500001)(26005)(72206003)(476003)(14454004)(11346002)(86612001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0904;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ofRFqCH1lfFvtRuY3/zTHSbwpeAHnKO1dd41WwR8SyZjOBQavVOc7UVU4tpz76/SUR8PlPELLS3ZCGEMmYCHo+gR7rvPbaJUupKpSIcd2Wu+T9Pg2qQIo5IYCCcm+Ce6erPSLoycbJjoblgO2yMReVW/xv3YSTkC5FB3uN8QeeIf1w8+SvUNuXdgjJlSc+dtx5BdWb+BoE31xEvX/7Y0JHMVMKhJrKamq6QW2UsC0oxCBfBOUEF5V1sppFOrSVqjISyFms3FpvWRUoAeYawt5kM4UlAE85M874wcb/j++Ufeg6Xw4IXk0FYKtie+XRhaXD+9lC6ywRoB4cZoODEcfz9lp07WstudcGcspNPuTxLC+OfP5AzlgsvOhjWN/6F5rYbwUqtObrxgp6MmzzFbHC8ze7OXkvgVp3jJERcugfk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ebb0782d-3b4c-4dba-ff3b-08d59eea0eca
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb0782d-3b4c-4dba-ff3b-08d59eea0eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:50:44.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0904
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has also determined it's probably a bug fixing patch. (score: 97.73=
89)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.9=
3, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Build OK!
v4.4.127: Build OK!

Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks,
Sasha=
