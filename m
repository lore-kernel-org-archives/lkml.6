Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeBLV1i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:27:38 -0500
Received: from osg.samsung.com ([64.30.133.232]:62825 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932104AbeBLV1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:27:37 -0500
Date: Mon, 12 Feb 2018 19:27:30 -0200
From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus <torvalds@linux-foundation.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
Message-ID: <20180212192730.4b4df411@vento.lan>
In-Reply-To: <20180213080036.3bf3a908@canb.auug.org.au>
References: <20180213080036.3bf3a908@canb.auug.org.au>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Em Tue, 13 Feb 2018 08:00:36 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi Mauro,
> 
> By merging the v4.16-rc1 tag into the v4l-dvb tree, you have created an
> unnecessary merge commit.  The v4l-dvb tree was already contained in
> v4.16-rc1, so a fast forward merge was possible, but explicitly merging
> a signed tag will give you a commit instead.  In this case, you could
> have just reset your branch to v4.16-rc1 or merged v4.16-rc1^0.

I did the usual way I used to do in the past. Not sure why it ended
by being an explicit merge instead of a fast forward.

On a quick test here, doing:

$ git checkout -b test media/v4.16-2
$ git merge v4.16-rc1

indeed makes produce a merging commit.

I never realized that I could force a fast forward using the weird

	$ git merge v4.16-rc1^0

If this is the way we should do git merges, are there a way to make
it default, suppressing the need of a "^0" (either via some .git/config
parameter or changing at git code)? Doing just one such merge once
or twice on every Kernel cycle, I'm pretty sure I'll forget to do 
it next time :-)

> Linus, this happens a bit after the merge window, so I am wondering
> about the rational of not doing a fast forward merge when merging a
> signed tag (I forget the reasoning).

Reset my tree on the top of v4.16-rc1 doesn't seem a good option,
as it causes merge issues from media sub-maintainers and from other
developer's trees.


-- 
Thanks,
Mauro
