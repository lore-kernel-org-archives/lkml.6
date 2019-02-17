Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701E5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6702186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpFOTwAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBQVHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:07:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33844 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBQVHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:07:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so209557pfn.1;
        Sun, 17 Feb 2019 13:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdrzO1HAX/nvgHQ+K8w/MjkesLMtr9+rDsq3IVCmO3g=;
        b=XpFOTwABW4VWQqx8p6f4KQR1dKqomD37WKhFr6qSDK46IHRqse7yu2pDM/ZVZcEcI7
         ChkcH/wDV1SnAtjSjlPt5FTAYfiqdahiSkGbz/16h4Ormga628vf4fiujVF9NYUSo9rQ
         nipKXj4hv+dOh7nlnijnuf7xpc1ufCeqSO6XjhUoJuZND9nLOw97abw8nIUjseLouggD
         u4DWoRhM3GScb7Ej7j10OyZ9FKd6DkGsZ+vpBzJ/j1Aes4lnd/gzHBoL+HuSiFaTMYzc
         QAqY0SELD9eTryskrKtlgdnhqgKhmsz4aydR3W1kfarmBq22Apu3o4gGjpje5C17AzbT
         RxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdrzO1HAX/nvgHQ+K8w/MjkesLMtr9+rDsq3IVCmO3g=;
        b=mmYSkpeQD1fL10QJ4QMuEy5/3bLaXSTK0I9xpEj15zQAln2slsU4ELuoJuytzwwP7U
         yy9fey3WHASslmeRVeOsQLtVb8X6zXfdBi21BIjMZ19HpNem9JlC+Jk6Y067/nVbFTKk
         w9pwHLZfJW1mVJtgJw9EBw2Kq1FxjTTo54ICySVB9pkyUN3AgzChCnPyC/aP0jcZ9Ncp
         N6HslhUlGTCA6rUeTLiT+wAWF5vxl8cyrOcqk90YLvbAzlMxpOZ9bjabynEpTcEV63uZ
         UY8Ivr0F1KDvJpYu5r6R2qTnISKxmyxpgvT18HE12h9teRLfJLT3g3wfVArsVDsdWXWV
         Ot5A==
X-Gm-Message-State: AHQUAubLtkOBplI1LFvABOM5Gd1YMUgudpNgNnqVUH0t8m5JleiJqLyt
        0amtDyFU5yUbcOGVMm6XekY=
X-Google-Smtp-Source: AHgI3IZw20Az0TGsnuUqo29TH3TbtdpYvkCIHXXeXwC3HltjpeBArSDtx9cnUfpBOglIAq02B2AOxA==
X-Received: by 2002:a62:41cc:: with SMTP id g73mr20436543pfd.145.1550437635728;
        Sun, 17 Feb 2019 13:07:15 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v6sm10801692pfb.149.2019.02.17.13.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 13:07:14 -0800 (PST)
Date:   Sun, 17 Feb 2019 13:07:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     rydberg@bitmath.org,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
Message-ID: <20190217210713.GA145509@dtor-ws>
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
 <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On Fri, Feb 08, 2019 at 07:25:52PM +0900, Tetsuo Handa wrote:
> syzbot is hitting use-after-free bug in uinput module [1]. This is because
> uinput_destroy_device() sometimes kfree()s dev->name and dev->phys at
> uinput_destroy_device() before dev_uevent() is triggered by dropping the
> refcount to 0. Since the timing of triggering last input_put_device() is
> uncontrollable, this patch prepares for such race by setting dev->name and
> dev->phys to NULL before doing operations which might drop the refcount
> to 0.
> 
> [1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Sorry it took me so long to sort out the issue and unfortunately I
disagree with your analysis. The issue here is not that we do not know
when last reference is being dropped (because we expect that KOBJ_REMOVE
uevent will be sent out when we call input_unregister_device, which is
quite deterministic) but the kobject cleanup logic added in commit
0f4dafc0563c6c49e17fe14b3f5f356e4c4b8806 ("Kobject: auto-cleanup on
final unref") coupled with the fault injected by the syzcaller.
The commit tries to send final uevent for objects for which "add" uevent
has been sent, but not "remove" event. However in uinput (and general
input case) we always take care of sending uevent at unregister, and do
not expect to have uevent sent out at the final "put" time.

I believe the real fix is to have kobj->state_remove_uevent_sent be set
to true as soon as we enter kobject_uevent(kobj, KOBJ_REMOVE) so that
it is being set even if memory allocation fails. Doing anything else may
violate expectations of subsystem owning the kobject.

Thanks.

-- 
Dmitry
