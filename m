Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E85C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7A0208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PCpTldtX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2L/QNZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7A0208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeHWImU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:42:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47595 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbeHWImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:42:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F95421F4D;
        Thu, 23 Aug 2018 01:14:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 Aug 2018 01:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=DFf3vk8fgpFTesDSsGWDd8xAek1Ax5xw+vESOD0XAbY=; b=PCpTldtX
        YJ1nm2z6guZMNc86Q9/qPeMmfsH8MJ0dSexto/ZdLNCRWBrXjOM4ymNjSW4TURnO
        ruOeEFxUZlzi7WrqBAwyhaP88BIjRHqzI8v4jY3lOtZWla+9cEC04tlLRIWNikDC
        4ZYE2RlbWo9HzWwiGs6u9a+JCrSnji6OJiFIwlG7ruqKYSrr/bjqPKgYQvdtSmob
        UpVcRqIwYK/FeaKnC0jaCbt/wJ1xtTuCuUS64ofiXWKwl1gDIbbcOj3P5ltm1OSQ
        IIYlbxcOLZNgtGEycoYoM+zLJ6MzSQAsETsLE+nUAxUvLTS5iT5drGIumWj6A2Nx
        ZvDYQp1fLRG3+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=DFf3vk8fgpFTesDSsGWDd8xAek1Ax
        5xw+vESOD0XAbY=; b=L2L/QNZzODYajqpOO1ZdEMPh2mk1HKNiDuyYNoMJA3axg
        +aIzSnxtoABXYQMB29wwpBuxa9upYzJbiMbcBw9ljZAb5S45R4xNz+PWxZElGLzD
        +G0Srb1TSZ+BXoZF9RYOlY6azk2kkWZhNITOOWU3Y70AbMvkLnqSbo5OHxNsvknm
        G1RnYWeMOT74TAtS1Yx4zf6P9zTQnkuOGtr5UOvO8KJ7swCPEeoxRweMVkckKfYX
        SK5Xsnte5i1+ds9ZiF+XNylSyVJEWHrrLefaa2nWIHwh/sR3o29zzaTLW0HbsItU
        3B0gvGut/g3mNcZGi3mGjwmhSchbzZKxznKavFdbg==
X-ME-Proxy: <xmx:sEJ-W4GX2cdTzNu5tb2o8Gg67WXHWdHqeiNFX8tbAnnumy_p7mAQlA>
    <xmx:sEJ-W6TldQjfi2APMW1iwh8H69PsvNBrUMYAJexVjW1b2IJSXOZJXg>
    <xmx:sEJ-W0EKTA8ugfJkH2VowIXmzfKQEpmU7xptEyBv0I-PO5AsUeysYw>
    <xmx:sEJ-W292F4KUmaO2coyD7_UrXM3EyhIfOdomc0148qEAMewQnfIggA>
    <xmx:sEJ-W-Iei5qzbIm00H4Q9YvDQ6U3Iu8lRyKNjfl3fdWuYjmsWQtKgw>
    <xmx:sUJ-WyDk4-iZpJuZcSjEtW8VD9KZHRSVZiNELFjOgRq_lOJ6BymLYQ>
X-ME-Sender: <xms:sEJ-W0dr0cy8IjIsWzcYFtqqHLhDCjhiZ7Owx7j0qvnG6lV20_K04A>
Received: from localhost (5355525a.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35DFA10255;
        Thu, 23 Aug 2018 01:14:24 -0400 (EDT)
Date:   Thu, 23 Aug 2018 07:14:22 +0200
From:   Greg KH <greg@kroah.com>
To:     pheragu@codeaurora.org
Cc:     Linux-arm Msm <linux-arm-msm@vger.kernel.org>,
        Linux Usb <linux-usb@vger.kernel.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ckadabi <ckadabi@codeaurora.org>, Tsoni <tsoni@codeaurora.org>,
        Bryanh <bryanh@codeaurora.org>,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        Rnayak <rnayak@codeaurora.org>, psodagud@codeaurora.org
Subject: Re: Reminder to review series of patches
Message-ID: <20180823051422.GA5310@kroah.com>
References: <c0fd219eeba038e4d2375f5ff9c29ff8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fd219eeba038e4d2375f5ff9c29ff8@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:57:28PM -0700, pheragu@codeaurora.org wrote:
> This is reminder to review a series of patches sent a
> week ago pertaining to EUD driver. These are the links for
> the patches -
> 
> https://patchwork.kernel.org/cover/10568275/ - cover-letter
> https://lore.kernel.org/patchwork/patch/975228/ - dt-binding
> https://patchwork.kernel.org/patch/10568281/ - EUD driver

It is the middle of the merge window, no new code can be merged into any
trees right now, and maintainers are busy with keeping up with the merge
issues.  Please wait until after 4.19-rc1 is out to worry about this.

thanks,

greg k-h
