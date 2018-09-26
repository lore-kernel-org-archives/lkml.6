Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B9BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B6021537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI3Rvu+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B6021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeI0EZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:25:04 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37719 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeI0EZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:25:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id y14-v6so256998ywa.4;
        Wed, 26 Sep 2018 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQ7Q60uYXf4LqamCl0e4BKF8/okCSOJdGDkhWo3ciCQ=;
        b=MI3Rvu+4Ddwd/kdiM9JFBSg+XuP3yi8znpP3zA0HHoLsdsxy07MLtqc6ljJAQYCkq6
         25uQ5ocjBPrp21TE7MJkMiscVQ5DvkJ+I/UQoaFblmas768dLw0PwVUv1yJ/yOZHbNRt
         2ijkcJp36PedKrpbwrUyZM1Dn2ypsAlT9MDatQNh6TyTb+TCZbUXVyB+A+UoNWkd+m7c
         AYdWUwWTptsXh5ZZzbntDb0GLlwfPiJ6kv/LhaMRHKxtWSBZMBIvfMaSQLXP5PHNQY/2
         kIC0KUvkHrK8c3PsnjKKN/S1Mw/l60zKLUzVSgsf3lBh2lZ7rFhaqcvBic372fqDXUK7
         mjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQ7Q60uYXf4LqamCl0e4BKF8/okCSOJdGDkhWo3ciCQ=;
        b=RWkEHJAhKrAVZfd3Da8Ltfg48+Gb4LJ6nurQR9Pv2nariYs6HFv1rEcam1XRGc/esl
         BuSK5PkMXpby1a+BnJ4H1EQLhgVZ1pN/1u8YHPepma/5E8X9YFx1xw2QZAZvjOW/XoM6
         +iiVkTqc/eVhYuiSz/iuf8KS0t7TuPaoWiI3o4GhmwSUTMoOjs9psAP/lJN7gndJTTMm
         niJX2xXAelFmPeae3cu1d9Xl/f9uQq1f15NJHUIe5jH3/oLhsYWJDDOvfPCK4JJgF/1t
         uDQMcOMbY4e7QQDYajSAUVk9q+yIhHDg975YcOsEtb5afha6teRp+xFfIj08/bSU71Fg
         Ydmw==
X-Gm-Message-State: ABuFfohbkSx3+wtywRs7qLKaJKFp2ghYCVwLdRmBoq+Vuj9suPEdKZkP
        23lBiZ9LvzaxtmDHa15RANE=
X-Google-Smtp-Source: ACcGV62MakdzjB2Ehk8jn94QJ5MWRkxdYXV16mjeX10IKvbvtUeebuIqtqF6AKRRj9V8TOVL3Jpw0A==
X-Received: by 2002:a81:7ad4:: with SMTP id v203-v6mr4415229ywc.166.1537999800106;
        Wed, 26 Sep 2018 15:10:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::4:2c77])
        by smtp.gmail.com with ESMTPSA id v74-v6sm373912ywa.19.2018.09.26.15.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 15:09:59 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:09:57 -0700
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
Message-ID: <20180926220957.GB270328@devbig004.ftw2.facebook.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 26, 2018 at 03:05:17PM -0700, Alexander Duyck wrote:
> I am using unbound workqueues. However there isn't an interface that
> exposes the NUMA bits of them directly. All I am doing with this
> patch is adding "queue_work_near" which takes a NUMA node as an
> argument and then copies the logic of "queue_work_on" with the
> exception that I am doing a check to verify that there is an
> intersection between wq_unbound_cpumask and the cpumask of the node,
> and then passing a CPU from that intersection into "__queue_work".

Can it just take a cpu id and not feed that to __queue_work()?  That
looks like a lot of extra logic.

Thanks.

-- 
tejun
