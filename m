Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4A6222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550043952;
	bh=Bf6wVHM2zl0aE9B2LDl29C2f3IcoiM4ObH6yW8fhAyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qpye7HNe6RS1tj74Z7xx7YcTIfjfl7bNMHmRZIsQl0rt0sNNkt2OD0lVMX4ZK9lhm
	 SOD7WdwIVnYE/XPk5N9htjrVns6HwRpr9mukOIgNeiEmHKc3uAjoXECRxHWJ+eFS/5
	 byePhM0r/QtYmJNBwVVpdGxXye9T7A5DcbTysDNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbfBMHpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:45:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfBMHpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:45:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so1289906wmh.4;
        Tue, 12 Feb 2019 23:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WSLNpQeKH85LdvlZ78tn7b/TaWGoRsly3MpPfDxVU28=;
        b=n0Uu+1spwh6BP8F080TtY1cvdPiS5MomeYgaSXLX0ODIFfwbvTDCFCySsQcLxVKGmM
         dw/96VmrPhtvCuR7/3aha/Y+YTXZYmokABimDEcEnAeR0hD3UDlcQCUCKdmikIZpJm7D
         V81pl3f8hRpJxAFdazAHEXOg7tIHMAM9CYE2zVy7dMTLwKTYDzwRNPhxrhdAIO52PsDj
         w/7l9Pu0cYzoafONIE5xszt/iaFRaoZh+SEBV/1dLccfZHIgA35DSaB0okBf0jyDgwDz
         kUXx6/grQqC0RNDfrI1CRbMCF2x8FbFq5HpRq/FEdLVE5s+21PZZUKFE+EKOUMwCUXXD
         hTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WSLNpQeKH85LdvlZ78tn7b/TaWGoRsly3MpPfDxVU28=;
        b=GhFk60DU5FF7cpM6Krj1QuIhhpJzLSH7fftEj428k+sACuPUIwqOdgPMCvI+L/lrZv
         pJg4iVSWckf8YKbuaY+pAz7+rzrftFyDrc8MzrTUXE0f7OfOT/KFVZdF8mGOStu8JIUy
         xW7qTU4PhZ/Ijol5/kMWdtbCJg6YYwcgsGwS/CW2b0jzOeK6uk+hEn6xXXrxR9J3HHUk
         jqKvbx+uCuX6K+pCfPNmHgOL8zfvS3IyMc+iNav17OlgTv+JbxKvfYh0J8NPxLun5ROZ
         c7C8G5a+telnfNjN1DAVff6lfs0S4rCPnA78tcWi6PMuAh9+QfNJ/hmou7Exavyz/gKG
         DMGQ==
X-Gm-Message-State: AHQUAubGs7oFIoqttZq4YWeaXEkeasNxI/JkjFwjfjGDScncsYjC2M25
        HgufSAgDcu5vRznz4pAbHDA=
X-Google-Smtp-Source: AHgI3IZUCQNNdjmNfZR03XpdWC0K36paSAMR5JYQTu6XL1rM9r4b6zd01sh6EsJm+bWZZlyeBZ+N7A==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr2238898wmc.116.1550043947629;
        Tue, 12 Feb 2019 23:45:47 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m4sm5399647wmi.3.2019.02.12.23.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:45:46 -0800 (PST)
Date:   Wed, 13 Feb 2019 08:45:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190213074544.GB62549@gmail.com>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
 <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
 <ef66f262-d68e-58ea-34f6-15b88803cf71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef66f262-d68e-58ea-34f6-15b88803cf71@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> I looked at the assembly code in arch/x86/include/asm/rwsem.h. For both
> trylocks (read & write), the count is read first before attempting to
> lock it. We did the same for all trylock functions in other locks.
> Depending on how the trylock is used and how contended the lock is, it
> may help or hurt performance. Changing down_read_trylock to do an
> unconditional cmpxchg will change the performance profile of existing
> code. So I would prefer keeping the current code.
> 
> I do notice now that the generic down_write_trylock() code is doing an
> unconditional compxchg. So I wonder if we should change it to read the
> lock first like other trylocks or just leave it as it is.

No, I think we should instead move the other trylocks to the 
try-for-ownership model as well, like Linus suggested.

That's the general assumption we make in locking primitives, that we 
optimize for the common, expected case - which would be that the trylock 
succeeds, and I don't see why trylock primitives should be different.

In fact I can see more ways for read-for-sharing to perform suboptimally 
on larger systems.

Thanks,

	Ingo
