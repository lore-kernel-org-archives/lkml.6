Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6BCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF762175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpWLXb2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfBGAhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:37:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42158 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBGAhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:37:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id r15so6125592eds.9;
        Wed, 06 Feb 2019 16:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vBhoGQLZYAfDziwwXABntOkkRWdSCMRv+msmR1NKUU=;
        b=KpWLXb2HmN1EdbNjkxvfbF29y1vqo/E24o70p6OeK6T9+EquMknbcN5YgPjHYJQL2N
         RyOuy7IPSwUEU5dznkjRCTU1hewfxMcr4FeJ0V6PvVXTPpb4ipzlg3JUsob5YpW+5cuc
         w+/ZXg6tU/BokFmtS51Nn49+zCNMV+oPJWAxqfvUJepF0XT8Qx6DSUiP+9ya8DXftbwJ
         ypDTWh8Aai/QDG9/j5Xdc0l/8eqd9mWBCMxGZ+stQ5VHjTHmZped2iRUf4MI+qzVTk6/
         HiO4ugheiBJCd7O3h4Pp4GDBWR817w6LkU5UcgkqRzGeXUJmOaqbGDetFo6vR0hJzlOY
         TG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vBhoGQLZYAfDziwwXABntOkkRWdSCMRv+msmR1NKUU=;
        b=OdeaZPyEOMP2pVkY8Me0EoGRLGeR1TJaiKmDaMrSBiJcd9Y48+i7lqITeEidmaLXMi
         JbwAUd+zXoge/ZzMmgFQvd4RQkSQfx4AsaP3kBLa/O3f5ajOfl3XNRjE3L5ICEAcfrli
         /9Gmm8EV85WfZVoHXW37mUBzdpCupyODFx+h5PixUEgJCHPjurgMecQdBA267a17v9nU
         tdCGgBuOzeSRmjp1i6nhqA5bNsnSaNHQAPcD8+9WMbGe5akQ6hEYPnJYn4f+HW7oWTJV
         +ElpepsdvnF5AY6vw8MVdV2uQ1nE4IvylLw93Bk/2FnxL9kSB3FBSWgcQN8LR837ZCNe
         NxpQ==
X-Gm-Message-State: AHQUAuaV4pCWtQ0T5k0hAUNV0bSer7tdV0R912E5741B6voUzseyIFTS
        qUr7Y19wfzXCC4Tup6w3hPc=
X-Google-Smtp-Source: AHgI3Ib78no6sHkyAvoWZJohuWYNnahWb/y/l+rokOcyVWbUWhuwSWyzyasQGQqMRQ1648WR3wMsqg==
X-Received: by 2002:a17:906:64d:: with SMTP id t13mr9048814ejb.53.1549499835061;
        Wed, 06 Feb 2019 16:37:15 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id j4sm2907663ejx.75.2019.02.06.16.37.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 06 Feb 2019 16:37:14 -0800 (PST)
Date:   Wed, 6 Feb 2019 17:37:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>, g@archlinux-ryzen
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jon Flatley <jflat@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
Message-ID: <20190207003712.GA10692@archlinux-ryzen>
References: <20190201210853.244043-1-jflat@chromium.org>
 <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
 <20190206164528.GA8925@archlinux-ryzen>
 <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
 <CAKwvOdm=dqScCDVTgQ71i0wtBSqezEzLr69Pxp3bZJFs+_mXsQ@mail.gmail.com>
 <20190206174339.GA19743@archlinux-ryzen>
 <CAK7LNAQ97h3RjKNy8f2abb7fnCaQS3TOoF2LFeGgNxeoCy0GwA@mail.gmail.com>
 <CAK7LNATAdXh4d39VfNqmLX-V-46sLwVXK+YhE1AiMCDutvUr0w@mail.gmail.com>
 <CAKwvOdk4cT=Ay2Xk4hYo4-x8=4ng9gF5rF=5RsV-Rp=q5UFNtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk4cT=Ay2Xk4hYo4-x8=4ng9gF5rF=5RsV-Rp=q5UFNtg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:30:21PM -0800, Nick Desaulniers wrote:
> On Wed, Feb 6, 2019 at 4:28 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > BTW, it would be nice if kbuild test robot
> > could test building with clang ...
> 
> Is "kbuild test robot" different than 0day, kernelCI, or ClangBuiltLinux's CI?
> -- 
> Thanks,
> ~Nick Desaulniers

kbuild test robot is 0day (that's the name the emails come under when
reporting issues).

Nathan
