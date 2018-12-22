Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA102C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DF121983
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545497477;
	bh=FrNJM1BIyA1S9dfC4d+KVdiG/ARg4H10T+4zgJenNGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zY4BMQKFgkGUreA/knsQgT1/anPYt1/M7nESw3KrgKRZ6vEHFnflaiqmF9QNQ+367
	 DAePClyQt2h3lHJouPMENxrvM2rezsdgxWXaSNs9qt3qYHvYztMEoYwaHUwU5mf3au
	 Ll53LovdTXylXBdOMSX5reyrjjJCT/QhXmSwJO6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392291AbeLVQvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:51:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44384 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLVQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:51:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so3884281plt.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qyb/zR9lRaLZjiAGxrIel8/0+W94M3LEUVIwmJA6Z+g=;
        b=u9mB75ksHzu2NzvJtfn4wyodLlvd08yUvVLq19LQIeYliT1E7QC5mrqXQhFR/1LOdR
         Y4AhXQCcF//4TcH0tgaYuM7+iRYXCgvhi1TCDbDmP71D6JXRGSc4kIYilcTMoVM7vOfO
         athYm5i2FbnklpB2X6mRW4fBYQN1FjSgZSBYKPbT40WACY1fv8wYP0Zn49yxbBjwVAz4
         oIRKBOE2Vh+ntd6Wop20HxHo4A8ANkKwX+BPw5WjApXoAMc5om0sDPbVxF+6obQf2xnf
         0eKLJSmVbiUJlfMBbujZa1egUQV3AeDPmvMeEYYusuIxbsolnbYDV9Tqoghp/gxf5/qm
         Yv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qyb/zR9lRaLZjiAGxrIel8/0+W94M3LEUVIwmJA6Z+g=;
        b=sHkgaGhK5Du1JicX5CyhP8YkJQ8MFab1FE1PXcd91RfRCJYFKNty0MRfLmxb/OzYHH
         ZCoBonm4/eNuas3+tbs+plJl4ay38VzEW4GQAEcAujYNrWcl4sD85EzhwscuzZGEi1v8
         HI6mSID3tmcsbYlmfiy1maFLKrw5ZfcPPRqO945fLVVnBiIXNUi3FH1qJGWIpaN5ng+w
         z4/tOHF/ViIXyIFYkjswI6LMiGN0Z4OFHa1ZAh5K+WVb7M3iKUJ36+Yg2Fv5RHON9NVM
         iV9hVK86Kx+u0qNfsUIunxJl1J/E72p2mlW5DHl/Y8YwFLdLP4YUavvVOAFOEQUpK8kA
         wS5g==
X-Gm-Message-State: AJcUukcGOyyCWWSzvxhSLhMT1cBusMQZpXrFWIGl1SvT66PZhxpF7skk
        w6Ssx361peV3g7B5VJIbKOBirPc9
X-Google-Smtp-Source: ALg8bN5uXAGyjoC7ik3+YZIjO7QJt53mI+WJnXETWFrmPqQNEpReOY4DBXcVE3J3rQGDvxd0kJUSMQ==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr5951398plt.101.1545471232738;
        Sat, 22 Dec 2018 01:33:52 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id u70sm44618493pfa.176.2018.12.22.01.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 01:33:52 -0800 (PST)
Date:   Sat, 22 Dec 2018 18:33:46 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, kernel-team@lge.com
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181222093346.GB7610@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221231924.4583e90b@vmware.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:19:24PM -0500, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> A discussion came up in the trace triggers thread about converting a
> bunch of:
> 
>  strncmp(str, "const", sizeof("const") - 1)
> 
> use cases into a helper macro. It started with:
> 
> 	strncmp(str, const, sizeof(const) - 1)
> 
> But then Joe Perches mentioned that if a const is not used, the
> sizeof() will be the size of a pointer, which can be bad. And that
> gcc will optimize strlen("const") into "sizeof("const") - 1".
> 
> Thinking about this more, a quick grep in the kernel tree found several
> (thousands!) of cases that use this construct. A quick grep also
> revealed that there's probably several bugs in that use case. Some are
> that people forgot the "- 1" (which I found) and others could be that
> the constant for the sizeof is different than the constant (although, I
> haven't found any of those, but I also didn't look hard).
> 
> I figured the best thing to do is to create a helper macro and place it
> into include/linux/string.h. And go around and fix all the open coded
> versions of it later.
> 
> Note, gcc appears to optimize this when we make it into an always_inline
> static function, which removes a lot of issues that a macro produces.
> 
> Link: http://lkml.kernel.org/r/e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com
> Link: http://lkml.kernel.org/r/20181219211615.2298e781@gandalf.local.home
> Link: http://lkml.kernel.org/r/CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com
> 
> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggestions-by: Joe Perches <joe@perches.com>
> Suggestions-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> 
> Since I haven't heard anything since Linus said he preferred the len
> to be the return value, I'm posting this last version before running
> it through my tests.
> 
> Changes since v3:
> 
>   - Use size_t instead of int (Joe Perches)
> 
>  include/linux/string.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 27d0482e5e05..7927b875f80c 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -456,4 +456,24 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
>  		memcpy(dest, src, dest_len);
>  }
>  
> +/**
> + * str_has_prefix - Test if a string has a given prefix
> + * @str: The string to test
> + * @prefix: The string to see if @str starts with
> + *
> + * A common way to test a prefix of a string is to do:
> + *  strncmp(str, prefix, sizeof(prefix) - 1)
> + *
> + * But this can lead to bugs due to typos, or if prefix is a pointer
> + * and not a constant. Instead use str_has_prefix().
> + *
> + * Returns: 0 if @str does not start with @prefix
> +         strlen(@prefix) if @str does start with @prefix
> + */
> +static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
> +{
> +	size_t len = strlen(prefix);
> +	return strncmp(str, prefix, len) == 0 ? len : 0;

As it already knows the length (and it needs to use it for return
value), isn't it (slightly) better using memcmp() instead?

Thanks,
Namhyung


> +}
> +
>  #endif /* _LINUX_STRING_H_ */
> -- 
> 2.19.1
> 
