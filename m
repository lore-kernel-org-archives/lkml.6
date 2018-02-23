Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Pms7oTwdp/ri3k5kbiOl/mVBdIJb6PoZcOC035gY1GbB/aHNI/Ql0XqPbYkhw0pdj/A3g
ARC-Seal: i=1; a=rsa-sha256; t=1519412203; cv=none;
        d=google.com; s=arc-20160816;
        b=VKzraSR2e0OokeEUhsCe4L4zS8ZZP4QXcmIGIeWcgEtwgcfn56ydLCkgDTJqpexQ16
         bXWGtw8ddTqdOzyWjE0sSEcNnCH7+4sphyt8zCTtbX6iliugGGvxmJzTPgK+s58XwEGb
         oiKtNHUPI7ZtsZCXoajZLTLhiTHsGpWu13NAorQhsE+A8UInc2XXu6Gap52bf8rHV6UA
         80N/pmXsZkS38+eaIGmnQ1+BL6QraHVsW08ITLEULO+W5HTe8h27lhM/9vr72bZyOmhg
         XIQYw4yXp/j9xSrYuORIfGKu+7dvdpfOQdP9+ylFuer5YIfSRXcr2bhhz5otScOQDuCR
         KMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IdFb7RQgoZ7XZzTU30B++wAH7+ZZ+8C6du0iLODHrCg=;
        b=enRMS0IiAfWF7xNudnR5SqHCQ32br51qz0T4fjOS5eUk7zy/r3U89khhRsJkHyLDdd
         w8Yw37sylADgcGJr+9kcX6z1wgn19Stk6NhGiZuL1wDNt7V2YJ0OzEtPebv+k7TxpOzn
         ssBrm2h3ysbDujKNfrO5Ni+rsv8yCB+j1L9hcSLfHyXj/ACYAYClSNP6v0VzbA1xIHwi
         Hice60VHvwhHH/Gyfy2hu2KVs0d9bDv/ea6JR0KO93jCYSQnMYYuKWuUovwwuT+OCDd+
         MxgAWxrsNUOSuLf8uhrDv/F0WLYmv8o85Int5vfr8sXdM5kscHdGQOf3GZt5NkV2z8Qr
         Jo9A==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 121/159] brcmfmac: Avoid build error with make W=1
Date: Fri, 23 Feb 2018 19:27:09 +0100
Message-Id: <20180223170757.916434991@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218447569926384?=
X-GMAIL-MSGID: =?utf-8?q?1593219170774944112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2064,7 +2064,7 @@ static int brcmf_sdio_txpkt_hdalign(stru
 	return head_pad;
 }
 
-/**
+/*
  * struct brcmf_skbuff_cb reserves first two bytes in sk_buff::cb for
  * bus layer usage.
  */
