Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA232082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA232082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeJBA5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:57:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44033 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:57:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so10020409pgu.11;
        Mon, 01 Oct 2018 11:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VetK6gfSEbLmIt2s8/EsyZD32iONqi7+KRCNkgcKH0E=;
        b=pnpPxXQQkPd4cDZp/am6qIEcvDVT5IyZbklZsWbGxCvfUGbNASDbtahj5zY6tf2ASb
         psAqFTM/XmIyvpkhtuE/uHXxb4iSyK6pdvoxnh+uZN5HNkdwsnmDI4uZjVrnYwMdEzln
         azXm3ZMa6vbS4Y9j24TYAIsAE+hSJX94ZhHc08ORHtBsdbitG5kkeBkUH47PtJcnSVNX
         18w1OYvKdTNhFH7uv5LKsqwExAxukN/VM4maVLBZ+1b88W0KQEDJIAK6olsEzs1Zaw46
         7SRAcNyrcp+qDEWJ8e19tJzSM3Fge4q27LltXIi+lWMgSPc9iB6vDiqmGbWuk8S6yF3D
         HsQg==
X-Gm-Message-State: ABuFfohaF/QlbNqS986cJ8I1XE+WCxp+29lDEldQy9zPVSjO4vnJ9Roo
        lM2v0lC9jXfeczCeu/mAwgM=
X-Google-Smtp-Source: ACcGV639x9VxKz3qylyTRAAxLAFDrvnhbocX8XKf5R8ivpKdUgJyUTJ0dyblhBVPW0QTErp0MKbzjg==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr12899006pld.145.1538417918602;
        Mon, 01 Oct 2018 11:18:38 -0700 (PDT)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id r73-v6sm8987228pfk.157.2018.10.01.11.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 11:18:37 -0700 (PDT)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 01 Oct 2018 11:18:35 -0700
Date:   Mon, 1 Oct 2018 11:18:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH] firmware: Always initialize the fw_priv list object
Message-ID: <20181001181835.GG5238@garbanzo.do-not-panic.com>
References: <20180920010938.10315-1-bjorn.andersson@linaro.org>
 <20180920052204.GA15695@kroah.com>
 <20180920073415.GC1367@tuxbook-pro>
 <20181001132703.GA12193@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001132703.GA12193@centauri.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 03:27:03PM +0200, Niklas Cassel wrote:
> On Thu, Sep 20, 2018 at 12:34:15AM -0700, Bjorn Andersson wrote:
> > On Wed 19 Sep 22:22 PDT 2018, Greg Kroah-Hartman wrote:
> > 
> > > On Wed, Sep 19, 2018 at 06:09:38PM -0700, Bjorn Andersson wrote:
> > > > When freeing the fw_priv the item is taken off the list. This causes an
> > > > oops in the FW_OPT_NOCACHE case as the list object is not initialized.
> > > > 
> > > > Make sure to initialize the list object regardless of this flag.
> > > > 
> > > > Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >  drivers/base/firmware_loader/main.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > Is this being triggered by some hardware somewhere today?  Or is this
> > > just a fix found by code inspection?
> > > 
> > 
> > Hi Greg,
> > 
> > Yes, I found this issue while attempting to load the firmware and boot
> > one of the DSPs on one of my Qualcomm dev boards after v4.19-rc4 and it
> > can be reproduced on the upstream Dragonboard 820c.
> 
> I still see this issue on v4.19-rc6.
> 
> It would be nice if this fix gets merged before v4.19 gets released.

This is the first I hear of this and this patch, so you should re-send
it and I can review it. Also please Cc Rishabh.

Rishabh, had you heard of this and can you confirm as well as
422b3db2a503 was your commit?

  Luis
