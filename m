Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-222706-1526673259-2-2060588441295398226
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526673258; b=SFRomtt2kFqiMUNXbwyPv2DajhirprZpEICAcZMgYksnOITaF1
    EXibAyVy4sNsdqAepF9lw48fqnUF4DzLFJJqYcNdpdfst9EQsCoRPwgHrI2qJdmM
    78QjMuulLQXrvosoy6BUoIVkwrR7OaBeLzN23YSurICNB9tNLAic4/45FcPJSzX8
    ILfyMUYrFV5y4IK90OKDVzF9X2sh2by7vOviZR8SPR98GCl8BKlR7jhJJS8KYT6X
    eBB7YCKEPwYX+bMX/dvAaPIg8uiLmxEBEQr7sJxDtCMHN4NIP5brN2JLarRzjzw8
    2NqQtHzq77CHe5u08iCM0LWf0YpjmpiLQZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526673258; bh=pwg9xW2ASTPBgpksY81XTA2sSkRWqoJSFfY5aoWqmTA=; b=
    jdYI3G2LbH4kLTcSwhWz+vUX6FM3Qctxx056lP8qe0rErRDISqa/40TV936NURFy
    HC6tNHseSh/7HajwZcRa3DKEf0tcSQnMDmEMQwWYa9qXCuiBVWmAVmU431ZoT1Q1
    /o6WqkLbC7AKniikJa6oxXXJje/NVEIVhzFSeu//Bgh170T5IjbXIY/4eQE0Vy8h
    AHdfrPtrPVc94R2j6yV4/w50FjoKYgpCezs3KklxcPUJkDLGN5JyDJ+8p6oAiYck
    AantwJ7bV7IwombNLbZ0HetAZk7Lp8kjxUFZVsC/ip5olRklvJFVK1tBgps/ng+1
    yXJex0dL3aOarZpM0WPhDA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=W+F7fFh3 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=Aslpx9GG x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=W+F7fFh3 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=Aslpx9GG x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCcrky4MEgA4T3b2PlXl7gsSxT+AMjanbhbcYW3An0vVjKVBOhl04anO7hHxKBMEzO4dTffkzOPbYRTXVJwWupR2BWkSbaQmmWqwVx6FkLhK+ZssM/u3
    ImU3HYVMFJQLKFmmdQyN5Lu789OpEUruip/o5DBRhrz0AEVtg7u5/0aoo/SZ1PHD9P0+2TFVNt5nS000blbzRvbHhdtHq5tLenokjNPdKAz5aI3rO72x0HUP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=NW1C4N5ZCfcA:10 a=l63GRFdEORMA:10
    a=wwSihFc02yEA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=VwQbUJbxAAAA:8 a=2mpGYqPCJODQdnpu18gA:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeERTyK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 15:54:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33994 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeERTyI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 15:54:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,415,1520870400";
   d="scan'208";a="78315368"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "rgoldwyn@suse.com" <rgoldwyn@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Thread-Topic: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Thread-Index: AQHT7h8HZ2EK9VUEMke9xQtgYlZJXKQ1qCYAgAA/jgA=
Date: Fri, 18 May 2018 19:54:04 +0000
Message-ID: <2e450c50-b4e0-4c41-0417-991c0f73973c@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-4-adam.manzanares@wdc.com>
 <20180518160636.GH22791@infradead.org>
In-Reply-To: <20180518160636.GH22791@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB1067;7:YkYwANPkPJGqK+xZMPM9J3p7RCF6IzzZo3fueSdxet+Vka/VKbdijoH2hpBT9TyXK/XXvAloSJMP/VJgJ8slztmynPBACc8wMpT8phkpbSAFz8f1BvpphsGV09K80Q3QcAXDWTGWQULthsoxe5aSBhwshe8LzP+um0F90RlDrsq0cskI3hv3shR/ap5JGTZLdCMycyoiXxx/Vko/ii2xIfSbIDzNjXmVzpX2UcmSD7lEeATDqcvXokUImMfLWouH;20:tuJQQ0WS2fZnZ2W3mmXrqJq+nA5/ehaRKHCG3oWVZZfCeJzQFKzjQZ5Xh/H5esGsUNN4DRnLEN23q5GJpl/yCwwZRshiyXu9SJ18cOA+bwgg99xDlM+J2BFclddH7cYyTBAD6H+6N30TbWUYjV6dHZ+KtdRIbxOwKSrFq2ikDGA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB1067;
x-ms-traffictypediagnostic: DM5PR04MB1067:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB1067A50685CEE4339AB079FAF0900@DM5PR04MB1067.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB1067;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB1067;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(39380400002)(366004)(396003)(199004)(189003)(68736007)(102836004)(105586002)(106356001)(31686004)(66066001)(6506007)(558084003)(53546011)(76176011)(8936002)(81166006)(6916009)(26005)(8676002)(3660700001)(2906002)(3280700002)(5660300001)(7416002)(4326008)(81156014)(6436002)(5250100002)(99286004)(25786009)(3846002)(7736002)(6116002)(305945005)(6486002)(316002)(53936002)(6512007)(6246003)(478600001)(14454004)(72206003)(97736004)(31696002)(2900100001)(476003)(186003)(229853002)(446003)(54906003)(486006)(86362001)(11346002)(36756003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB1067;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wiW0mnpGMe8T5t/UT9bfN/QWl9GCxp5b5dv5LC+Lc33+mIlDi84TyrU4f4v53A/xMStyHeTp3EepD5929AV+fUqkfC2dPDqcLRZ8C1NAnlySefSoXSAT/VJDjGt6gEDWKG2BTVfU4jxvm9K0/fg3/6FX3sOeZEqUwF1LhmJd5o5lWjIGkRoXPWSbqOlWJs4T
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <298567E02415514BAE4B2BD0BDF58013@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5c60f884-dc25-4e87-61b4-08d5bcf91c34
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c60f884-dc25-4e87-61b4-08d5bcf91c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 19:54:04.8554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1067
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMTgvMTggOTowNiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IExvb2tz
IGZpbmUsIGFsdGhvdWdoIEknZCBzcGxpdCBpdCBpbnRvIGEgYWlvIGFuZCBibG9ja19kZXYgcGF0
Y2guDQo+IA0KPiBBbHNvIHBsZWFzZSB3aXJlIHRoaXMgdXAgZm9yIHRoZSBmcy9pb21hcC5jIGRp
cmVjdCBJL08gY29kZSwgaXQgc2hvdWxkDQo+IGJlIGVzc2VudGlhbGx5IHRoZSBzYW1lIHNuaXBs
ZXQgYXMgaW4gdGhlIGJsb2NrX2Rldi5jIGNvZGUuDQo+IA0KDQpXaWxsIGRvLg==
