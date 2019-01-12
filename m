Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56342C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E712177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="qGjgbh2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfALD4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:56:20 -0500
Received: from out0-136.mail.aliyun.com ([140.205.0.136]:58171 "EHLO
        out0-136.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfALD4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 22:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1547265374; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
        bh=eEeTgQ5vhIJdNCTwjYOVbgxbq2ITVfBqvOgBWpt4Bc8=;
        b=qGjgbh2cF6lDIm3nj7YJJOa19b/qzXsqpEMWU3xJPpp3F5hph7CHbjA7LJ6dX+97awITkO90Cc6fzQaFPbf2LF2p0pvqbPOKZn5Mwh9fXmQt+z3LYNfm8OizUEn7A3kD+67IbFpJ1UJ/JP+bid4mcueyq1muiPx2jO74qTqFgsU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01454;MF=longchun.lc@alibaba-inc.com;NM=1;PH=DW;RN=13;SR=0;TI=W4_5465780_v5ForWebDing_0AC26432_1547257684625_o7001c118q;
Received: from WS-web (longchun.lc@alibaba-inc.com[W4_5465780_v5ForWebDing_0AC26432_1547257684625_o7001c118q]) by e01l10410.eu6 at Sat, 12 Jan 2019 11:56:09 +0800
Date:   Sat, 12 Jan 2019 11:56:09 +0800
From:   "=?UTF-8?B?6ZqG5pil?=" <longchun.lc@alibaba-inc.com>
To:     "yamada.masahiro" <yamada.masahiro@socionext.com>
Cc:     "=?UTF-8?B?5p2O6K+aKOWFgeivmik=?=" <lc85446@alibaba-inc.com>,
        "=?UTF-8?B?5p2O5Li5KOaWl+mToCk=?=" <doukai.ld@alibaba-inc.com>,
        "=?UTF-8?B?6K645p2l5YWJKOaclOmjnik=?=" <laiguang.xlg@alibaba-inc.com>,
        "=?UTF-8?B?6YKs5qGF5qGFKOaXoOW4hik=?=" <tom.www@alibaba-inc.com>,
        "=?UTF-8?B?5p2O6ICAKOi0peWkqSk=?=" <yao.ly@alibaba-inc.com>,
        "=?UTF-8?B?546L5L2z55CmKOWHjOWknCk=?=" <jiaqi.wjq@alibaba-inc.com>,
        "=?UTF-8?B?55Sz5pmoKOWtpOmfpyk=?=" <shenchen@alibaba-inc.com>,
        "keescook" <keescook@chromium.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "akpm" <akpm@linux-foundation.org>, "tglx" <tglx@linutronix.de>,
        "mingo" <mingo@kernel.org>
Reply-To: "=?UTF-8?B?6ZqG5pil?=" <longchun.lc@alibaba-inc.com>
Message-ID: <b2d62e31-a64c-4561-a7ad-1625acad8a3d.longchun.lc@alibaba-inc.com>
Subject: =?UTF-8?B?c3RhY2stcHJvdGVjdG9yOiBmaXggQ0NfSEFTX1NUQUNLUFJPVEVDVE9SX05PTkUgZGVwZW5k?=
  =?UTF-8?B?IG9uIC1mbm8tc3RhY2stcHJvdGVjdG9y?=
X-Mailer: [Alimail-Mailagent][W4_5465780][v5ForWebDing][Chrome]
MIME-Version: 1.0
References: <4103792e-6b1f-48ca-ab1c-24adee0e7b38.>
x-aliyun-mail-creator: W4_5465780_v5ForWebDing_NTMTW96aWxsYS81LjAgKE1hY2ludG9zaDsgSW50ZWwgTWFjIE9TIFggMTBfMTNfNCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzcxLjAuMzU3OC45OCBTYWZhcmkvNTM3LjM2XQ
In-Reply-To: <4103792e-6b1f-48ca-ab1c-24adee0e7b38.>
Content-Type: multipart/mixed;
  boundary="----=ALIBOUNDARY_6377_50596940_5c396559_16845d"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=ALIBOUNDARY_6377_50596940_5c396559_16845d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Y29tbWl077yIMmE2MWY0NzQ3ZWVhYTg1Y2UyNmNhOWZiZDgxNDIxYjE1ZmFjZDAxOO+8iXJlbmFt
ZSBDQ19TVEFDS1BST1RFQ1RPUl9OT05FCmNvbmZpZy4gYnV0IHVuZm9ydHVuYXRlbHkgaWYgdGhl
IGNvbXBpbGVyIHN1cHBvcnQgb3B0aW9uIC1mbm8tc3RhY2stcHJvdGVjdG9yLCAKQ0NfSEFTX1NU
QUNLUFJPVEVDVE9SX05PTkUgd2lsbCBub3QgYmUgZGlzYWJsZWQuCgpDQ19IQVNfU1RBQ0tQUk9U
RUNUT1JfTk9ORSBhbmQgQ0NfU1RBQ0tQUk9URUNUT1JfU1RST05HIHdpbGwgYmUgZW5hYmxlZCBh
dCBvbmNlLAphcyB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CiAgICAgICAgMS4gZ2NjIHN1cHBv
cnQgLWZuby1zdGFjay1wcm90ZWN0b3IgJiAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcKICAgICAg
ICAyLiBlbmFibGVkIENDX1NUQUNLUFJPVEVDVE9SX1NUUk9ORyAmIFNUQUNLUFJPVEVDVE9SCiAg
ICAgICAgMy4gZGlzYWJsZWQgQ0NfSEFTX1NUQUNLUFJPVEVDVE9SX05PTkUKCgoK
------=ALIBOUNDARY_6377_50596940_5c396559_16845d
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="=?UTF-8?B?MDAwMS1zdGFjay1wcm90ZWN0b3ItZml4LUNDX0hBU19TVEFDS1BST1RFQ1RPUl9OT05FLWRlcGVuLnBhdGNo?="
Content-Transfer-Encoding: base64

RnJvbSAxZjNlMTcyNGUzNjRiZjFhMGNhM2ZmNDg3Nzg5NmE1NmFmZTgzOGM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAibG9uZ2NodW4ubGMiIDxsb25nY2h1bi5sY0BhbGliYWJhLWlu
Yy5jb20+CkRhdGU6IFNhdCwgMTIgSmFuIDIwMTkgMTE6MDk6MTIgKzA4MDAKU3ViamVjdDogW1BB
VENIXSBzdGFjay1wcm90ZWN0b3I6IGZpeCBDQ19IQVNfU1RBQ0tQUk9URUNUT1JfTk9ORSBkZXBl
bmQgb24KIC1mbm8tc3RhY2stcHJvdGVjdG9yCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlw
ZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4
Yml0Cgpjb21taXTvvIgyYTYxZjQ3NDdlZWFhODVjZTI2Y2E5ZmJkODE0MjFiMTVmYWNkMDE477yJ
cmVuYW1lIENDX1NUQUNLUFJPVEVDVE9SX05PTkUKY29uZmlnLiBidXQgdW5mb3J0dW5hdGVseSBp
ZiB0aGUgY29tcGlsZXIgc3VwcG9ydCBvcHRpb24gLWZuby1zdGFjay1wcm90ZWN0b3IsCkNDX0hB
U19TVEFDS1BST1RFQ1RPUl9OT05FIHdpbGwgbm90IGJlIGRpc2FibGVkLgoKQ0NfSEFTX1NUQUNL
UFJPVEVDVE9SX05PTkUgYW5kIENDX1NUQUNLUFJPVEVDVE9SX1NUUk9ORyB3aWxsIGJlIGVuYWJs
ZWQgYXQgb25jZSwKYXMgdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgoJMS4gZ2NjIHN1cHBvcnQg
LWZuby1zdGFjay1wcm90ZWN0b3IgJiAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcKCTIuIGVuYWJs
ZWQgQ0NfU1RBQ0tQUk9URUNUT1JfU1RST05HICYgU1RBQ0tQUk9URUNUT1IKCTMuIGRpc2FibGVk
IENDX0hBU19TVEFDS1BST1RFQ1RPUl9OT05FCi0tLQogYXJjaC9LY29uZmlnIHwgNiArKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL0tjb25maWcgYi9hcmNoL0tjb25maWcKaW5kZXggNGNmYjZkZS4uMTE0OTJkOSAx
MDA2NDQKLS0tIGEvYXJjaC9LY29uZmlnCisrKyBiL2FyY2gvS2NvbmZpZwpAQCAtNDQ0LDcgKzQ0
NCwxMSBAQCBjb25maWcgSEFWRV9TVEFDS1BST1RFQ1RPUgogCSAgLSBpdCBoYXMgaW1wbGVtZW50
ZWQgYSBzdGFjayBjYW5hcnkgKGUuZy4gX19zdGFja19jaGtfZ3VhcmQpCiAKIGNvbmZpZyBDQ19I
QVNfU1RBQ0tQUk9URUNUT1JfTk9ORQotCWRlZl9ib29sICQoY2Mtb3B0aW9uLC1mbm8tc3RhY2st
cHJvdGVjdG9yKQorCWJvb2wgIk5vbmUiCisJZGVwZW5kcyBvbiAkKGNjLW9wdGlvbiwtZm5vLXN0
YWNrLXByb3RlY3RvcikKKwlkZWZhdWx0IG4KKwloZWxwCisJICBEaXNhYmxlICJzdGFjay1wcm90
ZWN0b3IiIEdDQyBmZWF0dXJlLgogCiBjb25maWcgU1RBQ0tQUk9URUNUT1IKIAlib29sICJTdGFj
ayBQcm90ZWN0b3IgYnVmZmVyIG92ZXJmbG93IGRldGVjdGlvbiIKLS0gCjIuNy40Cgo=

------=ALIBOUNDARY_6377_50596940_5c396559_16845d--

