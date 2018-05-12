Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZoMdpKHxTj6DljEDHuj8uPgVIbWzzZ7A14XN9T/Z71cs01Qxs5FmwpPr3b8qK+FRkgU6ZQl
ARC-Seal: i=1; a=rsa-sha256; t=1526115980; cv=none;
        d=google.com; s=arc-20160816;
        b=JamhrbgZGpMBkckN2XC9lDdpf+SMtPxLjlPIk69A0Eos3ZLXI/V78Kvn2pYR11jMqc
         GuEPemtRZOf5yCHQaXRl3UYX2CzRAKVeEdd9Kqx9KzAjF6w+bZVGX7zvlsn9BEgFwLsQ
         51rTueI5a58dKM76LRAyuVCsL9Sy7SzzRWJsGBA2VlYB/FOpt0c3iKhBPIgIn3Vi0sgN
         AVRt/UrV2HpxLyl5D7ndwjFFVaUlATBPs12wR5s/KgnHzIBw4l0EO+EEGprGGhuhuEmP
         4xOeZR2mCddPLn6d+xCsmVX4m3lzO/gpJAp7xT3dkit7fsFJhhYS0WP74ebatYsRarcF
         +50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5RYop64XJwb4FaXjpTtBjf22fQFuS1We3XPGv5/DTyc=;
        b=PKPdzxxREk505bC6+5QwYZeGDnyThc0+G5Sdvicwty5/2PIEqfK5VkKd2DTL2GBaN4
         BIoXKHayWSOJcDWpeAwrRiGHyl0ZasqYNyQ0nMS0qt6TFXg0ohhlZZC4zNKpVghcLViw
         vWDN4v9dkHRfQMpWoNXN/ndfQPN9+HLn2nV9BebvyLc72uegRnzYBKVuQJ6CUyw91sEt
         LSRYT7AtY3cU8khjyf8rCN1cuOwt0j3S+orczp1esvj32Aq2Uk1JT9HXMePNjxdXsi8E
         2AvEwDcfuGmtyZXHDByN7EYIpNAwWyDxrMPmae9FNdXCzsiD4mSb8E5Rt/6YjOeK2Kc2
         059Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Sat, 12 May 2018 09:06:19 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, alexdeucher@gmail.com,
	christian.koenig@amd.com, arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	hdegoede@redhat.com, Kees Cook <keescook@chromium.org>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] firmware: print firmware name on fallback path
Message-ID: <20180512090619.GL27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-7-andresx7@gmail.com>
 <20180503234235.GX27853@wotan.suse.de>
 <8736yxb8rb.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736yxb8rb.fsf@codeaurora.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569151610038779?=
X-GMAIL-MSGID: =?utf-8?q?1600248590938183246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 11:03:52AM +0300, Kalle Valo wrote:
> (sorry for the delay, this got buried in my inbox)
> 
> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
> 
> > On Mon, Apr 23, 2018 at 04:12:02PM -0400, Andres Rodriguez wrote:
> >> Previously, one could assume the firmware name from the preceding
> >> message: "Direct firmware load for {name} failed with error %d".
> >> 
> >> However, with the new firmware_request_nowarn() entrypoint, the message
> >> outlined above will not always be printed.
> >
> > I though the whole point was to not print an error message. What if
> > we want later to disable this error message? This would prove a bit
> > pointless.
> >
> > Let's discuss the exact semantics desired here. Why would only the
> > fallback be desirable here?
> >
> > Andres, Kalle?
> 
> So from ath10k point of view we do not want to have any messages printed
> when calling firmware_request_nowarn(). The warnings get users really
> confused when ath10k is checking if an optional firmware file is
> available or not.

I figured, that is the intended functionality now.

  Luis
