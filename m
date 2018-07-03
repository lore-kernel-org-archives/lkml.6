Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2F5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038F32456B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7jRWvB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038F32456B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeGCUMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:12:10 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38207 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeGCUMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:12:08 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so1219513ybo.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7udbj33I/RjDYlty0aqbXLzXs5JGlDd9JyrBjCM7DY=;
        b=u7jRWvB7S8HzRNWgfrwku2W7hFAd/z3f1DT/ZJKi1jqz/rhsakwDKIpKaEopR5o1Zn
         15aQF0LCwaXH9+KCor+pADCm/wAfoEMRSAtGSNeK1MgeedaNdqhw46WbEYyNFfuB9EbK
         p0rQ+Ppz65njVdiYkaoKT7gWJSknfXXL1AcmAjvzZCWxN1KOomnSvVKfhvpj6g42/0Ud
         Kn7oLsYu7N3adlC1odEyUE4Y1Gs6M6naBD//kRIstY5Vy8mLbnqCbUxbSdJ4N+oS+5Mp
         XyDHBM9PKQL5Jf8H3Db6ND0DG9LxAeBm53am1LudMl3qeQv+rOpWIavf6F6PiyPA2MXt
         BsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7udbj33I/RjDYlty0aqbXLzXs5JGlDd9JyrBjCM7DY=;
        b=Lr2L4Nf5v1ByJJkI7/ykJwVxgtn9PgABo1X3qutXtObKj8srXV6g7J0Og9Wub69FqV
         k1j2TrFqPVqcl0Zr4o37axnNGwpF474gnJhsd5mEkHlfokDfHOUexYSV7550u7ENRC6c
         q2IIhsSqw+4zn/Ce1vFZnO3BpyTtu+wqAFpZHnoIOK32JmFqkVHpof1AZiAqxAY5KisV
         UeYjqNBXb/NnLVglGJBGC++oD9XxbPxXaeDs5Fltao6Lbq8baCV8gcF3+nRTf18I7TqM
         ziBEHTICR68pwk89mEkTOLTH2GmMoGlqXW7V0C1ht6aKDMQ5BSI+M5LyrAM/feqDJh2d
         aWkA==
X-Gm-Message-State: APt69E1cLPkvTJMwWIGO4MYhixhZlcg+mKzViOkl2tYWAfHqqQ0tWahk
        mcUn1beMDT2Ywfl7N93vb+g=
X-Google-Smtp-Source: AAOMgpdYryzvOtl6wEhNxeSKkFuhRH37YYn9+nmMlgTyFNLvQskCiQu/RzYyR8670zNYRSlU4KIbSg==
X-Received: by 2002:a25:283:: with SMTP id 125-v6mr7175655ybc.473.1530648727973;
        Tue, 03 Jul 2018 13:12:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:a4be])
        by smtp.gmail.com with ESMTPSA id d11-v6sm665370ywd.1.2018.07.03.13.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 13:12:07 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:12:05 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: WARN_ON_ONCE() in process_one_work()?
Message-ID: <20180703201205.GA72677@devbig577.frc2.facebook.com>
References: <20180620192901.GA9956@linux.vnet.ibm.com>
 <20180702210540.GL533219@devbig577.frc2.facebook.com>
 <20180703040518.GV3593@linux.vnet.ibm.com>
 <20180703164044.GA400@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703164044.GA400@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul.

On Tue, Jul 03, 2018 at 09:40:44AM -0700, Paul E. McKenney wrote:
> > I will apply this, but be advised that I have not seen that WARN_ON_ONCE()
> > trigger since.  :-/
> 
> But I get a build error:
> 
> kernel/workqueue.o: In function `worker_attach_to_pool':
> workqueue.c:(.text+0x63c): undefined reference to `cpuhp_target_state'
> workqueue.c:(.text+0x647): undefined reference to `cpuhp_current_state'
> /home/paulmck/public_git/linux-rcu/Makefile:1015: recipe for target 'vmlinux' failed
> 
> My guess is that the worker_attach_to_pool() code needs to change so
> as to invoke cpuhp_current_state() and cpuhp_target_state() only in
> CONFIG_HOTPLUG_CPU=y kernels, but I figured I should defer to you.

Just to clarify, the bug happened on a kernel with cpuhp enabled,
right?

Thanks.

-- 
tejun
