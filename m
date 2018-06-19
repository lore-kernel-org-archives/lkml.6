Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B637EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5928820874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6YkbgiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5928820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965078AbeFSFjM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:39:12 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44036 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755840AbeFSFjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:39:10 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so5919861ywm.11;
        Mon, 18 Jun 2018 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jRmR9Ir7Hxv5BEAB9O55qM501tg9AC56/e8gCFTlL5Q=;
        b=r6YkbgiSr4Y4r+cexYf0i3G61id72X8ZJAoHbS9YFPg6jfWKLeSXg+35yFhZHKvysE
         rge/w7hEPJUClhwY3cECuugEFz4/6J/lvDJj4oLSFXUX50jQjFOiNcGkTjvaeZiSYjI3
         2TA3rROxABmPZE+qaILiUJceJbg1EZn7BdMpCtT0x3laSypWtadnK4Rvnz4AtfMjjgMy
         oXNFpdcB897XkwSLoOkevJT4aEoJPPObnB9st+dCDnouoPB/4pFtApcs1ccfYqp6MBgY
         7qxiOIVdxD2QazZWDZq+hoT7yoS/j7bWpVOO52SDjMesK7/7vdDahNP0xaKbD9at/3IS
         qQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jRmR9Ir7Hxv5BEAB9O55qM501tg9AC56/e8gCFTlL5Q=;
        b=Hy3plJJxuUrmCBqhH04vIK3DqrQk9iTUfE01j+glsAP/riZhOaVFQffQ8eH5aoTpZ2
         pgBkEXvHq5ks7KW0brcgEWfjtKhfILnXkJYxCT61+/o8TI/nbvi90FKPfevXapsycmt/
         i0rVmr8yc5MXFyFa82aFf5UNFMiVzs8Ylijzqr+U9SHCdOoYxOP1XyvISoPvWIR+BiXk
         dWgDskHMZoM8YQ/mIQggGLjazjnEa8P5OPLXtLu2Lak1/wROwiSlSSA3cYEXafDDnO5Z
         FAvPd2C3nkAGCbgFXVl1T4BqUATTSMlLmbiOwbuIrY6YrSry/1+3b9iodPciN2vF0F1b
         HWTg==
X-Gm-Message-State: APt69E31ZHSbvgfJKhza9QyQvmtnrbedc8/4qYRcVxXA9Y47jvB8+j8P
        9w1hw9dR4vynNH5o/9vFwKidRGTHBy5OuFzuxZE=
X-Google-Smtp-Source: ADUXVKINlblthn20A38UfvkX9aamIqfqfwN7Tu4XkLkWOltOpsbh61F0gpb995G9X6ELGdzQqIKigCphjGQEomMKq6Q=
X-Received: by 2002:a81:3050:: with SMTP id w77-v6mr7146341yww.88.1529386749151;
 Mon, 18 Jun 2018 22:39:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:79cf:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 22:39:08
 -0700 (PDT)
In-Reply-To: <87in6fagxw.fsf@xmission.com>
References: <20180618192726.67981-1-salyzyn@android.com> <87in6fagxw.fsf@xmission.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Jun 2018 08:39:08 +0300
Message-ID: <CAOQ4uxjepYO+UqED2is-Qcxs=nYypOtY6LhvRxrJeKiLxduU0g@mail.gmail.com>
Subject: Re: [PATCH v2] overlayfs: caller_credentials option bypass creator_cred
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:05 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Mark Salyzyn <salyzyn@android.com> writes:
>
>> All accesses to the lower filesystems reference the creator (mount)
>> context.  This is a security issue as the user context does not
>> overlay the creator context.
>
> Sigh.  You gave Vivek a reasonable description of what is going on
> and then you did not repeat it here.  Your patch description
> very much needs to be fixed.
>
> As I read your patch there you are removing an override in credentials.
> Presumably that override is needed for the fileystem to function.
>
> If that override is needed to function your patch is incorrect
> because it breaks things for no reason.
>
> If that override is not needed it should be safe to explain why
> and simply remove it from overlayfs.
>

Eric is correct about override being needed for filesystem to function
because overlayfs calls mknod and sets trusted xattr.

Alas, overlayfs makes an assumption that if mounter has credentials
to mount, it also has credentials for those other things, which so far,
nobody complained about AFAIK.

There was one complain though about abusing SYS_CAP_RESOURCE
of mounter to exceed underlying ext4 quotas, so that capability has been
recently revoked unconditionally from the override creds - that makes a user
with SYS_CAP_RESOURCE also incapable of exceeding underlying ext4
quotas (a good thing IMO, but that is arguable).

Ideally, the correct solution would be to "merge" the mounter creds and
caller creds and use different combinations of the two in different cases,
but that would complicate the code and the test matrix considerably.

> I don't see any real explanations in this change description.
> So this appears to be an incompletely thought out change.
>
>
> Mostly this looks like someone tried to use the principle of least
> privilege in your Android implementation and got it wrong.  Having given
> the mounter of overlayfs too few privileges this appears to be an
> attempt to get overlayfs to pay the cost of an implementation mistake in
> the Android security model.
>
> That seems like a very unreasonable thing to do.
>

To the best of my knowledge, the Android sepolicy rules for init have been
like that for a very long time. I am not sure why Eric claims the unreasonable
claim. Not sure who the users of overlayfs are going to be though and if
it is possible to guaranty that they have capabilities to mknod and set trusted
xattr (needed for removing dirs among other things).

As it is, the patch is simple enough and only makes an existing functionality
optional, so if it *really* solves the Android use case, and there is
*really* no
other "reasonable" way to configure Android sepolicy, I rather have this patch
than the more "correct" implementation.

Two comments about the patch in case we are going forward with it:

1. I would use the same convention for Kconfig/module param/mount option
as used for other overlayfs defaults, i.e. override_creds=on/off and Kconfig
default which defaults to the legacy behavior.

2. with override_creds=off, all the checks being done during mount become
irrelevant (e.g. mounter can set trusted xattr), so either skip them and issue
a warning saying that we really hope mounter knows what it is doing, or
I don't know what.

Thanks,
Amir.
