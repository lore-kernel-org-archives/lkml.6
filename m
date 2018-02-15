Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224hw8PvGxbcS5WHVyr0FP67MtKpw1b9fVhOFQf0mFt6kvtU0fTmTNheSmjQzz+lK2K1FSOF
ARC-Seal: i=1; a=rsa-sha256; t=1518708380; cv=none;
        d=google.com; s=arc-20160816;
        b=fZlXiXreKKrl40Rt3KzYpanLLa4GoDc8zimBcG6h94PPP+StKowkM+HUoviYhTtmm8
         9sT7EE+mc8Pa2vRbflBhINpjYgCq1gb3RAzoftea22WSyw5w1ELfCJ3O6jZmCfsrIW7K
         sf7wEnlMKbt1hYiRaEtkQTamd3P8toOskCBYnKC1qOdbOvhafLxtic+ZtyEAfauIMcdC
         kHFS6e7IsZ4BzCCfzXC7cKQW1GdFJP735Q2ImSG6dTTlUP9zBDcTWkXR81feYGMC8Ben
         UpzlPiDvMMgtVy44iAigdJSWDgaLa31Tyktb93ASCpqSadPgFZW2CRwNvse+eXP4m9J8
         a2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pqYsFnKMAzhvZIi/evQahDArzsYY5EVKV8u9GrdxIb8=;
        b=zfs2Di/yYl2qPGnylUVZ2Pj2/TeBw9r8+LcmI+nfgzRqHdsJ9/Rsmk51XxEnqMr8dO
         UnFIODl8J3yr3lq8eRAjxNXxI4k2BwyQoQhsuVafctWCvMJQYQtmBw+8NU4vB5eY3WPs
         xE4KJCvgIyZMV7pOquPAZmhMwaviTaG0ZPYuq0WNf9V8CXQmbljRAjJJvsMNcAhoHURh
         tHMa28luyFAMz+PHLPSeHbH03xTpoXK1QrW9gbIMdq1r+BEib9M2TU2yuMwx0cipWE+Q
         qMtTc0dXpN2GWaliE/23tx7vfLGUGUUDlsPa7NvCQR634RMjNgNtawGFuwpdyphTz1zG
         6l0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Petr Cvek <petr.cvek@tul.cz>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 08/88] usb: gadget: uvc: Missing files for configfs interface
Date: Thu, 15 Feb 2018 16:16:35 +0100
Message-Id: <20180215151223.709062488@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481057520719450?=
X-GMAIL-MSGID: =?utf-8?q?1592481159221116334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Cvek <petr.cvek@tul.cz>

commit c8cd751060b149997b9de53a494fb1490ded72c5 upstream.

Commit 76e0da34c7ce ("usb-gadget/uvc: use per-attribute show and store
methods") caused a stringification of an undefined macro argument "aname",
so three UVC parameters (streaming_interval, streaming_maxpacket and
streaming_maxburst) were named "aname".

Add the definition of "aname" to the main macro and name the filenames as
originaly intended.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/uvc_configfs.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2140,7 +2140,7 @@ static struct configfs_item_operations u
 	.release		= uvc_attr_release,
 };
 
-#define UVCG_OPTS_ATTR(cname, conv, str2u, uxx, vnoc, limit)		\
+#define UVCG_OPTS_ATTR(cname, aname, conv, str2u, uxx, vnoc, limit)	\
 static ssize_t f_uvc_opts_##cname##_show(				\
 	struct config_item *item, char *page)				\
 {									\
@@ -2183,16 +2183,16 @@ end:									\
 	return ret;							\
 }									\
 									\
-UVC_ATTR(f_uvc_opts_, cname, aname)
+UVC_ATTR(f_uvc_opts_, cname, cname)
 
 #define identity_conv(x) (x)
 
-UVCG_OPTS_ATTR(streaming_interval, identity_conv, kstrtou8, u8, identity_conv,
-	       16);
-UVCG_OPTS_ATTR(streaming_maxpacket, le16_to_cpu, kstrtou16, u16, le16_to_cpu,
-	       3072);
-UVCG_OPTS_ATTR(streaming_maxburst, identity_conv, kstrtou8, u8, identity_conv,
-	       15);
+UVCG_OPTS_ATTR(streaming_interval, streaming_interval, identity_conv,
+	       kstrtou8, u8, identity_conv, 16);
+UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, le16_to_cpu,
+	       kstrtou16, u16, le16_to_cpu, 3072);
+UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, identity_conv,
+	       kstrtou8, u8, identity_conv, 15);
 
 #undef identity_conv
 
