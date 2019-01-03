Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C55C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D032218D2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfACRlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:41:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59225 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbfACRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:41:38 -0500
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1gf6zv-0006Kw-Mv
        for linux-kernel@vger.kernel.org; Thu, 03 Jan 2019 17:41:35 +0000
Received: by mail-oi1-f198.google.com with SMTP id b18so24340106oii.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sGb4XEzPZIAF9ImqYSs/+Ejn6NkMQw4KrWZyezAgmes=;
        b=fbCOiC1mFpG33Rt4reUB3nCyfZ7KEiJ0LX4V7I5v63DZPFmvRr9dQsezM24WgvoSwd
         CeN4EIwDlithL6zM6g0vnGUENt5hRT0iAdi7LQnETpKqeLCRjTkRNriL3wtPqW39YsNp
         kLtPEfpA7tJKdaQvQNlHsXpoVtZnlPGMzrSsLA0rtzW/cUOL7FRxWq7EfKq7O2XRj5KY
         oh7LwY46Xf6uxqFCoQ7TIRNFzOxpejZGlKHtHMPrykmVAuuIhT3k3FQNzIVWKk9MOFUc
         IKPrl9yo4phV3YpKTOABjtljQ3e/nmUDBiQwfxizcHv0HbEs4q30x9D1YkNogkWRMOgF
         WpzQ==
X-Gm-Message-State: AJcUukcwEeWXJhseoxx2Ft6/10IGhugw0bvpr/Kh/WCaOx+TgxK8lVbn
        mQvksF6L9Ypsl8F5Uh91DxxH+m66gwcZC77cRTBhpudG1eruRxfTc4rVr3rAhsIfVfzjkLZzwbQ
        fbZsLprAN4/iUgWO9gJKySpDIBsqdwwsoHTl25HMbNQ==
X-Received: by 2002:a05:6830:114a:: with SMTP id x10mr10337843otq.89.1546537294466;
        Thu, 03 Jan 2019 09:41:34 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7cUiUQXXlzX2K3LQ13k2+WEtlkk5xlsL+nVowP/+YhGs7at2WMkDUwQhWsTYVa/fqxOMnZqQ==
X-Received: by 2002:a05:6830:114a:: with SMTP id x10mr10337823otq.89.1546537294131;
        Thu, 03 Jan 2019 09:41:34 -0800 (PST)
Received: from xps13.canonical.com (c-107-2-141-103.hsd1.co.comcast.net. [107.2.141.103])
        by smtp.gmail.com with ESMTPSA id d66sm27518730oia.29.2019.01.03.09.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 09:41:33 -0800 (PST)
Date:   Thu, 3 Jan 2019 10:41:32 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     "lipeng (Y)" <lipeng321@huawei.com>
Cc:     Salil Mehta <salil.mehta@huawei.com>, davem@davemloft.net,
        yisen.zhuang@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH net-next] net: hns3: Config NIC port speed same as that
 of optical module
Message-ID: <20190103174132.GA19859@xps13.dannf>
References: <20181126184300.24964-1-salil.mehta@huawei.com>
 <20190101012205.GA22494@xps13.dannf>
 <aadad75b-a3fe-8bf1-77ce-14d3375ce4fd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aadad75b-a3fe-8bf1-77ce-14d3375ce4fd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 08:45:36PM +0800, lipeng (Y) wrote:
> 
> 
> On 2019/1/1 9:22, dann frazier wrote:
> > On Mon, Nov 26, 2018 at 06:43:00PM +0000, Salil Mehta wrote:
> > > From: Peng Li <lipeng321@huawei.com>
> > > 
> > > Port 0/1 of HiP08 supports 10G and 25G. This patch adds a
> > > change to configure NIC port speed same as that of  optical
> > > module(SFP/QFSP). Driver gets the optical module speed and
> > > sets NIC port speed accordingly.
> > Hi,
> > 
> > I'm getting the following errors in dmesg about every 1s on a D06:
> > 
> > [  766.761823] hns3 0000:bd:00.0: get sfp speed failed -5
> > [  767.785823] hns3 0000:bd:00.0: get sfp speed failed -5
> > [  768.809820] hns3 0000:bd:00.0: get sfp speed failed -5
> > [  769.833818] hns3 0000:bd:00.0: get sfp speed failed -5
> > 
> > Reverting this patch fixes the issue.
> > 
> >   -dann
> Hi,dann,
> 
> Thanks for your test and report.
> 
> This patch needs to match new fireware verison ,
> And  it  does some work to  be Compatible with older versions.

I did upgrade to the latest available firmware (20181213-b20), but the
problem persisted. Maybe the necessary firmware is not yet released?

> Can you show me more information？
> can you  use "ethtool -i ethx" to get the fireware version ,
> and shows me  some other message about hns3?

Sure: 

$ sudo ethtool -i enp125s0f2
driver: hns3
version: 4.20.0+ SMP mod_unload aarch64
firmware-version: 0xb0311019
expansion-rom-version: 
bus-info: 0000:7d:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: yes
supports-priv-flags: no

  -dann
