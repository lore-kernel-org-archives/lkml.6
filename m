Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39284C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E9E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qggCbewc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E9E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeLAELP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:11:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35341 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeLAELO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:11:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so5739702otj.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvaWUYYAClB6E8LcCQ2H6UI/5M+q7CWR/9h3uZUMGLE=;
        b=qggCbewcXxArO+eC50a1fcLC/838xna1VPwm1gH2vkBg47G1jrIU/oLca8CjwODyAT
         0fY9htPW7u//SlvshuyW8KOt0dHnZ+AnK2gsVLCUGdWABbNp7V4SZQnm3dI0M3WRwqL2
         i+DT6s1XYX1j73qdiMddaXnFZ8EpemXzvep7TpCCNZX+2patlosezMeLVCnSDwqOEQOx
         4GkpNHDCUPGWGlhvEqxXBpyw4NL5dFCxW/DnUemXrG0jQVTXC04+kLXxIjntdnrb06XN
         IZuBcyO9rYxkk8d8ptpACKx0wWJpeJBZdIKd+pYW3TR6iZlJ+wzT64lwrrLCPIUByYIL
         VI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvaWUYYAClB6E8LcCQ2H6UI/5M+q7CWR/9h3uZUMGLE=;
        b=as6mnyYZytqI/UtPyGZyvPrp3rlA7IPwWw4JCGE8EKQjATvAxAIcg0bEn7EUHEu+oK
         /Qur4FVdbHytIGH18mcQw1iTK2Q0wqKOQPIHoP0pEciFxfdn6dOJ/xTraVhd6H6s80LO
         du5H9BLfB0fLBLYIactZ9PhDejzgWmqJROUJPAsy7RJdKQYkONa2tC0DSUArCxRJV61z
         QpR3nU5icp1vbZ2l10LnJwK5yExDvN6JexkiGn876om3PN7pX/sbPd+/BZQBsxEKRHkD
         9X3mELnfz9rZ9b8qMmXZjwtJxsfo+//u+DxHawmnvNEn1Ew6ooqsHK69da6nBSZ4mlDI
         6JoA==
X-Gm-Message-State: AA+aEWbdiKfWmj67cyDPhT8m5Cs/g6X8OYbHux7hFRBb42CnWI4fvlLi
        0Lwh1foj4AnKoItdYDJ7qoHkNHpqQG3xkBHlgLqv2A==
X-Google-Smtp-Source: AFSGD/VJJxDuLqyJgIn/CFb54kzCko7Eh05KLq2P4BFyk6xmdzWZyfPkre4uagRmuRAkFuoqF8ALnKeltevTfbC/vH8=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr3791943otf.98.1543597278517;
 Fri, 30 Nov 2018 09:01:18 -0800 (PST)
MIME-Version: 1.0
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181130154902.GL10377@bombadil.infradead.org> <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
 <20181130162435.GM10377@bombadil.infradead.org> <CAPcyv4gBwtCxN4xTncsyShMwMzNiLG3SxKA-frYh9Fn-f6QV=g@mail.gmail.com>
In-Reply-To: <CAPcyv4gBwtCxN4xTncsyShMwMzNiLG3SxKA-frYh9Fn-f6QV=g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Nov 2018 09:01:07 -0800
Message-ID: <CAPcyv4gDO7sUJgE5kKe=VC5uUG36QaUrkb6tCrtnaFMkgdSYGw@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 8:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Nov 30, 2018 at 8:24 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Nov 30, 2018 at 07:54:49AM -0800, Dan Williams wrote:
> > > Looks good to me, although can we make that cookie an actual type? I
> > > think it's mostly ok to pass around (void *) for 'entry' inside of
> > > fs/dax.c, but once an entry leaves that file I'd like it to have an
> > > explicit type to catch people that might accidentally pass a (struct
> > > page *) to the unlock routine.
> >
> > That's a really good idea.  Something like this?
> >
> > typedef struct {
> >         void *v;
> > } dax_entry_t;
>
> Yes, please.
>
> > I could see us making good use of that within dax.c.

I'm now thinking that this is a nice improvement for 4.21. For 4.20-rc
lets do the localized fix.
