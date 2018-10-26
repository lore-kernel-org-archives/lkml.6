Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0273ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC2120868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfCw8xOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC2120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeJ0CX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:23:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39302 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeJ0CX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:23:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5-v6so2003793eds.6;
        Fri, 26 Oct 2018 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GPRy1o4EFRcbsJMOuW16r1Wo22rZY+9kuCPxz26ivrs=;
        b=HfCw8xOP/sRSXr/mYSuHE5V1ht3m7DgG/mt72YeYmfaLPyKSFgN+gc8xyC/3GrRhM9
         9S2QzgB61jDO6xg6iG6QOEl12gz+brKc+soaSSmtYGo8TS1cXtZZpjvjPi47575elPQP
         LIhGkaSLO80FjgK7mrUAtM1U/Mhl6gPRJv8rY892yFKN9Y9agB0CoISlERU9xQ7WZrR5
         Darcc2fBHUQ4FVPHkTwS2ZjxPXiquw99b5tWEfdbTwNvUlgwo7ONc1fNMfbe1YgHWVvX
         AbTYw4WE+t0fccuDv7Tf/CAKFdSDskRYuHq48mJP4YCIxkuV+VNbw7tn1KVJS6NnPx4E
         ShPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GPRy1o4EFRcbsJMOuW16r1Wo22rZY+9kuCPxz26ivrs=;
        b=ikJ7s6trllz1McH6MVBIEW2o+aYK6QSsu9G5HktHyQad4dRp47Ln76yL8WrJnCVSgN
         Ydyq5J0eN89JoCqWUa9bT8MHF4pZI1KG9itU3KImFQcvZxbCI99B8oXhnhGCGzppnpBH
         AeCoT4TwK/X24YnXX5jD0tRQ1Q2fS4b+cwbBIAMO0SOKEWcxBEW8Qzi77Qb+XvtE/xhe
         pBkwU8RSN/goaFFbnTXiSDOCB1FJRJKxgjFKfkFbqQs17UniQYeycEkg+ZWniE3+wmgL
         iLcmwHdHXfrNQ2O06ozjZt2+KnX2PjhavwnGEWH0ESQ0D7RRgTl2w69iYFX9UV5up1K5
         U9BQ==
X-Gm-Message-State: AGRZ1gKdn8nvxJLxpreU5xan3MEyJK6qS8moV2RJH7mXWpa8pcSG1Yh0
        KP1MW+jRpENPJm2ix3DLUcY=
X-Google-Smtp-Source: AJdET5c/pQsgny189+kAWULtraodxkl/MJJs8FuotP9L5eoLzrBM25uEeyqGyB2s/X00GAfvEFWJUA==
X-Received: by 2002:a17:906:1cd0:: with SMTP id i16-v6mr2979624ejh.195.1540575931908;
        Fri, 26 Oct 2018 10:45:31 -0700 (PDT)
Received: from dell.be.48ers.dk ([84.198.244.197])
        by smtp.gmail.com with ESMTPSA id 51-v6sm4492681edt.34.2018.10.26.10.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 10:45:30 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gG6Ar-00073K-Hx; Fri, 26 Oct 2018 19:45:29 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <jacmet@sunsite.dk>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <20180625161303.7991-4-federico.vaga@cern.ch>
        <CACXmViZK=4dXYN-399=U6UDJDv4NuTQ2LHEfgh8UbeUJLJp_QQ@mail.gmail.com>
        <4222986.LvGMQbjSbS@pcbe13614>
Date:   Fri, 26 Oct 2018 19:45:29 +0200
In-Reply-To: <4222986.LvGMQbjSbS@pcbe13614> (Federico Vaga's message of "Wed,
        24 Oct 2018 11:51:19 +0200")
Message-ID: <87woq438li.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:

Hi,

 >> > -       } else
 >> > +       } else {
 >> > 
 >> >                 msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
 >> > 
 >> > +       }
 >> 
 >> This looks unrelated to $SUBJECT.

 > Do you prefer a different patch just for styling?

Yes please, it is a lot nicer to keep functional changes from pure style
changes.

 >> > +static void ocores_poll_wait(struct ocores_i2c *i2c)
 >> > +{
 >> > +       int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits */
 >> > +       u8 loop_on;
 >> > +
 >> > +       usleep_range(sleep_min, sleep_min + 10);
 >> 
 >> Where does this 10 come from?

 > It's true, it's just a random number. It can be zero as well, and we ask the 
 > system to just sleep for that amount of time. 

 > (1) usleep_range(sleep_min, sleep_min);

Or just usleep(sleep_min);

 >> 
 >> > +       if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR)
 >> > +               loop_on = OCI2C_STAT_BUSY;
 >> > +       else
 >> > +               loop_on = OCI2C_STAT_TIP;
 >> > +       while (oc_getreg(i2c, OCI2C_STATUS) & loop_on)
 >> > +               ;
 >> 
 >> How would an I2C transmission timeout be handled here?

 > There is the assumption that the hardware is alive and what we read from 
 > oc_getreg() is correct. With this assumption, when there is a timeout this 
 > will happen:
 > 1. STOP command (previous patch)
 > 2. both TIP and BUSY will become zero at some point and we get out from the 
 > loop

 > I can see now that there are cases when it may loop forever: for example if 
 > the device is broken and it does answer always with 0xFFFF: we should not 
 > break the host as well :)

 > I can fix this.

Thanks!

-- 
Bye, Peter Korsgaard
