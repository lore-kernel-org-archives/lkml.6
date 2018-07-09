Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40508C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B30208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhoMp6hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B30208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeGIUaN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:30:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44338 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932898AbeGIUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:30:12 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so6542131pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fMd8wcePcNWxqZ6lD5xrjiFKExUH7YMqoNvCMLnrVYQ=;
        b=uhoMp6hC+tcEGAMAuh5tme9zwjFYIYmgjb+PO+7Yfr+NHU/aaW453DVVK9vfis0qzu
         v1FRBEIqqduPzZc8CUNs9GaiJvC6VuLogdRX8CAKGUi1MImWDaSnC/qRzVJboV7iuZjk
         XMTgr7MkoXFsyTwKYGGMKm3UI+L+POOqwLsfLYcpItfKfi9CaRJKg2Rn5XunvdG55zHS
         GeTkgNudiTzb6Pw0OzvoTc5HA40ajoXrENIfFiKT/Je1Yur2oPkvPtyS+SLdl/HSSJvV
         we/7ux7cBUN40IwBOsTb6n3tF0kXfxG2n7UfMyzvQVb6BBQ8/q83PdtB+BsgNp43+97D
         sX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fMd8wcePcNWxqZ6lD5xrjiFKExUH7YMqoNvCMLnrVYQ=;
        b=pi58t0OalbjfTiF91dGlKRKv3VkbHgqre+vZqpjYtitg+WO9sZ4iTNhr4F0NThloSu
         cnvS+5CxV6XWR+ZrSnivCU393/LJVFqQ74MDZpmW4xUiy+2WGd+2fypn+sOr99j8lMjw
         JAy4DB3OZN+/164hwkPmjUeN408eNIFAIhYATvbM09u6+fwlk1Oo5NwA1l0tVS7EnkdI
         QhtHQjr7JUoGiI0SfNSaMEitW0wfgNTGFGPUsM8OPzrOQMLjwkGvDpec1qhYQk6PHQTw
         s9WRyk9/aHYkIsDKY+DyrzqOl+Pgh+58gijejhHPDWBVR/ithsfjW4N4QWhuBjm4A8dZ
         LMwg==
X-Gm-Message-State: APt69E1hH2eZZL2uxNXjHwGD207dvUu1Ad/LixFUA3KrnSlRRsLIbX7V
        u3yml5k08hICT227rhdlYEDUpA==
X-Google-Smtp-Source: AAOMgpePElkNjR7XfLbmn5bkTXGzn3IfC1zI6p0e/hEpX1LwxS6N/l38gmVL66Mcm/0AWT49Ou9iuw==
X-Received: by 2002:a17:902:301:: with SMTP id 1-v6mr21738293pld.127.1531168211793;
        Mon, 09 Jul 2018 13:30:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e21-v6sm14767538pfl.187.2018.07.09.13.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 13:30:11 -0700 (PDT)
Date:   Mon, 9 Jul 2018 13:30:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <20180709123524.GK22049@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1807091323570.101462@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <20180705164621.0a4fe6ab3af27a1d387eecc9@linux-foundation.org> <alpine.DEB.2.21.1807061652430.71359@chino.kir.corp.google.com> <20180709123524.GK22049@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Michal Hocko wrote:

> > Blockable mmu notifiers and mlocked memory is not the extent of the 
> > problem, if a process has a lot of virtual memory we must wait until 
> > free_pgtables() completes in exit_mmap() to prevent unnecessary oom 
> > killing.  For implementations such as tcmalloc, which does not release 
> > virtual memory, this is important because, well, it releases this only at 
> > exit_mmap().  Of course we cannot do that with only the protection of 
> > mm->mmap_sem for read.
> 
> And how exactly a timeout helps to prevent from "unnecessary killing" in
> that case?

As my patch does, it becomes mandatory to move MMF_OOM_SKIP to after 
free_pgtables() in exit_mmap() and then repurpose MMF_UNSTABLE to 
indicate that the oom reaper should not operate on a given mm.  In the 
event we cannot reach MMF_OOM_SKIP, we need to ensure forward progress and 
that is possible with a timeout period in the very rare instance where 
additional memory freeing is needed, and without unnecessary oom killing 
when it is not needed.
