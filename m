Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeBISsn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:48:43 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:44518 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeBISsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:48:42 -0500
X-Google-Smtp-Source: AH8x227FXt2Wy+c7WWgZZlldz/q6U2wi5cVw+7kJd8NZHvDORa9mMFrxE+ERH/1Fx9cmDt8PgdsyX7sGWOyzSX8Lwas=
MIME-Version: 1.0
In-Reply-To: <20180209142800.25485-1-jgross@suse.com>
References: <20180209142800.25485-1-jgross@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Feb 2018 10:48:40 -0800
X-Google-Sender-Auth: neCzTx_FXP4lzeRscsw4KICF2j0
Message-ID: <CA+55aFxyEpQUgpZtkRbc1ESbMBw6FcbLgbzB3ioPN_097HpzOg@mail.gmail.com>
Subject: Re: [GIT PULL] xen: fixes for 4.16 rc1
To: Juergen Gross <jgross@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 6:28 AM, Juergen Gross <jgross@suse.com> wrote:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-4.16-rc1-tag

So I've pulled this, but the back-merges *really* annoy me.

Seriously, DON'T DO MERGES IF YOU CANNOT EVEN BE BOTHERED TO WRITE A
REASON FOR THEM!

There are two back-merges in that tree, and while they both merge
reasonable merge points (v4.14 and v4.15 respectively), neither of
them has *any* explanation of why the f*ck the merge was done. The
v4.15 merge doesn't even make it clear that it merges v4.15 - it just
says "master".

Having random commits with no explanation of what the hell they are
doing is NOT OK. It's not ok when they do real changes, but it's EVEN
MORE not ok when they are just random merges that bring in
who-the-hell-knows-what.

Merge commits need explanations of what they merge and why they merge it. This:

    Merge branch 'master' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/torvalds/linux

(which is all the explanation there is in commit ddb9e13af3bb) is
simply not acceptable.

At least the other merge merged the v4.14 _tag_, so just looking at
the merge it's at least clear that you merged a real release. It still
doesn't explain _why_ it was merged.

If you cannot state a good reason for the merge, or you can't be
bothered to write one, DO NOT DO THE MERGE.

It's really that simple.

          Linus "grumble" Torvalds
