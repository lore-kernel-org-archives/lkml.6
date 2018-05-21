Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937531-2-11913765758628270907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937530; b=aJMhecrtkyY6j8V0y08fRaBrFtC3MpL6Ig+WEcL6D3CgBxQIcZ
    BCqa03Dtls8sCb7aymdVzFUobW3HgW7slNdSZQlfXIex0hN7w+nbVWJFnmcJ5cPC
    5Fe9gj69x0lgiub6mENVZryeZ43dw6PCp2NiAbEFhlr+z3W/GWaa/JSaC6fTvjvq
    gxexIIgduueQUtwSAjvm+2DAekYtdfsaqj1I5hzqzBnmJvkjUzHN8p3SFFwHnhIh
    XQBS+ILG3Gt9vM/+UM/mV33gs/1rqE97lNTBa9kP0KGfO+NmhGWxM5uik+Zp62K+
    2I0VgIz3bN/0ZZPU93GEL3VwgnhghsJMcK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937530; bh=4MyQkeJwO5wHtadDgdcK3GuAxGF93u
    r+59HFLvXBl/I=; b=lkIivtiBd17rYPHJiJJa2/9Lc9M4PftnYhFLkNNvOfdTFS
    IuMEmpC9z7UZHGkCjv30UyLK2ApTZxcMI94EVbI/3Y5rYrmpvq6gjB3NRvulMits
    OaNU84ESZe8Q/e070lhud/bNR0vK4Qu9WfMUUgj3E4BsAdrGTJutJ8yLF2WE6Ba7
    D280onWnd8E8v+v+v0IFAyGfdKoLYIP4JwPH6ea8vZHVxj+Xbix0WWk/QSwaRioU
    0MK4pFaUhSxWyaDJkjqIvdYvmZMspWGPGoHgfz937qDzX0a0/73qUhUbW3wMw1te
    nKC/ic/t8S3gnyKNuWipLlzqp/lAK5540KuYwQIg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=qKXVHmYs x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=qKXVHmYs x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOkoDW3/0rst6CUfWMQlWY2Fre8Ou5/+Tc/TOzDKiPO3t7bT09AbEm4sRJA+c0La+yvwTC77vcGrztqJTlAjgslN247S7JRrajaLjcVX+8AnHtfO77+0
    kWdQW9mrPpEyNIpL+0tDFH1F0Ne3jIJG7gBe7+0rpDjutq+FqCEJCXmasQycIahvFuR/4/wBbSyWHvsmNB4/TcnyMZcE0dp9nkGt2j2WfSPS4YPV6MnY7zrU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=enOvQawGAAAA:8
    a=QyXUC8HyAAAA:8 a=tBb2bbeoAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=xZ1hyXiKp-vhQTs5yaQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=xmb-EsYY8bH0VWELuYED:22 a=OuzhcWw_GC9nAYdNdRwA:22 a=Oj-tNtZlA1e06AYgeCfH:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeEUVSp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753596AbeEUVSm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:18:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 24/95] lib/test_bitmap.c: fix bitmap optimisation tests to report errors correctly
Date: Mon, 21 May 2018 23:11:14 +0200
Message-Id: <20180521210453.286442585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit 1e3054b98c5415d5cb5f8824fc33b548ae5644c3 upstream.

I had neglected to increment the error counter when the tests failed,
which made the tests noisy when they fail, but not actually return an
error code.

Link: http://lkml.kernel.org/r/20180509114328.9887-1-mpe@ellerman.id.au
Fixes: 3cc78125a081 ("lib/test_bitmap.c: add optimisation tests")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <stable@vger.kernel.org>	[4.13+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_bitmap.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -434,23 +434,32 @@ static void noinline __init test_mem_opt
 	unsigned int start, nbits;
 
 	for (start = 0; start < 1024; start += 8) {
-		memset(bmap1, 0x5a, sizeof(bmap1));
-		memset(bmap2, 0x5a, sizeof(bmap2));
 		for (nbits = 0; nbits < 1024 - start; nbits += 8) {
+			memset(bmap1, 0x5a, sizeof(bmap1));
+			memset(bmap2, 0x5a, sizeof(bmap2));
+
 			bitmap_set(bmap1, start, nbits);
 			__bitmap_set(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024))
+			if (!bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("set not equal %d %d\n", start, nbits);
-			if (!__bitmap_equal(bmap1, bmap2, 1024))
+				failed_tests++;
+			}
+			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("set not __equal %d %d\n", start, nbits);
+				failed_tests++;
+			}
 
 			bitmap_clear(bmap1, start, nbits);
 			__bitmap_clear(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024))
+			if (!bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("clear not equal %d %d\n", start, nbits);
-			if (!__bitmap_equal(bmap1, bmap2, 1024))
+				failed_tests++;
+			}
+			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("clear not __equal %d %d\n", start,
 									nbits);
+				failed_tests++;
+			}
 		}
 	}
 }
