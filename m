Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96729FA373C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE520873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qd1mtWDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBE520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeG2LP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 07:15:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52889 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeG2LP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 07:15:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so9818191wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZOtItiTCStsWeN6jnA9gjaLoKTyuas34VUfXWJskHkk=;
        b=qd1mtWDD3C3z1vRgbnTb6gxuW3ftc+axTQtSsRCHpb7NZaspl/EFM941og1B2Bq9hZ
         cUP0SJrLnD2qqYWU5zr3QYbV7R81xJz4a718Lxz7IJcnhU0EyAhM/tXbDw2yxHi7UcPF
         oLj9t0CbMHMaYwqTQqtZvEV2AJWbTCOyIBxW9Lfllfq6/wlyC1r+4TJfEXu3wRyOeMec
         HUJJ5zXyYI9ZnniY0rX4s1Xp79qiepzqYAXSEMcTYYmVBxYuwBYQZ1jceSSmmKkEmyPe
         GIzpg6wNqNRiCcDrmB6nSHBVVIK/2tcIdoYt/CPIiExstqW6cAIpnbRQ42SvPUxMjDA1
         c/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOtItiTCStsWeN6jnA9gjaLoKTyuas34VUfXWJskHkk=;
        b=ixoKbsUDOROjTYx+5iO5ORvGias1C4KUraHTuWAR1/wB9y46aDUClW9qckPRiIjHc9
         PhKBxBHN2GFXpZcXPm6wGjZDXA9GyDNBK5aC4Mg9LYQvtTenlxjhl6/DSHs+7mcr6Wmk
         8M71eiiPg3NllnqV44SCxbzQ0JNNL4Qk9NG8KnpA2hgSBi9HTp3Tm3YEk1w7FNaeIW/R
         eyyh1ly6a6l7l3A8ahDxS7+6zgsGKwSktynM1dgc5yQE0eaVBVUEJ4eEZVMI3re6ASpp
         3aoQEGfLantLbomRQpgxDmhpyI0jERzmH9HZOzZjU2NyhBxxpCIddOiCulGesIMN3pbU
         7DNg==
X-Gm-Message-State: AOUpUlHWnnwxHeqverLHDAITkAyb81sQUnY7taioHA7JJnO/k1huR7Y5
        12czZnyBxsLr613rt/n/PFriMm550ZY=
X-Google-Smtp-Source: AAOMgpcBn8yg/eNxeMGGnP+/VsysJ+USP71PpnK0aAHBsa/QNOVnBW77X5d0w02WtOFk0bGtRv3kFg==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr11033159wmo.40.1532857564523;
        Sun, 29 Jul 2018 02:46:04 -0700 (PDT)
Received: from xux707-tw (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id y14-v6sm16878893wrq.45.2018.07.29.02.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 02:46:03 -0700 (PDT)
Date:   Sun, 29 Jul 2018 10:46:04 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 01/10] staging:rtl8192u: Remove typedef of struct
 cmpk_txfb_t - Style
Message-ID: <20180729094603.GA21046@xux707-tw>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
 <20180725221630.28595-2-johnfwhitmore@gmail.com>
 <20180729081055.GA21268@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729081055.GA21268@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:10:55AM +0200, Greg KH wrote:
> On Wed, Jul 25, 2018 at 11:16:21PM +0100, John Whitmore wrote:
> > -typedef struct tag_cmd_pkt_tx_feedback {
> > +struct cmpk_txfb_t {
> >  	/* DWORD 0 */
> >  	u8	element_id;			/* Command packet type. */
> >  	u8	length;				/* Command packet length. */
> > @@ -53,7 +53,7 @@ typedef struct tag_cmd_pkt_tx_feedback {
> >  	/* DWORD 5 */
> >  	u16	reserve3;
> >  	u16	duration;
> > -} cmpk_txfb_t;
> > +};
> 
> People use the "_t" to try to denote a "typedef".  When converting to
> just a structure, there is no need to keep the _t anymore at all, so
> this should just be "struct cmpk_txfb".
> 
> Or just drop the typedef and use the name for the struct they had here
> already, "struct tag_cmd_pkt_tx_feedback", that also would work.
> 
> Same for all of the other patches in this series.
> 
> thanks,
> 
> greg k-h

Oops again. Sorry, that should have occured to me. I'll fix up the affected
and resend.

thank you

jwhitmore
