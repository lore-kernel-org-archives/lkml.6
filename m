Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA18C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BEC20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eU9PM7IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BEC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeLADn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:43:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46616 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeLADn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:43:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so5596581otm.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYoKPdE6SvqMcfaw0G2NJgdyUViuTXYS+Dc8ThpjB2o=;
        b=eU9PM7IZ/r7Sbh27k9K21CTrJEoJ5AfYdm9aolWnnYbkJ1rZfbQbnE/LusCFPkjE4F
         dFCxYVSvKV3T1aTzSb6u7MurjKDCJARqw2MfPw0inPBKJL0OHkYfJvjl+Rlznat1J7WB
         zMhJ6cvCxn54WJhvTRdc4yvvKpIXPAHorkiwJ9C+wDVtKPr1Ia7XhlBuhFTK0BFTYK/V
         ehLmMDVJzsNJIjzGr/j41re68T6u+1ZbMzm4dBZ61PCj1dCbaWXwlWz3JoP52szYBu63
         SX2MZPCPgfNPrBe2zbit03BVElMLCXcPnWJIWtaTS7syBJif+nJSNg0OFtiai+zkIzxJ
         qDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYoKPdE6SvqMcfaw0G2NJgdyUViuTXYS+Dc8ThpjB2o=;
        b=KjSl7FwLg87J+oppjBwL66ILrhIPfF+xEuvmHplVvGN7ltDM/raXDjExdtuEAfpLs0
         dwYDaCs3rACf7jMXhm9QPECcW0eyEzRrLjR2qZGgixrFR7v9Y+bJISVpLdKQjJJPeVsv
         PCuPecudfn8bJex+LO+kdmGIthvItpE2ZdtJtBwK/stgMeC/a9v4aUzP5+/F8N7S2xKO
         t45zoTDrj/bn7vZ+EA0nNZni20+CWrv3+7rIgF/N/bf7zzZMsQBhl+R5cIKdC4FsQzvy
         oWWGF1Vgpfr3+Di//nbXFUYX2YHQOvtUFsxePfaPiQFCMUUjOmoGQoFGIlaHAM472ojU
         Bmew==
X-Gm-Message-State: AA+aEWZMe3ovu0Ii7hvnh6CiqJPIk0W5outN7eUDsT3XcBliJ94F4Skm
        kS+XKSzpbgX15WaMF+RNJ6WGLdrvUgrMmPfq+8vxWA==
X-Google-Smtp-Source: AFSGD/XkL7TpUI5lVwDN4URFaWjRlawioo356wQ2TmLRFBhkijU/RBHJ9oZVC5Zrznl+aJf2XkOAlP4hXIP4hl9uG9E=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr3841971otg.229.1543595647322;
 Fri, 30 Nov 2018 08:34:07 -0800 (PST)
MIME-Version: 1.0
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181130154902.GL10377@bombadil.infradead.org> <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
 <20181130162435.GM10377@bombadil.infradead.org>
In-Reply-To: <20181130162435.GM10377@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Nov 2018 08:33:55 -0800
Message-ID: <CAPcyv4gBwtCxN4xTncsyShMwMzNiLG3SxKA-frYh9Fn-f6QV=g@mail.gmail.com>
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

On Fri, Nov 30, 2018 at 8:24 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 30, 2018 at 07:54:49AM -0800, Dan Williams wrote:
> > Looks good to me, although can we make that cookie an actual type? I
> > think it's mostly ok to pass around (void *) for 'entry' inside of
> > fs/dax.c, but once an entry leaves that file I'd like it to have an
> > explicit type to catch people that might accidentally pass a (struct
> > page *) to the unlock routine.
>
> That's a really good idea.  Something like this?
>
> typedef struct {
>         void *v;
> } dax_entry_t;

Yes, please.

> I could see us making good use of that within dax.c.
