Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521018402; cv=none;
        d=google.com; s=arc-20160816;
        b=DcwgGTVmttzHyt3i5GpfUR3+CUo7tP6kLYUy7usq4WbxNqaN0SO4YapkJNB9F3c24v
         7MY9Tliq7bGQNpiHXY2bycZ0isIL6oF6T7F5g9dxGxj2jRJcwGZiUjTKUjJeSEPYIXPM
         8SyhgHs4CA/VjJUYugOCMckTRui7GB1C97Bre82Y05MqQLzM2p87SUoC/nC2fMrenHbW
         fOMxU/moUQhOfQF0eMsTECFDjaxvJMngXpb/Px3sqKcCt1Pl0v3xELzGu8qQumBKMtFz
         JNjpjPoze9M6lKYzcTi/i0GEzx1XKZfUSgdHdTXkn7E6pQrEpVsgexYFyufpnMTHWf0l
         dPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=TyvZa+n07+9WlY5as5wfSklA6vuPw8ZjSp7BR6e1huA=;
        b=vbdKiQlK/fcFvSm9PEdUT8nbMcaBiXbSKZTtVm4FwnTMb6HjzBQpkwVd8ga4auD0Xn
         ZbeZQrQ4jWc23NWseFP4lFHeJqYDBJKFI48akZyqU3CK+B+atOearMQ6f1HWzYJVN1I0
         MNSMmQzFKdCUCqmEaSYs544oADUWYUMbH6SO1sQ0BOnaynguRq/TgyK85W+Z5fITg+Zj
         HXYHX/M+R4Y0ZflXCEwiKuD+gqtUtYtEgJ+MhmtOzLrLcK7dLEvyNaBByDCAVgvUktqR
         eCowW+Huiu9XSObjhycswE7o5RY1Imvb6xM4CpTdQ/OQxf+jHhU/XAoK4EEDpBjJvnz+
         HAdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=VHfsoe3/;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=VHfsoe3/;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELsHWxhgQVBtIZfz2qt966rtcCxjbNBX61qz/qrpbs85d/E+XKTtNL2PSp8znqfuXd/9M9CJUQ==
Subject: Re: [PATCH] drivers: base: add description for .coredump() callback
To: Arend van Spriel <aspriel@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1518167637-1948-1-git-send-email-aspriel@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA8E61F.9090500@broadcom.com>
Date: Wed, 14 Mar 2018 10:06:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1518167637-1948-1-git-send-email-aspriel@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914160440023159?=
X-GMAIL-MSGID: =?utf-8?q?1594903392011542957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/9/2018 10:13 AM, Arend van Spriel wrote:
> Commit 3c47d19ff4dc ("drivers: base: add coredump driver ops") added
> a new callback in struct device_driver, but not a kerneldoc description
> so here it is.

Hi Greg,

Revisiting the header file I notice this patch is not yet applied. I am 
pretty sure I got an automated email from you regarding the merge 
window, but nothing else so did this one slip the cracks?

Regards,
Arend

> Fixes: 3c47d19ff4dc ("drivers: base: add coredump driver ops")
> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
> ---
>   include/linux/device.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405..0b32a42 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -256,6 +256,7 @@ enum probe_type {
>    *		automatically.
>    * @pm:		Power management operations of the device which matched
>    *		this driver.
> + * @coredump:	Called through sysfs to initiate a device coredump.
>    * @p:		Driver core's private data, no one other than the driver
>    *		core can touch this.
>    *
>
