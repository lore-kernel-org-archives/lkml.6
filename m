Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Sthe05tR9mOfqKxr1whQenW3mfPI66DcIhUY1MpD3Td0l6396EJGu7XSsUHKakZiYsUgf
ARC-Seal: i=1; a=rsa-sha256; t=1517591606; cv=none;
        d=google.com; s=arc-20160816;
        b=rfqxH0pO7yaUoCcq8JnFgY7CHeS9TOKcOSY7EJSas33M8RuUNWZxY5j7gIJJHeHapD
         BOGxiblf+3JMuG6Vu+qvoEJOKlUScdvAhykAe6o5qkJqpQaVA2Et7OOvqfK36Qoao5gc
         J3LXN/y8CKstP+qJ23+kEOSNiHMJUGa6HcyfKAAG7oC0jwi0WEccMhQ4GasXjAC0AOQ0
         C9olP6NE6XUH+dsqCAA91xQ0FSHrOrysBp/45d9GL3JIa/S1Xr1Kq7GyI+EbuyQZFQXJ
         84qjkWKaoFjAB5KEg6fbIeuYLKLbI18yx/M1XlouhfPY2zLhZVqkhYpzDwT/J9MfEZRE
         8OkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YVLELla9xfzOF+vwxqy5QcqIc2SYegi14EePlJ22eqY=;
        b=IYT7jSnY4/hd1CInSZOMYoXzSCPWQlBbvAI26VlZl+QkWACpEdY3HdeaDSxGlBDjSs
         GL4n9f9uwgYkb3+4ucToHVEUKvCLfa+wlWcE7rfxeZ+/eOc164gDwYZhYvogd4MOQxaT
         Q4wFKLP+lozS/nbG3R/bBV3S5YRq50SKVIDK6MnCGep1bqL3TxogYdUAN5oy5cUYe0Td
         iJ2rokuF8GQX8HSZ90B7JamcgqzSrWmYcI8n3m9nMEhfWgbWvzlmnysyYmdEdR0GTA3r
         Hw7S6ffhjvQ4CxW6vD0s98aCQZ1MxSFMTLNR9VevbBO53ketOhWb98RxymNuQnx5pUsM
         VOcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 108/156] drm/bridge: tc358767: fix DP0_MISC register set
Date: Fri,  2 Feb 2018 17:58:09 +0100
Message-Id: <20180202140845.072909468@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309721522702501?=
X-GMAIL-MSGID: =?utf-8?q?1591310136193851077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit f3b8adbe1911f66fd3cab1aaa74f0f66b7ceda25 ]

Remove shift from TU_SIZE_RECOMMENDED define as it used to
calculate max_tu_symbols.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-4-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -97,7 +97,7 @@
 #define DP0_ACTIVEVAL		0x0650
 #define DP0_SYNCVAL		0x0654
 #define DP0_MISC		0x0658
-#define TU_SIZE_RECOMMENDED		(0x3f << 16) /* LSCLK cycles per TU */
+#define TU_SIZE_RECOMMENDED		(63) /* LSCLK cycles per TU */
 #define BPC_6				(0 << 5)
 #define BPC_8				(1 << 5)
 
@@ -716,7 +716,8 @@ static int tc_set_video_mode(struct tc_d
 	 * Must be less than tu_size.
 	 */
 	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
-	tc_write(DP0_MISC, (max_tu_symbol << 23) | TU_SIZE_RECOMMENDED | BPC_8);
+	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
+			   BPC_8);
 
 	return 0;
 err:
