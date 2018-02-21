Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2245weG7dvT3zwZalxNZQ4dr1TpEc6NkRVUUj/vtGhi3OV9BMxiAsnm+B6YFB8CNNSBidc18
ARC-Seal: i=1; a=rsa-sha256; t=1519218186; cv=none;
        d=google.com; s=arc-20160816;
        b=rBhbRFS+itxnkbYBEUo/ICcS9YAowXh7EP8C+oE2SgFEjwFlzEfj3ZvjecFm8hg/bq
         7MpzL1I/J7gcQ/cJKHHXvGBSJxBrGzVXRPxeoDK4egRzsqNdJh26cMauzwGlLtJRSpOZ
         oeyu+vUcVVM/y3cKTgSAQbVJh2bfAsWq0sZ2Mqsb6To7OLPeHrudvzEZM+gEkh3ka0M7
         OUvgA++eV41tahwH7iIGoDTh2bXejjlwVgWv/TiFw1gqPP3/wvMKpWpIpLmKhpH3QYok
         v1t5PQhdnDfCuwYv5fHrKiwPClVsf+e6ZooGl2+EwNApRDynp3VOh4YZYUqpk521BU6B
         pzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/GNbOD8zhIkuRclA7H++djOgjle9dx2/usSj4X1gDB0=;
        b=ZzGkxrpszbsfNeDpT105OCHZksNn37tGO7qPUAvF17qAF5jeZ0TJcrvkYk3z4Xkor1
         bgXuFXGC9StNcAZUE5bpRtZEhKIaGws9+sKScwNkk+De/DOMxQfAf6inNePQXw23YZzQ
         0a5bRJVckKFdDuWZkz8nldtjbO1j53OjkvuTF/IasaQSd9Xhu/fws3p/ef8Q48R7w56R
         SGMmEuBZRDs1+Nmlnt8tr4aZykuJdh9zsVbYYjoZCvWU579kOnjeN2kBC5/vpP0bMcyi
         xzhsiLf94FiMZ4qmqiiGx0jV4qDZX4woX2KtZbx/YDkOxWaTT3i5mbUQ+QLJNWE2ZE7t
         7q3A==
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
Subject: [PATCH 4.14 118/167] rbd: whitelist RBD_FEATURE_OPERATIONS feature bit
Date: Wed, 21 Feb 2018 13:48:49 +0100
Message-Id: <20180221124530.937345854@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015728324035230?=
X-GMAIL-MSGID: =?utf-8?q?1593015728324035230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
