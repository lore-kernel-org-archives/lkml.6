Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbeENQai (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:30:38 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42682 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbeENQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:30:35 -0400
X-Google-Smtp-Source: AB8JxZqG0kZ4I8kbCZLVDM3ALkfe9uk2Hctb9dEoxv8TRGFl9H7pG0p0mIPTzvfEtauWvOcgMPEKNwA4sXwSEfj48ZQ=
MIME-Version: 1.0
In-Reply-To: <CABeXuvpi_dm6TE3pH_KGehgNwW177hJFBmR8u29w6KJH1aA1Kg@mail.gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
 <20180512045921.18311-7-deepa.kernel@gmail.com> <CAGXu5jLFHSE12La25QEvZawdBm84cLavtTD5LAA6MqeqBmbYuw@mail.gmail.com>
 <CABeXuvpi_dm6TE3pH_KGehgNwW177hJFBmR8u29w6KJH1aA1Kg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 14 May 2018 09:30:34 -0700
X-Google-Sender-Auth: SbH6IkpnSIpPFCubwoh0rzan5ls
Message-ID: <CAGXu5jJpO+z8k_=UuVY9WAeiEgABQg4gWE6nz82BX0_UhaPUWw@mail.gmail.com>
Subject: Re: [PATCH 6/6] vfs: change inode times to use struct timespec64
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>, anton@tuxera.com,
        Felipe Balbi <balbi@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>, David Sterba <dsterba@suse.com>,
        David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mike Marshall <hubcap@omnibond.com>, Jan Kara <jack@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Jiri Slaby <jslaby@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Nicolas Pitre <nico@linaro.org>,
        reiserfs-devel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Sage Weil <sage@redhat.com>, Steve French <sfrench@samba.org>,
        Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        "Ted Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 9:05 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Kees mentioned that he wants to merge a patch to pstore that changes
> it to use timespec64 internally for 4.17:
> https://lkml.org/lkml/2018/5/13/3

I'm still working on a v2 for pstore. What is the correct
cross-architecture format string for timespec64's tv_sec? In your
other patches, you're using %lld and a (long long) cast. I'd really
like to avoid the need for casts.

-Kees

-- 
Kees Cook
Pixel Security
