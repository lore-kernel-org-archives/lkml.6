Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB57C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1024B2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS05crj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1024B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJBPvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:51:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46977 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeJBPvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:51:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id z3-v6so1245852wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SDQJVEW6v+xuhyPbX4XU6rmi6PfsejHORPxn29soWW4=;
        b=XS05crj9d6aGLqHIKI8V7DKGtWCFy/GLXMULD34WMatFENcyz57yoOPBErtK2lpnEe
         oC8yJtWraTEtK+pWBdq4UkLEYo8Q+v6gAowUFbJqJYFm8f8z2V+ZuI3T9b2i6OvGgoPR
         nZWpLK0oiu8kms1dabBCIu8ky8CiT8u9eJolFlous/JB9mk6upGpnzr4zfGif3c+RsJU
         AhY0Kgo3ZZeP7vQyod/lRY6+ohpy13frLy1VsOU/cC2eAs6ZnmRbVl4gGtROrJzWFsDO
         F3WStSHlLMJ+Psx1YCuJ+0JasCgIC5OQ9FFirkld4NE3rDWoMnnqlPb7CflUDIW+6fCb
         69IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SDQJVEW6v+xuhyPbX4XU6rmi6PfsejHORPxn29soWW4=;
        b=dRVC7J42vzhmw6XvNXsQRcx3BZS4cHp+6QNfUsIdH4V7OMvlgAbczs9WHEPsx/gBCq
         wEY85E5h+Zj2r3xW+RsKTIEI4YIrOFXF568pBBnxwP58NQRQOd8Meu/stv+41VkkjWRU
         63C+AlgOt/RLuee8/zjGJ0agy7lGhr4PmVL2ECQ6PaoQ8rPdR61vQEHLCrqcHyaMOz4t
         45Ckj2ov52Ee6jtn46sxAvH8pE0xgh4ljq4O2HVnuykKOmAWbTiGQFSSmU/RuXFgPre0
         ZQ4fB7ANSETXbqn/cf0D7jVHOQqmPEwb9jtmP55MYLGPUAx8EL+SpHw1nttphrwb0vvE
         G4tw==
X-Gm-Message-State: ABuFfoghJ8PLWJ4j7CGB76FzhPnYKY8gLh8JjUMwUv64XSlrLkPOoegz
        1wqjUa2l7cSaOb3UAL5QmHnPu1Yb
X-Google-Smtp-Source: ACcGV61qRx/KVkOSP9mvj5scp5G5eFpQl66bIHqlU71+Ujf+w5VcFf/e05tD9cN1ZHB8oOMtJJmMiw==
X-Received: by 2002:adf:ce10:: with SMTP id p16-v6mr6538511wrn.118.1538471331044;
        Tue, 02 Oct 2018 02:08:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c2-v6sm4483579wrt.77.2018.10.02.02.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:08:50 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:08:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] locking/lockdep: Call lock_release after releasing
 the lock
Message-ID: <20181002090848.GD116695@gmail.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-6-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538157201-29173-6-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> Subject: locking/lockdep: Call lock_release after releasing the lock

s/lock_release
 /lock_release()

> Currently, lock_acquire() is called before acquiring the lock and
> lock_release() is called before the releasing the lock. As a result,
> the execution time of lock_release() is added to the lock hold time
> reducing locking throughput, especially for spinlocks and rwlocks which
> tend to have a much shorter lock hold time.
> 
> As lock_release() is not going to update any shared data that needs
> protection from the lock, we don't actually need to call it before
> releasing the lock. So the lock_release() calls are now postponed to
> after releasing the lock for spinlocks and rwlocks.

Nice optimization!

Thanks,

	Ingo
