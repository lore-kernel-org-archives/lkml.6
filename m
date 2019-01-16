Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AC7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D686206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAPXcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:32:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfAPXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:32:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7CB1E1088ACE1;
        Wed, 16 Jan 2019 15:31:59 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:31:58 -0800 (PST)
Message-Id: <20190116.153158.1210819126964530944.davem@davemloft.net>
To:     mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: bulk free tx skbs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190115012847.14730-1-mst@redhat.com>
References: <20190115012847.14730-1-mst@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Jan 2019 15:31:59 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPg0KRGF0ZTogTW9uLCAx
NCBKYW4gMjAxOSAyMDozNDoyNiAtMDUwMA0KDQo+IFVzZSBuYXBpX2NvbnN1bWVfc2tiKCkgdG8g
Z2V0IGJ1bGsgZnJlZS4gIE5vdGUgdGhhdCBuYXBpX2NvbnN1bWVfc2tiIGlzDQo+IHNhZmUgdG8g
Y2FsbCBpbiBhIG5vbi1uYXBpIGNvbnRleHQgYXMgbG9uZyBhcyB0aGUgbmFwaV9idWRnZXQgZmxh
ZyBpcw0KPiBjb3JyZWN0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IA0KPiBNeSBwZXJmIHRlc3Rpbmcgc2V0dXAgaXMg
ZG93biBidXQgaXQgd29ya3MgZmluZSBvbiBteSBkZXZlbCBib3ggYW5kDQo+IHNob3VsZCBiZSBm
YWlybHkgdW5jb250cm92ZXJzaWFsLg0KDQpJdCB3b3VsZCBiZSB1bmNvbnRyb3ZlcnNpYWwgaWYg
aXQgY29tcGlsZWQuDQoNCmRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzogSW4gZnVuY3Rpb24goWZy
ZWVfb2xkX3htaXRfc2tic6I6DQpkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6MTM0NjoyNTogZXJy
b3I6IKF1c2VfbmFwaaIgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBk
aWQgeW91IG1lYW4goXVzZWRfbWF0aKI/DQogICBuYXBpX2NvbnN1bWVfc2tiKHNrYiwgdXNlX25h
cGkpOw0KICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+DQogICAgICAgICAgICAgICAg
ICAgICAgICAgdXNlZF9tYXRoDQpkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM6MTM0NjoyNTogbm90
ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBl
YWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4NCg==
