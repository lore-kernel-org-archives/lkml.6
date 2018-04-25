Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+lTTYq7vKsn9UvVcWAmbFvs30MQwpEymdMElfI8Dkrxy3qS7lamO8b87ABF4YfF/5Gec6d
ARC-Seal: i=1; a=rsa-sha256; t=1524670025; cv=none;
        d=google.com; s=arc-20160816;
        b=LFEEvfOQtU+uWuPs4lhoOHJkakZGkg5eqTTFjl50K527ky4cpKN75RrzCpcX0uNJFd
         TU19bpeJj9RFWwvyp2HrkQRNe5rL8sXHdO368IcRGCO8JCJbckX9CaCAycfM0vlpphqm
         /2+g+UQRkOa1xSf3nIcR8LhJgP8tvHSuB3fu9CLhA8vUxamG2IQHMjEOFbfR6kaqXJpn
         tnprdw6g9wtn3OJt7gQuTxqN2I0PiRrQMdX/+/FaaWgc+wwLL1WlOZOW1XKk6afOGWrm
         wIUj95jNOlvotjeQ+utdgyeEfx4IBaba87V61Y99NZ11iYmIpo9jHDCQY0vJShlADYY8
         fWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=sWvrBzZd1bhP2WEbVWTglYQMmBR1Zs4mOJXBSdsWW1k=;
        b=Xi//0ihOpkh15w88LDRRgEtuEjUi7QlMUO9dx9vf36oYcU78enPAQodi9M57U8PhwV
         YRTABoJIGKyMGMcHIm0MK3L1YU8+u/HVNJ//NLQfbrszJ9WMLMTLbhjwA9l2Lf//GR7X
         evmUmWYziKRd0HJXJS7/Cc+Tldv1vD8cfqa2LcfngYKRglnRCSgxbGK5qCzbU4KXZ1NN
         /ZQoF5jvZwa9IzIkonNEeRko8pmg7wFtk5TcI10FZK00nNwHXdc6IvnLkJ4k5EgtQoVT
         yrktasU0NYdIIqoNiP+3TRsGR/ao4yIpxkOZpGRCITthYQLcu5eVFOtwXf/FGi8PhRhz
         jMPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbeDYP1F (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 11:27:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754630AbeDYP1E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 11:27:04 -0400
Date: Wed, 25 Apr 2018 17:26:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>,
        Jeffrin Jose T <ahiliation@yahoo.co.in>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK"
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: Re: [PATCH] selftests:firmware: fixes a call to a wrong function name
Message-ID: <20180425152657.GA5139@kroah.com>
References: <20180423141022.5019-1-ahiliation@yahoo.co.in>
 <CAGXu5jL0FKq=_fESYT78_LPOVYQ4MsPHQ6u_RgFBJa4fzNN3rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jL0FKq=_fESYT78_LPOVYQ4MsPHQ6u_RgFBJa4fzNN3rQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598546450187595839?=
X-GMAIL-MSGID: =?utf-8?q?1598732397080707618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 09:39:02AM -0700, Kees Cook wrote:
> On Mon, Apr 23, 2018 at 7:10 AM, Jeffrin Jose T <ahiliation@yahoo.co.in> wrote:
> >  This is a patch to the tools/testing/selftests/firmware/fw_run_tests.sh
> >  file which fixes a bug which calls to a wrong function name,which in turn
> >  blocks the execution of certain tests.
> >
> > Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> >
> > ---
> >  tools/testing/selftests/firmware/fw_run_tests.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
> > index 06d638e9dc62..cffdd4eb0a57 100755
> > --- a/tools/testing/selftests/firmware/fw_run_tests.sh
> > +++ b/tools/testing/selftests/firmware/fw_run_tests.sh
> > @@ -66,5 +66,5 @@ if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
> >         run_test_config_0003
> >  else
> >         echo "Running basic kernel configuration, working with your config"
> > -       run_test
> > +       run_tests
> >  fi
> 
> I find it confusing that run_tests() uses $1 and $2 but later ignores
> them unless -f $FW_FORCE_SYSFS_FALLBACK, which is checked at both the
> top level and in proc_set_*_fallback()... I'd expected the test to
> happen only in run_tests() and have it removed from from
> proc_set_*_fallback().
> 
> Regardless, the above patch is correct to run the tests. :)

Thanks, I'll go queue this up.

greg k-h
