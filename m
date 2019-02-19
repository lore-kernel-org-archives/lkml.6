Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D495D2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctZMxIA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfBSS67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:58:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38481 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfBSS67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:58:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so3369041pfn.5;
        Tue, 19 Feb 2019 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TGtpiW4RdGRJ0GVK41jyL9RRSprNTe/GlApNUQT/kzA=;
        b=ctZMxIA99CiSFpyiQPtbzIptNlLmjIskkMxiPcHBvr5WNxvgRQSk2tuOYQ80pSicsz
         b1tR1fP+8WWEbymfNtx8xw8NTYuQMVkyr/atf2zP/7q2+xaoKg6kSGN9NH2EXpQbbefo
         n0qn4syxAZIGBfHyOhCBzIfIEOwXCDILBNtNLp/EVER3S0K/n4ocbuZfxKDbeDKVuGUm
         a4E3OwO/nN2LazTqjBi7P/OudYkMBcDWdwGxwQnm/qsC+Dg89GigDoN2U0d/2gaBPGWU
         Wr0SJZVKdZgo+ylVlxS+RfGublBNnqiIDp50SbYAtqCJlJpb70Rfx/RuXcP5IXnkaFTq
         RssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGtpiW4RdGRJ0GVK41jyL9RRSprNTe/GlApNUQT/kzA=;
        b=WjCc1uLVRlAMkQLXYUgXeod3ncGv/yGotEy6s8GiFtD4OxVKufQBcOLzSnEQGMpzBi
         NE3jHCSXIEz4F2Uxq09F5nz6g+HaaSNeBPaR10fXUQZ7xX0LvgMBc6fh0ub2IqjNMSyC
         wCpv636WICyyhkEITQ1vNfkWiGuybOA6wUkdEOo3QfO38Qvohnw5pQwk1+98eASMNndM
         fhJzaUoetC5KvV2eGrUjiOG1VdYCAf1iVf9Rlu5cKaPvgih27Gtjug231a4XIWa9oj0w
         eOCl01XaS96ELEYSwqXHCStNIoIkLm5deDH23/7fqUNqOmWpvzdxHBk2xrr0h+LnYwkU
         q9bQ==
X-Gm-Message-State: AHQUAuahgZ5VZg74iNzaqU59zoeUvt+SXeP2u4khjfP/6+8sawZtTUb0
        T+uL43dJzz2v7FMGih9xBWQ=
X-Google-Smtp-Source: AHgI3Ia9CPAnpQT/33PNGa2+4bduRrA7dIukLGKWmydZjzKuJechqnz213nzfuIaeMRXIdr06gOBKQ==
X-Received: by 2002:a62:6702:: with SMTP id b2mr30435511pfc.244.1550602737896;
        Tue, 19 Feb 2019 10:58:57 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t5sm21661632pgo.70.2019.02.19.10.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 10:58:57 -0800 (PST)
Date:   Tue, 19 Feb 2019 10:58:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     rydberg@bitmath.org,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
Message-ID: <20190219185855.GB210481@dtor-ws>
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
 <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
 <20190217210713.GA145509@dtor-ws>
 <722c14a1-78cd-14b6-59ef-ba0d6fc82cb1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722c14a1-78cd-14b6-59ef-ba0d6fc82cb1@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:10:23PM +0900, Tetsuo Handa wrote:
> Thank you for responding.
> 
> On 2019/02/18 6:07, Dmitry Torokhov wrote:
> > The commit tries to send final uevent for objects for which "add" uevent
> > has been sent, but not "remove" event. However in uinput (and general
> > input case) we always take care of sending uevent at unregister, and do
> > not expect to have uevent sent out at the final "put" time.
> 
> Then, we want to keep dev->name and dev->phys when calling "unregister" time.
> 
> > 
> > I believe the real fix is to have kobj->state_remove_uevent_sent be set
> > to true as soon as we enter kobject_uevent(kobj, KOBJ_REMOVE) so that
> > it is being set even if memory allocation fails. Doing anything else may
> > violate expectations of subsystem owning the kobject.
> 
> If we want to keep dev->name and dev->phys when calling "unregister" time,
> we could do something like below. Does calling kobject_uevent(KOBJ_REMOVE)
> without dev->name and dev->phys (to some degree) help (compared to not
> triggering kobject_uevent(KOBJ_REMOVE) at all) ?

We are talking about handling pretty bad failure (I am not sure if these
allocations can fail in real life) so not getting KOBJ_REMOVE uevent is
not a big deal.

Thanks.

-- 
Dmitry
