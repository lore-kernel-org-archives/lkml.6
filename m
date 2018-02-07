Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518009488; cv=none;
        d=google.com; s=arc-20160816;
        b=SnQSKi0pkeV7PisIIDSinaSs1ULQUSYfssDBJrWByfwZGKhedr9JQnjuslv1pml3yP
         8nsqp16sK3v5NYryLTTD92EVcbGXNQaDCjZuaMB4Uf5AkXzE3Z0IBz9WqZ5/9R5gwbkf
         D3dXLibUt0T7oXbDwnzGPuNI+D/HrPYodFRXoE0VDovG/ZdKQc2qREdVjTFB16ftrqdG
         tVDVxkGijb/ba1/ijusNDjx8WkBrZl4SWAURd68tl0TgR8G8++rLGQj6KclEh8+if2HD
         6ObqD2lz0qlAALZSgQ6Rdu7DuVSHXFM6RkOeGLsC7Uszp6daTZE3X7Lj2DCgkrdjjfn7
         V/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=91wWZipCTzk6iYvou9uJ9ZRjhQIhVXvTC3eT0tKNxeA=;
        b=g7bNZ/tGpkm9EJMHjfNvYzA92waLUvLHYYltlzjFTOh+R/YYmNxaEm2bM7OKXyaLXL
         XC1UCis9/F11E0mCbOMgRNA3rLupb+tYW8e7gBLvhculgpLvmpg70aY4P3xW+hlGJdTZ
         1zdmSCnt+626yvQRLQB8G509IvW94+NH4R/8ftquHCUS44F4lLIYUKhpP5OZeFz1Kc6Y
         Aa4PLeE5OCDP7oaTctQM+6KPOvMBQAYNrL1Tl5SvN1Y1Nsj2q3fJv1r4cAMdpOeXhpJI
         u05Hrs+5g3zTy00UmgQCbXsoIz/9ZEVAHsEwnXrJbN6E2WiHGWVuwSDmRKlQ1NWK2GkE
         T0tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IBmGbDV6;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IBmGbDV6;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224tv62soerLXFJI1zCcLBWj2nMYYSLaR4BIsnzaOu5INVtsGGK0h7pMZPCKCohXRvXe+CedAg==
Date: Wed, 7 Feb 2018 18:48:00 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 1/2] acpi/dptf: document sysfs atttributes
Message-ID: <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518009225.git.aishpant@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748317597152283?=
X-GMAIL-MSGID: =?utf-8?q?1591748317597152283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The descriptions have been collected from git commit logs and reading
through code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
new file mode 100644
index 000000000000..e8168e5198d7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dptf
@@ -0,0 +1,30 @@
+sysfs interface for ACPI DPTF platform power driver
+---------------------------------------------------
+
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
+What:		/sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power
+Date:		Jul, 2016
+KernelVersion:	v4.10
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		charger_type:		(RO) The charger type- Traditional,
+					Hybrid or NVDC.
+
+		adapter_rating_mw:	(RO) Adapter rating in milliwatts (the
+					maximum Adapter power). Must be 0 if no
+					AC Adaptor is plugged in.
+
+		max_platform_power_mw:	(RO) Maximum platform power that can be
+					supported by the battery in milliwatts.
+
+		platform_power_source:	(RO) Display the platform power source
+					0x00 = DC
+					0x01 = AC
+					0x02 = USB
+					0x03 = Wireless Charger
+
+		battery_steady_power_mw:(RO) The maximum sustained power for
+					battery in milliwatts.
-- 
2.16.1
