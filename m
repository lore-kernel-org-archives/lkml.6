Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-222706-1526673224-2-7755724176555628921
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
    1526673224; b=Do5yTbHRkGSRcFI8CBn7eD3UFrcvmXHZeYfeI4FHpQq5lMbHeD
    rRYbiS/ws+9o5gCCxIkCSack7ayAIy7ATt4S4aXlXvgFM9ctz/HyHIz8FIDaI+mo
    p0QkeUTaKN/Pk/u0K6YY3dqoyUPqDGr6+eTzDzN9CdW5RJa3E0i1FcEyj0wTOco6
    ytF9YXMjb2JzA1R31h7X+GBA4gN+qrGbw+dCOK6IlYVCiGfkkI+MBaZsxx9z12wr
    lDGaZlokxJxnsIE/B4wp1pXgfljGlSVGgd8D6FjtLeZv4Xs8VZsM151WpDVJk7G9
    aSwFJuaKpVJfV3EM4SUlGwlIXF7ccqhpv5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1526673224; bh=0hG9B4/bZllA3mU0i8PHiAM9YRUvSwBpuSgAo3E2Zcs=; b=
    f/AEXq+4dwbTBfi3cQ0i7HMXSEaSXxJWwQHaW18bnykXuGW1RlPKuMptPlj2WT1z
    ZcJQXHQJS5K3HFnOcHNFJPaU5v4Qv/6CNIzDtXIT30oDHQAzWTixM58f05irKsfI
    a6Tysgg8S3H6nZK+l7buwFfdyLN51b2++ObSO4qOyEmx3QCWJiHnt0jxrEaP+RKk
    MS5TOIkXRD5lGaZ0YyommZi+px5pZjQINzTMgQ4i+/Mi33ELLXAZ+Rkzc20D55fK
    HUXmbJjOsOt4XmBmvDKg7lWoMdJ8Ko/InL8hcQr6Bm8Hx67Vbi+OvnlYztRBJQ3X
    2uzKAXAmV/4ArfNYObohgw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=sharedspace.onmicrosoft.com
    header.i=@sharedspace.onmicrosoft.com header.b=gr11W0Dv x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=hqdyPQZY x-bits=2048
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=sharedspace.onmicrosoft.com
      header.i=@sharedspace.onmicrosoft.com header.b=gr11W0Dv x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-wdc-com;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=hqdyPQZY x-bits=2048
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
X-CM-Envelope: MS4wfCocOP9h2YvvYEsW0G7bjfZVKkUsz+HE8rmWT7F7gZ5CWQy1iGU0lnFBVeTUOWsuzAmfUQSNk/FxfApW5mu0IfOb3b6bX4LAEKvKyx3/3h2i0FvF4n9o
    h1tRdcjz1ajAJpjE5g9B6CrMn0HPXQKjGHW8SCP/RfYaHmUrldr80M1B8UhNFW9Qa08I9erjj/m/8GAxvLRCMmg4P8ZyRtblvMX9/7kQeH2RJH4LrElTqbIX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=NW1C4N5ZCfcA:10 a=l63GRFdEORMA:10
    a=Wta_QN2i4hwA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=X0ROFhD97x8A:10 a=VwQbUJbxAAAA:8 a=YaEwC-xDOFpWjiZ5haEA:9 a=QEXdDO2ut3YA:10
    a=ic4oXV6auKO-Q6VfiSZ6:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeERTxm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 15:53:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57510 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeERTxk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 15:53:40 -0400
X-IronPort-AV: E=Sophos;i="5.49,415,1520870400";
   d="scan'208";a="175168320"
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
Subject: Re: [PATCH v4 2/3] fs: Convert kiocb rw_hint from enum to u16
Thread-Topic: [PATCH v4 2/3] fs: Convert kiocb rw_hint from enum to u16
Thread-Index: AQHT7h8G9C7PtFvsv0SQW8fq/Rs95qQ1p8IAgAA/z4A=
Date: Fri, 18 May 2018 19:53:36 +0000
Message-ID: <db91bfca-4ec9-726d-aac1-fa5979c65692@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-3-adam.manzanares@wdc.com>
 <20180518160512.GG22791@infradead.org>
In-Reply-To: <20180518160512.GG22791@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB1067;7:4uV8o/PkTmzxjPjVO/XJXnBRmWNoPk51ldZJD5mSZMNNh066lunjavsMkFHTI3INCQAMQeA2cgrByrY0hwOlM/7EIGF7HRg+AV/025vsZwwBVueNz8ZukaGN1NDIAVnRP7u6TySqxDFGCKyeTYAMVB7G0ZIxbJh3Iw+8M/RG3POpnRrbxBS4fBfKcK2KKRLMOiiDX3eYVLNF/zheyH8svB3ZNN9kFUcWjmtXfee5Do2f8CEmEx2ztGnawuQMUJH1;20:mgBLFQwud2xNqZcXlKHUVhth1BmFuIRONYofvxrSxW1WS1lHX6i5uAGxqi6wpDRqe+hovSJ8UHJLGSDJVo8tcLAaBjQZGNJSSUGYH4jx4sUk7xpgDVnC3zKQPKPk2K+A6+WFwRKbuZEZorOdbU9tUzq7j0Kn8/dxc6qFcjNbKgg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB1067;
x-ms-traffictypediagnostic: DM5PR04MB1067:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB10675D98E7AEE77994B8B464F0900@DM5PR04MB1067.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB1067;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB1067;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(6486002)(6512007)(53936002)(316002)(7736002)(6116002)(3846002)(305945005)(446003)(186003)(229853002)(486006)(54906003)(2616005)(86362001)(36756003)(11346002)(478600001)(14454004)(6246003)(476003)(72206003)(31696002)(2900100001)(97736004)(6506007)(66066001)(76176011)(53546011)(59450400001)(102836004)(105586002)(68736007)(31686004)(106356001)(4326008)(7416002)(5660300001)(6436002)(5250100002)(99286004)(25786009)(81156014)(81166006)(26005)(6916009)(8936002)(3280700002)(2906002)(3660700001)(8676002)(461764006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB1067;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oA72RfFfhgjo7i2sa59vj/SU/DonyXfuZFh1rufnDiiWtvOc6Z1ZqJTdAS4DKMLOuiKQ/7V52ImKaFj8iEUshijXO8pz+z75iwG2I9qBfv5Ov69R4nDeyVvXp5S6AUUn7dS25P6q5D47Er11ybmiEnz21XI9nTUofWDzaQISc5lqSSSYRjDEVc0BKCfAOrod
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B812D3DA2D2F624ABD22CF050A2AD410@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a048c993-c2d6-4fa3-33b8-08d5bcf90b73
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a048c993-c2d6-4fa3-33b8-08d5bcf90b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 19:53:36.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1067
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDUvMTgvMTggOTowNSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiArLyog
a2lfaGludCBjaGFuZ2VkIGZyb20gZW51bSB0byB1MTYsIG1ha2Ugc3VyZSByd19oaW50IGZpdHMg
aW50byB1MTYgKi8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBjb21tZW50IGlzIHZlcnkgdXNl
ZnVsLg0KPiANCj4+ICtzdGF0aWMgaW5saW5lIHUxNiBraV9oaW50X3ZhbGlkKGVudW0gcndfaGlu
dCBoaW50KQ0KPiANCj4gSSdkIGNhbGwgdGhpcyBraV9oaW50X3ZhbGlkYXRlLg0KPiANCj4+ICt7
DQo+PiArCWlmIChoaW50ID4gTUFYX0tJX0hJTlQpDQo+PiArCQlyZXR1cm4gMDsNCj4+ICsNCj4+
ICsJcmV0dXJuIGhpbnQ7DQo+IA0KPiBOaXQ6IGtpbGwgdGhlIGVtcHR5IGxpbmUuDQo+IA0KDQpJ
J2xsIGNsZWFuIHRoaXMgdXAgaW4gdGhlIG5leHQgcmV2aXNpb24u
