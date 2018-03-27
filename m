Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AG47ELt7ruXn0s2r3sfH3WKUeCYuGCNEgoDzXdhWs8+6oNSTlYu5BnrNgAJ6vbcXKyDEnzRYdCcY
ARC-Seal: i=1; a=rsa-sha256; t=1522137951; cv=none;
        d=google.com; s=arc-20160816;
        b=T+fNHJHqfh15nP2JDEbhCE6GGKYI35eNH+bJJWEsVVAlnZ1QXB8RXK1yd85xPiwL3q
         tq9tL4RIaWQ9gB9BKr4ZisHApGWuNj6yJL22hpEdwPVjw5LtXZwlnuEgA047rXu01Ld7
         uPrT6GPbH2sZU/Pf4YAytZNdyumzErNEy9Akb/mhDkswPlR9M+F9Qmx5PVMovQtT77Ni
         TByicSdlEjrCsDU2ZLXGrSgArV8oA/d8RjH+1VLqvXk2e9+Z0uk8gtmDz8Gqf3RxUmju
         cweQPSOqB2DAQ+mxifA+4FVd6Gm1BAlGvHw53oC0VTr6hRUVZfJms4G7VXkxAVKDbEjW
         oV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GanGSsaPjndZxenrnEoyWRORqpQqtNElPu0Bjgisy54=;
        b=jBHA0fdN8G7kVWVEV+tBpljwPZOkg/sazWOw0E0a+GMXe7LIFFLkKaSEV8VOzZBoBk
         rNQUhe+cRzHiRmc9agCITTDGF2QTRdgIQW9ICKInNU5q+Sef0M4GStrMoCspGOYHboF2
         ObscNTYU9kuHWvlItePeC13fwMpuofFuJkHxRiJXvBrJaxndXIsJUPOgtYGGKyN9WHni
         c1Jkl5r9FpVz2DV8B+PZkgDffFVXzaNs58IiDvuJeBKe319Xc8jM8v8paXocDhHX+yfD
         jklnuBVxXwazCeTMg8ELZPpVCl7XEBellykDo5Lj6bm8vLTvn/1QN3/RaN9EOA35tpf+
         xVGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v1 1/7] platform_data/mlxreg: Document fixes for hotplug device
Date: Tue, 27 Mar 2018 10:02:01 +0000
Message-Id: <1522144927-56512-2-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077325157567666?=
X-GMAIL-MSGID: =?utf-8?q?1596077325157567666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove redunadant description of label in struct mlxreg_hotplug_device.

Change location of access_mode in struct mlxreg_hotplug_device.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 include/linux/platform_data/mlxreg.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index 2744cff..19f5cb61 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -58,11 +58,10 @@ struct mlxreg_hotplug_device {
  * struct mlxreg_core_data - attributes control data:
  *
  * @label: attribute label;
- * @label: attribute register offset;
  * @reg: attribute register;
  * @mask: attribute access mask;
- * @mode: access mode;
  * @bit: attribute effective bit;
+ * @mode: access mode;
  * @np - pointer to node platform associated with attribute;
  * @hpdev - hotplug device data;
  * @health_cntr: dynamic device health indication counter;
-- 
2.1.4
