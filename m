Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QXK5E6/5/sWGpggHZZAu54PNQWPWSjllRGEtrwmtBGcseKSf5rQkx9jrNKDkHGF+4gOZi
ARC-Seal: i=1; a=rsa-sha256; t=1523021945; cv=none;
        d=google.com; s=arc-20160816;
        b=Bfi8IuRkumk6he1alLhLFrRSua0GxgoDieD35RqxnlNszd+xtD3tMhdFgMsTA2nUmA
         FlGuR8fVRB2Gau2MvAIowPvPbeMAKvHhXskKg6j1mq3hJD+rVAv/R9evEzUV/5oukYI0
         h1Ie5u1fYOVOXu2tdniZ2NR9WrOygsUX6musW5N3TFdGosaYlqdK7S7YQ2G6Db9cL0Cy
         rHzXW6zAs1CBmupLYtEsvXPCZ1UZcnMOsvT1ETkXIzH+OnTJqb9XOVlU4ZbSn1lGCFnr
         wuKzmKMoybCjkYp5pmfw+D8VbP4Ul6maqiSeWzDZyt3AuMfzauh5rFNTl3L5DEEXAxa8
         qqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ydX14m9p0/84dVPbDgd1pEcQeAFvnqnLy3yA/eOjlBI=;
        b=wec47UP8uJhUJlBrSq9YuEA0r19Hyl+DMkmManifr+HDsJwN8gITu4Rqm1F7JP9RDk
         KwFHhADQRxWUOj63hwwbV+Cms663BsjYXTdPjH43iA3KTJ9pHUQtC06cyQGa7CGyK8ea
         okoQDEY7w+yMCwmIIacLkff1btkw5oP/MJt5PMu1/8S6zG5qzpLTXgQB5H9C7i1lsb2r
         ZiJ2m5bMAu/6DltodvmXppUYAqsiwE5pnteuxLV615GmZyXawVvzRPkq/DlhOM/AANGL
         /C/RKeTkb6YpSdo2rHfVpNWVZ060LCoMGnF7/xEqRuZzHpDtI9UBdF22+g05GdJ//x9/
         oZZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.14 42/67] mei: remove dev_err message on an unsupported ioctl
Date: Fri,  6 Apr 2018 15:24:12 +0200
Message-Id: <20180406084347.079689948@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003580077452612?=
X-GMAIL-MSGID: =?utf-8?q?1597004260072753200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -507,7 +507,6 @@ static long mei_ioctl(struct file *file,
 		break;
 
 	default:
-		dev_err(dev->dev, ": unsupported ioctl %d.\n", cmd);
 		rets = -ENOIOCTLCMD;
 	}
 
