Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227qpWJa0n0UD0vIBpsSm2JHndOjB8AktqPW7LeguGEgzASe6W2EMk0qLlOWpzUbNgF2+Qhs
ARC-Seal: i=1; a=rsa-sha256; t=1518709437; cv=none;
        d=google.com; s=arc-20160816;
        b=RFxwy8IxzgFon7/D72rKLFDttmJsjYsE8UCnAUpUkV/aBG5uqZdB/M12U9qtMHUfHH
         6v2QeqTzbhkECQ4mmJKG9CTLApMxpkxLQ4sAIInHCoXXj00eQreqv3YYduG4Mbe6k5jo
         t4Jf1Xg+HguFS33hv3A+b6gtRY7co4Bvaa4ta6g7LPdulUuYs9nwNw7ti9xeRTaUbKfl
         HaAD/pZBp5cJf7IeQ/xO4bVxYKLlnyz2tuBOVEpUwyPNFdVSPfSN/IW2n9KCtlYjHVNH
         racurH4iKUD0Is2MizOGmhy+C15ODIG7EupxvtVarzLCBls3l7ncDcpjfDl9v/swIKN7
         KjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nTnYIxmiw5MxBlaxGN1Yl24xTFZhXs31377RJlqt4WQ=;
        b=oBw6qTmXIbHv6GI8Dq4DEx+lkTAVkHtacncP5zfJslpdddJaLFUbXDWPqYrGLkNyiT
         iCpdPcm/w1oJM0irG07ChDCpSWVDQdY/FL4oNr8w4NBHoNehayssNx5MPBWSR1Mh6Kjp
         X8FdF5s/0RsJrW5zp1KcFcPk2oARP3t4QuWMdm5V0ZR36h2aKv5GJe9FoXEZ5WBtldRL
         6SjWYqlhm7Qw24YhIftfnF1nogSae14dYBLOmt52q6rgmltbZpNGRuOLnKdzDDcx6uib
         2pnkdIMkMwxNPJDqMBTc98f3p2JpYRviUrlHquZO58W561laZCNY4kf3KHbUecvZtFZj
         AKSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 116/202] media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
Date: Thu, 15 Feb 2018 16:16:56 +0100
Message-Id: <20180215151719.313716914@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481000340552467?=
X-GMAIL-MSGID: =?utf-8?q?1592482267479514980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
