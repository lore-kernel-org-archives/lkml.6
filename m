Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2BCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E15E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fXVdNhgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E15E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeGQLsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:48:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52554 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbeGQLsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:48:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so1085437wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOvPp6b0C7XSwc1BkF56Pa2irrv+IIQ/aLn5fozBffk=;
        b=fXVdNhgIVuUMf7DtDJeD9k/sg+/e67rpAHpr8fJ2FtkNOOx8JZZjCY+PTpI4ilCECE
         nfJi3Q4rWJ0y0e44zvpxUMWMoYy+tIyj1enGpqy1una1BFz5suHbqkDDG9ddkyeEF9rF
         0YztehNBFRcOi7iiPngSmVIqaEzxKVFgzFUWh9XG0pWShE0wCmo2WZiVog/UAVQyK7te
         ACF/XovRNy48xXACitiOHnUuIDBDqhFYxBpw9Ckhb2BMf7CrCTYXGBpUZC2KCAqENQnK
         ginJvqFAE66lAAAn1Rg5Xx7ihwRwKrLDSNVSV4ZI4Z4a0Fcn3t0xnX4U3Ds+pBj+e5kl
         EN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOvPp6b0C7XSwc1BkF56Pa2irrv+IIQ/aLn5fozBffk=;
        b=RyUyGWbpD8tH43ffkQDehzmShcNq0swNEyIvCUFjPToMx7ZxbPiKa8+lsA+szynuVN
         hAKkRtEUtceWWw+NWYs/+WJufRvBEDkHQMk4c+d+fbPn2hTFIolSWoSmDJif7jEE6VIO
         Kny3hUfqH5Zf/A5y594f86j1t59bOy2TEn0elum0Hmr8FbELb9x8VUhu7u9eGugS0v8H
         N3OZvUMVJv1lZF6POojR3nJTdZNaY01+G/SJ3OJVXC/z8qWOIj+bZMKh2H4yaWoAePKS
         y1FdUUFuoGxfn81kS6BgKvZKlq4Pd50YdaTeSqg5++u5XLKpM2slCAx/1gaD+inBE6yA
         BI2w==
X-Gm-Message-State: AOUpUlHrS3ooLTro+dglTFhoIgjr+iDj5MUaFczBDJ8ogEgTL1klWZRn
        598Ru1XH/+usEXowgu3We+VpHg==
X-Google-Smtp-Source: AAOMgpfYPNMj8OFQl8CxfIBXMwuURnY4AiGFCsjenR9cZIiJ8FjBZrjI/Q6X2tFwuwyTw/6IhUiVrw==
X-Received: by 2002:a1c:3693:: with SMTP id y19-v6mr1015920wmh.71.1531826193863;
        Tue, 17 Jul 2018 04:16:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id a11-v6sm1194851wrr.81.2018.07.17.04.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 04:16:33 -0700 (PDT)
Date:   Tue, 17 Jul 2018 13:16:30 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, tj@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io
Subject: Re: [PATCH v3 4/9] dt-bindings: ata: ahci-platform: document AHCI
 reset
Message-ID: <20180717111630.GA7900@Red>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
 <20180716155416.GA32497@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716155416.GA32497@rob-hp-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:54:16AM -0600, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 11:03:01AM +0000, Corentin Labbe wrote:
> > This patch document the new optional resets for ahci node.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > index 5f362af2724c..a5281d7557e3 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > @@ -34,6 +34,8 @@ Optional properties:
> >  - phys              : reference to the SATA PHY node
> >  - phy-names         : must be "sata-phy"
> >  - ahci-supply       : regulator for AHCI controller
> > +- resets            : phandle to the reset line of AHCI controller
> > +                      If set, must have a reset-names set as "ahci"
> 
> A name is pointless if there is only one. Also, the name should be what 
> the signal in the block is called which I doubt would be called "ahci". 
> A likely name is some form of reset, resetn, etc. which again is 
> pointless to name if there is only 1.
> 
> If you do have 'reset-names' then that needs to be listed too like 
> phy-names.
> 

Since the ahci-platform code is common to lots of different drivers, I must have a name otherwise I could grab a reset which wasnt for me.
See the revert of f0f56716fc3e ("ata: ahci-platform: add reset control support") for example.

So the code need to grab a name, and since this name could be used by other people I took the generic "ahci".

In my case (R40), the reset is called sata, so I will change reset-names to "sata" in my next serie.

Regards
