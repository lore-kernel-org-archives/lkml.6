Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/3XCpeQOJ08ykyMWejoUJMpLoQxSPo36b9kIdwcj/VfCM/2cMMiszHPUWC8uIvo6+7BuC+
ARC-Seal: i=1; a=rsa-sha256; t=1523021281; cv=none;
        d=google.com; s=arc-20160816;
        b=eqwf5mBkk9lYnM8MMUmNuRF20nzOgqJUMUd10pnHhtV4aBtWbLYAizgBUUMQqV2MCh
         2C+59k5BdQrpYJyxyQIShddnOTLlS0Gva8iMr+4Jy3xlblH6FBP6XMdiqOPFQkvYbZC+
         qx2FMpoSdt0MFEL4se59NXaTQZlevcv4A3ZmZgwlRwYx4eO6R8PFOXVk9+9H+C9nerS+
         at4GZ/45YHRI/FluX3XyP9rY0/E8H2MjOFF2G/jotJm1paHLe+UEtl6vrxBG/0M0yltI
         6eXSuup81JSOx67JJxeXJSgyU9BH2rBTX2GxsIPK71JANWl0ZvrzxNgM19L6Fp6yR63r
         u39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YE/GpTWe2Lr8juEP255+W+YZTQmqFuz6SF7zDKojg8I=;
        b=SClHLiCAI2H7u/qcdCpNlWBxdklCLL+MIRPXF52709UvfQWyfQGGRmSy8ZyInpyrQt
         GCEaGkLE5Razfy1maJePlRyg9B03akIw5I4eihIcskS0WxgBkvcBvcwg25/eLsUfVpue
         wcR7R96ErVywRqb8aXJMEgkq92O16ddNiAGwitJc59uSdfsSU2AlnQWu0h6oul+XJOGe
         HIPMUboWtnAPA3pCuQoeMiewoUiJFeAH1Oi5VzpNbABilTyKXWlJzWOHio9mHaYH6/8R
         nNHMOWKxivCSX+G/zuquEMA3zetwjYmASUI5h3V9deMj7gJHeRPkylT7rRC1o6qmZENF
         LjiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 3.18 73/93] media: v4l2-compat-ioctl32: use compat_u64 for video standard
Date: Fri,  6 Apr 2018 15:23:42 +0200
Message-Id: <20180406084228.264324948@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003563316207696?=
X-GMAIL-MSGID: =?utf-8?q?1597003563316207696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Instead of using the "v4l2_std_id" typedef, use compat_u64,
as otherwise it fails to properly handle some ioctls.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -686,7 +686,7 @@ struct v4l2_input32 {
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
 	__u32        tuner;             /*  Associated tuner */
-	v4l2_std_id  std;
+	compat_u64   std;
 	__u32	     status;
 	__u32	     capabilities;
 	__u32	     reserved[3];
