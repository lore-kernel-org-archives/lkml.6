Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755689AbeEaQEs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755675AbeEaQEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:04:45 -0400
Date: Thu, 31 May 2018 18:04:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
Message-ID: <20180531160419.GA16172@kroah.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com>
 <d2ed4f7c-f97c-ba51-6f33-d329da69dbc6@dd-wrt.com>
 <510e5f2c-718a-de42-8274-9345d13e7797@codeaurora.org>
 <20180531121251.GA13561@kroah.com>
 <2898aafa-e185-8ad5-5f7f-9b81d4a36a8f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2898aafa-e185-8ad5-5f7f-9b81d4a36a8f@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:09:50AM -0500, Timur Tabi wrote:
> On 5/31/18 7:12 AM, Greg Kroah-Hartman wrote:
> > Why is it somehow ok for "future" kernels?  You can't break the api in
> > the future for no reason.
> > 
> > So this needs to be the same everywhere.  If it is broken in 4.17-rc, it
> > needs to be reverted.
> 
> This was discussed here:
> 
> https://www.spinics.net/lists/linux-arm-msm/msg32572.html
> 
> The code can't program the value to 0 *and* support multiple TLMM devices at
> the same time.  Prior to 4.18, it is not possible to support multiple TLMMs
> anyway, so blindly setting the base to -1 in the 4.17 kernel just breaks
> existing user-space code that uses the legacy GPIO API.
> 
> (This patch in 4.18 is what provides support for multiple TLMMs: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/pinctrl/qcom?id=f265e8b91bb50c7a732a171ddaeb0eef143bacd9)
> 
> So you can see in the thread that I proposed a compromise:
> 
> https://www.spinics.net/lists/linux-arm-msm/msg32596.html
> 
> but that was rejected

Ugh, ok, you all have fun with this :(

I've reverted it from all of the stable trees, again, sorry for it
coming back.

greg k-h
