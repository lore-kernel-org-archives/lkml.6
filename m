Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/jBYS/UT8swDzQgUjAvMyuXNtP9aNuhYNu9gOwa5l8f4DoyruaMwNLFY49QbxiQON50il6
ARC-Seal: i=1; a=rsa-sha256; t=1523021241; cv=none;
        d=google.com; s=arc-20160816;
        b=aK2sod9m4k3YCAF+7kNdaLXbOYii3V28sHEV2Z54wTioFrPNSsfSkSUMl2s4yk44f0
         0lgXzv6I+3T9JPtFZw8Bzjl+wz2XTvVYWu7oNaqbP7GodtS0erFxZwXEl5UQvCZ3L4+b
         cqevogE4735kyu4qc7Qrr1ZjptPVpKbYr/7KjfFK4ymRplSTQ7rvRgrF4sLY0cPzz5t3
         feYOb4flTCcf34pUQ8DE8EuLXj1rr9Qp+Ki6zkW5yq1EgcDWKxcxi2JvQLHs7hp3GUoq
         bIJ4UyVLd87z1DRCwUrH3D594iRGnKT373gJ1RQjuQbcmg1DKlfmtq+Mnwf5afXwNaRL
         1DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6heiHL65JH+uLhFqzmkcR6T2CjIzmuamkFx07fuKq6o=;
        b=ijBNRk1EnQ7R4De8/oxBh06qDFFMsfKYnMt9COwpJ4nB9NjStpzaXhy4cCLc5IPhUF
         nX31nFcXB2dlJU0EOiRelE2OPemcdRr6VVHuwyULjVoYMbrQx25gmp2QIGdI4gOUnKz+
         cM2euZsjD0qO2qwrMWf7Lk0jNy7kXEREgj6d/mIXnXdQyeKZoMHgrTdEqYToXwM99Tdt
         YFFVnmSxDBUGvLQhCq2rb6BKndaQ19OJl2ijd9YOsCGrVlz6pspQs9NJ8bxG0+41e89u
         ohpGdY5cDnRmrq+xXsykUdf/Hdn4LXlgGoxyKryMFvZnoKgSdASpJbvxQaXwRQyZh0e5
         /BgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 3.18 59/93] media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
Date: Fri,  6 Apr 2018 15:23:28 +0200
Message-Id: <20180406084227.481318689@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003521465317722?=
X-GMAIL-MSGID: =?utf-8?q?1597003521465317722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 3ee6d040719ae09110e5cdf24d5386abe5d1b776 upstream.

The result of the VIDIOC_PREPARE_BUF ioctl was never copied back
to userspace since it was missing in the switch.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: <stable@vger.kernel.org>      # for v4.15 and up
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -996,6 +996,7 @@ static long do_video_ioctl(struct file *
 		err = put_v4l2_create32(&karg.v2crt, up);
 		break;
 
+	case VIDIOC_PREPARE_BUF:
 	case VIDIOC_QUERYBUF:
 	case VIDIOC_QBUF:
 	case VIDIOC_DQBUF:
