Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55840C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2543921738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058603;
	bh=C2spL73ULE0G4uvoK6TZkvfJYjIUXtQxQxO3sXOShEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oWD7OBKCnI0/26R8lk6nwXLW0v1e9qLtcmJ8UlvkrjFAZ++YSu5fRFlGnR9ZnNJ7x
	 J1b2676idxiVtm9Xx0qZYsTyNsvabBf4Fv22Gm3JCcXa8t7vWhNHdDzV2RBrjFwnxp
	 qcOq97CjQpLmKT3FwcoTByRetWi6M+wRraa2CHAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfAISaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:30:02 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53914 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfAISaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:30:01 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so13140196ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7zMDJ5TuneP0bwDoiXXoUm6V+PvHgAFAU6A4s0FJyI=;
        b=ONUb3DDiwPv9Ei8ILYSy3QatRCu5mlERq1bOm/APMW1XZvLDiFtrMgOqpdviPPMlyd
         xFSzVbkgoj1V1i7AH0ncY6HhfkdXQ0FtCmdNeRO5GNNvkGT/TG2zJXe8sa9yse4X5v2d
         0Ai0b/Np7MxcfvGd47IULAeKEUMrFvYAGfGiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7zMDJ5TuneP0bwDoiXXoUm6V+PvHgAFAU6A4s0FJyI=;
        b=Je/mfCXWZWYpCySaqyew6OwZInNJ8TVzhIb1ptBMjfNEyX8DVu5XE/+zwPDaOh3EH0
         jlMi20ch/0XS6EBYf6RNHiNihgRa+T+8nSZtrQlN/PvMB7YbaIloeYJLtcvhXnbouj5c
         giQEX/o8vhJNWxKVfjP2GiOGcQc8oilGB4hXi9UnC0z0eG2iZf0hNy/60HdG0WxqGGal
         ZgzbYwxbtgpgQH+6Ecz05cF2GRnPB/m9iMByVyn7dRPoQAw4PpFQwExdMNta8sAjcPqg
         n3kASkheO4c4R6PCZhGevhdeo+2sPCpuIPX2FOgFqXJUxI/WunClL45OfTGzxmFb7zM9
         weHQ==
X-Gm-Message-State: AJcUukfYgwIqbYYcRoejcmjXx90ii8wViTq8QjJ2v7QzlqGLJgrqwHrg
        ZFxA2fFxkYVPkEw3Ng07Mh2isyYJ39jFmw==
X-Google-Smtp-Source: ALg8bN5FR5C9flofs2T9/dEGv2n2AOF4jPH3TGDyY6YCLHegh3rp0aSiUFl152f9jFg4h7j0mFVIJA==
X-Received: by 2002:a02:290e:: with SMTP id p14mr4930302jap.74.1547058600470;
        Wed, 09 Jan 2019 10:30:00 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id t194sm32273727iof.3.2019.01.09.10.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 10:29:59 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:29:55 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     pr-tracker-bot@kernel.org
Cc:     guoren@kernel.org, torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190109182955.GC30131@pure.paranoia.local>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:05:01PM +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Wed,  9 Jan 2019 22:49:57 +0800:
> 
> > (unable to parse the git remote)

I just committed a fix for this. We weren't expecting URLs without ://
in them.

-K
