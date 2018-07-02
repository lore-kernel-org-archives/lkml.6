Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13E2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC52124D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C1DJHqhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FC52124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932391AbeGBX26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:28:58 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32875 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932098AbeGBX24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:28:56 -0400
Received: by mail-it0-f66.google.com with SMTP id y124-v6so2134696itc.0;
        Mon, 02 Jul 2018 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqvR6nMGCT++7QJRBmzLyRCBdSbDDlDkEflnOyerIis=;
        b=C1DJHqhREeL0O56FFHJEYzKpQTY9eNB6fF69Dvq4ZHvfWmc8ss/Sf6LUYma8ndl7R1
         G2Li61gm/TfkUam82wqTiObxw5Sfn8zPxurBzIsGIZcP2B9ZByXRy4eqVkTMGBiVAb06
         j4ZIqHiFgvG9o5GMWtG8g7yapxQ+QrqYoBwDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqvR6nMGCT++7QJRBmzLyRCBdSbDDlDkEflnOyerIis=;
        b=giV1UBjKgy236nkmuC/ezxetjiPOFodnR7PXeZE3U5DuVswtQZev++XsBnBiHbakGr
         lxCJPbMLOvgZ0hoMCVCfAeglh6oASbKUKS2Di7Ati845+qLMUtYpCW4rWICIsKcqrbL0
         LmibcgsNFc077Z/CgecxbzWNDqLhEDKmOD2NKwIB9Ew5vuir21Vihoulpyf+9g9N+cBl
         vTDnwQXvZeuh7fYD0xDzvm84cmgTtZp9fIgBcWTMz3CDVtR8zexdXRwJm6XZPY+jqNrw
         HUu0sKNGLeFkuOmnzeua5EHp6sFAiW4ZKLzaGE/ARyJBs/wVzg3d/PTcAjT1uBpenAXP
         UBoA==
X-Gm-Message-State: APt69E08VfYZXWF9IK/ZPjozpuQDoXqF5GCBSlYxNEIZqPLWI9czkgTV
        2aiMqkFjKOlS85vBuvk1dJ3xnR9UW8U4dkQmx6o=
X-Google-Smtp-Source: AAOMgpfJSSRg1NBqIDbn/1ig+Vkd7idefMONsn33zjBhQPViwTpgcnTUBOZ293N7jKxrDE28TpwNgAystaq6tdzhkEU=
X-Received: by 2002:a02:664b:: with SMTP id l11-v6mr22995213jaf.70.1530574134995;
 Mon, 02 Jul 2018 16:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com> <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
In-Reply-To: <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 16:28:44 -0700
Message-ID: <CA+55aFwYsq5OVMVizhfis7Jtepj8xQk1Paz=Tqz-HmfhoZ_mfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Before we go and add a large amount of code to do the shrinker's job
> for it, we should get a full understanding of what's going wrong.  Is
> it because the dentry_lru had a mixture of +ve and -ve dentries?
> Should we have a separate LRU for -ve dentries?  Are we appropriately
> aging the various dentries?  etc.
>
> It could be that tuning/fixing the current code will fix whatever
> problems inspired this patchset.

So I do think that the shrinker is likely the culprit behind the oom
issues. I think it's likely worse when you try to do some kind of
containerization, and dentries are shared.

That said, I think there are likely good reasons to limit excessive
negative dentries even outside the oom issue. Even if we did a perfect
job at shrinking them and took no time at all doing so, the fact that
you can generate an effecitvely infinite amount of negative dentries
and then polluting the dentry hash chains with them _could_ be a
performance problem.

No sane application does that, and we handle the "obvious" cases
already: ie if you create a lot of files in a deep subdirectory and
then do "rm -rf dir", we *will* throw the negative dentries away as we
remove the directories they are in. So it is unlikely to be much of a
problem in practice. But at least in theory you can generate many
millions of negative dentries just to mess with the system, and slow
down good people.

Probably not even remotely to the point of a DoS attack, but certainly
to the point of "we're wasting time".

So I do think that restricting negative dentries is a fine concept.
They are useful, but that doesn't mean that it makes sense to fill
memory with them.
                 Linus
