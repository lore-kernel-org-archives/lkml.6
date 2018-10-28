Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA83C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3610620672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3610620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJ2CUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:20:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41338 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeJ2CUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:20:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id a19-v6so2839621pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 10:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ko6DMPZzGP/t0RFZm/l/OMhRIWBXiTrmvjX1V2BRzY4=;
        b=S115Wh3FHoSQ+eGcs0i7dpKlvmDP2Y5Q9ywyR4x7N3g5tk1BdZG0kAN5GACqPlSc0y
         5zR2W68mH6DajMqFQKAa9PmB4flPQDb6pczy/JrEALzJrY7TWN8SyAYM6RUklscgwW4W
         2wtynW/MU3MYsUKUB2zThx0vsGDdRNm4+YKfBlq7BApPj/TnvCr9qVAbR/5vz5N3Dg/c
         uvtVNAcgY43/2Kq4ZR1q2LLnlK313Q9q7Yij37+VCyX2kR0cCGi0jzxQa0S7S8uEq4P6
         nkss2xotNzx9DhARwbLMx4Qrk/vtK96/xDnFlvG/kS5ykMG6Dvk7yKNw3poTBDCzh0Vo
         PzIg==
X-Gm-Message-State: AGRZ1gIkn4s7YtIrOxSuMJWmMM2lkh4dMcBc0ovolQRFSDHhpElhEd0k
        6PQm51Q0KUk1ZBQ0RvrZshs0Cw==
X-Google-Smtp-Source: AJdET5eokQ7geGgMWCkjNfhHgxE0Zllc971l/V8hSLTczzqArMhQvJ5TUEStlsdeIHobJQpN4liLJw==
X-Received: by 2002:a62:34c5:: with SMTP id b188-v6mr12275911pfa.65.1540748106485;
        Sun, 28 Oct 2018 10:35:06 -0700 (PDT)
Received: from localhost ([2601:647:4700:ab4a:e7d0:9f45:8bc9:57ab])
        by smtp.gmail.com with ESMTPSA id i13-v6sm2797441pgs.51.2018.10.28.10.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 10:35:05 -0700 (PDT)
Date:   Sun, 28 Oct 2018 10:35:03 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Andreas Puhm <puhm@oregano.at>
Cc:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Anatolij Gustschin <agust@denx.de>,
        Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181028173503.GA4358@archbook>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
 <20181023182649.047f1f93@crub>
 <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
 <20181024095135.GA1382@archbook>
 <alpine.DEB.2.20.1810241545580.2819@mgerlach-VirtualBox>
 <1540457043890.27497@oregano.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540457043890.27497@oregano.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Oct 25, 2018 at 08:44:06AM +0000, Andreas Puhm wrote:

> >My experience with cvp is with Arria10 and Stratix 10.  The PCIe Hard IP
> >gets configured when the IOring gets configured at power on.  The idea is
> >that the load of the IOring is very fast, much before the infamous 100ms
> >PCIe timeout for link training.  When the Hard IP is configured, the
> >CVP_EN is set or cleared according to how it was configured.  Yes, you
> 
> So is it correct that the value of CVP_EN can be evaluated by the altera_cvp right in the first call of its probe function
> (as would be the case with my proposed patch).
> 
> If it is, I will fix the remaining issues with the patch and submit it.

Yes please, go ahead and fix up the remaining issues (+ send it using
git send-email)

Thanks,
Moritz
