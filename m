Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeDCQkW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:40:22 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33347 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeDCQkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:40:20 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w33Ge2Px024196
X-Nifty-SrcIP: [209.85.217.177]
X-Google-Smtp-Source: AIpwx4/3otyoDSVS/wqGU43ueJrQqv2x917U63Yn/2F6m6u0Tq0si1meyXNOhZ/4gOR3w2+6aYexTH1tn15KMa3J1KY=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Apr 2018 01:39:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJ_eUVzzy9RzDn2uN3bNJLvw03fy8AQdmNo7eEo5ZVpw@mail.gmail.com>
Message-ID: <CAK7LNAQJ_eUVzzy9RzDn2uN3bNJLvw03fy8AQdmNo7eEo5ZVpw@mail.gmail.com>
Subject: [GIT PULL 2/2] Kconfig updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kconfig updates for 4.17.



The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kconfig-v4.17

for you to fetch changes up to 18492685e479fd4d8e1dca836f57c11b6800f083:

  kconfig: use yylineno option instead of manual lineno increments
(2018-03-26 02:04:07 +0900)

----------------------------------------------------------------
Kconfig updates for v4.17

- improve checkpatch for more precise Kconfig code checking

- clarify effective selects by grouping reverse dependencies in help

- do not write out '# CONFIG_FOO is not set' from invisible symbols

- make oldconfig as silent as it should be

- rename 'silentoldconfig' to 'syncconfig'

- add unit-test framework and several test cases

- warn unmet dependency of tristate symbols

- make unmet dependency warnings readable, removing false positives

- improve recursive include detection

- use yylineno to simplify the line number tracking

- misc cleanups

----------------------------------------------------------------
Eugeniu Rosca (1):
      kconfig: Print reverse dependencies in groups

Masahiro Yamada (24):
      kconfig: clean-up reverse dependency help implementation
      kconfig: do not call check_conf() for olddefconfig
      kconfig: remove unneeded input_mode test in conf()
      kconfig: remove redundant input_mode test for check_conf() loop
      kconfig: hide irrelevant sub-menus for oldconfig
      kconfig: invoke oldconfig instead of silentoldconfig from local*config
      kconfig: rename silentoldconfig to syncconfig
      kbuild: add PYTHON2 and PYTHON3 variables
      kconfig: tests: add framework for Kconfig unit testing
      kconfig: tests: add basic choice tests
      kconfig: tests: test automatic submenu creation
      kconfig: tests: test if new symbols in choice are asked
      kconfig: tests: check unneeded "is not set" with unmet dependency
      kconfig: tests: check visibility of tristate choice values in y choice
      kconfig: tests: test defconfig when two choices interact
      kconfig: tests: test randconfig for choice in choice
      kconfig: tests: test if recursive dependencies are detected
      kconfig: tests: test if recursive inclusion is detected
      kconfig: warn unmet direct dependency of tristate symbols selected by y
      kconfig: make unmet dependency warnings readable
      kconfig: do not include both curses.h and ncurses.h for nconfig
      kconfig: remove duplicated file name and lineno of recursive inclusion
      kconfig: detect recursive inclusion earlier
      kconfig: use yylineno option instead of manual lineno increments

Ulf Magnusson (5):
      checkpatch: kconfig: recognize more prompts when checking help texts
      checkpatch: kconfig: check help texts for menuconfig and choice
      checkpatch: kconfig: prefer 'help' over '---help---'
      kconfig: only write '# CONFIG_FOO is not set' for visible symbols
      kconfig: remove redundant streamline_config.pl prerequisite

 Documentation/kbuild/kconfig.txt                       |   2 +-
 Documentation/networking/i40e.txt                      |   2 +-
 Makefile                                               |   6 +-
 scripts/checkpatch.pl                                  |  21 +-
 scripts/kconfig/Makefile                               |  29 ++-
 scripts/kconfig/conf.c                                 |  41 ++--
 scripts/kconfig/expr.c                                 |  86 +++----
 scripts/kconfig/expr.h                                 |   4 +-
 scripts/kconfig/lkc.h                                  |   1 +
 scripts/kconfig/menu.c                                 |  12 +-
 scripts/kconfig/nconf.h                                |   4 +-
 scripts/kconfig/symbol.c                               |  40 ++--
 scripts/kconfig/tests/auto_submenu/Kconfig             |  50 ++++
 scripts/kconfig/tests/auto_submenu/__init__.py         |  12 +
 scripts/kconfig/tests/auto_submenu/expected_stdout     |  10 +
 scripts/kconfig/tests/choice/Kconfig                   |  54 +++++
 scripts/kconfig/tests/choice/__init__.py               |  40 ++++
 scripts/kconfig/tests/choice/alldef_expected_config    |   5 +
 scripts/kconfig/tests/choice/allmod_expected_config    |   9 +
 scripts/kconfig/tests/choice/allno_expected_config     |   5 +
 scripts/kconfig/tests/choice/allyes_expected_config    |   9 +
 scripts/kconfig/tests/choice/oldask0_expected_stdout   |  10 +
 scripts/kconfig/tests/choice/oldask1_config            |   2 +
 scripts/kconfig/tests/choice/oldask1_expected_stdout   |  15 ++
 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig  |  19 ++
 .../kconfig/tests/choice_value_with_m_dep/__init__.py  |  15 ++
 scripts/kconfig/tests/choice_value_with_m_dep/config   |   2 +
 .../tests/choice_value_with_m_dep/expected_config      |   3 +
 .../tests/choice_value_with_m_dep/expected_stdout      |   4 +
 scripts/kconfig/tests/conftest.py                      | 291
+++++++++++++++++++++++
 scripts/kconfig/tests/err_recursive_inc/Kconfig        |   1 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc1   |   4 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc2   |   3 +
 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc3   |   1 +
 scripts/kconfig/tests/err_recursive_inc/__init__.py    |  10 +
 .../kconfig/tests/err_recursive_inc/expected_stderr    |   6 +
 scripts/kconfig/tests/inter_choice/Kconfig             |  23 ++
 scripts/kconfig/tests/inter_choice/__init__.py         |  14 ++
 scripts/kconfig/tests/inter_choice/defconfig           |   1 +
 scripts/kconfig/tests/inter_choice/expected_config     |   4 +
 scripts/kconfig/tests/new_choice_with_dep/Kconfig      |  37 +++
 scripts/kconfig/tests/new_choice_with_dep/__init__.py  |  14 ++
 scripts/kconfig/tests/new_choice_with_dep/config       |   3 +
 .../kconfig/tests/new_choice_with_dep/expected_stdout  |  10 +
 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig    |  14 ++
 .../kconfig/tests/no_write_if_dep_unmet/__init__.py    |  19 ++
 scripts/kconfig/tests/no_write_if_dep_unmet/config     |   1 +
 .../tests/no_write_if_dep_unmet/expected_config        |   5 +
 scripts/kconfig/tests/pytest.ini                       |   7 +
 scripts/kconfig/tests/rand_nested_choice/Kconfig       |  33 +++
 scripts/kconfig/tests/rand_nested_choice/__init__.py   |  16 ++
 .../kconfig/tests/rand_nested_choice/expected_stdout0  |   2 +
 .../kconfig/tests/rand_nested_choice/expected_stdout1  |   4 +
 .../kconfig/tests/rand_nested_choice/expected_stdout2  |   5 +
 scripts/kconfig/tests/warn_recursive_dep/Kconfig       |  62 +++++
 scripts/kconfig/tests/warn_recursive_dep/__init__.py   |   9 +
 .../kconfig/tests/warn_recursive_dep/expected_stderr   |  30 +++
 scripts/kconfig/zconf.l                                |  41 ++--
 58 files changed, 1043 insertions(+), 139 deletions(-)
 create mode 100644 scripts/kconfig/tests/auto_submenu/Kconfig
 create mode 100644 scripts/kconfig/tests/auto_submenu/__init__.py
 create mode 100644 scripts/kconfig/tests/auto_submenu/expected_stdout
 create mode 100644 scripts/kconfig/tests/choice/Kconfig
 create mode 100644 scripts/kconfig/tests/choice/__init__.py
 create mode 100644 scripts/kconfig/tests/choice/alldef_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allmod_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allno_expected_config
 create mode 100644 scripts/kconfig/tests/choice/allyes_expected_config
 create mode 100644 scripts/kconfig/tests/choice/oldask0_expected_stdout
 create mode 100644 scripts/kconfig/tests/choice/oldask1_config
 create mode 100644 scripts/kconfig/tests/choice/oldask1_expected_stdout
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/choice_value_with_m_dep/config
 create mode 100644
scripts/kconfig/tests/choice_value_with_m_dep/expected_config
 create mode 100644
scripts/kconfig/tests/choice_value_with_m_dep/expected_stdout
 create mode 100644 scripts/kconfig/tests/conftest.py
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc1
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc2
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc3
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/__init__.py
 create mode 100644 scripts/kconfig/tests/err_recursive_inc/expected_stderr
 create mode 100644 scripts/kconfig/tests/inter_choice/Kconfig
 create mode 100644 scripts/kconfig/tests/inter_choice/__init__.py
 create mode 100644 scripts/kconfig/tests/inter_choice/defconfig
 create mode 100644 scripts/kconfig/tests/inter_choice/expected_config
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/config
 create mode 100644 scripts/kconfig/tests/new_choice_with_dep/expected_stdout
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/Kconfig
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/config
 create mode 100644 scripts/kconfig/tests/no_write_if_dep_unmet/expected_config
 create mode 100644 scripts/kconfig/tests/pytest.ini
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/Kconfig
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/__init__.py
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout0
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout1
 create mode 100644 scripts/kconfig/tests/rand_nested_choice/expected_stdout2
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/Kconfig
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/__init__.py
 create mode 100644 scripts/kconfig/tests/warn_recursive_dep/expected_stderr


-- 
Best Regards
Masahiro Yamada
