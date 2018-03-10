Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520702198; cv=none;
        d=google.com; s=arc-20160816;
        b=YDCBnBk9Of4LTnwfsSLtzJdQyBho1Ngt6Km76bXpFogWHwOflqmuDpD+tXYW+qguaH
         JQe3910mtSNa2I+nH1kItL4bUz6MAHOj3lx/i4n4osL09pCImbCX41tTL7Lzz9mKt8uO
         zden1MjTqb3OCn6dcqH0T+35BbN6XS1QvqVs6oViZcoFZS4DEaPkbkzDKgWwoftcAgio
         Cwsjd4U0mQ66nhslJgaQOBpsCBMY8ka5Oy7W/IFiqcZ/K9DQePIZ9KXqK43ppwFbYDQe
         Bnn35xYXMlh0I2uWZt5xwmq6pklqzrzS3GaU3l+NRlbJnvodL9iuDxlOpcemOKw5W2sX
         vWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=8RfMgxi8h1sQG6xkUhH3HHMwfQLrmYMYdW8Js2c58js=;
        b=bNHKA3Lj60b42y4oG2wjDdyPirfuHxYfFEzQqRNgF4N74x3ai9UkksdUATRNvK65f5
         U2UHkwlkgkKnkM1/NhbuYSPVUpyTspJWhUueV/mK3T7UsHlfcb2kDCL4g69Zd9n1g+gW
         J37ZQEEuisf/IH1Yv6R/icMPveRi/lVKFO4l/g01lNsIm0EsaqbEEt4jRrvwIjZIRfsi
         kFi8iaCCacrBULg0b2S0H0plgxZZ0q1CmKYR6VmMzIags/U+3ac+dNLx2QKpDcmMDiLt
         PZ9A8yfS9+Yj14yfKz2KAhdFfO6MQwMpOIi4RGYCJj7UikxN8KIRaxLQ28/3SsrguqJg
         gIJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=KezFTcnd;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZJRrA2TL;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=KezFTcnd;
       dkim=pass header.i=@chromium.org header.s=google header.b=ZJRrA2TL;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELv7ef2tRhzGd5LIqOTNm3v4M9yNSocuFWfZv7beTZ0x1/d4bzc9g+6n8t03oGh6L0eR2fGt/tZKLrx2GF+vCVQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Mar 2018 09:16:36 -0800
X-Google-Sender-Auth: 34xoLRISOXIsoONw2OiTb7ap0xg
Message-ID: <CAGXu5jJqzahD=iwv8_ipvebi8kQ=UVPiMrHOtQL5iLyviFm6jQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] firmware: development for v4.17
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Bitterblue of Monsea <cantabile.desu@gmail.com>, Jakub Kicinski <kubakici@wp.pl>,
	linux-wireless <linux-wireless@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com, Takashi Iwai <tiwai@suse.de>,
	arend.vanspriel@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Nicolas Broeking <nbroeking@me.com>, Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	oneukum@suse.com, ast@fb.com, andresx7@gmail.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560413093563327?=
X-GMAIL-MSGID: =?utf-8?q?1594571827749509343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 6:14 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Greg,
>
> Here's a respin of what I have queued up for v4.17 for the firmware API. It
> combines the cleanup I've been working on and the addition of the new API call
> request_firmware_cache() for fixing a corner case suspend issue on some type of
> cards with an optimization in place where the firmware is *not* needed on
> reboot.
>
> The cleanup work allows us to test the firmware API with one kernel
> configuration. I've addressed Kees' feedback on this respin and
> combined the code into drivers/base/firmware_class/.
>
> I've made one new test_firmware change in consideration for one firmware
> change, the patch "firmware: ensure the firmware cache is not used on
> incompatible calls" requires us to modify our tests scripts to use
> the APIs sanely as well.
>
> I've put up these changes on my git tree, refer to the branch
> "20180307-firmware-dev-for-v4.17" based on linux-next [0] and
> the same name based on Linus' tree [1].
>
> Questions, feedback, and specially rants are always welcomed.

This all looks good to me! Thanks for respinning. :)

-Kees

>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20180307-firmware-dev-for-v4.17
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20180307-firmware-dev-for-v4.17
>
> Luis R. Rodriguez (20):
>   test_firmware: add simple firmware firmware test library
>   test_firmware: enable custom fallback testing on limited kernel
>     configs
>   test_firmware: replace syfs fallback check with kconfig_has helper
>   firmware: enable to split firmware_class into separate target files
>   firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK further
>   firmware: use helpers for setting up a temporary cache timeout
>   firmware: move loading timeout under struct firmware_fallback_config
>   firmware: split firmware fallback functionality into its own file
>   firmware: move firmware loader into its own directory
>   firmware: enable run time change of forcing fallback loader
>   firmware: enable to force disable the fallback mechanism at run time
>   test_firmware: expand on library with shared helpers
>   test_firmware: test three firmware kernel configs using a proc knob
>   rename: _request_firmware_load() fw_load_sysfs_fallback()
>   firmware: fix checking for return values for fw_add_devm_name()
>   firmware: add helper to check to see if fw cache is setup
>   test_firmware: modify custom fallback tests to use unique files
>   firmware: ensure the firmware cache is not used on incompatible calls
>   firmware: add request_firmware_cache() to help with cache on reboot
>   mt7601u: use request_firmware_cache() to address cache on reboot
>
>  .../driver-api/firmware/fallback-mechanisms.rst    |   2 +-
>  .../driver-api/firmware/request_firmware.rst       |  14 +
>  MAINTAINERS                                        |   2 +-
>  drivers/base/Makefile                              |   2 +-
>  drivers/base/firmware_loader/Makefile              |   7 +
>  drivers/base/firmware_loader/fallback.c            | 674 +++++++++++++++++
>  drivers/base/firmware_loader/fallback.h            |  67 ++
>  drivers/base/firmware_loader/fallback_table.c      |  55 ++
>  drivers/base/firmware_loader/firmware.h            | 115 +++
>  .../{firmware_class.c => firmware_loader/main.c}   | 833 ++-------------------
>  drivers/net/wireless/mediatek/mt7601u/mcu.c        |   2 +-
>  include/linux/firmware.h                           |   3 +
>  kernel/sysctl.c                                    |  11 +
>  tools/testing/selftests/firmware/Makefile          |   2 +-
>  tools/testing/selftests/firmware/config            |   4 +
>  tools/testing/selftests/firmware/fw_fallback.sh    |  65 +-
>  tools/testing/selftests/firmware/fw_filesystem.sh  |  72 +-
>  tools/testing/selftests/firmware/fw_lib.sh         | 194 +++++
>  tools/testing/selftests/firmware/fw_run_tests.sh   |  70 ++
>  19 files changed, 1332 insertions(+), 862 deletions(-)
>  create mode 100644 drivers/base/firmware_loader/Makefile
>  create mode 100644 drivers/base/firmware_loader/fallback.c
>  create mode 100644 drivers/base/firmware_loader/fallback.h
>  create mode 100644 drivers/base/firmware_loader/fallback_table.c
>  create mode 100644 drivers/base/firmware_loader/firmware.h
>  rename drivers/base/{firmware_class.c => firmware_loader/main.c} (60%)
>  create mode 100755 tools/testing/selftests/firmware/fw_lib.sh
>  create mode 100755 tools/testing/selftests/firmware/fw_run_tests.sh
>
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
