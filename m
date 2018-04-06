Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49rOc4Z7ujvk4PU25E5bpjzw0szTiH8n3Ch6F76I6MKtT9csu7Nba97zp6ec8jIFLMqNzcx
ARC-Seal: i=1; a=rsa-sha256; t=1523021608; cv=none;
        d=google.com; s=arc-20160816;
        b=uV64+xlLCm3KJiJSQeLHMjrQDnL2Pgee/xRmuIU0Rl/jDC3FjvhYZo6FWuCVIYbzzE
         4GcGI9gaRSeSEFNfSH1q861J1t6ae2JOuebzqv7t03EEnQ7wLFhtLyhMWwWM+mVjoHx7
         oWT29++zQo6LP+MAZDp2xT3Eg7P+I5YCOBdwpICbwFRWOwKjkHWbi1rl4424NrQl0m3u
         NH793M1qpq0maLVauptoe5HF/k+TEoyHoWeky6Q3UfG59EemPAGCbg2ejZPeKhkK3htW
         bttty5g5MBR+b09eehlFh3H8BVTuyv6sEzU+WOtflTG4BlGyXCSqeZm0iytksD9M3tBn
         LFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jAIP97rTG+gRfu70qqnzJbIVptWdr0Mq88T+CTiI218=;
        b=qVwkvZkkHa2ZUMpoUkPdcW3kZVWYtylliqTOTbynjNd/ZFr6oeqYare3ONEZQxfXtL
         NmXvA7l7mT59+a0Mt/uf53FOljUWj8vFDJQNAvCCKq4dUTs46mBZHJRI1E5UDki0JuJY
         1830oBVVQAgY3t81xh0yiGMHDP90x/YHVgy0d8+KYMU4k45V7vNDUjjjDCnSu8lsy1K/
         CA+eaznqYJ/J8ivgU5hmvVEcKGDn88iVWX1BdJR6UhH+VNGXOrCfE8kIz7bStppECrlj
         HXGOSirXaibDoFVX8Xjyax8zAEhlNcIJ5yjpwDmO1cPR+p5QOYgS+s2ULz5vAXiBqAd2
         fQ7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 025/102] nl80211: Fix enum type of variable in nl80211_put_sta_rate()
Date: Fri,  6 Apr 2018 15:23:06 +0200
Message-Id: <20180406084335.225305155@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003905927741132?=
X-GMAIL-MSGID: =?utf-8?q?1597003905927741132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit bbf67e450a5dc2a595e1e7a67b4869f1a7f5a338 upstream.

rate_flg is of type 'enum nl80211_attrs', however it is assigned with
'enum nl80211_rate_info' values. Change the type of rate_flg accordingly.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/nl80211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4081,7 +4081,7 @@ static bool nl80211_put_sta_rate(struct
 	struct nlattr *rate;
 	u32 bitrate;
 	u16 bitrate_compat;
-	enum nl80211_attrs rate_flg;
+	enum nl80211_rate_info rate_flg;
 
 	rate = nla_nest_start(msg, attr);
 	if (!rate)
