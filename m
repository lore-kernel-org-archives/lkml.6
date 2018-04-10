Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523368245-2-3193046231545680741
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
    1523368245; b=gVcn9OTDDGU2JZ52f8bVVoPCVyJ0wCe/CxCPSasZ2sf2retOuH
    aCN2mpw2XaMjHDocNuvFvYd70yGAZhDsjkoEY+r98v2l6mhSf02u6xkJwGIY/nju
    +AP4u+/TUvRNNkJu5J3iNNqIyDLen8jLOd+JmaAS+X1j/YZFm0wLSSHccLFXk9P9
    J1wkfDKRwDK5fDddfcJQxT6vClnK7SnHf8WiscRIooHWuYyxTfJD5ZS8CZ76AkmA
    ZtGuEw3wyQeK4oDK/Hm/bRdEEu9TFC3v5VWJ+51zItMqL81m+htIinGVcrrvis4l
    pUV6xWJ4EYGjXFmojHfoDNiHBDepOfMPbjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368245; bh=6Y6qaJmKck
    l/wHUro+CZ/VETupZIoRiFfcY4PfmijjM=; b=MlBE1QtXMT7/NH+XsTPqsEjObe
    L4DlTuwNRiqkiYr+tsc9uYH/OP5C0KWgH2jIuSIo8s7ZvRKAUYXdHiOx85yBLZc8
    eSKyGhUhs6NvlnaYdfTm6JaBzVc7ocNIdDmsREjHxRPaqgzigWkfPJ152xJwm3mg
    yybXEKZMtiO2J8rcf/Rk5kSnz33itR5LaBdJuZaiTc+lW/vtNz3X6Yk58gIRp/e3
    da8lKnIabPBMCZ5DWrkIeCCKscj1bu6h+9+PGzQMJTSogBFXWPd6G551kOzFYdLb
    PukUWz1tt52Idc6oMhdxpY/Gosxpm8KXpym/tfm5o/t9eeCmrkiT4AtzUieA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OLJX9uil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OLJX9uil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEehigKpXJjuo4+qgm9vd3avKHNW0ywtMVyNJfLhF5kB8wlKf6sFnO2pQ4UWJsFMW5Q0+Fr8pmviTK+gfTx/Bnm0ijbqa8MQbNY7xgqaXOvkmlVLG1N4
    YiKDxZsQzNu1VIuh7sHCKTJCYZU5u+iTB6Mm85bXkZT0qZQniBlNsxjykrz3ge6RAPBmkNivgGBa2krSrfX+5KqNp7Glqq1pE5J4VFJmNfhRlboW6Gupxfy/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=pSi1LfidigEA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Rimg5bTZ6ZlM9Z7fx6gA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754249AbeDJNul (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:50:41 -0400
Received: from mail-sn1nam02on0095.outbound.protection.outlook.com ([104.47.36.95]:51482
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754204AbeDJNuh (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:50:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Takashi Iwai <tiwai@suse.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] dell_rbu: make firmware payload memory uncachable
Thread-Topic: [PATCH v4] dell_rbu: make firmware payload memory uncachable
Thread-Index: AQHT0NLmwULA5rjPh0SFxD5+23V+5A==
Date: Tue, 10 Apr 2018 13:50:34 +0000
Message-ID: <DM5PR2101MB1032ACF6AD83275DF39309E6FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <eb0db565-5f8a-ab1e-2bf3-2def3ec3eddc@gmail.com>
In-Reply-To: <eb0db565-5f8a-ab1e-2bf3-2def3ec3eddc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0904;7:W2gk7a4Sr7q+jOQMgK2Mc1KXRFPfIu0ye4/WzZs5kuq0qH4U55fszhXETQWbt0blj9tkUTi9ykU1vMr47svWqyM3GD3OEbitdOnyyZRBYdXAiZog1MZhG3JJFAFsw5RNqE57PkE08fjE9DzhcwgMvKkZ1JopscgyG/Y1LbxrevF3GEsIJ+NIwHSHNCtoCKoe8KZMGtQS6BXqg6vw/eVce+MkiBqwYCzYKJrhXd3ZrLSqBPAW0cploOj5//EvTq1E;20:SZfMSbFl2XcJfyR9YFGyX1aGMmukZmZ2sDP9maHXKTOLbxx9D8b06IVmudQZyt/FM9o/tYC42cU2gBvQMhbpxvE3tV1NtaZLREuubT6g+/t5yuCIF2xa4g81Gkp5hCLDXRoXD+DyLSAwsQGwz2uGnSK1fPR4Beh3r/7o34QcO8k=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0904;
x-ms-traffictypediagnostic: DM5PR2101MB0904:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0904044E33140FAC187193FBFBBE0@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0904;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0904;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(66066001)(7736002)(97736004)(478600001)(1511001)(305945005)(74316002)(86362001)(105586002)(106356001)(4326008)(10290500003)(81166006)(8676002)(25786009)(2900100001)(81156014)(22452003)(6246003)(316002)(39060400002)(33656002)(2501003)(8936002)(5250100002)(6116002)(3846002)(110136005)(99286004)(6436002)(55016002)(486006)(102836004)(6506007)(76176011)(7696005)(53936002)(54906003)(8990500004)(9686003)(3660700001)(3280700002)(2906002)(446003)(68736007)(10090500001)(26005)(72206003)(476003)(14454004)(11346002)(86612001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0904;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: dxNlZef5kfta2vOsArhibzWyWpRKt+7vNVEMJ6GhKj/9TZxEFm8hOemcGXqk7Dk26USgHz8fvG3MA3mBaR3+9nRXmu6UjUiRcGuGha+3fWhh8aICkIdwtEPfTojiJNmuYO7fU1Pkz9qxDdQEN0PgYipfnzYTHG1OKSzHbRCZSKDJq6s7RVdo0YwiK9M7IWRAYMuT3rGlNkJGfigmvBZvuMf8MLah2RomWJV0yZI2nDnwViaLcildtSoVYL/t/Zdcb2r+9DxCvSStfTnyA3+YgsqJEbpXSj3qnI+MILorAy7fIlRkbwFZZlo/OOfo+vkHJ+NoIOIxpAy0rwz68y50IL6IFjPC+6dG4EJhkMUEEvTsK+ZmpiUFksOc8D6Epb0HiHDmkQJwaHT1wYJ6hTODhw6S1J966Bqx/cpTzx36gMo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 10f3d078-00ee-43cb-e229-08d59eea089b
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f3d078-00ee-43cb-e229-08d59eea089b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:50:34.5200
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

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 19.9792)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.9=
3, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Build failed! Errors:
    set_memory.h: No such file or directory

v4.4.127: Build failed! Errors:
    set_memory.h: No such file or directory


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks,
Sasha=
