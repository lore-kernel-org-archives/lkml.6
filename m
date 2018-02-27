Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773420; cv=none;
        d=google.com; s=arc-20160816;
        b=feimb9QL8wQ6e3hVsDglY+JqhnzjdcaQiWsGBFDF5rIl808tebARR+uA0M085m5KPu
         Ju8Cfn4H08cQb0jBKPFuDYPj1fF7G4tHORD5/hLstYRw8bnb/MtGIgFoZRGN39lRCpQJ
         XyeX6Zke+yFO/xqrLxwfK79YM4PxTpF+XMimPK4PB+/3FSU1KiinFn1BKJZtZUzBwh6j
         xTABftmc7rU2cJbOOFDdatsf8Uv8gkMB3Jo0wVUXCRXtjcT5PJrUidQMB7FW9pF3Fe9I
         jd/3+TbS6nnIQ8EaYCH7nAbkb4IksDWkrlAC4p/8Rc4G0Rp5D6zdUPQkCEqfe2trttbx
         YVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=taIRZAeROC3eRXJ+d32kjjuo4QkvEKa63who4S2m6kY=;
        b=UF7H4C977zGaDSHjOrR2b4uxmi0YsDgbLLbdvMvd+Kh0qF2us49GWDNFz5WZ1FrZ+P
         9XfLutt6+1ysen/E3AvY0rkVggtubmQgjjya6Xou+5M3m7tPlqYMOsNUq3OlTDvNGGU6
         Ca5Mlg9Zg6EU5+g020CCKF8KhyQsbo8+tz0bnDyBp7Oc8d1qmiNuYVPcZXqN5uXyyTQt
         VBY3xqtnjBWYyrhLIXmQFR+7Kk4VkFSNodM3nb2q5Oi+YJguocd16Y2CGc5N8dhitYQ4
         zAlrrUGsa2YZG+FN/ydM/dGCKDyGOuHsbcAVBEZqsXVZjAw84/vqJP7JJpjX0LeE/0Vl
         W7TA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bWTJfnJZ;
       dkim=pass header.i=@chromium.org header.s=google header.b=QMSAWRCQ;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bWTJfnJZ;
       dkim=pass header.i=@chromium.org header.s=google header.b=QMSAWRCQ;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsadJpIqXqSMDLHnGpWmE7ybIFKv9FBOfqrlrihiXhIAesaB32BljIR74fT6VASxyf5lTM7/W689FjSYLe8kYE=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-11-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-11-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:16:58 -0800
X-Google-Sender-Auth: kOZC0CXulIPuPz22ukQKXq4UXcM
Message-ID: <CAGXu5jLnrfn3=UfndR4hePCqMo6_hj85CUzPu+aV4L-r9a_PBg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] test_firmware: add a library for shared helpers
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
X-GMAIL-THRID: =?utf-8?q?1593248722956229960?=
X-GMAIL-MSGID: =?utf-8?q?1593597934123927541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Both fw_fallback.sh and fw_filesystem.sh share a common set of
> boiler plate setup and tests. We can share these in a common place.
> While at it, move both test to use /bin/bash.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  tools/testing/selftests/firmware/fw_fallback.sh   |  69 ++-----------
>  tools/testing/selftests/firmware/fw_filesystem.sh |  61 ++---------
>  tools/testing/selftests/firmware/fw_lib.sh        | 120 ++++++++++++++++++++++

Why not initially create this fw_lib.sh instead of moving it later?

-Kees

>  3 files changed, 137 insertions(+), 113 deletions(-)
>  create mode 100755 tools/testing/selftests/firmware/fw_lib.sh
>
> diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
> index 40b6c1d3e832..0db1c09a6bcc 100755
> --- a/tools/testing/selftests/firmware/fw_fallback.sh
> +++ b/tools/testing/selftests/firmware/fw_fallback.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  # This validates that the kernel will fall back to using the fallback mechanism
>  # to load firmware it can't find on disk itself. We must request a firmware
> @@ -6,68 +6,17 @@
>  # won't find so that we can do the load ourself manually.
>  set -e
>
> -PROC_CONFIG="/proc/config.gz"
> +TEST_REQS_FW_SYSFS_FALLBACK="yes"
> +TEST_REQS_FW_SET_CUSTOM_PATH="no"
>  TEST_DIR=$(dirname $0)
> +source $TEST_DIR/fw_lib.sh
>
> -modprobe test_firmware
> -if [ ! -f $PROC_CONFIG ]; then
> -       if modprobe configs 2>/dev/null; then
> -               echo "Loaded configs module"
> -               if [ ! -f $PROC_CONFIG ]; then
> -                       echo "You must have the following enabled in your kernel:" >&2
> -                       cat $TEST_DIR/config >&2
> -                       echo "Resorting to old heuristics" >&2
> -               fi
> -       else
> -               echo "Failed to load configs module, using old heuristics" >&2
> -       fi
> -fi
> -
> -kconfig_has()
> -{
> -       if [ -f $PROC_CONFIG ]; then
> -               if zgrep -q $1 $PROC_CONFIG 2>/dev/null; then
> -                       echo "yes"
> -               else
> -                       echo "no"
> -               fi
> -       else
> -               # We currently don't have easy heuristics to infer this
> -               # so best we can do is just try to use the kernel assuming
> -               # you had enabled it. This matches the old behaviour.
> -               if [ "$1" = "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y" ]; then
> -                       echo "yes"
> -               elif [ "$1" = "CONFIG_FW_LOADER_USER_HELPER=y" ]; then
> -                       if [ -d /sys/class/firmware/ ]; then
> -                               echo yes
> -                       else
> -                               echo no
> -                       fi
> -               fi
> -       fi
> -}
> -
> -DIR=/sys/devices/virtual/misc/test_firmware
> -
> -HAS_FW_LOADER_USER_HELPER=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)
> -HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
> -
> -if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> -       OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
> -else
> -       echo "usermode helper disabled so ignoring test"
> -       exit 0
> -fi
> -
> -FWPATH=$(mktemp -d)
> -FW="$FWPATH/test-firmware.bin"
> +check_mods
> +check_setup
> +verify_reqs
> +setup_tmp_file
>
> -test_finish()
> -{
> -       echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
> -       rm -f "$FW"
> -       rmdir "$FWPATH"
> -}
> +trap "test_finish" EXIT
>
>  load_fw()
>  {
> diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
> index f9508e1a4058..7f47877fa7fa 100755
> --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  # This validates that the kernel will load firmware out of its list of
>  # firmware locations on disk. Since the user helper does similar work,
> @@ -6,52 +6,15 @@
>  # know so we can be sure we're not accidentally testing the user helper.
>  set -e
>
> -DIR=/sys/devices/virtual/misc/test_firmware
> +TEST_REQS_FW_SYSFS_FALLBACK="no"
> +TEST_REQS_FW_SET_CUSTOM_PATH="yes"
>  TEST_DIR=$(dirname $0)
> +source $TEST_DIR/fw_lib.sh
>
> -test_modprobe()
> -{
> -       if [ ! -d $DIR ]; then
> -               echo "$0: $DIR not present"
> -               echo "You must have the following enabled in your kernel:"
> -               cat $TEST_DIR/config
> -               exit 1
> -       fi
> -}
> -
> -trap "test_modprobe" EXIT
> -
> -if [ ! -d $DIR ]; then
> -       modprobe test_firmware
> -fi
> -
> -# CONFIG_FW_LOADER_USER_HELPER has a sysfs class under /sys/class/firmware/
> -# These days most distros enable CONFIG_FW_LOADER_USER_HELPER but disable
> -# CONFIG_FW_LOADER_USER_HELPER_FALLBACK. We use /sys/class/firmware/ as an
> -# indicator for CONFIG_FW_LOADER_USER_HELPER.
> -HAS_FW_LOADER_USER_HELPER=$(if [ -d /sys/class/firmware/ ]; then echo yes; else echo no; fi)
> -
> -if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> -       OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
> -fi
> -
> -OLD_FWPATH=$(cat /sys/module/firmware_class/parameters/path)
> -
> -FWPATH=$(mktemp -d)
> -FW="$FWPATH/test-firmware.bin"
> -
> -test_finish()
> -{
> -       if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> -               echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
> -       fi
> -       if [ "$OLD_FWPATH" = "" ]; then
> -               OLD_FWPATH=" "
> -       fi
> -       echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
> -       rm -f "$FW"
> -       rmdir "$FWPATH"
> -}
> +check_mods
> +check_setup
> +verify_reqs
> +setup_tmp_file
>
>  trap "test_finish" EXIT
>
> @@ -60,14 +23,6 @@ if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
>         echo 1 >/sys/class/firmware/timeout
>  fi
>
> -# Set the kernel search path.
> -echo -n "$FWPATH" >/sys/module/firmware_class/parameters/path
> -
> -# This is an unlikely real-world firmware content. :)
> -echo "ABCD0123" >"$FW"
> -
> -NAME=$(basename "$FW")
> -
>  if printf '\000' >"$DIR"/trigger_request 2> /dev/null; then
>         echo "$0: empty filename should not succeed" >&2
>         exit 1
> diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> new file mode 100755
> index 000000000000..0702dbf0f06b
> --- /dev/null
> +++ b/tools/testing/selftests/firmware/fw_lib.sh
> @@ -0,0 +1,120 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Library of helpers for test scripts.
> +set -e
> +
> +DIR=/sys/devices/virtual/misc/test_firmware
> +
> +PROC_CONFIG="/proc/config.gz"
> +TEST_DIR=$(dirname $0)
> +
> +print_reqs_exit()
> +{
> +       echo "You must have the following enabled in your kernel:" >&2
> +       cat $TEST_DIR/config >&2
> +       exit 1
> +}
> +
> +test_modprobe()
> +{
> +       if [ ! -d $DIR ]; then
> +               print_reqs_exit
> +       fi
> +}
> +
> +check_mods()
> +{
> +       trap "test_modprobe" EXIT
> +       if [ ! -d $DIR ]; then
> +               modprobe test_firmware
> +       fi
> +       if [ ! -f $PROC_CONFIG ]; then
> +               if modprobe configs 2>/dev/null; then
> +                       echo "Loaded configs module"
> +                       if [ ! -f $PROC_CONFIG ]; then
> +                               echo "You must have the following enabled in your kernel:" >&2
> +                               cat $TEST_DIR/config >&2
> +                               echo "Resorting to old heuristics" >&2
> +                       fi
> +               else
> +                       echo "Failed to load configs module, using old heuristics" >&2
> +               fi
> +       fi
> +}
> +
> +check_setup()
> +{
> +       HAS_FW_LOADER_USER_HELPER=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)
> +       HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
> +
> +       if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> +              OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
> +       fi
> +
> +       OLD_FWPATH=$(cat /sys/module/firmware_class/parameters/path)
> +}
> +
> +verify_reqs()
> +{
> +       if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
> +               if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> +                       echo "usermode helper disabled so ignoring test"
> +                       exit 1
> +               fi
> +       fi
> +}
> +
> +setup_tmp_file()
> +{
> +       FWPATH=$(mktemp -d)
> +       FW="$FWPATH/test-firmware.bin"
> +       echo "ABCD0123" >"$FW"
> +       NAME=$(basename "$FW")
> +       if [ "$TEST_REQS_FW_SET_CUSTOM_PATH" = "yes" ]; then
> +               echo -n "$FWPATH" >/sys/module/firmware_class/parameters/path
> +       fi
> +}
> +
> +test_finish()
> +{
> +       if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> +               echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
> +       fi
> +       if [ "$OLD_FWPATH" = "" ]; then
> +               OLD_FWPATH=" "
> +       fi
> +       if [ "$TEST_REQS_FW_SET_CUSTOM_PATH" = "yes" ]; then
> +               echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
> +       fi
> +       if [ -f $FW ]; then
> +               rm -f "$FW"
> +       fi
> +       if [ -d $FWPATH ]; then
> +               rm -rf "$FWPATH"
> +       fi
> +}
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
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
