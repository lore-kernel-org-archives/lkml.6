Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C20C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9851218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 04:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="pd69V962";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDHtciso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfB0ElO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:41:14 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47105 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729846AbfB0ElM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 23:41:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 327FA3654;
        Tue, 26 Feb 2019 23:41:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Feb 2019 23:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Vq56sPVlf5iV9SyHAx96gQfF91Z
        o/49jS5sKTSdjcyQ=; b=pd69V962jR6gcm43a/hVVFK1KkKZcBAkqOHTlLUG0KH
        QrBDZXc+lhBVZt62txCvlGxUVtp81cfzgL9sCbCE1kwKTHJDswqPULnj+a+SG8Fc
        EYhdArj93x2fjcmBO3spM4X7xNC3Lt3Y/7mB6Yy8RG/Ph7wP10yO0+1Kfuaq+aWV
        AEHMXlqvhmSahqPzAGS/C9zyWIVbEQXWHHH/OLcPHuFalnPTIkkgboE9fRAlzSXb
        JogYXUKrfHAmhw+CmFL6jn5tcc0q8CRo2Tw3+qf+lQ1GCL0cNK4LXpl3kkIDQWXr
        ywvb2FAIry7B7XkQz5arV7JdVqVhDPkn6150zbaHWYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Vq56sP
        Vlf5iV9SyHAx96gQfF91Zo/49jS5sKTSdjcyQ=; b=rDHtcisomt+prEj+t7Z/G4
        W7JTUoCZKJ/687QpBKPjB58dScwZv99AZRka+FBI6VVbr2e2O3WxLAUdUaFsYJFU
        erm21orUXck+2ECs/RMMkRWax7+Atd3Br5EDw/VlDuBQdWwqwblsT+u3yqIdE+B6
        p1rTCBcfMrlZCaBnuQLwRQ5rHYQGxww4lnYwuXzAfcQv1W2ub0uE7tbl1tzVkGTf
        /PDmDHjLl1f3HP8wCdYcZqUAKipB7ypBCAb9YChE+9uJz8RP6AuSDLQQIVf8rS+K
        E9G2lt+jqIugYmwhnCrs9LRgx6EVxcCVzFaoolrDlOhyZxlui8uc/1n35lNnddPw
        ==
X-ME-Sender: <xms:4hR2XErRPj2Qdg5pm8bDjUI18N3ZoNSN_v0qVa05jNFioB3iGRnOUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvddtgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvhedtrdekjeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:4hR2XMOUBmmhaGRCUiXLBEn2oj6iGj3QzT3nbsdIk8stEGX03IQKeg>
    <xmx:4hR2XPhvBFcdfZ_62Y5oVzx3-3O6rBrpRncB3t4zRL03UnoDNmAHPA>
    <xmx:4hR2XHu1wsUlvxc5WK4JE3YHoS-V_YdVwDxbwRz6Be28ZeIaQiDkBw>
    <xmx:4xR2XHNCmVVQw8XA_loLs2TzZc83Ii3fXvgT2fzvEkXdtT3R8rBQ-Q>
Received: from localhost (ppp121-44-250-87.bras2.syd2.internode.on.net [121.44.250.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id E143AE4542;
        Tue, 26 Feb 2019 23:41:04 -0500 (EST)
Date:   Wed, 27 Feb 2019 15:40:49 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] lib/string: Add strscpy_pad() function
Message-ID: <20190227044049.GA13176@eros.localdomain>
References: <20190225041534.27186-1-tobin@kernel.org>
 <20190225041534.27186-2-tobin@kernel.org>
 <CAGXu5jJ_OACAt8dmb7QiO9tT4i7+VPJnU+RFCCa98vQEvVsOLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ_OACAt8dmb7QiO9tT4i7+VPJnU+RFCCa98vQEvVsOLw@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:38:44PM -0800, Kees Cook wrote:
> On Sun, Feb 24, 2019 at 8:16 PM Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > We have a function to copy strings safely and we have a function to copy
> > strings and zero the tail of the destination (if source string is
> > shorter than destination buffer) but we do not have a function to do
> > both at once.  This means developers must write this themselves if they
> > desire this functionality.  This is a chore, and also leaves us open to
> > off by one errors unnecessarily.
> >
> > Add a function that calls strscpy() then memset()s the tail to zero if
> > the source string is shorter than the destination buffer.
> >
> > Add test module for the new code.
> >
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > [...]
> > +ssize_t strscpy_pad(char *dest, const char *src, size_t count)
> > +{
> > +       ssize_t written;
> > +
> > +       written = strscpy(dest, src, count);
> > +       if (written < 0 || written == count - 1)
> > +               return written;
> 
> *thread merge* Yeah, good point. written will be -E2BIG for both count
> = 0 and count = 1.
> 
> > +
> > +       memset(dest + written + 1, 0, count - written - 1);
> > +
> > +       return written;
> > +}
> > +EXPORT_SYMBOL(strscpy_pad);
> > +
> >  #ifndef __HAVE_ARCH_STRCAT
> >  /**
> >   * strcat - Append one %NUL-terminated string to another
> > diff --git a/lib/test_strscpy.c b/lib/test_strscpy.c
> > new file mode 100644
> > index 000000000000..5ec6a196f4e2
> > --- /dev/null
> > +++ b/lib/test_strscpy.c
> > @@ -0,0 +1,175 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/printk.h>
> > +#include <linux/string.h>
> > +
> > +/*
> > + * Kernel module for testing 'strscpy' family of functions.
> > + */
> > +
> > +static unsigned total_tests __initdata;
> > +static unsigned failed_tests __initdata;
> > +
> > +static void __init do_test(int count, char *src, int expected,
> > +                          int chars, int terminator, int pad)
> > +{
> > +       char buf[6];
> 
> I would make this "6" a define, since you use it in more than one
> place. Actually... no, never mind. The other places can use
> "sizeof(buf)" instead of "6". Noted below...
> 
> But I'd add an explicit check for "expected + 1 < sizeof(buf)" just
> for future test-addition sanity.
> 
> > +       int written;
> > +       int poison;
> > +       int index;
> > +       int i;
> > +       const char POISON = 'z';
> > +
> > +       total_tests++;
> > +       memset(buf, POISON, sizeof(buf));
> > +
> > +       /* Verify the return value */
> > +
> 
> Needless blank line.
> 
> > +       written = strscpy_pad(buf, src, count);
> > +       if ((written) != (expected)) {
> > +               pr_err("%d != %d (written, expected)\n", written, expected);
> > +               goto fail;
> > +       }
> > +
> > +       /* Verify the state of the buffer */
> > +
> 
> Same.
> 
> > +       if (count && written == -E2BIG) {
> > +               if (strncmp(buf, src, count - 1) != 0) {
> > +                       pr_err("buffer state invalid for -E2BIG\n");
> > +                       goto fail;
> > +               }
> > +               if (buf[count - 1] != '\0') {
> > +                       pr_err("too big string is not null terminated correctly\n");
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       /* Verify the copied content */
> > +       for (i = 0; i < chars; i++) {
> > +               if (buf[i] != src[i]) {
> > +                       pr_err("buf[i]==%c != src[i]==%c\n", buf[i], src[i]);
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       /* Verify the null terminator */
> > +       if (terminator) {
> > +               if (buf[count - 1] != '\0') {
> > +                       pr_err("string is not null terminated correctly\n");
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       /* Verify the padding */
> > +       for (i = 0; i < pad; i++) {
> > +               index = chars + terminator + i;
> > +               if (buf[index] != '\0') {
> > +                       pr_err("padding missing at index: %d\n", i);
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       /* Verify the rest is left untouched */
> > +       poison = 6 - chars - terminator - pad;
> 
> instead of "6", use "sizeof(buf)".
> 
> > +       for (i = 0; i < poison; i++) {
> > +               index = 6 - 1 - i; /* Check from the end back */
> 
> Same.
> 
> > +               if (buf[index] != POISON) {
> > +                       pr_err("poison value missing at index: %d\n", i);
> > +                       goto fail;
> > +               }
> > +       }
> > +
> > +       return;
> > +fail:
> > +       pr_info("%s(%d, '%s', %d, %d, %d, %d)\n", __func__,
> > +               count, src, expected, chars, terminator, pad);
> > +       failed_tests++;
> > +}
> > +
> > +static void __init test_fully(void)
> > +{
> > +       /* do_test(count, src, expected, chars, terminator, pad) */
> > +
> > +       do_test(0, "a", -E2BIG, 0, 0, 0);
> > +       do_test(0, "", -E2BIG, 0, 0, 0);
> > +
> > +       do_test(1, "a", -E2BIG, 0, 1, 0);
> > +       do_test(1, "", 0, 0, 1, 0);
> > +
> > +       do_test(2, "ab", -E2BIG, 1, 1, 0);
> > +       do_test(2, "a", 1, 1, 1, 0);
> > +       do_test(2, "", 0, 0, 1, 1);
> > +
> > +       do_test(3, "abc", -E2BIG, 2, 1, 0);
> > +       do_test(3, "ab", 2, 2, 1, 0);
> > +       do_test(3, "a", 1, 1, 1, 1);
> > +       do_test(3, "", 0, 0, 1, 2);
> > +
> > +       do_test(4, "abcd", -E2BIG, 3, 1, 0);
> > +       do_test(4, "abc", 3, 3, 1, 0);
> > +       do_test(4, "ab", 2, 2, 1, 1);
> > +       do_test(4, "a", 1, 1, 1, 2);
> > +       do_test(4, "", 0, 0, 1, 3);
> > +}
> > +
> > +static void __init test_basic(void)
> > +{
> > +       char buf[6];
> > +       int written;
> > +
> > +       memset(buf, 'a', sizeof(buf));
> > +
> > +       total_tests++;
> > +       written = strscpy_pad(buf, "bb", 4);
> > +       if (written != 2)
> > +               failed_tests++;
> > +
> > +       /* Correctly copied */
> > +       total_tests++;
> > +       if (buf[0] != 'b' || buf[1] != 'b')
> > +               failed_tests++;
> > +
> > +       /* Correctly padded */
> > +       total_tests++;
> > +       if (buf[2] != '\0' || buf[3] != '\0')
> > +               failed_tests++;
> > +
> > +       /* Only touched what it was supposed to */
> > +       total_tests++;
> > +       if (buf[4] != 'a' || buf[5] != 'a')
> > +               failed_tests++;
> > +}
> 
> I don't think you need to keep "test_basic". Anything it tests can be
> rewritten in terms of do_test().
> 
> > +
> > +static int __init test_strscpy_init(void)
> > +{
> > +       pr_info("loaded.\n");
> > +
> > +       test_basic();
> > +       if (failed_tests)
> > +               goto out;
> > +
> > +       test_fully();
> > +
> > +out:
> > +       if (failed_tests == 0)
> > +               pr_info("all %u tests passed\n", total_tests);
> > +       else
> > +               pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
> > +
> > +       return failed_tests ? -EINVAL : 0;
> > +}
> > +module_init(test_strscpy_init);
> > +
> > +static void __exit test_strscpy_exit(void)
> > +{
> > +       pr_info("unloaded.\n");
> > +}
> > +module_exit(test_strscpy_exit);
> > +
> > +MODULE_AUTHOR("Tobin C. Harding <tobin@kernel.org>");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.20.1
> >
> 
> Otherwise, yes, looks good!

Cool, thanks.  Will fix up as suggested and re-spin.

	Tobin
