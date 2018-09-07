Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5F4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE282077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="dAWckZE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE282077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeIGQoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:44:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44665 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeIGQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:44:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so14684709wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Cuv5nIbxXA1T4QHQ8A8xCqoPE9cBAsHCrlhDJLxfo54=;
        b=dAWckZE3SGECbNEoADcVXLBVxVlzH9VIciMiv31xKOxTZMeh/axGiyGiP6ZErjknkq
         h3kD+enqwHJhsT48tfBNCepJzy62XsYtHEanY1b5vu4rUlxKDuYeSgV2WBbkwrAIlfDP
         vjIMg5d1zWT3ytheBsKH7w8V9ITQBr0/eq91QOwpoa2LY5THO/C93BnyksHLB591smVh
         fpujcyDSaYpX0TCdXMyTXrUMADzwFbezWPAyzyuzW3IkpYl3yEGydnH9+b0Ssw+e/5xE
         LUgsbWLYKwzHDGLLLKh9KfIJDf01LH2m6kwbPMQnIZMqlAYL+GiordSaSV4lIkVbrjLo
         PgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Cuv5nIbxXA1T4QHQ8A8xCqoPE9cBAsHCrlhDJLxfo54=;
        b=LDZ88Pm45AAD1WEISsM5jov90Mo0UtkbkzDykXjtqvgrIgSIOesZSRqX/zTLL+l5e0
         e+V9Dh7Sl6+OKX1qfPkLkZ0PZ19Ncu2zpeHH36h57eLVvwBRDmOvm+yqhInTJW4mqcZw
         JgtK6gonl3GTywi7O0nciQycnNu2JCGREvK7v4XbTg3UZ3vE6qJyaJnFV994xVUB6WOm
         eH8myvc670AJGKQlHuygxH2JB1DGOXOTo0mCSa4LcTl5fj7HJRXsXigPkQjWfGAkgGLI
         BuJd3sSaQs9Q3VkmfwosE6e2IM5LF2Q94A/3L/rgybBIJSPi7wey3aK+/tw/OnlLYGXc
         Wt7g==
X-Gm-Message-State: APzg51A0QOxPDqEAZBM5e/K9RvOydhwVoavtUC38yGAmfWB08lDKVi6v
        A3t2fRyRz4dQjFpp+SB/KzQcEg==
X-Google-Smtp-Source: ANB0VdaYyyCYfnGraqiW5C7u/s/wR6LZORFL6kaBhmoYU3mZUS1dhZIvMie1dRGDu6BjjErVG97O9A==
X-Received: by 2002:a5d:5009:: with SMTP id e9-v6mr340222wrt.18.1536321818859;
        Fri, 07 Sep 2018 05:03:38 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id 198-v6sm12578484wmm.0.2018.09.07.05.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 05:03:38 -0700 (PDT)
Date:   Fri, 7 Sep 2018 14:03:37 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        drbd-user@lists.linbit.com
Subject: Re: [DRBD-user] [PATCH] xen-blkback: Switch to closed state after
 releasing the backing device
Message-ID: <20180907120337.GB11834@soda.linbit>
Mail-Followup-To: Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        drbd-user@lists.linbit.com
References: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
 <20180905103649.edugijsjx4v2fbxd@mac.bytemobile.com>
 <20180905162756.GA26705@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180905162756.GA26705@gavran.carpriv.carnet.hr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 06:27:56PM +0200, Valentin Vidic wrote:
> On Wed, Sep 05, 2018 at 12:36:49PM +0200, Roger Pau Monné wrote:
> > On Wed, Aug 29, 2018 at 08:52:14AM +0200, Valentin Vidic wrote:
> > > Switching to closed state earlier can cause the block-drbd
> > > script to fail with 'Device is held open by someone':
> > > 
> > > root: /etc/xen/scripts/block-drbd: remove XENBUS_PATH=backend/vbd/6/51712
> > > kernel: [ 2222.278235] block drbd6: State change failed: Device is held open by someone
> > > kernel: [ 2222.278304] block drbd6:   state = { cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate r----- }
> > > kernel: [ 2222.278340] block drbd6:  wanted = { cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate r----- }
> > > root: /etc/xen/scripts/block-drbd: Writing backend/vbd/6/51712/hotplug-error /etc/xen/scripts/block-drbd failed; error detected. backend/vbd/6/51712/hotplug-status error to xenstore.
> > > root: /etc/xen/scripts/block-drbd: /etc/xen/scripts/block-drbd failed; error detected.

Very frequently it is *NOT* the "original user", that "still" holds it
open, but udev, or something triggered-by-udev.

So double-checking the udev rules,
or the "lvm global_filter" settings may help.
You could instrument DRBD to log current->{pid,comm} on open and close,
so you can better detect who the "someone" is in the message above.

Adding a small retry loop in the script may help as well.

As a side note, 
with DRBD 9 (which still moves too fast to be "in tree")
we have the "auto-promote" feature, where no explicit promotion/demotion
is necessary anymore, but DRBD (tries to) promote itself with the
first "RW" opener, and demote itself once the last opener is gone.


Hth,
    Lars
