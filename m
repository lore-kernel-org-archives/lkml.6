Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeDYOzH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:55:07 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:60488 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeDYOzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:55:03 -0400
Date: Wed, 25 Apr 2018 15:54:59 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Mike Galbraith <efault@gmx.de>
Cc: Ferry Toth <ftoth@telfort.nl>, linux-kernel@vger.kernel.org
Subject: Re: DOS by unprivileged user
Message-ID: <20180425155459.5a4e40e0@alans-desktop>
In-Reply-To: <1524470676.5451.1.camel@gmx.de>
References: <9023506.UBh6vynRGa@delfion>
        <4285098.DEWjdbWF2X@delfion>
        <1524325275.8078.2.camel@gmx.de>
        <6057755.ozdVOybsI6@delfion>
        <1524470676.5451.1.camel@gmx.de>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think memory allocation and io waits can't be decoupled from
> > scheduling as they are now.  
> 
> The scheduler is not decoupled from either, it is intimately involved
> in both.  However, none of the decision making smarts for either reside
> in the scheduler, nor should they.

It belongs in both.

Classical Unix systems never had this problem because they respond to
thrashing by ensuring that all processes consumed CPU and made some
progress. Linux handles it by thrashing itself to dealth while BSD always
handled it by moving from paging more towards swapping and behaving like
a swap bound batch machine.

Linux thrashes itself to death, the classic BSD algorithn instead throws
fairness out of the window under extreme load to prevent it. It might take
a few seconds but at least you will get your prompt back.

Alan
