Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C599CC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE2A20878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8LSDG0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE2A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKUKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:33:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37540 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeKUKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:33:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so2663795plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ESDgRLDwVIKN01iWb2NZ8edlx75PdpNdlKtBC19Cq38=;
        b=g8LSDG0SR+AAnlIhDxI963bVaCJNNoVLE0x8FJxCSuQ0Jr1pjY+txkWmujDxajcinD
         ebGqzvRfDgQvm08/QgAIC+JdvmKNFG4d97VrNjLrtCk3ZTcY78QQAfj0ge2LlrBy/Iaz
         Wp3Q7aJYwLZo5Q1mP0VzCa2gYSgDRJTdbW7VSKide821PkGiHS7R4MsbOymz9+heMvY/
         TPHS6JrThn2wgImxDTeo2RBhpd4bCwdBNnxyWt4FZJw5W0QKrGEmvGMbFHyr1PyKntBN
         oOEV5mkG7tCkdBMJDOdVtFGh/XZCYPBap0XMwSwt67uwiL4ucqVHbzjLi5OHkadMwBDm
         SfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ESDgRLDwVIKN01iWb2NZ8edlx75PdpNdlKtBC19Cq38=;
        b=WmKoRuq2FSxM9dWR9Avgm6R6kLZar5hE35TJVQ/nQ19T8aKvSLX9QcFlOYkTcfUDs/
         u0i9zRwvNFC3L48GVJZB/O/MQd4oUvgu0U7sjBfrhRKdH00Wj/B3qqLabikV12ceMuef
         vx6q+XI9o5lHe1SASDbEM1W5kAhn9CR0lTT6SFRBIVmq1wDycXgTt9pehylwWd+YCpQJ
         NxHrb0PSzvZCuL6X7rZ99A+/MB/XY2JfUJYNs9AsbwA6mvDkpt7E+OBz3+DFNMQT2D1z
         gZFOWYd2C/9EN62k7X4daS9JSE7Kck6oCaMyDdCGd/bt1amL0gKDAmdsCe9POMeA8qr5
         A7yA==
X-Gm-Message-State: AGRZ1gLvNNNz15NFtd2n9B+M6AwMkQj/n+dg5eEJmpPVPvX+yyrlsM5k
        ilCyZHjCAsAb3KdWTVa1e28ruQ==
X-Google-Smtp-Source: AJdET5fvE9boKlX/QbItczSZX9MpGO6EjnhjkoBmwHqdkFmtE/YeVdsOWTxiXgd44qVJWS0wmqj9/w==
X-Received: by 2002:a62:6d83:: with SMTP id i125-v6mr4475518pfc.184.1542758508805;
        Tue, 20 Nov 2018 16:01:48 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z9sm32460926pfd.99.2018.11.20.16.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 16:01:48 -0800 (PST)
Date:   Tue, 20 Nov 2018 16:01:47 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Jan Kara <jack@suse.cz>
cc:     Michal Hocko <mhocko@kernel.org>, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/3] mm, proc: be more verbose about unstable VMA
 flags in /proc/<pid>/smaps
In-Reply-To: <20181120105135.GF8842@quack2.suse.cz>
Message-ID: <alpine.DEB.2.21.1811201558060.89573@chino.kir.corp.google.com>
References: <20181120103515.25280-1-mhocko@kernel.org> <20181120103515.25280-2-mhocko@kernel.org> <20181120105135.GF8842@quack2.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Jan Kara wrote:

> > Even though vma flags exported via /proc/<pid>/smaps are explicitly
> > documented to be not guaranteed for future compatibility the warning
> > doesn't go far enough because it doesn't mention semantic changes to
> > those flags. And they are important as well because these flags are
> > a deep implementation internal to the MM code and the semantic might
> > change at any time.
> > 
> > Let's consider two recent examples:
> > http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
> > : commit e1fb4a086495 "dax: remove VM_MIXEDMAP for fsdax and device dax" has
> > : removed VM_MIXEDMAP flag from DAX VMAs. Now our testing shows that in the
> > : mean time certain customer of ours started poking into /proc/<pid>/smaps
> > : and looks at VMA flags there and if VM_MIXEDMAP is missing among the VMA
> > : flags, the application just fails to start complaining that DAX support is
> > : missing in the kernel.
> > 
> > http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
> > : Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> > : introduced a regression in that userspace cannot always determine the set
> > : of vmas where thp is ineligible.
> > : Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> > : to determine if a vma is eligible to be backed by hugepages.
> > : Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
> > : be disabled and emit "nh" as a flag for the corresponding vmas as part of
> > : /proc/pid/smaps.  After the commit, thp is disabled by means of an mm
> > : flag and "nh" is not emitted.
> > : This causes smaps parsing libraries to assume a vma is eligible for thp
> > : and ends up puzzling the user on why its memory is not backed by thp.
> > 
> > In both cases userspace was relying on a semantic of a specific VMA
> > flag. The primary reason why that happened is a lack of a proper
> > internface. While this has been worked on and it will be fixed properly,
> > it seems that our wording could see some refinement and be more vocal
> > about semantic aspect of these flags as well.
> > 
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Honestly, it just shows that no amount of documentation is going to stop
> userspace from abusing API that's exposing too much if there's no better
> alternative. But this is a good clarification regardless. So feel free to
> add:
> 
> Acked-by: Jan Kara <jack@suse.cz>
> 

I'm not sure what is expected of a userspace developer who finds they have 
a single way to determine if something is enabled/disabled.  Should they 
refer to the documentation and see that the flag may be unstable so they 
write a kernel patch and have it merged upstream before using it?  What to 
do when they don't control the kernel version they are running on?

Anyway, mentioning that the vm flags here only have meaning depending on 
the kernel version seems like a worthwhile addition:

Acked-by: David Rientjes <rientjes@google.com>
