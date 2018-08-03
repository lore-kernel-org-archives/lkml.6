Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E4FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4A82176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4A82176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeHCSNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:13:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58965 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeHCSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:13:41 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1flcks-0006Ms-5x
        for linux-kernel@vger.kernel.org; Fri, 03 Aug 2018 16:16:42 +0000
Received: by mail-io0-f198.google.com with SMTP id e8-v6so4407952ioq.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 09:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nmj5h/wK48XhaTLw2A7fWijogQ3AC6+cnE18hnadvD4=;
        b=SfVQMSS1D+UMNEH2wzFLGqIeamX3MKBQ4R5ajr3t2tA2EI7gm1UnuSYwtyQBN/n8vB
         bB8Krzboi58OU/2W2g4ANnQXTZ3K5UWNtXGZHlQHYpBiUdPGMx4iQNlhZn3TLboLyeQl
         N2138Vu24Pmzr2i7ombsENZXTWW3k8IigKaUlakoo/qSEPVe36W+CSdviIKoigOkBS+r
         NQulXwFN4VKj8MBXqg5MBrLkCg8W/Gl36fseQaHeyyzVLUgBqPoDXgIG0qSmRxKAgfe4
         Gc/x5Jf47j92pAO532S0Bh+c/kGpZlzYQMDA3JcOKIs8DCkwUStZZw7i2UjxLkQ9I5np
         K6zQ==
X-Gm-Message-State: AOUpUlGpQV7gWGCjJE4DXXqVHBS6fB4LAG3tw+0JgJvMfXVTUDJkrb57
        Z0oGXCJi+TaT3jx688egFmd3Qqw9NjvtikAdnfC+lAXmaPS5At3O6SAdJ5Y6oedRpt5+ZnTBIUy
        pT49ob6YVwfLhK9xNOr7na/EAYsjvccsUQFpnO1GN5A==
X-Received: by 2002:a6b:84d6:: with SMTP id o83-v6mr6869665ioi.93.1533313001079;
        Fri, 03 Aug 2018 09:16:41 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpdv26nmI3GG1F6zdLhMaUM8/KgW+lD1/puynM6C5Bv14AEQMx71H+Wf3zL3FEIgPJu5l3Whjw==
X-Received: by 2002:a6b:84d6:: with SMTP id o83-v6mr6869655ioi.93.1533313000793;
        Fri, 03 Aug 2018 09:16:40 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:5df8:7f89:d6e6:9952])
        by smtp.gmail.com with ESMTPSA id g26-v6sm910000iti.0.2018.08.03.09.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 09:16:39 -0700 (PDT)
Date:   Fri, 3 Aug 2018 11:16:36 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Richter <erichte@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>
Subject: Re: [PATCH 3/4] ima: add support for KEXEC_ORIG_KERNEL_CHECK
Message-ID: <20180803161636.GX3001@ubuntu-xps13>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
 <20180725233200.761-4-erichte@linux.vnet.ibm.com>
 <20180803131129.GS3001@ubuntu-xps13>
 <1533308099.4337.424.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533308099.4337.424.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:54:59AM -0400, Mimi Zohar wrote:
> On Fri, 2018-08-03 at 08:11 -0500, Seth Forshee wrote:
> > On Wed, Jul 25, 2018 at 06:31:59PM -0500, Eric Richter wrote:
> > > IMA can verify the signature of kernel images loaded with kexec_file_load,
> > > but can not verify images loaded with the regular kexec_load syscall.
> > > Therefore, the appraisal will automatically fail during kexec_load when an
> > > appraise policy rule is set for func=KEXEC_KERNEL_CHECK. This can be used
> > > to effectively disable the kexec_load syscall, while still allowing the
> > > kexec_file_load to operate so long as the target kernel image is signed.
> > > 
> > > However, this conflicts with CONFIG_KEXEC_VERIFY_SIG. If that option is
> > > enabled and there is an appraise rule set, then the target kernel would
> > > have to be verifiable by both IMA and the architecture specific kernel
> > > verification procedure.
> > > 
> > > This patch adds a new func= for IMA appraisal specifically for the original
> > > kexec_load syscall. Therefore, the kexec_load syscall can be effectively
> > > disabled via IMA policy, leaving the kexec_file_load syscall able to do its
> > > own signature verification, and not require it to be signed via IMA. To
> > > retain compatibility, the existing func=KEXEC_KERNEL_CHECK flag is
> > > unchanged, and thus enables appraisal for both kexec syscalls.
> > 
> > This seems like a roundabout way to disallow the kexec_load syscall.
> > Wouldn't it make more sense to simply disallow kexec_load any time
> > CONFIG_KEXEC_VERIFY_SIG is enabled, since it effectively renders that
> > option impotent? Or has that idea already been rejected?
> 
> Agreed!  We can modify the "case LOADING_KEXEC_IMAGE" in
> ima_load_data() to prevent the kexec_load based on
> CONFIG_KEXEC_VERIFY_SIG.
> 
> The architecture specific policy would only include the IMA appraise
> rule if CONFIG_KEXEC_VERIFY_SIG was not defined.

After looking at this some more I'm having second thoughts about my
suggestion. As a distro we produce a kernel that needs to be flexible
enough for a variety of scenarios, and if we completely close off the
ability to load an unsigned kernel for kexec that's almost certainly
going to end up breaking some use cases.

So I think it is necessary to make this a run-time decision rather than
a compile-time decision. The patch as provided does this based on
whether or not the kernel was booted under secure boot. That might be
reasonable, though I still find this mechanism kind of awkward. It seems
like ideally there would instead be some logic that would accept the
image if the KEXEC_VERIFY_SIG verification had passed, and otherwise
require IMA signature verification.

Thanks,
Seth
