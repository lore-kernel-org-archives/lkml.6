Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815CFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572CE222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfBLS3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:29:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfBLS3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:29:35 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0384314C4DC96;
        Tue, 12 Feb 2019 10:29:34 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:29:34 -0800 (PST)
Message-Id: <20190212.102934.2110719705539981019.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     pebolle@tiscali.nl, isdn@linux-pingi.de,
        gigaset307x-common@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] ser_gigaset: mark expected switch fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211223444.GA29517@embeddedor>
References: <20190211223444.GA29517@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 10:29:35 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAxMSBGZWIgMjAxOSAxNjozNDo0NCAtMDYwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoDQo+IGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL2lzZG4vZ2lnYXNldC9z
ZXItZ2lnYXNldC5jOiBJbiBmdW5jdGlvbiChZ2lnYXNldF90dHlfaW9jdGyiOg0KPiBkcml2ZXJz
L2lzZG4vZ2lnYXNldC9zZXItZ2lnYXNldC5jOjYyNzozOiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVu
dCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAgc3dpdGNo
IChhcmcpIHsNCj4gICAgXn5+fn5+DQo+IGRyaXZlcnMvaXNkbi9naWdhc2V0L3Nlci1naWdhc2V0
LmM6NjM4OjI6IG5vdGU6IGhlcmUNCj4gICBkZWZhdWx0Og0KPiAgIF5+fn5+fn4NCj4gDQo+IFdh
cm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0zDQo+IA0KPiBO
b3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHRoZSBjb2RlIGNvbW1lbnQgaXMg
bW9kaWZpZWQNCj4gaW4gYWNjb3JkYW5jZSB3aXRoIHdoYXQgR0NDIGlzIGV4cGVjdGluZyB0byBm
aW5kLg0KPiANCj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8g
ZW5hYmxlDQo+IC1XaW1wbGljaXQtZmFsbHRocm91Z2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBH
dXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KDQpBcHBsaWVkLg0K
