Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968727-1523368249-2-1291003241344611495
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
    1523368248; b=tERc2EcZFCJXj4ysvRkaapMDEJSz/gLyY1JopXF03cyuiv49sF
    QpTX4CCkzcUppJ3qgc1g9QPEcofI+upo9hQDudy+OvbtEmp8fxPbaaXkk0dehzuh
    6qA2VYL6u13oC+IluaK4Jd9dWGvZjz2D1B6lbaAj7pjugc1MiCWM3zkhe8Udza46
    xKs4BtUoN0xbSanK63wcWxaYQDYADy9XYV+7u1HeBo1LrRQkWMZ9i4b50nSIP5Sc
    PGM3IZ8KlBz2yKWToOoj0fz1rETWxva2zwb0G3HlI4VjPKkb8Eu3XQv6VWw75j+t
    wyTwjAqkX3iX5lYp9pZo/wNVphe2JAup3uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368248; bh=wF6mPodk2Y
    IrqfnE3WPKsdfK//3abXsRPDODTNqIZZk=; b=HGNJWr9ekkXtQ+VqMKQrx8n4tU
    x0BVhRkDrHa+Lvo5tyY9NiBiacXD3q3u42v4hA6oHeH896p0M0nVUjfWyc7/P0tF
    UT/kLzRQhuCPo2CfZTFYFsrQGiUZdDlC5HCCzPCKcICOgMaImfxTV8SIwR1lGkXs
    3UUm6B/nNYQWAsSeLzJZdQhlOwQL+3BXPN0hr8pwE7ZfJhb8ijjfXGvyZJQv7AbR
    C7U9O7X38CQOhDLbX1b9mNoM5JK8zBCPqOAabsQYQ2+SSFfjKZoHKZzEhuyrIdO6
    3RhAFYSofMOQBhlQ7D9zXGr3iGfFDWBHYXZaV8ItHwNxZyTB5D8NoYd72N6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvn7EqLe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jvn7EqLe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGAG55idt1tE2L4hMZ3gSIFiSqArQTrw0GlYyf3YHroIAy3TZSIiKV2BP0SoJFQNETq2ceUeoEZXEmBlx/y4mLe4TQetMXOjF6n48rDC07jaS2GYAj7h
    QhL05uGvBURSr8eA4oH9KZ16FcQtdQF2M0t6H2/jVdn40LFo+a1k2gjQt72u0HjAbOm/ajf3NHhjVayJzlC/HMLf3W3A6YzCrD9fdS//NC6nFo1WmiIWcxGK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=9bipHb5F-c0A:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ZNyxNIxsH9A7wj_SNroA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeDJNup (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:50:45 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:46240
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754250AbeDJNum (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:50:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Colin King <colin.king@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Huewe <peterhuewe@gmx.de>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] tpm: st33zp24: check if chip is null before dereferencing
Thread-Topic: [PATCH] tpm: st33zp24: check if chip is null before
 dereferencing
Thread-Index: AQHT0NLpqFyIj8svv0aDez0tb+ys7w==
Date: Tue, 10 Apr 2018 13:50:40 +0000
Message-ID: <DM5PR2101MB10327A765FB1588EA7700E58FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180406160541.8188-1-colin.king@canonical.com>
In-Reply-To: <20180406160541.8188-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0904;7:PhfgOx+gmJTblxiPDJIkeSqwKOclSaEokkIIydQ34LOtCVOB8g+MD6ptv1EjmEtLg8dclFPYRPqQUnSAnMkpf5KPZpk9ebjGv4jm0HMCt3Jshvxp4fxXqluN2V2mI8+5d+U1BjvOqvr95PlV+Zm33+zgU/mUbJiurvHxZPvhBTQXHSCosdhMtm/Ate0QKEN3k+FXNiFQS6qzvmoqwo39r1cszhl2+/rt0aakGO3WP1Pz/rCH3StF77Wb1FE3znen;20:Rxtp2ut3XdSCR9AZLy6fMpXQWt2XLuMI1bqxGUPUkVYWUmUmOPIots/2KatVdPOEeu/y85x32UT+KzCBqsfbV48lT7pn1ww51yeulERdT5tc5U3zhPoaxtBSYPABLOozQfZs6YeFT6YDs8clwf8SDdGcQUp2U9CrU61seQzcmEU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0904;
x-ms-traffictypediagnostic: DM5PR2101MB0904:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090431AF991DDE578912E067FBBE0@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0904;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0904;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(66066001)(7736002)(97736004)(478600001)(1511001)(305945005)(74316002)(86362001)(575784001)(105586002)(106356001)(4326008)(10290500003)(81166006)(8676002)(25786009)(2900100001)(81156014)(22452003)(6246003)(316002)(33656002)(8936002)(5250100002)(6116002)(3846002)(110136005)(99286004)(6436002)(55016002)(8666007)(486006)(102836004)(6506007)(76176011)(7696005)(53936002)(54906003)(8990500004)(9686003)(3660700001)(3280700002)(2906002)(446003)(68736007)(10090500001)(26005)(72206003)(476003)(14454004)(11346002)(86612001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0904;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QxPtJA2lW1e3BFFTo8KYCvYRVlJjGHRZzxDWfqa+v1FbQLiTlDmg4wC2GnKax+iX2ClaC6Ubu16QIbmSIqiY0j+c311O3ITJvP7h4MYcKNZjQvGpubsnzXkt5/mNXgSLHQBVm2UfjE2SzbBr8LnHs/gBoE8dkmMu+JBXzAENYbVn6v7tsa+xmm9fw2a7nIsx6It0VOrQlkayXGad+wXL+/hUxUnFUYpzMkrjO+tDG1qcFSQ+UJWtTI3Jk8m5ksjjLv8Rv+3TktkFv0R984Xl0VWX46QZVQ9yUBMhUyiofkbszfNnhUQnDynlSXWKUYiQ2qKaH0TklvwuzvpoQxLxr++ZF53w9IElf9JRi7GGV/YUHf6Fd3vpetx8Ik9uqlU81eymNwGPSElvv5e5zkK5jO1VfXSYyn84qeoaeRtA8gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5ab1211d-3d48-444f-7e24-08d59eea0c42
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab1211d-3d48-444f-7e24-08d59eea0c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:50:40.6607
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

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 9e0d39d8a6a0 tpm: Remove useless priv field in struct tpm_ve=
ndor_specific.

The bot has also determined it's probably a bug fixing patch. (score: 19.67=
16)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.9=
3.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Build OK!

--
Thanks,
Sasha=
