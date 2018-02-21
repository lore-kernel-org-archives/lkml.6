Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227jJr2eN3/+jlTVmO7L5R1rOEjBd4VYC/H1MgjGFhOL4VU191IL/ShGZE8vNSBX4iSn6o+g
ARC-Seal: i=1; a=rsa-sha256; t=1519218453; cv=none;
        d=google.com; s=arc-20160816;
        b=VEs0KebVZ4HU19P3HHRgmPILmptC5GBB61k8/lqgmsRPZSQ3VoS9k9cuegzZLm45Z+
         +PMZjN7GGSYQrGPeEmFLztKjivZtENjBLwWjIkwOK8JVo47zQR6KB18dxQGAvB3Uru0q
         nb5cDPtAVia427urcNwiP2HyrWZFFjAtUlnCc6dNnlXysokr4R0D3OHLAL1lub8FN8Wp
         BJ5Ti0Qj5X4Gb3d4Z15Pr0BCWciQxfPLupnup8ADre0aj/9GrAMQZX2vEw58Ll7bNENe
         JJNSfJTTtn7hKzVo5vhbx/mAYBdL1dvYInxaG0DVaVvj3zON7Mf9Jc+kIFscWy8XBIe0
         RYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k+t8u7JcVsvl0giMpyL8IaxN3/83a3sYGmRRYgX4CS4=;
        b=ooPC37iKrRWpNalqiZk5zy4mKfdkhlQPG5BmJZpGfBOTxgeCWhe9EzWVgAhvkjEITE
         qhX8TzkQX+EbiKEm9arOFtClpuEL/ag0CJDNPI5DoQ/vsoJuQe++JtvoBOGHUm6chN0y
         O4BZy5uv6hHrT3QKalfsKVq9+YWPMMEYfX//KHJYargBMFk1tROfpOGGc0cIGePYRk/H
         +DGTGdE+njgC/gdQUI2uE0VqwhOUITAbFaCuoi8lJDqvBA5CC106/HCO/IzeLbHZWr19
         pnvyNa09AErSPwXZK3B2NIRhdn2KeT1nWIhmRkdW9yg/ywICdldUNuAtL6Uwck2S98ch
         zfEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Artem Savkov <artem.savkov@gmail.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 044/163] crypto: sun4i_ss_prng - fix return value of sun4i_ss_prng_generate
Date: Wed, 21 Feb 2018 13:47:53 +0100
Message-Id: <20180221124532.814246374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015504980249643?=
X-GMAIL-MSGID: =?utf-8?q?1593016008639622585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Savkov <artem.savkov@gmail.com>

commit dd78c832ffaf86eb6434e56de4bc3bc31f03f771 upstream.

According to crypto/rng.h generate function should return 0 on success
and < 0 on error.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
@@ -52,5 +52,5 @@ int sun4i_ss_prng_generate(struct crypto
 
 	writel(0, ss->base + SS_CTL);
 	spin_unlock(&ss->slock);
-	return dlen;
+	return 0;
 }
