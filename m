Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQcstmd18Ly2e9SSJUxQnLnCa4M/dglB/m1mGd1rDO2juRgMCk8r8+GSeJ5LDSJBmbX3LR
ARC-Seal: i=1; a=rsa-sha256; t=1526937904; cv=none;
        d=google.com; s=arc-20160816;
        b=DG+mNEimYyvck17oHBMo+NqW/cdMeZ8eKsCinbP+nSDvhI7mndkyPjZhZutUC1vi9L
         a+F7MeccTXSLqiXShLzM9t/4Fx7AXX9Knu7HQ/kZDOvEtcr1/Ch8WWXFVc+Wyc4J1Br7
         5OWFeqL8RJC3PDeplxyBnCfXXbejPiSG4WcKnVSnbim42i04caJC+FLXDxaXo5O9PBLt
         VBqD90a1vsmrx8Rz/XLNhvGPkFMz4qOPUeUch13XlmaRG+kpUbQ6NfcRyDY6CT4csxmq
         +KCQb4/pNnAJ8eKIXd/XoAMwvBUdv5XelIQWmI31N5VZoACeHC5OB3pwanbYCFCYDoLL
         7MSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1WSOpdBCeOBe52y9+5uKY/EmvTCX7Tbb0WXsXuBFu0M=;
        b=VHjJsv1SINKw6H+fhH2z8xsT3/5Ffd+oL6vawxQeg1wK8gsm4y94zxxgQpovo7YpAF
         mULM6AmNu71f9DNnkVgs352uH5qxrgtp59k97EYbv7wBwvFdtrd71divLItcw2MC27GA
         uojIknVt5YfxbmFjXxAaNMOneh0kOBYG7kNUFnRXuoQP94PiwN2w6P1P0QDHEFM/SXV4
         4/myRr2Koi6YoVuFdcUTayKo+O3Zysga8age0cc93hNUxmJqDR8FS5KEuvBofcgICmv1
         S6xkIFkm7Lf6OZ1c0yB6Xbpd/0f1HMK6y+ETgV6p6MEantalHpqpVUnNGi7gG74b2JHv
         0bUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=w0M+eMl+;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=w0M+eMl+;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Kees Cook <keescook@chromium.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 036/110] lib/test_bitmap.c: fix bitmap optimisation tests to report errors correctly
Date: Mon, 21 May 2018 23:11:33 +0200
Message-Id: <20180521210506.912667866@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110038722851247?=
X-GMAIL-MSGID: =?utf-8?q?1601110440478592234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -329,23 +329,32 @@ static void noinline __init test_mem_opt
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
