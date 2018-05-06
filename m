Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AB8JxZqAoPoK428dvRUvSpYn3cB0lb8ar5Sb2xdQfE2MMeVJ4C1ZfPfbXUYhMhBxS6Lkpbo6hAlT
ARC-Seal: i=1; a=rsa-sha256; t=1525594558; cv=none;
        d=google.com; s=arc-20160816;
        b=nykliRuvqgrEBlUEVEsw7xb8nHnyeE7WeQlQ54lTpYqUZugdkFSkFY+Ls/5RWjRy03
         H3SsLGsLbzewglNG4qDk55aaGPPqv0Ts+Qjee3W0XhQqeU6TKdTEq5eIy316f670HYfd
         XMbTAb+4RqoNXRKe9M/4MMh2cw2vtBvnKHaCZujpovFXTSbNXKvvmOXEi2UU8/VABDYW
         Rathfcm52mrroDP+quSyeX4XE8ILfXCN+kzmJMmfAmfORxGYl8x/0O673wLO+UStshRb
         IJ8XwxJ4XyHl+rEk7HFQAAbMR0oZBEUl3omjbgmacigILFCYqxgEObJxMi+mV96LOzPy
         k2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=t9pCBjh+jW3NqypHOiEdUxLrceCuNJktd2irRbA1d1k=;
        b=PrX/7wi/Qzar77glxZI4XVSDVdvasEbyi3zZF7cx2BJLr5Yb+9uIY2wlp2gV/Uplhr
         rvx2DUhJyuk3B0h006mO2Qmly85mohFw5DVTBOIrczkrtRumWGsWlLWO0+dJVbsmJgM9
         qyNEucIlmqkLQuZUPMzcFKcysmglcnjt6tKLYC136o8wV1tPRa7xDpNZ4CNZFzU1O0tH
         NIDpr8kGuGEjl/qWLjZV3tA7oRUaMnXGf1uMZ6Kwj7ErCO4A62/oosmHzqnLqkm9LEH/
         CEIqgYzWLXTtfabrI67y2QpQMCGw8Q4R6aFu3LD2sDgd4bbneBlMQgYZISm/BG0a4qOK
         0GqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Sun, 6 May 2018 10:15:56 +0200
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: gregkh@linuxfoundation.org, ebiederm@xmission.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/24] selftests: filesystems: return Kselftest Skip code
 for skipped tests
Message-ID: <20180506081555.GA9705@gmail.com>
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-7-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180505011328.32078-7-shuah@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599584748100996964?=
X-GMAIL-MSGID: =?utf-8?q?1599701839610755318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 07:13:11PM -0600, Shuah Khan (Samsung OSG) wrote:
> When devpts_pts test is skipped because of unmet dependencies and/or
> unsupported configuration, it exits with error which is treated as
> a fail by the Kselftest framework. This leads to false negative
> result even when the test could not be run.
> 
> In another case, it returns pass for a skipped test reporting a false
> postive.
> 
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
> 
> Change it to use ksft_exit_skip() when test is skipped.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks, Shuah!
Christian

> ---
>  tools/testing/selftests/filesystems/devpts_pts.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
> index b9055e974289..0f2d9f427944 100644
> --- a/tools/testing/selftests/filesystems/devpts_pts.c
> +++ b/tools/testing/selftests/filesystems/devpts_pts.c
> @@ -11,6 +11,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/wait.h>
> +#include "../kselftest.h"
>  
>  static bool terminal_dup2(int duplicate, int original)
>  {
> @@ -125,10 +126,12 @@ static int do_tiocgptpeer(char *ptmx, char *expected_procfd_contents)
>  		if (errno == EINVAL) {
>  			fprintf(stderr, "TIOCGPTPEER is not supported. "
>  					"Skipping test.\n");
> -			fret = EXIT_SUCCESS;
> +			fret = KSFT_SKIP;
> +		} else {
> +			fprintf(stderr,
> +				"Failed to perform TIOCGPTPEER ioctl\n");
> +			fret = EXIT_FAILURE;
>  		}
> -
> -		fprintf(stderr, "Failed to perform TIOCGPTPEER ioctl\n");
>  		goto do_cleanup;
>  	}
>  
> @@ -281,7 +284,7 @@ int main(int argc, char *argv[])
>  	if (!isatty(STDIN_FILENO)) {
>  		fprintf(stderr, "Standard input file desciptor is not attached "
>  				"to a terminal. Skipping test\n");
> -		exit(EXIT_FAILURE);
> +		exit(KSFT_SKIP);
>  	}
>  
>  	ret = unshare(CLONE_NEWNS);
> -- 
> 2.14.1
> 
