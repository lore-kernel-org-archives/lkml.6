Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225/xmWB/1rHKpUhBk63YceT1fKy7IbP2jO9d7PQpDSg5tM5X659e1pA1WAcifPuel4bHU7x
ARC-Seal: i=1; a=rsa-sha256; t=1518709253; cv=none;
        d=google.com; s=arc-20160816;
        b=K4Gr3HPW4P93b8ykvTeNHwDQmesIjOBYUvM+XuYXdiN4vBRWwgiFzavFT1Ok8Ca4g5
         xvPHMi5YO65WTfP/AnqqEApEVtSBS3FhrhMbO5VDiAEw45xHXyFZgt4zzvxT+hhbJE3A
         PNZApkuETsAOqxKxz8nQsF42kgxp/UGZyHSGscVSAmO0ADg+g/mI0xeIi5aytc1p0E3M
         9Yyd3wYS8/5XMkF6+Y3AaHGm03N0EsmP5jjMnwwDF069h9+fnPQpO1bpRw7tkx/I0UAo
         ZHN6yAM/Ahpp2z3wGLsjAShy9wBJKCbi3A4r4b3PuiryCeV/cRauv3nZH5okZXSrOpzQ
         a18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SEVVYvGVUgIZjZmf8p1V3Mq/JSVBeN3yyL0ageXw+7Q=;
        b=G3PoMIsR6khYdn83Z4RXJJH1ek2E47zADdFC26LUNQIciRo8OsCdPs5rNFRDODSh6z
         rK0E+scUSvwaoPfmLyVMxielZIPKiWoGKbnPHSNh+C3oL96OvHGvsLsvd7uD2qftKREO
         pShWfUJdN5HZjzvnofzTrUzYkG5OLWRnXFyOJSHPXdiKtLbpP4rJwO0snWXi9SBDveb4
         OmJA+IFNC/NeaWDis6qxUWSCH0PqNywx5UzbonzqAJUDHRidztE7yts1ELEPzUk0xjMl
         oM+PDMpEPWfWTmxYfhkjqEv2l8uAZtF3Q/+8SfiiDTKgfOmZmUbxvF1BqGaGugf9GDCp
         jBiQ==
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
Subject: [PATCH 4.15 005/202] cpufreq: mediatek: add mediatek related projects into blacklist
Date: Thu, 15 Feb 2018 16:15:05 +0100
Message-Id: <20180215151713.068890160@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481395330019866?=
X-GMAIL-MSGID: =?utf-8?q?1592482074831713395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -108,6 +108,14 @@ static const struct of_device_id blackli
 
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
