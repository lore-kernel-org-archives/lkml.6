Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AFCC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCDA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9rmTHzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCDA20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeFTERg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:17:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:47102 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFTERb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:17:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so912029pff.13;
        Tue, 19 Jun 2018 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k9vzrTR3cxXzv/I12VHQRSBnPNzsABk7Hz1MBOTxpUc=;
        b=h9rmTHzlOLAh7fIZyDDynR8wo1MrWTiCKQVx+/dS0AmntXV84+fI0SA+YH7zHlJ55Y
         nlK4+y6N58Vta6hxcGblU5NzVQs5qAhza8c7WUQfwTMt/4OP3z6MXZfdhPhR7FxLsIO2
         oa3xWUfRU3ahjR9gBrzS4fDW4VrC1cKD1mH+IC0us9LdKJruIen7FkYdZaM4tcpr5sta
         LmYFclFmOUgchFNw4flwk4YP4Xu+Y3I4jNV2KciiOOFqcc1LmInkTvE9r3Oa4Lt3crnK
         6eDMYLEFtgjt4M2OZOumoqFHGEAD3z+TXveV4vjMSyLRDBpxbo7+SG2hsxeoCjBP7V48
         ZzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k9vzrTR3cxXzv/I12VHQRSBnPNzsABk7Hz1MBOTxpUc=;
        b=UzMcoYo9qW93SZ6M3ylAs0kUKlP5HuClxRXZCVjS91eLMJlvlEysJmi7MAK2J0FfEd
         mvf7TcOJFN5rrX1hVEvzZmKspLkrsihD/79X7FgKHDcSqkbLBu4DvKLQ+I0LJ3dXGTs4
         nXRrRx/0XPvi4wJqRkJVRs34v3t9abRVGef4mDNAsG+t43ClqFyPDxr/4CTpDAVtBz8i
         CQ/6RD6oan3vIynWsTreyCpaLGd/hL6YJWJXiIrrAAJzS35NSNxo3JeHbxwBuyAzMSj1
         2mhTKUF4VVJ/RhGVD5sIDfwKjptw35GWpAjs3yZz3MtBGbIww792T1NvCpeN0+eYCe+T
         LpSQ==
X-Gm-Message-State: APt69E08S69xFpuzeyjN0++vHlhuhdIB2dRrpPjJ5p3QRpkD76qRhi4G
        y4ahNOXBl50Twa6/tqhj4gv4uKgT
X-Google-Smtp-Source: ADUXVKIvcrXhf73GSBWAaIoFPXjdQenpcEoxEFFgjutBiC+3tT35Dgr724eMuI03Zq9i/0Gy0aHESQ==
X-Received: by 2002:a65:608c:: with SMTP id t12-v6mr17630725pgu.159.1529468251227;
        Tue, 19 Jun 2018 21:17:31 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id o87-v6sm1827485pfa.106.2018.06.19.21.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 21:17:29 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:17:26 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180620041726.GG650@jagdpanzerIV>
References: <20180606103356.GB19211@tigerII.localdomain>
 <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
 <20180618063738.GC27996@jagdpanzerIV>
 <20180618093917.qeaatnlqh5if6t3r@pathway.suse.cz>
 <20180618100718.GA555@jagdpanzerIV>
 <20180619075219.iq7ztwu43bn4uua7@pathway.suse.cz>
 <20180619082716.GD405@jagdpanzerIV>
 <20180619092304.6b6ba390@gandalf.local.home>
 <20180620015834.GD650@jagdpanzerIV>
 <20180619223222.6cf05e0b@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619223222.6cf05e0b@vmware.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 22:32), Steven Rostedt wrote:
> On Wed, 20 Jun 2018 10:58:34 +0900
> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> 
> > Which one of these you'd prefer to see in ftrace_dump():
> > 
> > - printk_nmi_direct_enter() / printk_nmi_direct_exit()
> 
> The above appears to be the most sane.

OK. The original name suggested by Petr.

	-ss
