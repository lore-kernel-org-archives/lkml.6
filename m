Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138A42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="asBo5BoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138A42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJRPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:08:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44619 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJRPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:08:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so26668360ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 00:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T2stLgyg18MQ9p+6+t8oNvg14Su0YdeVWjL1RNVaFOE=;
        b=asBo5BoUlydsbwdkRSJS5mm4XLmE8XjsGGKPTdk4wISXR0gaxQgsdSRnKT639AdM5c
         BeNYyYGMt5O2DrDu9bSJYa1VQA1h+HZiHb8JQd7aOYa9avsl4t1pfE+7TTnBPdB1KYVG
         fR6yfRgfXXmXrdZ6QdKGWlMDqf13S7Za/ZzLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T2stLgyg18MQ9p+6+t8oNvg14Su0YdeVWjL1RNVaFOE=;
        b=tBucwEAVqrdj8rZUdRStQhbFzhKB9jf369LwG7eWlz3PTxZi9BYjjnfB80tv1F8D0Q
         r7KZHKWygjqFrfh3yF1+ArnPVdNrHOXsGQGaWYx4aVAiVNypL9Qyc3tUSWB2gHPKCIjB
         b5sQnWvTTMYbN5hj9F70MWKdosGhfHAyqLBpuoQc30NnW95IAEnSEC3ORWJVq6V7Tymh
         kbJhTTvEOfP7Ky4j7ekq6ZFB8IH5bHDv/fFV8yKjPjWYhHbFw2Vj9iUfhtVpyNSp+miA
         Z+0J9UaAyWxL8FaUY8hFOaAYE2NWVWmd+RXq0kBKriQISmkpJtBf49LGy5MrXAPQ/qNK
         7YGw==
X-Gm-Message-State: AGRZ1gIvndNbsjc11nSLT1OPytyEq8OoKi468DC4KHRa5KN5NJEkWwZi
        9Ksmp41/kou15TvRhwQbZBiZFE/PSWXha1aepUqjI5dIGRU=
X-Google-Smtp-Source: ACcGV60h4bxxC/0tlMomkA9iR7HJaDEOYN/TYhqLEw9O7mX8xF0JRIDaBOTHhHHjd4JpTgeQ9RLPLDzfSRm1eddMZ/4=
X-Received: by 2002:a2e:9e56:: with SMTP id g22-v6mr584134ljk.120.1539846539241;
 Thu, 18 Oct 2018 00:08:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8e91:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 00:08:58
 -0700 (PDT)
In-Reply-To: <20181018065908.254389-2-joel@joelfernandes.org>
References: <20181018065908.254389-1-joel@joelfernandes.org> <20181018065908.254389-2-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Oct 2018 00:08:58 -0700
Message-ID: <CAEXW_YTDWgY3JAeiY0Ti0BBL=iJMcSkR5V7USJYv6UxHiCpN-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/memfd: Add tests for F_SEAL_FS_WRITE seal
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     kernel-team <kernel-team@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        John Reck <jreck@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:59 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> Add tests to verify sealing memfds with the F_SEAL_FS_WRITE works as
> expected.

I messed the commit message it should be "F_SEAL_FUTURE_WRITE", but
otherwise this
patch itself is good and I'll resend it with the corrected commit
message after further review.

thanks,

 - Joel



> Cc: dancol@google.com
> Cc: minchan@kernel.org
> Reviewed-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 10baa1652fc2..32b207ca7372 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -692,6 +692,79 @@ static void test_seal_write(void)
>         close(fd);
>  }
>
> +/*
> + * Test SEAL_FUTURE_WRITE
> + * Test whether SEAL_FUTURE_WRITE actually prevents modifications.
> + */
> +static void test_seal_future_write(void)
> +{
> +       int fd;
> +       void *p;
> +
> +       printf("%s SEAL-FUTURE-WRITE\n", memfd_str);
> +
> +       fd = mfd_assert_new("kern_memfd_seal_future_write",
> +                           mfd_def_size,
> +                           MFD_CLOEXEC | MFD_ALLOW_SEALING);
> +
> +       p = mfd_assert_mmap_shared(fd);
> +
> +       mfd_assert_has_seals(fd, 0);
> +       /* Not adding grow/shrink seals makes the future write
> +        * seal fail to get added
> +        */
> +       mfd_fail_add_seals(fd, F_SEAL_FUTURE_WRITE);
> +
> +       mfd_assert_add_seals(fd, F_SEAL_GROW);
> +       mfd_assert_has_seals(fd, F_SEAL_GROW);
> +
> +       /* Should still fail since shrink seal has
> +        * not yet been added
> +        */
> +       mfd_fail_add_seals(fd, F_SEAL_FUTURE_WRITE);
> +
> +       mfd_assert_add_seals(fd, F_SEAL_SHRINK);
> +       mfd_assert_has_seals(fd, F_SEAL_GROW |
> +                                F_SEAL_SHRINK);
> +
> +       /* Now should succeed, also verifies that the seal
> +        * could be added with an existing writable mmap
> +        */
> +       mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
> +       mfd_assert_has_seals(fd, F_SEAL_SHRINK |
> +                                F_SEAL_GROW |
> +                                F_SEAL_FUTURE_WRITE);
> +
> +       /* read should pass, writes should fail */
> +       mfd_assert_read(fd);
> +       mfd_fail_write(fd);
> +
> +       munmap(p, mfd_def_size);
> +       close(fd);
> +
> +       /* Test adding all seals (grow, shrink, future write) at once */
> +       fd = mfd_assert_new("kern_memfd_seal_future_write2",
> +                           mfd_def_size,
> +                           MFD_CLOEXEC | MFD_ALLOW_SEALING);
> +
> +       p = mfd_assert_mmap_shared(fd);
> +
> +       mfd_assert_has_seals(fd, 0);
> +       mfd_assert_add_seals(fd, F_SEAL_SHRINK |
> +                                F_SEAL_GROW |
> +                                F_SEAL_FUTURE_WRITE);
> +       mfd_assert_has_seals(fd, F_SEAL_SHRINK |
> +                                F_SEAL_GROW |
> +                                F_SEAL_FUTURE_WRITE);
> +
> +       /* read should pass, writes should fail */
> +       mfd_assert_read(fd);
> +       mfd_fail_write(fd);
> +
> +       munmap(p, mfd_def_size);
> +       close(fd);
> +}
> +
>  /*
>   * Test SEAL_SHRINK
>   * Test whether SEAL_SHRINK actually prevents shrinking
> @@ -945,6 +1018,7 @@ int main(int argc, char **argv)
>         test_basic();
>
>         test_seal_write();
> +       test_seal_future_write();
>         test_seal_shrink();
>         test_seal_grow();
>         test_seal_resize();
> --
> 2.19.1.331.ge82ca0e54c-goog
>
