Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DF9C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4258C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYcn5uk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4258C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFUGap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:30:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40331 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeFUGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:30:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so3590073wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 23:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qetVJMR9BXAytswHwx5TeHMKsYk5lZhH0E06bN+1lvY=;
        b=BYcn5uk7Jzas4T+3eBbGSRq0OWSfYF+2IN9Zw7mgbSQCTGVpUMzB9F94rfxADE56WJ
         HAlahcwPTZXnmrexSgNjSPTz8p5sJ1YT4Xu2GI1CjO1gYLY3OTID75YGtk2ZEjcU4lEw
         eo2FWUP5aknEgxvRBliJW9TJz/64+M8ciznqel+ISCRsA7k2JTAv4s1WPH9eOp1zWQr8
         dehb1VeXxZqm3BzEz14xbHFnQXzKyCqneQZYtD6Rv8M+TnxaGsMdD32n01O9n3iyMESB
         WxfFmRTdmKiLvw8qSIW/9pZSOxKR8kDCyxrY2i1272VatewsIZ/DXXYuwWz0ss7XyPst
         CNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qetVJMR9BXAytswHwx5TeHMKsYk5lZhH0E06bN+1lvY=;
        b=M5aAf/G8m/M+5LsQUGdU8BTIyvkGVp1+R4OW9sdQzuLxfdKU1jF6SlO6E4ptCXEz2c
         6I2ULqELMWMyX+FiGO9q2Lxi9dsydLLLxdOUCWoejzURBnCeZ0U9KoY0jk4CBVkLY2VR
         RZhG4xp63p94JJVSpjH3jhTA50RKxd19NfUrKlMi0eyu1bu6IXiECAbVhO9c0rGc9Yx4
         ZCwIDZPiAuEMKBn5Ru2fp4XOHnuMvWaDF8eL+hxODpqEH7CE0XefGXw9vkTFzxtffSCy
         hcpnu0haczjg2cOC6tvd5Icb4O66ZzBkSCDXyHyYlU6Y0YfLin2iNrh7MiKQupNQZWQr
         vtdQ==
X-Gm-Message-State: APt69E2+/O81Awx6dyGeJi0ykIlaoPS9RaNRyixgonUCg5W20IN8JK+P
        Tu23pml0EsuLnLkDCiTmlYBCfRA8GOABGFzbHrLHDg==
X-Google-Smtp-Source: ADUXVKKdK4IPCBbP5D74EZ+xKSFAmE+VUpOW28GSnq9iDvgTxaR+napvYXxg6zaAhjCFEb3VO6mUKEhYnHuei9Ctan4=
X-Received: by 2002:a1c:1c8f:: with SMTP id c137-v6mr3884950wmc.142.1529562641633;
 Wed, 20 Jun 2018 23:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180620224147.23777-1-shakeelb@google.com> <010001641fe92599-9006a895-d1ea-4881-a63c-f3749ff9b7b3-000000@email.amazonses.com>
In-Reply-To: <010001641fe92599-9006a895-d1ea-4881-a63c-f3749ff9b7b3-000000@email.amazonses.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Jun 2018 23:30:29 -0700
Message-ID: <CALvZod7fgFYDY7nqE2S4a78TqoX19MC66YTFFrWqqR0h9F8iPA@mail.gmail.com>
Subject: Re: [PATCH] slub: track number of slabs irrespective of CONFIG_SLUB_DEBUG
To:     Christoph Lameter <cl@linux.com>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 6:15 PM Christopher Lameter <cl@linux.com> wrote:
>
> On Wed, 20 Jun 2018, Shakeel Butt wrote:
>
> > For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> > allocated per node for a kmem_cache. Thus, slabs_node() in
> > __kmem_cache_empty(), __kmem_cache_shrink() and __kmem_cache_destroy()
> > will always return 0 for such config. This is wrong and can cause issues
> > for all users of these functions.
>
>
> CONFIG_SLUB_DEBUG is set by default on almost all builds. The only case
> where CONFIG_SLUB_DEBUG is switched off is when we absolutely need to use
> the minimum amount of memory (embedded or some such thing).
>
> > The right solution is to make slabs_node() work even for
> > !CONFIG_SLUB_DEBUG. The commit 0f389ec63077 ("slub: No need for per node
> > slab counters if !SLUB_DEBUG") had put the per node slab counter under
> > CONFIG_SLUB_DEBUG because it was only read through sysfs API and the
> > sysfs API was disabled on !CONFIG_SLUB_DEBUG. However the users of the
> > per node slab counter assumed that it will work in the absence of
> > CONFIG_SLUB_DEBUG. So, make the counter work for !CONFIG_SLUB_DEBUG.
>
> Please do not do this. Find a way to avoid these checks. The
> objective of a !CONFIG_SLUB_DEBUG configuration is to not compile in
> debuggin checks etc etc in order to reduce the code/data footprint to the
> minimum necessary while sacrificing debuggability etc etc.
>
> Maybe make it impossible to disable CONFIG_SLUB_DEBUG if CGROUPs are in
> use?
>

Copying from the other thread:

On Wed, Jun 20, 2018 at 6:22 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Jun 21, 2018 at 3:20 AM Christopher Lameter <cl@linux.com> wrote:
> >
> > NAK. Its easier to simply not allow !CONFIG_SLUB_DEBUG for cgroups based
> > configs because in that case you certainly have enough memory to include
> > the runtime debug code as well as the extended counters.
> >
>
> FWIW, I ran into issues with a combination of KASAN+CONFIG_SLUB
> without having CONFIG_SLUB_DEBUG, because KASAN was using functions
> that were broken without CONFIG_SLUB_DEBUG, so while you're at it with
> creating dependencies, you might want to also say KASAN+CONFIG_SLUB
> ==> CONFIG_SLUB_DEBUG.

KASAN is the only user of __kmem_cache_empty(). So, enforcing
KASAN+CONFIG_SLUB => CONFIG_SLUB_DEBUG makes sense but not sure about
cgroups or memcg. Though is it ok let __kmem_cache_shrink() &
__kmem_cache_shutdown() be broken for !CONFIG_SLUB_DEBUG?

For __kmem_cache_shutdown(), I can understand that shutting down a
kmem_cache when there are still objects allocated from it, is broken
and wrong. For __kmem_cache_shrink(), maybe wrong answer from it is
tolerable.

Shakeel
