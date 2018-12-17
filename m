Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A11FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C969E217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TADvunuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbeLQVGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:06:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeLQVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F5eDz++z/FQJ213bay0vdKfK1MgxKX+eXhxMIAA31Go=; b=TADvunuPcx9nhwIyhivs69EW4
        ETFO94vFVgZjs1BNj9rLk72dTLsV6+ckzW4b7REeEIFMx7xHY/XFVfmHHgxoIROC8v1JyRoJHZloc
        FrH9cdDaj5DVrT4GnZx/lne23boVEwlGbDlGE+yNf7xRyI4C32mx33FQOKqVjo7IEavuXiqvVpfFW
        v16fTnIQJjiYPGEApg8IxLE+YNXwvysMcvN7JmJnCkFXPxJ/f89cx926q3OlZb88ZKvsuWgAqE13u
        nLYYgzYOeq/P3jxVGpAx5pS+/zpMu57NC+E/admts7MPRZjmynWtlj17SC4pj+FenWGTgipNf32oO
        zuhUqdlPw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZ05j-0003ww-4y; Mon, 17 Dec 2018 21:06:19 +0000
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org>
Date:   Mon, 17 Dec 2018 13:06:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181217112437.5fe868eb@lwn.net>
Content-Type: multipart/mixed;
 boundary="------------6BBD015C4CD1538B71FF8F14"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6BBD015C4CD1538B71FF8F14
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 12/17/18 10:24 AM, Jonathan Corbet wrote:
> Here's an idea if you feel like improving this: rather than putting an
> inscrutable program inline, add a taint_status script to scripts/ that
> prints out the status in fully human-readable form, with the explanation
> for every set bit.


And some people prefer not adding tools that use python, perl, etc.

E.g., I use this shell script (named 'chktaint', which could probably
be done better):

(see attachment)

-- 
~Randy

--------------6BBD015C4CD1538B71FF8F14
Content-Type: text/plain; charset=UTF-8;
 name="chktaint"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="chktaint"

IyEgL2Jpbi9zaAojIEdQTCB2Mi4KIyBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFk
Lm9yZz4KClRBSU5URklMRT0iL3Byb2Mvc3lzL2tlcm5lbC90YWludGVkIgoKaWYgWyAhIC1y
ICRUQUlOVEZJTEUgXTsgdGhlbgoJZWNobyAiTm8gZmlsZTogJFRBSU5URklMRSIKCWV4aXQK
ZmkKCnRhaW50PWBjYXQgJFRBSU5URklMRWAKaWYgWyAkdGFpbnQgLWVxIDAgXTsgdGhlbgoJ
ZWNobyAiS2VybmVsIG5vdCBUYWludGVkIgoJZXhpdApmaQoKZWNobyAiUmF3IFRhaW50IHZh
bHVlOiAkdGFpbnQiClQ9JHRhaW50Cm91dD0KCmFkZG91dCgpIHsKCW91dD0kb3V0JDEKfQoK
aWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91dCAiRyIKZWxzZQoJYWRk
b3V0ICJQIgkjIFByb3ByaWV0YXJ5IG1vZHVsZSB3YXMgbG9hZGVkCmZpCgpUPWBleHByICRU
IC8gMmAKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91dCAiICIKZWxz
ZQoJYWRkb3V0ICJGIgkjIG1vZHVsZSB3YXMgZm9yY2UgbG9hZGVkCmZpCgpUPWBleHByICRU
IC8gMmAKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91dCAiICIKZWxz
ZQoJYWRkb3V0ICJTIgkjIG9vcHMgb24gbm9uLXN1cHBvcnRlZCBTTVAgaGFyZHdhcmUKZmkK
ClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRk
b3V0ICIgIgplbHNlCglhZGRvdXQgIlIiCSMgbW9kdWxlIHdhcyBmb3JjZSB1bmxvYWRlZApm
aQoKVD1gZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEgMCBdOyB0aGVuCglh
ZGRvdXQgIiAiCmVsc2UKCWFkZG91dCAiTSIJIyBNYWNoaW5lIENoZWNrIGV4Y2VwdGlvbgpm
aQoKVD1gZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEgMCBdOyB0aGVuCglh
ZGRvdXQgIiAiCmVsc2UKCWFkZG91dCAiQiIJIyBCYWQgUGFnZSByZWZlcmVuY2UKZmkKClQ9
YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0
ICIgIgplbHNlCglhZGRvdXQgIlUiCSMgVXNlciB0YWludCByZXF1ZXN0ZWQKZmkKClQ9YGV4
cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIg
IgplbHNlCglhZGRvdXQgIkQiCSMga2VybmVsIERpZWQsIE9vcHMsIG9yIEJ1ZwpmaQoKVD1g
ZXhwciAkVCAvIDJgCmlmIFsgYGV4cHIgJFQgJSAyYCAtZXEgMCBdOyB0aGVuCglhZGRvdXQg
IiAiCmVsc2UKCWFkZG91dCAiQSIJIyBBQ1BJIHRhYmxlIG92ZXJyaWRkZW4KZmkKClQ9YGV4
cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIg
IgplbHNlCglhZGRvdXQgIlciCSMgcHJldmlvdXMgV2FybmluZyB3YXMgaXNzdWVkCmZpCgpU
PWBleHByICRUIC8gMmAKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91
dCAiICIKZWxzZQoJYWRkb3V0ICJDIgkjIFN0YWdpbmcgKENyYXApIG1vZHVsZSB3YXMgbG9h
ZGVkCmZpCgpUPWBleHByICRUIC8gMmAKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRo
ZW4KCWFkZG91dCAiICIKZWxzZQoJYWRkb3V0ICJJIgkjIGZpcm13YXJlIGJ1ZyB3b3JrYXJv
dW5kCmZpCgpUPWBleHByICRUIC8gMmAKaWYgWyBgZXhwciAkVCAlIDJgIC1lcSAwIF07IHRo
ZW4KCWFkZG91dCAiICIKZWxzZQoJYWRkb3V0ICJPIgkjIG91dC1vZi10cmVlIG1vZHVsZSBs
b2FkZWQKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBbIGBleHByICRUICUgMmAgLWVxIDAgXTsg
dGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQgIkUiCSMgdW5zaWduZWQgbW9kdWxlIGxv
YWRlZCBpbiBrZXJuZWwgd2l0aCBzaWduaW5nCmZpCgpUPWBleHByICRUIC8gMmAKaWYgWyBg
ZXhwciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91dCAiICIKZWxzZQoJYWRkb3V0ICJM
IgkjIHNvZnQgbG9ja3VwIHJlcG9ydGVkCmZpCgpUPWBleHByICRUIC8gMmAKaWYgWyBgZXhw
ciAkVCAlIDJgIC1lcSAwIF07IHRoZW4KCWFkZG91dCAiICIKZWxzZQoJYWRkb3V0ICJLIgkj
IGtlcm5lbCBoYXMgYmVlbiBsaXZlLXBhdGNoZWQKZmkKClQ9YGV4cHIgJFQgLyAyYAppZiBb
IGBleHByICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNlCglhZGRvdXQg
IlgiCSMgYXV4aWxpYXJ5IHRhaW50LCB1c2VkIGJ5IGRpc3Ryb3MKZmkKClQ9YGV4cHIgJFQg
LyAyYAppZiBbIGBleHByICRUICUgMmAgLWVxIDAgXTsgdGhlbgoJYWRkb3V0ICIgIgplbHNl
CglhZGRvdXQgIlQiCSMgc3RydWN0IHJhbmRvbWl6YXRpb24gcGx1Z2luIHdhcyB1c2VkCmZp
CgplY2hvICJLZXJuZWwgVGFpbnQ6ICRvdXQiCiNFT0YjCg==
--------------6BBD015C4CD1538B71FF8F14--
