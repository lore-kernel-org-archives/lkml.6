Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245129-2-3275378234412215297
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
    1523245128; b=DZnB47QZchhZ097olXskTXwAn7CBObgQqUOFMmCwepEL5AEJIv
    C/pWVtpTusvI5847u4/0ttvAB5O9N25mIdlmqMSa2nYgEGsESKSH6QqIy9RMBF8m
    bM90S5UiKNdPuk/CsRuQctUOUDiTvp0HUNuoX87DP+kuBQyPd69KSxJpk0jaDj8S
    dwujstPeCB4cEDCRnV3QnMHX355yZwaRSFywht2lAv2nRt+o2EKEyksnJ1lK56s7
    YeeWoj60S6a4FBFwIw0QztJlIuL77rEcKHOiwnkWY6EZ0sv0ad4G0nx2MwXxHycq
    gMWlCFq/CDiTbfF7+HOpDzQEo020amUeuufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245128; bh=o4jbP5YEFj
    X4kFzQz2fCYZfR/OV+D+duZny6uysCFtw=; b=FfRPyJv4hOAnCums8dEaKAQWi1
    h7UvgR6I++i6/PsrT+ieAYEQ1WaqWAYATO7JUozNeb8oj8PubZ8aSPi6YwMbaFHd
    5rWcauTPY14G8hcFEtSCDW1Hci3h/NmIN6wIBe3D9Urb9TiW+kAtkK+4c5a1FBOD
    CG2DUNHlbsb1JH+Vj6bGNjytoTtScoHBsy5U8kaxdjVErQkf6t/KKNOR5vvSZyR6
    WgKwfJImr0vnjwbtO8S/ERnKCGW0O12xijLDGCttLc93k1x1zXRr8fpZmSxDcMAg
    8phl7TG/gquw3+4EnrPqMv6r6kbv8ouzbuWcKLYPprKIGQ4RoS8/AHn6qSQg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hmajbmW8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hmajbmW8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAuQcsdYGifcMIQm8TLmIw9iHaQx116BoXMFkHwV5P2ZwR9+UnpOascxqJDakwXqSDI7zr0HwGbRnjzKKUbLl9ZcrjsXkOFIl8JuxrmemnZD8JMlqnap
    BXv7hicL4fQjxW/9JnlDnJZVorbB5QMYYdzRba2n3JX60aYNYQWT3Wqawc/FVOecA1M2Ay18qJOtUgNzAZ3ZUI+wslrxsh8aTff0QZ7+nY7QhWw3Hvq9jtJY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=FmOupSUhuRgA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zH1xJuc9CYu6ccsto9YA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDIDhU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:37:20 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:62871
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752091AbeDIDhP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 23:37:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] mm/ksm: fix inconsistent accounting of zero pages
Thread-Topic: [PATCH v1 1/1] mm/ksm: fix inconsistent accounting of zero pages
Thread-Index: AQHTz7QMP2ktIfdiaEmWYKRM/lLkHw==
Date: Mon, 9 Apr 2018 03:37:14 +0000
Message-ID: <DM5PR2101MB1032D5A7084078760F686527FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <1522931274-15552-1-git-send-email-imbrenda@linux.vnet.ibm.com>
In-Reply-To: <1522931274-15552-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:0W4fCTYdkCh+YWK926JtfoNLjSnWwSii2snUjFNFAdoP5HwmuGuYe6uG1b2mITPu/IUcS0iPpSq+qfCmU9Lqg7fNJkD5Mtj7MPRKBaIq2PN2gOJ7DBpyzmb7P1JSoPg55xf7qkDiG+89uUTwy7sKUGz+M0n84a6sHo6y4w3uPC/Fs/jStO2l4EA0zzW0QldU3ktpr67PLCRSobj5Aedv9B3f+SJ3Z7U1jXXprueHNQ1QKZfRVxzPRoCm5cFmiWS/;20:xRIaJglxz/ib0Upw4PIV+tgtoj0un3xtxtkFa3umleushr1/IX0TbCxUnnfxUbQtjYeqnUP381iVveO58vGzR4VF8P8kxKOACRT+om4p//YJc7xNDBWAweQDlA1HaZ4Y2Udfsvf6L/8qfYRUGR0k82pqOz8fvqYq2KMLU2Z190c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 877b34aa-4593-41fa-bef2-08d59dcb2f77
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048FB7B168E52B13884F5E3FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(39380400002)(366004)(199004)(189003)(8990500004)(74316002)(305945005)(106356001)(2501003)(478600001)(5250100002)(72206003)(10290500003)(68736007)(102836004)(26005)(6506007)(446003)(11346002)(10090500001)(8936002)(486006)(476003)(5660300001)(81166006)(81156014)(8676002)(33656002)(66066001)(316002)(76176011)(4326008)(105586002)(3280700002)(9686003)(2906002)(1511001)(7696005)(99286004)(86362001)(229853002)(54906003)(3846002)(6116002)(110136005)(22452003)(86612001)(25786009)(2900100001)(55016002)(6246003)(14454004)(97736004)(53936002)(6436002)(3660700001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Bo04gcJ/ivznD0SFpjLteO3A+rMn8g4SrBQo/6UOlStZRReuTouNYM89o/pyBiHRfB7pgRycWvRNJ7lwyhtpcIzCNpFpEWncvG1ZRa8dhUZgy/CGnSe1wySolRemLewMDAekaWJ2QhmqFxdmUbb6eBp9yaFDjkeWWEnYM1oSselXiSsBqbIa/nFTlr/rNU7YajiKVfDIubzmZ1FWHzusHwwuIJQbcUxrvhs0l+T2FqsA0BgZ20Ue8FPGIjYMDugHxSW43nfrjkqbz1p9eosG6iTQS09/R9EzZZskFoPCUQ7pjvP1PF6QqrEIpYMq2uI6EgmMprXQCuDNK1jGvpOZNa1t4fKkg6oABMFIO/GubnuaHfrigHBr+FOmkznoskby5y6hooxk0hAAMT1uoh2T4JKosHq5zdZGbXtimvQS10Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877b34aa-4593-41fa-bef2-08d59dcb2f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 03:37:14.1841
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
fixing commit: e86c59b1b12d mm/ksm: improve deduplication of zero pages wit=
h colouring.

The bot has also determined it's probably a bug fixing patch. (score: 20.26=
26)

The bot has tested the following trees: v4.16, v4.15.15, v4.14.32.

v4.16: Build OK!
v4.15.15: Build OK!
v4.14.32: Build OK!

--
Thanks,
Sasha=
