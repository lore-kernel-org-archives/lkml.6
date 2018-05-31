Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbeEaMNP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754637AbeEaMNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:13:13 -0400
Date: Thu, 31 May 2018 14:12:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
Message-ID: <20180531121251.GA13561@kroah.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com>
 <d2ed4f7c-f97c-ba51-6f33-d329da69dbc6@dd-wrt.com>
 <510e5f2c-718a-de42-8274-9345d13e7797@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <510e5f2c-718a-de42-8274-9345d13e7797@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 06:55:55AM -0500, Timur Tabi wrote:
> On 5/31/18 6:53 AM, Sebastian Gottschall wrote:
> > > 
> > i checked initially 4.9 with latest patches and 4.14 and reverted this
> > line to get back to the old behaviour but a which view in the current
> > 4.17 tree shows
> > that the same patch has been included in 4.17. it was introduced in the
> > kernel mainline on 12.feb 2018
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pinctrl/qcom/pinctrl-msm.c?h=v4.17-rc7&id=a7aa75a2a7dba32594291a71c3704000a2fd7089
> 
> I believe that this patch should not be applied to *any* stable kernel.
> 
> It completely breaks legacy GPIO numbering, and it does so intentionally.
> That may be okay for future kernels, but IMHO it's wrong for older kernels.

Why is it somehow ok for "future" kernels?  You can't break the api in
the future for no reason.

So this needs to be the same everywhere.  If it is broken in 4.17-rc, it
needs to be reverted.

thanks,

greg k-h
