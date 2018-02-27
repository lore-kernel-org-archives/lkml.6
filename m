Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AH8x227Hdu6ogxeP2sPXsFewUbSlno8RxcJaZMsUhoRAEQ4npWk66k1MXbaeWDfcMQjBCPx+9UuA
ARC-Seal: i=1; a=rsa-sha256; t=1519739508; cv=none;
        d=google.com; s=arc-20160816;
        b=WrGdqDLuJ71TI/BId4nCoRTiQk9/IbOGNcFM2scOe0otPdm1yoCoxd8fGy4CngWPor
         xN34/0y29HlIv5CxNinPihcVoL8L1BR/Go8VntcF5ly9bYI4NRR4nipgGyI/XudLZqFY
         q1HHZab0THOo6++hVC2Y8grVww/QnmTV4w2kuTUjhE8qZglloL6xPCf+yzT+sfz+i7Iq
         6R+8tkpAK+OM1Ebwy3MbQwaM0NpTg53/ztPpdomsdnsDOkuJ0xt6iyetG34xQ44EUIQs
         FyNI1NZdt6EJOEoq3SZLYCelEs5tp1JYQsIGahM8RZNKkuyOcvmt5UGNyNE7xd4v2Flq
         DDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:user-agent:cc:to:references:in-reply-to:from
         :subject:content-transfer-encoding:mime-version:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=549iOlrNCwOs9nVl31rdmbuK7MrsxUWuKZBk/cyd4mE=;
        b=LH9qbozLfg+hfoDDLyGeeR/ik1e9/tw/MnAOrs5nm43AOdvi+uwdf6grFMYlxjKwIM
         FRYvW2nnbc7Z0Er5VnwtPqjQyWgM8S+R606ttfH6SYnHrnWj3DOgMVhBKYl/g5jN7U/I
         gzn5/IkkJf6CmDcvWml29DirRJ5+WDkNiOXd96NrrQd+kQEzn9Xr0RMZlR5ZMdWJ8yRK
         Oa1hU9AjjSpjU+c2mchAW6+hS3L7KaJGkJz9SwluHX/ZZ+oQfX5evy9740I1iyoWw41y
         CV/tJCAmR/khjW1TlKpnZZvnlJBfa1XF5nsQi3DDm7m+BcYgutYseDKvz48VqyvzFlCa
         AfNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mi9v/nSS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Xjcl50za;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mi9v/nSS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Xjcl50za;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31AEE607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v2,1/6] wl1251: Update wl->nvs_len after wl->nvs is valid
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1510270708-14377-2-git-send-email-pali.rohar@gmail.com>
References: <1510270708-14377-2-git-send-email-pali.rohar@gmail.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Ming Lei <ming.lei@canonical.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Gnedt <david.gnedt@davizone.at>, Michal Kazior <michal.kazior@tieto.com>,
 Daniel Wagner <wagi@monom.org>, Tony Lindgren <tony@atomide.com>,
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Grazvydas Ignotas <notasas@gmail.com>,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180227135148.4D1FF60A60@smtp.codeaurora.org>
Date: Tue, 27 Feb 2018 13:51:47 +0000 (UTC)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1554617151981382095?=
X-GMAIL-MSGID: =?utf-8?q?1593562374695793526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pali Rohár wrote:

> If kmemdup fails, then wl->nvs_len will contain invalid non-zero size.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

4 patches applied to wireless-drivers-next.git, thanks.

f63b4c971f5f wl1251: Update wl->nvs_len after wl->nvs is valid
562da3a39cb7 wl1251: Generate random MAC address only if driver does not have valid
4f507d588d08 wl1251: Parse and use MAC address from supplied NVS data
3142467fc15b wl1251: Set generated MAC address back to NVS data

-- 
https://patchwork.kernel.org/patch/10052101/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
