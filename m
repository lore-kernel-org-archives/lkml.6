Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519774102; cv=none;
        d=google.com; s=arc-20160816;
        b=b8qL/n/mxWzaW3jv70ZSt9cGcES2BX6qmz/G1kbdhsvJOGGjbCGcCeAUvPMZSvXWpv
         giYd0OXP00aRVdGkbSX0OLsPFyvCk8Rig4Z+8NVr2NhIt7J3yKhqlZBqBQ7gK4/4mVfl
         YkEiP+5ImWeW4KObbbdU4XWqjRdb/5ylsW+tdKiHH2sFzJ7c+UGtXYnZsVSZhMO36cMB
         4km0PTy2P+AGbqVo9LT+oEhi4TJjWiEKeGXulD4wzcxsXQ73BJRLdnBKp0t1IzVGdi5u
         ccyNEstCTBn6pGnhoCc3Voe0md5qQ2rCUC2xy2TaPDq6GtZx/c87zVHpnKIzN2/zBhPS
         EVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kH5a0sPcYaPlgQS2WGSLWMmM1pbBFyUWfg2moOD8ESU=;
        b=qxMdxG6XNRN1cOWHO+qtzIM4I5Eb9/0Hdc+Wr3iE5NONt4xReRLu67sz4pvG0i1Fpq
         qHafGqUP1BT0S7qw4xkeb2M3jPe+hlNTBd8W5tunhCJfWKW9hWO7EkfV8Q9L+XSQSYUH
         zDt0Vgn2Qiwcvi0KwaBL7MSsYbDbZ8WfgXe1+wdJrPakpgHahdVCdEbvJ/jAGy5vS5I6
         OcGpDSEf1DChuObMJuh/4mipUD0Db35AraZj1cY5FkCIsUqY3YcZgrm3zlEr6CctXP7J
         FgZ6GN7fXKO+wJait+88QrKeXN1SF4c/7Wz7NZkRq69CsOlEswxRgH194w/C/owkCdCy
         RJXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=C7Zkgc5I;
       dkim=pass header.i=@chromium.org header.s=google header.b=PBsAqV20;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=C7Zkgc5I;
       dkim=pass header.i=@chromium.org header.s=google header.b=PBsAqV20;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtkFTcgRNSIdb7U1YdT2yJQrZ0qKpHvOQ4XFRBWl0ZyY0Nh6NOITFr6IFO6Dz2SvnCxZKnERLAY8Q2Sex6Yf7U=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180227232101.20786-2-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org> <20180227232101.20786-2-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:28:21 -0800
X-Google-Sender-Auth: pYfKY62mNKiQnxMy3eWd4ivqPI4
Message-ID: <CAGXu5jJwRU1mMH-erQmHLsrDgu1zmYOMrWiG_A_r3tksufLHDg@mail.gmail.com>
Subject: Re: [RFT 1/7] rename: _request_firmware_load() fw_load_sysfs_fallback()
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: cantabile.desu@gmail.com, Jakub Kicinski <kubakici@wp.pl>,
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com, Takashi Iwai <tiwai@suse.de>,
	arend.vanspriel@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	oneukum@suse.com, LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598193855582168?=
X-GMAIL-MSGID: =?utf-8?q?1593598649808067360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 3:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> This reflects much clearer what is being done.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  Documentation/driver-api/firmware/fallback-mechanisms.rst | 2 +-
>  drivers/base/firmware_fallback.c                          | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> index 4055ac76b288..f353783ae0be 100644
> --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
> +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> @@ -112,7 +112,7 @@ Since a device is created for the sysfs interface to help load firmware as a
>  fallback mechanism userspace can be informed of the addition of the device by
>  relying on kobject uevents. The addition of the device into the device
>  hierarchy means the fallback mechanism for firmware loading has been initiated.
> -For details of implementation refer to _request_firmware_load(), in particular
> +For details of implementation refer to fw_load_sysfs_fallback(), in particular
>  on the use of dev_set_uevent_suppress() and kobject_uevent().
>
>  The kernel's kobject uevent mechanism is implemented in lib/kobject_uevent.c,
> diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
> index 13fa5ff2b46c..ce7ccfe82c69 100644
> --- a/drivers/base/firmware_fallback.c
> +++ b/drivers/base/firmware_fallback.c
> @@ -536,7 +536,7 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
>  }
>
>  /* load a firmware via user helper */

As long as this is being renamed, maybe add full kern-doc for this function?

-Kees

> -static int _request_firmware_load(struct fw_sysfs *fw_sysfs,
> +static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
>                                   unsigned int opt_flags, long timeout)
>  {
>         int retval = 0;
> @@ -621,7 +621,7 @@ static int fw_load_from_user_helper(struct firmware *firmware,
>         }
>
>         fw_sysfs->fw_priv = firmware->priv;
> -       ret = _request_firmware_load(fw_sysfs, opt_flags, timeout);
> +       ret = fw_load_sysfs_fallback(fw_sysfs, opt_flags, timeout);
>
>         if (!ret)
>                 ret = assign_fw(firmware, device, opt_flags);
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
