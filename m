Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC8C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32341208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 18:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RGZJT0AW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixM2Aenc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32341208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeGHSk4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 14:40:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38233 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932563AbeGHSky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 14:40:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 751CF20FAD;
        Sun,  8 Jul 2018 14:40:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 08 Jul 2018 14:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dMWu/hOBckfmNn/1wC8axn7JziypqzsKlXYgkRMGEXM=; b=RGZJT0AW
        zg/H7XZqS0V/R3clXvglL+NZC/7IIRn/HDIgLWk38WP08gIOBmHVEUVx65lZN6ra
        BCO1oaDTBQwCT6kmmlJilnH8a3iZa26jv46QWpO6xBy8xiO9T82wfqhIbhfbvOYA
        EtRrrLI9csKMUC6LUN+FHYEsrCXeUZ0qtcIgt/6/nFf5HlFV2DO91nKSiicqoTdc
        Ed/UZesz4GoCMshyk3b9L3d8VV0kOSCu1G4MbtraRiQWAJDX+EwIq58Dfoif/uFZ
        EgM13j2n4GUNr+G1WHwZR5Ick/OjknlzIv4oqtsJyl46AmDku36G99SbJO/bQrWj
        L5pPjlSOxAxWqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=dMWu/hOBckfmNn/1wC8axn7Jziypq
        zsKlXYgkRMGEXM=; b=ixM2AencR2QDSFczhGYaVBKNIz4XOORdRUI8k0w071Ahj
        tZz5VQk9ArZCgGz1mO8If+k930pGjQjty7PLR6F2dfCI2VxMV5fJ76aYxo1y9svq
        pn5IE1P7nYcJicDihSwISo1WEs3Eq7nUtZTbPwOcvMrYWJOh48Eg1WJQtEi6l/1i
        W3w9kHrkXZSMjwPNRUtvTN8i++RtbRYsUXJOr1fHQEH+xFqh90IGv0V6XHG8ruLv
        Irn55AtOdO7Xd3UTezvfYQmzUb+fFVwUNW/ZzG45/5H8cFeoOmgFqffy46SIafgq
        XaZJfFotbm7gL0uP8Y/XXuVJQZDb4YOvIcKUX6scQ==
X-ME-Proxy: <xmx:slpCW7SK7ptzZ0r0W0xeCZdDeEJ-mxiBlERSSPNFwQT2o7BxTCP3jA>
    <xmx:slpCW4oVIodLgzj3NYX8XYN0E14S7DPfLszoPu5HsSmfFl5jdBUAJw>
    <xmx:slpCW8UOKbm8WCPmSYVwp8uKRDU_UrN49I6yYECGZaoLZNiY7mEVog>
    <xmx:slpCW-8xz4AhuYfHxThVUt-i8d5L807w1ycQeRbjsGAiijWdgXVkqA>
    <xmx:slpCW8a11MSRY28VfZ4m-AdMqK9b4TIo_IsuHRN5Pc0oDh9exLKmYQ>
    <xmx:s1pCW4OYtm9DDdN1OPylbHHLDN3PRP7kqkUDuLWrv9W6iNzP44o2yg>
X-ME-Sender: <xms:slpCW1whGABQC2j3VaX2dD3NwU_KP8B2H7RVLsvmCE-KD37rlxBqJA>
Received: from localhost (unknown [46.44.180.42])
        by mail.messagingengine.com (Postfix) with ESMTPA id 872F2E4439;
        Sun,  8 Jul 2018 14:40:50 -0400 (EDT)
Date:   Sun, 8 Jul 2018 20:40:49 +0200
From:   Greg KH <greg@kroah.com>
To:     Alexey Brodkin <alexey.brodkin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2] devres: Really align data field to unsigned long long
Message-ID: <20180708184049.GA1645@kroah.com>
References: <20180708175621.6951-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708175621.6951-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 08:56:21PM +0300, Alexey Brodkin wrote:
> Depending on ABI "long long" type of a particular 32-bit CPU
> might be aligned by either word (32-bits) or double word (64-bits).
> Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> 
> At least for 32-bit ARC cores ABI requires "long long" types
> to be aligned by normal 32-bit word. This makes "data" field aligned to
> 12 bytes. Which is still OK as long as we use 32-bit data only.
> 
> But once we want to use native atomic64_t type (i.e. when we use special
> instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> misaligned access exception.
> 
> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
> 
> Changes v1 -> v2:
> 
>  * Reworded commit message
>  * Inserted comment right in source [Thomas]
> 
>  drivers/base/devres.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Always use scripts/get_maintainer.pl to properly cc: the needed
developer/maintainer.  As it is, this patch is going to get dropped on
the floor, sorry...

greg k-h
