Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224OgS6MsRSqcXeoRmEEfB77LYIjP4o9gXLOAASKd7iO/ZPHrPyLms3dDSh/w8uFLejlWW/C
ARC-Seal: i=1; a=rsa-sha256; t=1519218675; cv=none;
        d=google.com; s=arc-20160816;
        b=hU5ErefBnUTgPfvexl3DlmJx/E6xwoVtylC0Qy7h/8eENu/e0GOvZoCZvDc332qm1S
         yN8SB0XVJKKs1WFu5IYSPXaDUGLET0UHNBfBCcUkFo5rt5B9yiv0Ewafi+uVsOyT9p1g
         djg7kCEhx27WlQ9sp8jewF/T8TlVJSOvcM5WVr9GOPHacXwzFaxs7XfYmEHSsFH80mWU
         SVNOi8ukop58XH3Bh4lhNOy4jUn2SPDkFNZWqMZaFbk3/KpiX3uZ3HXSmhg8Mb9YJxOG
         A2KEdNEqFcOs+NpdIkfWB8sxZXtT9CT51KBms4VXsIp49ms9XqtHyVS4tjLXcmD6Aq0M
         cwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IeqjPyG8/A5sAZbMXgGQwLXU/DaJ/OATZa5WlQ+IkTI=;
        b=EYhUifvdDeyv1L2G7WtR8EW8IgAwNjMIyjYCljxnIuxxgmycJJbltN4f4yoFHuVpHk
         Z3hCQu4dnpvsuKVs3DYUVaxxgV1KLMTwsdvbHy9VY+83uHac+P9zIdqfsZ536xxyx6QD
         b34FRpFKK8GekzMW4KNxH457hoY7Hd9XxLDo08ySBgyVBTgicZ44H8UEz/BcnW237Tst
         hV6oAy2xmmR2cV0dR68IsvUapdTLQon8Ds+btlnRqBAGoLI1oHS71cslZFxwL9zaJ108
         d3MFdS9YpOr6B5xE0Sv3eV7I1ExwfuTvpobiL17u9iqyzKSqNGUEp/hndz5qTgtSBKqg
         UWqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.15 121/163] rbd: whitelist RBD_FEATURE_OPERATIONS feature bit
Date: Wed, 21 Feb 2018 13:49:10 +0100
Message-Id: <20180221124536.802226088@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015728324035230?=
X-GMAIL-MSGID: =?utf-8?q?1593016242019317136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit e573427a440fd67d3f522357d7ac901d59281948 upstream.

This feature bit restricts older clients from performing certain
maintenance operations against an image (e.g. clone, snap create).
krbd does not perform maintenance operations.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/rbd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -124,11 +124,13 @@ static int atomic_dec_return_safe(atomic
 #define RBD_FEATURE_STRIPINGV2		(1ULL<<1)
 #define RBD_FEATURE_EXCLUSIVE_LOCK	(1ULL<<2)
 #define RBD_FEATURE_DATA_POOL		(1ULL<<7)
+#define RBD_FEATURE_OPERATIONS		(1ULL<<8)
 
 #define RBD_FEATURES_ALL	(RBD_FEATURE_LAYERING |		\
 				 RBD_FEATURE_STRIPINGV2 |	\
 				 RBD_FEATURE_EXCLUSIVE_LOCK |	\
-				 RBD_FEATURE_DATA_POOL)
+				 RBD_FEATURE_DATA_POOL |	\
+				 RBD_FEATURE_OPERATIONS)
 
 /* Features supported by this (client software) implementation. */
 
