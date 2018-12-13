Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92E4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A6520672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiwIeexB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A6520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLMFS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:18:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35206 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:18:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so499696pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iOJgq/M54U/KgwawNPpYMt16/DMHyCVGKzYXtCd0qSs=;
        b=TiwIeexBlX1n6EqhkULlRXyWnuBBbrSOU9zLMqccpr2s1kEjxuYI7K0n6gG4TBF+oY
         +8ddBX4CPax7EBroeWFVRJ9DPPVJonHn5OdE//jicJwQcR9jpIzODIgk2BQoTwbUfSdq
         WtAEePC/2LcMwdhgOvSUjo12BV0xhWbWhaHOfh/iOFrEl9LRdGsiAjM8IpHp3/4WqcLc
         09NQ0tzmAURe91pvMO9GFCwnk7NlLkeWUoiS1djSe8sgwOaTwL6Ik4aAPuRo023fphIM
         lgKRQckaKZcjXCmoMfoNBe168zEll+N/ajRdaxXbhMYOP++Bl2vemV41NwUxJof6L2Bz
         PYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iOJgq/M54U/KgwawNPpYMt16/DMHyCVGKzYXtCd0qSs=;
        b=oyWeAllU2y+j5xjaLfhgc3cX97QQfG6C0GKXFVVky0ovQkRAjvVhZXv88k60Ngernh
         oMFs5+F/fnsPOgN5ZZEwB1qGbTwQ34deXAJIX7/kruenxsmNGcTwYVN39oiXmShdqZKn
         tmGlBmDFPMet2hrCnstfMn++3owsgy8kCR+dTv146MTCWCnBlAdbLaEHVMcerdg5r3UM
         2tJkIYgK2eXeW8Vz2RPGXi6gvoKT2IFeAx2hnZ5PDCi+nVpliEovWo+zN0wMNGEhaorq
         dkMKDVXSJsSL24n/XDBzmt1z3yMGLsKJmGC5d14xB0M46BXheOvs+j/Tk8YWPcOxD1m3
         BxVA==
X-Gm-Message-State: AA+aEWZ+59OJfwg7JCqDYoNCZgYYgtejBuvbE3buTk0VTABjXlfG1i4c
        pcC0zIm2n4pY6YCztewrp+Y=
X-Google-Smtp-Source: AFSGD/UpyUjK1vEdCFSuVItq3vEGuMUtqFZYPhWSiYVZ/tJxdPRyHX+NFV1YW07ywvOA772PDrMIMQ==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr21083620pgi.434.1544678337279;
        Wed, 12 Dec 2018 21:18:57 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id x26sm874550pfn.50.2018.12.12.21.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 21:18:56 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:18:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181213051853.GG4860@jagdpanzerIV>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
 <9cb1526a-e82f-dfa7-4b3c-5ea911a8d476@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb1526a-e82f-dfa7-4b3c-5ea911a8d476@arista.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/13/18 04:35), Dmitry Safonov wrote:
> I've tried to review it and found minor issues like missed
> debug_object_is_on_stack() for initializing already active object.
> 
> But than I come to opinion that it's just generally unsafe:
> debug_obj life-time is protected by bucket's spin_lock.
> Check the conditions when free_object() is being called.

I thought about it for a second, but couldn't figure out if this race
was real.

E.g. uart case - if there are two paths which concurrently free and
access debug object, then the same race condition should exist for
the xmit.buf page. debug object's lifespan should be the same as the
lifespan of, ummm, whatever the thing that debug object is attached
to? I'm surely missing something here.

	-ss
