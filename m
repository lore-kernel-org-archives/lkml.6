Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226TMOlRNoWpEfA7I84rJi+SanHQOoBe3Q0b/sLf3oBktEbWcC1C1IQQA15mIPb92phJ9svi
ARC-Seal: i=1; a=rsa-sha256; t=1519411159; cv=none;
        d=google.com; s=arc-20160816;
        b=HKlLcqR1MUUkGtMFuiLSXH+rT/a3bcZDIT4B4tPQsC8MzH+0K3dCtqTqpfIhsdeA2j
         uc+e6JKZjS4pddbW2/L0yOin1JXu8TGXDo0whXnQj9OuEct/zzuK1sRcjCr5VObBZJgq
         GqJXyr+8ZZSsDrGrdJUyK8r31PkrOJlDDghUCFwsc2xw6lUlPW384ZL6gCBX8lCxfnkt
         03+JEfyNj8fzXm8E3VjkHIMGZGY5h6bMKGXMYrscN19kmiZcOGkldxmNnekRQtzT3arJ
         qq4ec6P0nyQojmM6D4bPkLio82hiP+EBxYsdMMDqQCzFRVXXnV40dchrnv8GRzzrn/+i
         d1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AoIFyqeYi2X6Nr0P0knce6xRQuPv12RdlcgtAm3TWwQ=;
        b=ju/jpNhpildpaqy6pl2cvmPMZ/o6byAGwNImfX5N47AJYVESQ97DXHn13wnwFXQWp2
         HXq9YSHqSqeJKM7LeYwB96JHg3xIOe0VFt/iSbxJfbXYsSKbu7yX42WobtzQwEuMe8fH
         RMeCTwrMG1lucVVO0kgB26ZeX3yE9nOqerUKlfdsUWnXMyf+JgXXP2viUDJMDXTNMa9T
         KVVWKx7ikZ/WVqRMlMH/t+8Ig3sNfbTQ/mFJmjpegH/epYQxsJfzCE3lq2yT+AnOtxAG
         /wB1Yi/d0IDkxhNvrQf2H3l8ueNjbuxDxj7nN6+waH/xeLatlZNDjuf/kQNoUUPXRniK
         isWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 4.4 141/193] [media] v4l: remove MEDIA_TUNER dependency for VIDEO_TUNER
Date: Fri, 23 Feb 2018 19:26:14 +0100
Message-Id: <20180223170347.938119989@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218076475754307?=
X-GMAIL-MSGID: =?utf-8?q?1593218076475754307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 7c8fe516bd81d991feb73ccd969ec29850af3013 upstream.

em28xx selects VIDEO_TUNER, which has a dependency on MEDIA_TUNER,
so we get a Kconfig warning if that is disabled:

warning: (VIDEO_PVRUSB2 && VIDEO_USBVISION && VIDEO_GO7007 && VIDEO_AU0828_V4L2 && VIDEO_CX231XX && VIDEO_TM6000 && VIDEO_EM28XX && VIDEO_IVTV && VIDEO_MXB && VIDEO_CX18 && VIDEO_CX23885 && VIDEO_CX88 && VIDEO_BT848 && VIDEO_SAA7134 && VIDEO_SAA7164) selects VIDEO_TUNER which has unmet direct dependencies (MEDIA_SUPPORT && MEDIA_TUNER)

VIDEO_TUNER does not actually depend on MEDIA_TUNER, and the
dependency does nothing except cause the above warning, so let's
remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/media/v4l2-core/Kconfig
+++ b/drivers/media/v4l2-core/Kconfig
@@ -37,7 +37,6 @@ config VIDEO_PCI_SKELETON
 # Used by drivers that need tuner.ko
 config VIDEO_TUNER
 	tristate
-	depends on MEDIA_TUNER
 
 # Used by drivers that need v4l2-mem2mem.ko
 config V4L2_MEM2MEM_DEV
