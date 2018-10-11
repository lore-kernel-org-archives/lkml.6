Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA71820644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVU2Qg3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA71820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeJKQCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:02:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45818 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeJKQB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:01:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id d9-v6so3283146ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MRRNidPAV1dgo6qiu9TtpewOrE8KOgOgk8M2Ca9G9w=;
        b=NVU2Qg3ymzw2q6JcQ+veQx6CSxIPJ+Zv0c89+8kxdrFSMcwihbTKQgtOUnjDQJjPdS
         ai5A+zPjbALwy/7ndOzx4Xcrx+4/v/NsPI0aFj52udpMWHFcmxw8Yb9xTd96y7No4Op5
         cFrHCJA8qo7lIqnyzQD9nKNp1qCEPWvp6gcJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MRRNidPAV1dgo6qiu9TtpewOrE8KOgOgk8M2Ca9G9w=;
        b=G1XaMmuZDT9dA3/HVPzkLzo3hCthE/UVn61u7OavfzQWo9c2DbM0SmPW78G87uOfz6
         c3k0cgv+3yjSU+awlxYn6oywWqXAAluejQrhzpXl1Nvg6AE4Tse50fyFNAjCmUe5DoRL
         k0uchgEcLQ4/A1QVPYXhoKinUW1VNnFwLWvDQ9GzW1Ol6XRqu/RR9O/wfEV2LBDb9QnH
         5hSj+lzdgRYCWAkoGgp5txeTLe0yBNcG9sYP6eG+end3xEbaf5ce15BtIjq2w90JQ92R
         OB2nH7KYI7NiOwPe68Ot9f8Y5tWCbx6lryNwGhJfN4PVssI3DGeVQXnEAqnz0X85hSRL
         5Qjw==
X-Gm-Message-State: ABuFfojf7o8kqvCheru6USyzo8fNWLTxeO/srzwl7AhlnTJhSYEdB5Xi
        jjeTNrn4q75C/Uj/bWyK5DmN3t8sdYpLixEswRFGcQ==
X-Google-Smtp-Source: ACcGV61gAyjXNUZO3SHXG1KMz61ql2uWU1Y4nTbaLZ9Kh8RWzyaSlgS6ToepopwGU8Mn8QBJhp489P5K5wEu1I4aCvw=
X-Received: by 2002:a25:9709:: with SMTP id d9-v6mr260820ybo.77.1539246944095;
 Thu, 11 Oct 2018 01:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <1539231895-4118-5-git-send-email-firoz.khan@linaro.org> <CAK8P3a2JdFnAQcZ9YSOkEC_Od4QeLLP0RcWkte5MHC6VSXi0qQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2JdFnAQcZ9YSOkEC_Od4QeLLP0RcWkte5MHC6VSXi0qQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 11 Oct 2018 14:05:33 +0530
Message-ID: <CALxhOni9LxYWGzKRdc6iNmr6d1CuXj_dLj4CBJeswT13zziEsQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] ia64: replace the system call table entries from entry.S
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 at 13:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 11, 2018 at 6:25 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > In IA64, system call table entries are the part of entry.S file.
> > We need to keep it in a separate file so that one of the patch in
> > this patch series contains a system call table generation script
> > which can separately handle system call table entries.
> >
> > Replaced the system call table from entry.S to syscall_table.S,
> > this is a new file. This change will unify the implementation
> > across all the architecture and to simplify the implementation for
> > system call table generation using the script.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/ia64/kernel/entry.S         | 333 +-------------------------------------
> >  arch/ia64/kernel/syscall_table.S | 334 +++++++++++++++++++++++++++++++++++++++
>
> According to the discussion we had on the same patch for parisc,
> I suppose we can skip this one as well now, and just remove the
> entries when the generated table is added.

Sure.

>
>        Arnd
