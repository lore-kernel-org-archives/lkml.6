Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518047939; cv=none;
        d=google.com; s=arc-20160816;
        b=g8GvSj8xiWHC08lwzkpwW9ET/11Z4HBVPcGjxe4ZlZ2eutNOFyN7D45J5Dmo/UYcbW
         vRyZiLARtNZ4sLMv3I1/riSoyO27o9HdGNT6EdjfT1DGJvtzfK6DyZzTaXuw+d2q1MAu
         dWEmapjzgsvzCgnzmReSMA40pTmzJvyquxm8kj39sQIKNXZcTPjci5ZBc/DQ6Hq9xNJK
         ZSLiqkW4TIzym1qVziz54pdGFwGWnFXYtEsNs82hFV3Kwhd1kIQjJFwa/49LcTRlkhiw
         ws0bYZqWN3lYdNbW5eo2SDs51Bc6pPRpqsmGqjC9j/PylaiWWdtZr4gHHXn61T8mGmym
         ixSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ywtqmartQEunV9fbWF/KXCB7DPt00XLuf9ZvvJwsGcc=;
        b=piryw71swe0lJw10sQZTJCq7OiCONS7sQpoaO3qrkKAxoE4J61I0vuJ58k4WGboCAe
         nRIo9Gi9QO/HLnt4vEUQlBitIgTSypxAocqP4sFHrjW+zomujS5R+KFM+gRO1Wb0JyAD
         +vdrTK/cLiP7iHfDX6reLJ8gGPkTX0c1F6gNsdvWkKl8yZ9XXiZ1374oTi2nc+yph8/X
         ypQsYwbGO7/Lt6nbgVhaj1sVlKRKQWk94nDXvpR+Mv1uMeC/KylMUvpQ46JvybuKjSu9
         vJwX2Eofk77Jpa2PjsOtWKUKUgaoD3p81nju8MGXHOnjvolpDOR+WfqxtDGtnhsdY3mM
         R35Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s6Xsmpm0;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s6Xsmpm0;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226TOyrbfQBHny7fh0b/CFudmJwgI4G6Yis7J0DD8ZqdTJ6m+Fp1EySjE1oR9/wGWSJH1+eNeAhwv8HDf2moWos=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-10-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-10-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 00:58:58 +0100
Message-ID: <CAFkk2KTXdByA3_vad1J7U_a5qWHCLbf2qX-ZAEicGU4HeyNgNg@mail.gmail.com>
Subject: Re: [PATCH 09/14] kconfig: test: test automatic submenu creation
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778638341632?=
X-GMAIL-MSGID: =?utf-8?q?1591788636385383851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> If a symbols has dependency on the preceding symbol, the menu entry
> should become the submenu of the preceding one, and displayed with
> deeper indentation.
>
> This is done by restructuring the menu tree in menu_finalize().
> It is a bit complicated computation, so let's add a test case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  .../kconfig/tests/auto_submenu_creation/Kconfig    | 50 ++++++++++++++++++++++
>  .../tests/auto_submenu_creation/__init__.py        | 12 ++++++
>  .../tests/auto_submenu_creation/expected_stdout    | 10 +++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 scripts/kconfig/tests/auto_submenu_creation/Kconfig
>  create mode 100644 scripts/kconfig/tests/auto_submenu_creation/__init__.py
>  create mode 100644 scripts/kconfig/tests/auto_submenu_creation/expected_stdout
>
> diff --git a/scripts/kconfig/tests/auto_submenu_creation/Kconfig b/scripts/kconfig/tests/auto_submenu_creation/Kconfig
> new file mode 100644
> index 0000000..9e11502
> --- /dev/null
> +++ b/scripts/kconfig/tests/auto_submenu_creation/Kconfig
> @@ -0,0 +1,50 @@
> +config A
> +       bool "A"
> +       default y
> +
> +config A0
> +       bool "A0"
> +       depends on A
> +       default y
> +       help
> +         This depends on A, so should be a submenu of A.
> +
> +config A0_0
> +       bool "A1_0"
> +       depends on A0
> +       help
> +         Submenus are created recursively.
> +         This should be a submenu of A0.
> +
> +config A1
> +       bool "A1"
> +       depends on A
> +       default y
> +       help
> +         This should line up with A0.
> +
> +choice
> +       prompt "choice"
> +       depends on A1
> +       help
> +         Choice should become a submenu as well.
> +
> +config A1_0
> +       bool "A1_0"
> +
> +config A1_1
> +       bool "A1_1"
> +
> +endchoice
> +
> +config B
> +       bool "B"
> +       help
> +         This is independent of A.
> +
> +config C
> +       bool "C"
> +       depends on A
> +       help
> +         This depends on A, but not a consecutive item, so should not
> +         be a submenu.
> diff --git a/scripts/kconfig/tests/auto_submenu_creation/__init__.py b/scripts/kconfig/tests/auto_submenu_creation/__init__.py
> new file mode 100644
> index 0000000..dda866d
> --- /dev/null
> +++ b/scripts/kconfig/tests/auto_submenu_creation/__init__.py
> @@ -0,0 +1,12 @@
> +"""
> +Create submenu for symbols that depend on the preceding one
> +===========================================================
> +
> +If a symbols has dependency on the preceding symbol, the menu entry
> +should become the submenu of the preceding one, and displayed with
> +deeper indentation.
> +"""
> +
> +def test(conf):
> +    assert conf.oldaskconfig() == 0
> +    assert conf.stdout_contains('expected_stdout')
> diff --git a/scripts/kconfig/tests/auto_submenu_creation/expected_stdout b/scripts/kconfig/tests/auto_submenu_creation/expected_stdout
> new file mode 100644
> index 0000000..bf5236f
> --- /dev/null
> +++ b/scripts/kconfig/tests/auto_submenu_creation/expected_stdout
> @@ -0,0 +1,10 @@
> +A (A) [Y/n/?] (NEW)
> +  A0 (A0) [Y/n/?] (NEW)
> +    A1_0 (A0_0) [N/y/?] (NEW)
> +  A1 (A1) [Y/n/?] (NEW)
> +    choice
> +    > 1. A1_0 (A1_0) (NEW)
> +      2. A1_1 (A1_1) (NEW)
> +    choice[1-2?]:
> +B (B) [N/y/?] (NEW)
> +C (C) [N/y/?] (NEW)
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
