Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeBLQKd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:10:33 -0500
Received: from imap.thunk.org ([74.207.234.97]:33896 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933591AbeBLQKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:10:31 -0500
Date: Mon, 12 Feb 2018 11:10:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: ext4 iomap SEEK broken [was: [GIT PULL] ext4 updates for 4.15]
Message-ID: <20180212161026.GA2087@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20171113031502.f6mctmlmgk5psh77@thunk.org>
 <7ae851b1-92a8-779a-a066-1c7e34867465@suse.cz>
 <45062110-e80c-f1e8-3710-743c1ae4d232@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45062110-e80c-f1e8-3710-743c1ae4d232@suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 01:14:07PM +0100, Jiri Slaby wrote:
> On 02/12/2018, 11:02 AM, Jiri Slaby wrote:
> > Given this happens only on 32bit kernel, I assume some 32bit overflow.
> > But I am unable to see it (yet).
> 
> Just to add, a diff of strace in good and bad kernels:
> @@ -655,14 +655,4 @@
>  _llseek(3, 4275568640, [4286054400], SEEK_DATA) = 0
>  _llseek(3, 4286054400, [4288675840], SEEK_HOLE) = 0
>  _llseek(3, 4288675840, [4299161600], SEEK_DATA) = 0
> -_llseek(3, 4299161600, [4301783040], SEEK_HOLE) = 0
> +_llseek(3, 4299161600, [4299161600], SEEK_HOLE) = 2621440
> 
> llseek returns a very invalid value when it comes to 0x100400000.

Thanks for the bugreport!  Can you send me the output of "filefrag -v"
on the file so I can make sure we can exactly replicate what you're
seeing?

Thanks,

						- Ted
