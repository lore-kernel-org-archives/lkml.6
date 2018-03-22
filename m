Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646944-1521694212-2-8881653516120048380
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
    t=1521694212; b=gW28uYbow/c3FPilyC51ZSzpjAvMXj/fs+XS80C2Zc0TDf5
    qpVOqA9wCmjsPKmKrgJayap3JjEqKD7T01kvOY/Hhy9ScQZj4Hir5515Eux8jQT5
    Q53fwMZn0vxXl3OHBIy2UwUpDyQU9nIMRspZOrJd3zn6immR3rsedYJKVGv75+L+
    vazzHiSanJUP2yjjE+5LeOnwF5d+S0XUtZJKsb6JVcj2wdMy863Knjiq4YWZRV2e
    U7l4t1beLkuvQ+Gx8LwMhQtcnttzj2ZVo4PBg39dY+EwRVbQJTAEA9Lq9FMikEqb
    gWWqV5KUK/n48VNtpO4hvKu0807SeqDIGIpidLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521694212; bh=E2+xPAEG+P3OudkJLK+rmZdlpn
    DQCflsysJqfofWLP8=; b=GodsPSvJl+kgWVdYI6cIQ3Coi4+PPJemifyB84Txfx
    ZIpV3PrdmRNk/7QikLmfHqJ794FQfvmC+7qBAXDyyeFdLEEFc5nD/zmm0mn1twpU
    QWhhMi65qKEs4GZo0Vsqs4Ki7BDfiPAzVIzAEywElCcxc19wGSWc8Q0JAHR4guP+
    30BBnBr6xJKZ35UnYWpvSfQv7KamlC5XHKKyvzBV5dHFkuSKWyeo1ChNsqMNH4qt
    JMeLbChD8eNeMGtSr3dC7M8bK38qcVG41kx3QYwzZEJpM8brNv7z5oLHBXNZBAEt
    fByCHxVnfOwNJ2ilNQlCzWzWRKL6UO03Y3BY6ML5hRqg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1751948AbeCVEuJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 00:50:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:42882 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeCVEuI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 22 Mar 2018 00:50:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,342,1517904000";
   d="scan'208";a="27832034"
Date: Thu, 22 Mar 2018 12:40:06 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v4 04/24] fpga: add device feature list support
Message-ID: <20180322044006.GA8305@hao-dev>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
 <1518513893-4719-5-git-send-email-hao.wu@intel.com>
 <CANk1AXT0dBT9qejdbSyi75e956OHA0-y0V7de7H=XkOZzVhRqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXT0dBT9qejdbSyi75e956OHA0-y0V7de7H=XkOZzVhRqQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 06:54:58PM -0500, Alan Tull wrote:
> On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> > +static int
> > +build_info_create_dev(struct build_feature_devs_info *binfo,
> > +                     enum fpga_id_type type, const char *name,
> > +                     void __iomem *ioaddr)
> > +{
> > +       struct platform_device *fdev;
> > +       int ret;
> > +
> > +       /* we will create a new device, commit current device first */
> > +       ret = build_info_commit_dev(binfo);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * we use -ENODEV as the initialization indicator which indicates
> > +        * whether the id need to be reclaimed
> > +        */
> > +       fdev = platform_device_alloc(name, -ENODEV);
> > +       if (!fdev)
> > +               return -ENOMEM;
> > +
> > +       binfo->feature_dev = fdev;
> > +       binfo->feature_num = 0;
> > +       binfo->ioaddr = ioaddr;
> > +       INIT_LIST_HEAD(&binfo->sub_features);
> > +
> > +       fdev->id = alloc_fpga_id(type, &fdev->dev);
> > +       if (fdev->id < 0)
> > +               return fdev->id;
> 
> Do we need platform_device_put if returning here?

Hi Alan,

Actually if any error returned by this build_info_create_dev, it will cause
parse_feature_list returns error code and finally build_info_free is invoked.
In build_info_free function, it will do platform_device_put there, so we don't
have to add code to do put here. : )

Thanks
Hao

> 
> Alan
> 
> > +
> > +       fdev->dev.parent = &binfo->cdev->region.dev;
> > +
> > +       return 0;
> > +}
> > +
