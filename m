Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524732798; cv=none;
        d=google.com; s=arc-20160816;
        b=m+GoaYyTe49dtvJbf6GWd4D9uAPzEuaPG2P2O3+AEjgiQsiX+iCwkmFbwsJmWYiU/P
         4biY9kDlJ6P/4+UEYw/h9bzYkx3SyNnBp+obsKU0HzhsqVbup7L1puL1VMstihftasvC
         /CQKgPuR5GPcdZQEYAOgAirGAcwA4HzAGnbAZ0V0q4FYzCYuQX9UGsnaefanzBqKvK5q
         lfYjieJS1ZLjfDuLsgdfDdF7QUT99jXZtd9XDGwoOUK/enrFBJUJxs/s7MXJhPqQwlqy
         9rgTrsHRCPbU4iVw7Usqyi4tpOCvEEXg4nr9SZtoxv59b+PyQXRhzldoNSMlKr1zqVJG
         7CtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=T9Wib4djefmVxBJqaikiWSvLHOActznyxXHnlI0JbYo=;
        b=laCvNXGFvCsBNQfTCLmCm5r0ruyeWUTBNG99OOP3ov96aDObPF4yRSi4taKn2Hi6DJ
         rxhbGbjMW19BmHqe1sqB551+TTECXoUq6P+KIQbtCr/1pnYrkMBMS5aojbFewTgqAWNZ
         iNEEgkCKhGxWfRIZPLZ0vUJP7t/73t+pIHQV7gPKAqfBWWJ2NW8Xzz7I5f+v2KwAHzzA
         MFcS90I+Lb7bIyv7IUA5rB6gUA2FV+yLJO/MDq/vDKonA4xi7b6XvD/qyXVlK6iZRUTx
         +pKVXZDwdx9JVbaq+aU4+sVM1oNmpNeOUPNfwL6MHYRIKcbhMT8teAEoyoZLAS32b8xi
         iYkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QKKACr4/;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QKKACr4/;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoMYppiNVNJ8LrqJuEo2YSyCCdCZ6BA+20vnaKxwNfLnK/TG4wklADjtV76PtgngxoU67648Q==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/11] PM / Domains: Drop comment in genpd about legacy Samsung DT binding
Date: Thu, 26 Apr 2018 10:53:01 +0200
Message-Id: <1524732790-2234-3-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798219088227802?=
X-GMAIL-MSGID: =?utf-8?q?1598798219088227802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The parsing of the Samsung specific DT binding is gone, but the comment in
the function header remained. Let's drop the comment to avoid confusions.

Fixes: 001d50c9a14f ("PM / Domains: Remove obsolete "samsung,power-domain" check")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ef6cf3d5..d3703a1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2185,9 +2185,6 @@ static void genpd_dev_pm_sync(struct device *dev)
  * Parse device's OF node to find a PM domain specifier. If such is found,
  * attaches the device to retrieved pm_domain ops.
  *
- * Both generic and legacy Samsung-specific DT bindings are supported to keep
- * backwards compatibility with existing DTBs.
- *
  * Returns 0 on successfully attached PM domain or negative error code. Note
  * that if a power-domain exists for the device, but it cannot be found or
  * turned on, then return -EPROBE_DEFER to ensure that the device is not
-- 
2.7.4
