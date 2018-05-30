Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932404AbeE3Uv7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:51:59 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:39008 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932337AbeE3Uv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:51:56 -0400
X-Google-Smtp-Source: ADUXVKK4k7H8tPpZi7FYwdeS947Dj0uCkXdhRyBqXkgqSwthQRhI48wbb52oWDg5byrdMeVgORHeCj2ivsxRH9MD+g4=
MIME-Version: 1.0
References: <000000000000457b2d056cbb0044@google.com> <20180522123107.GC3751@bfoster.bfoster>
 <20180522222620.GW23861@dastard> <20180522225208.GB658@sol.localdomain>
 <20180523074425.GM14384@magnolia> <20180523162015.GA3684@sol.localdomain>
 <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net> <20180523234114.GA3434@thunk.org>
 <20180524004931.GB23861@dastard>
In-Reply-To: <20180524004931.GB23861@dastard>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 30 May 2018 13:51:44 -0700
Message-ID: <CACdnJutbRW4wV7QAwS9s-=p1dd7mYkHqEX1NBkEXiD+oBV3-xw@mail.gmail.com>
Subject: Re: Bugs involving maliciously crafted file system
To: david@fromorbit.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, sandeen@sandeen.net,
        ebiggers3@gmail.com, darrick.wong@oracle.com, bfoster@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 1:42 PM Dave Chinner <david@fromorbit.com> wrote:
> We've learnt this lesson the hard way over and over again: don't
> parse untrusted input in privileged contexts. How many times do we
> have to make the same mistakes before people start to learn from
> them?

You're not wrong, but we haven't considered root to be fundamentally
trustworthy for years - there are multiple kernel features that can be
configured such that root is no longer able to do certain things (the
one-way trap for requiring module signatures is the most obvious, but
IMA in appraisal mode will also restrict root), and as a result it's
not reasonable to be worried only about users - it's also necessary to
prevent root form being able to deliberately mount a filesystem that
results in arbitrary code execution in the kernel.
