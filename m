Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuYo3auS8YhdJng0MyPE2gsk4LZaqetkfAwXOOrVQfOGZHaVZwjxAKxSVXbiZ+NP8T8Y9bt
ARC-Seal: i=1; a=rsa-sha256; t=1519410964; cv=none;
        d=google.com; s=arc-20160816;
        b=Ms2ygPs/566vJORG8QxfCF2b9leti5ocBs8RwDcqKwyJoEKj12G4CFY22IoagQL5H1
         11Qxe77hGZSvGladLOXimZUVsFtKB6Q971h0RNp8f5hjy1TrOjWJRo15Xy6pFPJkKzeC
         3llS/myhgk4mxrXeQgpLg82eSCUz080tqpYoB6t7ntDBw5/uzezPlXlLTt207EpnClFI
         pNMCHOA1w+Xh0VuIqhe/m3pI4BIiZdrBMP9vA/X+217x+TsGtkyv4xp1RAS+ZDPNwB/R
         uNIsZKvRWzifsQZc+anoFmLD4aHdq0qz4DjmpAqSf1oACtempB1Le/cn6cwbMQWlfFUB
         2WEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bBEV0zDk4hvBys3+5UN15HyUYfs1hHAyRMfalveRGLY=;
        b=GGDVeCpSwJAs4yDrGHkwus8oqRHvt7iPzB9w882RuRGcMsyOKkPDC2SLm7vqWic7oC
         Lau0lwA7CILmYV6A8huFTZ0o1a2W8t2LuzxwTpqthJ1f8oqYLXuqOAXO+RMtqbTngNnF
         /WrDt4AtqfaZqO5ATMwmx5FrJ0MNqShoNfGdcfUewZMxAMRLSLA4ebgfTYzJ1xOwgzOK
         Xkfw92SaZp+wqdQ0IUfv7oSV/FjFL8zJaa7tPxBsokOV3+8I+oACIQWbLY5l21vYJdiy
         gzLwwvreQaoBeKojF6kYNxJVYt9kmbKOobNWSPjIKt/z2BPk39dH52QiaY31UgFnghJ1
         T31w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 037/193] media: s5k6aa: describe some function parameters
Date: Fri, 23 Feb 2018 19:24:30 +0100
Message-Id: <20180223170331.886846388@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217666347196031?=
X-GMAIL-MSGID: =?utf-8?q?1593217871754332608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>


[ Upstream commit 070250a1715cee2297de0d9e7e2cea58be999d37 ]

as warned:
  drivers/media/i2c/s5k6aa.c:429: warning: No description found for parameter 's5k6aa'
  drivers/media/i2c/s5k6aa.c:679: warning: No description found for parameter 's5k6aa'
  drivers/media/i2c/s5k6aa.c:733: warning: No description found for parameter 's5k6aa'
  drivers/media/i2c/s5k6aa.c:733: warning: No description found for parameter 'preset'
  drivers/media/i2c/s5k6aa.c:787: warning: No description found for parameter 'sd'

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/s5k6aa.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/media/i2c/s5k6aa.c
+++ b/drivers/media/i2c/s5k6aa.c
@@ -421,6 +421,7 @@ static int s5k6aa_set_ahb_address(struct
 
 /**
  * s5k6aa_configure_pixel_clock - apply ISP main clock/PLL configuration
+ * @s5k6aa: pointer to &struct s5k6aa describing the device
  *
  * Configure the internal ISP PLL for the required output frequency.
  * Locking: called with s5k6aa.lock mutex held.
@@ -669,6 +670,7 @@ static int s5k6aa_set_input_params(struc
 
 /**
  * s5k6aa_configure_video_bus - configure the video output interface
+ * @s5k6aa: pointer to &struct s5k6aa describing the device
  * @bus_type: video bus type: parallel or MIPI-CSI
  * @nlanes: number of MIPI lanes to be used (MIPI-CSI only)
  *
@@ -724,6 +726,8 @@ static int s5k6aa_new_config_sync(struct
 
 /**
  * s5k6aa_set_prev_config - write user preview register set
+ * @s5k6aa: pointer to &struct s5k6aa describing the device
+ * @preset: s5kaa preset to be applied
  *
  * Configure output resolution and color fromat, pixel clock
  * frequency range, device frame rate type and frame period range.
@@ -777,6 +781,7 @@ static int s5k6aa_set_prev_config(struct
 
 /**
  * s5k6aa_initialize_isp - basic ISP MCU initialization
+ * @sd: pointer to V4L2 sub-device descriptor
  *
  * Configure AHB addresses for registers read/write; configure PLLs for
  * required output pixel clock. The ISP power supply needs to be already
