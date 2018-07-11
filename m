Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE270C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A45208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fBV9OUV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A45208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbeGKTFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:05:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50684 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387884AbeGKTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:05:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so3384144wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=63XmOPrd5GuKGkOcpOTEmyyDfpJ661iyEU0sTr5uDhc=;
        b=fBV9OUV1ozT3iguhqwZ0rfJcX1E6YMzbZQDC1Gf1hZTA8kng647qsrAD0+JHU0KunG
         VrJWYoUuUalmSrj1kzDAcWRm1N13m6EtBgTt4FARjXTSkFnxWKQA9QHCA7XoPFbioNaC
         fDdpyn3ad9E+kbrt5oU2T9HBOxNiHyVWXp0KcCrn8xMbcHTy6nenKwgis6cb2FjpacZl
         k7/Rb1oT6ypPJst/l1PW7KIKESDDJmV1SiDDWQGFHSf5iKt8G6jP/FZy9yidKMUEAqcK
         aFT+x4AMHNCWp+9OFAKG9r5c9Fx2i03VkbA5haJSc3am4mtb3CsVu8GmnQ1NVVaHUSDV
         CsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=63XmOPrd5GuKGkOcpOTEmyyDfpJ661iyEU0sTr5uDhc=;
        b=LhhW905AP2tV0UVM2/s13CuSP+jL/igiWWCRrb0Z6H2m1rC9DbUPcMsPMmdCvcPq+k
         j37tyB5eZOgKGkXCGsQT7uNsDEVLnmyuGe74NB+4OtdW4otzDWTkIouIPgqmr2i3mET5
         iytExyLZ/eZQLAROwPT4a503KWeUD6xsYMYbJM97DUhunbu928Fvv0VfyOx8uWHwbDVb
         m5xgbB57e1KlSrLBmqVL1DG1MHhIpawq+16lDYujg/SH6JWFhVS/dmH0qxYy0KAGaM3E
         n4GBoWE/psWHKCrEyH0mzbYMfgkPY0hoi8ENkSe4ng7YV81Tuc1pv9TDMYxmKfrbBKbE
         z1dA==
X-Gm-Message-State: APt69E0l/dwUct+pKNmWJ1EqBUE5srnt98teWqP7CJCcdWkwyNBMtd31
        zvJHcGO4kBBHur7Rd0TBN0IEqA==
X-Google-Smtp-Source: AAOMgpc6sDZcyr+A2DoCd5N4mC/8ycBtGhYLidVbrbX8UMOCFOzQC0Rm+vTUeI6SmiHcDglZN5DEuw==
X-Received: by 2002:a1c:694f:: with SMTP id e76-v6mr17461704wmc.132.1531335562237;
        Wed, 11 Jul 2018 11:59:22 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id d102-v6sm5388212wma.10.2018.07.11.11.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 11:59:21 -0700 (PDT)
Date:   Wed, 11 Jul 2018 20:59:18 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        icenowy@aosc.io
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
Message-ID: <20180711185918.GA1152@Red>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
 <20180710122922.6sgmgfislqwhn3tt@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710122922.6sgmgfislqwhn3tt@flea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:29:22PM +0200, Maxime Ripard wrote:
> On Mon, Jul 09, 2018 at 03:20:54PM +0000, Corentin Labbe wrote:
> > Hello
> > 
> > With Moeicenowy's agreement, I have take leadership ot this patchset.
> > 
> > There are no really changes appart renaming struct quirck to variant.
> > 
> > Since the last serie is really old, I will answer comment here.
> > The two regulator (1.2 and 2.5V) are not for the PHY since:
> > - nothing in the schematic said that they are for the PHY, they seems
> >   only for controller
> > - all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
> >   cannot be used for target)
> 
> That's a pretty bad thing to do, especially for old series. You just
> dropped all the context that you reply to, and there's no way for any
> reviewer to tell if your answers make any kind of sense, or addresses
> any question one might have had.
> 

I apologize, i feared to hack a mail with the messageid.
Next time I will

> > Furthermore, the AHCI binding support only one regulator per PHY, so
> > using the "target" regulator is out of question for registring this two
> > non-phy regulator.
> 
> Nothing is "out of question", we have the source code and can change
> it if needed.
> 

Ok, I will try with a generic AHCI platform solution.

Regards
