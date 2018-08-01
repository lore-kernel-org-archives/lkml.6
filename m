Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3175C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EACB208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY7fkdFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EACB208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbeHAR4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:56:40 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36625 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390031AbeHAR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:56:39 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so7742398ybk.3;
        Wed, 01 Aug 2018 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BTWBEwriMB4IM8RCCcf1tcZMNxuqeP2Zcup7vIWFOA0=;
        b=gY7fkdFTgl0huYzwe1SuzAu8zXMhSeUp1Etgw1OstWg1iAAC3jYA/dNPBpQNlAkj+2
         744dOjq1I4gJtqcyDboRg5fGphWXDP5iq5Zv41GgROFgi2HxmA8S7LhgZZQvM86AImJv
         5q5fWlvv0Bk05KdCBT+pLOqzgIYc+MK+DXo8YXSH47kkBTTNiVGaXe1uaEu8hpeov/Qm
         pE2DGUrbM9hoQ8MsMmgNqzvxRFoAWmwxE4ZYTvYPAEaCdrb8Ztez204Hlmyp/tPllabz
         v2B6f7RxwXcAOB6rZ/W1R9RqnUvC+SWSOSc+BuOlOs149w4od58LphJ94Rb/395sNlpI
         CIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTWBEwriMB4IM8RCCcf1tcZMNxuqeP2Zcup7vIWFOA0=;
        b=IyDP2jYDaZ/H9BY/RqDGYdezH+dFdc4jb2sBnLYu2GiIy29+SNllTbHOmQPm1RuoMy
         0TSpshWIokWAT5XLnVo9vQ9OAqpgdNqJm80n8N3h4hLZ0TJa7OeSbBp+QOKHor9OQN7A
         4+UjAy8UWAvmDU6CSI7CE5PrGwmj2nIPe3I5j6lU3XQ0c9ZosDHL9xRZFqnYylLOfw25
         FEPnudCZDrjjp/xcpZbCuQ7zmZGfho+/pUOC9rIB6YoAcvIwM04WQz9hfJPz1YdO1HIE
         4BCoJzv5CxDgnMW68kC8nPUrkWm+NFKRUI1LsBLUrQxreWTKLx5PdAQPz8pSLRnhS01A
         cCjQ==
X-Gm-Message-State: AOUpUlFVCfJ1TnDQlTX6J79oERgU4gPpis5ZPewdUbOH5/vGES0sRree
        HFIq0IpOWqWVsV1G/bYNrQx7Ye3T
X-Google-Smtp-Source: AAOMgpc9U71GJpD+hepeJP48PGuPcjK27Asg+dFgqElhrCfqN1i43DXf3X+rzOQZ4ibZVmO8RfBcOA==
X-Received: by 2002:a5b:2c7:: with SMTP id h7-v6mr14015369ybp.190.1533139813812;
        Wed, 01 Aug 2018 09:10:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:d2a6])
        by smtp.gmail.com with ESMTPSA id i67-v6sm19608981ywc.27.2018.08.01.09.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 09:10:12 -0700 (PDT)
Date:   Wed, 1 Aug 2018 09:10:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] block: make iolatency avg_lat exponentially decay
Message-ID: <20180801161011.GS1206094@devbig004.ftw2.facebook.com>
References: <20180801002559.36261-1-dennisszhou@gmail.com>
 <20180801154958.GP1206094@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801154958.GP1206094@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 08:49:58AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 31, 2018 at 05:25:59PM -0700, Dennis Zhou wrote:
> ...
> > +	/*
> > +	 * CALC_LOAD takes in a number stored in fixed point representation.
> > +	 * Because we are using this for IO time in ns, the values stored
> > +	 * are significantly larger than the FIXED_1 denominator (2048).
> > +	 * Therefore, rounding errors in the calculation are negligible and
> > +	 * can be ignored.
> > +	 */
> > +	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
> > +			iolat->cur_win_nsec / BLKIOLATENCY_EXP_BUCKET_SIZE);
> 
> Build bot is complaining about naked 64bit div.  Should use one of the
> div64*() helpers.
> 
> Looks good to me.  Once Johannes's concerns are addressed, please feel
> free to add

Ooh, one nitpick.  total_lat_avg is a bit of a misnomer now.  Maybe
rename to lat_avg?

Thanks.

-- 
tejun
