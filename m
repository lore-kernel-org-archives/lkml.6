Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226QwIzY6tfGWSGLOK12WPa9wCakCOaEa2afh1Ieeo1aI7jiRtxwym+6ewlyfCCi8Uxy9zxd
ARC-Seal: i=1; a=rsa-sha256; t=1519217675; cv=none;
        d=google.com; s=arc-20160816;
        b=Y4/jHkplCGvWJ/2VQwOmY7ddXPKRU9LSx3ubj3S02FRH2NTPwYoAu8DMlB8rPrGp/a
         8PRQDB6YfRwsm6YS30uR1OMMJYDvxusRbH0vS2mFg4KXC/ZKugmW+/LmoyrU8kYK7tSj
         x37NLr1QqDX3sFsNGj1JNghAVTALB62jXd6whg0fB82G3KGJ8CCidXFFebyEqC8CiGqn
         vZ8b6hHtxo5MH+PIM8+ZjsYrXnnTOp9QV2fFxl9c9gUHNDYjYFEHgcfqn1Q0LPOiavST
         yB4ZOMmHXFiVQVt0xdHHN7texSSdm4NolheaEG3rg5zQSQo177pkyDqLw3PhETWH6wvH
         WrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=koTm9ym7j0cneedkKJJR65va3iL0zQBSl+rCb36kBhg=;
        b=R1LXwpytw3NR76ojHY/pugG7Rs2soHdEGtHjWoa7gtXRYnMrKlzLIqrewA1XOPN125
         Psd9jXrkdOAaABzHcA5Lj1I92Mn1DyiRxlNiby3DHa6bV3vE8rSIOpgfJo2YgOyXRJlg
         EPJKeQItbeY6qZWaDd2vY1uTZEcytff03ir5YQcwN8FUkUYN+Dtz0f4TMXhcSRVg/zOQ
         IhF5R+FpNQx5YadlOKCEQJh90fJC4mgbVE8BLoGrGOjrlxdsIYf+pyJhG0PQ1GyVFUSH
         NzoXLwoJFj7u1UMaj2yBe2YvRYc08G8N4IFyWGWs8p5pcnCBzkSdlBNQHQJvEthnqyk3
         KIFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicolas Pitre <nico@linaro.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.9 15/77] console/dummy: leave .con_font_get set to NULL
Date: Wed, 21 Feb 2018 13:48:24 +0100
Message-Id: <20180221124432.813376426@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014631678388583?=
X-GMAIL-MSGID: =?utf-8?q?1593015193335321475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 724ba8b30b044aa0d94b1cd374fc15806cdd6f18 upstream.

When this method is set, the caller expects struct console_font fields
to be properly initialized when it returns. Leave it unset otherwise
nonsensical (leaked kernel stack) values are returned to user space.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/console/dummycon.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -67,7 +67,6 @@ const struct consw dummy_con = {
     .con_switch =	DUMMY,
     .con_blank =	DUMMY,
     .con_font_set =	DUMMY,
-    .con_font_get =	DUMMY,
     .con_font_default =	DUMMY,
     .con_font_copy =	DUMMY,
 };
