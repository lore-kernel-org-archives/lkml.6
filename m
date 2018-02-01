Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2578270-1517462750-2-16806404519573929027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517462749; b=X435TJoN/e0FiEI9aasI/JAGbOAHdwBpud5jxlI6rDfm2gl
    q7uQ+2Q2qu+PgRczxpNFg0IHEaEaWS1J+dd+B5/FocP1mLbN4/eLLKe4dMUCeh2i
    0YvA9PeOjkS/DOOiPQKe1H3W9IKyQVHPIHh4AYl73V33O0Hd/56VpyW8kFlEDAiD
    XczTcN/Efs80gfWUgRnIo4amZ133Z52DMmOTjnhcfk/MDkbVmprHfSHS6bEyeBtr
    j7AECowsAPpjnKQay9HgLcI0s5bqH5rCZOOwoZ8hSFUf6Bo4GPM8yhN2K0GUQXfs
    cYGPOAdtu5F9R+W6Y/sRYJpEXTr2SEKn2IvGHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517462749; bh=59NTKj4oFgw+oceFCRanonPDUX
    cLpI2uglPOzlYqH0A=; b=s3SiyxCr0jpCrC5napqRv3RuvY/BV7Wq8DzirHZo7u
    f31ZPb6CFPHETngITMGesfG6OnmSfqSHOnalvo9xptYmfxkB3wgtosEkty3nnJu5
    SfGSHQrIK1y/tNpcUfnPQkYXUCsxA4hNe8hVB5gxWv215St1GX3t0y/Rm13xf56L
    BQItBfwwMa36TxfEYaCmGA2L5WrJGB2nE54pAyS/Z5ecXxAMFDdsfIxM58H5PTxP
    +Q3lJLqb61pwdUxo+ezrThOngpIh8J5/ZeKr9l7pPZKg7XBkLHsnFAqY14UMYpAo
    P4u/XUH39ndUg9j2Lc4qowBL9XvGYZKHhDk3ng4uQk1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBAFZr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 00:25:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:58822 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbeBAFZq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Feb 2018 00:25:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="scan'208";a="24042418"
Date: Thu, 1 Feb 2018 13:16:25 +0800
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
Subject: Re: [PATCH v3 19/21] fpga: dfl: afu: add
 FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Message-ID: <20180201051625.GD10273@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-20-git-send-email-hao.wu@intel.com>
 <CANk1AXSfUfVbtbuREwG5Ck8TNZrqBg1fO5AuDDdFk-x=UjRTiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSfUfVbtbuREwG5Ck8TNZrqBg1fO5AuDDdFk-x=UjRTiw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 08:52:36AM -0600, Alan Tull wrote:
> On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> I'm adding my "Acked-by' below.  When you post v4, please add it so
> that we can keep track of what got acked.

Sure, thanks a lot for the code review. :)

Hao

> 
> Thanks,
> Alan
> 
> > FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones which
> > need to be supported by all feature devices drivers including FME and AFU.
> > This patch implements above 2 ioctls in FPGA Accelerated Function Unit
> > (AFU) driver.
> >
> > Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> > Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> > Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> > Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> > Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
