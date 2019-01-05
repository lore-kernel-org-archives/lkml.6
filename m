Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C0C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE419222EE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T5rpLbUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAEXjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:39:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43064 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfAEXjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:39:31 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so27755249lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqn7KU+WgVrfy/zTMX85nX2nASUNdrmXGozjZhj/P34=;
        b=T5rpLbUe43AjyR/Tays+5hbKh/g/PPzb5DJwZdl42hJPSlD71AGfF/5kapE247v3zf
         WwJ+RVtey6C00eBVmeJ6Ke+ra/20LG+umoF5rijWao25CREZdQDrrdSryW3gSlN1T25V
         nd/Di9P/35w1cIE/gk7xjYwTnPmL9y0w+5e5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqn7KU+WgVrfy/zTMX85nX2nASUNdrmXGozjZhj/P34=;
        b=qHw6lmfi45dX8551NeX0NSL2FenXR+N/0WAUrffv1ybZhgiNwFF9G6Xq6AXzGJI9Sv
         t5RVHqMZQ4wz09fJpFbMz3eQOpYVwXqzTAzJlJ5KPE7I5Apl+P7xnsZqsQGchArsPf+n
         OUTsTj7DS3YgYSJROVBcFdMsd1AKvM6tu6rh1j+2gEAhc2KUfCRkmq6mlLXoCuOBdjrK
         Ib67Q/autR3O/K52oxPGL31Fj2Z/G+NfOErMN9j2Vhss6HqmJoZLGTmJOSRQ6HsSN7ff
         iv4OStUFKtONskWPSACiz3eWkESD3mT7qAYL6lZqPodYyVxk9Sarm7HYF7QWqnYlrakl
         gCOQ==
X-Gm-Message-State: AA+aEWZceQ/ZNkqgeZ3+InYQbQbt/uJX3rCfykYEuyWfvyqPnnUUHhw8
        y3Wfk7xNXT7MGnDj8HA6jZoRlVgacEg=
X-Google-Smtp-Source: AFSGD/VOazp9sOb7eI5z1ixMbmOTLoGnxfPpzOlK/1Gqaaywh5IG0PnBnb+lOB5c5l9ASwjxZ4c7VQ==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr26923211lff.141.1546731568159;
        Sat, 05 Jan 2019 15:39:28 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r10-v6sm13200392ljj.71.2019.01.05.15.39.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 15:39:27 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b20so27747905lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 15:39:26 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr30186946lfc.124.1546731566565;
 Sat, 05 Jan 2019 15:39:26 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com> <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 15:39:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
Message-ID: <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 3:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It goes back to forever, it looks like. I can't find a reason.

mincore() was originally added in 2.3.52pre3, it looks like. Around
2000 or so. But sadly before the BK history.

And that comment about

  "Later we can get more picky about what "in core" means precisely."

that still exists above mincore_page() goes back to the original patch.

           Linus
