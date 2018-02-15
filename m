Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224liLORR4zu2Qcudu9y39Nxy2xoVKKqM1PfC4jP4E0aEZ9raPDBCg3tzvroKEVWYlNYj0CN
ARC-Seal: i=1; a=rsa-sha256; t=1518708926; cv=none;
        d=google.com; s=arc-20160816;
        b=jal6zfiD4P8QrQbJes5oE+Xbw/v1fsfyRKHhW+JQTGrJ9b2o5P0Ak82imf95JHdWKJ
         jzs7vr7eRnuT5C0sMXmH50tbBMkPafwLTeo8GceGqocBzaYMQNrjzHNY1B+fINoPc30s
         MOrVvmvMAuMBuUFN+JmaktN+bkexfG3t/yl1E+SUHjXkjH7WjLFltSTaJ2Z0zIEIoZC6
         /ygdB3GvXfOiFLeLLEsFvHiO/1ULC7zvMnKft2apHZC6U/P9E1Ag6ekVdwJxMoifDY+m
         1yzhSPC8sjg5imWJAx75esDklDuqb2dOJLQccykYf3Krcw3p8Go/ghjTMUCTEsOBoX5L
         Bo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YTI67nk9DvH1vqElyZf0RyvMN8u5vxGdGSWWhba2Hp4=;
        b=j0DoTzn58gX9SvfmR3ycxa51YIBpqmn6FOx7pcJ6ViCati8lJiaTWlXraJhy+gBlxp
         5mYGyjHtID/vk6ilgIo5XAjsI06J5cNGCefB/1vLR0sKgq6AOBbJcyIUshWl+2DiiOmk
         7SwmD2Gh6eq0N+ULYY7XRJYXvRjHeXG+6I8+CdVZsiX4HHPJT2l832JzueysJLCmj4Xe
         c609yjjLlFJlfEIaWBOho29lmGxftEX6qP7Z74RIAi4K5odflgxXjk0QsyGchm4lST7e
         tfXKHZkpUCm+LWxDmyIrCH67bywiDnS0v3p9mGAprdtLgQrg3jsEhlM2M00oCrdBa+s+
         OUgQ==
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
Subject: [PATCH 4.14 122/195] media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
Date: Thu, 15 Feb 2018 16:16:53 +0100
Message-Id: <20180215151711.804144613@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481000340552467?=
X-GMAIL-MSGID: =?utf-8?q?1592481730766322394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1052,6 +1052,7 @@ static long do_video_ioctl(struct file *
 		err = put_v4l2_create32(&karg.v2crt, up);
 		break;
 
+	case VIDIOC_PREPARE_BUF:
 	case VIDIOC_QUERYBUF:
 	case VIDIOC_QBUF:
 	case VIDIOC_DQBUF:
