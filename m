Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EABC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62578222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbfBLS3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:29:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfBLS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:29:43 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E917714C4E625;
        Tue, 12 Feb 2019 10:29:42 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:29:42 -0800 (PST)
Message-Id: <20190212.102942.1990347675673609567.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] isdn_v110: mark expected switch fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211224237.GA29262@embeddedor>
References: <20190211224237.GA29262@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 10:29:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogTW9uLCAxMSBGZWIgMjAxOSAxNjo0MjozNyAtMDYwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoDQo+IGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOg0KPiANCj4gZHJpdmVycy9pc2RuL2k0bC9pc2Ru
X3YxMTAuYzogSW4gZnVuY3Rpb24goUVuY29kZU1hdHJpeKI6DQo+IGRyaXZlcnMvaXNkbi9pNGwv
aXNkbl92MTEwLmM6MzUzOjc6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91
Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQ0KPiAgICAgaWYgKGxpbmUgPj0gbWxlbikgew0K
PiAgICAgICAgXg0KPiBkcml2ZXJzL2lzZG4vaTRsL2lzZG5fdjExMC5jOjM1ODozOiBub3RlOiBo
ZXJlDQo+ICAgIGNhc2UgMTI4Og0KPiAgICBefn5+DQo+IA0KPiBXYXJuaW5nIGxldmVsIDMgd2Fz
IHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mw0KPiANCj4gTm90aWNlIHRoYXQsIGluIHRo
aXMgcGFydGljdWxhciBjYXNlLCB0aGUgY29kZSBjb21tZW50IGlzIG1vZGlmaWVkDQo+IGluIGFj
Y29yZGFuY2Ugd2l0aCB3aGF0IEdDQyBpcyBleHBlY3RpbmcgdG8gZmluZC4NCj4gDQo+IFRoaXMg
cGF0Y2ggaXMgcGFydCBvZiB0aGUgb25nb2luZyBlZmZvcnRzIHRvIGVuYWJsZQ0KPiAtV2ltcGxp
Y2l0LWZhbGx0aHJvdWdoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2
YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCg0KQXBwbGllZC4NCg==
