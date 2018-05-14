Return-Path: <anders.roxell@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526295287; cv=none;
        d=google.com; s=arc-20160816;
        b=AW3ECitW9awIODKeaG3ZH/HOfGYcn8Y5HwVM3yPQzFcJ+ScUXnsHi9eNTRcwY3Jp77
         6LNdLkwUa9vmp9CDzIzrg27W6du7xikgvhPja39AZHXlnm/99B9yulqJ5R4HuunpGbk9
         lpfUaKbgzEqDnhFSESOVBfVWEq+7fYeId0Wg37kN5h9IuJyp0o+8s+hxhHnlyBzuywLn
         R1Flw4FACZaEcDH131n78YPdKemaEnMstec2oAqnWIZBYXZnKLWFofHPsaSN1K1Yq0df
         M/RK+/xPaw6/IQntl3FuBCTrlelPzJh4aE3AAl9fynWAb5teyMwMuBl/GVXjtQM3UxKA
         9DDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=QUqredEsnnvm0NIVnryFxbYznGhUCHJaYIVDwKjCs34=;
        b=FurAU3zHOYTjmEE7oQ/80501kAg/p6GiSfreLk0foL8SHxI8O4m4POe85px39UiGbW
         ee29gk7MM2lCEwBOSYuj2UqRk917WkLPTv2z6mVGUkhj/6larQ02zaucxBGGtAyAun8+
         eYl4S+oelKxfkze/O4IDERIIpWS8YLX5Fyp1Cqg/dBYIq2pPCG0nDsf8U+j/L30p55BW
         CRq086c5dJcEew0N8T5uHHLEozR6VFpaScZpqrb1xMLcW6ObP4wVnD+J3vlCsrJquF1h
         kE/JwmMIRmlhwMLjLEhyQGmqPwWFsoPMpSuvAPgrALNObsNpJeYFWDkvWb6AMUglJuM7
         L0Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=RzsZWICs;
       spf=pass (google.com: domain of anders.roxell@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=anders.roxell@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=RzsZWICs;
       spf=pass (google.com: domain of anders.roxell@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=anders.roxell@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrXvGS6SkYLrpRoy5a1qIVAENxHXQN8GJY3V2EHBFysUqIgoDPvPbjA7P+G6PJ+ZYqd4Tt/dA==
From: Anders Roxell <anders.roxell@linaro.org>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] staging: video: fix warning unused variable
Date: Mon, 14 May 2018 12:54:42 +0200
Message-Id: <20180514105442.10179-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600436607638339528?=
X-GMAIL-MSGID: =?utf-8?q?1600436607638339528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When building video warnings pops up unused variable 'mdev',
drivers/staging/most/video/video.c: In function ‘vidioc_enum_fmt_vid_cap’:
drivers/staging/most/video/video.c:265:25: warning: unused variable ‘mdev’ [-Wunused-variable]
  struct most_video_dev *mdev = fh->mdev;
                         ^~~~
drivers/staging/most/video/video.c: In function ‘vidioc_g_fmt_vid_cap’:
drivers/staging/most/video/video.c:282:25: warning: unused variable ‘mdev’ [-Wunused-variable]
  struct most_video_dev *mdev = fh->mdev;
                         ^~~~
drivers/staging/most/video/video.c: In function ‘vidioc_g_std’:
drivers/staging/most/video/video.c:309:25: warning: unused variable ‘mdev’ [-Wunused-variable]
  struct most_video_dev *mdev = fh->mdev;
                         ^~~~

Remove the 'mdev' declaration.

Fixes: 7d7cdb4fa552 ("staging: most: video: remove debugging code")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/staging/most/video/video.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index fc374711fcc0..cf342eb58e10 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -261,9 +261,6 @@ static int vidioc_querycap(struct file *file, void *priv,
 static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 				   struct v4l2_fmtdesc *f)
 {
-	struct comp_fh *fh = priv;
-	struct most_video_dev *mdev = fh->mdev;
-
 	if (f->index)
 		return -EINVAL;
 
@@ -278,9 +275,6 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
-	struct comp_fh *fh = priv;
-	struct most_video_dev *mdev = fh->mdev;
-
 	comp_set_format_struct(f);
 	return 0;
 }
@@ -305,9 +299,6 @@ static int vidioc_s_fmt_vid_cap(struct file *file, void *priv,
 
 static int vidioc_g_std(struct file *file, void *priv, v4l2_std_id *norm)
 {
-	struct comp_fh *fh = priv;
-	struct most_video_dev *mdev = fh->mdev;
-
 	*norm = V4L2_STD_UNKNOWN;
 	return 0;
 }
-- 
2.17.0
