Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934540AbeCPPzn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:55:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49838 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbeCPPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:55:40 -0400
Date: Fri, 16 Mar 2018 15:55:38 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: remove trailing whitespace
Message-ID: <20180316155538.GD30522@ZenIV.linux.org.uk>
References: <20180316143400.8698-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316143400.8698-1-niklas.cassel@axis.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 03:34:00PM +0100, Niklas Cassel wrote:
> Remove trailing whitespace.
> Remove empty line and trailing whitespace after function comments.
> Remove an extra space in one of the comments.
> Fix a typo in of the comments.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> I know that these type of patches are not really appreciated,
> however, there is enough trailing whitespace in this file to
> distract me from reading the real code.

No, they are not, and here's why:

Applying: dcache: remove trailing whitespace
error: patch failed: fs/dcache.c:254
error: fs/dcache.c: patch does not apply
Patch failed at 0001 dcache: remove trailing whitespace

... which, BTW, happens in *all* branches.  If you do that kind
of stuff, at least do it against something in the public trees
and _tell_ _what_ _it_ _is_ _against_.

Or send a sed script for doing that[1] - even Linus takes those
for search-and-replace stuff.

[1] sed -i -e 's/[[:space:]]*$//' fs/dcache.c
or, if you are not sending to Linus,
ed fs/dcache.c <<'EOF'
%s/[[:space:]]*$//
wq
EOF

Not applied.  Please, do it sanely.  BTW, which editor is _that_
annoying?  Anything that shoves trailing whitespace in my face
would've been either configured (with considerable cursing at
the people who'd set such defaults) or, should that prove
impossible, given a boot...
