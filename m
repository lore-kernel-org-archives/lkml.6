Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A503BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4083A20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="UUFLcM9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4083A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeIYNgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:36:55 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35742 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeIYNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:36:54 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6A6A225B749;
        Tue, 25 Sep 2018 17:30:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537860640; bh=0Sj0HiCfOl5gLkkBL+kz513Fw8cQt59Ut18FJpUCWUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUFLcM9X2r4c+Rag7JZBTO73vcHcKcLL7SR/syJ4onQMBB15Tfx0IaxTgplQBH/v6
         OEvOXvDwpGLbKQQ3t0n33ckKgHOWCiTOciE/8F1blseUXNJmiAdo0iQNZv6NuQfq7k
         KW9m+bYcfjXSjLhDEegVmUZ0rA7P/ntWHteUeE0k=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 6630F940453; Tue, 25 Sep 2018 09:30:38 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:30:38 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/8] phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role
 sysfs
Message-ID: <20180925073037.fqcomitltrw3uf6d@verge.net.au>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1537530804-19399-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537530804-19399-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:53:18PM +0900, Yoshihiro Shimoda wrote:
> This patch fixes and issue that the vbus_ctrl is disabled by
> rcar_gen3_init_from_a_peri_to_a_host(), so a usb host cannot
> supply the vbus.
> 
> Note that this condition will exit when the otg irq happens
> even if we don't apply this patch.
> 
> Fixes: 9bb86777fb71 ("phy: rcar-gen3-usb2: add sysfs for usb role swap")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

