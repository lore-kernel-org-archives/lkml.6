Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD005C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F68720862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OrvO/Pyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F68720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeGaSKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:10:39 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35885 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbeGaSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:10:39 -0400
Received: by mail-it0-f45.google.com with SMTP id p81-v6so5226943itp.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3hCeX0kaZSBzqUGORcpaei11sRWFKwXi214q+E0cL8=;
        b=OrvO/PyfiedmAfb0GX7UYd/+Rt2M8hzrNa6q+coF180sK5AxCA9wJTeXJIxTVoXmXe
         DGlMJ3bgF6hnxfs15r05fqSO+h6iv8YrLHkqUrtmDaQHJdoUO4kqAnbojLhkv58yGpk9
         dNZWwNeWeyV/qSP1z2ZW1uqdPhC5yaQmkGXeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3hCeX0kaZSBzqUGORcpaei11sRWFKwXi214q+E0cL8=;
        b=QINxgO+mwB0Rq3oXo90t9B3/KF350bWTA8gfqBj4WIrBRY4hObWLWJRB6hWMBL/HxT
         id7NBZbax2aqhxpWGuNyoNF9nw/3zMjk8VAVZ2J6lkjKWV6g0fJUHcPQphqzWcX6GzdJ
         6j4YHCpDgQ1ubpRb6goKIRWYhRhWKo+ObbIILsUH73d2PzReUHhIFTwFFuJB28LM4H6G
         ZZ9BH68kPUFvzxXlcieku2QPVZXegyJuivK2n9AHNxBD0jwjt5OBWPpJsqJcn7vPMYl9
         1E+XQqnS1DSFuYGT+hLz1BdMpnISRPJvbUugLzisedXcwsn6AmVph5W2H2fkQE3XCaUi
         lZzA==
X-Gm-Message-State: AOUpUlFfwjKhBxJgRiSYrh88fEgIN4V9nRL2qqEN/vaiMBvDTEFDgy57
        h2aClOtldgzHYEg9xeQL5Q6ja9wwyDY9oyPPlo4=
X-Google-Smtp-Source: AAOMgpeVcyCyVW2OVFo+lDz1t7MCfANxRnHT6Mbr/Q/joBVoneWFnnyJDulInBpvVatkCZe7Tbm61jy6MVcASBa6dZA=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr356654ite.1.1533054573486;
 Tue, 31 Jul 2018 09:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
In-Reply-To: <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Jul 2018 09:29:22 -0700
Message-ID: <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:40 PM Amit Pundir <amit.pundir@linaro.org> wrote:
>
> This ashmem change ^^ worked too.

Ok, let's go for that one and hope it's the only one.

John, can I get a proper commit message and sign-off for that ashmem change?

Kirill - you mentioned that somebody reproduced a problem on x86-64
too. I didn't see that report. Was that some odd x86 Android setup
with Ashmem too, or is there something else pending?

                       Linus
