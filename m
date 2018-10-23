Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213092075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213092075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeJXF4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:56:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41773 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeJXF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:56:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so3367258qtl.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 14:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PrSsFdcbepnogT/aIKfHSenBdobNsGAURFn8vZz/HbE=;
        b=nb3OYI1ar2DUrt2NOo8cHkcnr/iXaq6lxpQ+/Ihv79N0VFv9JxMHZIbcq0+dINb9Bn
         SEvEXFVR4OCn/sRDGkphNewE0HWsPpgi14c/NruNkTVkG/VeoPUelQEW0x3rO5KiONO5
         OyBrQblZPx55WIjOpICT9XH8CHX9FD/XmYSgd5tDupiby65oe7Bzp2I230j+8bo5trLw
         ocbXa9MMQDZt6B+7iL6a6fRzVvfJFdN5yiEjTuCxShpjcHvcpHFrYSU1rn2ptegY7EWl
         K6X47iGqnNFrNqoGRnzjMnZAvayQtiM2WHLvnz4HA3PNZsm4ulPqNXLqp8JAKKAvsU90
         mbBA==
X-Gm-Message-State: ABuFfoihQ4cVkeDCZmkNyfpiC0ap/87VKnBxY3f/Q69yfCZQRYOnlHYn
        0hjYDiZ3BB4B+Rqp1ZT+dyU=
X-Google-Smtp-Source: ACcGV63rJekqIXGU9sjmimeWgh5Nd81PNUoCGwD7P8tE/Nmf+Il5uk+oUBHr9xTwK15lw83dD71nLg==
X-Received: by 2002:ac8:38c6:: with SMTP id g6-v6mr48619106qtc.55.1540330255715;
        Tue, 23 Oct 2018 14:30:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id z188-v6sm1747173qkz.66.2018.10.23.14.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:30:54 -0700 (PDT)
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
To:     Johannes Berg <johannes@sipsolutions.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <1540244870.128590.39.camel@acm.org>
 <63ae9bac-3587-bded-ea98-e43fb4d7240d@grimberg.me>
 <b3aae7aa8241c9828c04d2f2b58927f4ce1411b9.camel@sipsolutions.net>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b61979ff-918b-a27e-3d3b-34e9cfc23083@grimberg.me>
Date:   Tue, 23 Oct 2018 14:30:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b3aae7aa8241c9828c04d2f2b58927f4ce1411b9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I also commented over there regarding this specific problem.
> 
> I think my wording was inaccurate perhaps. It's not so much direct
> recursion, but a dependency chain connecting the handler_mutex class
> back to itself. This is how lockdep finds problems, it doesn't consider
> actual *instances* but only *classes*.
> 
> As Sagi mentioned on the other thread, in this specific instance you
> happen to know out-of-band that this is safe, (somehow) the code ensures
> that you can't actually recursively connect back to yourself. Perhaps
> there's some kind of layering involved, I don't know. (*)
> 
> As I said over there, this type of thing can be solved with
> mutex_lock_nested(), though it's possible that in this case it should
> really be flush_workqueue_nested() or flush_work_nested() or so.

I guess that could make this specific complaint complaint go away...

> johannes
> 
> (*) note that just checking "obj != self" might not be enough, depending
> on how you pick candidates for "obj" you might recurse down another
> level and end up back at yourself, just two levels down, and actually
> have a dependency chain leading back to yourself.

Its not a simple check, any removal invocation is serialized under a
dedicated workqueue and in order to be queued there, the connection need
to first be connected which comes later (after the flush takes place).
