Return-Path: <starnight@g.ncu.edu.tw>
ARC-Seal: i=1; a=rsa-sha256; t=1526205307; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+7Pa1DlBIRGftmMj/zkeUc8V6F9MbLt2bWKx704XSjhEKIbEzQAhYRhIY8kXDcaLA
         YAJ2hZDflgBUMgaabiqnWPcVhs/4NCk7EKBRkgY4iN2PlD/Aij8Q9u+W8eJOMr2JEWPJ
         hlSbVeBvOSuf8wjVzLV1jMkUZX1qD+fPl9ItFqxVEPp40rY8VqXErpjjm17HVVxuF+Vg
         BPlXlYcPkj+HEYdR9GrtpZPnGOrBKeXJsW59xevKFsV8QlWTaRJpyVDneuUPf/17WGRv
         mRX+AP9CS99dZ6t79JT7Y8wcl75SzuJ1+76cwMDOqNr/OT13OjdtPiDLlzuxvVYjx9ou
         U6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=m7iw/FTQWqm2t9AyvEwTTxR21OlrwIZeJ4/l1FUN1nk=;
        b=FYlty2Wruce2Slt0RQTr3G/AmWE2DnAtKV6UemXWz1UTQbsMkc0xesqCTBykNqfORS
         Mqa/OtgwHEOjTO2N+fPUQM6XbI3KyWro6JpTh4eyIWvuMR6VV/cspFce1K7uvj1O7fa/
         m1bQ9T4LYmJhafeJXr+NbqqvxgzKDx0i4s0e/6U5HY7e3KI5tzc3fpQdLpzABqPReK6v
         vOLmL/zjGrgtCeWlqMlHgqwZw+Wo2+2jAVO4jlquMqalMRzF9Tgu71+5SaMNdSPoUj5V
         Q50LSYwf4logQ0zS6Lt2+bD37bs/hueafCQTZFVBBhZmA+YB/VKoLGritHnR6IvLyJLU
         AagQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@g.ncu.edu.tw header.s=google header.b=K1obxIM/;
       spf=pass (google.com: domain of starnight@g.ncu.edu.tw designates 209.85.220.65 as permitted sender) smtp.mailfrom=starnight@g.ncu.edu.tw
Authentication-Results: mx.google.com;
       dkim=pass header.i=@g.ncu.edu.tw header.s=google header.b=K1obxIM/;
       spf=pass (google.com: domain of starnight@g.ncu.edu.tw designates 209.85.220.65 as permitted sender) smtp.mailfrom=starnight@g.ncu.edu.tw
X-Google-Smtp-Source: AB8JxZrDt8EGrBrvYMGKV3Zsn2TOQuuqiy83e02HiCNtWg9noCU2G6bOMEgWy830mXbPFTpp8AYKcg==
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC PATCH] net: Remove a confusing comment of macro SIOCDEVPRIVATE
Date: Sun, 13 May 2018 17:54:58 +0800
Message-Id: <20180513095458.16148-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600342256765812470?=
X-GMAIL-MSGID: =?utf-8?q?1600342256765812470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I have been reading the NET related header files recently.  I found
there is a macro "#define SIOCDEVPRIVATE 0x89F0" defined in
include/uapi/linux/sockios.h which is useful for private controls of net
devices.  When I read this section:

/* Device private ioctl calls */

/*
 *	These 16 ioctls are available to devices via the do_ioctl() device
 *	vector. Each device should include this file and redefine these names
 *	as their own. Because these are device dependent it is a good idea
 *	_NOT_ to issue them to random objects and hope.
 *
 *	THESE IOCTLS ARE _DEPRECATED_ AND WILL DISAPPEAR IN 2.5.X -DaveM
 */

I notice there is a string in the comment:
"THESE IOCTLS ARE _DEPRECATED_ AND WILL DISAPPEAR IN 2.5.X -DaveM"
which makes me confused.  Because, there are still a lot of devices or
subsystems using this macro, for example, ethernet, appletalk,
usb/rtl8150 ..., etc.

Therefore, I make this patch to remove the confusing comment.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 include/uapi/linux/sockios.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/linux/sockios.h b/include/uapi/linux/sockios.h
index d393e9ed3964..c166f8c6b20f 100644
--- a/include/uapi/linux/sockios.h
+++ b/include/uapi/linux/sockios.h
@@ -139,8 +139,6 @@
  *	vector. Each device should include this file and redefine these names
  *	as their own. Because these are device dependent it is a good idea
  *	_NOT_ to issue them to random objects and hope.
- *
- *	THESE IOCTLS ARE _DEPRECATED_ AND WILL DISAPPEAR IN 2.5.X -DaveM
  */
  
 #define SIOCDEVPRIVATE	0x89F0	/* to 89FF */
-- 
2.17.0
