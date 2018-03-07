Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeCGSOE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:14:04 -0500
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:33108 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754578AbeCGSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:13:58 -0500
Date: Wed, 7 Mar 2018 12:13:56 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Chintan Pandya <cpandya@codeaurora.org>
cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Fix misleading 'age' in verbose slub prints
In-Reply-To: <1520423266-28830-1-git-send-email-cpandya@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1803071212150.6373@nuc-kabylake>
References: <1520423266-28830-1-git-send-email-cpandya@codeaurora.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfOlX3EjpGBacdbSRb8h1bJQEv1EgzVHKIxROUSWnsQ76VXsEpXCJmDAqdp2naKe8+ATurQi4wDodtqAa7Y4v+Lh1ZTwHWGY02AT6NysJDQfozwvKaEJ5
 h6frLnlxxpJ4K/4DYwAc0y9QplYxj7xY4mbwJq4CKujsVnaefiloBFXyEXikUzxc0LE57p4S+GMHQ2NOEPsKhiCNFjLWmuB0Lm5RGEYUTe/UnS5JZOFPfCJp
 EAhmXw3QHcvENrYwGh9ItzAWB5Ov4m+dSviEGRdb8KfjgDj+qXhwTGhZt93RMPl7LfyPQaLlXXaJLHASejgl/slalinfxsuB4bn8UvG7y3RPsTsMrSU3QNRH
 q85fv+tg
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018, Chintan Pandya wrote:

> In this case, object got freed later but 'age' shows
> otherwise. This could be because, while printing
> this info, we print allocation traces first and
> free traces thereafter. In between, if we get schedule
> out, (jiffies - t->when) could become meaningless.

Ok then get the jiffies earlier?

> So, simply print when the object was allocated/freed.

The tick value may not related to anything in the logs that is why the
"age" is there. How do I know how long ago the allocation was if I look at
the log and only see long and large number of ticks since bootup?
