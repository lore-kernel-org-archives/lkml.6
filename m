Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA09C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729D521763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729D521763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeHCPHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:07:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55598 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbeHCPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:07:53 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1flZri-0004Ki-1i
        for linux-kernel@vger.kernel.org; Fri, 03 Aug 2018 13:11:34 +0000
Received: by mail-it0-f71.google.com with SMTP id r184-v6so5541380ith.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 06:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2IbJzeDoYA1WZUw2b0yUey+OFe3tTgbEAknAwk5jJIw=;
        b=NXDBUx54lbf5pejIWANNaYKN46O2kOodp+McmYsS8FZajnUEeqZWHvJRw+oEeBvDMy
         eeAcpfR77oqJEt1LBQ7MIzON97jNsPBEVaZ+MYOWBRv+m7twX7+83Fg82zHuUfSXKmBV
         y73pIPmIUtvu0h/nihayQSL/megHYupLSfJBSh54NtZdjcvI5dnw8TZnlUxc81wlX3uT
         B2NStXun7mHpWRbR6VNe8TNYf34AeN6QECI/EmG6rheHJIctDEL201FuUTrsdtGdEb90
         aWP15WzEKA8qkqVdOYX5AslhqS9gvaa36tSd1OZzDGiWYZ8w1AtIBVp46OO4TGZWtXpW
         +PDg==
X-Gm-Message-State: AOUpUlEypZDFYd2VqZ53nIDT1QTY6/58SIE0AHXHxgLUaEo16+Xqai7Z
        Bc+knQNbc0J78nibWzjAurVGBnaC/gcBuT2kbjU/aBHHo6NN4KxMBZbr6F72bCrVsbD/whh9hen
        J+AI0WLAEd3gC1yiQXaHYvERQFzM7EFJe+UN6eK9drw==
X-Received: by 2002:a6b:2353:: with SMTP id j80-v6mr5486908ioj.99.1533301892977;
        Fri, 03 Aug 2018 06:11:32 -0700 (PDT)
X-Google-Smtp-Source: AA+uWPzkBVfWq9BNAA7PYq7wfl6H/S69U5kp863kKQnhgkU2IMzvUfl7fKmMPxYH3CvrCn5MIje2bQ==
X-Received: by 2002:a6b:2353:: with SMTP id j80-v6mr5486887ioj.99.1533301892696;
        Fri, 03 Aug 2018 06:11:32 -0700 (PDT)
Received: from localhost ([2605:a601:ac7:2a20:5df8:7f89:d6e6:9952])
        by smtp.gmail.com with ESMTPSA id l13-v6sm2604210itb.43.2018.08.03.06.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 06:11:32 -0700 (PDT)
Date:   Fri, 3 Aug 2018 08:11:29 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Eric Richter <erichte@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>
Subject: Re: [PATCH 3/4] ima: add support for KEXEC_ORIG_KERNEL_CHECK
Message-ID: <20180803131129.GS3001@ubuntu-xps13>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
 <20180725233200.761-4-erichte@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725233200.761-4-erichte@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 06:31:59PM -0500, Eric Richter wrote:
> IMA can verify the signature of kernel images loaded with kexec_file_load,
> but can not verify images loaded with the regular kexec_load syscall.
> Therefore, the appraisal will automatically fail during kexec_load when an
> appraise policy rule is set for func=KEXEC_KERNEL_CHECK. This can be used
> to effectively disable the kexec_load syscall, while still allowing the
> kexec_file_load to operate so long as the target kernel image is signed.
> 
> However, this conflicts with CONFIG_KEXEC_VERIFY_SIG. If that option is
> enabled and there is an appraise rule set, then the target kernel would
> have to be verifiable by both IMA and the architecture specific kernel
> verification procedure.
> 
> This patch adds a new func= for IMA appraisal specifically for the original
> kexec_load syscall. Therefore, the kexec_load syscall can be effectively
> disabled via IMA policy, leaving the kexec_file_load syscall able to do its
> own signature verification, and not require it to be signed via IMA. To
> retain compatibility, the existing func=KEXEC_KERNEL_CHECK flag is
> unchanged, and thus enables appraisal for both kexec syscalls.

This seems like a roundabout way to disallow the kexec_load syscall.
Wouldn't it make more sense to simply disallow kexec_load any time
CONFIG_KEXEC_VERIFY_SIG is enabled, since it effectively renders that
option impotent? Or has that idea already been rejected?

Thanks,
Seth
