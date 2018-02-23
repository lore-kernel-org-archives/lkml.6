Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227knkF6Gl9JHG7QoljwsaRbeZYK/jL3CgCgf7qFgtUjxzWzMU2TJBfyyDz79KQ7Tb12iiuI
ARC-Seal: i=1; a=rsa-sha256; t=1519411514; cv=none;
        d=google.com; s=arc-20160816;
        b=SfV7+KC8siy+LX15uo5gSeBCbx2kobjWHCbpFJuLO7tQDSTCroCRnqeKTxi+TxzJbp
         i+lXOuIgefi9TFU1dHnSRrRsOBvA+NosrQ+HM7Q0NwrMPQWuzYPs8UmtbKlgPoKEOjHw
         kkXVtB31S+uZMr+1gsiNpKeAKsIZhwQlDnUO4qrHtp1BxfG0k2gjqjuAGKtbWh9LvVy/
         g4nCbwXvSBuHR1GNo0gbbjHXNtZE2B6HdhFqi9Zhrcxx0Zjiv6W215gH8zZRR6sYpRJQ
         FLng6xtxR+ts0+6tAcZBH7AhLllAN/sMZL1w+063wcjt0x4v5j77CSIW+YqDu6hJA//v
         qeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lq3vbvnsLKtUCDi2qRq/0eAb6lFrq3X48nHFHtOfMH0=;
        b=y1KtKtKvD1pH2tA/d3WRV83U0vA4ch+dGoKCK0wcY1ug/Hck13Bj0c2MioJGC6ePi6
         AiHzw6E5c7zqwwQsCgatHf5Nu+XlNl3fKgFOfmgct1pwpLrG2zOLeqOqkEBKLHRuhCBy
         x69OpXZCxNM15+4ZNynHATfNeGJOiuy7plOx8F+wTSlDgJepeS9psY+PCKR82gozTtOg
         saH+Xhtn9CWX72YIgIvz3xzaV+9sj1QnFoIERFSfbthcqvIUYqT7HiuDtTF39KsJgeyg
         voEl7yqWW5sX4OwTTTYD96gHAVxOvem5r5eRxr8TQYv5T9hZuRM/HmE5vb+r1haWxvLi
         l19A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 068/145] brcmfmac: Avoid build error with make W=1
Date: Fri, 23 Feb 2018 19:26:14 +0100
Message-Id: <20180223170733.429921302@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218447569926384?=
X-GMAIL-MSGID: =?utf-8?q?1593218447569926384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


[ Upstream commit 51ef7925e10688c57186d438e784532e063492e4 ]

When I run make W=1 on gcc (Debian 7.2.0-16) 7.2.0 I got an error for
the first run, all next ones are okay.

  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.o
drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:2078: error: Cannot parse struct or union!
scripts/Makefile.build:310: recipe for target 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.o' failed

Seems like something happened with W=1 and wrong kernel doc format.
As a quick fix remove dubious /** in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2049,7 +2049,7 @@ static int brcmf_sdio_txpkt_hdalign(stru
 	return head_pad;
 }
 
-/**
+/*
  * struct brcmf_skbuff_cb reserves first two bytes in sk_buff::cb for
  * bus layer usage.
  */
