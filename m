Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FAEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B16C20658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ8dM3gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B16C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJQXEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:04:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33010 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJQXEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:04:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id 84-v6so16700754qkf.0;
        Wed, 17 Oct 2018 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5bqOghSzvUOk7rsXSilVyYGwatXjhM7u+odjRAkfi4=;
        b=vJ8dM3grDlZ/NMU8EDubc1RbZoT/h53R+wjWcyG2YRo7rbpJQLNqNHqZkD9YyP4Flg
         isJSP7maA8mWbxFsfSvVssgFBGG5i+sAce1/MmGafci+LOXXIwvrMuhkvhKHHQsn8Uqz
         V5PKPYfmJDdOyHQm0vWDIc/A6eq9q3GIS6U2g6xRY0wqGFzPaGDD9FrBLe+d4RxCPY5V
         eUu7zOb8l50kgUzJVaI/f9X9UIPsBXsjG5o0x+WW4YicXaMmmSD/9YMJCqHHmWxPj3q+
         Cx/ZVyaEDrHJX+P74HNajLHb4flPy10SE11pPm5oUMCo0b2Gx/BFfGH4TUqyDz6kxBmt
         FDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5bqOghSzvUOk7rsXSilVyYGwatXjhM7u+odjRAkfi4=;
        b=cxGYqiQav2cWZSAySj5Us68cfn19T2IYCCBUk1AyCkFHHjjDoxDs5xj3IIKJvO2qDC
         NjUKsswXpazXmZnkU/4OcqEnC71qO2SGImYZtbjZdsovVr1NW+feomAu19G7g9si1l1H
         YGk6ijCg1LzFefDh6r7FK9l7Z+xT+AUjye0KdYA/wY35ziXkrZS+3NaTPSAhnOeRa0sh
         Th4stc0sJW2BYe12qRzJj1DBvt4bswUgZ8FUFSCcY1T7wiDsbHGJJP7HFfH/tkY40yCO
         EIHrwK3cWOiJFNRt05MCkZSeGKG1yQSRQwJhWmpbOt+XVRn+gZ8OJ+2h+tQ7lhQoMZXu
         W/Sg==
X-Gm-Message-State: ABuFfoiBK/HRH+8Wz6Xr9V+cV/b5xrvh8BNG0xkQNPpY8YekZFqgx8XF
        PafLkLpaV5tSGuIyhMSImTc=
X-Google-Smtp-Source: ACcGV62gxfgiMt1siuRTXRIkMbzIo+7wLA58Y6XSsPC0/+ET9fFCaWfDYfSPVptpCKp9jE9A8HHLiw==
X-Received: by 2002:a37:af46:: with SMTP id y67-v6mr25674494qke.111.1539788919023;
        Wed, 17 Oct 2018 08:08:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::5:5411])
        by smtp.gmail.com with ESMTPSA id x1-v6sm933058qkx.93.2018.10.17.08.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 08:08:38 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:08:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 12/12] cpuset: Show descriptive text when reading
 cpuset.sched.partition
Message-ID: <20181017150836.GS270328@devbig004.ftw2.facebook.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-13-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539635377-22335-13-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:29:37PM -0400, Waiman Long wrote:
> Currently, cpuset.sched.partition returns the values, 0, 1 or -1 on
> read. A person who is not familiar with the partition code may not
> understand what they mean.
> 
> In order to make cpuset.sched.partition more user-friendly, it will
> now display the following descriptive text on read:
> 
>   "normal" - A normal cpuset, not a partition root
>   "partition" - A partition root
>   "partition invalid" - An invalid partition root
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Can you also make this consistent when writing to the file?

Thanks.

-- 
tejun
