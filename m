Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CECC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF35820866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lImCh7dF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF35820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeILCIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:08:39 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43116 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILCIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:08:39 -0400
Received: by mail-ed1-f41.google.com with SMTP id z27-v6so64412edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5hMxcTwgFvjg3Cn36+h3/NyFLDAf8RfQtlGAAtawlzI=;
        b=lImCh7dF4E2qabezD6/q6ozsuJLTLIGk0nxXOJmHojmZWxLdvL8LNylY2WWT7DNDtc
         ZzdxquDYVGymLJs40gUtlP87+VY1payt5KLe4fbBi4fsCDAbRcRuw5LP4GNDBYdnGTsr
         bSeNCvXv6AAiuzmeUjoMXToMCICeMPABy2OK62lnFe76Fg3Ic+Rwypi3iq7pruvr9pR5
         4FRMuoQLdq58fA9eEYaKAIzi04iq2yYfqbPcq2DI84AlhGRASl/iQ61ga/eKarhcQqQw
         +OzgukqlE+dFlJshB2oa+YNIoqYuV5J4p8D+g3VkQY1106s5hRLWl45aeuD4ACpdxv5t
         QJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5hMxcTwgFvjg3Cn36+h3/NyFLDAf8RfQtlGAAtawlzI=;
        b=pfffkpifQBg2O/utweRuFPvnwG/neIjuwy9QsCXq9G+RyWLGGsK6KXLniKseT+qgO5
         ajZaVbGdXOQUpBsS/Xx4BlkCtbbQjY+H+4AhPHAfbsF/ztAm8gkCDzwHIn6vlYjQcaz5
         3RXLbT61DvUJBnBZ7ls3xLllFXdmqKKZqrmxBWiFeilTFx90jFet/WJp+N56VNF/iv7d
         TCQEOK2EvsH63S3So1syhgcGlkEwLD+NwlDlnZOEP1g9uF0NYLqCpog31UI0RjQDlDZx
         +fn3ZQQN2HJ8cC6XdmeV9BKZPMdh26kPpgTvr0RKtgM7sFp9FLBarBde9p+9tC9AeiBI
         Vruw==
X-Gm-Message-State: APzg51DUeaVpdxdsKr9xaG6kJ4dMeTrMz/gggacoMOUGp+aL7roXOPoy
        /24iUX+jl5fiUjTcowQSS4SbdPyu6qcCOg==
X-Google-Smtp-Source: ANB0Vdb1gg1/RT3d2YOe2MpLnO1jbQBX1gzLO0356jICLYEb6dMAZhVAs0bv7V8cL+RNFD3dZlS23g==
X-Received: by 2002:a50:98c1:: with SMTP id j59-v6mr30671219edb.212.1536700051201;
        Tue, 11 Sep 2018 14:07:31 -0700 (PDT)
Received: from xux707-tw ([109.78.225.224])
        by smtp.gmail.com with ESMTPSA id z30-v6sm11543481edb.4.2018.09.11.14.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 14:07:30 -0700 (PDT)
Date:   Tue, 11 Sep 2018 22:07:46 +0100
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH 1/1] staging:rtl8192u: Rename dot11d_init to fix name
 clash
Message-ID: <20180911210745.GB31239@xux707-tw>
References: <20180904105623.15797-1-johnfwhitmore@gmail.com>
 <20180904105623.15797-2-johnfwhitmore@gmail.com>
 <20180910081929.GB31344@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910081929.GB31344@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:19:29AM +0200, Greg KH wrote:
> On Tue, Sep 04, 2018 at 11:56:23AM +0100, John Whitmore wrote:
> > The function dot11d_init() was previously renamed to clear a style
> > issue. Unfortunately the new name used, dot11d_init(), clashes with
> > a sybmol which is exported with the same name. To correct this
> > problem the function has been renamed to rtl8192u_dot11d_init().
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> 
> You forgot a "Reported-by:" tag here.  I'll go add it...
> 
> thanks,
> 
> greg k-h

Sorry and thank you.
