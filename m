Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF9B222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfBLS3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:29:51 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfBLS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:29:51 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7641214C5051A;
        Tue, 12 Feb 2019 10:29:50 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:29:49 -0800 (PST)
Message-Id: <20190212.102949.565787841270910392.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] isdn: i4l: isdn_tty: Mark expected switch fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211223821.GA13158@embeddedor>
References: <20190211223821.GA13158@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 10:29:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAxMSBGZWIgMjAxOSAxNjozODoyMSAtMDYwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoDQo+IGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOg0KPiANCj4gZHJpdmVycy9pc2RuL2k0bC9pc2Ru
X3R0eS5jOiBJbiBmdW5jdGlvbiChaXNkbl90dHlfZWRpdF9hdKI6DQo+IGRyaXZlcnMvaXNkbi9p
NGwvaXNkbl90dHkuYzozNjQ0OjE4OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0
aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAgICAgIG0tPm1kbWNtZGwgPSAw
Ow0KPiAgICAgICAgfn5+fn5+fn5+fn5efn4NCj4gZHJpdmVycy9pc2RuL2k0bC9pc2RuX3R0eS5j
OjM2NDY6NTogbm90ZTogaGVyZQ0KPiAgICAgIGNhc2UgMDoNCj4gICAgICBefn5+DQo+IA0KPiBX
YXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mw0KPiANCj4g
Tm90aWNlIHRoYXQsIGluIHRoaXMgcGFydGljdWxhciBjYXNlLCB0aGUgY29kZSBjb21tZW50IGlz
IG1vZGlmaWVkDQo+IGluIGFjY29yZGFuY2Ugd2l0aCB3aGF0IEdDQyBpcyBleHBlY3RpbmcgdG8g
ZmluZC4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgcGFydCBvZiB0aGUgb25nb2luZyBlZmZvcnRzIHRv
IGVuYWJsZQ0KPiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
R3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCg0KQXBwbGllZC4N
Cg==
