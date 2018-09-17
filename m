Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A639ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E94E214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz6myxXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E94E214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeIQTcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:32:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37541 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:32:52 -0400
Received: by mail-yw1-f65.google.com with SMTP id x83-v6so5465216ywd.4;
        Mon, 17 Sep 2018 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jK9qcSMg9uFDisVB7E3l8UGhe+f+ljW9bHMmZnpIMms=;
        b=Cz6myxXtfnCfFNXvFrTt8URJhCbVkr1lovIXumhdODnbmDjlBrLyjBxIQp11wD0rkd
         RFIy1DQm+apdXEdB0+x76kN6FSoHuir9kAELxgdasGzgpyPBYCDhJFupqlzKmAS9XKCd
         07c0utw5R0/RM2i0Fp+x2WNLUDg9kiAe2U2chMtn1W0Vhvrn0ZR0Y3PVrtqPoXcVlGLq
         sFUXPVCLbcFtxAJsszbmOd6CW0SqZ8R8PglVDIoN4t0Y8nBs9G8C6fOkAMlbyoKsk069
         eZ5WdlWUS+D5kojUFWqL5IsseZv3yYzLdYe/eIl9MMx9b8AUWXgRQ0QQYoL7q9maRhyx
         jB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jK9qcSMg9uFDisVB7E3l8UGhe+f+ljW9bHMmZnpIMms=;
        b=RT2K3waikXXFfwFQV6M/Xjw6/evBxfrhNWNwh6gs4bW6/3t3ES6cY0KfCTJkkYjO4P
         l4nTQ4YF8so2FudH6yNMmIV5PcEC8FXE8SjuG7SnKAowrBrverAdvXizFyjRmh4UgVkO
         DTH0cOnSwut+z5vExLzjxQRmEdoog5V7o5Cpu9aYRuh64hqvThuvLG5RbbxL+QjcM7sS
         0tM6kQXY7X96J87txFk2a4WnH47RWpOBuajgYbdzD+PiT+EQOYqbkb1eU4Pn871fMPID
         YmU6zXsTSKt0y9cDgPlbafohkUhn4cYmRL1xHv2MVk8xTIa0CtLpy6anJQHxrT2HYv0j
         eS5A==
X-Gm-Message-State: APzg51A7GjKIjDVY6ruw77Ir0LrAZ8kbiU214s2D1tsALTCqHeg5Qore
        /l5/Tg+H3h25tnEsFZKAFsk=
X-Google-Smtp-Source: ANB0Vda+b72+HZRb2hf/G0v3d3Ql7hxg6AbdZMgM0w1N0PAgBVrZ5cW7AT8IGM560QxZY4J8UZpeJw==
X-Received: by 2002:a81:128c:: with SMTP id 134-v6mr10675640yws.22.1537193122884;
        Mon, 17 Sep 2018 07:05:22 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:25be])
        by smtp.gmail.com with ESMTPSA id r3-v6sm20784374ywr.80.2018.09.17.07.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 07:05:22 -0700 (PDT)
Date:   Mon, 17 Sep 2018 10:05:20 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: changes in the maintainership of the percpu tree
Message-ID: <20180917140519.GA91246@dennisz-mbp.dhcp.thefacebook.com>
References: <20180917210339.21ebb029@canb.auug.org.au>
 <CAOS58YNVTVLzBhQSQBkQkh_Zr101L9_cjhPSK3iTQSScjjYFrg@mail.gmail.com>
 <20180918000003.1ecd47b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918000003.1ecd47b1@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Sep 18, 2018 at 12:00:03AM +1000, Stephen Rothwell wrote:
> Hi Dennis,
> 
> On Mon, 17 Sep 2018 07:53:29 -0400 Tejun Heo <tj@kernel.org> wrote:
> >
> > Ah, yeah, please switch the tree to Dennis's for-next branch instead of
> > mine.
> > 
> > Thanks.
> > 
> > On Mon, Sep 17, 2018 at 7:03 AM Stephen Rothwell <sfr@canb.auug.org.au>
> > wrote:
> > 
> > > I noticed commit
> > >
> > >   1194c4154662 ("MAINTAINERS: Make Dennis the percpu tree maintainer")
> > >
> > > Just wondering if this means any changes to the tree/branch I should
> > > fetch or the contacts I should use for the percpu tree in linux-next.
> 
> I have switched the percpu tree to be the for-next branch of
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
> 
> and added you to the contacts for problems with that tree.
> 
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window. 
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.
> 

Thanks for switching it over and for the rundown!
Dennis
