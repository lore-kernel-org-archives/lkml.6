Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE7CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E557C2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitmath.org header.i=@bitmath.org header.b="toSnihup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfBDVCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:02:45 -0500
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com ([46.30.210.184]:55210
        "EHLO mailrelay3-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728004AbfBDVCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:02:44 -0500
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2019 16:02:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20140924;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:references:cc:to:subject:from:from;
        bh=WKL4qPrsbcWUdiKmxiFatz7iy/568YL9wtbPxM3bCQw=;
        b=toSnihupqMkRlVkDJ29T/VfFOrWn7uL32Q42x9RpGRmUTh3Od98YxLYz3KZSaSYha3pXoAh/qhOYc
         3JwFoUZgHAUJAAsr/Gs3QmtoJeB9nprLJEkwweGvpoVjIzkUuwPkKfpCSxQTtPXriZF6PEFKzGpWia
         NmbmxTpolgmxoXBg=
X-HalOne-Cookie: aa5a7aadd2139a7b04d130f724e3d2cada954a74
X-HalOne-ID: f828f0d0-28bd-11e9-906a-d0431ea8bb03
Received: from [192.168.19.13] (unknown [79.136.64.225])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id f828f0d0-28bd-11e9-906a-d0431ea8bb03;
        Mon, 04 Feb 2019 20:46:39 +0000 (UTC)
From:   Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 0/2] Add Apple SPI keyboard and trackpad driver
To:     =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190204081947.25152-1-ronald@innovation.ch>
Message-ID: <cdca5121-4f2b-2f74-8a1c-63fda385ee6f@bitmath.org>
Date:   Mon, 4 Feb 2019 21:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190204081947.25152-1-ronald@innovation.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronald,

> This changeset adds a driver for the SPI keyboard and trackpad on recent
> MacBook's and MacBook Pro's. The driver has seen a fair amount of use
> over the last 2 years (basically anybody running linux on these
> machines), with only relatively small changes in the last year or so.
> For those interested, the driver development has been hosted at
> https://github.com/cb22/macbook12-spi-driver/  (as well as my clone at
> https://github.com/roadrunner2/macbook12-spi-driver/).
>
> The first patch is just a placeholder for now and is provided in case
> somebody wants to compile the driver while it's being reviewed here; the
> real patch has been submitted to dri-devel and is being discussed there,
> with the intent/hope that I can get an Ack and permission to merge it
> through the input subsystem tree here as part of this patch series.

Great to see this upstream. The patch obviously has a lot in common with 
the previous keyboard and touchpad drivers; foremost this is a change of 
transport protocol and not functionality. That said, the code is compact 
and clear enough to make it hard to motivate any major effort to share 
more of existing code, at least initially. Barring detailed comments 
that are likely to produce new revisions, this looks like really good work.

Thanks,

Henrik


