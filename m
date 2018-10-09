Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7840DC65BD7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A630214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qe4UXvTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A630214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeJJFaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:30:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45698 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:30:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so1531515pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o4TYvoO88LvQpX4BrPrq3xfIUSnUOO0k84kAP8T/g20=;
        b=qe4UXvTLt1Dovekp2e6sfCc1K4VMdymoZS9LBw7b3hQOsizdV4qLCWCaQfIfSbr9f+
         S6qiVM3nF5+7NObXK0yOxvv5HUw8Ln+nRVqgCWS5oZmuq5hJsxbQxJi50u+2jSv4MrVk
         W7pjSQSZjFn+smYqQe5M0AB1ZetG7EXR8JOYhczEHdBaeEJfrC23TQt3XEW4Up1PxfJc
         ZhlJAh8XYOWF6yy5SFdYCREDRHE6xZ5OyGyO6qA13p8kUT+5Z+T6lRtYKzVDbdvyPGX4
         kFQZc26y2vaMBRcfz4UELDxx9bpc/hVtUHhsqukOCrWDhC8SMgMsEGFIONeRjcI6Euin
         D75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o4TYvoO88LvQpX4BrPrq3xfIUSnUOO0k84kAP8T/g20=;
        b=CA4tvP2K6fsIMaBHBu3mRX5hOkTj1PB2JFsv5WzRdKdwFTZMJ7efA2qNqhS57gGjZS
         sG3sISdunllkdnMKAI56DZsJAOw71CAB0auCPsUWE1KLkfStj6kiLGFAPun1F46S4sz5
         WnD0eLRPZZCE1FTa1rNdeIVVKerd5L3/OB4TOPJi1bFlFV0O1f+PRp628avhMnklCxPI
         YirajlDVoqdaPlrAvg83tdo0IzinYGfpQHiloZgjsz51zEytLJiSnfwQDWFDZb+SRx3C
         Fgo6UgVcP+hqUydxqCowyJ7nuguQyEj6gQbMCcPdn1gEwZ5PRP0PTvJ9oTfgToVXXyOv
         /QDg==
X-Gm-Message-State: ABuFfoioc/Ce9oOxncWRjuwXiOo5TeW2x5Wnv/dyEQzbQl+GM3Se6y78
        hAek/SEIjevDALizy6yz1vqjdIRI0400LE9/K5TOsw==
X-Google-Smtp-Source: ACcGV61g0otoB0IqtbkFEL0IJO7aE1ezg/qVx9CM+Eaj2ddvYVXaOc4nJcL4DQpJX/EaVDo4KyVTBnu0kQsfsHrPoQQ=
X-Received: by 2002:a65:4882:: with SMTP id n2-v6mr26084917pgs.225.1539123110476;
 Tue, 09 Oct 2018 15:11:50 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Oct 2018 15:11:39 -0700
Message-ID: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
Subject: undefined behavior (-Wvarargs) in security/keys/trusted.c#TSS_authhmac()
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I noticed that compiling with
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
and Clang produced the warning:

  CC      security/keys/trusted.o
security/keys/trusted.c:146:17: warning: passing an object that
undergoes default
      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
        va_start(argp, h3);
                       ^
security/keys/trusted.c:126:37: note: parameter of type 'unsigned
char' is declared here
unsigned char *h2, unsigned char h3, ...)
                               ^

Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
standards explicitly call this out as undefined behavior:

The parameter parmN is the identifier of the rightmost parameter in
the variable parameter list in the function definition (the one just
before the ...). If the parameter parmN is declared with ... or with a
type that is not compatible with the type that results after
application of the default argument promotions, the behavior is
undefined.

So if I understand my C promotion/conversion rules correctly, unsigned
char would be promoted to int?

We had a few ideas for possible fixes in:
https://github.com/ClangBuiltLinux/linux/issues/41

Do the maintainers have feedback on these suggestions or a more appropriate fix?

Note: https://www.gnu.org/software/libc/manual/html_node/Calling-Variadics.html
and `man 3 va_start` mention more about promotions, but just for
va_arg, not va_start. But the standard seems explicit about parmN
which is passed to va_start.

https://www.eskimo.com/~scs/cclass/int/sx11c.html is also an
interesting read on the subject, which states: `Finally, for vaguely
related reasons, the last fixed argument (the one whose name is passed
as the second argument to the va_start() macro) should not be of type
char, short int, or float, either.`
-- 
Thanks,
~Nick Desaulniers
