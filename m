Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82790C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB74214ED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="tLgi0omK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liko1LoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB74214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLDHmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:42:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44515 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbeLDHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:42:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9088921F58;
        Tue,  4 Dec 2018 02:42:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Dec 2018 02:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=FUqZXK9QlSROIut/MRw1EB28oTS
        ZtjAHgHhbXkfa3JY=; b=tLgi0omKYR2AhnvRAEVAtpU5fT82/zd60J08AT7LC6y
        khTFH6OmBTnBT8jNurJUlG3zdx10Sm2S2QBpFHhZmUEM7tHR4TZ70bargKtkIkNM
        7hEzYYDH+1aTTHViy33JbsQp32e8fKGJaeEklNCgnkwNQaFTrZvu3gzAL8l91mdE
        rg4j/lVfcr7VMCMfW4K3m5cpRjQN9eFcYJ6AVyRiXqB38TJL1tnj+Fwp/YdfbY17
        4EZ4pHKmCTlhnn4lJcG4TZjHZ4EoYcmRS/wDM364NgKCh9YdadLGHoB3il7cOTYs
        z9K924DIHEP2Qdvo4FUXnMhF84LwMr+DkKYYfs5NfEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FUqZXK
        9QlSROIut/MRw1EB28oTSZtjAHgHhbXkfa3JY=; b=liko1LoJFKFIstDltFMgIH
        ow7L7poKJ5+ofSMSQmimllLcGnlAapH80raYdqTGeoVsb42x/3+/K80pTuqAxNB/
        VEki0ERBVnalEo1MU2KsH6ePW+OqiVw8bLwbe6eeNQJogRjheVSQCmS52hvv5ApI
        gEHJDbp3hb9kll7eNjCoFMhTdZCEhdIw8DSenGLbvApRyJGVo9xhrZ2O9mbiKC/d
        y3tGqYhr0NKaLKEkmBUmaeVVf470wxCEYR+jtvn6V2vSVw655qVf9+gcvqDW1Mqg
        HzkJgNVNZz/SM4tYzxrLMXtazB+blj5Hx0s+R8UtYJObke8Yu0W0eaZ9DgqK486w
        ==
X-ME-Sender: <xms:8y8GXPl5i0El7ufV27VoRuSbDxcikPWLs2oV17grNlZbjAI1MpdRYA>
X-ME-Proxy: <xmx:8y8GXLQk_2RQNE-6r0N62yarBPmXkIvrhRzp5E5I9rsP_YJHfe0OIw>
    <xmx:8y8GXGx2dZ5qGRCO8XH0Pu_vLVqigFhMjMfPyhGjiiEntAIMr2JCwA>
    <xmx:8y8GXHcCN_yq74TiD1Y-2XiFim93Ou0THTO6Wq8EvXWg8maikReLWg>
    <xmx:8y8GXJP0Diih6_NPObkeYPjhE7igSh4oFYJ12EzwF-t3Lpk3YWH_xg>
    <xmx:8y8GXCuFYfKQLZvG9fuMqGdmurZCTvJtCrQ7F3O13ZtmrCittdzxkg>
    <xmx:9C8GXCQiL_Cybk_vYAxIwJw4RyN_ZR68hdV9z4DeMSRalKGo7TBqfw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B29DE450E;
        Tue,  4 Dec 2018 02:42:42 -0500 (EST)
Date:   Tue, 4 Dec 2018 08:42:41 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <20181204074241.GB27141@kroah.com>
References: <20181204153513.1e799336@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204153513.1e799336@canb.auug.org.au>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:35:13PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/hv/channel_mgmt.c
> 
> between commit:
> 
>   37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channels to two workqueues")
> 
> from the char-misc.current tree and commit:
> 
>   4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoing_channel()")
> 
> from the char-misc tree.
> 
> I fixed it up (I used the former version where they conflicted) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Yeah, this is a mess, I'll wait for the hyper-v developers to send me a
fixup patch for handling this merge issue, as they know it is happening
:(

thanks,

greg k-h
