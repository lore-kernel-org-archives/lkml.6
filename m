Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeB0UOF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:14:05 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40979 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbeB0UOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:14:04 -0500
Date: Tue, 27 Feb 2018 21:13:55 +0100
From: Willy Tarreau <w@1wt.eu>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: geert@linux-m68k.org, andy.shevchenko@gmail.com, rabel@robertabel.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] auxdisplay: charlcd: Fix and clean up handling of
 x/y commands
Message-ID: <20180227201355.GA27525@1wt.eu>
References: <20180227193118.n33bkbrqxybfhgdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227193118.n33bkbrqxybfhgdc@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 08:32:21PM +0100, Miguel Ojeda wrote:
> The current version is not parsing multiple x/y commands as the code
> originally intended. On top of that, kstrtoul() expects
> NULL-terminated strings. Finally, the code had to do two passes over
> the string, while now only one is done.
> 
> Some explanations about the supported syntax are added as well.

Thanks Miguel for doing this. To be fair, I personally think that the code
was significantly complexified compared to the original version, just for
the purpose of using one library function designed to multiply by ten and
add a number. Not to mention that it now requires a copy before parsing.
For me it simply means that the initial code change was a wrong idea in
the end. But at least with your version, the bugs introduced by the
previous "fix" should now be gone, which is a good thing.

Thanks,
Willy
