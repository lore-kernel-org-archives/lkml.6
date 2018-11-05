Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3607C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4288920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OBuyNIkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+k0IVLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4288920819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeKEWbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:31:25 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56943 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728973AbeKEWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:31:25 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 138A01D56;
        Mon,  5 Nov 2018 08:11:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Nov 2018 08:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=OG80R87VZMUQczho15pRzYZs94N
        i+9X9w3Nj2QxOJXU=; b=OBuyNIkJqsbNEDYOlimOXpfmQuvG6268f3cwnIkSCwY
        23KPuOIiEjutP3ottNmcXRWaT4ftFRKyaSrjTGC7iTJgFvMtlNSCOK4PeB5m1ucq
        IsnIRYqauelvvLGZBUCVJ/jvnMNlp0ZuSv4fp37L0tkTki9avaD8exRIA0suRyJM
        it3WJqwTl0o17uAADdqMXCyBm0KechXmnGCwkxTaLegMIv9uBRChadws9di+meZC
        iB8ZWcZEcEbSkdI2TbuBF0+vq6xVpceFbGgSg8OfKoYUn6+YHKYavsUnYC58aUfA
        tpwGkiKTEasHgSVmjv0V+YZwnBf2RWh1PReUZSAfFbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OG80R8
        7VZMUQczho15pRzYZs94Ni+9X9w3Nj2QxOJXU=; b=W+k0IVLcqo/N8Dn7WpSyx/
        Zg26mcZLqqLAMKuTp4nfbB3zsk/uBH7UFtav1E74ndf9Kbnre7r/sI9Bty8gyOaV
        uLoSxcoIcEIBJvuafJrdeC9JG7RjWW5umT/GuB3NXOY07mF8L3FfH3hX7bqVbKtq
        ja4sYqsBb2g3k1k8ehEYQWRRxKcbBOZpjHbkTlG7R2z4ie4GSsbeM8Q5o2JQDNsF
        mrterII19OeN3bvEW+dsPOCdgW1/dRNJyQ9J8q5t4ZPSwpTTaC8Ixi2pYU28PHWv
        K8+gPJQk8Kb96tfbAeZHd2GqVhaqu+ynEaDYgusXrvb1uE2RKTsNxM81yOUJU2Yg
        ==
X-ME-Sender: <xms:jkHgW1L4AjMq7pCM90U41DGc1A1FE47RtiUNtP1WfLyQfBQ4UVdsYg>
X-ME-Proxy: <xmx:jkHgWzqzkLBKi4UDuray_CZ7q7eu2FZmvZA6biyVHhhKj18IjwzdSw>
    <xmx:jkHgWykkzQlfPbTJP0jSEL1ZTPpIp5ZeDqcnH0Aobf3-QvJpkpsC0g>
    <xmx:jkHgW7sY9kawj1Sl0urcRsPgbMBke3xa5_WpBMh5ArAUc8KdqQyFgA>
    <xmx:jkHgW6CPiaYvfdX-kapCP1UE2aGTukQeHvtzDYBRV6RperJXIQWSJA>
    <xmx:jkHgWwG_uG827Q7NLHogHJRhYKTLa0-YlYyV70D6YSQBj0lfSrgV2w>
    <xmx:jkHgW9w3NytSroPBPyOg_sLA8AcihUCQxejtm49OCGFyPKtS313vcA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04448E490F;
        Mon,  5 Nov 2018 08:11:41 -0500 (EST)
Date:   Mon, 5 Nov 2018 14:11:40 +0100
From:   Greg KH <greg@kroah.com>
To:     Ivan Roman <mr.ivanroman@gmail.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: io_ti: Replaced simple_strtoul with
 kstrtoul + Formatting issues
Message-ID: <20181105131140.GA19598@kroah.com>
References: <20181105085009.25512-1-mr.ivanroman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105085009.25512-1-mr.ivanroman@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:50:09AM -0800, Ivan Roman wrote:
> Replaced simple_strtoul with kstrtoul since simple_strtoul is obsolete. 
> Also fixed several formatting issues.
> 
> Signed-off-by: Ivan Roman <mr.ivanroman@gmail.com>
> ---
>  drivers/usb/serial/io_ti.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch breaks the build.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.
If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
