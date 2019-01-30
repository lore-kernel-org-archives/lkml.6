Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DB2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838EC2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bzuk+pZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfA3SlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:41:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33934 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfA3SlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:41:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so437474lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCIG9VzWuYh+4Bf06Auxq3qGZen7OwOELA8vsXd/35o=;
        b=bzuk+pZXi21YAEqDDpBSJtx9ETbV3TvSPPgDua49V5H1nPuLiSNyTMzEwu9o6wqcBT
         2Af5cWanIGXkR2qaTuvjKsVwQa8DDgjqvGHCq1zl/tUs9v05MjF+k1Imnz+LGUQDOypo
         sXJI6OZvqz5CzhCSD/SmkcWXJQcZcH2BuZqVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCIG9VzWuYh+4Bf06Auxq3qGZen7OwOELA8vsXd/35o=;
        b=s6dHI1jAO4IniwsTO6hVDjy2NqplH727SL+lV5594XzCswGVTWYt0FOUJLfvloRJi1
         Dh5sq1NkVF7z+RZFZWgm1QGWIL0Q0KPQHBGCOqCAxDdi8Q967POCor3i963x5mCY8Zx2
         +Gv3pOo03QwWeb70y+xS2ooqTSyicPYpvDzRqNDnrtcgoWiN/QREDWCdK9qfCWndJOVc
         64b5ulCcWzPTQ8ROlxHe9Ff3tVsdvaD1w08E+G72hn/IgJfhmacC8xT1hvmRnXd3rL8H
         rC4TYQ+G9GR6yvigeE1EheS01sKPlYXgRFsWtgVEbx8xJHbCIzjsLmg2x6rI5bfVp0+z
         3g2A==
X-Gm-Message-State: AJcUukfezN5WkVH0+OxS+NTUttO6HD2rzafEwxxoYrrTe4EQ7ImxBFGX
        +ZgwqdExen66JqdM0tc2qhwt81xRClc=
X-Google-Smtp-Source: ALg8bN73qwzq+8N/9682aQN9h3WxIJaKhdlVeZd63KmCtcUOgvdN6OU7kNoZj9L/jp9PhAZLr8iBNg==
X-Received: by 2002:a19:d04d:: with SMTP id h74mr22542372lfg.52.1548873671654;
        Wed, 30 Jan 2019 10:41:11 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j18-v6sm394579ljc.52.2019.01.30.10.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:41:11 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id t18-v6so492712ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:41:11 -0800 (PST)
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr26573226ljz.54.1548873324599;
 Wed, 30 Jan 2019 10:35:24 -0800 (PST)
MIME-Version: 1.0
References: <1544824384-17668-1-git-send-email-longman@redhat.com>
 <CAHk-=wi-V7LjAAzFuxg+eLQAdp+Ay4WmVJdTNxgPjqKXaj-3Xw@mail.gmail.com>
 <0433488a-c8ad-e31a-6144-648e45478c07@redhat.com> <260e6cdb-42b7-1891-e525-54048d168b5c@redhat.com>
In-Reply-To: <260e6cdb-42b7-1891-e525-54048d168b5c@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Jan 2019 10:35:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi1raFRkRH1HEe_awy7HVy7XWxFRv9aZY-cgNL5zMqW4A@mail.gmail.com>
Message-ID: <CAHk-=wi1raFRkRH1HEe_awy7HVy7XWxFRv9aZY-cgNL5zMqW4A@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/3] fs/dcache: Track # of negative dentries
To:     Waiman Long <longman@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, lwoodman@redhat.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        wangkai86@huawei.com, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:40 AM Waiman Long <longman@redhat.com> wrote:
>
> Ping. Will this patch be picked up?

Can you re-send the patch-set and I'll just apply it directly since it
seems to be languishing otherwise.

                Linus
