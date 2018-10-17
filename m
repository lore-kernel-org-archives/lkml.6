Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA917C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69182214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXyJFRoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69182214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJQI4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:56:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQI4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:56:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so11682246pgv.3;
        Tue, 16 Oct 2018 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtfVJGuK3ZhO/8ZGeMlQEw2Z0tpYdlLRRC7H57ePNVM=;
        b=tXyJFRoOG8IFhdlaUFl8MLfczm7p2+zHhsYaTsQdSKRecGOjHW83oNRBptxM62xj7r
         mXHhxLlFNTZ83t2c00avWtqdJi1IaQAYYcXHEGZ+L4v0i5ek2H1sFjGIG6wR2+WbnX+9
         iYwuaSW+ioiEUgKASyqK9wJXWYq9EBf0pmMMdAfKcYf0xIVaIUM9VtEhq/lZ36Uuwifs
         LFK32bLEZXkhI/P9DmfN6mxns5cotGPeR0NkVH81R9ENTcEBHTe0ndtBllcW6Vk7oMpU
         WdibNnSSdoa/U16Txi/NaKbaXycJa4nPiKrl9L4v8XnND9BJC6wTI9aDB0wNPdw7sxs2
         81yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtfVJGuK3ZhO/8ZGeMlQEw2Z0tpYdlLRRC7H57ePNVM=;
        b=Sh0rCyGzyfdXUAkSUL+49g2MJMDexvHnL+J4SVsj/PNLJxpH0W3ed6QfrXdILlTWXH
         5xeUNAUJSm5PDVrOKMnrYE5GK6M+XodzjZ8gU+6Fdw0RD8Ran+rNm8+f04YskW6mXj4f
         itiAfLlhqj51t9LQAuLHz6/Qbs7FHxiDPoBvPr87IhARXJIXAAsypQEPYq2nPg5poZdQ
         RgtWE+rihBTlsaBxl8Ez+MPolF5fayLc3wGt3zvl3Xf+uATRyBLaLEmoPq9I4wEnt40G
         0GXQ4GC7koBpv8WaJkHvA8XbB6KiLu+noMfj/9ViH505bSC54NRBycPdZRrpHYp7zXMJ
         Yr2A==
X-Gm-Message-State: ABuFfog26FmRyOIjHFbWHC9iVWZW5khmHLuozt/6H1rjoZD++OltiHRR
        6kJGMxi1qLTxc7P4eg0B8Zg=
X-Google-Smtp-Source: ACcGV61KmQKeKQB5t/FZW9qLFSdTIo43kkGP+ayTBcRhCFdDLK8WM9hvuTgatTUNs+YpiZJ630ws3w==
X-Received: by 2002:a63:3e06:: with SMTP id l6-v6mr21155730pga.96.1539738189289;
        Tue, 16 Oct 2018 18:03:09 -0700 (PDT)
Received: from devbox (NE2965lan1.rev.em-net.ne.jp. [210.141.244.193])
        by smtp.gmail.com with ESMTPSA id c79-v6sm22799350pfb.147.2018.10.16.18.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 18:03:08 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:03:05 +0900
From:   Masami Hiramatsu <masami.hiramatsu@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Use colored output when available
Message-Id: <20181017100305.0b3c03461b098f8943805455@gmail.com>
In-Reply-To: <20181016130956.2be3b984@gandalf.local.home>
References: <20181016170220.31156-1-daniel.diaz@linaro.org>
        <20181016130956.2be3b984@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 13:09:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Masami,
> 
> Does this fix the issues you reported?

Yes, a half. We still need to strip out the escape sequences from
log file even if the terminal accepts colors.
Anyway, this fixes the "black character" issue for me :)

Thanks Daniel!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

I'll add a filter patch on top of this.

Thank you,

> 
> -- Steve
> 
> On Tue, 16 Oct 2018 12:02:20 -0500
> Daniel Díaz <daniel.diaz@linaro.org> wrote:
> 
> > If test is being directly executed (with stdout opened on the
> > terminal) and the terminal capabilities indicate enough
> > colors, then use the existing scheme of green, red, and blue
> > to show when tests pass, fail or end in a different way.
> > 
> > When running the tests redirecting the stdout, for instance,
> > to a file, then colors are not shown, thus producing a more
> > readable output.
> > 
> > Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> > ---
> >  tools/testing/selftests/ftrace/ftracetest | 29 +++++++++++++++++------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > index 4946b2edfcff..d987bbec675f 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -152,6 +152,21 @@ else
> >    date > $LOG_FILE
> >  fi
> >  
> > +# Define text colors
> > +# Check available colors on the terminal, if any
> > +ncolors=`tput colors 2>/dev/null`
> > +color_reset=
> > +color_red=
> > +color_green=
> > +color_blue=
> > +# If stdout exists and number of colors is eight or more, use them
> > +if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
> > +  color_reset="\e[0m"
> > +  color_red="\e[31m"
> > +  color_green="\e[32m"
> > +  color_blue="\e[34m"
> > +fi
> > +
> >  prlog() { # messages
> >    [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | tee -a $LOG_FILE
> >  }
> > @@ -195,37 +210,37 @@ test_on_instance() { # testfile
> >  eval_result() { # sigval
> >    case $1 in
> >      $PASS)
> > -      prlog "	[\e[32mPASS\e[30m]"
> > +      prlog "	[${color_green}PASS${color_reset}]"
> >        PASSED_CASES="$PASSED_CASES $CASENO"
> >        return 0
> >      ;;
> >      $FAIL)
> > -      prlog "	[\e[31mFAIL\e[30m]"
> > +      prlog "	[${color_red}FAIL${color_reset}]"
> >        FAILED_CASES="$FAILED_CASES $CASENO"
> >        return 1 # this is a bug.
> >      ;;
> >      $UNRESOLVED)
> > -      prlog "	[\e[34mUNRESOLVED\e[30m]"
> > +      prlog "	[${color_blue}UNRESOLVED${color_reset}]"
> >        UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
> >        return 1 # this is a kind of bug.. something happened.
> >      ;;
> >      $UNTESTED)
> > -      prlog "	[\e[34mUNTESTED\e[30m]"
> > +      prlog "	[${color_blue}UNTESTED${color_reset}]"
> >        UNTESTED_CASES="$UNTESTED_CASES $CASENO"
> >        return 0
> >      ;;
> >      $UNSUPPORTED)
> > -      prlog "	[\e[34mUNSUPPORTED\e[30m]"
> > +      prlog "	[${color_blue}UNSUPPORTED${color_reset}]"
> >        UNSUPPORTED_CASES="$UNSUPPORTED_CASES $CASENO"
> >        return $UNSUPPORTED_RESULT # depends on use case
> >      ;;
> >      $XFAIL)
> > -      prlog "	[\e[31mXFAIL\e[30m]"
> > +      prlog "	[${color_red}XFAIL${color_reset}]"
> >        XFAILED_CASES="$XFAILED_CASES $CASENO"
> >        return 0
> >      ;;
> >      *)
> > -      prlog "	[\e[34mUNDEFINED\e[30m]"
> > +      prlog "	[${color_blue}UNDEFINED${color_reset}]"
> >        UNDEFINED_CASES="$UNDEFINED_CASES $CASENO"
> >        return 1 # this must be a test bug
> >      ;;
> 


-- 
Masami Hiramatsu
