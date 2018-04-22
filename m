Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JP8N6Cwu0UAjsGvVddkpvCwFcIWIQcLdxis0QIheGhYGTZx4mwvmGpSAfQzmoNd+/UmGk
ARC-Seal: i=1; a=rsa-sha256; t=1524405411; cv=none;
        d=google.com; s=arc-20160816;
        b=dHBavlHum20lDUY1be6vG0ytgdLpkae1PFTDtreWBti1/X7ZeeHgArhONRTzCp03Mm
         G180gG0SVGZ9u60qbTrSlv0E4Ops1IsWorVZXCt3jLhrBabmotJ49a4yRfVDXhmh6ZbP
         TQvifBahHRpFVG54prZ+j9MP9p7/PoZgu1fF3LH/caGJUa+SQPbn7An0KSC2PqkyOQbx
         2nWTfOWSHRXHwnXwSvajwY/zDDYYKMrFUaeBue23doGaOAaM3kfmySxxS7GiF0SpJsm6
         hBr3jDHBHrUqo/pqcMTtln1aQeuSHgR6+9CgfW5t5m9fQ/OUmR1e6EREaA0gHmA2DH7o
         g0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OD2wnv0Mi5QoqLn3dhe5/Fl/OjS5xmT7+2hzFwAV3nI=;
        b=Wa/c2CBgDbBXiIvkqihDMHOHdGKR10HeV2uuTHv+g9IC3xkhVOHzz2upZQpzwEzasR
         ZoVGxbRvrZIBjOlnVEqwCATNDWjHVRInRlhRHfmWAU85RS33ekh2956/WMwK67kREUpH
         c7vI3CvGJL5RcY+UxSdGcB8VHPbleIUC425hQsIv0gRIWUcxKrl/XkBVm20H66jH6uoj
         gKaOFeQ0I0jezQc5QOlNLUXO/KY3WKK66Ppn6wwrPD/C7qhO+7RJ6ydolybmo0Al2XuC
         P/Js0d7c6Mo1ayHO2qp9JhieK/YDgncD9CpZbg5+Nhz9K9qjAqctnQ14V4nnAbVytv3r
         /b7w==
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
Subject: [PATCH 4.16 057/196] CIFS: fix sha512 check in cifs_crypto_secmech_release
Date: Sun, 22 Apr 2018 15:51:17 +0200
Message-Id: <20180422135107.162407950@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454928419788198?=
X-GMAIL-MSGID: =?utf-8?q?1598454928419788198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
