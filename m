Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbeDMNFI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:05:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:10833 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeDMNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:05:06 -0400
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq7U2oCocl772u2XiabRKKbHM1HYja5N/pDsB6V17g==
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] random: fix crng_ready() test
Date: Fri, 13 Apr 2018 15:05:01 +0200
Message-ID: <4393662.RPWnPK42dp@tauon.chronox.de>
In-Reply-To: <20180413125313.GA2633@thunk.org>
References: <20180413013046.404-1-tytso@mit.edu> <1699469.KmO53oa8XU@tauon.chronox.de> <20180413125313.GA2633@thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. April 2018, 14:53:13 CEST schrieb Theodore Y. Ts'o:

Hi Theodore,
> 
> This was always the original design intent, but I screwed up and no
> one noticed until Jann reached out to be and said, "Hey.... this
> doesn't seem to make much sense".

I disagree, but I guess you would have expected that. But this is not the 
issue.

What I would like to point out that more and more folks change to 
getrandom(2). As this call will now unblock much later in the boot cycle, 
these systems see a significant departure from the current system behavior.

E.g. an sshd using getrandom(2) would be ready shortly after the boot finishes 
as of now. Now it can be a matter minutes before it responds. Thus, is such 
change in the kernel behavior something for stable?

Ciao
Stephan
