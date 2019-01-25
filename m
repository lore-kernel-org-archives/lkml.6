Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59496218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548430276;
	bh=yiOty6TK9JYHYti5S85wqyOKeKDEgNV5OlvlFFxZ9ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VNgQcEWMfxCVmGVK1S97qSraN/q9QpgSb0UHtJqM8OwMXgnyy8VACTbdtunLevbiI
	 Jkqbc9TOxtWDJRpjrOmEDm3lF50KbcUSmg5YAwhHBwnMe3wkj3R6BYrGKmKpl2FN9f
	 FXZGe9xeSNDYT0BmedOlfWNjQkvM8m7R8hQC2Y0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAYPbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:31:14 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36133 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfAYPbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:31:14 -0500
Received: by mail-yb1-f193.google.com with SMTP id c65so2355943ybc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGBt2z7n5AhLP4pocgQwPm5kcmwoxNm71n0zgMZga4M=;
        b=bZm427l+2Tejt4HTVR5nNnl7HlzK4X3n9Aaj15AAX+jCXxZSo1TFVtgOvimVKs9N/A
         fb981lKXCY+qYUtmLio25clAzovEOg9VrPoLnxN2bFaBHRsJ13kpqUsbdttDnuboPsDB
         Q4abE9Oxi1Ss3wfVs2ni0ihWAQKn7i6pqT2AUBxSmpe/ZLthw3ylBf2WPWBa7mv67a4R
         y3DU+MFidsAvB+1XoECSjEpiE93yKniDSnG5fDzPfQb/QHN/sRhq7MGKrIonQhdxBxPD
         HQEHxrwKm0uTdRlWIOzPG5UaU1P09UV8nWP3gK3wwcdW1SV/SBpE6gu5lwlixn0BCXzD
         LQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGBt2z7n5AhLP4pocgQwPm5kcmwoxNm71n0zgMZga4M=;
        b=Qu1oyT+aKTWDQvf1GAydd7uijCbmUg4hCIePVtYLitxB4Uo7fdcnvtVNZHHXWihCC+
         7O4RwhVjBfAPSe8rJq28c+qhGxr+tfZYamISjga26e30CsPgiW1SudcWC/jsk8WJpcWh
         dvkgRU0UP+RRuQ6ZTrlKbG3rCIm+XOLJeOLjd/lL0ysqqKTTO0BXjz+PYALuRPhAR0Pa
         u17Kug0JfHWONaZEHORMG8FX8YuUy7gjjUtfb+y+4dX0iC6SLPlzpsDELzzUJUFUZWbT
         5/8ZBcc5TVx9ri1RIUMcXrMtlAhSuKst3GfgV3xnfJM4EYdIGn1LFgVbQqAAXnV/YFyC
         h80g==
X-Gm-Message-State: AJcUukdkrhEN3L3GmwDcIJRzfo9pJUgRjyKp9lbLUHl41Y+NbN0deMMX
        /tRTZOwRSq2Zf8jY0/KD2Z8=
X-Google-Smtp-Source: ALg8bN7xaAJ+Z9cLRSjq/QQBToBaaXHfpiiZsEiaTco8bFZujlYIuvHJNwpPslzpcYGUYyVmVmKtOw==
X-Received: by 2002:a25:9b01:: with SMTP id y1mr11273364ybn.465.1548430272963;
        Fri, 25 Jan 2019 07:31:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id w63sm9318550ywc.46.2019.01.25.07.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 07:31:11 -0800 (PST)
Date:   Fri, 25 Jan 2019 07:31:07 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Try to catch flush_work() without INIT_WORK().
Message-ID: <20190125153107.GI50184@devbig004.ftw2.facebook.com>
References: <90c831b3-0d09-3cf7-5a2c-2fa7afaa003e@i-love.sakura.ne.jp>
 <20190122151819.qjzihyyd4h2ukou2@ca-dmjordan1.us.oracle.com>
 <201901230044.x0N0iCdk051613@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901230044.x0N0iCdk051613@www262.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:44:12AM +0900, Tetsuo Handa wrote:
> Daniel Jordan wrote:
> > On Sat, Jan 19, 2019 at 11:41:22AM +0900, Tetsuo Handa wrote:
> > > On 2019/01/19 4:48, Daniel Jordan wrote:
> > > > On Sat, Jan 19, 2019 at 02:04:58AM +0900, Tetsuo Handa wrote:
> > > > __queue_work has a sanity check already for work, but using list_empty.  Seems
> > > > slightly better to be consistent?
> > > > 
> > > 
> > > list_empty() won't work, for "struct work_struct" is embedded into a struct
> > > which is allocated by kzalloc().
> > 
> > Please check list_empty's definition again, it compares the address of the node
> > to its next pointer, so it should work for a zeroed node.  I'll reiterate that
> > it seems slightly better to be consistent in "is work_struct initialized?"
> > checks, but it's not a big deal and I'm fine either way.
> 
> You are talking about
> 
> 	if (WARN_ON(!list_empty(&work->entry))) {
> 		spin_unlock(&pwq->pool->lock);
> 		return;
> 	}
> 
> part in __queue_work(), aren't you? But since flush_work() is used for waiting for
> a work to complete, that work can be either queued state (list_empty() == false) or
> not queued state (list_empty() == true). Thus, I don't think that flush_work() can
> use list_empty() for checking whether that work was initialized.
> 
> 
> 
> [PATCH v2] workqueue: Try to catch flush_work() without INIT_WORK().
> 
> syzbot found a flush_work() caller who forgot to call INIT_WORK()
> because that work_struct was allocated by kzalloc() [1]. But the message
> 
>   INFO: trying to register non-static key.
>   the code is fine but needs lockdep annotation.
>   turning off the locking correctness validator.
> 
> by lock_map_acquire() is failing to tell that INIT_WORK() is missing.
> 
> Since flush_work() without INIT_WORK() is a bug, and INIT_WORK() should
> set ->func field to non-zero, let's warn if ->func field is zero.
> 
> [1] https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to wq/for-5.0.

Thanks.

-- 
tejun
