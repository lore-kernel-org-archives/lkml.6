Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523368268-2-2691127070850823070
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
    1523368268; b=PXYQo3/Utn5WPnoIUzzq6lBR21dh3bVe9z5TMZ89rQuPVtkV4m
    8WHu+HwLsIuzR7bF7S4egG4RroGkUsc91Lc9uTq8qikbgJqs8P3VZW9wg/HaqLrz
    t7XINpQhln0UBgwwbkqHt8WHwJ54ySpfGUFbzRzLsjBI8CvaRUqTznupb4oBm1dk
    O0hUaytfgCpw7bxVdfVpHxI245GOCF8AQ1qRxVeESBgFtTS3g526lqqDMv/ugybG
    +ePpgntWJeHTNYEJVKknJlqY4eES84C7P+9s8K2OTM41C3xoGDGOvW9rJEgwH0LM
    shwYRBwp8/c2QtYhLtZsMMx10ZJOAZTXnAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523368268; bh=qIeNb3xgME
    gyorXR+9rIaWCum3vlWPvmpBHPvt4Mb6E=; b=TMi1A6QC1uLIwX8sP3C9ZiFuTW
    8BGxK7zA40pEq37S83kEjG22Yc5yExEltl6rIefB14kArvQgltarov87vk9nT0vv
    tRbONkXcUH90uhE1owxRyzbVq+oJUjSS4bNQKTcaXkOftE1s56DRtiUj0arAfKMX
    S1T4ZpZjfdiUDYRsLJfimb0Vhtk3/AqsBR0jKLXcRxFWLdl9WF9YkyoYLkRA8wNg
    mSUA4GxZu3AET7txKfNiE0DzdX6SKrEos+r7GLZfh1Jo8sWlYLgqJQ0fguEqm4VF
    1FdfrThJP/V44UC+L7foA/J+IjJg4jvt28J3ZZVKueo4LX/aBtFYmNv0kZ2Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dOtZX+OW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dOtZX+OW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMSFvaZywbKua3BJV+6IbZqYI4g6PvljGet5Xe+6aFMePQD0igtbZ93U5e3SfxeFYWZNp4fY9kiIhc8ijP8N2AYY2uAYd78I1Cv1RP/ppJ71fXLGkRnE
    QNvyL2wO1eXaAtxFsEOEO9hJWFuLhy7/hH+MSrAHYYdm+1FOKLE7R+8KLaEWFH+VeBnAJfdizC44eCn//3gRw2QRGkeuQGxam7GSiCZm1GoLcmmpFKJ6Tbnk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=eQSBASbiplkA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=0R-XuUhx7rNaXD85l9AA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeDJNuz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:50:55 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:41613
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754258AbeDJNuv (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 09:50:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as a
 struct member name
Thread-Topic: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as a
 struct member name
Thread-Index: AQHT0NLuk7QR+JtKDUyuYO4i0bGtqQ==
Date: Tue, 10 Apr 2018 13:50:49 +0000
Message-ID: <DM5PR2101MB1032FCB3C25A4F8B7F778073FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
In-Reply-To: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0904;7:f6APOkaNjMLSvkBGux5/GT5IdiWG1HDzmxOTWOGOLBfQinj2kAsafExRx0PB5gXNQH0kSsGY6IgSVMdhxS8Tjj3odS0lMVDXMGwi2j7MH/ObY+NX2/ewsGeUDv6q8WQYfg21NWQHz92u2p4Hr3AApEWR6eyN32KfcTnRr5QPdoLsP23KZzdHJUlO7bdFd9h2Lbc1U5bOVWySW3o4xpZAJ3Ly/ayc+9CmEikWm7Ptj22N8slhHXH9sSSjdi2ZW44B;20:AUuHWgrflWpYhipJaUTUG0FeuXBZjvRj1ZPxnC+oFs1qAcJeFlw8jxKSIgzCzg1Mhf4quDCUcvDSDOQzL2UvANlkSbJYyoigI7x6iylC127wic5/fPHAUEdM3SYoW2hAoeMPX0x1KvFS+mIpojEkG+iMmeNMKDO5uKKHExRdOZM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0904;
x-ms-traffictypediagnostic: DM5PR2101MB0904:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090462B14BE694E7B0FC0C64FBBE0@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0904;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0904;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(66066001)(7736002)(97736004)(478600001)(1511001)(305945005)(74316002)(86362001)(105586002)(106356001)(4326008)(10290500003)(81166006)(8676002)(25786009)(2900100001)(81156014)(22452003)(6246003)(316002)(33656002)(8936002)(5250100002)(6116002)(3846002)(110136005)(99286004)(6436002)(55016002)(486006)(102836004)(6506007)(76176011)(7696005)(53936002)(54906003)(8990500004)(9686003)(3660700001)(3280700002)(2906002)(446003)(68736007)(10090500001)(26005)(72206003)(476003)(14454004)(11346002)(86612001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0904;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZR5Iy8iTXCg1eT1pAU29Xk2A3a6DYvG0HVcq1KENTYWVQYwF7gYY0vXT9cvOZsQsjaDM5yMAMjZd7xEA51LTMEAWPDPuan+IeMYBOr7jewhL9QrnQmzJErNefl30vLJ0CC/pSwb7VNN1vOYZUFL4n0ydKEgjHA5D3ZYJgBJRw/aSXSKTnsqIng7WHn5km+941si2IJg1mlnOCsdlK5zXhWQ7632gdnAwU7Fn9k1mvroKBkSx/fjd8g38V0rPVjrgx1mmc4AtENpylA5Cu3qETS4u+cE3SfmsEE/t4wr6e1spvdtSIPMzvc/xqlRzDERQavNCkUNnTHFmD1QIy7Za5zeqwMGsv1GAt2Hyr2iGcK2XzHAkzSUN7u3ODRm+STyeEHVmy3498v1PZ92NaFBZCNY2fnbsZxBZPf2zGkqMeEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a696eef3-ebd2-402a-b8e3-08d59eea118c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a696eef3-ebd2-402a-b8e3-08d59eea118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:50:49.5201
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
fixing commit: .

The bot has also determined it's probably a bug fixing patch. (score: 15.70=
18)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.9=
3, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Failed to apply! Possible dependencies:
    7cbe0932c2f2 ("KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP AP=
I")

v4.4.127: Failed to apply! Possible dependencies:
    7cbe0932c2f2 ("KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP AP=
I")
    ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")


--
Thanks,
Sasha=
