Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx48Pz6e9FPTwMb+kr8L7FYhxVCRm1dDYod47P3gu7JP8Z5wGObnK7tGv68a8lxvi9KExHFnl
ARC-Seal: i=1; a=rsa-sha256; t=1523998717; cv=none;
        d=google.com; s=arc-20160816;
        b=VEGgmXL5Fz3yPviAslrt2YapBZa0NhxwKzkV7epTCNYPxMb6Igk+z2yC3X6r4mgU5N
         EjbMhsqq22APepz/xoivbODRv1QqYlefWnkuGpnS+7ZyYmu2TlLHHVCuAdi3H4e7IDZv
         tXGcgPRdkeQAwO3Z6hSPT1yJBYNd/y7PaY+BCgyMfIuzWtEtB+zgfGmFjgTuIaMKHTO4
         fTz5KJ2kGIT/IMRx3EUe7YsUgZA/rurAHqdfH5IniTv10dpP9MV+jjz9cCD7ceQVk/V4
         8RcJmYu8dcOISbqV28XLJwnAT2nayuKCGDEtd0DGrHoS/VuP9ybVjVPPXs+qVzp5PJ8Q
         kzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=4RmPcgbPmGphuw6t0dfyrqYvBlisDNmTa6b0PKGg+XE=;
        b=EKo8MybhBqfCa23wsYiGgwRVhcSz/H9O6W6rDcN4HTTXNR9Sic8TyDqQYyMK/UfhFI
         4USt3U1G+FBQu/FQJAefDvhKU1ulbrRAgPet2Qw82ZK8KgsF7ODnOnWstwkLBVQcsvfg
         UqYZdS+26pM2MKE+8GznjWfCSEZZig7XBxrohLM27xMJaBxbl34jBw9oRwlzouaobxRc
         3j95Bs8HUh4J9LvO4wG/x7Shy6aPwM8lGiRKvTPnJSY959TMTcuxElsyCVyOqCMx/nOs
         h4pcWVCTYbIO5nRFk1BLlZaM+LvIPjLu/BohPoJ7sc7DjpFrnlVmmjsbqbKXJZo12MQW
         6MPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=JxqKUUhQ;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=JxqKUUhQ;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v2] firmware: Fix firmware documentation for recent file
 renames
To: Hans de Goede <hdegoede@redhat.com>,
 "Luis R . Rodriguez" <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20180408160621.13042-1-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <18d60d18-24ce-2a02-b2a4-d1b5a6cc6310@infradead.org>
Date: Tue, 17 Apr 2018 13:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180408160621.13042-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597194722140266854?=
X-GMAIL-MSGID: =?utf-8?q?1598028478877810028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/08/18 09:06, Hans de Goede wrote:
> firmware_class.c was split into several files under
> drivers/base/firmware_loader. The new main.c has the functions which
> /request_firmware.rst references.
> 
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes in v2:
> -Fix the same issue in 2 more files
> -Add Luis' Acked-by
> ---
>  Documentation/driver-api/firmware/request_firmware.rst | 10 +++++-----
>  Documentation/driver-api/infrastructure.rst            |  2 +-
>  Documentation/power/suspend-and-cpuhotplug.txt         |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
> index cf4516dfbf96..20f21ed427a5 100644
> --- a/Documentation/driver-api/firmware/request_firmware.rst
> +++ b/Documentation/driver-api/firmware/request_firmware.rst
> @@ -17,17 +17,17 @@ an error is returned.
>  
>  request_firmware
>  ----------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware
>  
>  request_firmware_direct
>  -----------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware_direct
>  
>  request_firmware_into_buf
>  -------------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware_into_buf
>  
>  Asynchronous firmware requests
> @@ -41,7 +41,7 @@ in atomic contexts.
>  
>  request_firmware_nowait
>  -----------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware_nowait
>  
>  Special optimizations on reboot
> @@ -55,7 +55,7 @@ firmare to be loaded.
>  
>  firmware_request_cache()
>  -----------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request_cache
>  
>  request firmware API expected driver use
> diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
> index 6d9ff316b608..bee1b9a1702f 100644
> --- a/Documentation/driver-api/infrastructure.rst
> +++ b/Documentation/driver-api/infrastructure.rst
> @@ -28,7 +28,7 @@ Device Drivers Base
>  .. kernel-doc:: drivers/base/node.c
>     :internal:
>  
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :export:
>  
>  .. kernel-doc:: drivers/base/transport_class.c
> diff --git a/Documentation/power/suspend-and-cpuhotplug.txt b/Documentation/power/suspend-and-cpuhotplug.txt
> index 31abd04b9572..6f55eb960a6d 100644
> --- a/Documentation/power/suspend-and-cpuhotplug.txt
> +++ b/Documentation/power/suspend-and-cpuhotplug.txt
> @@ -168,7 +168,7 @@ update on the CPUs, as discussed below:
>  
>  [Please bear in mind that the kernel requests the microcode images from
>  userspace, using the request_firmware() function defined in
> -drivers/base/firmware_class.c]
> +drivers/base/firmware_loader/main.c]
>  
>  
>  a. When all the CPUs are identical:
> 


-- 
~Randy
