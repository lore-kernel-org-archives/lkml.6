Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224wbi/iFXf7Sbe5Jp5wfLEheAXIYaSsDhgW8Mz3KpsUTZMbbnPA+gkpJmc/2904qJ34J7Xo
ARC-Seal: i=1; a=rsa-sha256; t=1518708425; cv=none;
        d=google.com; s=arc-20160816;
        b=l0rZB4w0gTyq3qDoCVfV4IjCmtrdooLz9RU6UirS+YXZxPQ8wOV/PQ7ZclZQlZBosF
         z6ePmB8B0mQW1nolXEr7Ca+J5Sqok2+CtPKFFX0h37xw+g2vhw3Ii3rx/7JVoCYRns0X
         68Hp2OT/hJTbcqr243VU9vU2BbW8gABZEC4X0oRAmKT6MZKKS73cl788g/83mAdiendS
         03g23ChdZAuX4mQ6RoDoWSuImWooxDlgia5NpMNvbzuCHEOwl2jtdsIC0TWjMJ1Yx8tO
         6g6UwOTLo4W6yFEVG2/UkBxOzlKMwUuF913nBpsdalEO1nx8Ktseo9r9H6oWKTxQusMC
         AcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ha+LworWsiSmYEbMskbChgfkNjOlvez8mbCjH5o7dz4=;
        b=Csg62mxCQXYrcOe5wKavSdbgPJ9vLAko1qZCAyW9yV8lUWAZnYRV/c7d1hRCaobdWy
         Vdxe3KvJAh+Y9+KjX982LChPTb1aCSZVOGki9WITDLmDAA+Bv761SsjbZ0Ku+e4HjiON
         tMZiOtSPsFCoNuoMw4lBLz8i9WDUsKEd0C51hMqxijogCc1bdwBAQjb/caTH4LcmEPLU
         IadFq9tclBviOCHI8NqYettVO2UDATCwE0htN/1F1sXNmcuKTq7DikM+w5K60AzEvCch
         Newl8gYXmsJPtHhwC5A29dHhPjzvFYV+zF81PWyCMjVWB2q6iJ/yoY5yyhbdfmoPibPy
         IwcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 37/88] media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
Date: Thu, 15 Feb 2018 16:17:04 +0100
Message-Id: <20180215151227.759764049@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481000340552467?=
X-GMAIL-MSGID: =?utf-8?q?1592481205731493783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 3ee6d040719ae09110e5cdf24d5386abe5d1b776 upstream.

The result of the VIDIOC_PREPARE_BUF ioctl was never copied back
to userspace since it was missing in the switch.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -1022,6 +1022,7 @@ static long do_video_ioctl(struct file *
 		err = put_v4l2_create32(&karg.v2crt, up);
 		break;
 
+	case VIDIOC_PREPARE_BUF:
 	case VIDIOC_QUERYBUF:
 	case VIDIOC_QBUF:
 	case VIDIOC_DQBUF:
