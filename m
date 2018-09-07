Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8A1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28D920861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28D920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIGMDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:03:00 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:39330 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeIGMC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:02:58 -0400
Received: from [2001:b68:ff:12::131] (port=50070 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fyB6t-0008U8-SM; Fri, 07 Sep 2018 09:23:20 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id AA510202E0; Fri,  7 Sep 2018 09:23:19 +0200 (CEST)
Date:   Fri, 7 Sep 2018 09:23:19 +0200
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, drbd-user@lists.linbit.com
Message-ID: <20180907072319.GA26705@gavran.carpriv.carnet.hr>
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905113515.GU26705@gavran.carpriv.carnet.hr>
 <20180905162801.GB26705@gavran.carpriv.carnet.hr>
 <20180906162932.7qge5dmrgyqbmbbj@mac.bytemobile.com>
 <20180906221929.GZ26705@gavran.carpriv.carnet.hr>
 <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907071530.te5dxdvg4zqgqscj@mac.bytemobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: Re: [PATCH] xen-blkback: Switch to closed state after releasing the
 backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:15:30AM +0200, Roger Pau Monné wrote:
> I'm not sure that's a good idea, there are a lot of backends (apart
> from blkback), and the tools won't know whether a specific backend
> supports such state or not. Also the current protocol and states are
> shared between all the Xen PV devices, so new additions should be
> considered very carefully.

Sure, I understand.

> IMO the best options are either calling vbd_free/vbd_create at proper
> stages in blkback or changing the hotplug script so it waits for the
> device to have no open clients.

Changing the block-drbd script would be ideal for me too, but I don't
think that piece of DRBD state is exposed at the moment.

-- 
Valentin
