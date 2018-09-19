Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10440C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3B921533
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="huaZi081";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWB104/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3B921533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbeITCir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:38:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59659 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727760AbeITCir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:38:47 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BE9621DB7;
        Wed, 19 Sep 2018 16:59:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 Sep 2018 16:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=PAldRkBaFAzLsR/TrPsqZM0n7gHPXyzC3/GcLvjyF/E=; b=huaZi081
        vqfyvzvxsqUbFS1hbKt23bDWoQRZaBvimJy7NrUek0AkvPFan2fkQHcyztLEgdK5
        /tI0OKQLM5g0dBDTKRL2RVTDexjYI9QrKkdUJKvguGBI7E/cPmWBsKc8iVLJM+T3
        aHdacYH5j6zPQJv+3ZYy0RiBEOZQiBBxPGrv938AR2YL6tnexANPxlQYqb0x3qmH
        RZy6U4HnjuHGChBvVbUsj9Jhee/aIXkO1du8bWR+DOJg03oCJQOnr+5ELG3W+YTS
        27IrLQLWhk2l+aDBjU23qploEtA0OOCXm/DgKYEM/EP1V7vk65GkDC207ze/QyAc
        KXmbtG6VywHvfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=PAldRkBaFAzLsR/TrPsqZM0n7gHPX
        yzC3/GcLvjyF/E=; b=SWB104/eJHRv83k2IGuJo4JrGCxWfDhkp3zcCPiisiBkW
        BVsiyqSXGe04Wg5uf2Y0mjORlPIg7xC2UWbD57/20q/YX/nqx9CIrAo/2s3KvZ9C
        t7yBjlc949Fro8iT6XDY7tGHadmXGZq0yInPEUDidB4cfzcuG+XdqP+wOpZCGbMl
        nw2JdeE/YL0Cnf3BDImuOwJgV1sc36cChTgvv4jszAw5ylPDhP8NFTUrXqLg1l7l
        Roda5Ch5+dyvi2vv+CBLvpfSiyx+FCd08KOSYOi5HhxvfqZzt8KmktgJtG86+vBh
        qqUoFi9wEp65ydsCPl9FGWyxX7aDx5PoasmB3WnUg==
X-ME-Proxy: <xmx:mLiiWzGei8dZRv-f1t43-wZtHIb-SKpgNUhwdxxj1iJsrQ9jgtxBXQ>
    <xmx:mLiiW0a7AwY_WcHj7du5cvGI8lG6r3GI9USZbdz8xwoAvM9bq4jL_Q>
    <xmx:mLiiW6U3X3L-b_ltp9n4fsZNkGgcrW1_sBiCQcayWPdcAcB54_3lFg>
    <xmx:mLiiWxnVu_kZ37gedwa0Bdoii8r7MRnm-Mj1H5lJwBewwG-RBh3dgg>
    <xmx:mLiiW9blKkoCnkJq7tscUi2bXUEQcinbfyTHmHIWwi2oPhYP_4l1Xg>
    <xmx:mbiiW91oiYGIMsywXnDSQBCJnZPd60dOEszLaoU8vD3ZJDjL0PXNwA>
X-ME-Sender: <xms:mLiiW18tkVjwi-ZICYIcHK0JiomylKRPGURjPjPgEaIWUDdubAFn4g>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59E2F102E4;
        Wed, 19 Sep 2018 16:59:04 -0400 (EDT)
Date:   Wed, 19 Sep 2018 22:59:02 +0200
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SCSI fixes for 4.19-rc3
Message-ID: <20180919205902.GA7233@kroah.com>
References: <1537355685.4640.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537355685.4640.5.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 07:14:45AM -0400, James Bottomley wrote:
> A couple of small but important fixes, one affecting big endian and the
> other fixing a BUG_ON in scatterlist processing.
> 
> The patch is available here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

Now pulled, thanks.

greg k-h
