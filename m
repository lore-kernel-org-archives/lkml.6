Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC366C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870F1217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoUV2ZHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfBSCNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:13:00 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45643 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfBSCNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:13:00 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so31611736ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsYNrd7gsjwoexzhJ7EgUb25vTqg/CQaLGiDhKUAECQ=;
        b=uoUV2ZHtp8+zUBRtHnyApkUEiaL1LCjeAowsypeyHOw/cZk8K9uYcxYw2nV5nvdwGJ
         vj7IlgDqh/VAsySIS23Xs4KuPjX+8rQANfmHY0IRy7Wf9mchaYK9Wsx/7ORrcl7M1D3K
         iOVc3PJ6H6gf9dDRjdlcediOrNDO4EAzMkLK3pFkNMus/V2Eyv1A0LzYRAR6tsajgkOK
         SvuPgRzP+2RUWvJohR5QyMz3y4bPMQinI3a2lsak+ZDPmzMdq68Wm7u4U1SHxkDkkNe8
         3qSf2EXN/EslCAiJPdZqMK4a4d5VoWIHB1djLmA2wvJd86G0Ilgz4zj40szQxZ3AMvtv
         EXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsYNrd7gsjwoexzhJ7EgUb25vTqg/CQaLGiDhKUAECQ=;
        b=h8EtQGTyYqvbu2PUQTMWOPOL46zAO5AqcMt28UvzS78Ilb+VA6srtFcuxDoZzhfmek
         C8dvs8wYuxEDStkgvSce0xDXOqqjDUUD73g5TKxnL8/FHbubIb9I5tQsMOG+NUCJ7762
         RfEl2yB7sdxKGKnZDJhTuQ4xUwVfA+rJTwrCQ2RuPbt0UBcBxDChohsxXsixSQ+EdM6g
         XU/cTrkJa3l7nl52lYCPyrVDOH3oyBhpclcZsf1Md6F8GwPPmH5Ec4n4+5nylA5tW6H7
         +Bo8wY/75lar6ZoYAgdhiRAh4Q+Sf9jJzXwfT0L78aznwRV2fECydXtgQX675JgqkWKu
         QL0Q==
X-Gm-Message-State: AHQUAuZCiiWjp896JOTJakFHfIf30dNk5b++CjjQUrO+5QBQxceqi3mm
        mjRGe1iVl3oqikWpU2fM6xaDLSXOAmuaoLT1xP6Uvg==
X-Google-Smtp-Source: AHgI3IbICthz30wZ7RYNBw+pmGzpxrW+CeivxmG9/N3Oa+yfXCV+c2W1faWJIv3J6wG2GF3emK/zuXT3jQ9BIRuhH/M=
X-Received: by 2002:a9d:66d0:: with SMTP id t16mr10535001otm.35.1550542379527;
 Mon, 18 Feb 2019 18:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-7-tobin@kernel.org>
In-Reply-To: <20190218232308.11241-7-tobin@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 Feb 2019 03:12:33 +0100
Message-ID: <CAG48ez1n=+GsvhMxHhxL=EBxD6VEqopdLRPcEAff9vrP3+a30g@mail.gmail.com>
Subject: Re: [PATCH 6/6] lib: Add function strscpy_from_user()
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:25 AM Tobin C. Harding <tobin@kernel.org> wrote:
> Currently we have strncpy_from_userspace().  If the user string is
> longer than the destination kernel buffer we get an error code -EFAULT.
> We are unable to recover from here because this is the same error
> returned if the access to userspace fails totally.
>
> There is no reason we cannot continue execution with the user string
> truncated.
>
> Add a function strscpy_from_user() that guarantees the string written is
> null-terminated.  If user string is longer than destination buffer
> truncates the string.  Returns the number of characters written
> excluding the null-terminator.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/strncpy_from_user.c | 43 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 11fe9a4a00fd..6bd603ccec7a 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c

This file is only built when CONFIG_GENERIC_STRNCPY_FROM_USER is set.
Some architectures have their own versions of strncpy_from_user() and
don't set that, so on those architectures, your code wouldn't be built
into the kernel.
