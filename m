Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D361C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD509206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD509206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeIGMer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:34:47 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:8585 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbeIGMer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:34:47 -0400
X-IronPort-AV: E=Sophos;i="5.53,341,1531785600"; 
   d="scan'208";a="78688784"
Date:   Fri, 7 Sep 2018 09:54:55 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <drbd-user@lists.linbit.com>
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
Message-ID: <20180907075455.szxahgevvlmfjvwy@mac.bytemobile.com>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
 <20180907072319.GA26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907072319.GA26705@gavran.carpriv.carnet.hr>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:23:19AM +0200, Valentin Vidic wrote:
> On Fri, Sep 07, 2018 at 09:15:30AM +0200, Roger Pau Monné wrote:
> > I'm not sure that's a good idea, there are a lot of backends (apart
> > from blkback), and the tools won't know whether a specific backend
> > supports such state or not. Also the current protocol and states are
> > shared between all the Xen PV devices, so new additions should be
> > considered very carefully.
> 
> Sure, I understand.
> 
> > IMO the best options are either calling vbd_free/vbd_create at proper
> > stages in blkback or changing the hotplug script so it waits for the
> > device to have no open clients.
> 
> Changing the block-drbd script would be ideal for me too, but I don't
> think that piece of DRBD state is exposed at the moment.

Then I'm afraid you will have to look into the vbd_free/create fix.

Thanks, Roger.
