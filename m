Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0F8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF5220C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdj/lP0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF5220C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeHTTsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:48:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45664 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeHTTsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:48:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so7007592pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KmKwhyDP7emF1fDF4MnZfHtdqJJxNAkJn3NUIL8EfKw=;
        b=Kdj/lP0GLF+en76e06U6EGubgMWI88294nTrhwqstkFze0XmGGGWeApbHtT/KvbvB9
         hMijoIY/Jhr/GrFQ2iZXAq3VjmIwsVhmalN2TYTHTYlzGrkXhf7ut2858r+jTV8cHyZV
         ZesyZbu7xV/T+citB9jSiHmqS3dGcyRtbjTDle5bGOthSsri0fNqc8fAAMAPoZ7exqx8
         /euqdZK0OQk6zxbF+XZ/Fl0271mvB54V2N1axsli1DCPt7AEgWlg+Za7awLy2UkNE+Nh
         CYyft9qRl609JBGiCqsW/jNOXswtsGuQIwC+8LLdmPLPba15ARvi6n9pjcW189nxrDyB
         4ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KmKwhyDP7emF1fDF4MnZfHtdqJJxNAkJn3NUIL8EfKw=;
        b=YkDJYXds3biCpoE+wBssUxLQo1BBfnpnJeKGZc2IOR2TqI0f0qYXR09ZJXchSGVCew
         rRO7nqyv31qX6BGO4dYJo8WMfwWZAWhlOa6RWesZO2PvtU0Sc1eBaYBt9IK0dudHCaM3
         Z/os39kc7RV7xLzrkNSO7ExK7a1oyuV52XBMW0K19cazNh03lH0OGuOyDJBAS32nDJlR
         wD9uauuVamwIkpQ4M5kXwy/L0Du+O5v7Y7r901f/MIiHjDx8iowO/JCOqEmZep+DuWrN
         VcaSIzC2qde3f+/Kyoxc7UwPb32e3LRqce2cZRXquZ155R1eRCv/ObeEoqCblhRNsaQj
         9hlw==
X-Gm-Message-State: AOUpUlFvo2bYm5dFx3D6pJaOnkN+a4EdAyiB2dkfxQTPJp+oZY7p1eBT
        ezbI70qbjjknwrDQzyQlPmg=
X-Google-Smtp-Source: AA+uWPzrmqdZ0f21JHe1c+zTp2AB5TH1c/jUZSH0MGezR584b2QhASQjU4ftMO7NSDW12DIRsPmJKg==
X-Received: by 2002:aa7:84c2:: with SMTP id x2-v6mr41479236pfn.220.1534782737029;
        Mon, 20 Aug 2018 09:32:17 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id c1-v6sm21679829pfg.25.2018.08.20.09.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 09:32:16 -0700 (PDT)
Date:   Mon, 20 Aug 2018 22:02:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3] staging: mt7621-mmc: Fix debug macros and their usages
Message-ID: <20180820163154.GA15968@nishad>
References: <20180819100458.GA13296@nishad>
 <20180819113401.GB18715@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819113401.GB18715@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 01:34:01PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 19, 2018 at 03:35:02PM +0530, Nishad Kamdar wrote:
> > Fixed four debug macros and their usages. Replaced printk with
> > dev_<level> without __func__ or __LINE__ or current->comm and
> > current->pid. Further removed the do {} while(0) loop for single
> > statement macros.
> > Out of the four, replaced all usages of ERR_MSG and IRQ_MSG with
> > dev_err() in the code itself and dropped them from dbg.h.
> > Removed all INIT_MSG usages and dropped it from dgb.h.
> > Issues found by checkpatch.
> 
> This needs to be multiple patches.  One for each type of macro you are
> deleting/changing, not all lumped together into one big patch.
> 
> Plaese fix that up and resend.
> 
> thanks,
> 
> greg k-h

Ok, I'll do that.

Thanks for the review.

regards,
nishad


