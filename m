Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519772870; cv=none;
        d=google.com; s=arc-20160816;
        b=Si7Ef5d5YUC/6RPaZI8m2ok8RQalHODahJKW24TGYptKZgf0ghMNm+NCG3aeKo9+Pd
         kwUDch/uuM76YxYty2HirQFkA11dRhbT/8reRrNtmHCRdFS6y3SdE0I7aI7zGTrL05M5
         XvQz5p+EdfKuTix5z9D3SYQv7pdeRG4ozn27jOhv5BwZuvarzvhvUK3CPLB0ptdJOpc+
         XQAu5WePadvRNSJsubxJchLbHNi8XqN/4/hOiLvwO/VSyVeCcpg7H+93ag1ln4Y61hdf
         ObZD2GO8xBb6nNxIeoojG/jNbxURDpDeHFAnvNZlRekKnQrqviTRzkj2md6Ue3u39VUq
         1LSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=pqUn7+BoO8vTyFOsmua1OAcaJqYH5aY32Avdjw/ZTMw=;
        b=kEsNxCFXk8rCKn52eka434aKbccHTX4AiBKxLmJbMLaWn8rZLzD2blyMDg+83UbzzJ
         Zg8zGStjoZz02aCHMAVGMUHLKsLothFDIfYS9e7Wqfz8Z9KCJMY45Ri/M4P8uYusnO13
         rP5daE0TEfz6q6yjI305VlTPNTHbDUzBpUP+Vi0lFK1TheRgsnbfSRTQyHrTk2cDBZVq
         G6trKmFFSyxfgZjPWJbg77Y5tFIFUuvy95gaYtesVP/DLwWjRc5lBueAknD823tCeAZZ
         9btj5ZUqcw9l5Jt01IguoVo0IMWiYGnPANj3ZnYRTtWoRYPwfU3OSZDvsVIHyMHFCcY1
         2GYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ohenyVVM;
       dkim=pass header.i=@chromium.org header.s=google header.b=Xbs7EQLE;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ohenyVVM;
       dkim=pass header.i=@chromium.org header.s=google header.b=Xbs7EQLE;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELv3KYVZ7NBoixjaYPQ217iPFNBv+Wtr+x7kZkgV6UjVTBo4G6gtXjd9nJUJmsF5TFL5vv4ZAxae/SOs6IHeDPI=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-2-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-2-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:07:49 -0800
X-Google-Sender-Auth: QO7Jtylc7Tb_B716tNSeEcPq6IY
Message-ID: <CAGXu5jKrurrd66BC6zyC8J4K7BPoEzG8Gn1hC6zBRfOODACcJg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] test_firmware: enable custom fallback testing on
 limited kernel configs
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, nbroeking@me.com,
	Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248713291607087?=
X-GMAIL-MSGID: =?utf-8?q?1593597357132610754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> When a kernel is not built with:
>
> CONFIG_HAS_FW_LOADER_USER_HELPER_FALLBACK=y
>
> We don't currently enable testing fw_fallback.sh. For kernels that
> still enable the fallback mechanism, its possible to use the async
> request firmware API call request_firmware_nowait() using the custom
> interface to use the fallback mechanism, so we should be able to test
> this but we currently cannot.
>
> We can enable testing without CONFIG_HAS_FW_LOADER_USER_HELPER_FALLBACK=y
> by relying on /proc/config.gz (CONFIG_IKCONFIG_PROC), if present. If you
> don't have this we'll have no option but to rely on old heuristics for now.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  tools/testing/selftests/firmware/config         |  4 +++
>  tools/testing/selftests/firmware/fw_fallback.sh | 45 ++++++++++++++++++++++++-
>  2 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> index c8137f70e291..bf634dda0720 100644
> --- a/tools/testing/selftests/firmware/config
> +++ b/tools/testing/selftests/firmware/config
> @@ -1 +1,5 @@
>  CONFIG_TEST_FIRMWARE=y
> +CONFIG_FW_LOADER=y
> +CONFIG_FW_LOADER_USER_HELPER=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
> index 722cad91df74..a42e437363d9 100755
> --- a/tools/testing/selftests/firmware/fw_fallback.sh
> +++ b/tools/testing/selftests/firmware/fw_fallback.sh
> @@ -6,7 +6,46 @@
>  # won't find so that we can do the load ourself manually.
>  set -e
>
> +PROC_CONFIG="/proc/config.gz"
> +TEST_DIR=$(dirname $0)
> +
>  modprobe test_firmware
> +if [ ! -f $PROC_CONFIG ]; then
> +       if modprobe configs 2>/dev/null; then
> +               echo "Loaded configs module"
> +               if [ ! -f $PROC_CONFIG ]; then
> +                       echo "You must have the following enabled in your kernel:" >&2
> +                       cat $TEST_DIR/config >&2
> +                       echo "Resorting to old heuristics" >&2
> +               fi
> +       else
> +               echo "Failed to load configs module, using old heuristics" >&2
> +       fi
> +fi
> +
> +kconfig_has()
> +{
> +       if [ -f $PROC_CONFIG ]; then
> +               if zgrep -q $1 $PROC_CONFIG 2>/dev/null; then
> +                       echo "yes"
> +               else
> +                       echo "no"
> +               fi
> +       else
> +               # We currently don't have easy heuristics to infer this
> +               # so best we can do is just try to use the kernel assuming
> +               # you had enabled it. This matches the old behaviour.
> +               if [ "$1" = "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y" ]; then
> +                       echo "yes"
> +               elif [ "$1" = "CONFIG_FW_LOADER_USER_HELPER=y" ]; then
> +                       if [ -d /sys/class/firmware/ ]; then
> +                               echo yes
> +                       else
> +                               echo no
> +                       fi
> +               fi
> +       fi
> +}

Some day when we have more formalized CONFIG-scanning for selftests,
we can probably describe all of this better in a cleaner way. In the
meantime, yeah, this seems fine.

>
>  DIR=/sys/devices/virtual/misc/test_firmware
>
> @@ -14,6 +53,7 @@ DIR=/sys/devices/virtual/misc/test_firmware
>  # These days no one enables CONFIG_FW_LOADER_USER_HELPER so check for that
>  # as an indicator for CONFIG_FW_LOADER_USER_HELPER.
>  HAS_FW_LOADER_USER_HELPER=$(if [ -d /sys/class/firmware/ ]; then echo yes; else echo no; fi)
> +HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
>
>  if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
>         OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
> @@ -286,7 +326,10 @@ run_sysfs_custom_load_tests()
>         fi
>  }
>
> -run_sysfs_main_tests
> +if [ "$HAS_FW_LOADER_USER_HELPER_FALLBACK" = "yes" ]; then
> +       run_sysfs_main_tests
> +fi
> +
>  run_sysfs_custom_load_tests
>
>  exit 0
> --
> 2.16.2
>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
