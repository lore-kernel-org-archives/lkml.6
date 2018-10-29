Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C01C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A235520843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A235520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeJ2LHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:07:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbeJ2LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:07:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 60AAB133FBEFB;
        Sun, 28 Oct 2018 19:20:26 -0700 (PDT)
Date:   Sun, 28 Oct 2018 19:20:25 -0700 (PDT)
Message-Id: <20181028.192025.548283670318508626.davem@davemloft.net>
To:     linux@rasmusvillemoes.dk
Cc:     richardcochran@gmail.com, keescook@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: drop redundant kasprintf() to create worker name
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181026212300.5827-1-linux@rasmusvillemoes.dk>
References: <20181026212300.5827-1-linux@rasmusvillemoes.dk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 28 Oct 2018 19:20:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFzbXVzIFZpbGxlbW9lcyA8bGludXhAcmFzbXVzdmlsbGVtb2VzLmRrPg0KRGF0ZTog
RnJpLCAyNiBPY3QgMjAxOCAyMzoyMjo1OSArMDIwMA0KDQo+IEJ1aWxkaW5nIHdpdGggLVdmb3Jt
YXQtbm9ubGl0ZXJhbCwgZ2NjIGNvbXBsYWlucw0KPiANCj4gZHJpdmVycy9wdHAvcHRwX2Nsb2Nr
LmM6IEluIGZ1bmN0aW9uIKFwdHBfY2xvY2tfcmVnaXN0ZXKiOg0KPiBkcml2ZXJzL3B0cC9wdHBf
Y2xvY2suYzoyMzk6MjY6IHdhcm5pbmc6IGZvcm1hdCBub3QgYSBzdHJpbmcgbGl0ZXJhbCBhbmQg
bm8gZm9ybWF0IGFyZ3VtZW50cyBbLVdmb3JtYXQtbm9ubGl0ZXJhbF0NCj4gICAgICAgICAgICAg
d29ya2VyX25hbWUgOiBpbmZvLT5uYW1lKTsNCj4gDQo+IGt0aHJlYWRfY3JlYXRlX3dvcmtlciB0
YWtlcyBmbXQrdmFyYXJncyB0byBzZXQgdGhlIG5hbWUgb2YgdGhlDQo+IHdvcmtlciwgYW5kIHRo
YXQgaGFwcGVucyB3aXRoIGEgdnNucHJpbnRmKCkgdG8gYSBzdGFjayBidWZmZXIgKHRoYXQgaXMN
Cj4gdGhlbiBjb3BpZWQgaW50byB0YXNrX2NvbW0pLiBTbyB0aGVyZSdzIG5vIHJlYXNvbiBub3Qg
dG8ganVzdCBwYXNzDQo+ICJwdHAlZCIsIHB0cC0+aW5kZXggdG8ga3RocmVhZF9jcmVhdGVfd29y
a2VyKCkgYW5kIGF2b2lkIHRoZQ0KPiBpbnRlcm1lZGlhdGUgd29ya2VyX25hbWUgdmFyaWFibGUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXNtdXMgVmlsbGVtb2VzIDxsaW51eEByYXNtdXN2aWxs
ZW1vZXMuZGs+DQoNCkFwcGxpZWQuDQo=
