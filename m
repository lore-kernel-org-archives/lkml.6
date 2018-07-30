Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5452C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8301520894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqy0Shbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8301520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbeG3UT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:19:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36769 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeG3UT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:19:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id k15-v6so4562817edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=No4E28qgG4yAGVQUeq4irHospSvjGZOL7yansrVe+vA=;
        b=Vqy0ShbiXIas0M3serhCEEWh7w7XvKGo5+oJdB6NqnWpnos0VKnUCuFz1Cf3mBlxpO
         kIU/Xy2ZE9DIR6GcPL4XiZGxP84py9hF0kBlna/b6jgBJAhf8lNCCLQVt84kIbd+kMJd
         U/XVNte9yest/KmPOXsd9mqCb5UAaMFbh8mbJe5mvsTTRkhS4BWLf/UHEyvOlB43ID42
         cMqr8hmJzmClvHEAE2TCxCpl035c/THOa4SiPdv3tPtoUXa+sSnPVA9mfG5pZ140BdNi
         EwDFKDr/8YjmmSo0V/3i8T921w2ZikbGW2JgniqeErL4twXJIAxJOiohrI2VY9wAWN5n
         4l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=No4E28qgG4yAGVQUeq4irHospSvjGZOL7yansrVe+vA=;
        b=Aymz7EL70XBugf0Bu0tn8+nYjB3l8WvhFiTp6iavyyaRg3BiIg2Ird0GhEroe4BL8M
         980dNtFufAWQIHcAAj6+UWIBeP8gIObgdoYCxx28Z9JzZ5Xr+slAeENuvVYMG3/XTkVA
         dbpmHrMKzFF2BwGAGr2cxuVbpzhdlnAdXfPit/01fpWbUBm2SRlyN86Bf4yndO3Q3sKG
         h9zPU4A5HuKp/44EdlQfjA+yNDpmblqfyiIXNW7CFzKVKv67q25ffhAp9gocxYinVDZZ
         f/rxHuLLAiKlwkKUCw8Gq/P0afeKfFlWt0DxGB9mQmyITWXNGFZ01U7+DKyxh71MSmz0
         PqAg==
X-Gm-Message-State: AOUpUlEWMCXmM9+xF3SqPNJzBF4av2CbKl0iP1gA3Y7+xW7UBvD+fN2Z
        7ngYxhirHdIGBhn8VjlRos8=
X-Google-Smtp-Source: AAOMgpeo/2qJ0dgoaZeli8S1z87c4mb89YMgBNF1S8LViIlcDbnUN3Ss+Ddp9T6Ej5+5bIe9ya49TA==
X-Received: by 2002:a50:9286:: with SMTP id k6-v6mr9353149eda.66.1532976218756;
        Mon, 30 Jul 2018 11:43:38 -0700 (PDT)
Received: from xux707-tw ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id p20-v6sm2187855edr.12.2018.07.30.11.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:43:37 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:43:38 +0100
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 01/15] staging:rtl8192u: Remove typedef of struct
 cmpk_txfb_t - Style
Message-ID: <20180730184337.GA19888@xux707-tw>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
 <20180729210747.10803-2-johnfwhitmore@gmail.com>
 <20180730091138.GA22781@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730091138.GA22781@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:11:38AM +0200, Greg KH wrote:
> On Sun, Jul 29, 2018 at 10:07:33PM +0100, John Whitmore wrote:
> > Remove the typedef of the structure cmpk_txfb_t. This clears the
> > checkpatch issue with defining new types.
> > 
> > Additionally the type is renamed from cmpk_txfb_t to cmd_pkt_tx_feedback
> > removing the '_t' as the typedef has been removed.
> > 
> > These changes are purely coding style in nature and should have no
> > impact on runtime code execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r819xU_cmdpkt.c | 8 ++++----
> >  drivers/staging/rtl8192u/r819xU_cmdpkt.h | 6 +++---
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > index 3140b3413f91..630cf612f265 100644
> > --- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > +++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
> > @@ -66,7 +66,7 @@ rt_status SendTxCommandPacket(struct net_device *dev, void *pData, u32 DataLen)
> >   * Overview:
> >   *
> >   * Input:       PADAPTER	pAdapter
> > - *              CMPK_TXFB_T	*psTx_FB
> > + *              STRUCT CMD_PKT_TX_FEEDBACK	*psTx_FB
> 
> nit, this should all be in lowercase now right?
> 
> Anyway, these function comments need to all go anyway, they are horrid :)
> 
> Something for future patches, look at the ones for the gasket driver
> sent yesterday as an example of what to do.
> 
> thanks,
> 
> greg k-h

Thanks for the pointer to gasket driver. I didn't like to start into horrid
comments, thinking that maybe they do convey some information to somebody, or
they're in that format for a reson. The code is easier. Anyhow thanks for
that pointer, and I will change comments in future. Sure all that can
happen is you'll reject some/all, but sure I might learn the style required.

jwhitmore
