Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1534962-1522892094-2-16101903732098626993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522892094; b=QkIb7euheZf2e4saoRZdgB1LTVozfYKtK6Akrx919nlkBP9SyQ
    aH/b7HXTXJRe8Jdgc5Y1QmI0K7DaUMUO7P9l0pvxfBOzjI1toQbRuBmr1N2c5Fal
    9d5rSGETe9OZ2nzOzubkP4CAVMvcX2VxpoqtahW2W4jRAgNozU9F0YegGoziNIEw
    2cHqEG4kq0E235pi2X16yEV8ma21StvqpxwcLJRv3Jpxe5vCTik3aK4GEnPRh7uA
    FOTeB+b2QqIOr55yRA5Qv5aC4M9HXKPmIh9vVwIS8bwC32S4RPy1uo5nrLCdZJ8i
    vmmgYg/c0z0jIuDJ4iSFEHNkbFRWJFyx0MJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1522892094; bh=J/afIaOxNf
    S3sHeptlw0hN8mG4bST+G0XgA4qL6FuCs=; b=isx9MVH3B+FBPdMtBf6gLs/NEs
    ZGbItxKVf0kOtIBGUSilaWqsAHEsXD/Zey+ZpKnsLXwXgl9n4iAVFpz+B8zfCHid
    cX/vX7cST9UDHANDmburOqY4YqBYeISJwwslAze9SlLLxt1gMucrI0nMxWF0XSXe
    D2V6VHBxr+6Ft1H3dqKMeE+Cub66w96Vu5U0kLqoZ6wyhK4GfdJXvhjWvRkIIe/m
    V9DO5LAeeyv7xC5RogVe59uMOeZMy4bzH/VxyBhe5+4GC9mRxHLcZtxEXhRjmZVM
    FHDaZ9NmjCjYGaD0eVgACbHnHtZsa68df4QO/t9sqGmlt7qOu38N8k02by6A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KloanT4Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KloanT4Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMhSNmaT5b6XxMAggve+fcX7T+n1Z8ubtUYeDgw7edeuc/U+AdbVkwlBhD5Y+rYX2DTuHKRs8kxw3C1cxtZYoI2C9nXwN4xsQoHypCFZfXn/ApoLO/fO
    pvcRE119KrQhZPcyQbsPo4PF36+jLI5TY+s1KNFCm3V8GBpOmGYg9NYXN8cgvsBVQAt/RyyXm0wHQEiHzBXbsGmUXUSf7Y/oZ3xAxQB4zR8XmQTz0MLHBRAj
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=UGWKpi7RT5EA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7DXSkWJGR00ATjiNyCkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeDEBec (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:34:32 -0400
Received: from mail-sn1nam02on0126.outbound.protection.outlook.com ([104.47.36.126]:10218
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752889AbeDEBe2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 21:34:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory
 error path
Thread-Topic: [PATCH] Input: synaptics-rmi4 - Fix an unchecked out of memory
 error path
Thread-Index: AQHTzH47v1M1UF8kxkO9rGnU2e7sWQ==
Date: Thu, 5 Apr 2018 01:34:26 +0000
Message-ID: <DM5PR2101MB103205963461FF9EE6FDC1EDFBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20180402140327.7715-1-christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:S9KNbzuiSg6MhBNrUy5qC78ptgEuKEMOV1xzVi4V521jGOXsRvRb8Hsg05RjRPbOU3a7LfxppRmsEFKp2/fVmT5X8lg5aEC1+dTlJ3tGB6/cwfp61PuzZ9WOGzMXb0fVoHUWB4O0afgYGzxJHOB2X3soKnZafrq8nyRywFWwAXiiEEL+LS6/0rbJUsCsUWg5xa6IDFV63oCznb1BagvoIOnCQN4QXN83KB91KWo+xaAf/UpNDekVlDyM3i0Sgdi5;20:pJDH/vJDq6j5IPgz4ZnxFAZz/mSyXjmQFldW5EUyvheHM5m5NrimgvBIozOIx0qB4mRafo5hEbBRZ2bfR/MDAaBt8PizMk8TdovkPMskY87hVtRdC5IzxK4T3JVKk5h4gSd1uoemgqcG44+393i0nv8BDHHwi9GuqrC//0fTs8Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b3b34aa-6731-4640-9388-08d59a955e6d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09333487168CBB9D5FDA77EDFBBB0@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(86362001)(97736004)(7696005)(22452003)(55016002)(9686003)(110136005)(11346002)(14454004)(2201001)(53936002)(5660300001)(99286004)(5250100002)(66066001)(39060400002)(8990500004)(6436002)(54906003)(6246003)(26005)(4326008)(68736007)(316002)(10090500001)(2900100001)(446003)(6116002)(72206003)(3660700001)(76176011)(10290500003)(81156014)(86612001)(8676002)(3280700002)(106356001)(33656002)(476003)(2501003)(102836004)(81166006)(478600001)(305945005)(105586002)(229853002)(74316002)(7736002)(25786009)(1511001)(8936002)(3846002)(6506007)(2906002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tVMo2jrwYUXlIFGmvNTenuxIcgdcP3qF26q/BP4LWqUJwllGryfa0yYRRYGIT5YTJ8Q3eCjfPKy1Hq/n88AEGE/2P8P0S3Xr71e3cZnb2AxjXIQE4FSi9UUyry5kpa0/RhcN/9zzW3Y6VlpJidRu6CGIpi1K7BumA3VXO7yunHisyEFQIFoW5rcTO76o4Mxe/ZPUGDv2rf40FjPrFsw7aJt4nwBixL3Dua/u9reVjj+g9gzhtL4qrrXLgotuhwVGzjU2mcRr/KiCQnoePHyRvVqFFtsiRcu465c85IIfpFz8lf+K9X5RGWPCkaNldPRgKzVcB4AmxeQ91DFmvG4twhVx84ligSWGRXnSwxEp7aB170T3zI9OP2bpoxLnukOyn5L7bbi4xJW3pSQir4YXqQ4BGOk/zuLY3fJL2xm97u0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3b34aa-6731-4640-9388-08d59a955e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 01:34:26.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Christophe JAILLET.

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 7.5278)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Failed to apply! Possible dependencies:
    8d99758dee31: ("Input: synaptics-rmi4 - add SPI transport driver")
    ff8f83708b3e: ("Input: synaptics-rmi4 - add support for 2D sensors and =
F11")
    fdf51604f104: ("Input: synaptics-rmi4 - add I2C transport driver")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")
    fdf51604f104: ("Input: synaptics-rmi4 - add I2C transport driver")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")
    2b6a321da9a2: ("Input: synaptics-rmi4 - add support for Synaptics RMI4 =
devices")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks.
Sasha=
