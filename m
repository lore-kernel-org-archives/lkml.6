Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29447C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F332087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuJbCb3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfBYAJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 19:09:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36778 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBYAJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 19:09:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id k2so3615045plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 16:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRL6UsEO/rvJ55w2sZtRGCTBil9aZeQ8KAlWhXZVy+I=;
        b=GuJbCb3eMvzjkg4qro6YPQvpox8bPAZ7vm1/gcP6GrfdT/+6jcWknXGKqZAUoGiISZ
         rdhahPnwLLfsbGZJMXtwgphzvo54SmuIzrM6x0O32mfA6g68+bGw6L04fvxeLDkXaV7a
         xFfi8+zZg4EPuPfI4S8H91mfjyVir1zCf2nnURJUWb43onTN7mDfU4XIPM0tsKG/ZHzL
         tbAHqVPgFplWf5fh/L/7g4WbXk7oYzokWEi3UN2WkgsXeBlsAzbROAfoqj31hGVSXF2G
         WtU59aM+CgoIqfY47NocAYFQZKOEK2tLeQdJ5h6NTwReWpnEBdSV8E6/asXaqjS0nu2E
         IdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRL6UsEO/rvJ55w2sZtRGCTBil9aZeQ8KAlWhXZVy+I=;
        b=oko0mb3s9Mn+sO24KvZkgUY6+bNMJdtZRV1LmQoVa8uPMudLhX4oH5x53f3QSsFJyQ
         zssiDUo2E+7PRnhLWptQZnaa8bj7yE9t0wdsBJDcn+LheOfD4z2pCIX7usi0+hLacnM7
         6FX03meV1c6wwkCaHRl7QTUt33QXIYV86VgT4NbN8rIpkpZh/pnNljZ3nRPOC/DIIlLB
         hoeqS+QlN52mNQ/1ZThWtWW8jSiY9aqYG65YHbndWt/0pn7mIQ8AvGsQw1HslgiJFRL4
         fxNXoEUnXG9p2PRkLOcz99W7uXQKosZmOekibFlQOJmWWEM9P8EMVr7Dbu1rQ0fKlsNu
         gAkQ==
X-Gm-Message-State: AHQUAuYKvUpB3m1ugCCheqx+VNOnPkwsleBeZ33HknZaWCyhP2Xg89Ty
        LK4QtfAPr4GndD2l1MKePimfUA==
X-Google-Smtp-Source: AHgI3Ibxx/zmd2DOPmb4iIjFvR93y7aeEA6esy8u2ty56xR6wqUEXRwrPBNnlC0R1/+HxDWVxw8AUA==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr16881078plb.256.1551053376828;
        Sun, 24 Feb 2019 16:09:36 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([240e:e0:f891:19f7:b1b0:fed6:e3b3:4ba1])
        by smtp.gmail.com with ESMTPSA id 70sm24500168pfr.43.2019.02.24.16.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 16:09:35 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:09:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Message-ID: <20190225000917.GA4001@leoy-ThinkPad-X240s>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-3-leo.yan@linaro.org>
 <20190222083756.359523ca@why.wild-wind.fr.eu.org>
 <20190222085439.GA845@leoy-ThinkPad-X240s>
 <20190222093923.09e36583@why.wild-wind.fr.eu.org>
 <20190222124906.GB845@leoy-ThinkPad-X240s>
 <86r2bzrful.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r2bzrful.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:40:50PM +0000, Marc Zyngier wrote:

[...]

> > > The interrupt affinity is either defined by the distributor
> > > configuration (SPIs) or the ITS configuration (LPIs).
> > 
> > Given to the up example, I am struggling to understand how you can set
> > the interrupt affinity for virtio device.
> > 
> > Do you set the physical interrupt affinity to CPU0/1 in host OS and
> > forward it to guest OS?  Or set interrupt affinity in guest OS (I
> > tried on Juno board to set irq affinity in guest OS from
> > '/proc/irq/xxx/smp_affinity' but failed)?   Or this is accomplished by
> > user space tool (lkvm or qemu)?
> 
> virtio interrupts are purely virtual, and the host plays no part in
> their routing (nor does userspace). As for their affinity, that
> depends on the virtio driver. Some virtio devices allow their affinity
> to be changed, some don't. Here, this is a virtio-net device, which is
> perfectly happy to see its queue interrupts moved to a different vcpu.
> 
> I tend to run irqbalance in my guests so that it actually exercises
> the affinity setting in the background.
> 
> > Sorry if I am asking a stupid question :)
> 
> It's not stupid. You're simply confusing multiple independent layers.

Thanks a lot for explaination, Marc.

Thanks,
Leo Yan
