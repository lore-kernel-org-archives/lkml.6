Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB02DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D003207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548864432;
	bh=duRPLTQ6wlSFvtGOlMxAxDxRtQ5Jacj59x197ZF423Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Efuu9uf3Z4sEIGJAdJ49BJKGasFqeNlLSJCFk+K7Ba+q8gBjLzSrYp2KIbSf5GrBo
	 RjYYgw4vnSNfw2Idjt837eZdxpXB3xfwdmTHPWK0INh7AcDjwDM/+5ktVXeixyMttO
	 l1nSlDupc6YfZ2Hp/OfFdNFdhmR5WoZLv977A5a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfA3QHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:07:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35770 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfA3QHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:07:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so65182otj.2;
        Wed, 30 Jan 2019 08:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g2YVABEOYLcMlUm2t8Parde08+vXwjS1kxc3IjzVaM0=;
        b=bhyZi95r+mp/XCQTSZGbwIP2iJGv++ReOo7Yr+eDDX/cQcgW+HicDXAtJkTdZOM4Kw
         H2ByyReUihGsCmmIyfS5PDj+NQYKKzS5mHHYHWmiY/bMP4+Z2Zk1ew1m5LBduqrG5GBy
         Sm8zM0m7E2H/XLLifx+NFVoz59JP4pkSJzgqLPriIgQUwomBUXvzYLtlyfY56TfnjVbT
         iYjmXym+DQjxAzIkF/vk72Vd/Ia2QCpF01Pt8e8aEsP2quJFw+BFlNWmGjWmiO8mHMSz
         eek4UosvbSNk2oV3w4aYyAoq4MKb6lPh2fekNt3w/8Rki73x1RfFY5W2SZg8Kse3FFNv
         FmSw==
X-Gm-Message-State: AJcUukdEWvKV5uwBjwvmIuobIWI+SWHo1WFvXQY2s6JF1t6mVQGNHteU
        /vFXKlH72FmdcUONHY7LMULa0BY=
X-Google-Smtp-Source: ALg8bN61w4RcI3Wx58qjC+ljn2ByYOU452ZYGnsKTzGjhCHLAAxMV4BeuKBMSKz6ck77BF2PuDSEdg==
X-Received: by 2002:a9d:2184:: with SMTP id s4mr24453896otb.46.1548864429221;
        Wed, 30 Jan 2019 08:07:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 102sm668062otj.65.2019.01.30.08.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:07:08 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:07:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v7 2/5] dt-bindings: pstore-block: new support for blkoops
Message-ID: <20190130160707.GA31844@bogus>
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1548245116-6360-3-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548245116-6360-3-git-send-email-liaoweixiong@allwinnertech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 08:05:13PM +0800, liaoweixiong wrote:
> Create DT binding document for blkoops.
> 
> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
> ---
>  .../devicetree/bindings/pstore-block/blkoops.txt   | 32 ++++++++++++++++++++++

/bindings/pstore/...

I wouldn't call it blkoops either. I believe ramoops is called that to 
maintain compatibility keeping the same kernel module name that 
preceeded pstore.

>  MAINTAINERS                                        |  1 +
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pstore-block/blkoops.txt
> 
> diff --git a/Documentation/devicetree/bindings/pstore-block/blkoops.txt b/Documentation/devicetree/bindings/pstore-block/blkoops.txt
> new file mode 100644
> index 0000000..a25835b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pstore-block/blkoops.txt
> @@ -0,0 +1,32 @@
> +Blkoops oops logger
> +===================
> +
> +Blkoops provides a block partition for oops, excluding panics now, so they can
> +be recovered after a reboot.
> +
> +Any space of block partition will be used for a circular buffer of oops records.
> +These records have a configurable size, with a size of 0 indicating that they
> +should be disabled.
> +
> +"partition-size" and at least one of "dmesg-size" or "pmsg-size" must be set
> +non-zero, but are otherwise optional as listed below.
> +
> +Blkoops will take value from Kconfig if device tree do not set, but settings
> +from module parameters can also overwrite them.

That's all kernel details not relevant to the binidng.

> +
> +Required properties:
> +
> +- compatible: must be "blkoops".
> +
> +- partition-size: size in kbytes, must be a multiple of 4.

This seems unnecessary given a partition has a known size.

> +
> +Optional properties:
> +
> +- partition-path: strings must begin with "/dev", tell blkoops which partition
> +  it can used. If it is not set, blkoops will drop all data when reboot.

No. '/dev/...' is a Linux thing and doesn't belong in DT.

You should define a partition UUID and/or label and the kernel can find 
the right partition to use.

> +
> +- dmesg-size: maximum size in kbytes of each dump done on oops, which must be a
> +  multiple of 4.
> +
> +- pmsg-size: maximum size in kbytes for userspace messages, which must be a
> +  multiple of 4.

Common properties shared with ramoops should be in a common doc.

Rob
