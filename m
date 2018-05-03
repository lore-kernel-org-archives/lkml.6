Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrWXHIj9eBT+zT/zyCuqILQ4NP3kbtGJPRgPACQWodxOpgbszTCGyggZYOS51w+791l6PLo
ARC-Seal: i=1; a=rsa-sha256; t=1525390569; cv=none;
        d=google.com; s=arc-20160816;
        b=lEXgvzlkNCy0g2O6R7cJWITH+mIs6sFRnan1/vpFlHngNr6clRIF5fiwhTAsyWMTb9
         qYDntMiFztN2vlSqDN/wdwvxiRw1TQ/TDfZiRLXHNlJw9pymT+1bN1pWUorTl5TTJf1S
         gMWoVFU6Lh+qqCxENhkQZOG6C7NB+xd2aiJAY64GjCP9jKgYFJXLLFAqq517Gh1RDswJ
         jd9mxeqNzQAOyFJtLkyCO6MAJImIQKaJ77dq1ZTgTEja5IOWSE7bMY6OWtUWEgyIR7k9
         d5u5tPav6dSi0QGL9UBJPzmcnWuIJcQ5yt0jqEx0y4GaGSZkH3+E6OMaDecA122ccitF
         /9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=KWCZX2iirUO5iJpAeGKWakiX5Dc9DZPzT1kz1Bk7Eo8=;
        b=ml8owEKZfjXvzQtRSVgz8GgOrF0t0m/5MGjB1QXTSZJGtSq7Y2wiNiM2ZLQNqRXahv
         RmxLHCG5fzizXO35O/XsQSKCQq+rUvqBvQHUmi3XHStr2boyYWnJbVeWWm/bJKd9a9TI
         uuSkGlHSEKmts5kMPcaE5gflr0Qp8E8PJb/uRGiZoUF34mbQ33jHh70jgfoBQWZYSbeJ
         +PoMSfXAKaQIO0X7SG9C4R8hP+lRDzXh5jY+5v53Jo/fPK4ognQoucHevXHI7sajuDCU
         dk/Mj9uDtatNXmpnluHqs2m+hYPlh7uoX5cXxzQsWzRyQsrn76PAGDczvSJ4YIqb9cUY
         6HSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 3 May 2018 23:36:08 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com, christian.koenig@amd.com,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	hdegoede@redhat.com
Subject: Re: [PATCH 3/9] firmware: add kernel-doc for enum fw_opt
Message-ID: <20180503233608.GT27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-4-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423201205.20533-4-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569147115158619?=
X-GMAIL-MSGID: =?utf-8?q?1599487941822529290?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:11:59PM -0400, Andres Rodriguez wrote:
> Some basic definitions for the FW_OPT_* values
> 
> v2: Documentation corrections from Luis.

Likewise.

> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  drivers/base/firmware_loader/firmware.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index b252bfa82295..a405d400a925 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -11,6 +11,26 @@
>  
>  #include <generated/utsrelease.h>
>  
> +/**
> + * enum fw_opt - options to control firmware loading behaviour
> + *
> + * @FW_OPT_UEVENT: Enables the fallback mechanism to send a kobject uevent
> + *                  when the firmware is not found. Userspace is in charge
> + *                  to load the firmware using the sysfs loading facility.

The style here is a bit off. I'll just merge this patch with the last one
an change the style a bit to match expectations.

  Luis

> + * @FW_OPT_NOWAIT: Used to describe the firmware request is asynchronous.
> + * @FW_OPT_USERHELPER: Enable the fallback mechanism, in case the direct
> + *                     filesystem lookup fails at finding the firmware.
> + *                     For details refer to fw_sysfs_fallback().
> + * @FW_OPT_NO_WARN: Quiet, avoid printing warning messages.
> + * @FW_OPT_NOCACHE: Disables firmware caching. Firmware caching is used to
> + *                  cache the firmware upon suspend, so that upon resume
> + *                  races against the firmware file lookup on storage is
> + *                  avoided. Used for calls where the file may be too
> + *                  big, or where the driver takes charge of its own firmware
> + *                  caching mechanism.
> + * @FW_OPT_NOFALLBACK: Disable the fallback mechanism. Takes precedence over
> + *                     &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
> + */
>  enum fw_opt {
>  	FW_OPT_UEVENT =         BIT(0),
>  	FW_OPT_NOWAIT =         BIT(1),
> -- 
> 2.14.1
> 
> 

-- 
Do not panic
