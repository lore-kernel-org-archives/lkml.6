Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48elhPSt0sxJggLWg0/kPeNYvQFSuDxJb5o4ti/rFFbI6w5njZsAbgM7ur5yarKpUY9Jv14
ARC-Seal: i=1; a=rsa-sha256; t=1523021262; cv=none;
        d=google.com; s=arc-20160816;
        b=N8vHCr87bU2lm1uGglj3kHPAUON9Cq0Ssi98M7yAG6vdIZco7zJOod12psAtUP0rPW
         m4V6AVBvKJuegUChnzaeNsPrAL5VKrOrPeAXuF+OsVtE1M4jtRzRO1KnKrNKLbzk6k81
         MfEyre2PmFm5IEc+I5Zcv7f1v9XZdC8oHSxijOg9kohQAv9nNKrOJKayJ5zUR36NM4HQ
         l7i6f0wOb6WxZDEjoggz8EHatXowIaEwfYLEiBtcsfDl1Ux4HOd02aNW9I0/53k/uwPZ
         xm7LiT386Kx+o2b6EVcdjeQiYYWLCrFUWUCrV0s/crTqLFSG2CMsp1qeyzBAIWxKxxzA
         3Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JASdtZLMakz8WQddREI40k4NTnXAPaclLESJ7u6Cj94=;
        b=jGYfKSdo3Zn+kkrSVf8JF6/OzVvy8+2XGHNpMeKJr1IhCMdX4Osrbl/Bd6Cph/bHG6
         AFMgGzIR7epNecYmu9VgSn9RiP9ABLh+iFHNlLk6QtMTHRZRpPC6GJn77C+bqDU/9lGV
         1+kEqlx0oJONWgrmqP6JOI4fIrtjEt7rAAw6fhLc/9LO20df5uuqz0PAuOq8YpJC/gq+
         XNvAlGpwBubHfi4zzVGVnrrFLMebY2rxKp7QYXGERyqYhhGMnHmzz+ATTKRAY0hF06fj
         nYAIHPquEJThSKpJh9itdy6n4Rf3uChI/df9xPeVwD97Ew9r1gyU45OfDOAyInBDlojG
         obZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Mentz <danielmentz@google.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 66/93] media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
Date: Fri,  6 Apr 2018 15:23:35 +0200
Message-Id: <20180406084227.860034662@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003543582258073?=
X-GMAIL-MSGID: =?utf-8?q?1597003543582258073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mentz <danielmentz@google.com>

commit 025a26fa14f8fd55d50ab284a30c016a5be953d0 upstream.

Commit b2787845fb91 ("V4L/DVB (5289): Add support for video output
overlays.") added the field global_alpha to struct v4l2_window but did
not update the compat layer accordingly. This change adds global_alpha
to struct v4l2_window32 and copies the value for global_alpha back and
forth.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -45,6 +45,7 @@ struct v4l2_window32 {
 	compat_caddr_t		clips; /* actually struct v4l2_clip32 * */
 	__u32			clipcount;
 	compat_caddr_t		bitmap;
+	__u8                    global_alpha;
 };
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
@@ -53,7 +54,8 @@ static int get_v4l2_window32(struct v4l2
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
 	    get_user(kp->chromakey, &up->chromakey) ||
-	    get_user(kp->clipcount, &up->clipcount))
+	    get_user(kp->clipcount, &up->clipcount) ||
+	    get_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
@@ -86,7 +88,8 @@ static int put_v4l2_window32(struct v4l2
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->chromakey, &up->chromakey) ||
-	    put_user(kp->clipcount, &up->clipcount))
+	    put_user(kp->clipcount, &up->clipcount) ||
+	    put_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	return 0;
 }
