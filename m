Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A634520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="B7TkwFe+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rBECeE4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A634520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeKHMLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:11:36 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54567 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbeKHMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:11:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EFCC21C6B;
        Wed,  7 Nov 2018 21:38:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Nov 2018 21:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=r
        vYOAeHJmv9q3O/AQJzG8Fu8E9ZzTvlqMZVkpF0EbPg=; b=B7TkwFe+i9R967VEc
        4J5E5iPsWh1Q4HHUIww0ucbNs4vCX4dZFmYzdySXYLmTndo4qb/YWbGRndL68Gjz
        vUm0rw0MEaSqMLzliOMXYB655/bDhDF6GXqVSpd8Z7wTIkTO4D6VBNPV+hTHI7bJ
        89KgaG55T0jKtLGad3HlTMopv2kto482TjJxtyoGvbvFmkSlFJI/Bj/G2868JfzD
        wn9/ElQC+mSbC3hT5lPIYJuqtRPt6ulkz6FfK4BXWU+nQKB/030EGiDWEpLqpu7m
        cKOtT7UE4nuGAv0s+wh/zWIK3CayW1FLboUbl4NZWsp9StrjkpCoSnOWW2yHAonV
        FfGTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=rvYOAeHJmv9q3O/AQJzG8Fu8E9ZzTvlqMZVkpF0Eb
        Pg=; b=rBECeE4tmNCFENrDCJV8OaAKqr82zfcOU+PzpwYnxfO/1lh7Sgpup+HCo
        gI9mC9rAWjG13MK8q7NzIXuoCcZxESd7fvQ7oUvO5JHsc08Lytbba4zdAT23l6gt
        navCToPoQc8nS2cE3QaCEXtzKDLHJMBk6ApKJepQFuGAEyuzJ+ZPoeGTkgYVNsLq
        ROJzodJIYUBC5ciurkCKeQ4nMOOUiuVmxmcRmL+86iko5FXX9mC+7TfgH38qnj/7
        NRn9YwCn/Jv/n/6RlY+i4dn+h0k7SC3t578GJbj7EmahI6rdAC6KKirV4cF8Vxtt
        S8itzEC73nwHq6m/T/oM6U/7LCYjg==
X-ME-Sender: <xms:naHjW96IIWL9IMKNwiHpwS7TKKx4ldVMgIA5Q93ZtJqRZNQwWvztoA>
X-ME-Proxy: <xmx:naHjWwjHCd-sN9Dw5tW3nP8UoiTQsAJ-7bgPoU5dAF9ngrVCu91-vQ>
    <xmx:naHjW-nbmJ8fbmz_ocBBqWcFhzeDjN8PlBjIdcrk_bEMXJEt2OP9yw>
    <xmx:naHjW6HPG16SSqV8Mvk_JKFib7WqbqnZ5Suq6me_MFf0WSxfIe2z5w>
    <xmx:naHjW_yxw1wqAh-_fwElh8TNvG8MnmIQqTuFkRHNtEjVpr-YIIcU1Q>
    <xmx:naHjWw5obbNPDqp5jwDwbSTN8r0gxYuLA_5OnHKBLy9WrZ4nR5A--A>
    <xmx:nqHjWzEx8MmcsWTM0Zch4dvZqxxRK-211m0yDIcpOZyyJAe8OJROOw>
Received: from localhost (unknown [216.9.110.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0D97E40E6;
        Wed,  7 Nov 2018 21:38:20 -0500 (EST)
Date:   Thu, 8 Nov 2018 02:44:33 +0100
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     wahahab <wahahab11@gmail.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, astrachan@google.com,
        ghartman@google.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
Message-ID: <20181108014433.GB16315@kroah.com>
References: <20181107023043.GA18052@ubuntu>
 <20181107091504.GD31015@kroah.com>
 <F0E33A6C-B2CC-4D8F-8B98-AE096704E038@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F0E33A6C-B2CC-4D8F-8B98-AE096704E038@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 08:49:41AM +0800, wahahab wrote:
> 
> > On 7 Nov 2018, at 5:15 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
> > 
> > On Wed, Nov 07, 2018 at 10:30:43AM +0800, Jerry Lin wrote:
> >> Add a attribute called permissions under vsoc device node for examining
> >> current granted permissions in vsoc_device.
> >> 
> >> This file will display permissions in following format:
> >> begin_offset  end_offset  owner_offset  owned_value
> >>           %x          %x            %x           %x
> >> 
> >> Signed-off-by: Jerry Lin <wahahab11@gmail.com>
> >> ---
> >> drivers/staging/android/vsoc.c | 48 +++++++++++++++++++++++++++++++++++++++---
> >> 1 file changed, 45 insertions(+), 3 deletions(-)
> > 
> > What changed from v2?  And where was v2?  What about v1?
> > 
> > You need a change log here of what you did different from the previous
> > patches.
> 
> Sorry for the mistakes I made, I shall read the document about patches more carefully.
> Here is the change logs:
> 
> Changes in v2:
> 	- Display permissions information in sysfs insureds of debufs.
> Changes in v3:
> 	- Remove unnecessary null terminator after snprintf.
> 
> > 
> > And why ignore my response saying that this type of sysfs file is not ok
> > at all?
> > 
> 
> I didn’t mean to ignore it but I haven’t receive the response you described,
> May you send the response to me again so I can do further revision as well as
> change logs and resubmit the patch again?

You can not have multiple values in a single sysfs file.  sysfs is "one
value per file".  This needs to be individual files, if you really need
this.  And never a "header" for a sysfs file, that's never something
that should ever be in a sysfs file.

And finally, you need a Documentation/ABI/ update for any sysfs file
changes.

thanks,

greg k-h
