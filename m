Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+F8wL2+34OoAw4wWdgtjVe9HkI0cXIlXtAH0R+H6BRCxcBx3+XjN1+58cJRaDEIA3oagx1
ARC-Seal: i=1; a=rsa-sha256; t=1523021518; cv=none;
        d=google.com; s=arc-20160816;
        b=GhmuoPXjYoR5p/OamLKDG9/TKVueCCvzagMYf4oRbW+AsPf/U268j/2zAcE8jUC1ka
         p7jgMA3/x/GGcuG5kG6z6v0rlokYZ/lD/4PJz7Y/d69vJhlKjsAbntGhcwDxQ1rm9GYV
         7GSIGH2yWJWY6IgmYw9jW8Gk74xJpSwgl53n39Ib2Mo6iK9CMVBQd675vCSSQMtsMiyb
         YNG1CUIVd7TLPhQdXGEMlCYWJm/U6xwA2tUgGZp1PFTxhimDo6Va26COSDGrwEBHBSAz
         NaoY6Wjfa5vLn1eXRRYdftJfN7/9EhhVbjE9gUFTVQ2HuxH7+rQDjq51AEAVR3b4/Nst
         luog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1JWWXAzlo5V7npX/tyV6dOJoBb7Yj92QNFCqFu3FSYg=;
        b=BH3v7vMlt87D6C8lLiIzTacpACG0B0cTSDCNw3ukyilfM3Fu2FdMz8bp19yZk/949B
         LpMAmQmAbo8QZzd1+y5sjOC4Kv7Jq/MkDjWmW5leKfh1YmvfOgzKJgrmMD77+hfBxpRu
         gJkeEoYoeBHYwPJGZTlK6zsD/UDUBRVUtZgVlNeUmyPL16LUFaQ7MM9lfZWiBQDEhLbx
         QHEnJ4L64hvk4mnKv6bc+Vc+u6fhVkDpDFLEu4664Poxg6PBdxYzl/7PFAqyokBoWXgc
         ZxjDkF7ELeQL4fbF0xrGuohFih3MyKp7I4DMgvNzCAq6kA0+DZbCjI8YdkNINBz7nZvM
         Y92Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.4 48/72] mei: remove dev_err message on an unsupported ioctl
Date: Fri,  6 Apr 2018 15:23:49 +0200
Message-Id: <20180406084309.201096802@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003580077452612?=
X-GMAIL-MSGID: =?utf-8?q?1597003811738625560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -571,7 +571,6 @@ static long mei_ioctl(struct file *file,
 		break;
 
 	default:
-		dev_err(dev->dev, ": unsupported ioctl %d.\n", cmd);
 		rets = -ENOIOCTLCMD;
 	}
 
