Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F3ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E4521473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQtlciUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E4521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJRKEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:04:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37595 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeJRKEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:04:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so28278367oth.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 19:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXqDoljyPiAGf8azecab2KuGNZbnO9MYXBF4o5v8oDM=;
        b=mQtlciUYOT3CUMvkvIkZ02T6fVcjtBDUlWJtHzWrJl9l5NJGG+woLUdW03Ochke8Sk
         T/Xo8TzWlQCm1hl1JO6EHC5AuPnIT/hzTyBlB2LRT6C6FDlxaEfU9MvVyuPU6FAyOOsg
         MHR8lXs9FM4HKjht8SKXc37gwJ19Y1ZYw2Vm7vprTgiq9iuvfaxPu42HtIDWlmdzIxWL
         31KleoB5qP6KqgK1FwIeoXOYkcLme6KBFAQiOi83UidwDYubJIi9kcFiwrUOR6qjfKXl
         QtrF32ExAYDmgIwE2N3Ua44bqQqg1xrC31lNIJbTIYC3igoZxwQgmkdTpIXPsC71Mqq3
         kFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXqDoljyPiAGf8azecab2KuGNZbnO9MYXBF4o5v8oDM=;
        b=IAi6h8Nh6NbTy4c8TLwDT6tAo3vzgae588G+DPOYYLuMIt2x4SKxQYECoTDU/xL4k/
         TmInMrHph06vUxDi01sZOpuoctMeRIJJ4sktooAbQiGPdZub6owOUihThscN7m2bAKY4
         hSqzlaJtCFFdJtRa5Id5BFLf/pV6PXcXeY+s04J6DEWaN9BhQV6RXekkL8pyfQgIQbiR
         ihCRDBXlTpcpqEA8VRh5wgB7gety93EYFyQr0LfdSL32de8XJ4wGLUODdzE5hDBlokCe
         /EfSXfsIC/gVr3IO9Y6RPAk4V6Zha1g875jLlPOecTQbYeUFmO6j0ihY5PWM7QdqcEyI
         bCxQ==
X-Gm-Message-State: ABuFfoh83nHWycPYJWcbePewdo9c3pbmNxR5/iiigENNvrhze0H/1l8S
        XPOSz6aszpT1H7kPe9F6//rdfDWKCG1KHgrg7XT9Wenu
X-Google-Smtp-Source: ACcGV60ArT3LpFuNR65QC3yp51UNMQjRFeZwIHtPAx0rTOxv/ZBqP352yYcP4h70CV36tKhj+g1GckKkW1TwKensYBU=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr17346130otb.230.1539828361129;
 Wed, 17 Oct 2018 19:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com> <42737f55-0d42-dffe-7b34-e24666e713a0@infradead.org>
In-Reply-To: <42737f55-0d42-dffe-7b34-e24666e713a0@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 17 Oct 2018 19:05:49 -0700
Message-ID: <CAFd5g440GaxOzii9pXF6ykmeT3ihUFduG8EpbRXCMpTLROPhtQ@mail.gmail.com>
Subject: Re: [RFC v1 00/31] kunit: Introducing KUnit, the Linux kernel unit
 testing framework
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 4:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/16/18 4:50 PM, Brendan Higgins wrote:
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
>
> Hi,
>
> Just a general comment:
>
> Documentation/process/submitting-patches.rst says:
> <<Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.>>
>

Thanks! I will fix this in the next revision.
