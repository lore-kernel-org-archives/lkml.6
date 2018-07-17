Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB39B208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2wtBxur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB39B208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGQExT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:53:19 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:45734 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeGQExT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:53:19 -0400
Received: by mail-pl0-f46.google.com with SMTP id 94-v6so4318400ple.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IbEYh3sE0lEQN86EDBidAaoJTgfuNRe/T1BPCLMMSbg=;
        b=d2wtBxur94D14Z9XWSp94ESdFYXTa3LG/wYP+C/jko83F4yQbfJYeWj6DCUDNoorRe
         OAm9h10smBoY6Ol++l+vjN7jzxjIox8CfUNye7LH4c9LfHtP4MVeuWDQfx6glTkDGgMg
         B8GPIzeqhsVFJnoUZCmc6g6kCnwoLUThWd7h79tzQ2qHYmMglY3orBGPJnp4bRChhPHp
         RgaM3mwbu878vgJbW8tzJI7yqsFe4wY1rh5fLg9v3XrHq9OVZYrOw5AZg06UKDa7n672
         YjyWqrg6fdVWhRODrL1xcQWObOe07OC1HtdTxR97HwyZbV3ZnAjdttZxLWHXfETiM7tP
         NJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IbEYh3sE0lEQN86EDBidAaoJTgfuNRe/T1BPCLMMSbg=;
        b=I26FF0X/FrgD+Gx1PJARa73NgCB3SQ7MyZ78DvkM3rUYRM/SOrr61o2g64PEAAKw7/
         Q5O6/Ei9HeYC/ynMOXwV/cya2O7e03WuFoORTsSjeNMMSKiVd2s4ull6pYPSCzIkAUg8
         MD30sS7u030w9LzEgCPsF/n9RIpzf9fJFyq6I2LvQTzacASnH3wagoFYnd0Le0ITyRcV
         On13yqmjIbi2yopWtCpi1xF6xAHKcDc+dNAyxUYoe28pqO42lRgNbL7YFApuMOuTLwKd
         k0uuxEQAo7XyAOi01fKIGwkaeHUJzoguNIvRQ450NLYFsCRjmnTLXkMh/hPBfO7Gh7Yi
         Woaw==
X-Gm-Message-State: AOUpUlHmb2s6yvTQT7LNIvtwbolBsn9lKaUtaXW9I55yz9Pcd12biCfc
        yJooQcTppP/PEr9CaxszqSnq6A==
X-Google-Smtp-Source: AAOMgpeEHefWhNXLI2kNDUeqoBFYAeYiyNzLipzqHec8H+MUHOE3x5J6Z9wLrOlMbSlcMOJ35cWAxQ==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21-v6mr7706plo.91.1531801364225;
        Mon, 16 Jul 2018 21:22:44 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x2-v6sm55980201pgq.33.2018.07.16.21.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:22:43 -0700 (PDT)
Date:   Mon, 16 Jul 2018 21:22:43 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] mm, oom: remove oom_lock from exit_mmap
In-Reply-To: <44d26c25-6e09-49de-5e90-3c16115eb337@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807162121040.157949@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com> <20180713142612.GD19960@dhcp22.suse.cz> <44d26c25-6e09-49de-5e90-3c16115eb337@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2018, Tetsuo Handa wrote:

> David is making changes using timeout based back off (in linux-next.git)
> which is inappropriately trying to use MMF_UNSTABLE for two purposes.
> 

If you believe there is a problem with the use of MMF_UNSTABLE as it sits 
in -mm, please follow up directly in the thread that proposed the patch.  
I have seen two replies to that thread from you: one that incorporates it 
into your work, and one that links to a verison of my patch in your 
patchset.  I haven't seen a concern raised about the use of MMF_UNSTABLE, 
but perhaps it's somewhere in the 10,000 other emails about the oom 
killer.
