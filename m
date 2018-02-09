Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227LgxPf2meIwE/axVHqVJ3/o5A0Pxtdm8oAYa40byoCJAcwm+EcXJvzFMh78RMHQq64InOf
ARC-Seal: i=1; a=rsa-sha256; t=1518184005; cv=none;
        d=google.com; s=arc-20160816;
        b=KJzZt6Ch1nlbFl6R1k11RiQkiQALSUjW6fBKT5xKRyIwcW6CsCXn3oQcEmEWb+ihUT
         HFV9oAzxUDFbXvohhcjcPVJcw6BG3LtTFjXwdefwLkQa9JQr1+IB5J6BYRHtsYE9Pl8x
         D50T/xSPoE2ZnQ3yxJ+AW1Qdu61dKhW4jII4tB2lFmPlsmyGFn0IkhbHvVNSyaqbKCSO
         jf9lDKNFGg3PnVYm33J5wK1iRLKeIxaYWMTN+HeoqGOfcBPwMg8I6s4O1Py0PXHh5/t/
         WmZgLFDemFGZA2RMP3HEiC8wTurYRPzTeaSuLxxg89OoJR0NAEaibPBVaW7gFY4K+m3e
         kpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SR+COAQNfKnBlwByPScm8t9rXcPKIiuwgvfyqvvD4ag=;
        b=lt1VSwfVEe4+/tTqDmrKhXNVFgYIztH5nLhnUpED5bH2kMgTgGD9Str/0XpY9TwC3l
         ucOq5Ka+LysU/W6WCJaiul85bp4hCfr9jUxXtvzUZ1Smrr55/hnhttMWJCGMRXHdwB+H
         iRP+Xn4RC+fA5H7B2TU+8PgIoT4rvDWjBI9vTzCndykTnSRiZZvSdnH8LcjsuWR1elt/
         3MAtjvRWKeqXE0EXrkjKy701XAV2bAeS/lzwNSLa0NMD0w/8ZOHS3ZdwI9NgFAFbjPsj
         WYf5ggFXnTocHpiu64RChw+8YqT44pwv+yTyZxiCa0HlWwlTcq9cUkjAc6beoXytTre7
         rhBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Chan <jc@linux.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.15 20/23] media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Fri,  9 Feb 2018 14:40:18 +0100
Message-Id: <20180209133939.310723967@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930994480931778?=
X-GMAIL-MSGID: =?utf-8?q?1591931311131692588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit 5331aec1bf9c9da557668174e0a4bfcee39f1121 upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/soc_camera/soc_scale_crop.o
see include/linux/module.h for more information

This adds the license as "GPL", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/soc_camera/soc_scale_crop.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/platform/soc_camera/soc_scale_crop.c
+++ b/drivers/media/platform/soc_camera/soc_scale_crop.c
@@ -420,3 +420,7 @@ void soc_camera_calc_client_output(struc
 	mf->height = soc_camera_shift_scale(rect->height, shift, scale_v);
 }
 EXPORT_SYMBOL(soc_camera_calc_client_output);
+
+MODULE_DESCRIPTION("soc-camera scaling-cropping functions");
+MODULE_AUTHOR("Guennadi Liakhovetski <kernel@pengutronix.de>");
+MODULE_LICENSE("GPL");
