Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZq+TGQxNfwAqtEXMhGwJjyds5e6Onls3U1WIUVN9o5Ay3OIm8cThBstHwXyo2qE4GuMPtE5
ARC-Seal: i=1; a=rsa-sha256; t=1525794553; cv=none;
        d=google.com; s=arc-20160816;
        b=MEq5021RFI0EyeASc1Bb5WQhyq5OwRw0LWxu0rQ3HnbqqQRiF5dkvciJzjw6V772DV
         vaBdW36lNmUY1iCK675aaBTY3BYSmJ15cJIOcCkHBaZtuy2Bh43Gv23ZG44LLLB7ObU/
         cLr4Npw2OK1ueBIQe+znK4pBaRE6iXfunpXx48WB/NbUPfrSzL6XOjiPbIsq0pIp4IFy
         5IFXvbaegmC97OmJaR7BcKQ4ZwKKdAC2hSPXyMgJDxkGSFhd+ZDSZcwaP3Rafrco1vgI
         /7Rx38NfpNRLANkEyBl7LBXa/O3Js7dhdq8uUm5UC+jqoodoHnLVcbr/2Ea3jTnpn4FZ
         rIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WX5QG6Al44mtWpI1RPfIgVmWivkiXReXTVRRbU02LhA=;
        b=ucUDw1wmFe0pTrCt+AFgr8eKuIDtxRCS04xNVF+YR83CpvY2RuFaIffS1teRCqw+6Z
         50kL/KLwiJVDO6ipLSRLMPQXC9hqWO3VaGOKygs++GK4KF+OQIIFQvAEaFhVzFdXPyEy
         cZLwKxmhoHzzh8knIPWdnPizuBhJdbVeH/InarrhyuUjLuVSFxWum+cAYJyYNn68VLNu
         1AcZSnFNhjX84EuxiQSatXO4VMeGMuBH2oBSTpoagt0WdUI1fCHSiiGwwz6o52l6KdoY
         DWGs4d12DCREK6w4zLSyhMIzkMzrJR32Z1ERgeDfpgLLVBLbAdgNOFUiC1CjlOAvA8yg
         yqDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 15:49:08 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masanari Iida <standby24x7@gmail.com>, linux-pm@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 02/18] docs: fix location of request_firmware & friends
Message-ID: <20180508154908.GD27853@wotan.suse.de>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <9e40d0b3a085a937b42ec60a3b2409cf820ca713.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e40d0b3a085a937b42ec60a3b2409cf820ca713.1525684985.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797480965348645?=
X-GMAIL-MSGID: =?utf-8?q?1599911549152917692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 06:35:38AM -0300, Mauro Carvalho Chehab wrote:
> commit 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> and other commits renamed the old firmware_class.c file and split it
> into separate files, but documentation was not changed accordingly,
> causing Sphinx errors.
> 
> Change the location accordingly at the documentation files.
> 
> While here, add a missing entry at request_firmware.rst for
> release_firmware() function.
> 
> Fixes: 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/dell_rbu.txt                      |  4 ++--
>  .../driver-api/firmware/fallback-mechanisms.rst |  2 +-
>  .../driver-api/firmware/request_firmware.rst    | 17 +++++++++++------
>  Documentation/driver-api/infrastructure.rst     |  2 +-
>  Documentation/power/suspend-and-cpuhotplug.txt  |  2 +-
>  5 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
> index 0fdb6aa2704c..befeff80e7ec 100644
> --- a/Documentation/dell_rbu.txt
> +++ b/Documentation/dell_rbu.txt
> @@ -121,8 +121,8 @@ read back the image downloaded.
>  
>  .. note::
>  
> -   This driver requires a patch for firmware_class.c which has the modified
> -   request_firmware_nowait function.
> +   This driver requires a patch for drivers/base/firmware_loader/main.c
> +   which has the modified request_firmware_nowait() function.
>  
>     Also after updating the BIOS image a user mode application needs to execute
>     code which sends the BIOS update request to the BIOS. So on the next reboot

This part looks good and is needed.

> diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> index f353783ae0be..7aed31b5a439 100644
> --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
> +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> @@ -72,7 +72,7 @@ the firmware requested, and establishes it in the device hierarchy by
>  associating the device used to make the request as the device's parent.
>  The sysfs directory's file attributes are defined and controlled through
>  the new device's class (firmware_class) and group (fw_dev_attr_groups).
> -This is actually where the original firmware_class.c file name comes from,
> +This is actually where drivers/base/firmware_loader/fallback.c comes from,

Not this part.

What I meant to keep well documented here was not just only the old firmware
file name for the code, but also the module name firmware_class, and its
respective sysfs class name which is registered. From what I recall testing, we
could not rename the module now because of this. I believe it had to do with
the modular case, given the sysfs class could still be registered.

The fact that I forget the exact *issue* which prevented the module rename shows
how important it is to document this.

Folks 10 years from now may wonder why the hell that name stuck, and the point was
to document that the *original* loader was the sysfs fallback mechanism.

>  as originally the only firmware loading mechanism available was the
>  mechanism we now use as a fallback mechanism.
>  
> diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
> index cf4516dfbf96..8e34d29ea02d 100644
> --- a/Documentation/driver-api/firmware/request_firmware.rst
> +++ b/Documentation/driver-api/firmware/request_firmware.rst
> @@ -17,19 +17,24 @@ an error is returned.
>  
>  request_firmware
>  ----------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

>  request_firmware_direct
>  -----------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware_direct

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

>  request_firmware_into_buf
>  -------------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware_into_buf

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

> +release_firmware
> +----------------
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
> +   :functions: release_firmware

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

> +
>  Asynchronous firmware requests
>  ==============================
>  
> @@ -41,7 +46,7 @@ in atomic contexts.
>  
>  request_firmware_nowait
>  -----------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: request_firmware_nowait

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

>  
>  Special optimizations on reboot
> @@ -54,8 +59,8 @@ this can be done with firmware_request_cache() insted of requesting for the
>  firmare to be loaded.
>  
>  firmware_request_cache()
> ------------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +------------------------
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request_cache

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

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

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

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

This is fixed on Hans de Goede's patch already merged on Greg's own tree.

  Luis
