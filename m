Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E4C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5C2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0X+h3SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE5C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeKFJ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:26:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35811 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeKFJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:26:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so9862754otj.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 16:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azjMIQVm8gzPRPbmBbpEO+983lQaQYonL9Il4GTjRao=;
        b=Z0X+h3SRlkaPFY5ceKC5MFEqeu2jzBMh3kXgvXUZwXX7I+AtknYmbDWFbGSezSVB7U
         S0EjVGvvYnllLMi4yZF1cKPYHJqJbs0rTi/RiJnQXe9iU4ZAli/w6lFJtP/lKQOmXaID
         eNYL7lNVmOQ9J/9JWy3hRK7sdP4KrcrJ7GLgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azjMIQVm8gzPRPbmBbpEO+983lQaQYonL9Il4GTjRao=;
        b=h5nqKQKBSLPKM54hc1QaEoXQjwcMQXkwuboAD7XN31NQFloS3DuwI7KMLQK8noq+pk
         4ZgNGH+caCCMQO2iAD6FcR9gOYhR7izz8fM8TyZkPpUKb6sZd6aW9A/0fqr1GoeTwLFX
         CDvRiXUN3aD58xdfUPb/7wgpJuWz3Hgf/3ECNjJh6MpSIOZ8uAtGe5jBeBQS4glg7Iya
         vE97AspnzZucOm9jevcwsLgr8+6uLLJ8T9EhJjUkxaUVPt3gV39BXiNGbWE/EJZhL3/P
         nxQps/Pdzcx0IgOGhne4vOrseE/mFMCfXb7epacYUZ6FHSLMTsnLxJ0BsI7+qfwdRzq+
         5p0w==
X-Gm-Message-State: AGRZ1gLc9v5A9pms1MSJAFMESnw2s2EbeuwfX7gTkmLbK3jh5nXRjZOw
        JS/KlmEynENeHvjHk9L4kZ38N7HHb6oJpKYsh8QR
X-Google-Smtp-Source: AJdET5f5IUODVNA0oMK4PX4IMRwffyt6Ri67W0A+/y3xnKuloqmkq95QtT8gIMM25gQHYGfZ6nr+MaI9LvbOK+Wg5Js=
X-Received: by 2002:a9d:4a5c:: with SMTP id d28mr14376856otj.25.1541462668411;
 Mon, 05 Nov 2018 16:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20181105111348.182492-1-vovoy@chromium.org> <516428f4-93a9-9ed7-426e-344ba91d81e0@intel.com>
In-Reply-To: <516428f4-93a9-9ed7-426e-344ba91d81e0@intel.com>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Tue, 6 Nov 2018 08:04:17 +0800
Message-ID: <CAEHM+4rCPdkv6-3sKZZHh5oBophz8GuF991pLgdue8gMDeXoTA@mail.gmail.com>
Subject: Re: [PATCH v4] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Michal Hocko <mhocko@suse.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 2:52 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/5/18 3:13 AM, Kuo-Hsin Yang wrote:
> > -These are currently used in two places in the kernel:
> > +These are currently used in three places in the kernel:
> >
> >   (1) By ramfs to mark the address spaces of its inodes when they are created,
> >       and this mark remains for the life of the inode.
> > @@ -154,6 +154,8 @@ These are currently used in two places in the kernel:
> >       swapped out; the application must touch the pages manually if it wants to
> >       ensure they're in memory.
> >
> > + (3) By the i915 driver to mark pinned address space until it's unpinned.
>
> At a minimum, I think we owe some documentation here of how to tell
> approximately how much memory i915 is consuming with this mechanism.
> The debugfs stuff sounds like a halfway reasonable way to approximate
> it, although it's imperfect.

OK, I will add more comments here.
