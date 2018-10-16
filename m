Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF2F2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxG0cA2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF2F2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeJQHro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:44 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:46335 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeJQHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:42 -0400
Received: by mail-ot1-f74.google.com with SMTP id s2so18385575ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8JQjq3jjxfWsRI34be5tLEmUCC8ErrwqnGVaEIBnglA=;
        b=JxG0cA2GwjOvv3iDVcP7ijufVw+YGRKlIvHvVhvryhtz78KrzjBQTLlTy4B2+td7HU
         bw9+S5O+sV4q03T74EQLRYZPBtqy6hBHKuScJHEvIg1gAxiPTNERo4jfr0BMavdNc6HW
         8/daEv9k1GfFI2YZSZBhDTNrCLWg2vWYKRZbrRT1oOoCqSgScPKnuY1W/uPBX48549jk
         P+OxStD42LP/ZB/OMP8YK0S2B2lyvo//+NHmusmP9GIPWvp+ZZlnpaN+tHBHbDT3OZQC
         lqWfBS2SKb12+70/q7x3kBGK3yuvqB/03PdGbXHdKY6bBMSVIAoV1FYi+vLyFXmOg5VC
         F8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8JQjq3jjxfWsRI34be5tLEmUCC8ErrwqnGVaEIBnglA=;
        b=so8LrTEtMq8ItcHazkWbvdYp7Qn39wTfvvRDS2NJDm2UGCf6aHhB/pua0oVDGeECug
         xaqN0II6HODoJcQ+6k9R4e0ZIhrLcDBMPrmeK65AB5MOXDLByY5/shsSw0WbaZmboeNI
         eieBGiOuNCDK3QbxTPp4QDdQ1yQNtpaVV5KcvfruF7t0dlBv9G+qP8d4ySpB/pSUjV5K
         S8TM87ynKDk4TLZOaZlcXQlsK5PEmeoq+AMaTReY4jjkt9g+4ObsZf/RXMbj7mmhXCbI
         //IpWJXxGQTxmtyNF+F9W349AF29Rcdq8RTqN5XhLcbJUhhsAJjACMC7OM6r09UutWgK
         Nhpg==
X-Gm-Message-State: ABuFfogNEZeVfHvzliZczPiJ9bsCCvumPtrNdsLz5Co8eWiXrpwg5Y9c
        IoDVhXews/x83wBnIsHOKtt6KE4RXou+l6cJjbnxyw==
X-Google-Smtp-Source: ACcGV62ZGWlrAKherce8lXLVzlDaHnPMCD/L2BzmINAK+Ck2DKM0kXSRftQSX1xTvkyKOT86jQFdDzHHS8HvgkXhi0JMqw==
X-Received: by 2002:aca:3110:: with SMTP id x16-v6mr20157312oix.8.1539734092276;
 Tue, 16 Oct 2018 16:54:52 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:16 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-28-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 27/31] Documentation: kunit: adds complete documentation for KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Added intro and usage guide for KUnit
- Added API reference

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/index.rst                       |   1 +
 .../kunit/api/class-and-function-mocking.rst  |  68 ++
 Documentation/kunit/api/index.rst             |  21 +
 Documentation/kunit/api/platform-mocking.rst  |  36 +
 Documentation/kunit/api/test.rst              |  15 +
 Documentation/kunit/faq.rst                   |  46 +
 Documentation/kunit/index.rst                 |  84 ++
 Documentation/kunit/start.rst                 | 185 ++++
 Documentation/kunit/usage.rst                 | 876 ++++++++++++++++++
 9 files changed, 1332 insertions(+)
 create mode 100644 Documentation/kunit/api/class-and-function-mocking.rst
 create mode 100644 Documentation/kunit/api/index.rst
 create mode 100644 Documentation/kunit/api/platform-mocking.rst
 create mode 100644 Documentation/kunit/api/test.rst
 create mode 100644 Documentation/kunit/faq.rst
 create mode 100644 Documentation/kunit/index.rst
 create mode 100644 Documentation/kunit/start.rst
 create mode 100644 Documentation/kunit/usage.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index fdc585703498e..9415b6536d04b 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -66,6 +66,7 @@ merged much easier.
    kernel-hacking/index
    trace/index
    maintainer/index
+   kunit/index
 
 Kernel API documentation
 ------------------------
diff --git a/Documentation/kunit/api/class-and-function-mocking.rst b/Documentation/kunit/api/class-and-function-mocking.rst
new file mode 100644
index 0000000000000..3e53291145f1f
--- /dev/null
+++ b/Documentation/kunit/api/class-and-function-mocking.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Class and Function Mocking
+==========================
+
+This file documents class and function mocking features.
+
+.. note::
+   If possible, prefer class mocking over arbitrary function mocking. Class
+   mocking has a much more limited scope and provides more control.
+   This file documents class mocking and most mocking features that do not
+   depend on function or platform mocking.
+
+Readability Macros
+------------------
+When defining and declaring mock stubs, use these readability macros.
+
+.. code-block:: c
+
+        #define CLASS(struct_name) struct_name
+        #define HANDLE_INDEX(index) index
+        #define METHOD(method_name) method_name
+        #define RETURNS(return_type) return_type
+        #define PARAMS(...) __VA_ARGS__
+
+Consider a ``struct Foo`` with a member function
+``int add(struct Foo*, int a, int b);``
+
+When generating a mock stub with :c:func:`DEFINE_STRUCT_CLASS_MOCK`, which
+takes a method name, struct name, return type, and method parameters, the
+arguments should be passed in with the readability macros.
+
+.. code-block:: c
+
+        DEFINE_STRUCT_CLASS_MOCK(
+                METHOD(add),
+                CLASS(Foo),
+                RETURNS(int),
+                PARAMS(struct Foo *, int, int)
+        );
+
+For a more detailed example of this, take a look at the example in
+:doc:`../start`
+
+These macros should only be used in the context of the mock stub generators.
+
+
+Built in Matchers
+-----------------
+
+.. kernel-doc:: include/kunit/mock.h
+   :doc: Built In Matchers
+
+Mock Returns
+------------
+These functions can be used to specify a value to be returned (``ret``) when a
+mocked function is intercepted via :c:func:`EXPECT_CALL`.
+
+.. code-block:: c
+
+        struct mock_action *int_return(struct test *test, int ret);
+        struct mock_action *u32_return(struct test *test, u32 ret);
+
+API
+---
+.. kernel-doc:: include/kunit/mock.h
+   :internal:
diff --git a/Documentation/kunit/api/index.rst b/Documentation/kunit/api/index.rst
new file mode 100644
index 0000000000000..a4fdc35b32c5c
--- /dev/null
+++ b/Documentation/kunit/api/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+API Reference
+=============
+.. toctree::
+
+	test
+	class-and-function-mocking
+	platform-mocking
+
+This section documents the KUnit kernel testing API. It is divided into 3
+sections:
+
+================================= ==============================================
+:doc:`test`                       documents all of the standard testing API
+                                  excluding mocking or mocking related features.
+:doc:`class-and-function-mocking` documents class and function mocking features.
+:doc:`platform-mocking`           documents mocking libraries that mock out
+                                  platform specific features.
+================================= ==============================================
diff --git a/Documentation/kunit/api/platform-mocking.rst b/Documentation/kunit/api/platform-mocking.rst
new file mode 100644
index 0000000000000..72555eb5b1de1
--- /dev/null
+++ b/Documentation/kunit/api/platform-mocking.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Platform Mocking
+================
+
+This file documents *platform mocking*, mocking libraries that mock out platform
+specific features and aid in writing mocks for platform drivers and other low
+level kernel code.
+
+Enable Platform Mocking
+-----------------------
+``CONFIG_PLATFORM_MOCK`` needs to be added to the .config (or kunitconfig) to
+enable platform mocking.
+
+Mocked IO Functions
+-------------------
+The following functions have been mocked for convenience.
+
+.. code-block:: c
+
+	u8 readb(const volatile void __iomem *);
+	u16 readw(const volatile void __iomem *);
+	u32 readl(const volatile void __iomem *);
+	u64 readq(const volatile void __iomem *);
+	void writeb(u8, const volatile void __iomem *);
+	void writew(u16, const volatile void __iomem *);
+	void writel(u32, const volatile void __iomem *);
+	void writeq(u64, const volatile void __iomem *);
+
+.. note:: These functions do not have any non-mocked behaviour in UML.
+
+API
+---
+.. kernel-doc:: include/linux/platform_device_mock.h
+   :internal:
diff --git a/Documentation/kunit/api/test.rst b/Documentation/kunit/api/test.rst
new file mode 100644
index 0000000000000..7f22db32536eb
--- /dev/null
+++ b/Documentation/kunit/api/test.rst
@@ -0,0 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+Test API
+========
+
+This file documents all of the standard testing API excluding mocking or mocking
+related features.
+
+.. kernel-doc:: include/kunit/test.h
+   :internal:
+
+.. kernel-doc:: include/kunit/test-stream.h
+   :internal:
+
diff --git a/Documentation/kunit/faq.rst b/Documentation/kunit/faq.rst
new file mode 100644
index 0000000000000..fce128d804b49
--- /dev/null
+++ b/Documentation/kunit/faq.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Frequently Asked Questions
+=========================================
+
+How is this different from Autotest, kselftest, etc?
+====================================================
+KUnit is a unit testing framework. Autotest, kselftest (and some others) are
+not.
+
+A `unit test <http://softwaretestingfundamentals.com/unit-testing/>`_ is
+supposed to test a single unit of code in isolation, hence the name. A unit
+test should be the finest granularity of testing and as such should allow all
+possible code paths to be tested in the code under test; this is only possible
+if the code under test is very small and does not have any external
+dependencies outside of the test's control like hardware.
+
+There are no testing frameworks currently available for the kernel that do not
+require installing the kernel on a test machine or in a VM and all require
+tests to be written in userspace and run on the kernel under test; this is true
+for Autotest, kselftest, and some others, disqualifying any of them from being
+considered unit testing frameworks.
+
+What is the difference between a unit test and these other kinds of tests?
+==========================================================================
+Most existing tests for the Linux kernel would be categorized as an integration
+test, or an end-to-end test.
+
+- A unit test is supposed to test a single unit of code in isolation, hence the
+  name. A unit test should be the finest granularity of testing and as such
+  should allow all possible code paths to be tested in the code under test; this
+  is only possible if the code under test is very small and does not have any
+  external dependencies outside of the test's control like hardware.
+- An integration test tests the interaction between a minimal set of components,
+  usually just two or three. For example, someone might write an integration
+  test to test the interaction between a driver and a piece of hardware, or to
+  test the interaction between the userspace libraries the kernel provides and
+  the kernel itself; however, one of these tests would probably not test the
+  entire kernel along with hardware interactions and interactions with the
+  userspace.
+- An end-to-end test usually tests the entire system from the perspective of the
+  code under test. For example, someone might write an end-to-end test for the
+  kernel by installing a production configuration of the kernel on production
+  hardware with a production userspace and then trying to exercise some behavior
+  that depends on interactions between the hardware, the kernel, and userspace.
diff --git a/Documentation/kunit/index.rst b/Documentation/kunit/index.rst
new file mode 100644
index 0000000000000..fc2716f155d74
--- /dev/null
+++ b/Documentation/kunit/index.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+KUnit - Unit Testing for the Linux Kernel
+=========================================
+
+.. toctree::
+	:maxdepth: 2
+
+	start
+	usage
+	api/index
+	faq
+
+What is KUnit?
+==============
+
+KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
+These tests are able to be run locally on a developer's workstation without a VM
+or special hardware.
+
+KUnit is heavily inspired by JUnit, Python's ``unittest.mock``, and
+Googletest/Googlemock for C++. They have the same structure for defining test
+suites and test cases. KUnit defines a way to mock out C style classes and
+functions and create expectations on methods called within the code under test.
+
+Get started now: :doc:`start`
+
+Why KUnit?
+==========
+
+Aside from KUnit there is no true unit testing framework for the Linux kernel.
+Autotest and kselftest are sometimes cited as unit testing frameworks; however,
+they are not by most reasonable definitions of unit tests.
+
+A unit test is supposed to test a single unit of code in isolation, hence the
+name. A unit test should be the finest granularity of testing and as such should
+allow all possible code paths to be tested in the code under test; this is only
+possible if the code under test is very small and does not have any external
+dependencies outside of the test's control like hardware.
+
+Outside of KUnit, there are no testing frameworks currently
+available for the kernel that do not require installing the kernel on a test
+machine or in a VM and all require tests to be written in userspace running on
+the kernel; this is true for Autotest, and kselftest, disqualifying
+any of them from being considered unit testing frameworks.
+
+KUnit addresses the problem of being able to run tests without needing a virtual
+machine or actual hardware with User Mode Linux. User Mode Linux is a Linux
+architecture, like ARM or x86; however, unlike other architectures it compiles
+to a standalone program that can be run like any other program directly inside
+of a host operating system; to be clear, it does not require any virtualization
+support; it is just a regular program.
+
+KUnit is fast. Excluding build time, from invocation to completion KUnit can run
+several dozen tests in only 10 to 20 seconds; this might not sound like a big
+deal to some people, but having such fast and easy to run tests fundamentally
+changes the way you go about testing and even writing code in the first place.
+Linus himself said in his `git talk at Google
+<https://gist.github.com/lorn/1272686/revisions#diff-53c65572127855f1b003db4064a94573R874>`_:
+
+	"... a lot of people seem to think that performance is about doing the
+	same thing, just doing it faster, and that is not true. That is not what
+	performance is all about. If you can do something really fast, really
+	well, people will start using it differently."
+
+In this context Linus was talking about branching and merging,
+but this point also applies to testing. If your tests are slow, unreliable, are
+difficult to write, and require a special setup or special hardware to run,
+then you wait a lot longer to write tests, and you wait a lot longer to run
+tests; this means that tests are likely to break, unlikely to test a lot of
+things, and are unlikely to be rerun once they pass. If your tests are really
+fast, you run them all the time, every time you make a change, and every time
+someone sends you some code. Why trust that someone ran all their tests
+correctly on every change when you can just run them yourself in less time than
+it takes to read his / her test log?
+
+How do I use it?
+===================
+
+*   :doc:`start` - for new users of KUnit
+*   :doc:`usage` - for a more detailed explanation of KUnit features
+*   :doc:`api/index` - for the list of KUnit APIs used for testing
+
diff --git a/Documentation/kunit/start.rst b/Documentation/kunit/start.rst
new file mode 100644
index 0000000000000..14d1e4bd02f58
--- /dev/null
+++ b/Documentation/kunit/start.rst
@@ -0,0 +1,185 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Getting Started
+===============
+
+Installing dependencies
+=======================
+KUnit has the same dependencies as the Linux kernel. As long as you can build
+the kernel, you can run KUnit.
+
+KUnit Wrapper
+=============
+Included with KUnit is a simple Python wrapper that helps format the output to
+easily use and read KUnit output. It handles building and running the kernel, as
+well as formatting the output.
+
+The wrapper can be run with:
+
+.. code-block:: bash
+
+   ./tools/testing/kunit/kunit.py
+
+Creating a kunitconfig
+======================
+The Python script is a thin wrapper around Kbuild as such, it needs to be
+configured with a ``kunitconfig`` file. This file essentially contains the
+regular Kernel config, with the specific test targets as well.
+
+.. code-block:: bash
+
+	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
+	cd $PATH_TO_LINUX_REPO
+	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
+
+You may want to add kunitconfig to your local gitignore.
+
+Verifying KUnit Works
+-------------------------
+
+To make sure that everything is set up correctly, simply invoke the Python
+wrapper from your kernel repo:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py
+
+.. note::
+   You may want to run ``make mrproper`` first.
+
+If everything worked correctly, you should see the following:
+
+.. code-block:: bash
+
+	Generating .config ...
+	Building KUnit Kernel ...
+	Starting KUnit Kernel ...
+
+followed by a list of tests that are run. All of them should be passing.
+
+.. note::
+   Because it is building a lot of sources for the first time, the ``Building
+   kunit kernel`` step may take a while.
+
+Writing your first test
+==========================
+
+In your kernel repo let's add some code that we can test. Create a file
+``drivers/misc/example.h`` with the contents:
+
+.. code-block:: c
+
+	int misc_example_add(int left, int right);
+
+create a file ``drivers/misc/example.c``:
+
+.. code-block:: c
+
+	#include <linux/errno.h>
+
+	#include "example.h"
+
+	int misc_example_add(int left, int right)
+	{
+		return left + right;
+	}
+
+Now add the following lines to ``drivers/misc/Kconfig``:
+
+.. code-block:: kconfig
+
+	config MISC_EXAMPLE
+		bool "My example"
+
+and the following lines to ``drivers/misc/Makefile``:
+
+.. code-block:: make
+
+	obj-$(CONFIG_MISC_EXAMPLE) += example.o
+
+Now we are ready to write the test. The test will be in
+``drivers/misc/example-test.c``:
+
+.. code-block:: c
+
+	#include <linux/test.h>
+	#include <linux/mock.h>
+	#include "example.h"
+
+	/* Define the test cases. */
+
+	static void misc_example_add_test_basic(struct test *test)
+	{
+		TEST_EXPECT_EQ(test, 1, misc_example_add(1, 0));
+		TEST_EXPECT_EQ(test, 2, misc_example_add(1, 1));
+		TEST_EXPECT_EQ(test, 0, misc_example_add(-1, 1));
+		TEST_EXPECT_EQ(test, INT_MAX, misc_example_add(0, INT_MAX));
+		TEST_EXPECT_EQ(test, -1, misc_example_add(INT_MAX, INT_MIN));
+	}
+
+	static void misc_example_test_failure(struct test *test)
+	{
+		TEST_FAIL(test, "This test never passes.");
+	}
+
+	static struct test_case misc_example_test_cases[] = {
+		TEST_CASE(misc_example_add_test_basic),
+		TEST_CASE(misc_example_test_failure),
+		{},
+	};
+
+	static struct test_module misc_example_test_module = {
+		.name = "misc-example",
+		.test_cases = misc_example_test_cases,
+	};
+	module_test(misc_example_test_module);
+
+Now add the following to ``drivers/misc/Kconfig``:
+
+.. code-block:: kconfig
+
+	config MISC_EXAMPLE_TEST
+		bool "Test for my example"
+		depends on MISC_EXAMPLE && TEST
+
+and the following to ``drivers/misc/Makefile``:
+
+.. code-block:: make
+
+	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
+
+Now add it to your ``kunitconfig``:
+
+.. code-block:: none
+
+	CONFIG_MISC_EXAMPLE=y
+	CONFIG_MISC_EXAMPLE_TEST=y
+
+Now you can run the test:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py
+
+You should see the following failure:
+
+.. TODO(brendanhiggins@google.com): update me!!!
+
+.. code-block:: none
+
+	...
+	kunit misc-example: misc_example_bar_test_success passed
+	kunit misc-example: EXPECTATION FAILED at drivers/misc/example-test.c:48
+		Expected -22 == misc_example_bar(example), but
+			-22 == -22
+			misc_example_bar(example) == -5
+	kunit misc-example: misc_example_bar_test_failure failed
+	kunit misc-example: one or more tests failed
+
+Congrats! You just wrote your first KUnit test!
+
+Next Steps
+=============
+*   Check out the :doc:`usage` page for a more
+    in-depth explanation of KUnit.
diff --git a/Documentation/kunit/usage.rst b/Documentation/kunit/usage.rst
new file mode 100644
index 0000000000000..605bc4d1165a7
--- /dev/null
+++ b/Documentation/kunit/usage.rst
@@ -0,0 +1,876 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Using KUnit
+=============
+
+The purpose of this document is to describe what KUnit is, how it works, how it
+is intended to be used, and all the concepts and terminology that are needed to
+understand it. This guide assumes a working knowledge of the Linux kernel and
+some basic knowledge of testing.
+
+For a high level introduction to KUnit, including setting up KUnit for your
+project, see :doc:`start`.
+
+Organization of this document
+=================================
+
+This document is organized into two main sections: Testing and Isolating
+Behavior. The first covers what a unit test is and how to use KUnit to write
+them. The second covers how to use KUnit to isolate code and make it possible
+to unit test code that was otherwise un-unit-testable.
+
+Testing
+==========
+
+What is KUnit?
+------------------
+
+"K" is short for "kernel" so "KUnit" is the "(Linux) Kernel Unit Testing
+Framework." KUnit is intended first and foremost for writing unit tests; it is
+general enough that it can be used to write integration tests; however, this is
+a secondary goal. KUnit has no ambition of being the only testing framework for
+the kernel; for example, it does not intend to be an end-to-end testing
+framework.
+
+What is Unit Testing?
+-------------------------
+
+A `unit test <http://softwaretestingfundamentals.com/unit-testing/>`_ is a test
+that tests code at the smallest possible scope, a *unit* of code. In the C
+programming language that's a function.
+
+Unit tests should be written for all the publicly exposed functions in a
+compilation unit; so that is all the functions that are exported in either a
+*class* (defined below) or all functions which are **not** static.
+
+Writing Tests
+-------------
+
+Test Cases
+~~~~~~~~~~
+
+The fundamental unit in KUnit is the test case. A test case is a function with
+the signature ``void (*)(struct test *test)``. It calls a function to be tested
+and then sets *expectations* for what should happen. For example:
+
+.. code-block:: c
+
+	void example_test_success(struct test *test)
+	{
+	}
+
+	void example_test_failure(struct test *test)
+	{
+		TEST_FAIL(test, "This test never passes.");
+	}
+
+In the above example ``example_test_success`` always passes because it does
+nothing; no expectations are set, so all expectations pass. On the other hand
+``example_test_failure`` always fails because it calls ``TEST_FAIL``, which is a
+special expectation that logs a message and causes the test case to fail.
+
+Expectations
+~~~~~~~~~~~~
+An *expectation* is a way to specify that you expect a piece of code to do
+something in a test. An expectation is called like a function. A test is made
+by setting expectations about the behavior of a piece of code under test; when
+one or more of the expectations fail, the test case fails and information about
+the failure is logged. For example:
+
+.. code-block:: c
+
+	void add_test_basic(struct test *test)
+	{
+		TEST_EXPECT_EQ(test, 1, add(1, 0));
+		TEST_EXPECT_EQ(test, 2, add(1, 1));
+	}
+
+In the above example ``add_test_basic`` makes a number of assertions about the
+behavior of a function called ``add``; the first parameter is always of type
+``struct test *``, which contains information about the current test context;
+the second parameter, in this case, is what the value is expected to be; the
+last value is what the value actually is. If ``add`` passes all of these
+expectations, the test case, ``add_test_basic`` will pass; if any one of these
+expectations fail, the test case will fail.
+
+It is important to understand that a test case *fails* when any expectation is
+violated; however, the test will continue running, potentially trying other
+expectations until the test case ends or is otherwise terminated. This is as
+opposed to *assertions* which are discussed later.
+
+To learn about more expectations supported by KUnit, see :doc:`api/test`.
+
+.. note::
+   A single test case should be pretty short, pretty easy to understand,
+   focused on a single behavior.
+
+For example, if we wanted to properly test the add function above, we would
+create additional tests cases which would each test a different property that an
+add function should have like this:
+
+.. code-block:: c
+
+	void add_test_basic(struct test *test)
+	{
+		TEST_EXPECT_EQ(test, 1, add(1, 0));
+		TEST_EXPECT_EQ(test, 2, add(1, 1));
+	}
+
+	void add_test_negative(struct test *test)
+	{
+		TEST_EXPECT_EQ(test, 0, add(-1, 1));
+	}
+
+	void add_test_max(struct test *test)
+	{
+		TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+		TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+	}
+
+	void add_test_overflow(struct test *test)
+	{
+		TEST_EXPECT_EQ(test, INT_MIN, add(INT_MAX, 1));
+	}
+
+Notice how it is immediately obvious what all the properties that we are testing
+for are.
+
+Assertions
+~~~~~~~~~~
+
+KUnit also has the concept of an *assertion*. An assertion is just like an
+expectation except the assertion immediately terminates the test case if it is
+not satisfied.
+
+For example:
+
+.. code-block:: c
+
+	static void mock_test_do_expect_default_return(struct test *test)
+	{
+		struct mock_test_context *ctx = test->priv;
+		struct mock *mock = ctx->mock;
+		int param0 = 5, param1 = -5;
+		const char *two_param_types[] = {"int", "int"};
+		const void *two_params[] = {&param0, &param1};
+		const void *ret;
+
+		ret = mock->do_expect(mock,
+				      "test_printk", test_printk,
+				      two_param_types, two_params,
+				      ARRAY_SIZE(two_params));
+		TEST_ASSERT_NOT_ERR_OR_NULL(test, ret);
+		TEST_EXPECT_EQ(test, -4, *((int *) ret));
+	}
+
+In this example, the method under test should return a pointer to a value, so
+if the pointer returned by the method is null or an errno, we don't want to
+bother continuing the test since the following expectation could crash the test
+case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if
+the appropriate conditions have not been satisfied to complete the test.
+
+Modules / Test Suites
+~~~~~~~~~~~~~~~~~~~~~
+
+Now obviously one unit test isn't very helpful; the power comes from having
+many test cases covering all of your behaviors. Consequently it is common to
+have many *similar* tests; in order to reduce duplication in these closely
+related tests most unit testing frameworks provide the concept of a *test
+suite*, in KUnit we call it a *test module*; all it is is just a collection of
+test cases for a unit of code with a set up function that gets invoked before
+every test cases and then a tear down function that gets invoked after every
+test case completes.
+
+Example:
+
+.. code-block:: c
+
+	static struct test_case example_test_cases[] = {
+		TEST_CASE(example_test_foo),
+		TEST_CASE(example_test_bar),
+		TEST_CASE(example_test_baz),
+		{},
+	};
+
+	static struct test_module example_test_module[] = {
+		.name = "example",
+		.init = example_test_init,
+		.exit = example_test_exit,
+		.test_cases = example_test_cases,
+	};
+	module_test(example_test_module);
+
+In the above example the test suite, ``example_test_module``, would run the test
+cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``, each
+would have ``example_test_init`` called immediately before it and would have
+``example_test_exit`` called immediately after it.
+``module_test(example_test_module)`` registers the test suite with the KUnit
+test framework.
+
+.. note::
+   A test case will only be run if it is associated with a test suite.
+
+For a more information on these types of things see the :doc:`api/test`.
+
+Isolating Behavior
+==================
+
+The most important aspect of unit testing that other forms of testing do not
+provide is the ability to limit the amount of code under test to a single unit.
+In practice, this is only possible by being able to control what code gets run
+when the unit under test calls a function and this is usually accomplished
+through some sort of indirection where a function is exposed as part of an API
+such that the definition of that function can be changed without affecting the
+rest of the code base. In the kernel this primarily comes from two constructs,
+classes, structs that contain function pointers that are provided by the
+implementer, and architecture specific functions which have definitions selected
+at compile time.
+
+Classes
+-------
+
+Classes are not a construct that is built into the C programming language;
+however, it is an easily derived concept. Accordingly, pretty much every project
+that does not use a standardized object oriented library (like GNOME's GObject)
+has their own slightly different way of doing object oriented programming; the
+Linux kernel is no exception.
+
+The central concept in kernel object oriented programming is the class. In the
+kernel, a *class* is a struct that contains function pointers. This creates a
+contract between *implementers* and *users* since it forces them to use the
+same function signature without having to call the function directly. In order
+for it to truly be a class, the function pointers must specify that a pointer
+to the class, known as a *class handle*, be one of the parameters; this makes
+it possible for the member functions (also known as *methods*) to have access
+to member variables (more commonly known as *fields*) allowing the same
+implementation to have multiple *instances*.
+
+Typically a class can be *overridden* by *child classes* by embedding the
+*parent class* in the child class. Then when a method provided by the child
+class is called, the child implementation knows that the pointer passed to it is
+of a parent contained within the child; because of this, the child can compute
+the pointer to itself because the pointer to the parent is always a fixed offset
+from the pointer to the child; this offset is the offset of the parent contained
+in the child struct. For example:
+
+.. code-block:: c
+
+	struct shape {
+		int (*area)(struct shape *this);
+	};
+
+	struct rectangle {
+		struct shape parent;
+		int length;
+		int width;
+	};
+
+	int rectangle_area(struct shape *this)
+	{
+		struct rectangle *self = container_of(this, struct shape, parent);
+
+		return self->length * self->width;
+	};
+
+	void rectangle_new(struct rectangle *self, int length, int width)
+	{
+		self->parent.area = rectangle_area;
+		self->length = length;
+		self->width = width;
+	}
+
+In this example (as in most kernel code) the operation of computing the pointer
+to the child from the pointer to the parent is done by ``container_of``.
+
+Faking Classes
+~~~~~~~~~~~~~~
+
+In order to unit test a piece of code that calls a method in a class, the
+behavior of the method must be controllable, otherwise the test ceases to be a
+unit test and becomes an integration test.
+
+A fake just provides an implementation of a piece of code that is different than
+what runs in a production instance, but behaves identically from the standpoint
+of the callers; this is usually done to replace a dependency that is hard to
+deal with, or is slow.
+
+A good example for this might be implementing a fake EEPROM that just stores the
+"contents" in an internal buffer. For example, let's assume we have a class that
+represents an EEPROM:
+
+.. code-block:: c
+
+	struct eeprom {
+		ssize_t (*read)(struct eeprom *this, size_t offset, char *buffer, size_t count);
+		ssize_t (*write)(struct eeprom *this, size_t offset, const char *buffer, size_t count);
+	};
+
+And we want to test some code that buffers writes to the EEPROM:
+
+.. code-block:: c
+
+	struct eeprom_buffer {
+		ssize_t (*write)(struct eeprom_buffer *this, const char *buffer, size_t count);
+		int flush(struct eeprom_buffer *this);
+		size_t flush_count; /* Flushes when buffer exceeds flush_count. */
+	};
+
+	struct eeprom_buffer *new_eeprom_buffer(struct eeprom *eeprom);
+	void destroy_eeprom_buffer(struct eeprom *eeprom);
+
+We can easily test this code by *faking out* the underlying EEPROM:
+
+.. code-block:: c
+
+	struct fake_eeprom {
+		struct eeprom parent;
+		char contents[FAKE_EEPROM_CONTENTS_SIZE];
+	};
+
+	ssize_t fake_eeprom_read(struct eeprom *parent, size_t offset, char *buffer, size_t count)
+	{
+		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
+
+		count = min(count, FAKE_EEPROM_CONTENTS_SIZE - offset);
+		memcpy(buffer, this->contents + offset, count);
+
+		return count;
+	}
+
+	ssize_t fake_eeprom_write(struct eeprom *this, size_t offset, const char *buffer, size_t count)
+	{
+		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
+
+		count = min(count, FAKE_EEPROM_CONTENTS_SIZE - offset);
+		memcpy(this->contents + offset, buffer, count);
+
+		return count;
+	}
+
+	void fake_eeprom_init(struct fake_eeprom *this)
+	{
+		this->parent.read = fake_eeprom_read;
+		this->parent.write = fake_eeprom_write;
+		memset(this->contents, 0, FAKE_EEPROM_CONTENTS_SIZE);
+	}
+
+We can now use it to test ``struct eeprom_buffer``:
+
+.. code-block:: c
+
+	struct eeprom_buffer_test {
+		struct fake_eeprom *fake_eeprom;
+		struct eeprom_buffer *eeprom_buffer;
+	};
+
+	static void eeprom_buffer_test_does_not_write_until_flush(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff};
+
+		eeprom_buffer->flush_count = SIZE_MAX;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[1], 0);
+
+		eeprom_buffer->flush(eeprom_buffer);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+	}
+
+	static void eeprom_buffer_test_flushes_after_flush_count_met(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff};
+
+		eeprom_buffer->flush_count = 2;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+	}
+
+	static void eeprom_buffer_test_flushes_increments_of_flush_count(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff, 0xff};
+
+		eeprom_buffer->flush_count = 2;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 2);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+		/* Should have only flushed the first two bytes. */
+		TEST_EXPECT_EQ(test, fake_eeprom->contents[2], 0);
+	}
+
+	static int eeprom_buffer_test_init(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx;
+
+		ctx = test_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+		ctx->fake_eeprom = test_kzalloc(test, sizeof(*ctx->fake_eeprom), GFP_KERNEL);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx->fake_eeprom);
+
+		ctx->eeprom_buffer = new_eeprom_buffer(&ctx->fake_eeprom->parent);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx->eeprom_buffer);
+
+		test->priv = ctx;
+
+		return 0;
+	}
+
+	static void eeprom_buffer_test_exit(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+
+		destroy_eeprom_buffer(ctx->eeprom_buffer);
+	}
+
+Mocking Classes
+~~~~~~~~~~~~~~~
+
+Sometimes the easiest way to make assertions about behavior is to verify
+certain methods or functions were called with appropriate arguments. KUnit
+allows classes to be *mocked* which means that it generates subclasses whose
+behavior can be specified in a test case. KUnit accomplishes this with two sets
+of macros: the mock generation macros and the ``TEST_EXPECT_CALL`` macro.
+
+For example, let's go back to the EEPROM example; instead of faking the EEPROM,
+we could have *mocked it out* with the following code:
+
+.. code-block:: c
+
+	DECLARE_STRUCT_CLASS_MOCK_PREREQS(eeprom);
+
+	DEFINE_STRUCT_CLASS_MOCK(METHOD(read), CLASS(eeprom),
+				 RETURNS(ssize_t),
+				 PARAMS(struct eeprom *, size_t, char *, size_t));
+
+	DEFINE_STRUCT_CLASS_MOCK(METHOD(write), CLASS(eeprom),
+				 RETURNS(ssize_t),
+				 PARAMS(struct eeprom *, size_t, const char *, size_t));
+
+	static int eeprom_init(struct MOCK(eeprom) *mock_eeprom)
+	{
+		struct eeprom *eeprom = mock_get_trgt(mock_eeprom);
+
+		eeprom->read = read;
+		eeprom->write = write;
+
+		return 0;
+	}
+
+	DEFINE_STRUCT_CLASS_MOCK_INIT(eeprom, eeprom);
+
+We could use the mock in a test as follows:
+
+.. code-block:: c
+
+	struct eeprom_buffer_test {
+		struct MOCK(eeprom) *mock_eeprom;
+		struct eeprom_buffer *eeprom_buffer;
+	};
+
+	static void eeprom_buffer_test_does_not_write_until_flush(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct MOCK(eeprom) *mock_eeprom = ctx->mock_eeprom;
+		struct mock_expectation *expectation;
+		char buffer[] = {0xff, 0xff};
+
+		eeprom_buffer->flush_count = SIZE_MAX;
+
+		expectation = TEST_EXPECT_CALL(write(mock_get_ctrl(mock_eeprom),
+						     test_any(test),
+						     test_any(test),
+						     test_any(test)));
+		expectation->max_calls_expected = 0;
+		expectation->min_calls_expected = 0;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+
+		mock_validate_expectations(mock_get_ctrl(mock_eeprom));
+
+		expectation = TEST_EXPECT_CALL(write(mock_get_ctrl(mock_eeprom),
+						     test_any(test),
+						     test_memeq(test,
+								buffer,
+								ARRAY_SIZE(buffer)),
+						     test_ulong_eq(test, 2)));
+		expectation->max_calls_expected = 1;
+		expectation->min_calls_expected = 1;
+		expectation->action = test_long_return(test, 2);
+
+		eeprom_buffer->flush(eeprom_buffer);
+	}
+
+	static int eeprom_buffer_test_init(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx;
+
+		ctx = test_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+		ctx->mock_eeprom = CONSTRUCT_MOCK(eeprom, test);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx->fake_eeprom);
+
+		ctx->eeprom_buffer = new_eeprom_buffer(mock_get_trgt(ctx->mock_eeprom));
+		ASSERT_NOT_ERR_OR_NULL(test, ctx->eeprom_buffer);
+
+		test->priv = ctx;
+
+		return 0;
+	}
+
+	static void eeprom_buffer_test_exit(struct test *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+
+		destroy_eeprom_buffer(ctx->eeprom_buffer);
+	}
+
+This test case tests the same thing as the
+``eeprom_buffer_test_does_not_write_until_flush`` test case from the example in
+the faking section. Observe that in this test case you specify how you expect
+the mock to be called (technically this is both stubbing and mocking `which are
+different things
+<https://martinfowler.com/articles/mocksArentStubs.html#TheDifferenceBetweenMocksAndStubs>`_,
+but KUnit combines them as many other xUnit testing libraries do) and also how
+the mock should behave when those expectations are met (see
+``test_long_return``).
+
+Mocks are extremely powerful as they allow you the finest possible granularity
+for verifying how units interact, and allows the injection of arbitrary
+behavior. But as Uncle Ben said, "Great power comes with great responsibility."
+Mocks are not to be used lightly; they make it possible to test things which are
+otherwise difficult or impossible to test, but when used improperly they have a
+much higher maintenance burden than using the real thing or even a high quality
+fake.
+
+Compare the ``eeprom_buffer_test_does_not_write_until_flush`` in the faking
+example to the above version that uses mocking. It is pretty clear that the
+version that uses faking is easier to read. It is also pretty clear that common
+behavior between test cases would have to be duplicated with the mocking
+version; the fake has the advantage of implementing desired behavior in a single
+place. Finally, it is pretty clear that the fake would be much easier to
+maintain. Of course what's even easier than having to maintain a fake is not
+not having to maintain anything at all. Thus,
+
+.. important::
+   Always prefer high quality fakes over mocks, and always prefer "real" code to
+   fakes.
+
+Fakes should generally be used when there is an external dependency that there
+is no way around; in the kernel that usually means hardware. If you write a fake
+you have to make sure it can be maintained; consequently, it is just as
+important as real code and it should get its own tests to verify it works as
+expected. Yes, we are telling you to write tests for your fakes.
+
+Of course sometimes faking something out is infeasible, or there is some code
+that is just otherwise impossible to reach; generally this means that your code
+should be refactored, but not always. Either way, well tested code in need of
+refactoring is better than code that needs refactoring but has no tests. This
+leads to the single most important testing principle that overrides all others:
+
+.. important::
+   **Always prefer tests over no tests, no matter what!**
+
+For more information on class mocking see :doc:`api/class-and-function-mocking`.
+
+Mocking Arbitrary Functions
+---------------------------
+
+.. important::
+   Always prefer class mocking over arbitrary function mocking where possible.
+   Class mocking has a much more limited scope and provides more control.
+
+Sometimes it is necessary to mock a function that does not use any class style
+indirection. First and foremost, if you encounter this in your own code, please
+rewrite it so that uses class style indirection discussed above, but if this is
+in some code that is outside of your control you may use KUnit's function
+mocking features.
+
+KUnit provides macros to allow arbitrary functions to be overridden so that the
+original definition is replaced with a mock stub. For most functions, all you
+have to do is label the function ``__mockable``:
+
+.. code-block:: c
+
+	int __mockable example(int arg) {...}
+
+If a function is ``__mockable`` and a mock is defined:
+
+.. code-block:: c
+
+	DEFINE_FUNCTION_MOCK(example, RETURNS(int), PARAMS(int));
+
+When the function is called, the mock stub will actually be called.
+
+.. note::
+   There is no performance penalty or potential side effects from doing this.
+   When not compiling for testing, ``__mockable`` compiles away.
+
+.. note::
+   ``__mockable`` does not work on inlined functions.
+
+Spying
+~~~~~~
+
+Sometimes it is desirable to have a mock function that delegates to the original
+definition in some or all circumstances. This is called *spying*:
+
+.. code-block:: c
+
+	DEFINE_SPYABLE(i2c_add_adapter, RETURNS(int), PARAMS(struct i2c_adapter *));
+	int REAL_ID(i2c_add_adapter)(struct i2c_adapter *adapter)
+	{
+		...
+	}
+
+This allows the function to be overridden by a mock as with ``__mockable``;
+however, it associates the original definition of the function with an alternate
+symbol that KUnit can still reference. This makes it possible to mock the
+function and then have the mock delegate to the original function definition
+with the ``INVOKE_REAL(...)`` action:
+
+.. code-block:: c
+
+	static int aspeed_i2c_test_init(struct test *test)
+	{
+		struct mock_param_capturer *adap_capturer;
+		struct mock_expectation *handle;
+		struct aspeed_i2c_test *ctx;
+		int ret;
+
+		ctx = test_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+		test->priv = ctx;
+
+		handle = TEST_EXPECT_CALL(
+				i2c_add_adapter(capturer_to_matcher(adap_capturer)));
+		handle->action = INVOKE_REAL(test, i2c_add_adapter);
+		ret = of_fake_probe_platform_by_name(test,
+						     "aspeed-i2c-bus",
+						     "test-i2c-bus");
+		if (ret < 0)
+			return ret;
+
+		ASSERT_PARAM_CAPTURED(test, adap_capturer);
+		ctx->adap = mock_capturer_get(adap_capturer, struct i2c_adapter *);
+
+		return 0;
+	}
+
+For more information on function mocking see
+:doc:`api/class-and-function-mocking`.
+
+Platform Mocking
+----------------
+The Linux kernel generally forbids normal code from accessing architecture
+specific features. Instead, low level hardware features are usually abstracted
+so that architecture specific code can live in the ``arch/`` directory and all
+other code relies on APIs exposed by it.
+
+KUnit provides a mock architecture that currently allows mocking basic IO memory
+accessors and in the future will provide even more. A major use case for
+platform mocking is unit testing platform drivers, so KUnit also provides
+helpers for this as well.
+
+In order to use platform mocking, ``CONFIG_PLATFORM_MOCK`` must be enabled in
+your ``kunitconfig``.
+
+For more information on platform mocking see :doc:`api/platform-mocking`.
+
+Method Call Expectations
+========================
+Once we have classes and methods mocked, we can place more advanced
+expectations. Previously, we could only place expectations on simple return
+values. With the :c:func:`TEST_EXPECT_CALL` macro, which allows you to make
+assertions that a certain mocked function is called with specific arguments
+given some code to be run.
+
+Basic Usage
+-----------
+Imagine we had some kind of dependency like this:
+
+.. code-block:: c
+
+	struct Printer {
+		void (*print)(int arg);
+	};
+
+	// Printer's print
+	void printer_print(int arg)
+	{
+		do_something_to_print_to_screen(arg);
+	}
+
+	struct Foo {
+		struct Printer *internal_printer;
+		void (*print_add_two)(struct Foo*, int);
+	};
+
+	// Foo's print_add_two:
+	void foo_print_add_two(struct Foo *this, int arg)
+	{
+		internal_printer->print(arg + 2);
+	}
+
+and we wanted to test ``struct Foo``'s behaviour, that ``foo->print_add_two``
+actually adds 2 to the argument passed. To properly unit test this, we create
+mocks for all of ``struct Foo``'s dependencies, like ``struct Printer``.
+We first setup stubs for ``MOCK(Printer)`` and its ``print`` function.
+
+In the real code, we'd assign a real ``struct Printer`` to the
+``internal_printer`` variable in our ``struct Foo`` object, but in the
+test, we'd construct a ``struct Foo`` with our ``MOCK(Printer)``.
+
+Finally, we can place expectations on the ``MOCK(Printer)``.
+
+For example:
+
+.. code-block:: c
+
+	static int test_foo_add_two(struct test *test)
+	{
+		struct MOCK(Printer) *mock_printer = get_mocked_printer();
+		struct Foo *foo = initialize_foo(mock_printer);
+
+		// print() is a mocked method stub
+		TEST_EXPECT_CALL(print(test_any(test), test_int_eq(test, 12)));
+
+		foo->print_add_two(foo, 10);
+	}
+
+Here, we expect that the printer's print function will be called (by default,
+once), and that it will be called with the argument ``12``. Once we've placed
+expectations, we can call the function we want to test to see that it behaves
+as we expected.
+
+Matchers
+--------
+Above, we see ``test_any`` and ``test_int_eq``, which are matchers. A matcher
+simply asserts that the argument passed to that function call fulfills some
+condition.  In this case, ``test_any()`` matches any argument, and
+``test_int_eq(12)`` asserts that the argument passed to that function must
+equal 12. If we had called: ``foo->print_add_two(foo, 9)`` instead, the
+expectation would not have been fulfilled. There are a variety of built-in
+matchers: :doc:`api/class-and-function-mocking` has a section about these
+matchers.
+
+.. note::
+	:c:func:`TEST_EXPECT_CALL` only works with mocked functions and methods.
+	Matchers may only be used within the function inside the
+	:c:func:`TEST_EXPECT_CALL`.
+
+Additional :c:func:`EXPECT_CALL` Properties
+-------------------------------------------
+
+The return value of :c:func:`TEST_EXPECT_CALL` is a ``struct
+mock_expectation``. We can capture the value and add extra properties to it as
+defined by the ``struct mock_expectation`` interface.
+
+Times Called
+~~~~~~~~~~~~
+In the previous example, if we wanted assert that the method is never called,
+we could write:
+
+.. code-block:: c
+
+	...
+	struct mock_expectation* handle = TEST_EXPECT_CALL(...);
+	handle->min_calls_expected = 0;
+	handle->max_calls_expected = 0;
+	...
+
+Both those fields are set to 1 by default and can be changed to assert a range
+of times that the method or function is called.
+
+Mocked Actions
+~~~~~~~~~~~~~~
+Because ``mock_printer`` is a mock, it doesn't actually perform any task. If
+the function had some side effect that ``struct Foo`` requires to have been
+done, such as modifying some state, we could mock that as well.
+
+Each expectation has an associated ``struct mock_action`` which can be set with
+``handle->action``. By default, there are two actions that mock return values.
+Those can also be found in :doc:`api/class-and-function-mocking`.
+
+Custom actions can be defined by simply creating a ``struct mock_action`` and
+assigning the appropriate function to ``do_action``. Mocked actions have access
+to the parameters passed to the mocked function, as well as have the ability to
+change / set the return value.
+
+
+The Nice, the Strict, and the Naggy
+===================================
+KUnit has three different mock types that can be set on a mocked class: nice
+mocks, strict mocks, and naggy mocks. These are set via the corresponding macros
+:c:func:`NICE_MOCK`, :c:func:`STRICT_MOCK`, and :c:func:`NAGGY_MOCK`, with naggy
+mocks being the default.
+
+The type of mock simply dictates the behaviour the mock exhibits when
+expectations are placed on it.
+
++-----------------------+------------+--------------------+--------------------+
+|                       | **Nice**   | **Naggy (default)**| **Strict**         |
++-----------------------+------------+--------------------+--------------------+
+| Method called with no | Do nothing | Prints warning for | Fails test, prints |
+| expectations on it    |            | uninteresting call | warning            |
+|                       |            |                    | uninteresting call |
++-----------------------+------------+--------------------+--------------------+
+| Method called with no | Fails test, prints warnings, prints tried            |
+| matching expectations | expectations                                         |
+| on it                 |                                                      |
++-----------------------+------------------------------------------------------+
+| Test ends with an     | Fail test, print warning                             |
+| unfulfilled           |                                                      |
+| expectation           |                                                      |
++-----------------------+------------------------------------------------------+
+
+These macros take a ``MOCK(struct_name)`` and so should be used when retrieving
+the mocked object. Following the example in :doc:`start`, there was this test
+case:
+
+.. code-block:: c
+
+	static void misc_example_bar_test_success(struct test *test)
+	{
+		struct MOCK(misc_example) *mock_example = test->priv;
+		struct misc_example *example = mock_get_trgt(mock_example);
+		struct mock_expectation *handle;
+
+		handle = TEST_EXPECT_CALL(misc_example_foo(mock_get_ctrl(mock_example),
+						      test_int_eq(test, 5)));
+		handle->action = int_return(test, 0);
+
+		TEST_EXPECT_EQ(test, 0, misc_example_bar(example));
+	}
+
+If we wanted ``mock_example`` to be a nice mock instead, we would simply write:
+
+.. code-block:: c
+
+	struct MOCK(misc_example) *mock_example = NICE_MOCK(test->priv);
-- 
2.19.1.331.ge82ca0e54c-goog

