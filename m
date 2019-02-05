Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92561C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5577620823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R02RwVcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBEClx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:41:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53439 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfBEClx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:41:53 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so4911950ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 18:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4yo+ZktVJDRj8IblqxKbLr7frw7VLVWNitlB7KcSEU=;
        b=R02RwVcQ/32Zw0yQFlOUnBYWDuc5EibJCOd+CZcc51BNZcD74Kg7tm6d1G8hgzjUVc
         km2f3Iv2ukGbo9+6wP9Vh46uMepETpLQ6Hp3bxPgrgmkQpliyqkYdQNtrGgzaRzpuQQl
         sKaf85giacpFOPI44crpeDAN/OjgL40sSeBqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4yo+ZktVJDRj8IblqxKbLr7frw7VLVWNitlB7KcSEU=;
        b=IvHRxNolIcXeagOd9WuMcTiaKmDzdiEMCWXDcI03ypKhTIAY3AvYeZvl1bIzQLcYoR
         qmfrwvvnHJf0S0zSE6hHy2E6HbhhvCBsKFt8exaJ4A9wJcFEYTFEXiZ+lokhz1hyHW46
         Bj+uyNRihhorrgdo/R+4U4tua/GoKYtzEQiAZFUNqyE9ELqu/JnGtMsyuDqQYj3S/5q0
         UNjLsXiIj7Jb3Kai1h2sT7LwVCR+yNzchVti4sHEJfmpgLX9G+7xAy12JlNmifhr/xJ/
         a1ngKKriY81AzRA0rRO1SAy2WlCNJTC445fX3I8wIrB1LGSr4qEGKhRC9lhamIII801X
         OkeQ==
X-Gm-Message-State: AHQUAuYke69+TzTORDYoRpmtsd/FlKDachxi0VDtLSAva2FzYqpi56OR
        7TJ2u6MZGs5A2+UpER7JaHeqkw==
X-Google-Smtp-Source: AHgI3IZ84tyUTeCQPEQIJuJIyGuTxfjNEsAviFYlnJiMs3cruX5SUAwM88axEv5QCtQLyMH72MhrUg==
X-Received: by 2002:a24:ac02:: with SMTP id s2mr1448545ite.94.1549334511886;
        Mon, 04 Feb 2019 18:41:51 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id e22sm816701iol.49.2019.02.04.18.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 18:41:51 -0800 (PST)
Date:   Mon, 4 Feb 2019 20:41:50 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 2/2] selftests: firmware: add
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config
Message-ID: <20190205024150.4ntyl5gccvk7soux@xps.therub.org>
References: <20181127031218.24419-1-dan.rue@linaro.org>
 <20181127031218.24419-3-dan.rue@linaro.org>
 <20181130023115.GN4922@garbanzo.do-not-panic.com>
 <CAB=NE6Xxzee9+VeXWqe3o8Uf3Mb+jw=_-9C8RuqSSeWrVUXJng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=NE6Xxzee9+VeXWqe3o8Uf3Mb+jw=_-9C8RuqSSeWrVUXJng@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:39:57PM -0600, Luis Chamberlain wrote:
> On Thu, Nov 29, 2018 at 8:31 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Nov 26, 2018 at 09:12:16PM -0600, Dan Rue wrote:
> > > CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y is required for fw_fallback.sh.
> > > Without it, fw_fallback.sh fails with 'usermode helper disabled so
> > > ignoring test'. Enable the config in selftest so that it gets built by
> > > default.
> > >
> > > Signed-off-by: Dan Rue <dan.rue@linaro.org>
> > > ---
> > >  tools/testing/selftests/firmware/config | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> > > index bf634dda0720..913a25a4a32b 100644
> > > --- a/tools/testing/selftests/firmware/config
> > > +++ b/tools/testing/selftests/firmware/config
> > > @@ -1,5 +1,6 @@
> > >  CONFIG_TEST_FIRMWARE=y
> > >  CONFIG_FW_LOADER=y
> > >  CONFIG_FW_LOADER_USER_HELPER=y
> > > +CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> > >  CONFIG_IKCONFIG=y
> > >  CONFIG_IKCONFIG_PROC=y
> >
> > NACK -- the point of the changes was to *allow* us to mimic such
> > configuration through a proc sysctl knob.
> >
> > You aren forcing CONFIG_FW_LOADER_USER_HELPER_FALLBACK but just having
> > CONFIG_FW_LOADER_USER_HELPER suffices to emulate the_FALLBACK
> > functionality.
> 
> Dan, again, you broke the whole point to the amount of work that went
> into emulating testing. As such anyone testing their changes would
> yield incorrect results.
> 
> > The issue here seems to be that *all* tests fail once a configuration is
> > found which is not suitable a tests. With the shiny new proc sysctls we
> > can test all 3 kernel configurations in one shot. Since we test 3
> > different kernel configurations naturally some of these won't have the
> > features needed, so that failure should be treated as non-fatal to allow
> > the chain of other tests to continue.
> >
> > This issue was a regression due to commit a6a9be9270c87 ("selftests:
> > firmware: return Kselftest Skip code for skipped tests") by Shuah for
> > the verify_reqs(). We need to treat this as a non-fatal / don't skip
> > return value.
> >
> > The following would fix this chaining issue:
> >
> > diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> > index 6c5f1b2ffb74..1cbb12e284a6 100755
> > --- a/tools/testing/selftests/firmware/fw_lib.sh
> > +++ b/tools/testing/selftests/firmware/fw_lib.sh
> > @@ -91,7 +91,7 @@ verify_reqs()
> >         if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
> >                 if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> >                         echo "usermode helper disabled so ignoring test"
> > -                       exit $ksft_skip
> > +                       exit 0
> >                 fi
> >         fi
> >  }
> >
> > However its not clear to me if instead we want some new special return
> > value for selftests so that the framework can detect an that an error
> > is non-fatal, and can continue. This is a tricky situation given the
> > script, existing upstream kernel module, are aware of such emulation
> > hacks via sysctl, but knowledge of this is not obvious to selftests.
> >
> > Shuah, how do you suggest we handle this corner case? If you are OK
> > with the above hunk for now I can send a fix for it. In either case
> > this commit was added on v4.18, so the fix would be a stable fix.
> 
> In lieu of any suggestion I'm going to request we revert this commit
> and send the above fix.

Sorry, I didn't realize this was waiting on me. I agree with all of your
feedback. Please revert 7492902e8d22 ("selftests: firmware: add
CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config") and add my Acked-by to
the proposed fix above.

Shuah, do I need to send a patch for that revert?

It would be nice if there were a way (maybe there is?) to let each of
the individual tests be exposed and run by run_kselftest.sh so that each
test gets its own proper pass/skip/fail. It could be done in this case
by making fw_run_tests.sh look more like run_kselftest.sh (running each
test in a subshell and capturing its exit code), but that starts to get
a bit fragile and ugly, too.

Dan

> 
>  Luis
