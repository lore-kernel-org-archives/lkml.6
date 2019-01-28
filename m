Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04068C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D3F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548687253;
	bh=8iwK0U6yXTos4t9tfbpOGS64qvqRgSHy0rTvvz/n5No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JdpxhYc4Qf7ZXpw+1A/EmUz4Gh1jVTJuo/XC63MdrFsqEVTB/yd+AahXT7gXywd6C
	 1Q1CVXBHpHFkPQ7dD8KtEU+5rFlISatedokKYin8wNeBJPtfyPZb9FtI2ViI7AKyaM
	 FQV0ai92czNscRudH74ftZ6pXKeUAKTgsxQT6Qg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfA1OyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:54:12 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46640 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1OyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:54:11 -0500
Received: by mail-yw1-f66.google.com with SMTP id t13so6790242ywe.13;
        Mon, 28 Jan 2019 06:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RNZJDYS78cHBuBaASjYOvQ9Ko3WT0Xjzjo+ql6w9VUw=;
        b=sFfs8X5eh/vbWdDTgYPX+K1Lc3aACjsLcTgKaKaELGUI/YJdjtQfD3PP7Thcc8I+V0
         VzvrPsx8aPUiZuMdPbmsQKTQlm8B5OwonaiKVCdWYLbtgD20G4MhYNB23vFBBaEZ3Yjy
         O7rNEQ5dHJSgThfW3GS1ZTUurT9bKKgGyEuWjSF/XaUjdZDETAiUkfA8YuAb2Jy7AQ3N
         xigKZoDcaSrYEvLmSuUXxyk9Fhlcz/yi8g1+noTMBfJIQcGC+0oAbl/fKUkgHlAuSG/f
         aB8QarYqlDA3BD/YlMPr+U6FC+gkq8JQi14bksz0cPljK/Ai2pQvV8FEdhh7XENOHITM
         xTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNZJDYS78cHBuBaASjYOvQ9Ko3WT0Xjzjo+ql6w9VUw=;
        b=IjujJZkLQHLJX+2AkfleK3t9vMV3m4Znr83ia/x2j18GtYVhwk1dcIQ1owT11T9Lf/
         RQX1YKGDX9LvivX3dINtmrW+eegOmAqdzhXj2LAwZP2klB5QkUYR9ypV5zWU/y2p7YAt
         g6hGrAp1M2HgdfD7BeiGO/TowBSeumJjDUSDQL/LBCZXx1FilqcEXkMsITMvMRy+ftDf
         EgRukw7bswAIHpEVby8ysLW2BtE9QVRknJXzVFzJHfYaqRS8Faa4NreSzog6WohZLmk0
         dksPRFphdfofuTWPLS0kP+ooPoB/tz2yIFwqtj9QwLuhTfEOk+2p107dDaEQhPR6poKc
         tuQA==
X-Gm-Message-State: AJcUukc7smfvneLgJ1bezSICV2UKp2CWioHYVYHZ2qHeviHoVBdrAzDP
        LQMHNYxFuLO6Z2ND4GyOf+3/e9Hx
X-Google-Smtp-Source: ALg8bN7PjAMmDGVJtjlGsZeDU7vwYgN+ZFrDMK6RFaKb28IN5OdoU3lQTnC/InfCKP26mD4Djv0mTw==
X-Received: by 2002:a81:ad5a:: with SMTP id l26mr20917165ywk.58.1548687250695;
        Mon, 28 Jan 2019 06:54:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id p11sm12053273ywm.60.2019.01.28.06.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:54:09 -0800 (PST)
Date:   Mon, 28 Jan 2019 06:54:07 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128145407.GP50184@devbig004.ftw2.facebook.com>
References: <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <20190128125151.GI18811@dhcp22.suse.cz>
 <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128145210.GM18811@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jan 28, 2019 at 03:52:10PM +0100, Michal Hocko wrote:
> > All .events files generate aggregated stateful notifications.  For
> > anyone to do anything, they'd have to remember the previous state to
> > identify what actually happened.  Being hierarchical, it'd of course
> > need to walk down when an event triggers.
> 
> And how do you do that in a raceless fashion?

Hmm... I'm having trouble imagining why this would be a problem.  How
would it race?

Thanks.

-- 
tejun
