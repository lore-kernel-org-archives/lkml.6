Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43104C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F073F2064E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yqvdHwKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F073F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeJLShI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727640AbeJLShH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:37:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DFEB20868;
        Fri, 12 Oct 2018 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539342313;
        bh=+vDSeJ6z+V2OSQOh/gem8wtpTRkNzrVqx5d7uL9eUPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqvdHwKFzvRF095jhn8KuFFgAU63qDgIm8+GTPfUln8842vw/WxVFI009/ChmBIu2
         4Wsp6dvbaX2TBW+oWwo5Jfdlzv867Ljel5G2IeVb7piwpNEBB8mbwEfRB33G5d8Awa
         Pg+z9t+qYnZdobcIF3Locy7jL8jweM+2DFFykfec=
Date:   Fri, 12 Oct 2018 13:05:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amit Pundir <amit.pundir@linaro.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, prsood@codeaurora.org,
        Tejun Heo <tj@kernel.org>, amit.pundir@linaro.org
Subject: Re: [PATCH 4.14 29/45] cgroup/cpuset: remove circular dependency
 deadlock
Message-ID: <20181012110511.GB26625@kroah.com>
References: <20181011152508.885515042@linuxfoundation.org>
 <20181011152510.156825448@linuxfoundation.org>
 <CADVatmO4qd2D7j9AuVWX29ODMd9xV7-ndMSv+dfFatT60h+mzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmO4qd2D7j9AuVWX29ODMd9xV7-ndMSv+dfFatT60h+mzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:33:34PM +0100, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, Oct 11, 2018 at 4:54 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Prateek Sood <prsood@codeaurora.org>
> >
> > commit aa24163b2ee5c92120e32e99b5a93143a0f4258e upstream.
> 
> This has been already reverted in upstream.
> bdfbbda90aeb ("Revert "cgroup/cpuset: remove circular dependency deadlock"")
> 
> Might be better to add e8b3f8db7aad ("workqueue/hotplug: simplify
> workqueue_offline_cpu()") instead which is mentioned in the revert
> commit.

Good point.  I'm dropping this patch for now.

Amit, can you test the above patch instead and figure out why you wanted
to add a patch to the tree that ended up being reverted?  :)

thanks,

greg k-h

> 
> -- 
> Regards
> Sudip
