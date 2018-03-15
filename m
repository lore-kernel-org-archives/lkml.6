Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521133503; cv=none;
        d=google.com; s=arc-20160816;
        b=gG8deHPc8gzuQENf9m9wwOoFQeJ10RIP4p1m5QOFDafzZ5o3XRIAkdoZT5jibTdaqs
         /szn2CDNPBGedc+IA0vHQNO3/QSesWXada1GNEqnFMkmP7KlnFG+sGcDjwo+bH2KMnjD
         3bhk+xEa/Wr2mWRn/m3k2wAKMJFY43pD75tbQEl+bA2AZ6MFBF1/F9BDcUy/1miBPzw+
         PdfCqmHrPFrn1uZiWfMhPPqdHHKpst3g1SxxGi+tUmuIRNo8hDnoza7q9h0MkQlxeQ3+
         byEB/Hq7x8cduJRH7gn6V445pGckojdfdb5qpzugkVC8CXn9b+LSfvx7HApeP+EWOLro
         5w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=X0ykJG6O/pZ7TNthJAZvCr2hEt7wl64te5a7ORiXLdM=;
        b=P8Ky6elyEBI48DAWMTCbxrOzLDsOEECCCb9JcbG6dSFrUwARMbnOiMFxio2wl58QKl
         pfFExLKXaP8IT8o+VL5X7bNW9hlcuuyXKtEWlMLrWiIgmcvg0xZ+TUs9pKxibNscpJuh
         nbpTCBzN1fVAuf3IsMJwrHoO3zX+LgIv6PpyP1jY33EJ5mG8Z4taF0IBHMBn9mGeZR/L
         kIn61Z9BRpIjBhoAjr9/UU/wQ+2ovNLLre9ohEphmuWkj+T1at90OAQk0gKechCU5vV+
         isgKAW+T0HQDOn+0B1iMAsCL5HYDkZOV4zWQebTX93qk2ICB4PAzJcIQWLA+2/9JsYEd
         Rzkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=mae8n/eU;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=mae8n/eU;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsNmwMdo/Vc2agJqtdeTV8Nz3Q71D401nGs14cRzuLt33lH9PA2V27j32KC86DJyGdtvJlL7g==
Date: Thu, 15 Mar 2018 10:05:00 -0700
From: Brian Norris <briannorris@chromium.org>
To: Arend van Spriel <aspriel@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH for-4.16 1/3] sysfs: improve devices-coredump description
 with user-space perspective
Message-ID: <20180315170459.GA120116@rodete-desktop-imager.corp.google.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
 <1521107725-25027-2-git-send-email-aspriel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521107725-25027-2-git-send-email-aspriel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067406689415?=
X-GMAIL-MSGID: =?utf-8?q?1595024084685797907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 10:55:23AM +0100, Arend van Spriel wrote:
> Instead of referring to kernel internals, describe the ABI from user-space
> perspective to clarify what can be expected when using it.
> 
> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-coredump | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-coredump b/Documentation/ABI/testing/sysfs-devices-coredump
> index e459368..d5a4c75 100644
> --- a/Documentation/ABI/testing/sysfs-devices-coredump
> +++ b/Documentation/ABI/testing/sysfs-devices-coredump
> @@ -2,9 +2,13 @@ What:		/sys/devices/.../coredump
>  Date:		December 2017
>  Contact:	Arend van Spriel <aspriel@gmail.com>
>  Description:
> -		The /sys/devices/.../coredump attribute is only present when the
> -		device is bound to a driver, which provides the .coredump()
> -		callback. The attribute is write only. Anything written to this
> -		file will trigger the .coredump() callback.
> +		When present the /sys/devices/.../coredump attribute can be used
> +		to trigger a coredump of the device. The coredump contents are
> +		device driver specific and thus vary. The coredump attribute is
> +		writeonly. Anything written to this file will trigger creation
> +		of the coredump. When the coredump is made available under
> +		/sys/class/devcoredump it will generate a uevent. When the
> +		coredump can not be successfully generated no ueven will occur.

s/ueven/uevent/

> 
> -		Available when CONFIG_DEV_COREDUMP is enabled.
> +		Available when CONFIG_DEV_COREDUMP is enabled and the device
> +		driver supports coredump generation.

What about /sys/class/devcoredump/disabled? Maybe we just need a
sysfs-class-devcoredump too, now that there's a formal method for
triggering devcoredumps.

Brian

> --
> 1.9.1
> 
