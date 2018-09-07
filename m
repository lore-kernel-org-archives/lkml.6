Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE371C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF2620652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixd7bD0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF2620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeIGWcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:32:20 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40133 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbeIGWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:32:19 -0400
Received: by mail-ua1-f65.google.com with SMTP id 101-v6so12566434uav.7;
        Fri, 07 Sep 2018 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PRdkeuot5Y1EgOLCumL4HI5Sx/hUWbupKdYCSWVyVo8=;
        b=Ixd7bD0UpTfxKDDdMX6oCeDF8gt8oQ0sXaQa0tgkX0LRWR/5YHLzMONQpz/VTq3apw
         GxypHk+xOWmb5MKQ89C57DBhkDJzE6rk5/kFnp+0vEqiUz1SDWmL6pLlIYHZ7I/ymv0F
         fX6jUt4f4aQOSjQjMpRiR28dGKQTFMlz1aL+FoXEYwuL5U1JK+FBYtAAq2pUTXgh4yEl
         qYqKNuL6Rh8lrQ7j0Z0jpxCuahPaVH1BbvgASBWstSOI7+99kfP4QoEqEpRXAVRjbAuD
         mo+WhddyBQPZLQAn6j8uyn2oiWnaT8yn55MLB8yQ05Kf0FhJ7rsNyzZLwgUZet9bsyPp
         15zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PRdkeuot5Y1EgOLCumL4HI5Sx/hUWbupKdYCSWVyVo8=;
        b=o6JAVtmBcmteP1OYEo82Gxsvkbl/REwpoSavufOAujDIvCIXYyZGPBnx5Q6XSlC5WH
         gG1ShBDTwHlS/tno1qFFmP6fZBn5CAkRZs5YvEmk1GXjn5n/B/yISERgbfKHtalrb+M6
         C1AhVYLq93s/iVG5xuaCr7kOuhPwGTznrAtMsZ6oDydPCf8+zq/C2Pzs/sjVHptk8kmD
         g9mNI1lu/2wHD8B7xKbAZJe1BGuDzuPpb61rB7ubE+du/1KxXy3F/Ine3F2Se3Pgz6CA
         +vQZeWBRRpOVDi7D7qfioSTCpllRY8dgU3yMGLWYjRU4e/zXR5fzf0IDMVXdP+EJkICJ
         4WqQ==
X-Gm-Message-State: APzg51Ax2EIFfABzSkeeFA3A7MGxlug0r2XgQ178jLYOTKZrp+vwJcPs
        76bHQbKJxPj8jcSFDc1oHA==
X-Google-Smtp-Source: ANB0VdaTcO+nhbiKPQ2/hltDIDcg6272KM7vAB+liXHJjYVhPl97Y2cNIHiA2CGVj8K1KJdglK8SEA==
X-Received: by 2002:a67:4497:: with SMTP id y23-v6mr2959103vsf.7.1536342617911;
        Fri, 07 Sep 2018 10:50:17 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t67-v6sm1691343vkt.7.2018.09.07.10.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:50:16 -0700 (PDT)
Date:   Fri, 7 Sep 2018 13:50:14 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/6] selinux: convert to kvmalloc
Message-ID: <20180907175014.GA29485@kmo-pixel>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-4-kent.overstreet@gmail.com>
 <89c167ff-91d3-7a27-78c6-82710bb11771@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c167ff-91d3-7a27-78c6-82710bb11771@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 02:08:03AM +0900, Tetsuo Handa wrote:
> On 2018/09/08 1:56, Kent Overstreet wrote:
> > @@ -329,8 +328,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> >  		nslot = MAX_AVTAB_HASH_BUCKETS;
> >  	mask = nslot - 1;
> >  
> > -	h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
> > -				     GFP_KERNEL | __GFP_ZERO);
> > +	h->htable = kvmalloc_array(nslot, sizeof(void *), GFP_KERNEL);
> >  	if (!h->htable)
> >  		return -ENOMEM;
> >  
> 
> kvmalloc_array() does not imply __GFP_ZERO.

Thanks, fixed
