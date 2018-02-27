Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773497; cv=none;
        d=google.com; s=arc-20160816;
        b=q3hknbDAx+YvRCswie3LNe1sq9fRMkySZ2Hj9l/XOhFrK90Z1PJSMkkRT4EqEkLVk8
         u5EXH3HPYzlycvBNQfsesmlmmJGdBXKjFUPv/j/8lp32m6SmBELgiGYGr9eqNahfTNYF
         rtimnBHabhbkdKJFlMTQ8T6xW9vNk2DxxQRJvCdsvZJSnkaPsIZTsoba5lOK1QfSBnvs
         24A8I6E7casnrdy8/n4N8iG95dhNFkKxbuMvDkzTp1zi1LrlXlm2IeYIQfL8sbHW8IxC
         u7t5b0IVH+7RWxtyTESEmngKFglqrP0pw9EnxgI3vbmR47FstiPvMX0WVqPzYFeZBXzZ
         kr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=RCStORM3KLC1yQsyLCWIZOTuiyl0cOicnh5cHTFD3jg=;
        b=d/s/fhhHKm5meOZPj7YNcUdtLa8AtVcGsZ43jZ9YoxRNRnu4Ll4Bkr3OFuZFYA4+lO
         R8D0hmPvRs9WO86zxH64csM5JRTcRhwzio43hI3ezgGKwpYP2tOvt84Mpji3pW3abP3X
         ASrzDKXbYL8lzqW+ucKoQSV7n6sfwRBlMUR2Ym3ToZL9o42OTsbyz5MRWMIFSBpdX1Yt
         wEOieiHdOnlDizbI1UswQy5vIY2tInuyUbmEoP1GICLC3X/dyrZUMe6X2AmgKx6pWGeV
         xN7IXCECq3DWuUWEtHA+SZWLG6EgQj/KeB6EaxFIi6Nxx9kkZKdNMgJDKzTDmYNFYXvj
         bDAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HUO5NTpB;
       dkim=pass header.i=@chromium.org header.s=google header.b=Yvb5dIc0;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HUO5NTpB;
       dkim=pass header.i=@chromium.org header.s=google header.b=Yvb5dIc0;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELuMYzYVtH/h7WVoW+It/4lbLhaM98Ir6xWt+UAtkHXUdqKhfdR4nSGPDaJcOWteCnF6LayHNwEMa8NwtnPdyRU=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-12-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-12-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:18:15 -0800
X-Google-Sender-Auth: LexbnLj9n3Nqmne1v2shm8inG-M
Message-ID: <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] test_firmware: test three firmware kernel
 configs using a proc knob
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
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593598014306120702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Since we now have knobs to twiddle what used to be set on kernel
> configurations we can build one base kernel configuration and modify
> behaviour to mimic such kernel configurations to test them.
>
> Provided you build a kernel with:
>
> CONFIG_TEST_FIRMWARE=y
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
>
> We should now be able test all possible kernel configurations
> when FW_LOADER=y. Note that when FW_LOADER=m we just don't provide
> the built-in functionality of the built-in firmware.
>
> If you're on an old kernel and either don't have /proc/config.gz
> (CONFIG_IKCONFIG_PROC) or haven't enabled CONFIG_FW_LOADER_USER_HELPER
> we cannot run these dynamic tests, so just run both scripts just
> as we used to before making blunt assumptions about your setup
> and requirements exactly as we did before.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Cool. Nice to have it all in one test build now. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/firmware/Makefile        |  2 +-
>  tools/testing/selftests/firmware/fw_lib.sh       | 53 +++++++++++++++++++
>  tools/testing/selftests/firmware/fw_run_tests.sh | 67 ++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/firmware/fw_run_tests.sh
>
> diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
> index 1894d625af2d..826f38d5dd19 100644
> --- a/tools/testing/selftests/firmware/Makefile
> +++ b/tools/testing/selftests/firmware/Makefile
> @@ -3,7 +3,7 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>
> -TEST_PROGS := fw_filesystem.sh fw_fallback.sh
> +TEST_PROGS := fw_run_tests.sh
>
>  include ../lib.mk
>
> diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> index 0702dbf0f06b..3362a2aac40e 100755
> --- a/tools/testing/selftests/firmware/fw_lib.sh
> +++ b/tools/testing/selftests/firmware/fw_lib.sh
> @@ -47,6 +47,34 @@ check_setup()
>  {
>         HAS_FW_LOADER_USER_HELPER=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)
>         HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
> +       PROC_FW_IGNORE_SYSFS_FALLBACK="N"
> +       PROC_FW_FORCE_SYSFS_FALLBACK="N"
> +
> +       if [ -z $PROC_SYS_DIR ]; then
> +               PROC_SYS_DIR="/proc/sys/kernel"
> +       fi
> +
> +       FW_PROC="${PROC_SYS_DIR}/firmware_config"
> +       FW_FORCE_SYSFS_FALLBACK="$FW_PROC/force_sysfs_fallback"
> +       FW_IGNORE_SYSFS_FALLBACK="$FW_PROC/ignore_sysfs_fallback"
> +
> +       if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
> +               PROC_FW_FORCE_SYSFS_FALLBACK=$(cat $FW_FORCE_SYSFS_FALLBACK)
> +       fi
> +
> +       if [ -f $FW_IGNORE_SYSFS_FALLBACK ]; then
> +               PROC_FW_IGNORE_SYSFS_FALLBACK=$(cat $FW_IGNORE_SYSFS_FALLBACK)
> +       fi
> +
> +       if [ "$PROC_FW_IGNORE_SYSFS_FALLBACK" = "1" ]; then
> +               HAS_FW_LOADER_USER_HELPER_FALLBACK="no"
> +               HAS_FW_LOADER_USER_HELPER="no"
> +       fi
> +
> +       if [ "$PROC_FW_FORCE_SYSFS_FALLBACK" = "1" ]; then
> +               HAS_FW_LOADER_USER_HELPER="yes"
> +               HAS_FW_LOADER_USER_HELPER_FALLBACK="yes"
> +       fi
>
>         if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
>                OLD_TIMEOUT=$(cat /sys/class/firmware/timeout)
> @@ -76,6 +104,30 @@ setup_tmp_file()
>         fi
>  }
>
> +proc_set_force_sysfs_fallback()
> +{
> +       if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
> +               echo -n $1 > $FW_FORCE_SYSFS_FALLBACK
> +               PROC_FW_FORCE_SYSFS_FALLBACK=$(cat $FW_FORCE_SYSFS_FALLBACK)
> +               check_setup
> +       fi
> +}
> +
> +proc_set_ignore_sysfs_fallback()
> +{
> +       if [ -f $FW_IGNORE_SYSFS_FALLBACK ]; then
> +               echo -n $1 > $FW_IGNORE_SYSFS_FALLBACK
> +               PROC_FW_IGNORE_SYSFS_FALLBACK=$(cat $FW_IGNORE_SYSFS_FALLBACK)
> +               check_setup
> +       fi
> +}
> +
> +proc_restore_defaults()
> +{
> +       proc_set_force_sysfs_fallback 0
> +       proc_set_ignore_sysfs_fallback 0
> +}
> +
>  test_finish()
>  {
>         if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> @@ -93,6 +145,7 @@ test_finish()
>         if [ -d $FWPATH ]; then
>                 rm -rf "$FWPATH"
>         fi
> +       proc_restore_defaults
>  }
>
>  kconfig_has()
> diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
> new file mode 100755
> index 000000000000..a12b5809ad8b
> --- /dev/null
> +++ b/tools/testing/selftests/firmware/fw_run_tests.sh
> @@ -0,0 +1,67 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This runs all known tests across all known possible configurations we could
> +# emulate in one run.
> +
> +set -e
> +
> +TEST_DIR=$(dirname $0)
> +source $TEST_DIR/fw_lib.sh
> +
> +run_tests()
> +{
> +       $TEST_DIR/fw_filesystem.sh
> +       $TEST_DIR/fw_fallback.sh
> +}
> +
> +run_test_config_0001()
> +{
> +       echo "-----------------------------------------------------"
> +       echo "Running kernel configuration test 1 -- rare"
> +       echo "Emulates:"
> +       echo "CONFIG_FW_LOADER=y"
> +       echo "CONFIG_FW_LOADER_USER_HELPER=n"
> +       echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
> +       proc_set_force_sysfs_fallback 0
> +       proc_set_ignore_sysfs_fallback 1
> +       run_tests
> +}
> +
> +run_test_config_0002()
> +{
> +       echo "-----------------------------------------------------"
> +       echo "Running kernel configuration test 2 -- distro"
> +       echo "Emulates:"
> +       echo "CONFIG_FW_LOADER=y"
> +       echo "CONFIG_FW_LOADER_USER_HELPER=y"
> +       echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n"
> +       proc_set_force_sysfs_fallback 0
> +       proc_set_ignore_sysfs_fallback 0
> +       run_tests
> +}
> +
> +run_test_config_0003()
> +{
> +       echo "-----------------------------------------------------"
> +       echo "Running kernel configuration test 3 -- android"
> +       echo "Emulates:"
> +       echo "CONFIG_FW_LOADER=y"
> +       echo "CONFIG_FW_LOADER_USER_HELPER=y"
> +       echo "CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y"
> +       proc_set_force_sysfs_fallback 1
> +       proc_set_ignore_sysfs_fallback 0
> +       run_tests
> +}
> +
> +check_mods
> +check_setup
> +
> +if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
> +       run_test_config_0001
> +       run_test_config_0002
> +       run_test_config_0003
> +else
> +       echo "Running basic kernel configuration, working with your config"
> +       run_test
> +fi
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
