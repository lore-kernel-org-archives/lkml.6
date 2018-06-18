Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D13C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAE3208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+H1fi64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAE3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935716AbeFRKMq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:12:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50777 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936826AbeFRKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:11:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so13086231wmd.0;
        Mon, 18 Jun 2018 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jBGa5eeVwZxNu8Kg2B1yPEMkvBVO6jkIVcPuYlZnEK0=;
        b=F+H1fi64I4cSgNixHeF6uv91Fx0ghvq+XBh/wY3upVZW1Dzb0Umecy0MYpoL46tKaZ
         NcbXy+SFz1/8d3OC4ovFd983p1fElx7JHmbJlEfWa8+lztsFzLN65jiPYvG/H7bsAH5M
         ha+JAAioj7Ym3b2/OjB3aQhwY1+0+6O7u/+xvTL9ekmTiQckR1tZkTkYhXl4nzRzGn0U
         BAu5hDr+fZWz2KP3YQN4cpaFCw5aDuIqs5plBC0R9okXO2Gfj9B7SVKgIvsDpTMli62i
         DYFXndTqislN5CnLDWlYJvbE/Pe0BmDSN/fkaqsrFyKcN8d5y85CyYwPi3KVrWSIOw3M
         cQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jBGa5eeVwZxNu8Kg2B1yPEMkvBVO6jkIVcPuYlZnEK0=;
        b=RxcMDZO0K3bu8vuUDibikqw7IItzugyBG9Kg2bWB9B8nCh6lZb6wTWeiQSzqN7nv81
         Xolo9AlKBFtOEjD1t/5rJ/BpIfrvx/EdED1OXazjJ6EABtn9AXu+QX2VS1YjHbDFfs5C
         t+K+bYnE0RYCc2M+ObJv77Mj1++Sh65CFj7V70vV3g2KgloB31tMRzB4cJ9OYjD/juvL
         2KVRaxQfA/tFPe+RiRiGi1AxvEQ9YPPyZXu99el1CiOouXO+OH28z9+iml5+v0+HUa4u
         g80duO9l1JMKVprF0Aw4LGybMGuJcNLp/lko5Yjb+hW+XiaB0abMlB/AiJsYOKJw+qbV
         eUnw==
X-Gm-Message-State: APt69E1qxg3cWjU1jcn1pg2oCNKc2idpydcX3Z/8Qz5lUuHQQuS2te5H
        wq7qfEAFPlArIrCJGoZ7HSk=
X-Google-Smtp-Source: ADUXVKIMxslSpDVD2S6wfVPSKhBPmdd/gFEULnsFm9kqO6frFh6gheH5oCDBoy+dnOUWkOH4lpTQJg==
X-Received: by 2002:a1c:58d5:: with SMTP id m204-v6mr7675112wmb.118.1529316705663;
        Mon, 18 Jun 2018 03:11:45 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l142-v6sm8801906wmd.16.2018.06.18.03.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 03:11:44 -0700 (PDT)
Date:   Mon, 18 Jun 2018 12:11:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180618101144.l5azlrg5jq32fpbf@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
 <20180615113728.h7snxhe2juaqvjyx@pali>
 <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
 <20180615190915.cdntdeesc52ei35u@pali>
 <20180615233628.gy2ffgupctheyqof@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180615233628.gy2ffgupctheyqof@khazad-dum.debian.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 June 2018 20:36:28 Henrique de Moraes Holschuh wrote:
> On Fri, 15 Jun 2018, Pali Rohár wrote:
> > means set. What is SHDA doing, I have not figured out. It does not
> 
> Look at the HDA mixer state, SHDA is likely to be directly messing with
> it.

Now I found following email thread between you and Alex with patch which
configures HDA mixer via that SHDA method:

https://www.spinics.net/lists/platform-driver-x86/msg03206.html

But looks like that patch was never included into mainline kernel...

Seems it would be needed in some part (to not break older Thinkpads) for
that LED support in alsa mixer about which Takashi Iwai wrote.

-- 
Pali Rohár
pali.rohar@gmail.com
