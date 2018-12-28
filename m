Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E0B20866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546019167;
	bh=U7lyKsFaoIrBMhebo5l/nRGY8+v3EHuVmahV5ssk+t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQzqAkCkbPTrgE3BYLLhEhL1m/UNcM+oG/yxn55KFuvhqZCmBtJFjgXFzx+/Dc9MF
	 Arr3dolnFJk6eXWihbYKBPB7Zp6HU0OGBT/k7laSHjO3SavdsN1x2w11pb5PIuSdKm
	 iGgpDG/JfjgPLWOr2Yx6TW9IfDhdnAHWNZoluyCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbeL1RqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:46:06 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40460 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbeL1RqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:46:05 -0500
Received: by mail-yb1-f194.google.com with SMTP id x201so4786732ybg.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 09:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PlQuia6IdBsTOm/fRMZZW9NtiG0+XxNam5aKRBhlXkk=;
        b=Y73hLWQAbOMhJvPAvKtkaaAhFCIWpiyEj5fiPAUCcC2jsm6aQVbgcfiDZLcrrbanGC
         i9NQH51gUe4TeEwMHT6TosgkUYZJyFXeDM9+LTf9l9EmPKR1f16mIK/LhYCqUHr7XP4g
         PjJHFJJ36kK1SNW/Dy0sgyHsY0zojR/BcKp9CgOIyKwVh/8L/Czl8vP9ydSAfM7D3fBd
         uCmbPNivUdkVwI74Ci4ri6RRTS2sorHU3WlXnuxpXa9+Ry0un0ZqkQMjdlUnx3sLnfZv
         q5+NSkO/ichcSpLTCGFMB0MRm5k4TJq/O25uRgKGf7UgeWHXZHla1IHgm0qLRTF6/SQH
         4Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlQuia6IdBsTOm/fRMZZW9NtiG0+XxNam5aKRBhlXkk=;
        b=T/9m5PsEFWJrD3CER5dPYOUgt/aqKDOpUBsbys51HEoTicCrus5rK3Ff7PHCQSNxOO
         G66H8+vCjeNcCdYAWo1Wg0nn5LjH8ocuAiBOeEQa6WSohcz39yc4ZUszrqZaHD5oxDKX
         BGYbQYWD7Nkg2EvBJnkvTWgv5KZswXn65G71GCnq1Fg7T7cvrtbwu+YwkNtO8dIpiqRC
         THWhkactoKEY3GphO4mNiU+1Y4i/4sDCy3AlAjofHLX52sJ2EJcZwJJlYHpDeD/5iKQc
         HUYUpb0sAyJo63vysFloosz6dmaAMCJ/hEtb7qimtYA4rjSiLu9lgf8zk7T1EIGZhgxF
         5E1A==
X-Gm-Message-State: AJcUukcDNBhviZ/DvLjxv2290FPUZdHBs7dPykCkS64/8cv7dLtyh2/t
        wyqQGq/R6+vDc4V7h/vVlKc=
X-Google-Smtp-Source: ALg8bN4KSZzZA+DgUPEkAswrc0jb+PHEVzXz5Tv2m10FCTiBHwd4/rkkbBQ6WskfE5f2wyD4eogoWQ==
X-Received: by 2002:a5b:990:: with SMTP id c16mr5682178ybq.452.1546019164371;
        Fri, 28 Dec 2018 09:46:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4800])
        by smtp.gmail.com with ESMTPSA id 139sm14696122ywt.78.2018.12.28.09.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 09:46:03 -0800 (PST)
Date:   Fri, 28 Dec 2018 09:46:00 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
Message-ID: <20181228174600.GK2509588@devbig004.ftw2.facebook.com>
References: <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com>
 <20181228011524.GF2509588@devbig004.ftw2.facebook.com>
 <CAHk-=wj33F7LKQS3wCYJtb_yCzYhbjPzFqhVS_ZPPNOWTTMHFQ@mail.gmail.com>
 <20181228015352.GG2509588@devbig004.ftw2.facebook.com>
 <20181228020243.GH2509588@devbig004.ftw2.facebook.com>
 <CAKfTPtA5WBKQ1FMyGqGjn1DdeDbSwT=bTQjD=oW7WMz6iKiS7A@mail.gmail.com>
 <20181228165451.GJ2509588@devbig004.ftw2.facebook.com>
 <CAKfTPtAMjfnNHu_JdDSi1BSMoXKgGkm2+G_QLsUBDAhq1wFvZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAMjfnNHu_JdDSi1BSMoXKgGkm2+G_QLsUBDAhq1wFvZQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 06:25:37PM +0100, Vincent Guittot wrote:
> > done without extra space as long as each node has the parent pointer,
> > which they do.  Is the dedicated list an optimization?
> 
> It prevents to parse and walk all task group struct every time.
> Instead, you just have to follow a linked list

Hmmm... I'm having a bit of a hard time imagining doing an actual
traversal being a meaningful optimization.  It may require more
branches but that shouldn't be expensive at all, especially compared
to walking all idle groups in the system each time which the code used
to do. Anyways, this is tangential.

Thanks for the explanation and happy new year!

-- 
tejun
