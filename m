Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EBAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75732214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBmVoWFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfAJRAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:00:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36316 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfAJRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:00:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so5578326pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-description:content-disposition:in-reply-to:user-agent;
        bh=6j/A8TcKOtE71kxvXPpjO0ugJYp9u52edbev/Tl2cEk=;
        b=lBmVoWFvJEJuiXcbGHhvMeJc0lu4Y+N6x7+syTLMn9QjypnGuFpQw8/RN0Cdl2OLlR
         XjHqvgJnWzjVKpByREcY2InJ1c7yaOgDlGETZz3RQ5oyosCG4IIBpzl3ikAvIph3YqCi
         TC5OjWkmLKcvm6NfdLfkVPofNStMplG6SUSZ9Cue/4Do8mnWBit1Z+MkOogny/0AS0l0
         dDLmxwoZSnkJvtv7snuhZbznTaZs5qsC12h0PjQqSMygzoVvZhAHf13Q2H1l49C9QYnM
         upAqM6jLKPfM6quxInbp+ak1phfFYWcOcBW3o3D6bdxZWNCGqOI/UPeFDkHEbHPizH+B
         IZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-description:content-disposition:in-reply-to
         :user-agent;
        bh=6j/A8TcKOtE71kxvXPpjO0ugJYp9u52edbev/Tl2cEk=;
        b=DQrARYQeP6Y9Sn6M2Z25L1lG3RfFOq05fXHet2rSbwC5cLnkQzIz1l85k1naC4z1ot
         mVzQ+TA0ESPq7fzLVbaEHCErG8i3QkbuM4CbvXEQuw5fTn3EA2I+ac7F0mUan0C3uwHD
         /vz2jf4X5JP2gtjThjFcr5WNWaqqglEsJoRGb/1uxoSaQDIg0c1juGuSBCyqNSJNLW1O
         1R4Noo1nkOd4ZaKoAWgbG6odDltf9z08PVSQOo2z2VI8JMwvMSOq2liIu+rgtvx6Hh6s
         O0fZHQ5ExSCQHc/eDxz8uu38vUUBbNzqG5hl6Q0AMfUXe5CTUyS1D/qkKEbSjwivZiDy
         UOJg==
X-Gm-Message-State: AJcUukfqp3TeudI60lBecKJ68ov1RM5Y2kWU3D+BL9bb+d9fJvMcAqst
        voo12YuO4EvrGljb68nsLRGks1fiSyY=
X-Google-Smtp-Source: ALg8bN4kKMMK20pD9rvsbdW7Ni+9GRDWL/yWqzSQKz16W1jNPbPRchHHojGzpYFRuxhWOEuDk0paLA==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr10681504pfm.63.1547139630014;
        Thu, 10 Jan 2019 09:00:30 -0800 (PST)
Received: from raspberrypi ([218.147.106.184])
        by smtp.gmail.com with ESMTPSA id i5sm18998991pfg.34.2019.01.10.09.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:00:29 -0800 (PST)
Date:   Thu, 10 Jan 2019 17:00:24 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vboxvideo: vbox_main: Remove unnecessary local
 variable
Message-ID: <20190110170023.4vcyws3ktsf2sz3g@raspberrypi>
References: <20190110061347.31326-1-realwakka@gmail.com>
 <20190110122358.GC1743@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: evel@driverdev.osuosl.org,
Content-Disposition: inline
In-Reply-To: <20190110122358.GC1743@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:23:58PM +0300, Dan Carpenter wrote:
> On Thu, Jan 10, 2019 at 06:13:47AM +0000, Sidong Yang wrote:
> > Removed unnecessary local variable in have_hgsmi_mode_hints.
> > The result of hgsmi_query_conf should be directly compared without
> > assigning to local variable.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> 
> I sort of prefer the original...
> 
> The hgsmi_query_conf() function returns negative error codes if it
> can't complete the query because of allocation failures.  To me that's
> more obvious, when we write it in the original way.
> 
> In the new code it looks like it returns bool or something.  The
> copy_to/from_user() are normally written like if (copy_to_user()) {
> but those don't return negative error codes so it's a different
> situation.
> 

Hi, Dan.

I think you just point out that my code isn't obvious because the
function returns negative error codes. I agree with you. But what if
change my code like if(hgsmi_query_conf() != 0). 

> This isn't something in checkpatch or CodingStyle so there isn't a
> standard.  It's just personal opinion vs personal opinion.  If you were
> going to do a lot of vboxvideo development, then it would be your
> opinion which matters the most because you are doing the work.  But
> this is your first vboxvideo patch...
> 
> Let's just leave it as-is.

I agree with this comment. I'm just a newbie for this module and It
isn't about checkpatch or CodingStyle. but I just wondered if my code
has problem.

regards,
Sidong Yang

> 
> regards,
> dan carpenter
> 
> 
