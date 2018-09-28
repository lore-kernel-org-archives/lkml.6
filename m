Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499CC004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789562073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="yvTCyhf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789562073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeI2E3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:29:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34661 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeI2E3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:29:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so5191511pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iksJQKVMIAn1KtvJBHa4N3Je5oF6iRMhRCD60ze68Wc=;
        b=yvTCyhf/dRXSIy2y+9O9Zc8YCdvyhat/LIJk3rmJGmA4Gg7VGvadJeR16VaCMn2Cyx
         52IbGu+UiK0BEp9E68Ssm+ZxG06OhPnYWY6xT9imYK+4xvNYnw3ylzzWTaF/K4Ny+nXH
         hPgY8MdAkGpRS2Z0U45lGjZ7m7krgwZULLPnB7RoA+L0a9x8F4OWlDs8r83NnBzM+3eE
         wOD4GO1ZgUIJZ+ayDqWyJM3yiyQ4SRdL16rOqcyfqQDviHyP1p4aBO76hhBIuvNtgf7Z
         DuQAMA/SL9w5G427n8vrmahCV3uRfLI0NI8ak/FQ4Ira9B+QFSu3UU27oQidR5031UVo
         zxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iksJQKVMIAn1KtvJBHa4N3Je5oF6iRMhRCD60ze68Wc=;
        b=mOz8zR+obENOfsoFNYXhImR+xz+fUBAe7zVpWiSi7LG1q382CQDJXUPtJotGsMYFiN
         e4nxA2uS/KiZHNbdSMq2FyYAAwb+G0yN2htVZzt0ZLsNTdWAeO9xmgvQIEf+nvIBqFjB
         JVsHF6XA6pNVQu0ZgrR1fCRfqJOgMwLjHtmASADpXtlYOPaZNMIC9ggofRLg3o99WJTb
         ahK8mcMtLEXdHykIf/ddjOlcKu8Hmkeb4dS5i36TTipgjZpkNN0OdEzCJFn7JCCSyCp0
         khECBNCVAVh6jqsDS3Gcjkoa2s6XoulUsPnXozDLWjn171YlpkPRcUQXdL6LqhAmlbFr
         AADw==
X-Gm-Message-State: ABuFfoge0S5swo52u02dZceuFeUWSX4hcgoyXDfCANeFlQQAVYPSrlFd
        JfjPTzCiCHfXVC8Zlo+SEDgJ2g==
X-Google-Smtp-Source: ACcGV61R0hCtO/X/AQ8p3EJhPcXuWFhd5oJkiCwGn+OjBw5VrXFkMJaKPhG6dXpJot1bFReBfNrbgg==
X-Received: by 2002:a65:4cc3:: with SMTP id n3-v6mr481510pgt.257.1538172242118;
        Fri, 28 Sep 2018 15:04:02 -0700 (PDT)
Received: from cisco.lan ([128.107.241.171])
        by smtp.gmail.com with ESMTPSA id d63-v6sm9256500pfd.94.2018.09.28.15.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:04:01 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:03:59 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Michael Kerrisk (man-opages)" <mtk.manpages@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] seccomp trap to userspace
Message-ID: <20180928220359.GF18045@cisco.lan>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <686fe047-16e6-3dfc-6284-ed574d97ad2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686fe047-16e6-3dfc-6284-ed574d97ad2f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:57:40PM +0200, Michael Kerrisk (man-opages) wrote:
> Hi Tycho,
> 
> On 09/27/2018 05:11 PM, Tycho Andersen wrote:
> > Hi all,
> > 
> > Here's v7 of the seccomp trap to userspace set. There are various minor
> > changes and bug fixes, but two major changes:
> > 
> > * We now pass fds to the tracee via an ioctl, and do it immediately when
> >    the ioctl is called. For this we needed some help from the vfs, so
> >    I've put the one patch in this series and cc'd fsdevel. This does have
> >    the advantage that the feature is now totally decoupled from the rest
> >    of the set, which is itself useful (thanks Andy!)
> > 
> > * Instead of putting all of the notification related stuff into the
> >    struct seccomp_filter, it now lives in its own struct notification,
> >    which is pointed to by struct seccomp_filter. This will save a lot of
> >    memory (thanks Tyler!)
> 
> Is there a documentation (man page) patch for this API change?

Not yet, but once we decide on a final API I'll prepare one.

Cheers,

Tycho
