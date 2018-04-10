Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523368332-2-10037000973700499557
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
    1523368331; b=v/p+67ZCjstvJlh75xKkAIcZhICYZMTV7+usXLrr7/8ghS2yYf
    O+T+mv4JeCTPIYEVVOPrd1jouIUFH2E+G1sZlGlIvf5HMxzfzWr5r2nEC0LjbeAy
    trwaZOMicsWO0DF/NAca4LwMhcrI681SIxhf6PqqY30+q8ngHsD+Hr6PVvPhA30u
    CthP7vgIgwTGUyjZq13U74/aUMD0PKIZoo8T6Bcd5BrJo8MASealTOPeEL8zlEDc
    4bcVK7Fmf7On0OQjMqtDw48hIl7TyNKPquCDKsgg8VVM3m+2P2Lzz0KR09AcQhoB
    y+4DcA1lrK/uLAsrSnxS+fq8ZJwZ4KGVdBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368331; bh=4mkkqgfhvM
    aoa2X9UhOtoEyXBwYVoqPDmAAlQ0QUR70=; b=jFzF/q+2P8tLOJwpYa8CDjt8BM
    oz8/0bKjxVhCyi8BqAbcKPZE3ZgaW0AXw7EDUKWx3yqD2qKmqx966TAY6TZWxhgr
    BlwsYq4V0fxIxmWrMcWwcwHCrN7EQ4AOfCKPGsQejAHtMZARKAiQ+13z+jfAemic
    QQd1yLArK5GdoBNkTku3RGPJ3aOjWlGlz1W7hbWHsjHZSX9DpkfCViWw7j4y+XeX
    gVa+DAgsLH8jLZTZGYjN6yJQ7/zQEWoWJNGeI9W+o4j66/YKGrWtfe6q6gxf/CTz
    R8IKYbeuPI2YvYV/T4ZZhq9lttZpUPqzw+yo72KwzvKlJA5l/ONYPckeNVzQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jA5nFNVi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jA5nFNVi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAtWdSbYv/axoq1uhjUdoR9oFtwJZ+gwejzP5sPawIWnq/7EysL/zqWCDe5ioPhx7K8lDaj7DJe4l1PC1q93XOgyFM4+e6CfWx4fnVcRmh/IRZDibbbN
    TVWUUeqxGThS0gShNFcvkld3cAzvyYNlkn8chWhvIIwZ8E5Jz5MbJKUuIlXf3AHvD9bLudkdz8nPX+05ynewqp68YmHjKay9e9qAVSV4O3Z4HkXZ2XNuz5iN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=aCSjOBizYcUA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=ZNyxNIxsH9A7wj_SNroA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeDJNuh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:50:37 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14362
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754205AbeDJNuZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:50:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg Thelen <gthelen@google.com>,
        Wang Long <wanglong19@meituan.com>
CC: "npiggin@gmail.com" <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] writeback: safer lock nesting
Thread-Topic: [PATCH] writeback: safer lock nesting
Thread-Index: AQHT0NLf1/YcgsCw3ECK+A/m+g0x2w==
Date: Tue, 10 Apr 2018 13:50:23 +0000
Message-ID: <DM5PR2101MB10326066D3508A2D9892B508FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180406080324.160306-1-gthelen@google.com>
In-Reply-To: <20180406080324.160306-1-gthelen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0904;7:hJNMsp/SUskxLc4nvGuHOFMwzUCuHAuODkaPX9K9eGYD3ABXOOq4O8rKhCkuGHcc1p1qLy8x674uR/1GMV19omV9A7f3NhSK2hI7TN+pooYXOSfQWUZEcEZyMPs9uhoLv4pRPzzfOriZswyWcB4ADdSCWIR2apSSjnEV5jUq3KlJz8ddINm+m0pWII2kaVfyuN5m+8+/54V06clVx+31suXEykdMfTnMD5IcnXYa/neUpzvGpN7XkBeS/eFuNk57;20:riQ9QBdkZ6LFtDvTl0v7fGP7byFlP37WxCjkhgwlT76NPJ/MNxaU8h1sXqA2pfwrc9FzQxkURhi/eSCJFW7eXiWilZP6pqYXgh7P2JcvvMKLZw7JeyKfCQ5t+k7klCgt30oLdVEvUYP64lZfh3WYx6Po9gueCJ2O+WsQm0oFpf4=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0904;
x-ms-traffictypediagnostic: DM5PR2101MB0904:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0904FF6D54C5F97D23259078FBBE0@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0904;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0904;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(66066001)(7736002)(97736004)(478600001)(1511001)(305945005)(74316002)(86362001)(105586002)(106356001)(4326008)(10290500003)(81166006)(8676002)(25786009)(2900100001)(81156014)(22452003)(6246003)(316002)(39060400002)(33656002)(8936002)(5250100002)(6116002)(3846002)(110136005)(99286004)(6436002)(55016002)(486006)(102836004)(6506007)(76176011)(7696005)(59450400001)(53936002)(54906003)(8990500004)(9686003)(3660700001)(3280700002)(2906002)(446003)(68736007)(10090500001)(26005)(72206003)(476003)(14454004)(11346002)(86612001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0904;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vpDTiEpjOIzXcWqKTnY770OnYtI6Pl0YHAkB37rg51ILtjhjmSzopYRCtGQVl38H/5JDA7jE2UpP4Q4c7ttdqabkNbSjjR/lF1sFGYY1ND+6cEPGai/KjGYt0tVgnyO5DL5/EtUCXKORixD43veHcKJk9UbisSH6AAOSDIRCnaf3N6s+IottoNrw4QNCrX4iWCyDSXk+ik4+/uDHOsfoWWL5vA22BsDmcWC56aiQ+9NocaeR0WHN2DUAcKpT3oFmVjmz+tP+3+N1CxRlZ/SHDeIctq/ejsnEvgK3hcDccSsMNxGHEEwx8KhNJKGqYxldjJVy+zITdUBRGY7mUfa588cFZ/hIJm1+MxXtvSQZZmpI1CRYgLojPeQKchlOiBCAJy31Vm9jV1c4QMtuSqM6r1SPo+CPWTcMKPE/3IpjMqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 17556512-857a-4e05-79b3-08d59eea0220
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17556512-857a-4e05-79b3-08d59eea0220
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:50:23.6449
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
to be a high probability candidate for -stable trees. (score: 44.5575)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.9=
3, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Build OK!
v4.4.127: Failed to apply! Possible dependencies:
    62cccb8c8e7a ("mm: simplify lock_page_memcg()")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks,
Sasha=
