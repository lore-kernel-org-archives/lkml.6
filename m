Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AGR4j7A2NYFd4UWc9pHjLfXEUFRQ9JoQHnNgWZUurs4MfZKgxPXjuM6HFAg79NMhXOkaa
ARC-Seal: i=1; a=rsa-sha256; t=1517590993; cv=none;
        d=google.com; s=arc-20160816;
        b=lGD0VXqda+lAAF5OhHBNbNGRYNNMonNI+nyTeW2mtfp7oW5rzSVgRop92eAyXstHoL
         khO7NMwhN82ahd189V0RectzWP5Qwcm/24Q0WqYW/vs0J647KxsXTVSJKjmVbwIIXX5V
         WayWsy4J2RdcwY7NeH+VTfWxxlIIngNtOEoYODEjGKFE1sWjrZOfkb2ggI1aSG3g5nyI
         3Ps4vIkzuokxLLOg0yVfsDsbYiFxUg3I8j6y36Rp8fYQ6ZRhzbK6ELdLAQFhUcp9CuQQ
         2e9w/tkNz3pfBJ+fftu3d/2lvp4ZPkj8fiQLH9hGQG0W58kviIAiduiWvGPFLHYxseQQ
         oa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+DfR06A8QmQt3m0cbz6W2mBcPHOGXgGMX3xZlwS7QCc=;
        b=0IIN61V5OMfr+aFuaBe1qWY60LHaj3+z/ZiKcg6jdexr08BIt7BpVOx5tbVXXlPcKT
         k1bxlKMFq/5vJDzNofz1PirLedDOIJKSgRbwkxwaoXprX3T8NNtJesSvTxKINg6Eh8iX
         kePMv8NbBM6b9xWEEw6caCuJGTxnzRYylEkYY96vPB7Oid5NO4jPns+Tage8omgBzljd
         NY2Tr+CEZ/MBagZqtFBCo82zCA3ISp2WpBNmi6kEmRT9kGEeOVkM22ALv6aIGTWsVHyl
         YzSqdCdRyyW8DSfVR3bRK+0l4mAnPD9zVmMZCrZxZUczxfj9Rs6g3FwMkzp+GhO7Dq9E
         XTuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 07/86] crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH
Date: Fri,  2 Feb 2018 17:57:27 +0100
Message-Id: <20180202140823.373194917@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309493854941730?=
X-GMAIL-MSGID: =?utf-8?q?1591309493854941730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

commit b5b9007730ce1d90deaf25d7f678511550744bdc upstream.

This fixes a typo in the CRYPTO_KPP dependency of CRYPTO_ECDH.

Fixes: 3c4b23901a0c ("crypto: ecdh - Add ECDH software support")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -120,7 +120,7 @@ config CRYPTO_DH
 
 config CRYPTO_ECDH
 	tristate "ECDH algorithm"
-	select CRYTPO_KPP
+	select CRYPTO_KPP
 	help
 	  Generic implementation of the ECDH algorithm
 
