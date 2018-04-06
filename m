Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/3siOcujMLd7FTenyDGTe4LkS8owJkEjy4zeq4ck2sFnYFiaGepDIPuNaCXz/FB6bImsZV
ARC-Seal: i=1; a=rsa-sha256; t=1523022153; cv=none;
        d=google.com; s=arc-20160816;
        b=M5hpp/7YCnb8M/AlATlx1mhXqQZNs6iUjx/BYmbFQlsyg3kB7i6k5cFcZuRRvbmHE3
         cOSq6tZfQ9AW4YOlBZN/UH7INsNciXTKAO7WnqCrnvzmg/Bdr4Glc2I27Q5mZuzLTsyk
         VjcFeDW/SrrPnt6M7s6Wt61wRwnLZfSZihEILAacaJRVgy4x+SGjsUcW6zJJr3HJ59gE
         hiclg4BF9CMhzCEXRd8SBhlDVUnJSAYy526XooqrJr9//nhokx1AtC5XTsD3leFkZRef
         0hgu4clYMX34AVQOVeEQsYar3qi/3cdTavHhZ2fM2nGquZeWSzW26iNgEzwqiHqzcfQ4
         hXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LLb/3uOLtx9ddPwcJfApz5excuX/k2hhXSNwZnbUivs=;
        b=k1DgQNZ5I2cO28v8aKu7OsnwEsmdU/DM6220z1L6M4y3gcgPj/FiGSUNXiGPI6AQ4r
         w3PuULlZRqhEmff7lodhLndburVD6GtYf8xyO5ksA6oihmdpL6Rxe5CP/8pgm7FNBant
         I0FqLXCXE9F9W1yYfSSC/92+v1vswiyH90ouMlIhSzO4cgCPZUnylHffQj9DXz3bmB2d
         W+sXMx77TxYjekJyfGqj+BtdQlAMs05kMpawXUg3hgCR1V+m6BbmHEG5Ypg5aOwES7ES
         h6rj6DzSUsZcijnIUUTt8sSHomck9xGbML9dA9pdtbkHsKZkbIugNuQjm1vwEC4gbHEp
         kJUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.15 45/72] mei: remove dev_err message on an unsupported ioctl
Date: Fri,  6 Apr 2018 15:24:20 +0200
Message-Id: <20180406084352.750538432@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003580077452612?=
X-GMAIL-MSGID: =?utf-8?q?1597004477537210612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
