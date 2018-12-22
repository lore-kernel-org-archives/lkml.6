Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E854DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AD82195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545512363;
	bh=eCe3/MTx1Qmv1TaNNletDnJqd6O0KcFqDF+4yAtCS58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ql8fTS4HOqMyYEVIiq+sGWgaq3KFdOwRMnP0RmEqM7rcDsuN7TPU6e4yn14Ge9KtT
	 np5LE1UFe7TIkeaGdbRMIcOawg3TMAmz6ax3i3JWkO0JjwSI3HMzn0cQQYzJnypzbT
	 VukELnIPQAU0BRsM4pM3FZ5Q5vq+MmrS970I6quM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbeLVU7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 15:59:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37866 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbeLVU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 15:59:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so8813292wmd.2;
        Sat, 22 Dec 2018 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tFlHYB0zI+dBZ58hLaDVEwWzC6NZU7woYYYkh5OAGRo=;
        b=VPcERrn8UWXd2MK1LsRI7aw9Ri/uFLhDl3SeVCVGk4AzpyMxOdJR67EZ9CpuKr4D++
         n8FUZQyRMeqtkaKX99ZaDIES01gCOTiN3VMx/udVI5FuEm2dyQHNXUXnCyA86uFyfkXl
         +mf2wjH1e3Y3FEBsDbKz32qH1D6XNqSFTzZJtt85yX6wagpp4bng6U7rXvip/ngvIZac
         d08o/Y9v9MWGPwFkDcletrcfueDC66FOf8K3+6APK7DgbZWQs5tHPmB+533mxXlXdBVK
         lkH97njUTxHEj/EkEkqoyKSDIbUuo5pONKF4jD4uCUcynWUT9cVJ70FdgJVlTHD6LMS8
         rL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tFlHYB0zI+dBZ58hLaDVEwWzC6NZU7woYYYkh5OAGRo=;
        b=RHF3YU8QnqNKbBqMBbbCsYIPOOSsvb2xeTGSO3w+QXUK2y/dMg1FUofo1NQczmSTOW
         fP8dPh2CjusjuVgCkDldFW12AWmrYtYfBEe4zqlH52XOQxyj6JagjqcQ1DZYlUCbhkT3
         18ghPt4V8qho+Z1KwcZH2elQK9J+TLbTI5aD/iinkgvxHvb7bEj3dwWPjfNGoyZIlhaP
         64ZHzE8R9kgbwr6OFJ1EalCwAtrYS3gp3i2EeIW+BZ2LsantN2hkuNI69YtPEfZIuRIo
         jNRwGrVPPDA8oRc4Z/5aFZiIabNwB5SYeXtzp97xgK9JU3pfOHX7RvuKfVaFX732/buG
         h2XA==
X-Gm-Message-State: AA+aEWay6hN3Mhottyyus+4rpiv7Y78PAo+1Pi5zZVPUxEzD8Wl2b4tl
        7k80FG6B/ROtFFfU6K7RrrzfgPzP
X-Google-Smtp-Source: ALg8bN6bpXemGQJHO+UJvTnX7PNhjDY9b28xNQB6Mc+h7jdV6w/+ckk/5GXR9EQ9n9+JQa3iLDXvKQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr7357954wmi.61.1545512359952;
        Sat, 22 Dec 2018 12:59:19 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y34sm42293826wrd.68.2018.12.22.12.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 12:59:19 -0800 (PST)
Date:   Sat, 22 Dec 2018 21:59:16 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] Last straggler for 4.20-rc8 or final
Message-ID: <20181222205916.GA64950@gmail.com>
References: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
 <20181221224040.GA25147@zn.tnic>
 <b54245cb-d029-02a5-d854-129ea7734336@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54245cb-d029-02a5-d854-129ea7734336@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 21/12/18 23:40, Borislav Petkov wrote:
> > + mingo.
> > 
> > On Fri, Dec 21, 2018 at 02:09:02PM +0100, Paolo Bonzini wrote:
> >> Linus,
> >>
> >> The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:
> >>
> >>   Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> >>
> >> for you to fetch changes up to 3cf85f9f6bd7b172122865432b4c6f0ec844e22a:
> >>
> >>   KVM: x86: nSVM: fix switch to guest mmu (2018-12-19 22:19:22 +0100)
> >>
> >> A simple patch for a pretty bad bug.  I haven't yet sent my 4.21 pull
> >> request because currently I'm waiting for a patch to be removed from
> >> tip (MPX removal breaks KVM live migration and was committed without
> >> Cc or Ack from me) and until that happens I cannot finalize my
> >> conflict resolution instructions.
> > 
> > Lemme make sure I understand it correctly: you'd like us to not send
> > 
> > https://git.kernel.org/tip/eb012ef3b4e331ae479dd7cd9378041d9b7f851c
> > 
> > up now and delay it for 4.22, right?
> 
> Right, and also I will have to provide you with a topic branch to base
> that patch on.

Ok - x86/mpx delayed for v4.22 at least.

Can we turn off CONFIG_X86_INTEL_MPX configurability in the Kconfig, via 
a patch like below?

Thanks,

	Ingo

 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8689e794a43c..20fd5695f265 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1870,6 +1870,7 @@ config X86_INTEL_MPX
 	def_bool n
 	# Note: only available in 64-bit mode due to VMA flags shortage
 	depends on CPU_SUP_INTEL && X86_64
+	depends on DEPRECATED
 	select ARCH_USES_HIGH_VMA_FLAGS
 	---help---
 	  MPX provides hardware features that can be used in
