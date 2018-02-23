Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtmpVIJHPnl5z/+O4y9cMTIjMOX4uElIjFL26E7xA23acn0E9q3S3QwuStheR7g/bdeS5qa
ARC-Seal: i=1; a=rsa-sha256; t=1519411202; cv=none;
        d=google.com; s=arc-20160816;
        b=y55kxHA/08X3cRgRa0nM748CrWK93Rm7cZCQaAYWp0JPWZX4UvmXKwNeMkk3/V7DAe
         uti72nJZERUO2ZbEzg23LfZhMpT1cM7D+f1gpFFmUKaDrJsPRS6o5Ld0UNjSQMto/cJA
         IyuEtG09B14hj5M0fR8J6GqVx7Z7bsCTw25dswXGKWzWTw/g5HqKJkUUrWSNPCab1baw
         1HE4mMesZ/BkjaYKBDb7CNr74utYLL6s0kIyLzDJPXCeKbsto/BgLQHKpNogP/hV8Qry
         88yzGrleOYMXoYB9YM33COCjDhom+v07bGDz+IS5OPJerOf4d1PW0k4Q+4dqyv8zJUFS
         uwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/S/54jP2KIVcMTz5zoRdb38yaY0oWOufh44eeJsf6CY=;
        b=AizM9rJ7SQhEOchzBDG3q/4vmZx4KexV3l7Ie5iF5rfaHL5MqvTTG/98AlRLW38tBZ
         y6iWQZ7VxaOcSkIGxo7pOuWERMXNSIWBuBjpx53nMocXIYDwsmJ7fnyeMUjMTs1zKLzs
         4xO6GgFuAY0In0SEzlgh9R2RHzTcXCAG8G31IdXlJijV3v16Ny9CDiIuIwTN/z0PtuAr
         nK9KkNaPQfaPFUVQX/MGVRr3EfuINbNBuh8ir3sz2TNTx+l+duXUIRTVAo/Blm0fQ50F
         RvbSR1wTY2LC2IcvzZCBe13RdJNZcQ0PP8B2V7nYQAeiI957EXKhuOn3uue7HanrLsGu
         W19Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 4.4 119/193] tc1100-wmi: fix build warning when CONFIG_PM not enabled
Date: Fri, 23 Feb 2018 19:25:52 +0100
Message-Id: <20180223170344.476822898@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218121602004888?=
X-GMAIL-MSGID: =?utf-8?q?1593218121602004888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 75d7e7d7a8f4966cb8b1da54a1c74fb2a97ae8fc upstream.

Conditionally declare suspend_data on CONFIG_PM to avoid
the following warning when CONFIG_OM is not enabled:

drivers/platform/x86/tc1100-wmi.c:55:27: warning:
  'suspend_data' defined but not used [-Wunused-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/tc1100-wmi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/platform/x86/tc1100-wmi.c
+++ b/drivers/platform/x86/tc1100-wmi.c
@@ -52,7 +52,9 @@ struct tc1100_data {
 	u32 jogdial;
 };
 
+#ifdef CONFIG_PM
 static struct tc1100_data suspend_data;
+#endif
 
 /* --------------------------------------------------------------------------
 				Device Management
