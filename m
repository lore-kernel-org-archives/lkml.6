Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68ADC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6228A20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcer1D9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6228A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIKVaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:30:39 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44231 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:30:39 -0400
Received: by mail-yb1-f194.google.com with SMTP id l16-v6so9555369ybk.11;
        Tue, 11 Sep 2018 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nqe4YOvPLCAPDqyOWnOJsyrzWUknn+6+rWQqCYQvNoY=;
        b=gcer1D9Mtad2TN8qhs7mO197yZbL0t54GXhsR4fu0a7CdreH1Q8nx4XYXznzHjHwFR
         qqCAl8J/JBwTh+wK+Zn+nQJ0u3xO/Pa/lwLNxC5OsOU4OlaofssiIOuWobDDQApyfRFx
         yqJQoUXme6FEOBRi5FlOrNCJ04T/mrbt5SCsIouzjBk5znxVZLGb8ric2iIxBrDAg985
         u6qXw2Z80U3q8VlnZktGtrsUDJcR7wlqlQOT0p81RwlDZcD2HYS93U3/j4hI/BCm8war
         iciYEi+lJW7E6zvswNSEk89AIUthOzMAFod4r0nRmfyukF9fiNP6/EtxSThy7Y4UmWkb
         ALEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nqe4YOvPLCAPDqyOWnOJsyrzWUknn+6+rWQqCYQvNoY=;
        b=uKvfFt9vPRxS1huDEHfG3Aj9scAN04IQSu8rJ/+a4zgJ2juwVpO7KTcUT57kkFnYZx
         aZTQbytV7BtWtwcNns1svt3yDPHvMipk4KAFYcjLuo4nIAgCuQk1yCfpXXF0HbTrQRVW
         0TvbN5Oklp5aVlh5dFHLDSLXVFkVgxyv1Yd+oWAWdWWku+7MlLeAH8CFmmVum+OaSXEx
         BVa0LH15pdHNS0vKaCnsmABbM3M13ALvLbYsEJl10F1OREvE+OtpVqfCswFgaxwMB65X
         BihCUn7VIjupxVMDODwLCWXhNEXsyAxarOhfsy9/6lTEwWtpPN72u9y2PGdChCjuwK1M
         qU+g==
X-Gm-Message-State: APzg51By9dWMYGBJnp9DjJQIotKOuYT3Vw4f8VVbV+FWXqtWqTpV9tB4
        RjB3jeXWY72sAca1VwldIzOEvHAW
X-Google-Smtp-Source: ANB0VdY23IkxeEk92oXwd61u3jXfndYvuk/I+bdNm1bsZT7JS3whFSNoU2smtZavKDO475PbQSQICg==
X-Received: by 2002:a25:8b:: with SMTP id 133-v6mr13281162yba.11.1536683434831;
        Tue, 11 Sep 2018 09:30:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id j66-v6sm7596383ywc.61.2018.09.11.09.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:30:33 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:30:32 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911160532.GB10082@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:05:33AM +0800, Ming Lei wrote:
> On Tue, Sep 11, 2018 at 08:49:59AM -0700, Tejun Heo wrote:
> > On Tue, Sep 11, 2018 at 11:45:41PM +0800, Ming Lei wrote:
> > > > So, this part seems wrong.  The function is called percpu_ref_reinit()
> > > > - the refcnt is expected to be in its initial state with just the base
> > > > ref once this function returns.  If you're removing the restriction on
> > > 
> > > But the comment says that 'Re-initialize @ref so that it's in the same
> > > state as when it finished', and this invariant isn't changed with this
> > > patch.
> > 
> > The comment goes "when perpcu_ref_init() finished".  The function is
> > called re _init_.  It should put the ref in the initial state, right?
> 
> OK, I am fine to keep the behaviour for this API, will introduce a new helper
> for NVMe.

Why aren't switch_to_atomic/percpu enough?

> However, it is doable to switch to percpu mode from atomic mode when it
> doesn't drop to zero, looks like sort of perpcu_ref_reinit(inherit_old_refcount).

Isn't that way more contorted than just switching operating modes?

Thanks.

-- 
tejun
