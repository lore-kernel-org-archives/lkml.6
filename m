Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755896AbeDZKg4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:36:56 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:35619 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755862AbeDZKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:36:53 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Date: Thu, 26 Apr 2018 12:36:50 +0200
Message-ID: <4153280.6zxFApgOmi@merkaba>
In-Reply-To: <20180426061108.GB4977@amd>
References: <20180425154602.GA8546@bombadil.infradead.org> <20180426061108.GB4977@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek - 26.04.18, 08:11:
> On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
> > Recently ncpfs got moved to staging.  Also recently, we had some
> > fuzzer developers report bugs in hfs, which they deem a security
> > hole because Ubuntu attempts to automount an inserted USB device as
> > hfs.
> 
> We promise "no-regressions" for code in main repository, no such
> promise for staging. We have quite a lot of code without maintainer.
> 
> Moving code to staging means it will get broken -- staging was not
> designed for this. I believe moving anything there is bad idea.
> 
> Staging is for ugly code, not for code that needs new maintainter.

Good point.

Moving things in and out to some "unmaintained" directory… I am not sure 
about that either. I tend to think that moving code around does not 
solve the underlying issue.

Which, according to what I got from Matthew, was that distributors 
enable just about every filesystem they can enable which lead to hfs 
being used for automounting an USB stick formatted with it.

In the end what may be beneficial would be hinting distributors and 
people who compile their own kernels at what features are considered 
stable, secure and well tested and what features are not, but how to 
determine that? The hint could be some kernel option flag that would be 
displayed by make *config. But then it probably needs also a 
justification or at least a link to more information.

Actually did ever someone audit the whole kernel source?

Thanks,
-- 
Martin
