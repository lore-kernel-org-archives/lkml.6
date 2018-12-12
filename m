Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D14DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5A220811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="T/On6EAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5A220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeLLFD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:03:58 -0500
Received: from ozlabs.org ([203.11.71.1]:35075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLFD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:03:58 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 43F4Tm05yWz9s3Z; Wed, 12 Dec 2018 16:03:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1544591036; bh=rhEosjEfZQzhO2bufzhDYXx13Ie6MQ63HUdwjJ0mvBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/On6EAJ8s/c3MCJUpyi0kf9eTf6ldoCznRPofkXLaxKgJyPQxhH9fJdLuTG7YgFS
         8MO6GzMJ3B7M0nAT+1jT/U3psl3Eqq8zIp8uWaTK+FjVvNTLN5/PlawFEOMHsibAi0
         ycC21g1yRthYEBTXQHmnGLzkR0mxghAfMYMRWNFU1XYZiuGvMwYrxtr7d5IIMRpg37
         vhA8lSSTfddQAEMd82tUYsNiViWUKYGvo+AUDkfuLQ881gC2J9eNZ1bRfyed/XJ2H2
         aOG4vMImeDe/8pM0mlwJD0MNgTps+a2EuB5w3+D5qRBrss3J1w9BaKZp5CRctDdfO7
         M8+jaPBfh+LQg==
Date:   Wed, 12 Dec 2018 16:03:53 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: Re: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
Message-ID: <20181212050353.GF22265@blackberry>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
 <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:21:10PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> The patch is to make kvm_set_spte_hva() return int and caller can
> check return value to determine flush tlb or not.

It would be helpful if the patch description told the reader which
return value(s) mean that the caller should flush the tlb.  I would
guess that non-zero means to do the flush, but you should make that
explicit.

> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>

For the powerpc bits:

Acked-by: Paul Mackerras <paulus@ozlabs.org>
