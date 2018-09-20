Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F1721525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F1721525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeITObX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:31:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26570 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730654AbeITObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 10:31:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-2-VqE3I_uhPeCWCGmpPCwO6Q-1; Thu, 20 Sep 2018 09:48:57 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 20 Sep 2018 09:51:09 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 20 Sep 2018 09:51:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Casey Schaufler' <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "SE Linux" <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        "John Johansen" <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: RE: [PATCH v3 09/16] SELinux: Abstract use of file security blob
Thread-Topic: [PATCH v3 09/16] SELinux: Abstract use of file security blob
Thread-Index: AQHUUHhVF1eZ06pqJE282SYq1iFnYaT43Qrg
Date:   Thu, 20 Sep 2018 08:51:09 +0000
Message-ID: <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
In-Reply-To: <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VqE3I_uhPeCWCGmpPCwO6Q-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2FzZXkgU2NoYXVmbGVyDQo+IFNlbnQ6IDIwIFNlcHRlbWJlciAyMDE4IDAxOjIxDQo+
IA0KPiBTRUxpbnV4OiBBYnN0cmFjdCB1c2Ugb2YgZmlsZSBzZWN1cml0eSBibG9iDQo+IA0KPiBE
b24ndCB1c2UgdGhlIGZpbGUtPmZfc2VjdXJpdHkgcG9pbnRlciBkaXJlY3RseS4NCj4gUHJvdmlk
ZSBhIGhlbHBlciBmdW5jdGlvbiB0aGF0IHByb3ZpZGVzIHRoZSBzZWN1cml0eSBibG9iIHBvaW50
ZXIuDQouLi4NCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IGZpbGVfc2VjdXJpdHlfc3RydWN0ICpz
ZWxpbnV4X2ZpbGUoY29uc3Qgc3RydWN0IGZpbGUgKmZpbGUpDQo+ICt7DQo+ICsJcmV0dXJuIGZp
bGUtPmZfc2VjdXJpdHk7DQo+ICt9DQo+ICsNCg0KV2h5Pw0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

