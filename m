Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518253046; cv=none;
        d=google.com; s=arc-20160816;
        b=KePNcgyPvJr3doujYLVUcbAtTXVQWQjS02/maTgeETF+ofQM17frd3NoFMagfvPlZA
         nfyGgbi0rPPAOkndHL6Gcs5xVVGVMBuexIc6xnlWTtzzmDWE21n2H1faEkNhtT4FPNfp
         0/nIu0VN23mICWkFNq6xBWw8V03kwknIwg9pjwp+U8CAdmUSyVy5ggSsyHfmYip3pYu4
         /9kH7MZZTxRN3xXHlXIKAIK8ciHiix0xr1+G63SCJlxBgRF3Zb5C0i2zOMM5ojlGwxMo
         0MqmZlJ7E3t+A6YAmF2+DY2oXNHc5WWsle3FsLvur12cQF7YJYfkLVg1gZbgqVKljOGU
         j3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=xOd0vXHluEH3t9rKbMSYHcsXxLp6umKRNiQ8yWwvN34=;
        b=g/ihsQTy+rxryQ7xCJHAWP1UwNjBPja2Aa6C0T7LGAQ2tGad0TvrKS+IlzjuHznzc5
         1x8aucyJ6myAfLp28g23NPX7NHniFCkEdXc8F1YCWDZo9T/ymptWG778y0EepZ62j4j8
         0nOxisI1xzs73K/vIIHpF2inm0JKbRdn+pCkRRoL+QhNHeOMqNBvxXHMrgBFjjM+Vted
         8EjQ0uz2vB+VowVxJHuWl+XlNsahy+xLKaQIfaR1Y2SQuI4bvYiQCm1fJCQksbdbCcDP
         aNE7jMG7jCnX3WlLgb+vQZWj7ej24iZ3TjtOVhV5VozurqzgXRq0RIUoGABInOA3r7Lg
         5nHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=phulab9z;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=phulab9z;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225PyhPY+udfnptlqtYIHV/iVrWggSG4v3lSB1DZnahp5xgKYaE1LNd6jpog4bZkDmSjRa/t3A==
Date: Sat, 10 Feb 2018 14:27:19 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2 1/2] acpi/dptf: document sysfs atttributes
Message-ID: <1ed759fffa55e45a92a69867e8cb35ff3d3978ed.1518252138.git.aishpant@gmail.com>
References: <cover.1518252138.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518252138.git.aishpant@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592003706644777470?=
X-GMAIL-MSGID: =?utf-8?q?1592003706644777470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The descriptions have been collected from git commit logs and reading
through code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Split up attribute definitions

 Documentation/ABI/testing/sysfs-platform-dptf | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
new file mode 100644
index 000000000000..325dc0667dbb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -0,0 +1,40 @@
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The charger type - Traditional, Hybrid or NVDC.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Adapter rating in milliwatts (the maximum Adapter power).
+		Must be 0 if no AC Adaptor is plugged in.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Maximum platform power that can be supported by the battery
+		in milliwatts.
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Display the platform power source
+		0x00 = DC
+		0x01 = AC
+		0x02 = USB
+		0x03 = Wireless Charger
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) The maximum sustained power for battery in milliwatts.
-- 
2.16.1
