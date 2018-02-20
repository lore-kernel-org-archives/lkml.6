Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeBTPDL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:03:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeBTPDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:03:10 -0500
Date: Tue, 20 Feb 2018 07:03:06 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc-guide: kernel-doc: add comment about formatting
 verification
Message-ID: <20180220150306.GE21243@bombadil.infradead.org>
References: <1519138484-29023-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519138484-29023-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:54:44PM +0200, Mike Rapoport wrote:
>  level.
>  
> +Running the ``kernel-doc`` tool with increased verbosity and without actual
> +output generation may be used to verify proper formating of the

"formatting"

> +documentation comments. For example::
> +
> +	scripts/kernel-doc -v -none drivers/foo/bar.c
> +
>  Function documentation
>  ----------------------

And that's not exactly true.  "make W=1" will run that exact command.
For example:

$ make W=1 net/ipv4/
(...)
  CC      net/ipv4/tcp_input.o
net/ipv4/tcp_input.c:4279: warning: Excess function parameter 'dest' description in 'tcp_try_coalesce'
  CC      net/ipv4/tcp_output.o
net/ipv4/tcp_output.c:3177: warning: Function parameter or member 'sk' not described in 'tcp_make_synack'
(...)

perhaps sneak that information in there somewhere.

Also it'll prompt people to run with W=1, so perhaps they'll fix their
more-easily-fixed warnings ;-)
