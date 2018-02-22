Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227KB9c/TiFwyC3yPGsU+zswcMM8yn5HgeIkyJ+qC6Uehp5x7RJBHIN6VYNf5j0XOnX6+EL4
ARC-Seal: i=1; a=rsa-sha256; t=1519264959; cv=none;
        d=google.com; s=arc-20160816;
        b=IooibpwnZ88yH7RyPg/95cvCsaMwHbKc8x3pJSoP7ZUYq2tBdJgfqdgPYMQixlchow
         n2qIlNC+d1zPebbcqGXX7AoUG7NgZ6sUiB3wgcyTxNYrq91hex2CN2JFmUCHyXTL42s4
         9LtR4WxW2BW6mpUeqdT2QZQ6ZA3YRktFU0ATxMFnOGkk/h0g11DRBCgd0mBtkHTkg2kP
         q67M7dtJq7Qf6P1FESHer+0SLNgQx2wXYJAjr4Sv2QCirXYo8BA2UywtslMG3GXbEHjD
         AOAqTE1gBHJ6XOBWpplA6kzuuoFb9/nku2ps7cPymfBuuqyRTLm2z1u7FE+KtrcMmxVa
         IFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uOdaqE02KDvBnwisFhHKehPlYYEGpBfdpKTa7MF8pwY=;
        b=bOqyqoRiAV6I8RFy8v7kZEPAg8iOHpvJ6bDmLVj0LDiQHKV+aTOUA8lUraLG//pF24
         UKzjWs5H3gxIvnrheOoKFnzvBMlH4nJNBKoTO1GcFYnVSBcQDMr1o258mWo2/tKescH1
         6Vo9bgCA1orpSny0npTkY3Qglfae2XasfbHYV+FH5tAkrbzn/xyMUy+GT5qhfzQ2yCwc
         21b4Ca2bbmVJRiOO91zoHf2xRJihchwC/JsKQfrR0TuHFM6whi1+N5/+U2yrUeQrgKWb
         //Pup3t46q3tDxDg+tsmc/KNoSi4TgV8s6UVc0qoRJLycjZGvD0kL1SH7Yibzr/fvIzu
         r/uw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=KIoV3kOE;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=KIoV3kOE;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeBVB4Q (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:56:16 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37310 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeBVB4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:56:14 -0500
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, arnd@arndb.de
Subject: [PATCH v12 00/22] selftests, powerpc, x86 : Memory Protection Keys
Date: Wed, 21 Feb 2018 17:55:19 -0800
Message-Id: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064774462844473?=
X-GMAIL-MSGID: =?utf-8?q?1593064774462844473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Memory protection keys enables an application to protect its address space from
inadvertent access by its own code.

This feature is now enabled on powerpc architecture and integrated in
4.16-rc1.  The patches move the selftests to arch neutral directory
and enhance their test coverage. 

Test
----
Verified for correctness on powerpc
and on x86 architectures(using EC2 ubuntu VM instance).

History:
-------

version 12: 
	(1) fixed the offset of pkey field in the siginfo structure for
		x86_64 and powerpc. And tries to use the actual field
		if the headers have it defined.
version 11:
	(1) fixed a deadlock in the ptrace testcase.

version 10 and prior:
	(1) moved the testcase to arch neutral directory
	(2) split the changes into incremental patches.

Ram Pai (21):
  selftests/x86: Move protecton key selftest to arch neutral directory
  selftests/vm: rename all references to pkru to a generic name
  selftests/vm: move generic definitions to header file
  selftests/vm: typecast the pkey register
  selftests/vm: generic function to handle shadow key register
  selftests/vm: fix the wrong assert in pkey_disable_set()
  selftests/vm: fixed bugs in pkey_disable_clear()
  selftests/vm: clear the bits in shadow reg when a pkey is freed.
  selftests/vm: fix alloc_random_pkey() to make it really random
  selftests/vm: introduce two arch independent abstraction
  selftests/vm: pkey register should match shadow pkey
  selftests/vm: generic cleanup
  selftests/vm: powerpc implementation for generic abstraction
  selftests/vm: clear the bits in shadow reg when a pkey is freed.
  selftests/vm: powerpc implementation to check support for pkey
  selftests/vm: fix an assertion in test_pkey_alloc_exhaust()
  selftests/vm: associate key on a mapped page and detect access
    violation
  selftests/vm: associate key on a mapped page and detect write
    violation
  selftests/vm: detect write violation on a mapped access-denied-key
    page
  selftests/vm: testcases must restore pkey-permissions
  selftests/vm: sub-page allocator

Thiago Jung Bauermann (1):
  selftests/vm: Fix deadlock in protection_keys.c

 tools/testing/selftests/vm/Makefile           |    1 +
 tools/testing/selftests/vm/pkey-helpers.h     |  434 ++++++++
 tools/testing/selftests/vm/protection_keys.c  | 1471 +++++++++++++++++++++++++
 tools/testing/selftests/x86/Makefile          |    2 +-
 tools/testing/selftests/x86/pkey-helpers.h    |  223 ----
 tools/testing/selftests/x86/protection_keys.c | 1407 -----------------------
 6 files changed, 1907 insertions(+), 1631 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/protection_keys.c
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
 delete mode 100644 tools/testing/selftests/x86/protection_keys.c

