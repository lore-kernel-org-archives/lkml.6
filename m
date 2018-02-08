Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518048549; cv=none;
        d=google.com; s=arc-20160816;
        b=q7QCx+omEKVPlFE1PKywlYJt+ODn+xvSFfIjujdG00ifkkW8r6U++zVE9gmwEXPMCU
         OKK7otJ7rhi73CXngK9NdzCOBNtvV0Ee+EFQu6ooEYA5T0qdQIsQfSr4ad9mJwwjW3g9
         KWDfc05ogG4G/S9rd87/+IpjBGin7BB9GBFZSeWEqcmRbFlQ4cqcxvjipD24DAWASy1f
         u9qawYxY+XhfAMfpMz6AjT49tSZQ7XoKiMroMAfUgOMkaqhmDivxDL4L5XCkFBA9CgP4
         pvIbN4MGbd79NNl0YGKWCNKw4fGCp7VQ5HjZwib3QBkoWPnWXwHEIIkEHKTnhthbgL4e
         iLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=v118VcUwLFs3DMgiDhxltFyw1kThWSYaahq7m5clhfY=;
        b=xvdLkyXVgKbbHga1eIogHtKSPDZwG/IYSLHKZhBaJuJWtM5Z3Qm+4L2RyP/vsw/iA7
         X0pgESHwhfhDf/712biw/r24Ow6v2h5H+wsBBn4gPo4KnBCLk/MKBLAzkPLZ4A4oXc3J
         QJ89y4xK/cLrVVDOu6bQdXq+PESWHImPbGBJ1z4bKod6HWbD3KdfuRQFxJvuY7xOX5g3
         DeT8JdkQKtNZ5BF+/bOBfau/N61EduOvJD0cmEwKtDtjSlOztYi9R99FnQ7D4FLbZVMB
         65L7DLW67j9eh4rHc2qOVQhSRy1fO8JoCXGauw8zl9mjK3Ev5wwVnWou2+d5vV5t6Yhz
         mCmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XRWlg44X;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XRWlg44X;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227T8cdpRt8/72CZCu/XQKVfkzljpBkuNk9CdNDDtLmB5NbsPNoBGD4CcrTDOh3hV8r7rxml7ZXGK98fTCS98ps=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-11-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-11-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 01:09:09 +0100
Message-ID: <CAFkk2KSnXQXjPRStKUk7QCoGuXGrD3HqMUfL9aurkia3_3kYEA@mail.gmail.com>
Subject: Re: [PATCH 10/14] kconfig: test: check if new symbols in choice are asked
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778323035647?=
X-GMAIL-MSGID: =?utf-8?q?1591789276341071591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> If new choice values are added with new dependency, and they become
> visible during user configuration, oldconfig should recognize them
> as (NEW), and ask the user for choice.
>
> This issue was fixed by commit 5d09598d488f ("kconfig: fix new choices
> being skipped upon config update").
>
> This is a subtle corner case.  Add a test case to avoid breakage.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/tests/new_choice_with_dep/Kconfig  | 37 ++++++++++++++++++++++
>  .../kconfig/tests/new_choice_with_dep/__init__.py  | 14 ++++++++
>  scripts/kconfig/tests/new_choice_with_dep/config   |  3 ++
>  .../tests/new_choice_with_dep/expected_stdout      | 10 ++++++
>  4 files changed, 64 insertions(+)
>  create mode 100644 scripts/kconfig/tests/new_choice_with_dep/Kconfig
>  create mode 100644 scripts/kconfig/tests/new_choice_with_dep/__init__.py
>  create mode 100644 scripts/kconfig/tests/new_choice_with_dep/config
>  create mode 100644 scripts/kconfig/tests/new_choice_with_dep/expected_stdout
>
> diff --git a/scripts/kconfig/tests/new_choice_with_dep/Kconfig b/scripts/kconfig/tests/new_choice_with_dep/Kconfig
> new file mode 100644
> index 0000000..53ef1b8
> --- /dev/null
> +++ b/scripts/kconfig/tests/new_choice_with_dep/Kconfig
> @@ -0,0 +1,37 @@
> +config A
> +       bool "A"
> +       help
> +         This is a new symbol.
> +
> +choice
> +       prompt "Choice ?"
> +       depends on A
> +       help
> +         "depends on A" has been newly added.
> +
> +config CHOICE_B
> +       bool "Choice B"
> +
> +config CHOICE_C
> +       bool "Choice C"
> +       help
> +         This is a new symbol, so should be asked.
> +
> +endchoice
> +
> +choice
> +       prompt "Choice2 ?"
> +
> +config CHOICE_D
> +       bool "Choice D"
> +
> +config CHOICE_E
> +       bool "Choice E"
> +
> +config CHOICE_F
> +       bool "Choice F"
> +       depends on A
> +       help
> +         This is a new symbol, so should be asked.
> +
> +endchoice
> diff --git a/scripts/kconfig/tests/new_choice_with_dep/__init__.py b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
> new file mode 100644
> index 0000000..4306ccf
> --- /dev/null
> +++ b/scripts/kconfig/tests/new_choice_with_dep/__init__.py
> @@ -0,0 +1,14 @@
> +"""
> +Ask new choice values when they become visible
> +==============================================
> +
> +If new choice values are added with new dependency, and they become
> +visible during user configuration, oldconfig should recognize them
> +as (NEW), and ask the user for choice.
> +
> +Related Linux commit: 5d09598d488f081e3be23f885ed65cbbe2d073b5
> +"""
> +
> +def test(conf):
> +    assert conf.oldconfig('config', 'y') == 0
> +    assert conf.stdout_contains('expected_stdout')
> diff --git a/scripts/kconfig/tests/new_choice_with_dep/config b/scripts/kconfig/tests/new_choice_with_dep/config
> new file mode 100644
> index 0000000..47ef95d
> --- /dev/null
> +++ b/scripts/kconfig/tests/new_choice_with_dep/config
> @@ -0,0 +1,3 @@
> +CONFIG_CHOICE_B=y
> +# CONFIG_CHOICE_D is not set
> +CONFIG_CHOICE_E=y
> diff --git a/scripts/kconfig/tests/new_choice_with_dep/expected_stdout b/scripts/kconfig/tests/new_choice_with_dep/expected_stdout
> new file mode 100644
> index 0000000..358d5cf
> --- /dev/null
> +++ b/scripts/kconfig/tests/new_choice_with_dep/expected_stdout
> @@ -0,0 +1,10 @@
> +A (A) [N/y/?] (NEW)
> +  Choice ?
> +  > 1. Choice B (CHOICE_B)
> +    2. Choice C (CHOICE_C) (NEW)
> +  choice[1-2?]:
> +Choice2 ?
> +  1. Choice D (CHOICE_D)
> +> 2. Choice E (CHOICE_E)
> +  3. Choice F (CHOICE_F) (NEW)
> +choice[1-3?]:
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
