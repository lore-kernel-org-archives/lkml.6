Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4045798-1522165097-2-14179670783404542958
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522165096; b=QgfNf/Gf4toG/2ZY076mTyupnFm42LsWFJfN6A2jggA4Ev9
    EniHFFGxaVlPGX+7x2Pd1P4M4bB+JpwDuEvMGsqsYs1rGlCOD615pg2/dq754OjB
    xkkBB5MLH34FfHKpmTPm4VFQcLJzti94hmrG9Jbp1Bc0LLGvNvcwxl90n8nhJtpz
    LRwe7IngzopEVzyqZoR8kHnSddAR7QZFiLLJP7bMG7Q4RsFCsP3zaNYM0a6COplD
    7bHmpNOzcD5IJewpdygmhIWb6uD4K1vS9roAnUSQ05ytq5YrdmtxxZJTYlVeTiCZ
    Zkwx0LR+nAaLg8KMhFJ7F4u96PrCNEg+jlaGF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1522165096; bh=0NZqOFZFAdPG1UyzNTyf71Rq7Ze/0Urhp83OCM
    YOb9k=; b=sv1wvZodWkLmJ/ssCYtpjOzuQR1xIhkt4fb1XyX75gB4T5ZTMsHIgF
    dgl/iXl7twEx02qGBLGuwiUINOo1IWan/n6uke2yvRsFbVpnilGAsS5BVVtsWMw6
    FBLFVGdD2BUnLdbK7bGLjmr4MAibEkeQWFk6pIUy2IislE5fsOdJAShaenBewPqi
    GYJC5bmntl5B9yjwQ9js/iZDyDjC9aTm75FWprZjt2nQiZdXJKnbFPO49lZxZp+z
    HsInVO6vNWZExBvLWW9hkhMtkpkOoDUQZKRkxZlCvYW2XntQzm7sxelnlvh4YP6t
    +KUi6ClErSw5PohmwmFS//TBG1fPZtoA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=mhJBc/WL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=pass (1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=ItftObWm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=mhJBc/WL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=pass (1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=ItftObWm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHxKfWdVRr1kM2cgS03sYBlLLriZnBr7nur4V4WZaVKljXOfET+HOe+tBtDTOADJuUkQtyhJfJX+hOs+y4k1BTZUXX0NLnW5s0arCGC72J6uzxEC3tEa
    f04KrpCwKL4qvoweqM8o3oDQEaEgtI4cFC9JWmkQM6qFkbHJ4etpsgph7GWxq8RLzA9SxyTzcXarJpc20JrIW9Ibd3haiy1kjVMcDtnICLdms3ExrOvIaovj
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=A7nYOoY3jUMA:10 a=WS3rvhOas08A:10
    a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=v2DPQv5-lfwA:10 a=jF-tZZ44EvIA:10
    a=FOH2dFAWAAAA:8 a=IZ3wmBwKdIdxH5YGXV0A:9 a=QEXdDO2ut3YA:10
    a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeC0Phz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 11:37:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34976 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752096AbeC0Phx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 11:37:53 -0400
From: Sahil Rihan <srihan@fb.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Thread-Topic: [PATCH] tpm: allow TCPA log area to be empty
Thread-Index: AQHTuItC/RRm9Hus7E2B3o7PByJEg6PMtTQAgAYlz4CABAOdgIABQaUAgAEvBACAAxFgAIAARd2AgActAACAAAj+gA==
Date: Tue, 27 Mar 2018 15:37:14 +0000
Message-ID: <AD861794-362E-47F4-A38F-A9F65E7F66E4@fb.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca> <20180316125525.GB5035@linux.intel.com>
 <20180319021323.GD27186@ziepe.ca> <20180319212436.GD14364@linux.intel.com>
 <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
 <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
 <49C2A39F-C9ED-4620-82C9-C0919DA3F2CD@fb.com>
 <20180327080502.GA11855@linux.intel.com>
In-Reply-To: <20180327080502.GA11855@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:180::1:703f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1149;7:Tzj6L3Pl0QDMXTm55l18VfPDhAU0enlHSJkMeqsKYYYwwChtxElfPGH7D+UF88q/czMDpBmfmtqyoFDOusCXG0t8ttS4CV2TSPDw+Qqk1K78QCdBQGu8UHKlMjLjMFJk3JcNQ8nVqisTFZH1knw9NOsj7NYCINWyK+Y8fS397RwGMb6rOo2NXoil5FpCh2hiHS0WseEtKZi+30xYVYnDOZji4AdBQ9eBO8cRxODBzPlCL9GEWGyBZq+eyByns5Sn;20:G1snN+DTdS5z0TmuUxjUt/uuzsnH6VfL91ox9ldDnPd3/kXCqy1Hmx3ItoJIhJEQ7U12LnTUOfSS6/FhZTDisfLhsjVqgDJpaW5V1HqrA7qFaTup/KL5RHMonQ7g81BDT+yq6XQCaqvg+uVpmYms9ilP8+Vjdlts5C+IpXMEECA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(82746002)(2900100001)(93886005)(106356001)(316002)(8936002)(99286004)(2906002)(478600001)(6916009)(446003)(305945005)(6436002)(476003)(76176011)(6486002)(86362001)(2616005)(14454004)(36756003)(11346002)(229853002)(97736004)(5660300001)(3660700001)(6116002)(8666007)(558084003)(102836004)(6512007)(5250100002)(105586002)(83716003)(3280700002)(7736002)(25786009)(68736007)(6246003)(81156014)(8676002)(81166006)(186003)(4326008)(6506007)(46003)(53936002)(54906003)(33656002)(486005)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1149;H:MWHPR15MB1149.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-correlation-id: 9bf8a094-3ced-4a31-aab8-08d593f89dd7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1149;
x-ms-traffictypediagnostic: MWHPR15MB1149:
x-microsoft-antispam-prvs: <MWHPR15MB11491EE0EB35EAF0A72A62C7BEAC0@MWHPR15MB1149.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR15MB1149;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1149;
x-forefront-prvs: 0624A2429E
x-microsoft-antispam-message-info: dIsPnjk4QOnFSyCY/U5wn/i9q1Ddm+cOOaSe2ACcBBza7y1Sm0AunmlRslX1wmQfLuf+2Y4UCi2tFb8rarxTN6w2elfjSqoCbFL7H4gFW9qyk5JUZQRttmgKlknTiRzRVdl73NXVwdLfYSD47bcyuNLUICg4N1RSf90ecGAnisAS9w2Aa7NuIONmh6RvBKW50QiDIac58DV8ZWdJbfnu0lJz7csedxC2LZRLy1M5kJxsZl8Dg+3rxtNaDLJlMbjpVRfxsCWem5DLlDg6bS4vacLqKmqTZAAwkMrQuyCcDkh9IVOJrwHSxWgWgWFT0d6Qk40wCBlz/RbNB2h7ulytlA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <33E57A7FA1ACB34A8609FED8A6586276@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf8a094-3ced-4a31-aab8-08d593f89dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2018 15:37:15.0247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1149
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBBbmQgYWxzbw0KPg0KPiBUZXN0ZWQtYnk6IFNhaGlsIFJpaGFuIDxzcmloYW5AZmIuY29tPg0K
DQpTdXJlIQ0KDQogICANCg0KDQo=
