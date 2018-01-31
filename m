Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeAaM3a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeAaM31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:29:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C5621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1517401762.3612.0.camel@kernel.org>
Subject: Re: [PATCH v2] iversion: make inode_cmp_iversion{+raw} return bool
 instead of s64
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Trond Myklebust <trondmy@primarydata.com>
Date: Wed, 31 Jan 2018 07:29:22 -0500
In-Reply-To: <CA+55aFw5Xf4V-BF1JK+SpjXnmrgeMe-k0wLaFc_=6ojbhfWEtQ@mail.gmail.com>
References: <20180130173126.2806-1-jlayton@kernel.org>
         <20180130203221.29310-1-jlayton@kernel.org>
         <CA+55aFw5Xf4V-BF1JK+SpjXnmrgeMe-k0wLaFc_=6ojbhfWEtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 12:53 -0800, Linus Torvalds wrote:
> Ack. Should I expect this in a future pull request, or take it directly?
> 
> There's no hurry about this, since none of the existing users of that
> function actually do anything but test the return value against zero,
> and nobody saves it into anything but a "bool" (which has magical
> casting properties and does not lose upper bits).
> 
>               Linus

Do you mind just taking it directly? I don't have anything else queued
up for this cycle.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
