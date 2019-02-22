Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427AEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070382075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550845945;
	bh=a+44of+O5MfmWO1VFv1M0kuaxhtH7XrTqGXzVYwC4Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RUEGHv0cioafrsw5YmOmp+gsDN8PcHHpUCosuWKnU4W6rnCy1hnS3PFL0c+oZVZQb
	 HvniOcC3lZ5cLbpulfI8TY0EyDAQtK9zWJAcShz/xGtlY0N3zw46sEL5DhqR+FUQD6
	 UFQfWPEB7FSCF/FXxBOCIIfWQow+IEevIcRyS9P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfBVOcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:32:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EA212075A;
        Fri, 22 Feb 2019 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550845942;
        bh=a+44of+O5MfmWO1VFv1M0kuaxhtH7XrTqGXzVYwC4Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDdrQ0crzo+ge1WTWEetZ7oxQp2Ud4RWpQL1RsBN/qHXQHAruRP7HYnmAzU0sUVgm
         MJ6nuuITGJHWEsN3xDL1VrUsQaFQuI6181GnAMkUpCyjcjKHygMUrOEAx3YnIq5EmS
         tuiEqRNZxyOd7y/ycXZwyst8fGtte0A/M0xHkv64=
Date:   Fri, 22 Feb 2019 15:32:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
Message-ID: <20190222143220.GA12675@kroah.com>
References: <20190222104844.1847-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222104844.1847-1-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 06:48:44PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> The max flush rep count of HvFlushGuestPhysicalAddressList hypercall
> is equal with how many entries of union hv_gpa_page_range can be populated
> into the input parameter page. The origin code lacks parenthesis around
> PAGE_SIZE - 2 * sizeof(u64). This patch is to fix it.
> 
> Cc: <stable@vger.kernel.org>
> Fixs: cc4edae4b9(x86/hyper-v: Add HvFlushGuestAddressList hypercall support)

Please use this format instead:

Fixes: cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")

And don't type it by hand, use a git alias for it:
	git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"

You also messed up your To: line, keeping anyone from being able to
respond to this message who do not know how to hand-edit the response
line :(

thanks,

greg k-h
