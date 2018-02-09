Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518172296; cv=none;
        d=google.com; s=arc-20160816;
        b=ifU6WhEVmaKhzmgW0ejMn/r7irz3B9Ng1xVR057kJayI9/yF3w8ErXjjR4Si2hJ0qZ
         kxFnjwGzHRIWmGHS/RxvMttgNp3yH8RaoafkvN7a2Pz94LUwppN/tcCRmbBxjdnRjk7A
         rfx0rrzbcYTsNnUf+4XFGogAdDrDLvHaxfQJ9sW22LcZb705pGRFRgklLor5IFTcoH0h
         5CbCQX96cHgFZJJgWxMDkQNy9dpRF1ym5zHaoywpdH5kpVNes02Y9jmwOz4Q3SVFu3ZG
         WhrXeyr9VvbTBHYZ1SMelQdRdeBUruetpD9WzmQBU7VdPByZguh2vOg3DKW3V749FN58
         VJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=RRYLGWs7nfMMSISLGnFj4oeF5NOm8srfCcd2k09qwAE=;
        b=wkx15IM4P3Mh9cWF+N0MUQzbWVBYz88IIM8XfgoZPoVdn+tHR3jITsNngAaZB1TiAE
         Y5a96camYIScOmWglfPspJyDy2xFvC9eEc+HeCtIyIPDCFNbTLCtMMs8g4HBYlG65C8O
         owQiogg2yL7LNqOKX7GxX8C+BV2nrg4EvLvGHDFubd3QLg2cRpe3khegq2In2wzOu29g
         lSGflcswyJM+XYYmtmT0fv2cgwBZo8WTJNyDrYG2fPkOLDT7xzReeEXklJ1Pw6QzQxFk
         slWrw83db/w+woyFiBhh5G5IkYfsv2TMbyMvnDzaPWxVOf4yEqGDPCQa6Zhw6d/3Ai77
         91Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y6sfGTiU;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Y6sfGTiU;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AH8x224aCuMPzhJx3hZdvMxYCuYUeoP30zMxVUtM5BLSizMG07FpXdHAuZtSwgEJ/Jv3MSCsInHmvO0+X9w9SNCEhRs=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com> <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2018 11:31:35 +0100
X-Google-Sender-Auth: WUdArlj28DnuT5OYlbraPa6xAdw
Message-ID: <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi/dptf: document sysfs atttributes
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748317597152283?=
X-GMAIL-MSGID: =?utf-8?q?1591919033156992740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
> The descriptions have been collected from git commit logs and reading
> through code.
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> new file mode 100644
> index 000000000000..e8168e5198d7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -0,0 +1,30 @@
> +sysfs interface for ACPI DPTF platform power driver
> +---------------------------------------------------

The header isn't necessary.

> +
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power

There should be one entry per attribute AFAICS.

Also I need Srinivas to tell me whether or not the descriptions are
accurate enough.

> +Date:          Jul, 2016
> +KernelVersion: v4.10
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               charger_type:           (RO) The charger type- Traditional,
> +                                       Hybrid or NVDC.
> +
> +               adapter_rating_mw:      (RO) Adapter rating in milliwatts (the
> +                                       maximum Adapter power). Must be 0 if no
> +                                       AC Adaptor is plugged in.
> +
> +               max_platform_power_mw:  (RO) Maximum platform power that can be
> +                                       supported by the battery in milliwatts.
> +
> +               platform_power_source:  (RO) Display the platform power source
> +                                       0x00 = DC
> +                                       0x01 = AC
> +                                       0x02 = USB
> +                                       0x03 = Wireless Charger
> +
> +               battery_steady_power_mw:(RO) The maximum sustained power for
> +                                       battery in milliwatts.
> --
