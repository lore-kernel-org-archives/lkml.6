Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE4720684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEyNs3nX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE4720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeJBPUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:20:30 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37806 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeJBPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:20:30 -0400
Received: by mail-wm1-f49.google.com with SMTP id 185-v6so1299762wmt.2;
        Tue, 02 Oct 2018 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NRt88zxXRDWXUWgWsbvCWbciUBL6Rr2yx3VUnWtY6rQ=;
        b=AEyNs3nXD0CY1wurEYpAJ9Sk0u5OXaoRh888YZQAr12STcIR3cFmGc9a+HWxm1bhEh
         siSPIUN1lcB86w4eMKBA1ZDWbkl8Fjrn85/CTzkbsMDkpMk9m3B01aU67JUQofTKaGON
         /9HHndmQOiW304X6SCpA6oUEECJZql5n0T9Cc+eoMCWK0lus4vP7PvODg6A51gZUbX1/
         m/d6uYgPMeFI7lF5VDYYSFfEiWvmAko5emSwOUem5z4zk04mAiINCoDpAyrem791/aY8
         Qo/ZTf21TiCJzkpFq/fx4fDfyU6L62eHUDr06pZ9XKv66OHaC8OzGMD6hsSR3BClkStA
         xnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NRt88zxXRDWXUWgWsbvCWbciUBL6Rr2yx3VUnWtY6rQ=;
        b=cUd1BpoBEgQ9YQKesOwikVJZqSGu+90tmHKZT1a5xP1d88sxMfGCR4qlGse8l27Hoh
         ho2hfFlqjozgbugyPpVmQg1WbCtl8Jnnw3f76N/nwrZUEEUQlwwO8jT3e0IoBlj+wFqV
         HBcM3ewMpVOQ8mSt9cgRTvcT3AuFa6yHUKCUGatzOVReRhlS2gMB7xakF218zsop+sjX
         W4tojlgKhv99NVKjRfP4vSMnLdsZk0M3UUgATlpEm8ZkM29xFELek5hnr5cyxW9TQpEB
         tEQoUNcjDYRPmnbuWabwhxaa4iqI1yhd78ytAJ6fei/xxEuNh0J1crxcXad5W+023Tgs
         BPuw==
X-Gm-Message-State: ABuFfojwBPRL72EnEDeqYRWhQc7OilzMS9Zowu1nFjXInOCdXwq0QaG/
        RXjy/PfuWsd9qfe/xi6Wjmo=
X-Google-Smtp-Source: ACcGV61giPxs/2f6qq3e2XhxoYvzQqo1Tf1bKID6GqXR5rzuy076LlOf8sOfV3tucXeug8N3qU1luQ==
X-Received: by 2002:a7b:c017:: with SMTP id c23-v6mr1148663wmb.136.1538469500499;
        Tue, 02 Oct 2018 01:38:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l125-v6sm15362943wmb.1.2018.10.02.01.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:38:19 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:38:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [GIT PULL 00/11] EFI updates for v4.20
Message-ID: <20181002083817.GC120270@gmail.com>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
 <7c25a402-0fc8-fe70-ac95-348a93f4fe69@arm.com>
 <20181002083456.GB120270@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002083456.GB120270@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> > Hi all,
> > 
> > On 27/09/18 09:50, Ard Biesheuvel wrote:
> > > Thomas, Ingo,
> > > 
> > > Please pull/cherry-pick the below. Note that the first three patches will
> > > be depended upon by an irqchip series that Marc Zyngier has sent out last
> > > week, and that targets the next release as well. So please advise how to
> > > proceed with that: we could simply apply those patches first and use the
> > > resulting commit in tip.git as a stable branch, I suppose, but I'll let
> > > Marc chime in in case he has any other ideas.
> > 
> > A stable branch with these three patches would be great. The irqchip code
> > will also end-up in tip, so it should all be quite easy to manage anyway.
> 
> Yeah - nevertheless, to keep it all separated nicely, I've created a new
> topic tree for this: tip:efi/irqchip (2e3ac98133a3), with just these three
> patches on top of latest -git.
> 
> That way it can then all be iterated separately.
> 
> Does this approach work for you?

It's a23d3bb05ccb - i.e. the commit ID of Ard's tree, so if you already based your work on top 
of that then you won't even need to rebase anything.

Thanks,

	Ingo
