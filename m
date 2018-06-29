Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C28C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354C22802F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SuDLjSD7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TX8KX6OD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354C22802F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936235AbeF2VTn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:19:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbeF2VTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:19:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27BA460452; Fri, 29 Jun 2018 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530307179;
        bh=YMjL9Fg/cw9cvnuXQGBGm2QzHTsC1Qt/iJGYMGYk8qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SuDLjSD76MF7rSlnus4LxKGDHBoHAet226CRRQ3rOHX8FQztL5G5gywwTHY8g6sqF
         uvnsLsNLswpRoCRd0/Y+I5ZEjbvb6qp2Li9KLeQf2oxsxagxn4rzDjUNczXKnz/uvI
         pHqxrrriVgOtZ15RI5qFEtrDaiC2yPERQfnNk2Rc=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C67EE606DD;
        Fri, 29 Jun 2018 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530307178;
        bh=YMjL9Fg/cw9cvnuXQGBGm2QzHTsC1Qt/iJGYMGYk8qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TX8KX6ODpS6tInGRoNTfbomo2tu9hpTNB4Ucspx9yF7UgsegaoAU9oCEohqCV4RYw
         fOv4ecm+ODldUdIZYxgi/4920CXCPTD+u9QRk8ZPZoZwU6BpnZDBuT05i+crJGwHWq
         R72HOXt8b7JgT6rFvmHmsohgsjFG0+BToNqlw+yk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C67EE606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 29 Jun 2018 15:19:35 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: Remove VLA usage
Message-ID: <20180629211935.GG24526@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180629184818.GA37439@beast>
 <CAK8P3a3Q9e59uqeZSLw6wqtNZYLe8LVgCO9RQGJB4D0F+3MLdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Q9e59uqeZSLw6wqtNZYLe8LVgCO9RQGJB4D0F+3MLdg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:47:31PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 29, 2018 at 8:48 PM, Kees Cook <keescook@chromium.org> wrote:
> > In the quest to remove all stack VLA usage from the kernel[1], this
> > switches to using a kasprintf()ed buffer. Return paths are updated
> > to free the allocation.
> >
> > [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  7 +++++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 28 +++++++++++++++++--------
> >  2 files changed, 24 insertions(+), 11 deletions(-)
> 
> This seems fine, though using a fixed-length string is probably just
> as well here,
> given that the 'fwname' variable is always set to the constant string
> "a530_zap.mdt"
> at the moment, which is not very long.

We could make it fixed but since this code is only called once this
feels safer.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
