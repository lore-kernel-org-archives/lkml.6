Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D559DC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E1020873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 19:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYODRvqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBJTGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 14:06:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52735 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfBJTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 14:06:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so13277256wml.2;
        Sun, 10 Feb 2019 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EKjzv7Pv4TNnz2+MQrslpZJwfNPoJRTBvfVLHgHOxOE=;
        b=iYODRvqBZuk6iTRsY65cJZof71V4wglY7fz5PhLo4pFhcXz3kErg/WHOARTCHniyS9
         irM5vDDfDDd0T1ExDZYNrcHcBkwA0IoJ3ff4FMxrXBwDgHjbNdw5hsAw7cXIH5mZ2AJe
         7IC4Q93UqEnInOmAvPbu3aAQlig6PhxUbn7EsVzw7ZbfKtjEtqINNAkSBWFee371XoW/
         Wqx/n0/5wfueftRHjMDjM0n2hXo5NC3y4xCUI9X4H0P3GGRg6ARTXVcKVgTyyORL5sM3
         Ps6ur/4XDxOpRs4N5HESGqevHbMbiaWMZ33w5ojYSd8vc+dSm8+1zgwFX2PvlvU5F7zs
         d0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EKjzv7Pv4TNnz2+MQrslpZJwfNPoJRTBvfVLHgHOxOE=;
        b=G4D9JkNEjnetoiCnGfL5VnW4UCf2fyebIWtDqzA6Xlgq3zDwhJoGBqveZKpk/wUZDz
         VC0usb8gxYE+/V1Fa3yX0kMqsf9V/bltjkAo191FHmrq4lkQEgUWocjDy+A5Bdhs/6Gv
         rlX5oBUxkABfxVtuEKYLZTzUqC7hg9pJOLjmUKT8vuqSzlazkNrRkqQSgxLFW+0+KdE5
         ++QlTJQjgA6YoMmAQmS/2/USxgyVTzJyYPimu/15WK0IBmaPi2JIp3Ouxf2O0e+kzz1N
         BtWlE+l1jRc+zIufbWskdFF4knRip+Z2vcwKVDuJ2GBH3FpoiCRQYyV8B6GEsscJUCaz
         URVQ==
X-Gm-Message-State: AHQUAuZS24SMlT8m4FZPxPYUDfmRw8UDdoT72BT5W7Wvp0fXyObWYr3Q
        zqgf8hP0x9utHSsj897j800=
X-Google-Smtp-Source: AHgI3IYwfX9oUBnuxmoYCydfrGj1gedZWXEQ/wK+wL+yNqkBYqJBcw6q5KCw8PuPG/h2fnnom95qHw==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr1011312wrn.80.1549825599435;
        Sun, 10 Feb 2019 11:06:39 -0800 (PST)
Received: from felia ([2001:16b8:2dee:9f00:2436:5653:8de5:2886])
        by smtp.gmail.com with ESMTPSA id s5sm8112484wmh.37.2019.02.10.11.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 11:06:38 -0800 (PST)
From:   "lukas.bulwahn" <lukas.bulwahn@gmail.com>
X-Google-Original-From: "lukas.bulwahn" <lukas@gmail.com>
Date:   Sun, 10 Feb 2019 20:06:20 +0100 (CET)
X-X-Sender: lukas@felia
To:     James Bottomley <jejb@linux.ibm.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
In-Reply-To: <1549823158.4142.12.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1902101954310.9405@felia>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com> <1549823158.4142.12.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Feb 2019, James Bottomley wrote:

> On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> > Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen
> > as
> > further maintainer to the KEYS-TRUSTED section entry. So, we rectify
> > this
> > with this commit.
> > 
> > The issue was detected when writing a script that parses MAINTAINERS.
> > 
> > Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for
> > trusted keys")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> This isn't really a bug, is it?
> 
> We have no formatting requirements for the MAINTAINERS file and the
> section owner is free to align with tabs, spaces or nothing as they see
> fit.  Most use a single tab, but a couple don't. The only real thing
> that cares is get_maintainers.pl and it uses \s* as the parse regexp,
> so it doesn't care either.
> 
> Now, we could possibly agree the file looks better with a single space
> or a single tab between the tag and the value and thus we should be
> doing this, but we'd need to agree on that and update the tag
> description accordingly.
> 

It was the only line in MAINTAINERS remaining that used spaces instead of 
a single tab. So, even if there is not an explicit formatting requirement, 
changing a single line to have it consistent in one format seemed 
reasonable to me.

I just sent a new patch that also corrected the email address; 
unfortunately, I was distracted and sent it out wrong twice before
getting Mimi's email right on the third try.

Please ignore this patch and consider the patch:

MAINTAINERS: rectify two issues in KEYS-TRUSTED entry

Thanks,

Lukas
