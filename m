Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EEF22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po+tcOA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EEF22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbeKMV1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:27:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41028 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732474AbeKMV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:27:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so12894106wrt.8;
        Tue, 13 Nov 2018 03:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rTW73qYJ/aWKFFWnPXk/DDJ1tgIipnHj3ggkUcdZ2rA=;
        b=Po+tcOA2cLqTULPONZ/OTouM6rNmG4Kf82pr6UG0/Vm83SYLU06gDX3lXB4QoadI4/
         khWwbnyWcMN+bRM0G38zAMgbggYelymgvSL48Kz9auEOA/di7jhDBl/HJWB4RG4tnP9w
         8w0SXzMnl1DG0Etrc/+3x+JzXZfIQKNsny0DFtoFSlcNIwADMR9qYY11kB5gc7vnmBgN
         pJ0TAP+EpXtAhJRR7nMdaKmHGZmcIrPrWc0Goyc5aqNRAzMHLcKozqx55+K6ivoOrDo9
         iecZpSrhtVI4ithjONyv5h+L1izUqOtLG8e3klhUn/PbxRHE2wOnALl9jNEMZL6ha1e6
         35oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTW73qYJ/aWKFFWnPXk/DDJ1tgIipnHj3ggkUcdZ2rA=;
        b=PytXzdAtMM5xAgivVwEEgkvg0ERM9iZh8LrpLdmFyMEwKbXU+HJN4MgM3O4b+ZXfOP
         tASYG2Ueag4QYLNXZ8MNvp/fzJJ6vjE6aPpJCC7lYG/I0Y29lmJGIZwnqMM/hfimDpYg
         g7FqdI68xwpqtEB4/hPn6QQ++Ibkw4MnKEiNvabXUCG4/+a5P4r9UrZMC+OTHIL4Kpyk
         So4N/sLf4KvAaV8oXPsR0hRIjUw1r/oiUfrGV4dPGlAY31IggI8KOJp8S67Ut/rwmJYT
         c3iPB5OXBmps4PCHLuVibry1RWy4uBqDR7c0ex3I1eZEHOmg+H6kk3lCwkKpUGilIP8I
         AuMg==
X-Gm-Message-State: AGRZ1gI6fl2cAQ+hGW4dUmMXl/LKpQsn7pmCFJ2+3PAS/e8FpARZwVYS
        x25gACqWViKPvNsqmQ6CTwo=
X-Google-Smtp-Source: AJdET5d674uU83sqC0kCHDImbUwpGRbhzVLYgOwCKCYDpWk7HIwL+G3qlq3WN3MijIeTkMcXC6M/+A==
X-Received: by 2002:adf:83a4:: with SMTP id 33-v6mr4541422wre.13.1542108603083;
        Tue, 13 Nov 2018 03:30:03 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z3-v6sm10173300wma.6.2018.11.13.03.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 03:30:02 -0800 (PST)
Date:   Tue, 13 Nov 2018 12:30:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
Message-ID: <20181113113000.GB4788@gmail.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112150215.508-2-namit@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> Introducing the use of asm macros in c-code broke distcc, since it only
> sends the preprocessed source file. The solution is to break the
> compilation into two separate phases of compilation and assembly, and
> between the two concatanate the assembly macros and the compiled (yet

s/concatenate

> not assembled) source file. Since this is less efficient, this
> compilation mode is only used when make is called with the "DISTCC=y"
> parameter.
> 
> Note that the assembly stage should also be distributed, if distcc is
> configured using "CFLAGS=-DENABLE_REMOTE_ASSEMBLE".

It's a bit sad that we regressed distcc performance ...

> +# If distcc is used, then when an assembly macro files is needed, the
> +# compilation stage and the assembly stage need to be separated. Providing
> +# "DISTCC=y" option enables the separate compilation and assembly.

Let's fix the various typos:

  > +# If distcc is used, and when assembly macro files are needed, the
  > +# compilation stage and the assembly stage needs to be separated. 
  > +# Providing the "DISTCC=y" option enables separate compilation and 
  > +# assembly.



> +cmd_cc_o_c_direct = $(CC) $(c_flags) -c -o $(1) $<
> +
> +ifeq ($(DISTCC),y)
> +a_flags_no_debug = $(filter-out $(AFLAGS_DEBUG_INFO), $(a_flags))
> +c_flags_no_macros = $(filter-out $(ASM_MACRO_FLAGS), $(c_flags))
> +
> +cmd_cc_o_c_two_steps =							\
> +	$(CC) $(c_flags_no_macros) $(DISABLE_LTO) -fverbose-asm -S	\
> +		-o $(@D)/.$(@F:.o=.s) $< ;				\
> +	cat $(ASM_MACRO_FILE) $(@D)/.$(@F:.o=.s) >			\
> +		$(@D)/.tmp_$(@F:.o=.s);					\
> +	$(CC) $(a_flags_no_debug) -c -o $(1) $(@D)/.tmp_$(@F:.o=.s) ; 	\
> +	rm -f $(@D)/.$(@F:.o=.s) $(@D)/.tmp_$(@F:.o=.s)			\
> +
> +cmd_cc_o_c_helper =    							\
> +	$(if $(findstring $(ASM_MACRO_FLAGS),$(c_flags)),		\
> +		$(call cmd_cc_o_c_two_steps, $(1)),			\
> +		$(call cmd_cc_o_c_direct, $(1)))

There are various stray <space>+<tab> whitespace noise errors in the 
chunks above.

Thanks,

	Ingo
