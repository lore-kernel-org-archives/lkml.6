Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELsnCZbiAfSbqmBrZ/ylhmFmky/94tBYVH6KBbfXRqdBITe/7hw1yJkUE7nFq6OOn/2UHfrv
ARC-Seal: i=1; a=rsa-sha256; t=1519843533; cv=none;
        d=google.com; s=arc-20160816;
        b=rnVmDfQZCK+R9o09f13TIhBH7mi7S+8m1DByCPkDd/raAQc7/aOZI8P1auBjpgLeBn
         xYMHPTejTp5+RnRctVARSVIpFtpdrkhAR491VQP4gPDudH7fgAzVBbBPucLMDUUfjNCJ
         gBwiuL6703m5gAM3uwvZCqlKMf5mHNE2dx0l7ByZAxzL3/4jARmse4QZf3m+7259j6nc
         3+p0xt/3l7oROm+B0dRi2petqtToEU4WZO04wVIVB62otoz37zi3HgSsIBbkTK2WuoLH
         mtwZmEmY7BzcZI+dQTF5r10LgTyBgst4xqhumiJ6/kyDUVc8N/KKGsdbB+XfIUMuGgQM
         /FtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=SoUmvVFHNkoQGPSaSuGJdCZL3iWzTsxD41s/bCuPolQ=;
        b=VB4O8lIljHhC29kay/Zmre1LMQB5RpAvyR9UQ0qdKzlQJWAlLq0Iz9B22BFcoTUzXp
         QZdljo4avMw8MlvT66/hP2elnZqZ6Zd7UA0n/Gg2QiNv7KmJN+60KtoIOfUQx9KkhO6D
         dVscoMmna9Q3cdCve7xRouBy9pnPMIzQ4eJ6G8HX46iEMuASqoVw0rUGt+jTbFjStzY8
         Vi6UGt/O2KcY2zJjuobjjnAEhzY+J/v4zLuM6HUwLyAyTJRLObbR1lDZ+F9Y7zqDbiDX
         kmC42FSlhECqvAUHY2PzSFP7eZnGktPPWauUUhJUbrNUllxK7AG1+evBJpvO0zdJrom2
         fG+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 28 Feb 2018 18:45:31 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: cantabile <cantabile.desu@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, kubakici@wp.pl,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	linux-wireless@vger.kernel.org, keescook@chromium.org,
	shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
	dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
	arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
	markivx@codeaurora.org, stephen.boyd@linaro.org, broonie@kernel.org,
	dmitry.torokhov@gmail.com, dwmw2@infradead.org,
	torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	oneukum@suse.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFT 0/7] firmware: enable caching of firmware for reboot
 optimization
Message-ID: <20180228184531.GK14069@wotan.suse.de>
References: <20180227232101.20786-1-mcgrof@kernel.org>
 <49e9d9c3-1352-e204-ff95-5cf10f14bd35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e9d9c3-1352-e204-ff95-5cf10f14bd35@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598192477821921?=
X-GMAIL-MSGID: =?utf-8?q?1593671453090347940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 08:03:26PM +0200, cantabile wrote:
> On 28/02/18 01:20, Luis R. Rodriguez wrote:
> > Cantabile, please give these patches a spin and let me know if it fixes
> > your reported issue. They depend on other pending patches I have in line
> > waiting to be merged so the easiest I thing I think is for you to test my
> > 20180227-firmware-cache branch [0], based on Linus' tree. To get that
> > tree, cd into your Linus git tree and do:
> > 
> > git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
> > git checkout -b 20180227-firmware-cache mcgrof/20180227-firmware-cache
> > 
> > Please let me know if this resolves your issue and thanks for your report.
> > 
> 
> I confirmed that request_firmware_cache is called, and the firmware is
> loaded from the cache when resuming from hibernation. The bug is fixed.

Great, thanks for testing.

Curious, is it also called if you suspend to RAM instead of just using hibernation?

  Luis
> Thank you.
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
