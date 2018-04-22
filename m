Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/KaSt/xtbrZGAafl6kFbcBd8uCxYhfnCGRfgsoLJRLudDww/XK7h0jfq3m9/ci1J7R6ONh
ARC-Seal: i=1; a=rsa-sha256; t=1524405931; cv=none;
        d=google.com; s=arc-20160816;
        b=C2veHEUVbK1Ih9nXuVqiMiTHEORN3YveAPh4VKPGmrbCzo44S0V2TURRqpnicrwi+D
         DR8vnVAmASQ/Ygo4TWtPyRBTjA4/T4COaY9C7MwfhEJRRzQOcDWM1DA3CP55ncAzi+yL
         fqWYYtL7oyKFBJ/AcWr/bo0ipsGYYuvCsGCa7MKmRjSIKHEzObtp/esGQP+ZT8cRUnwX
         tJGrQCdhSMf91JsRetdIab4oEOiyDbEBcJlKYfXuYMRqtrMtc2h0b0IVe4/7L0kONjZ0
         JPfEpOLKoYXzgkkMm9UgNRAdFUtS9Np4z8QH0t4H43lT4TXekQKC0o4/nMzwwSnIysyy
         JdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N+0eJ9HhbG61JuC+M7G5bTV/4TguFqbYVJsDxCt5uUI=;
        b=PGj1ab50sspdxYumeRlkFPGs9Es1t5eOQOMv6yb4zN6jaeb91TGqdVqCAE3b2MPM8W
         oxCzjvBEmjNnp91p7q1m1dfweyzn3gzhnTX8o3WPpCrKsdrfUZKhLiWYWQY9v/RxxIm8
         +ilIanP6xbzCvb8wNtqcau4Ksdk3Y55ygBO5WqdW8mXKC/5ED02kzGQkVTVSmoEZ36zM
         CM5v8h1SB32q0nMI1TbGaoRk4D9CktJdZ/Lxv03spvv8T123SPK5ophcIOmaVVFhOyJt
         gsq+DelEUvlw4pF5BON8suSBMXIql1zX5u6CaAVDkU+kUO6ityXYfjqPj5TqUq2nJtBF
         eIEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Aurelien Aptel <aaptel@suse.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.14 050/164] CIFS: fix sha512 check in cifs_crypto_secmech_release
Date: Sun, 22 Apr 2018 15:51:57 +0200
Message-Id: <20180422135137.450850423@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454928419788198?=
X-GMAIL-MSGID: =?utf-8?q?1598455473983525517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 70e80655f58e17a2e38e577e1b4fa7a8c99619a0 upstream.

It seems this is a copy-paste error and that the proper variable to use
in this particular case is _sha512_ instead of _md5_.

Addresses-Coverity-ID: 1465358 ("Copy-paste error")
Fixes: 1c6614d229e7 ("CIFS: add sha512 secmech")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsencrypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -829,7 +829,7 @@ cifs_crypto_secmech_release(struct TCP_S
 		server->secmech.md5 = NULL;
 	}
 
-	if (server->secmech.md5) {
+	if (server->secmech.sha512) {
 		crypto_free_shash(server->secmech.sha512);
 		server->secmech.sha512 = NULL;
 	}
