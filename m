Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A4EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DFF2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knyJoQ90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DFF2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJCAZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:25:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35751 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeJCAZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:25:50 -0400
Received: by mail-yb1-f196.google.com with SMTP id o63-v6so1155967yba.2;
        Tue, 02 Oct 2018 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JTz8Pnu5QddGR+QW5mlaibn08hKcnxthEyujDX3ldkE=;
        b=knyJoQ909kKZHX8kJmzxwv0GoKSeFKCdRgxKYZW1GSEV5+HXcVUYCkJKtwBD5n6ddw
         mXdJcNI0gQohuyxR3mQDTxNDAuhhQSmyBkggiZtfWFXxcQOOJFNfiiBhM9QuYY8Ad7vd
         61ua8b/ZNvibTpLrhiVmKG7cNUSbbNI+87QMRbmS5VksjUhuUt7qh8BRl/JpyYH+adMG
         1UdQFI8WOpBvcezKVuAwlh5WUQQtBh2zN9ov3+eITqBOjdEoLlq9sLgWLLmdsnPieJ+a
         LzaBMrmFMYDhUo0tYCUMvWkIdpsVu/KOeOkc6O1V4b1k1i1X3yKhc7U9J7kla7u+CReH
         Ig3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JTz8Pnu5QddGR+QW5mlaibn08hKcnxthEyujDX3ldkE=;
        b=M77+efvIMbUxjziRO9WxN8BPQi9E5utzas3AluwbntaYyWckLivh9DWztYXYTqT42c
         1UjB5Y24X1UnXyveVRIVBbgqKrDpTEVJESXqOufbchu6pHwuMfskbtYKMFW5NNJ237mK
         7sc8/rtRIU/sFCFljMK6UierSD5VdCdRIFM5desOfmd4/jWYeq4NAyXeuhB0aESvrLiY
         YmKnwn8xdFiBDGpkCb+upyhYWXh5Vr04kCXyAs3gUQLstM7wwOspCRAzZrWq/tasRSGT
         VlXO+V6GaWlq3N/e7W3xPmfFG9M2iP3PTNIccVysWuRnUV6+gEPBNh3RyvxTpk3O56MY
         Tt3A==
X-Gm-Message-State: ABuFfojZUQEBExywl5VCOjL0Owx2x1FrQ2rgHzSfVmfosT/Q7LUvGskc
        9puXjZacmc21D3qaDJyIPj0=
X-Google-Smtp-Source: ACcGV63EuqI+MV4SNeknZjjk0nmQGxu19meYhrc+ruyeOqJZXJ4Flf5m8x14a/qfBFT455IhovmO0Q==
X-Received: by 2002:a25:d90b:: with SMTP id q11-v6mr9536910ybg.447.1538502079125;
        Tue, 02 Oct 2018 10:41:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:ee3])
        by smtp.gmail.com with ESMTPSA id r12-v6sm6555367ywg.67.2018.10.02.10.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 10:41:18 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:41:16 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, len.brown@intel.com,
        dave.jiang@intel.com, rafael@kernel.org, vishal.l.verma@intel.com,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        dan.j.williams@intel.com
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Message-ID: <20181002174116.GG270328@devbig004.ftw2.facebook.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
 <20180926220957.GB270328@devbig004.ftw2.facebook.com>
 <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
 <20181001160142.GE270328@devbig004.ftw2.facebook.com>
 <4eebc017-23a2-a26e-095c-66433061a141@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eebc017-23a2-a26e-095c-66433061a141@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 01, 2018 at 02:54:39PM -0700, Alexander Duyck wrote:
> >It might be better to leave queue_work_on() to be used for per-cpu
> >workqueues and introduce queue_work_near() as you suggseted.  I just
> >don't want it to duplicate the node selection code in it.  Would that
> >work?
> 
> So if I understand what you are saying correctly we default to
> round-robin on a given node has no CPUs attached to it. I could
> probably work with that if that is the default behavior instead of
> adding much of the complexity I already have.

Yeah, it's all in wq_select_unbound_cpu().  Right now, if the
requested cpu isn't in wq_unbound_cpumask, it falls back to dumb
round-robin.  We can probably do better there and find the nearest
node considering topology.

> The question I have then is what should I do about workqueues that
> aren't WQ_UNBOUND if they attempt to use queue_work_near? In that

Hmm... yeah, let's just use queue_work_on() for now.  We can sort it
out later and users could already do that anyway.

Thanks.

-- 
tejun
