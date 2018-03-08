Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936048AbeCHSJw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:09:52 -0500
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:39334 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933221AbeCHSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:09:51 -0500
Date: Thu, 8 Mar 2018 12:09:49 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Chintan Pandya <cpandya@codeaurora.org>
cc: Matthew Wilcox <willy@infradead.org>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix misleading 'age' in verbose slub prints
In-Reply-To: <da1be252-403f-6725-a1b8-223222f7f946@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1803081204230.14628@nuc-kabylake>
References: <1520423266-28830-1-git-send-email-cpandya@codeaurora.org> <alpine.DEB.2.20.1803071212150.6373@nuc-kabylake> <20180307182212.GA23411@bombadil.infradead.org> <da1be252-403f-6725-a1b8-223222f7f946@codeaurora.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfJVKUAmpm5Tr1XYPCWphAvU+gD4wFLCXiZOOJkSzuFFBqqfxK57Y+RoPbwBZwOAuRncnNTnsl2kqAL2dnu6FUfDQhonBG/sdtoTI744eTn4ctm77tgqX
 VzgDYjkQi0Q/5r3hizZMUiQFua69IgLlnxp1AgOAIIm0mf24y0tW9xjllF+SwzQg3CamZ7fByHXqSwnWEOKBbNLeQl6p5cugR9AfCqLgqYgoD+nHaP8foZ6/
 owjfwrWKis4MsondOq3j4xmXqtuTPU6HJTztXHmnZ8fPKXzeM2yRrc5iHGaXik18DjkQ7AiV2yyn/E4U7HcJbzPDodE33pRrAVBIm2ernc7asoYfIrgJXkwH
 FdOk86d/NzHuPPjAH904uB7IlkfdbEjqPMh/sJgZHUpR/OSlBXA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2018, Chintan Pandya wrote:

> > If you print the raw value, then you can do the subtraction yourself;
> > if you've subtracted it from jiffies each time, you've at least introduced
> > jitter, and possibly enough jitter to confuse and mislead.
> >
> This is exactly what I was thinking. But looking up 'age' is easy compared to
> 'when' and this seems required as from Christopher's
> reply. So, will raise new patch cleaning commit message a bit.

Well then you need to provide some sort of log text processor I think.
Otherwise you need to get the object address from the log message, then
scan back through the log to find the correct allocation entry, retrieve
both jiffy values and subtract them. If the age is there then you can
simply see how far in the past the object was allocated.

One advantage in favor of jiffies would be the ability to correlate
multiple events if each log line would have a jiffies like timestamps.

But it does not. So I think outputting jiffies there is causing more
problems that benefits.
