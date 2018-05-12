Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeELQMN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 12:12:13 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32823 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeELQML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 12:12:11 -0400
X-Google-Smtp-Source: AB8JxZoRmEr1dQH3lN7mtYbWMBuRYMXQlNnvHN+iqZWlcSyO0CVm9FMfXxN4gWyvg7LmevfYY19hYNszGN1YfQKiAA0=
MIME-Version: 1.0
In-Reply-To: <20180502211848.22404-1-shuah@kernel.org>
References: <20180502211848.22404-1-shuah@kernel.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Sat, 12 May 2018 21:42:10 +0530
Message-ID: <CAOuPNLhZyWQfm=eK440suESciE-1q0Rpwx0nKHXWD2jxMZ74xw@mail.gmail.com>
Subject: Re: [PATCH] selftests: android: delete RUN_TESTS and EMIT_TESTS overrides
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 2:48 AM, Shuah Khan (Samsung OSG)
<shuah@kernel.org> wrote:
> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
> lib.mk. Common defines work just fine and there is no need to define
> custom overrides.
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  tools/testing/selftests/android/Makefile | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
> index f6304d2be90c..72c25a3cb658 100644
> --- a/tools/testing/selftests/android/Makefile
> +++ b/tools/testing/selftests/android/Makefile
> @@ -18,10 +18,6 @@ all:
>                 fi \
>         done
>
> -override define RUN_TESTS
> -       @cd $(OUTPUT); ./run.sh
> -endef
> -
>  override define INSTALL_RULE
>         mkdir -p $(INSTALL_PATH)
>         install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
> @@ -33,10 +29,6 @@ override define INSTALL_RULE
>         done;
>  endef
>
> -override define EMIT_TESTS
> -       echo "./run.sh"
> -endef
> -
>  override define CLEAN
>         @for DIR in $(SUBDIRS); do              \
>                 BUILD_TARGET=$(OUTPUT)/$$DIR;   \
> --
> 2.14.1
>

OK.

Acked-by: Pintu Agarwal <pintu.ping@gmail.com>

---

Note: This mail goes into my spam email box.
