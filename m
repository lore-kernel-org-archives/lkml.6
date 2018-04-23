Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524501543; cv=none;
        d=google.com; s=arc-20160816;
        b=THfns918EnYv4gOvRDfTmjFCiHWQv4ckh3C3yCkD0S3KLrx75W6e6Bde3UZdh9TrYa
         thjP3u4nhkZfm1gwsxuUbNQ1a+q0ZWTxoVAoIZGNFIivKAFPcYLzqJaMrfesQKzvZY07
         +aMjPJVMOM7X/hX2X2fHCGXsF4oQU71NWCvfmRmGHU3UrYXsmvD8RdF1GLASWoxPJg+1
         IbRnKJ/ggc/f7KyklwEU4+M7d7nmlE7TZunItUCApJNxZkV7DGM2Lgrb+gUA4MKOhDg3
         Hq1Ys13p1lf7fpvs+fOr3rOZZDwDQarqpT3KEeTFglRT2RSlWfBL2aSZ9k6DifdCsBw8
         M6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=D4ry4wpWUcfDh/UpRvXoIxcWIqXZD6slUjaN5jaZjOM=;
        b=fQmCPoLzEm17OgRCr1UC18teivPvz0KtyLu7jDV6T6PsZJQwLvVm8w5PWykPJIETzC
         MYJd4pRTUFwAtueAm6ZTwfoOHl67eRvnXREsW8I5KNhDXBF6fwBR/R9VCUZ4iJj4/8A4
         /17rTPu0pF9Egttwj++mpzbFVU4S2/EG8qzomnqYOM38BmT4PMk8mtXh3WqdGXsQKUKS
         dNKQIPH0U8fDe50cEvvrCqDWJqRkVzwJqc5U9g1XrFWmP5NSsAS/QRUFQ3J7RcjwfC04
         rqRfUQdlAcfTgnWz1bbmRvDoOcIRCjhX2YyLaTEC6o62ppJbpPGxUOAwSRoYBlLwo+cd
         NNYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CTC+yoIn;
       dkim=pass header.i=@chromium.org header.s=google header.b=kC7ne25t;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=CTC+yoIn;
       dkim=pass header.i=@chromium.org header.s=google header.b=kC7ne25t;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+XOLOZYseJUrupHdqXjhQtuVIo9HowDPQWOuitrQo0e4rFAyek8mpSkSSkjyMUcGe61k831LXSfwMdFxYq6Dw=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180423141022.5019-1-ahiliation@yahoo.co.in>
References: <20180423141022.5019-1-ahiliation@yahoo.co.in>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 23 Apr 2018 09:39:02 -0700
X-Google-Sender-Auth: BOwgsKTw5BcYEwzRiVxVlS4UgHg
Message-ID: <CAGXu5jL0FKq=_fESYT78_LPOVYQ4MsPHQ6u_RgFBJa4fzNN3rQ@mail.gmail.com>
Subject: Re: [PATCH] selftests:firmware: fixes a call to a wrong function name
To: Shuah Khan <shuah@kernel.org>, Jeffrin Jose T <ahiliation@yahoo.co.in>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598546450187595839?=
X-GMAIL-MSGID: =?utf-8?q?1598555730587936717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 7:10 AM, Jeffrin Jose T <ahiliation@yahoo.co.in> wrote:
>  This is a patch to the tools/testing/selftests/firmware/fw_run_tests.sh
>  file which fixes a bug which calls to a wrong function name,which in turn
>  blocks the execution of certain tests.
>
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
>
> ---
>  tools/testing/selftests/firmware/fw_run_tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
> index 06d638e9dc62..cffdd4eb0a57 100755
> --- a/tools/testing/selftests/firmware/fw_run_tests.sh
> +++ b/tools/testing/selftests/firmware/fw_run_tests.sh
> @@ -66,5 +66,5 @@ if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
>         run_test_config_0003
>  else
>         echo "Running basic kernel configuration, working with your config"
> -       run_test
> +       run_tests
>  fi

I find it confusing that run_tests() uses $1 and $2 but later ignores
them unless -f $FW_FORCE_SYSFS_FALLBACK, which is checked at both the
top level and in proc_set_*_fallback()... I'd expected the test to
happen only in run_tests() and have it removed from from
proc_set_*_fallback().

Regardless, the above patch is correct to run the tests. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
