Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BA420843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="aQ9uA5Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BA420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeIYNhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:37:18 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35770 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeIYNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:37:17 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0DA3025B749;
        Tue, 25 Sep 2018 17:31:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537860663; bh=Hm3Dmzfuuh5QnIK9sCeVyjI4FWwH5qhc9AAncoSb+2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQ9uA5Mp5wqqXbRxOFar57k3T70cjLViSAudDUqS8pqf5YpIoblWD3vLPEn7hs8wL
         JXc0O9mweod2IwuW2kaxaBVEVIkMBegZ9FwsNwH7pp8HQBpPh7RAfk/rrp4XplsbTZ
         v+P6ZWhd3dFmNUMcbbGo9Pdv1dhMwWSfiMEvY0Uk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 0E8AF940453; Tue, 25 Sep 2018 09:31:01 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:31:01 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 8/8] phy: renesas: rcar-gen3-usb2: add is_otg_channel to
 use "role" sysfs
Message-ID: <20180925073059.2ijq4qzqd5vup3ug@verge.net.au>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1537530804-19399-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537530804-19399-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:53:24PM +0900, Yoshihiro Shimoda wrote:
> Even if a board doesn't have otg pins connection, this hardware can
> change the role by a register setting. So, this patch adds
> "is_otg_channel" for it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

