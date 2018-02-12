Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x224eXB7Q2v1+kA7L6lwa1PApZST2yT6PvlLqRGOD6s6ckSNWmaK0r/S73xyv5VgiLZQp3QsN
ARC-Seal: i=1; a=rsa-sha256; t=1518395677; cv=none;
        d=google.com; s=arc-20160816;
        b=lA/3k8te6W8OFVKfKzHveidJcgThUNWSlfySdDbtZE9k8EkdkyGfoVUQJZGFVFDbdy
         rJNaDHUezcpFX5NGL3VFy1Unhd1EoytMFNrFowQi2u0aiPeTdASiNKAQVmlVsoMtm3Eg
         SwvLfhG5ZzOLMF+3GVjfLHqCI31HeXF2FnSM6U7rhA9pTyxwio1R6W7ewkjYc4so9S5k
         vWxzMsd9mDvZOHXA9Ji7qMVky1KadGk0Akjq1EBddftlG2TUuOtUlIjQUsZFWR8eQurT
         TDWKDblgDLfZP08k/HikYb9pGGvbJ97ORFlwUCDUl68C7LAxrnqACq9xYLhbKbOWDBS1
         gbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JQ/3kht8kIryrttkw0UX4qH+oFlJ0XDAzctfg0EK8c8=;
        b=BGI6lvByoXVaOmqhr/IKxomt7Wu2zqHd2C3UgdNALOdNBLAVd+YNSz+qOe1yzLGHTD
         y7uYB8qIoMWWkzMqYOrlQH64JUV+F15A7tKgAAu4WwAvMFkGEP5j96aJAz0ObMbQCk4C
         4tDZCuL3injJZzqUKlotd42/oI2v6SnoA3lnXeGiUKKBfdEZhNPoHCmxTX4pdHSLoH49
         WyUmryMgUxSBYfyALhyzM/oQs/MD11qFvN+WIjkPjhK7bjaP2uuG6U6KbXwNgd2Dy9wF
         +4wudZQFeJ4r50uEW3iXfmwIXJMwVBz+XX+GzYVz6JcImnErp9IOSo7T/fSm5iBBzH1m
         7y5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 02/12] hyper-v: use GFP_KERNEL for hv_context.hv_numa_map
Date: Sun, 11 Feb 2018 17:33:10 -0700
Message-Id: <20180212003320.6748-2-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfMBPoVmBpj5ZCphvaGIPrQDPdiP9EBYCoCwA13x7dFTj0gCvjgvLTrZo/d8eqMq58uZhIcAyYn4RsEcbpIMrcjHLlYImX+d1C+FSuKEllEHKslHysej8
 fg7BkCJVqliBc/AKN5cBO6jAxYFgkycGtdH8qut8ktMRW0Bmc7FWA4uMwH/XSbpT9WCi29bLPck7BeAPhIol5Sk95IcEJGnd0gy6Q8kfBQuJSIMiKiHNtvtI
 ZZsHHvY6BIhiJ1tEgXlJcp1apCC0JDVlzlwYQ91d26kU8+G+hb5irM9ZMfj5pzi1kqADc6T96pw9TPN9DyaqKPC+B2utn7uMPiuUGrL0ix8x/snFhl0XNdWL
 6WZNefcY70YeF2ofNxiENxtaUMeCtVFPYmZiU6rIqm1kw6eJJYPEg3xapljbGJK/fJu6A3zUc4swCvro1qKhF9+cM/ubhqkW+Uh3AiCvtlLAuRe8ln5PqPZd
 4XtisNTPydI9JOxsJfPNsEdVuKIfvuRX25HNiOC05FkFyD8Kb4PABOGrcHcP20JPhEXbvd0kD7gHhIm2EVVPWZ9LgRFOX1CzT/T9vLEEp5Uk4JPWXjGjufEq
 ko/avFLAaOUXh+rOrj711Yti
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153265147182049?=
X-GMAIL-MSGID: =?utf-8?q?1592153265147182049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia-Ju Bai <baijiaju1990@gmail.com>

The kzalloc function is called with GFP_ATOMIC.
But according to driver call graph, it is not in atomic context,
namely no spinlock is held nor in an interrupt handler.

This GFP_ATOMIC is unnecessary, and replace with GFP_KERNEL.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fe96aab9e794..b6cacc4cccf2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -147,7 +147,7 @@ int hv_synic_alloc(void)
 	int cpu;
 
 	hv_context.hv_numa_map = kzalloc(sizeof(struct cpumask) * nr_node_ids,
-					 GFP_ATOMIC);
+					 GFP_KERNEL);
 	if (hv_context.hv_numa_map == NULL) {
 		pr_err("Unable to allocate NUMA map\n");
 		goto err;
-- 
2.15.1
