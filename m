Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbeBESzA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:55:00 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39303 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeBESyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:54:35 -0500
X-Google-Smtp-Source: AH8x227RktE7dSS0iE5x1jFizVBieH5269NRO9eDR0Azp75gQkEDw0Zb1m4b7SXUPbOYqt+ZTLKVFN6MBom6be0fTfs=
MIME-Version: 1.0
In-Reply-To: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
References: <1517840166-15399-1-git-send-email-will.deacon@arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Feb 2018 10:54:34 -0800
Message-ID: <CAPcyv4hd1sfYtwFdup8TLiJQCw_J3sUhOB2fEUW2Tr__Nyg2mw@mail.gmail.com>
Subject: Re: [PATCH] nospec: Move array_index_nospec parameter checking into
 separate macro
To: Will Deacon <will.deacon@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 6:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> For architectures providing their own implementation of
> array_index_mask_nospec in asm/barrier.h, attempting to use WARN_ONCE to
> complain about out-of-range parameters using WARN_ON results in a mess
> of mutually-dependent include files.
>
> Rather than unpick the dependencies, simply have the core code in nospec.h
> perform the checking for us.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Looks ok to me and produces the same assembly.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
