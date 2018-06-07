Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CK3NNqKbGVuGMwAAmS7hNA
	; Thu, 07 Jun 2018 20:55:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 709596074D; Thu,  7 Jun 2018 20:55:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D9946605A2;
	Thu,  7 Jun 2018 20:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9946605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932679AbeFGUzU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:55:20 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34372 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFGUzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:55:19 -0400
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9754B1086A89D;
        Thu,  7 Jun 2018 13:55:17 -0700 (PDT)
Date: Thu, 07 Jun 2018 16:55:16 -0400 (EDT)
Message-Id: <20180607.165516.1480547908506142956.davem@davemloft.net>
To: geert@linux-m68k.org
Cc: alexandre.belloni@bootlin.com, andrew@lunn.ch, arnd@arndb.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mscc: ocelot: Fix uninitialized error in
 ocelot_netdevice_event()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1528377030-28319-1-git-send-email-geert@linux-m68k.org>
References: <1528377030-28319-1-git-send-email-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Jun 2018 13:55:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCkRhdGU6IFRo
dSwgIDcgSnVuIDIwMTggMTU6MTA6MzAgKzAyMDANCg0KPiBXaXRoIGdjYy00LjEuMjoNCj4gDQo+
ICAgICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tc2NjL29jZWxvdC5jOiBJbiBmdW5jdGlvbiChb2Nl
bG90X25ldGRldmljZV9ldmVudKI6DQo+ICAgICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tc2NjL29j
ZWxvdC5jOjExMjk6IHdhcm5pbmc6IKFyZXSiIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4g
dGhpcyBmdW5jdGlvbg0KPiANCj4gSWYgdGhlIGxpc3QgaXRlcmF0ZWQgb3ZlciBieSBuZXRkZXZf
Zm9yX2VhY2hfbG93ZXJfZGV2KCkgaXMgZW1wdHksIHJldA0KPiBpcyBuZXZlciBpbml0aWFsaXpl
ZCwgYW5kIGNvbnZlcnRlZCBpbnRvIGEgbm90aWZpZXIgcmV0dXJuIHZhbHVlLg0KPiANCj4gRml4
IHRoaXMgYnkgcHJlaW5pdGlhbGl6aW5nIHJldCB0byB6ZXJvLg0KPiANCj4gRml4ZXM6IGE1NTZj
NzZhZGMwNTJjOTcgKCJuZXQ6IG1zY2M6IEFkZCBpbml0aWFsIE9jZWxvdCBzd2l0Y2ggc3VwcG9y
dCIpDQo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IC0tLQ0KPiBUaGlzIG1heSBiZSB1bmxpa2VseSB0byBoYXBwZW4sIGJ1dCBnaXZl
biB0aGUgbm90aWZpZXIgaXMgY2FsbGVkIGZvciBhbnkNCj4gKGFsc28gbm9uLW9jZWxvdCkgbmV0
d29yayBkZXZpY2UsIGJldHRlciBiZSBzYWZlIHRoYW4gc29ycnkuDQoNCkFwcGxpZWQuDQo=
