Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9852186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220315;
	bh=NX/3oHhC6ICxOgvUqHVp0SaxxY5ngs6JhDxPUu01x28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqRicuOPVA1hwrjh6qpk4Hlbwwu5wtxiCmTfejKBkGr4ewWg3GKFdLs16Chj1aGP0
	 /XgIIW/HL5gw0r6hHXlI3Ic48A8eIYssCiQF/8i4oZpLSdRekzwUbVXQOVUr0jefqe
	 pCZ7l8L9FNzqP0/Det0a+OF7IzakLan+hFNMoS0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfBZWby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:31:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35897 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:31:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id v62so12606492otb.3;
        Tue, 26 Feb 2019 14:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iEP/InpNo00EOgcc80/CafziPswSl/INaXRFv7XNATQ=;
        b=N3TeKv1qpz4sP17tjoINSt3HLofvfSHIpjo+aUq/MrNCVEifInHpdi9897sCGqE7ei
         0vVE3y2LXlrTBGd0kMGxM2SMk83ICoHpNn5mxgi+WUPMbq9rXvhhTo2vOprp2gfAHR7B
         uGg6j5hNO/3jkynXvBcSXzNPO4sbkdzJRtkyQbvJ+aN/YcbgDkCmFk9iwAxJw0TAX4Zm
         t4r4Bdju4USpLre4sJID1CP53P67tZpbdjLuykZpcJjZYQGtge0KlB8Lp51BfK/QFJ9K
         VvQRBwb9Gs8St7kppFuk9xskgW/iujjPC3eSxIOeowSPGsl/T8sXqwtNmPgT/+7lJmBY
         qKBg==
X-Gm-Message-State: AHQUAuZrJRgMVklLeA5OxmZgJun4bbIaHqZlAF2Nk4AdMFH08EBEaClX
        Np12pIsFxKNxPEStz/ddhg==
X-Google-Smtp-Source: APXvYqxmRC+j9L2QF2EZzb6Mr3R1eUgiMxqV45458Yy3g2IpNV0F+8PUVMMucV8zUAw++O6HFACcDQ==
X-Received: by 2002:a9d:3f24:: with SMTP id m33mr166188otc.147.1551220312746;
        Tue, 26 Feb 2019 14:31:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o37sm6700964ota.37.2019.02.26.14.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 14:31:51 -0800 (PST)
Date:   Tue, 26 Feb 2019 16:31:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: handle PCI/USB VID,PID in DT compatible
Message-ID: <20190226223151.GA21838@bogus>
References: <20190223022440.146915-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223022440.146915-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 06:24:40PM -0800, Brian Norris wrote:
> Documentation/devicetree/bindings/usb/usb-device.txt describes the
> 'usbVID,...' compatible format, where VID is lower-case hexadecimal,
> with leading zeroes suppressed. Allow it here without complaining about
> lack of documentation (we don't need a new entry for every ID).
> 
> PCI has a similar format
> Documentation/devicetree/bindings/pci/pci.txt
> http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> 
> For both, I try to detect something that's close to a VID,PID, but I
> intentionally don't parse beyond 4 characters of PID, since USB supports
> extending with an interface index, and PCI supports additional subystem
> IDs.

Now that we have DT schema, that would be a better place to check the 
formatting. So I'm fine with this, but going back to the simpler version 
would be fine too.

We will also be able to really check that compatibles are documented 
rather than just grepping the bindings for a compatible string.

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Overall, this got a little more unwieldy, but it works.
> 
> v2:
>  * Include PCI in addition to USB
>  * Add special warning for leading zeroes and for upper-case
>  * Move the VID,PID check up higher, so we don't complain about
>    documentation at all if using the correct format
> ---
>  scripts/checkpatch.pl | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
