Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeFAPTN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:19:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49933 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753048AbeFAPTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:19:10 -0400
Date: Fri, 1 Jun 2018 17:19:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, baijiaju1990@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-clk@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for
 printk format %pCr
Message-ID: <20180601151905.yilldc6vbachfw4k@pathway.suse.cz>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
 <20180601114738.kdoggkha2yosjgbv@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601114738.kdoggkha2yosjgbv@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-06-01 13:47:38, Petr Mladek wrote:
> On Fri 2018-06-01 06:00:47, Linus Torvalds wrote:
> > On Fri, Jun 1, 2018 at 4:29 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > >
> > > This patch series:
> > >   - Changes all existing users of "%pCr" to print the result of
> > >     clk_get_rate() directly, which is safe as they all do this in task
> > >     context only,
> > >   - Removes support for the "%pCr" printk format.
> > 
> > Looks good to me.
> > 
> > What tree will this go through? The normal printk one? Just checking
> > that this doesn't end up falling through the cracks because nobody
> > knows who would take it...
> 
> I will take it via printk.git. There already is bunch of vsprintf
> changes for-4.18.

It is in printk.git, branch for-4.18-vsprintf-pcr-removal now.

Also I have added Cc: stable@vger.kernel.org into the commit messages.

Best Regards,
Petr
