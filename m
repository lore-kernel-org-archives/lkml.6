Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+SctkrwkeBKgc5wMJvqZ5YsnWmRmMhgSGG0cHyrreRHr5i/SdOV9QTsLuLXP6MaDIv7VPF
ARC-Seal: i=1; a=rsa-sha256; t=1523021756; cv=none;
        d=google.com; s=arc-20160816;
        b=znZ18mpk44X4MdbKaCI7xEX1ciwXaRM9eIPuZDtXEVXTwAbb5mY2wYmqwSWH9y7eaR
         gNGmh4tAFHnHWxpMna+RZlCdiRaFT/kogilD/4OHWlWWYjw+M4hWd4ggDSH98M0Dfv/T
         oFLRMjtzmXSvuM+EwaqW0y5lbylANPS58a1YMuylLwn7umyqmLLfxInkBYu8l5o+USBB
         pj6PgWKJxrC//eUyJfef1B3C3/joq29apGI6LSZ1GbNlH5nUJNKNpZWrzPoOukl41FvK
         XqJokMvk1meI9f6KzEfTesl+UhLaV9+8s2aRcoY26gJgR4JTZFX/OcDu7dydbFs33s7h
         B+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2PvrT6SXtZ4oFEwUW1yGRV1/2ViYuzyEv7rktaNe5RY=;
        b=NGLgJyRfpezSWOuvkL4l5tdSpDl7dp1u1lIwEAExvXvETGbOqMnVYtMw4dWNLsOW5o
         gaBfaijGceAy7UqDnZnLivR00rW7B5NuwtG7GmzMkg8vVnCpZdQu+9yUieyfp9QVWOMu
         Gs8K1q8WQUv2pzjOIn+XI2P6ahykRRy0DsGcAtR2b83RbvTEg/Dy2l0+YJDC7gShzxW2
         j5RK3G4jmOMs/qQPLwY+beyGnm/2WohcjclE9WHG0lV9XOiRKw8E9TZQOv5g0JNwA/js
         eOUxw6BKhZPrkg00akyD3yQOW6xjCX/bt/rIUewwicFds7H/Vfrc5inSWDgCmR0GkiNp
         I+Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.9 080/102] mei: remove dev_err message on an unsupported ioctl
Date: Fri,  6 Apr 2018 15:24:01 +0200
Message-Id: <20180406084342.741589643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003580077452612?=
X-GMAIL-MSGID: =?utf-8?q?1597004061230854548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit bb0829a741792b56c908d7745bc0b2b540293bcc upstream.

Currently the driver spams the kernel log on unsupported ioctls which is
unnecessary as the ioctl returns -ENOIOCTLCMD to indicate this anyway.
I suspect this was originally for debugging purposes but it really is not
required so remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/main.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -551,7 +551,6 @@ static long mei_ioctl(struct file *file,
 		break;
 
 	default:
-		dev_err(dev->dev, ": unsupported ioctl %d.\n", cmd);
 		rets = -ENOIOCTLCMD;
 	}
 
