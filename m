Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeA3Uxj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:53:39 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:56081 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbeA3Uxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:53:37 -0500
X-Google-Smtp-Source: AH8x225svz5RzCxHITCaTsZfmHGXjuKCd+mQdwkRMQ062h480g8fbVpx36aZWwGM/Je4wHuYunscGhNEet0GF9KHrbA=
MIME-Version: 1.0
In-Reply-To: <20180130203221.29310-1-jlayton@kernel.org>
References: <20180130173126.2806-1-jlayton@kernel.org> <20180130203221.29310-1-jlayton@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2018 12:53:35 -0800
X-Google-Sender-Auth: x33VSgfZkrJxA9VtdC6qi_8duxw
Message-ID: <CA+55aFw5Xf4V-BF1JK+SpjXnmrgeMe-k0wLaFc_=6ojbhfWEtQ@mail.gmail.com>
Subject: Re: [PATCH v2] iversion: make inode_cmp_iversion{+raw} return bool
 instead of s64
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Trond Myklebust <trondmy@primarydata.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack. Should I expect this in a future pull request, or take it directly?

There's no hurry about this, since none of the existing users of that
function actually do anything but test the return value against zero,
and nobody saves it into anything but a "bool" (which has magical
casting properties and does not lose upper bits).

              Linus
