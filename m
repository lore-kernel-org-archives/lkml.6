Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuqPY+qJWR3PwmOzx0pmioiN3DXIp0DIHrXlEIQf1+ucScwVXspjHTKmxDpFDrT5Sdhp//8
ARC-Seal: i=1; a=rsa-sha256; t=1521214876; cv=none;
        d=google.com; s=arc-20160816;
        b=mKX3CqQ4FqVq55ON6TRZ7C9xGYIeAtv4gm9IE9AZp31ubnacuClz7k9+FYs49KS7pW
         6c1hSICSfGa48+BinrXkvWxcwFajR4M6FEuS5VLq5sqcL2c+k36GTmSBlWkFcHbrKEh6
         ovlHMykhXaMFhC0nfQxT4Brr+JEdajSOFmb3fK9dGcV21K/CxqYtKaD7D6ciVRs6f+lN
         UGJc+xuklW90JKlV1sJr+KGsZ/VdFhCCIBqs15b4dOt2ZLw/hDtXKdQmboP0nhRk7y/i
         Ur7nJRrXzG1+qID2hQSNcNrYv6QVJznBlGiGKFmrDiTFwR0OwjCzQNo9tbXrKHNT1Ydd
         dJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lamVeDP/JW4Wjbeg4ktQBiDaWQhtLI2HyJI3VxE0q/8=;
        b=gufr7FvJK3PVYuRrKjAc+rZmGU+65UcoKQrhZ6kYZNhdQmFdWwFVdO+H1LdRMcFhJW
         a5yaICvLqh36kjA5d0FeDbEMZQZqxHockNZXsR/cPhIV2w2bJPsbVxmPkOi2f25+VPX+
         M8F/8d9qaHOxq6Hx8I+TZF1hOwXDl+x7U2f6j3R7L0M7UXYwLRrtTmsPpGliI7hPPl/I
         GY5F0agsy+OVrbp00E06ool91a7Db1HZH+gSbX4j2R/Cn2qfPBxgiRWEN3jAMykbHG0R
         cxQjq52hIrvnzOPk6HUJZpsRIi1JShp8VALtd5d/gq+NsdNRo+ZP8VXW2PqDwHn2Ju7g
         Lt5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 050/128] crypto: keywrap - Add missing ULL suffixes for 64-bit constants
Date: Fri, 16 Mar 2018 16:23:11 +0100
Message-Id: <20180316152339.334377062@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109410608854101?=
X-GMAIL-MSGID: =?utf-8?q?1595109410608854101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>


[ Upstream commit c9683276dd89906ca9b65696d09104d542171421 ]

On 32-bit (e.g. with m68k-linux-gnu-gcc-4.1):

    crypto/keywrap.c: In function ‘crypto_kw_decrypt’:
    crypto/keywrap.c:191: warning: integer constant is too large for ‘long’ type
    crypto/keywrap.c: In function ‘crypto_kw_encrypt’:
    crypto/keywrap.c:224: warning: integer constant is too large for ‘long’ type

Fixes: 9e49451d7a15365d ("crypto: keywrap - simplify code")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/keywrap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/crypto/keywrap.c
+++ b/crypto/keywrap.c
@@ -188,7 +188,7 @@ static int crypto_kw_decrypt(struct blkc
 	}
 
 	/* Perform authentication check */
-	if (block.A != cpu_to_be64(0xa6a6a6a6a6a6a6a6))
+	if (block.A != cpu_to_be64(0xa6a6a6a6a6a6a6a6ULL))
 		ret = -EBADMSG;
 
 	memzero_explicit(&block, sizeof(struct crypto_kw_block));
@@ -221,7 +221,7 @@ static int crypto_kw_encrypt(struct blkc
 	 * Place the predefined IV into block A -- for encrypt, the caller
 	 * does not need to provide an IV, but he needs to fetch the final IV.
 	 */
-	block.A = cpu_to_be64(0xa6a6a6a6a6a6a6a6);
+	block.A = cpu_to_be64(0xa6a6a6a6a6a6a6a6ULL);
 
 	/*
 	 * src scatterlist is read-only. dst scatterlist is r/w. During the
