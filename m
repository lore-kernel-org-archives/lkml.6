Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE30C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A54220693
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX6PWP54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A54220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeH3ByB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:54:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeH3ByB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:54:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so6161691wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xYIM+YvZZdmsKmiHZVN9ZObSPBR77XkKG+qYPWVUvp4=;
        b=aX6PWP54VNsdUZcVjzIVv1A1pKJ0FmesSA3LPuQdiK2n7h6Jfh8jLzQ2DJCTcQMgNj
         90dVVs9toMlxPE1GVDMnIl8VORNqndLPiMU7Ur1GlzZAZj1FozoJr73OwN/4/uVhyH7e
         i9BfHD4G16tzX1N8mbYKI18HU6Q99yrUinnWPEKI/hGEwzqc3nntdJrSytQ7+Ja2QJwV
         SDh9MEjiyPBjepug5dVXfA1eUVXlmGIYEzwHkkonoZXjrp/Dad9aOQdQu39VD+cyfMRZ
         qRbvh1IWetbPeZe0rjFSJRsf/MkbZQ2FZcR16P4OSnoG9jdFBcFxAz0T7vkvMlkVFxVI
         0APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xYIM+YvZZdmsKmiHZVN9ZObSPBR77XkKG+qYPWVUvp4=;
        b=rPt2JSskpTY6iVTxTogUFHsS0Ou8r4JOG92kc78bxntf0CQjjf4brt9wJMmQmeTnjY
         2uMdkTWrCMAhgjoF2CGmMinW5cYoz3ouiNs4z+f95YIDCSdkgUFXueYSlKu56//sAgf3
         jPo6nDZVoDKwcxaa3HO7ce5LVAXlWiTS/oRG4BeAvROWzMJKH5Hhz1Kvy+P+/Zj21z7g
         eFRZFyiVMEWRzZhGTiZuHPLaulduTzZQTQo77lI+sBLVa2ZjtCY7RBp178d2kpTssoTb
         OThWnqXhKH0mQ/VkoOTfgoiCndX/B2AcolgYe6UMday//hHQELQsOQ98/yS9H4JTel/V
         2MaA==
X-Gm-Message-State: APzg51BcveJK7n2bn3VU9axrWeN4lE6o6Bf5L3xwbbgz7ZnjkGffj/E2
        XvcZztz7XXCMVVpQiTZKMdw=
X-Google-Smtp-Source: ANB0Vda+ytknDgowV2w2CHpxIqj07C92dzgiffP7oTVjC08zuX9HW3JHKXAokXSbKnRnMAU2ZEtHvg==
X-Received: by 2002:adf:de85:: with SMTP id w5-v6mr5872035wrl.270.1535579706433;
        Wed, 29 Aug 2018 14:55:06 -0700 (PDT)
Received: from xux707-tw (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 144-v6sm8510094wma.19.2018.08.29.14.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 14:55:05 -0700 (PDT)
Date:   Wed, 29 Aug 2018 22:55:09 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Joe Perches <joe@perches.com>,
        John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Message-ID: <20180829215508.GA16451@xux707-tw>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
 <b621a12258c3f0d0a9fcb61ac454af4822814e67.camel@perches.com>
 <e302edd8-4b00-8c28-8375-2a781877f019@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e302edd8-4b00-8c28-8375-2a781877f019@lwfinger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:21:54PM -0500, Larry Finger wrote:
> On 08/29/2018 04:14 PM, Joe Perches wrote:
> > On Wed, 2018-08-29 at 21:35 +0100, John Whitmore wrote:
> > > Rename the bit field element AdvCoding, as it causes a checkpatch issue
> > > with CamelCase naming. As the element is not actually used in code it
> > > has been renamed to 'not_used_adv_coding'.
> > > 
> > > The single line of code which initialises the bit has been removed,
> > > as the  field is unused.
> > > 
> > > This is a purely coding style change which should have no impact
> > > on runtime code execution.
> > 
> > Hi John.
> > 
> > Other than the somewhat useful code style cleanups, is there
> > a point at which you will feel comfortable doing actual code
> > changes to this driver?
> > 
> > Perhaps support for the chipset could be converted to use
> > mac80211 and moved into the directory with the other realtek
> > drivers in drivers/net/wireless/realtek/rtl8xxxu/...
> > 
> > Larry?  What do you think?
> 
> First of all, if a variable is not used, then it should be removed, not
> merely renamed to satisfy checkpatch.
> 
> All the Realtek USB devices should be added to rtl8xxxu, not merely moved
> into that directory. Jes Sorensen created a well-designed driver the is
> structured to permit addition of different initialization routines, etc.
> That said, the conversion will not be easy. In addition, it will require
> having your hands on a real device - a requirement that I cannot meet for
> the RTL8192U.
> 
> Larry
> 

Oops... it probably doesn't look like it, at the moment, but 'actual code
changes to this driver' was where I'm hoping to get to. There's a lot of
stuff in the header files, including member variables, which are not used
in the code. I was hoping to strip these out incrementally to minimise
the amount of source code that has to be understood. I'm not familiar
with the overall network, or 80211, subsystem architecture, but it's hard
to see why this driver has it's own private ieee80211.h file.

I totally agree that the unused variables should be removed, and they
will be, if we can accept that they are in fact unused && size doesn't
matter. The structure in question 'struct ht_capability_ele' is used
in, what I consider to be, a strange way in the file ieee80211_wx.c.

    struct ht_capability_ele *ht_cap = NULL;
    ...
    ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[4];
    ...
    ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[0];

I have been trying to find a datasheet for this device but to date me
query strings haven't given me much joy. I must try and get my hands on the
device in question. 

Thank ye for your comments, and sorry for the "somewhat useful" changes
to date, but doing these changes is letting me get the hang of this code,
which I refuse to comment on because there are probably guidelines on using
naughty language on here. ;) When I see lines like these two:

    ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[4];
    ...
    ht_cap = (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[0];

I think that size might very well matter for the moment. The BSS_HT
structure is farther down the header file so when I clean up that struct
things might be clearer. I can only hope.

jwhitmore
