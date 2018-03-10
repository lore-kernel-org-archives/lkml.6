Return-Path: <kernel-hardening-return-12363-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsNOYFpV8JJsSAywiSF/SjK2WKBS2ZxXEus9WsFhDdUipEsZD9JSXR717npKnX/FxxO8xdp
ARC-Seal: i=1; a=rsa-sha256; t=1520663242; cv=none;
        d=google.com; s=arc-20160816;
        b=F9ihZP1W0Cf0SKPshSNiIrHIdOgxMMduynX9tADmP7FotHfv6VawCFK2DfxhSQZopM
         sFv9ZcyZs3B2mKpA43vxOzBbigMg+IeZHaDfx3p2rVgAVLzMKCZl+oaim2t+wy2wWHnN
         E4ieL8YArgu+ka/R8Ab1kyLjGDRNsjQGvCm6EAO1qIKa/LoNn1TWdWXjITBAazmYSkOP
         KwwTiSPh14fkHKwlwdtF+NEpHBHgxbzK62lhP8GnPTSzvpPnZS84CAQv3jJNzhBK3I3e
         5WF72Tstnerf2MTFMgMkpUv6Aspu7BuXLh3mCJ2UKtwh3vO7Lv5aVcFvL8o/MsLeSbw7
         jolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=8ymzxqzwisSrv0UI7Gb+e/uXq4ac9UjGK6tgJrWm2cU=;
        b=uFuIU0ABSmVy4F+hwE1SJm7PhW/nqiJyeTMS1iB70Nt/+bBwLhZesUN07YtGj2XxvK
         aLTuILRjA9++BnyrfBD7qV151KcQlqgGP2NZsWh2BKefGUMIZLyfnujfLi2EZ6NNV8Dy
         EzgcDAfINKbi5xWU67d/34sqXVRcDg9FeT/otTdsCmg/hyDaQXNz/AVOqUszJQ25yL2N
         Tv7eh1Jg57pA+1ZEzLSnej5Ia2ylaIjziHvFMhQm69BCHCD+X3Vsf929HHEY2K96ABLD
         PK4G1omraJcN3b/OkdWMEQkL81Q9l3dyTELYF5pKU3DjUg1jbR7GcZAMdtF5H7t3Hdx8
         2pHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12363-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12363-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12363-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12363-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 10 Mar 2018 00:27:02 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sangbeom Kim <sbkim73@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 0/2] Remove VLA usage in rtc-s5m
Message-ID: <cover.1520660422.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euXyB-001HdG-Du
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:42572
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594530980012652646?=
X-GMAIL-MSGID: =?utf-8?q?1594530980012652646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset aims to remove VLA usage from rtc-s5m.

The first patch moves an enum from rtc.h to rtc-s5m.c, as this is the
only driver in which such enum is actually being used [1].

The second patch adds the enum name RTC_MAX_NUM_TIME_REGS, which will
be used as a maximum length to the current VLAs, hence turning them
into fixed-length arrays instead.

[1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2

Thanks

Gustavo A. R. Silva (2):
  rtc: s5m: move enum from rtc.h to rtc-s5m.c
  rtc: s5m: Remove VLA usage

 drivers/rtc/rtc-s5m.c           | 25 +++++++++++++++++++------
 include/linux/mfd/samsung/rtc.h | 11 -----------
 2 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.7.4
