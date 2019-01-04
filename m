Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBF5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142CB2070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kccenyzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfADF7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:59:40 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39486 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADF7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:59:40 -0500
Received: by mail-yw1-f67.google.com with SMTP id k188so3598136ywa.6;
        Thu, 03 Jan 2019 21:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MfC7aBCkOCCz0Cq9hJDLGdjCert5YyjRHhIeE6ep/c=;
        b=kccenyzi/b+UGHQ7qmoxgmUaav1arBwflSLjw+c43e/+KVeHu7n7s11AJUgTRRVzKi
         uKdnSLchdJz+vPD7zSGHLYCKLUmATuPR09mGLCQ6u3yjF1kHTLXwzpYiKkclvy+ce/IO
         IQ8Jffc1NNHDG4VRY7DXpByC7OyaqkwByQXc387ZT8O07wJ5K4Glw2+D0/9GN5+ZbdhK
         gNSn/4iLRb6QslY7Zm1UGcVazfSYmVD2YxaKutlLr49abwkA6u9ABfqha5tTp1zpC5po
         /qg/qKiNyYjDjUncoVJhxubfneRpVl3lJK37b6DwRRxNyUvbW4EaJygDFFSFcapIh3wY
         q8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MfC7aBCkOCCz0Cq9hJDLGdjCert5YyjRHhIeE6ep/c=;
        b=iMluf6BDJ+eCvzru8AwQQAhBKyD2D1C6m/8BihFpzNxg/ygpmipiQa82M7dXfbSwP0
         /oPll9qPlf7WVYhMGnRDhyi5Z+eMbR9pkl/utNKcNLTaXh7IylFxkpBeHFd2wjjYzz6l
         Ecgwce+1gMoxW7U22E1/ZvFwukSqpYjVKJDsJ5kI5DM6Px4gXSdsQTPSSfhjT6lqeZ1K
         rZjuwQQstCfySbQ1H9x/bqKdWaSG4usePYhEYtbdC20aeNK9cVqAOBlOWnQ0jKjiEZ1T
         6lnab1XXSo0KujhgCD0rkDtf+/v/xYXl9tnffzV7Uof5tmsewEft9SF9ZWGHa34DcbFd
         /vQA==
X-Gm-Message-State: AA+aEWaokh3+7CT1l9as1XEKrOkYbv+cb0kNi/dKvoxsEFBEASlOdti/
        GlU1KJMbzkYNIJDmTsFfYRGFc+PMBgssWGCmtKs=
X-Google-Smtp-Source: AFSGD/XGQqWYv43vbCFgtuBLHn3uIFfAhbFRikH6WMDa4rK1/gpaNk8602Int59NopPqN8ubjBNubTjKFUBd1oeq0Us=
X-Received: by 2002:a81:3217:: with SMTP id y23mr50668172ywy.275.1546581579395;
 Thu, 03 Jan 2019 21:59:39 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-3-git-send-email-firoz.khan@linaro.org> <CAMo8Bf+qK=k33boeNOeL69sLC3e-M07QK9ErhYm-byuQ2UnVnw@mail.gmail.com>
 <CALxhOnhgAEeEFhL2fgjDSCBMJo7dF5jiuGKCXjWYjMJmHefMgA@mail.gmail.com>
In-Reply-To: <CALxhOnhgAEeEFhL2fgjDSCBMJo7dF5jiuGKCXjWYjMJmHefMgA@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 3 Jan 2019 21:59:28 -0800
Message-ID: <CAMo8BfJi-CLHHy1CWGZ_KhP2ddZxxHM+CafkjJRd=cC35aNF8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: generate uapi header and syscall table header files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:13 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Fri, 4 Jan 2019 at 04:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > >
> > > +quiet_cmd_sysnr = SYSNR  $@
> > > +      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'         \
> > > +                 '$(sysnr_abis_$(basetarget))'                 \
> > > +                 '$(sysnr_pfx_$(basetarget))'                  \
> > > +                 '$(sysnr_offset_$(basetarget))'
> > > +
> >
> > This patch seems to do more than it says in the description.
> > Perhaps adding cmd_sysnr needs a separate patch with its
> > own description?
>
> This build rule is unused now as I was tried to implement
> something else. Hopefully I'll remove the the above change
> in my v2.

Then maybe there's a way to move all these macros to a common
makefile, as they seem to be fairly generic?

-- 
Thanks.
-- Max
