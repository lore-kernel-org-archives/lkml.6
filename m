Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeCOPCX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:02:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:27004 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeCOPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:02:21 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2FF1qQo003862
X-Nifty-SrcIP: [209.85.213.47]
X-Google-Smtp-Source: AG47ELsrTKjcdgPNrDitR3WCvcyBevHxRxy0f7s8DIsHVjUC7VcjgmKosxuqicGecLY7gaVSZbzDPeHR4DqXpXQBMh0=
MIME-Version: 1.0
In-Reply-To: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520932332-2449-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 16 Mar 2018 00:01:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQuOVZcYw0bA63s+-dF=vBHmnqd6889bMsJQozxD10C7Q@mail.gmail.com>
Message-ID: <CAK7LNAQuOVZcYw0bA63s+-dF=vBHmnqd6889bMsJQozxD10C7Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add Kconfig unit tests
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-13 18:12 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> I am applying various cleanups to Kconfig these days.
>
> However, I fear regressions.  I have been thinking of unit-tests.
>
> There are various cryptic parts in Kconfig and corner cases where
> it is difficult to notice breakage.  If unit-tests cover those,
> I will be able to apply changes more confidently.
>
> This series introduces a unit-tests.  The framework is written based
> on pytest.  Also, this is written in Python 3.  Python 2 will retire
> in 2020.  So, I believe new python tools should be written in Python 3.
>
> This is my Python 3 and pytest versions.
>
> $ python3 --version
> Python 3.5.2
> $ python3 -m pytest --version
> This is pytest version 3.4.1, imported from /home/masahiro/.local/lib/python3.5/site-packages/pytest.py
>
> How to use?
> -----------
>
> Please make sure Python3 and pytest are installed on your system.
>
> Then, run "make testconfig"
>
> The result looks like as follows:
>
> $ make testconfig
> python3 -B -m pytest ./scripts/kconfig/tests \
> -o cache_dir=/home/masahiro/workspace/bsp/linux-yamada/scripts/kconfig/tests/.cache \
>
> ================================= test session starts =================================
> platform linux -- Python 3.5.2, pytest-3.4.1, py-1.5.2, pluggy-0.6.0 -- /usr/bin/python3
> cachedir: scripts/kconfig/tests/.cache
> rootdir: /home/masahiro/workspace/bsp/linux-yamada/scripts/kconfig/tests, inifile: pytest.ini
> collected 14 items
>
> scripts/kconfig/tests/auto_submenu/__init__.py::test PASSED                     [  7%]
> scripts/kconfig/tests/choice/__init__.py::test_oldask0 PASSED                   [ 14%]
> scripts/kconfig/tests/choice/__init__.py::test_oldask1 PASSED                   [ 21%]
> scripts/kconfig/tests/choice/__init__.py::test_allyes PASSED                    [ 28%]
> scripts/kconfig/tests/choice/__init__.py::test_allmod PASSED                    [ 35%]
> scripts/kconfig/tests/choice/__init__.py::test_allno PASSED                     [ 42%]
> scripts/kconfig/tests/choice/__init__.py::test_alldef PASSED                    [ 50%]
> scripts/kconfig/tests/choice_value_with_m_dep/__init__.py::test PASSED          [ 57%]
> scripts/kconfig/tests/err_recursive_inc/__init__.py::test PASSED                [ 64%]
> scripts/kconfig/tests/inter_choice/__init__.py::test PASSED                     [ 71%]
> scripts/kconfig/tests/new_choice_with_dep/__init__.py::test PASSED              [ 78%]
> scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py::test PASSED            [ 85%]
> scripts/kconfig/tests/rand_nested_choice/__init__.py::test PASSED               [ 92%]
> scripts/kconfig/tests/warn_recursive_dep/__init__.py::test PASSED               [100%]
>
>
> Masahiro Yamada (11):
>   kbuild: add PYTHON2 and PYTHON3 variables
>   kconfig: tests: add framework for Kconfig unit testing
>   kconfig: tests: add basic choice tests
>   kconfig: tests: test automatic submenu creation
>   kconfig: tests: test if new symbols in choice are asked
>   kconfig: tests: check unneeded "is not set" with unmet dependency
>   kconfig: tests: check visibility of tristate choice values in y choice
>   kconfig: tests: test defconfig when two choices interact
>   kconfig: tests: test randconfig for choice in choice
>   kconfig: tests: test if recursive dependencies are detected
>   kconfig: tests: test if recursive inclusion is detected
>


All applied to linux-kbuild/kconfig.



-- 
Best Regards
Masahiro Yamada
