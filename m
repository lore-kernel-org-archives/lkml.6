Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeA3SHl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:07:41 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:46402 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeA3SHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:07:39 -0500
X-Google-Smtp-Source: AH8x227ack8bAvm0ZGlpqtAY1JPDywreo9P01y+KI+WzWjh7p7N7BUZvXgq0Nlxj0PW2aa2kNmW/kg==
Date: Tue, 30 Jan 2018 10:07:36 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>
Cc: linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        it+linux-input@molgen.mpg.de
Subject: Re: i8042 AUX port [serio1] suspend takes a second on Dell XPS 13
 9360 and TUXEDO Book 1406
Message-ID: <20180130180736.ehucqywbz7zdl4v7@dtor-ws>
References: <5a74e1a7-2083-c6b2-f51a-f44908ac8bc4@molgen.mpg.de>
 <20180130175017.72inurhk5l7tcvae@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130175017.72inurhk5l7tcvae@dtor-ws>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 09:52:45AM -0800, Dmitry Torokhov wrote:
> Hi Paul,
> 
> On Tue, Jan 30, 2018 at 06:36:34PM +0100, Paul Menzel wrote:
> > Dear Linux folks,
> > 
> > 
> > I do not know, when it started, but with Linux 4.14-rc8 and 4.15,
> > benchmarking suspend and resume time with `sleepgraph.py` [1][2], there is a
> > regression, that i8042 AUX port [serio1] suspend takes a second on Dell XPS
> > 13 9360 and TUXEDO Book 1406.
> 
> It would be really helpful to know when the regression started.

So the reason it takes longer is because the touchpad does not want to
talk to us for some reason and we wait until commands time out:

[   94.591636] calling  serio1+ @ 2299, parent: i8042
[   94.794292] psmouse serio1: Failed to disable mouse on isa0060/serio1
[   95.593303] call serio1+ returned 0 after 974280 usecs

but it is not clear why it happens, I do not think we changed anything
in that path for a while, so it might be some other change affecting
things indirectly. I'm afraid you'll have to narrow the scope, and
ideally bisect.

Thanks.

-- 
Dmitry
