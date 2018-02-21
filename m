Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519253948; cv=none;
        d=google.com; s=arc-20160816;
        b=LVkwNvlb37MIKm5KNE7Vq7vA1zeqdv2c1yxHcC3r4/CP+0K6f/1S2Xg8Y/INNi+N1L
         OxEiz7Mk6+VKCn33T12iwao+IS1CRD6uKTA+SmEP8jR0rhX6KC+QODYyD/GnY7sB4ypo
         ktba9YPixC6ez+GEwGufitMagqCBFLO8N2gT2ykMQ9BK4ryr/Nbpt4GM8DdNTtcHGo3E
         bhMjc/EKYn9hEdqufcntLg2qMy5OzD3A+MUr28pLlTif2MZR+Cnq+Vh2eMIP5gzR279f
         aFD4ix/oUW6nmWElEjpmVZFRWFDt4xMzK1FPcZHA5NZH5pc4+JnjZtZntygUH/hP98Es
         C1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=PZOL+5cHIJSiepJIXAR+uLyxb2nT4MiwLBgiSoMTHOU=;
        b=YMKeev3Sm8DqlRJPd8I74yu2YZGRnYR3QcxKmghLXwi64nDbtpE3pd6GdKPe0FqmM7
         SgfnSdd23sM5gksouH38uHsFK6iWB4oPxsWsTL72GeN4J9C+hFwJPDWnU216EmIxOskg
         FJ8nvi4AtOrOPbWBaL0i/K94XJT7FkCOVUFvbNOTGNLyD0MRXfTE3jHY4+BWnyu5FBqT
         u+bVfjMFVel2kwysE9MXv+le8RwWFhyQfNmZsDx5hmzDoMV2wEgdAfIEfLg5+rVTNGp5
         xZknfXBkTfMFKSoz1E1dsF8zLwJkCWKYudI9/x1iPrM4ihO0pqK1pf9+IESLbTtkcVyz
         WEEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F9CWSpBf;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F9CWSpBf;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x2246dk2/CjqvC0sOahiPY2tJSxrqapVeqBilYxD6GCS3/2oLuHbgTbn1iWOFpH1cczMIvovMrg==
Date: Wed, 21 Feb 2018 14:59:05 -0800
From: Brian Norris <briannorris@chromium.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] mwifiex: support sysfs initiated device coredump
Message-ID: <20180221225903.GA42395@rodete-desktop-imager.corp.google.com>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
 <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1593053227845812135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:50:19AM +0100, Arend van Spriel wrote:
> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
> it is possible to initiate a device coredump from user-space. This
> patch adds support for it adding the .coredump() driver callback.
> As there is no longer a need to initiate it through debugfs remove
> that code.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/debugfs.c | 31 +-------------------------
>  drivers/net/wireless/marvell/mwifiex/pcie.c    | 19 ++++++++++++++--
>  drivers/net/wireless/marvell/mwifiex/sdio.c    | 13 +++++++++++
>  drivers/net/wireless/marvell/mwifiex/usb.c     | 14 ++++++++++++
>  4 files changed, 45 insertions(+), 32 deletions(-)

The documentation doesn't really say [1], but is the coredump supposed
to happen synchronously? Because the mwifiex implementation is
asynchronous, whereas it looks like the brcmfmac one is synchronous.

Brian

[1] In fact, the ABI documentation really just describes kernel
internals, rather than documenting any user-facing details, from what I
can tell.
