Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA18CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9114620989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="DAV3sxeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9114620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeLMEIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:08:32 -0500
Received: from mail.nic.cz ([217.31.204.67]:36041 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLMEIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:08:32 -0500
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 8A7B162921;
        Thu, 13 Dec 2018 05:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1544674110; bh=j7Zf0G2rtW7vEnmWtnVZudM/ZAQStV4sQ+VkHkrAlQI=;
        h=Date:From:To;
        b=DAV3sxeApFvxVejH66JVCSG+J/J/utyy7UlVVmP2q4BUNWF1I1hD5XPPHeuunNM40
         xgLQU+IYeaAxR+kxmg+6/Lh++TyupjualS04nXIMBSyfz+kzzghr5rbeS22F8iCRMT
         bJ5J+mlXz0DGkCLujzqbxktI/I9Gsqer3jZDJQgo=
Date:   Thu, 13 Dec 2018 05:08:29 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RFC] ARM64: dts: marvell: Add DTS file for Turris Mox
Message-ID: <20181213050829.6d942510@nic.cz>
In-Reply-To: <20181204203706.GA25038@bogus>
References: <20181113134408.5681-1-marek.behun@nic.cz>
        <20181204203706.GA25038@bogus>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Tue, 4 Dec 2018 14:37:06 -0600
Rob Herring <robh@kernel.org> wrote:

> > +
> > +	switch1@2 {  
> 
> Ideally, we shouldn't have this switch0, switch1, etc.

I can rename peridot switches (switch0@10, switch1@11, switch2@12 to
swtich@10, switch@11, switch@12), but I cannot rename Topaz to
switch@2. Topaz always has MDIO address 2, because there can be only
one, but it can be connected either directly or after the first or
second peridot. Therefore I have three different nodes, each describing
different connection to the previous switch/cpu.

How should I rename it?

Marek
