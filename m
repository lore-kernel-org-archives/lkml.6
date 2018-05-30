Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeE3N7L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:59:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49594 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeE3N7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:59:09 -0400
Date: Wed, 30 May 2018 15:58:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Jay Cliburn <jcliburn@gmail.com>, Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rakesh Pandit <rakesh@tuxera.com>, netdev@vger.kernel.org,
        Emily Chien <emily.chien@canonical.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Stezenbach <js@sig21.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "alx: remove WoL support"
Message-ID: <20180530135859.GB27537@lunn.ch>
References: <20180530021008.15080-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530021008.15080-1-acelan.kao@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:10:08AM +0800, AceLan Kao wrote:
> This reverts commit bc2bebe8de8ed4ba6482c9cc370b0dd72ffe8cd2.
> 
> The WoL feature is a must to pass Energy Star 6.1 and above,
> the power consumption will be measured during S3 with WoL is enabled.
> 
> Reverting "alx: remove WoL support", and will try to fix the unintentional
> wake up issue when WoL is enabled.

Hi AceLan

I find this change log entry rather odd.

If i remember correctly, you first argued that you did not want to
have to distribute out of tree patches.

It was suggested that you might be able to justify the revert using
the argument that the cure is worse than the decease. You ignored
that, and when with this Energy Star argument. That got shot down by
DaveM, and told to actually try to find the problem.

So you then come back and said you think the problem is fixed, but
don't know exactly what fixed it. So DaveM said try again.

Now you are back to Energy Star.

I don't get this. It was the fact you said it was probably fixed that
made DaveM reconsider. That is the argument you should be using in the
change log. We want to know what testing you have done. See a
tested-by: from somebody who had the issue which caused the revert,
and now says the issue is fixed.

Ideally we would like to know which change actually fixed the issue,
so it can be added to stable. But that requires somebody to do a long
git bisect.

    Andrew
