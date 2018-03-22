Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654586-1521694319-2-5250068546122319543
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521694318; b=fUjhKRg0s9j9SLuOFy08NzBX3iRrvgzv7uViW1YBvx8SO5m
    ji1cdMjNkN93Lew+28KMDfQpPuWSYbjkjivCacAzzCtM5TLiBmGL4Tqk1d302SXc
    63h/bMBKrnlqZpJMnvUW+AcBOGSdbGRxsp0vGIii3iAPShF3wVhuievFP0nEBHj/
    Ktuuu+6MlEzlcDVj6MgO6Sbim1YbV3FtFeVf5xtv9za2dOdkGN3tQghwtMBZN8ft
    gztsbUI9zv2nGq6XDUTC0jGFdKcM69dHwFGk1vViK1acZeVZ5Gb4fJqz03AdJwzi
    SW8453Mu5SC7vdRfxQczmbKfBnwnsCFEDSLG43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521694318; bh=hFPF61k4sdsj2lBQSlG6ItXgBJ
    +Wl/np1EYaWzlq6NI=; b=Q9MB1nzZH7KtqHfW7AgBYUBxA8ZREbygLJdoFAPVkG
    phlazGUCyfb6IsMCOS8yZfneN1blUVxNtBhSndsZifzxr+LRmTXpaPtR2LRR3ALJ
    fT187yO4bqQs2FLAGyYz/dnhODzafMCLpTaz8612ECNYJTlCwqcBVG9VBQzvgEQh
    P95Xy1ExOOIsuHLfe0iDPHpmiNWMpN8DqqlM8SDmh1GLqd6hGYGQoT1Ywg7J2vBg
    WpndcRO8Dt6ZWx8Pt8EzIc6/tW8Lxvsdp2+1nc6E9KXUQEw7JYjNpLPRUNimglMA
    299BXM97EGLlTlX+nWP6OPfZy9faT6ip2pI27ElmupkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeCVEv5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 00:51:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:3936 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeCVEv5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 22 Mar 2018 00:51:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,342,1517904000";
   d="scan'208";a="30196646"
Date: Thu, 22 Mar 2018 12:41:56 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: Re: [PATCH v4 23/24] fpga: dfl: afu: add user afu sub feature support
Message-ID: <20180322044156.GB8305@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-24-git-send-email-hao.wu@intel.com>
 <CANk1AXQpPXhNoPt1Uj=YvbtO+jun7e2Yzvyp+wuR1ZXx6+-i8Q@mail.gmail.com>
 <20180320071037.GB31239@hao-dev>
 <CANk1AXSyh1ZcbgVbj3DxjULEeYKMfq_4CA6P0DK6+_z-pnBMUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSyh1ZcbgVbj3DxjULEeYKMfq_4CA6P0DK6+_z-pnBMUw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 06:50:54PM -0500, Alan Tull wrote:
> On Tue, Mar 20, 2018 at 2:10 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> >> > +static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
> >> > +{
> >> > +       struct fpga_afu_region region;
> >> > +       struct platform_device *pdev = filp->private_data;
> >> > +       struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> >> > +       u64 size = vma->vm_end - vma->vm_start;
> >> > +       u64 offset;
> >> > +       int ret;
> >> > +
> >> > +       if (!(vma->vm_flags & VM_SHARED))
> >> > +               return -EINVAL;
> >> > +
> >> > +       offset = vma->vm_pgoff << PAGE_SHIFT;
> >> > +       ret = afu_get_region_by_offset(pdata, offset, size, &region);
> 
> Most of the functions here are afu_region_*, but there's also
> afu_get_region_by_*.  Better if afu_region_get_by_* to be consistent.

Agree, will fix it in the next version, thanks a lot for the comments.

Hao
