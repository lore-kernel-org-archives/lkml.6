Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E55ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E98520647
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5LxdXoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E98520647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGPP6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:58:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36750 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeGPP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:58:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id m19-v6so7643251pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FU0/wP1FdFcZWaM6Lp9dasTfWT6u/MLrRj91pF40vOE=;
        b=V5LxdXohDcq/0b4TwQuV0LvAZ7bJJIJk46NxAeYmaRQdBvyoQfLGAMfDrgWr0QkUyT
         qiUTfdoDvOVaO1GV0z7omgF0QrpBTqmfErfG45/aq2o5TYbLaVlXTVvGFZkCxZSBxnck
         p9hLvQI0mJPF+ZafpK5MYxZ42PzABC1RsIplYd2ACtroFfSFPPz+8tPnklaOiQLvQ2F9
         SZlr79LKQlVdbBWhxmHxBSoEtM0iyH+eBa7juITsorlvtP8ZFpm7txg+4B5Cj4FIu7r9
         eDiPgId9OOy3ef5M4yHUEpNzA28A8JNjde6A3kHVUpFBqNkLSusXzEBa8H6SPoy8jQfa
         7/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FU0/wP1FdFcZWaM6Lp9dasTfWT6u/MLrRj91pF40vOE=;
        b=nfVvV9VEUgEvCoJgmfIKvlw40QsVME5/BNGl81leNIaMe9LPxwiaLloSa5+J85GgaS
         NMVJjTOtVKlAXaspDruxDqSS6hkM3khN2cpy333hNKhlyBBzr+n4EynOsduMiqQjXEuD
         Kdn83nqvFDfII7VgoAptefrrvW0YemhuKJKzx60sMXlgYAHPus8UzW38il9EiUwbyrnM
         O8deWjzGBlowUJs9Xo8Hfj8a67pKDvsl4PvUOsJhlMgz5xqiEVpueRaSoOWgL5TP8KHN
         kdA4ZZ7SnnPtDeFPufaXt2eMczntHiKqsIc/LHDYa3ftWqYrNn0M/3kYi8dYZij5yWen
         3JUw==
X-Gm-Message-State: AOUpUlH6rrnqmgfLukgT9SXZ7V35FvhtZRyg2/90ta2EdDT2nwaWLrM0
        F3ZhznsEIEugR7ULddQ9C3rgn6jZ
X-Google-Smtp-Source: AAOMgpcGBUNRwV9IbsPGei1Itj4ZPXeQmXVXfSf7JVTbiCiOPbueBTtaVpx1BkPegAiHIWlf9TSZdw==
X-Received: by 2002:a63:3686:: with SMTP id d128-v6mr15473088pga.18.1531755005563;
        Mon, 16 Jul 2018 08:30:05 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id p5-v6sm38186220pfn.57.2018.07.16.08.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:30:05 -0700 (PDT)
Date:   Mon, 16 Jul 2018 20:59:59 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: comedi_internal.h: Avoid '(' at the end
 of line
Message-ID: <20180716152957.GA16348@nishad>
References: <20180715064914.GA5081@nishad>
 <20180715072712.GA15766@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715072712.GA15766@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 09:27:12AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 15, 2018 at 12:19:18PM +0530, Nishad Kamdar wrote:
> > Bring function argument 'struct comedi_subdevice *s' to the
> > previous line to avoid ending the line with open parenthesis.
> > Issue found by checkpatch.
> 
> But now the code has another checkpatch violation, too long of a line.
> You can go back and forth submitting the same change over and over for
> forever :)
> 
> Let's just leave this as-is, thanks.
> 
> greg k-h

Ok noted. Thanks for reviewing.

regards,
nishad kamdar
