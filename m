Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2243EiUJEjYq4KTgUVz5b4PcHfVt3Ww1WFf3RAjcTciTaRTlwPojufTImIxHbekT/fAEgx+s
ARC-Seal: i=1; a=rsa-sha256; t=1518708606; cv=none;
        d=google.com; s=arc-20160816;
        b=Tb4/u8e+Wc9C8RdWZKa8AYnRoqnE0OhAshikueUGvXxHtrQZn0uHa4E7fYk9UyT6vx
         ZxgS86FmNZUH4bEERqX0/WTsv/+fatdFjJuugDo6KJ5LKlQelfpN9GKhsrCXQayQHU0f
         hZPQj32Y+H/nq1c2fU/wq6+nto2EMxsiwuEmcCgIE4DvzW2/TTC4228eGX50FyKlbynv
         ux644Y9NVHhXg+Czflbbe7WDWlr/i4wuN/bOoFQcOQOZlYms+3mOoYcU5ZRoaS6TnFme
         noP0EgmtmAvju5jTrgLQHU4rAnQNb9Xta2r9WitrAoufmrHItADmD3Vgg9wzFP4k3MlX
         o7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=19lwTpdl2XAgKq7kkJqGjWkZFf8OXXKOqdqEzpxunVU=;
        b=hgC2Y/C04m6Hd2YputZUUGhwBXy7fGH4ece4J0NZwpFW6hYYWG6h/+NucjnmKHbk4L
         WI82WY0tG+OwWTn8qVn0EVhMac+y0w5XE+E1ThLXxGIa+N2WODnnrbjPV23lOGsS0Rcs
         Pc9A7djncNM9ClVS7b8svr+5KuiMNgn5UxYT8TE3bFH8ovux5ZQ5oP1rDV7OJnC1tUJY
         beb07LXOHuFbquchV+CcaOK8HLruG7QmpvNnoNsFdvvkxPv41gkSjEVxfp6TP45Ex7Ir
         HLW021TR6Q/XqtDjMX6Kzx17Fosg2EfRprSU/oVd156l1DVbMTDwNTZ02RDTHy4qS9DW
         MCPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4.14 006/195] cpufreq: mediatek: add mediatek related projects into blacklist
Date: Thu, 15 Feb 2018 16:14:57 +0100
Message-Id: <20180215151706.055547108@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481395330019866?=
X-GMAIL-MSGID: =?utf-8?q?1592481395330019866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>

commit 6066998cbd2b1012a8d5bc9a2957cfd0ad53150e upstream.

mediatek projects will use mediate-cpufreq.c as cpufreq driver,
instead of using cpufreq_dt.c
Add mediatek related projects into cpufreq-dt blacklist

Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cpufreq-dt-platdev.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -111,6 +111,14 @@ static const struct of_device_id blackli
 
 	{ .compatible = "marvell,armadaxp", },
 
+	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt2712", },
+	{ .compatible = "mediatek,mt7622", },
+	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt817x", },
+	{ .compatible = "mediatek,mt8173", },
+	{ .compatible = "mediatek,mt8176", },
+
 	{ .compatible = "nvidia,tegra124", },
 
 	{ .compatible = "st,stih407", },
