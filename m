Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098132082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549323615;
	bh=Fj6O/QNu7OcJcfg7dbnivArlP+7oIWZx6OwaYJbq5Qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=arJEbI4n3p19QXIpW7kPrumJaCWcSrdV6yxNCa5rx90mOb7aS3qmACDclkfMvVycJ
	 rHeH3Emf9WnlW4cEvSvfuk8feHnLHyaFmDvGZXf0EhAT/IjsLGfraC4YzGsCsVfqgU
	 /G60sm91i+SECTkC0V7NsPA0hIyncM/VeoBl1Dm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfBDXkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfBDXkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:40:13 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347722082E;
        Mon,  4 Feb 2019 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549323611;
        bh=Fj6O/QNu7OcJcfg7dbnivArlP+7oIWZx6OwaYJbq5Qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f93XC5WaBmkTes6d0/5wcCzcMZCqtiuP72mb9h5nSqnHRdEik+KYURlJhy3BGAFXO
         QQp+JHDU9grHBiotczyU4b5gEQlU14qUaBg9PJPq8szEVssKfBpPUQhX0wLWdmtNSn
         YOSd4wGTO13SC/Txq32qJCC6fncodgImUKYrrx2A=
Received: by mail-vs1-f48.google.com with SMTP id u11so1070581vsp.11;
        Mon, 04 Feb 2019 15:40:11 -0800 (PST)
X-Gm-Message-State: AHQUAuZbc+VtsQG1pbWLoGQkx4XfCYlgFyDXiRHlaEOxNSCRxfN14KmD
        IDMGuyblSfxjss+KLZvqC+WJuZX5WmhO21jk4Uk=
X-Google-Smtp-Source: AHgI3IYIqP2Nlfrligv6puhJbfdfLKjcYrCcTijszQBiEL80gyWg6jx44GOkQX7KSr8g8k/5q8Tu0o7YrWBvBl8pTVY=
X-Received: by 2002:a67:48d9:: with SMTP id c86mr875791vsg.122.1549323610324;
 Mon, 04 Feb 2019 15:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20181127031218.24419-1-dan.rue@linaro.org> <20181127031218.24419-3-dan.rue@linaro.org>
 <20181130023115.GN4922@garbanzo.do-not-panic.com>
In-Reply-To: <20181130023115.GN4922@garbanzo.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Mon, 4 Feb 2019 17:39:57 -0600
X-Gmail-Original-Message-ID: <CAB=NE6Xxzee9+VeXWqe3o8Uf3Mb+jw=_-9C8RuqSSeWrVUXJng@mail.gmail.com>
Message-ID: <CAB=NE6Xxzee9+VeXWqe3o8Uf3Mb+jw=_-9C8RuqSSeWrVUXJng@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK
 to config
To:     Dan Rue <dan.rue@linaro.org>, Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 8:31 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 26, 2018 at 09:12:16PM -0600, Dan Rue wrote:
> > CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y is required for fw_fallback.sh.
> > Without it, fw_fallback.sh fails with 'usermode helper disabled so
> > ignoring test'. Enable the config in selftest so that it gets built by
> > default.
> >
> > Signed-off-by: Dan Rue <dan.rue@linaro.org>
> > ---
> >  tools/testing/selftests/firmware/config | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> > index bf634dda0720..913a25a4a32b 100644
> > --- a/tools/testing/selftests/firmware/config
> > +++ b/tools/testing/selftests/firmware/config
> > @@ -1,5 +1,6 @@
> >  CONFIG_TEST_FIRMWARE=y
> >  CONFIG_FW_LOADER=y
> >  CONFIG_FW_LOADER_USER_HELPER=y
> > +CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> >  CONFIG_IKCONFIG=y
> >  CONFIG_IKCONFIG_PROC=y
>
> NACK -- the point of the changes was to *allow* us to mimic such
> configuration through a proc sysctl knob.
>
> You aren forcing CONFIG_FW_LOADER_USER_HELPER_FALLBACK but just having
> CONFIG_FW_LOADER_USER_HELPER suffices to emulate the_FALLBACK
> functionality.

Dan, again, you broke the whole point to the amount of work that went
into emulating testing. As such anyone testing their changes would
yield incorrect results.

> The issue here seems to be that *all* tests fail once a configuration is
> found which is not suitable a tests. With the shiny new proc sysctls we
> can test all 3 kernel configurations in one shot. Since we test 3
> different kernel configurations naturally some of these won't have the
> features needed, so that failure should be treated as non-fatal to allow
> the chain of other tests to continue.
>
> This issue was a regression due to commit a6a9be9270c87 ("selftests:
> firmware: return Kselftest Skip code for skipped tests") by Shuah for
> the verify_reqs(). We need to treat this as a non-fatal / don't skip
> return value.
>
> The following would fix this chaining issue:
>
> diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
> index 6c5f1b2ffb74..1cbb12e284a6 100755
> --- a/tools/testing/selftests/firmware/fw_lib.sh
> +++ b/tools/testing/selftests/firmware/fw_lib.sh
> @@ -91,7 +91,7 @@ verify_reqs()
>         if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
>                 if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
>                         echo "usermode helper disabled so ignoring test"
> -                       exit $ksft_skip
> +                       exit 0
>                 fi
>         fi
>  }
>
> However its not clear to me if instead we want some new special return
> value for selftests so that the framework can detect an that an error
> is non-fatal, and can continue. This is a tricky situation given the
> script, existing upstream kernel module, are aware of such emulation
> hacks via sysctl, but knowledge of this is not obvious to selftests.
>
> Shuah, how do you suggest we handle this corner case? If you are OK
> with the above hunk for now I can send a fix for it. In either case
> this commit was added on v4.18, so the fix would be a stable fix.

In lieu of any suggestion I'm going to request we revert this commit
and send the above fix.

 Luis
