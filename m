Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeC1I7O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:59:14 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55104 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeC1I7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:59:10 -0400
X-Google-Smtp-Source: AIpwx4/nRp3Sd8DnV/VFmQ4Ua/OJspbDamRuT0i19FTJe1JZCgrljgAwTR5ucD+UgJTQuCplZ50hqQ==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hofsass@google.com
Subject: [PATCH 0/2] kvm: add selftests for API testing
Date: Wed, 28 Mar 2018 10:59:04 +0200
Message-Id: <20180328085906.26936-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an initial reduced version of the self tests that Google contributed,
with the harness reduced from 12000 to 6000 lines thanks to my trusty chainsaw
(model "d%").

Rather than including them in kvm-unit-tests, I chose to place these tests
into linux.git, which of course had the side effect that the code had to be
cleaned up a bit to look more like Linux.

In particular a lot of changes went into lib/sparsebit.c; I don't have
a testsuite for that so I chose to fuzz it instead.  Turns out there were
no bugs introduced by the cleanups, which actually did surprise me, but
fuzzing did find some bugs in the driver instead so I think it can be
trusted. :)

For now there are two simple tests noly.  I'm leaving out the VMX test
because nested is still not enabled by default and thus the test fails
with a default configuration.  In any case, the idea is to first change
them to use more of the kselftest infrastructure, and then add more
tests.

Paolo

Paolo Bonzini (2):
  kvm: selftests: add API testing infrastructure
  kvm: selftests: add sync_regs_test

 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/kvm/Makefile               |   39 +
 tools/testing/selftests/kvm/include/kvm_util.h     |  142 ++
 tools/testing/selftests/kvm/include/sparsebit.h    |   75 +
 tools/testing/selftests/kvm/include/test_util.h    |   45 +
 tools/testing/selftests/kvm/include/x86.h          | 1043 ++++++++++
 tools/testing/selftests/kvm/lib/assert.c           |   87 +
 tools/testing/selftests/kvm/lib/elf.c              |  197 ++
 tools/testing/selftests/kvm/lib/io.c               |  158 ++
 tools/testing/selftests/kvm/lib/kvm_util.c         | 1480 ++++++++++++++
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |   67 +
 tools/testing/selftests/kvm/lib/sparsebit.c        | 2087 ++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86.c              |  700 +++++++
 tools/testing/selftests/kvm/set_sregs_test.c       |   57 +
 tools/testing/selftests/kvm/sync_regs_test.c       |  235 +++
 15 files changed, 6413 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/Makefile
 create mode 100644 tools/testing/selftests/kvm/include/kvm_util.h
 create mode 100644 tools/testing/selftests/kvm/include/sparsebit.h
 create mode 100644 tools/testing/selftests/kvm/include/test_util.h
 create mode 100644 tools/testing/selftests/kvm/include/x86.h
 create mode 100644 tools/testing/selftests/kvm/lib/assert.c
 create mode 100644 tools/testing/selftests/kvm/lib/elf.c
 create mode 100644 tools/testing/selftests/kvm/lib/io.c
 create mode 100644 tools/testing/selftests/kvm/lib/kvm_util.c
 create mode 100644 tools/testing/selftests/kvm/lib/kvm_util_internal.h
 create mode 100644 tools/testing/selftests/kvm/lib/sparsebit.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86.c
 create mode 100644 tools/testing/selftests/kvm/set_sregs_test.c
 create mode 100644 tools/testing/selftests/kvm/sync_regs_test.c

-- 
2.16.2
