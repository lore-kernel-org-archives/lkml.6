Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEGLET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:04:19 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42755 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeEGLER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:04:17 -0400
X-Google-Smtp-Source: AB8JxZp0TJC2H8Vt+QRtgZ4hp35c3SJZjqf3xlDk1tbDHFDw4QxgV5tMnYROPZR/lyc0wUC8WA5XzXjNHi3FTj1OduI=
MIME-Version: 1.0
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 7 May 2018 16:34:16 +0530
Message-ID: <CAOuPNLjqAqF3Ls76ab+9QtTOmrCwYzYzXPye7i9mLp8DwqMaMQ@mail.gmail.com>
Subject: Re: [PATCH 01/24] selftests: android: ion: return Kselftest Skip code
 for skipped tests
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 5, 2018 at 6:43 AM, Shuah Khan (Samsung OSG)
<shuah@kernel.org> wrote:
> When ion test is skipped because of unmet dependencies and/or unsupported
> configuration, it returns 0 which is treated as a pass by the Kselftest
> framework. This leads to false positive result even when the test could
> not be run.
>
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
>
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  tools/testing/selftests/android/ion/ion_test.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/android/ion/ion_test.sh b/tools/testing/selftests/android/ion/ion_test.sh
> index a1aff506f5e6..69e676cfc94e 100755
> --- a/tools/testing/selftests/android/ion/ion_test.sh
> +++ b/tools/testing/selftests/android/ion/ion_test.sh
> @@ -4,6 +4,9 @@ heapsize=4096
>  TCID="ion_test.sh"
>  errcode=0
>
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  run_test()
>  {
>         heaptype=$1
> @@ -25,7 +28,7 @@ check_root()
>         uid=$(id -u)
>         if [ $uid -ne 0 ]; then
>                 echo $TCID: must be run as root >&2
> -               exit 0
> +               exit $ksft_skip
>         fi
>  }
>
> @@ -35,7 +38,7 @@ check_device()
>         if [ ! -e $DEVICE ]; then
>                 echo $TCID: No $DEVICE device found >&2
>                 echo $TCID: May be CONFIG_ION is not set >&2
> -               exit 0
> +               exit $ksft_skip
>         fi
>  }
>

Ok changes looks good to me.

Acked-by: Pintu Agarwal <pintu.ping@gmail.com>


> --
> 2.14.1
>
