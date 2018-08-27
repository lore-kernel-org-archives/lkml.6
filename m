Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF569C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEF520896
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSpAl3gN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEF520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeH0NaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:30:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46358 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0NaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:30:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so11777133ljj.13;
        Mon, 27 Aug 2018 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XLQFTafYzMFh2BQ1WlYD2Ng2koSEMQyinUqrNanOj7Y=;
        b=kSpAl3gNIq9o8RDCN2BkG8pFGKbxoj2p/GPKOh9HHVwmrZO/3W/MRDG/Oo09/+4soz
         20CHSBvRtdRU459ukQuoxZmNcaEmoLJJ/Fjuvm2LZuEnA7WEdA723Gsfawc4Cw+bk+D6
         oNkDxv02i1tPhphYYXAYYfrQIPuIBHe6VCrSx9Fa1wqyV7pORvGV12ANKBFhaFh+6yK0
         NsyaTa8lh8meojkuOZXacf3q0a1eYjdVeMHOENfd+XT12L4l6/SQl2X2gmzpjvWlTD78
         aUodWb1IZ8/C9u8jX3qe051dCZIMggRrisaz1vp/Eft//qF3ZoSSO9nnExoFeub+6Nxy
         oIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLQFTafYzMFh2BQ1WlYD2Ng2koSEMQyinUqrNanOj7Y=;
        b=JONAgyefVKxYS+dTXU10pgyUcqIhayBV9MotkN2i1L2bIoAOY05WhN1U1lQzlmJtpS
         K1kw8Fgf1zYm4FRMwAO9g/UX0q9qLQCieHTs0t7p8nvbsRfpz4ffTLwimPA6QPp0nO8Y
         nyhc7qfUSqlEurdz6vLXtGKR77oGnkvaEWrZ3+zYZDoZYwqfXJzB4dKxBGBpBANZkHf/
         N8J/BlvvdzaL0V8NTx1WUS10pHHEivnzr6o6b+2KTJtsaBOas822/RjTlY6Te2ptfH1l
         neFgrStQOY7ZVhfPoWpHU3BS2h5C2nz2l0yTGWMoU6Ghn697drRCOtSa5XgxHGgoiaC7
         ZnZQ==
X-Gm-Message-State: APzg51BNIRZ4SpmGszSeIeoSWLdrrS2E17Xk1GmjQt6c/TyXq5XFbM/q
        81VE5G2WslxJB19H8QPvPCs=
X-Google-Smtp-Source: ANB0VdYGmZ9bJRc8Ijat0rr55LutB7q/8R1o+PnZ7uUJRcEFvSH9DujbVgLVRmqVlphqk75CKRnGdQ==
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr7776800ljc.25.1535363064882;
        Mon, 27 Aug 2018 02:44:24 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2715016ljg.54.2018.08.27.02.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 02:44:24 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuE4N-00067H-72; Mon, 27 Aug 2018 11:44:23 +0200
Date:   Mon, 27 Aug 2018 11:44:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>
Subject: Re: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
Message-ID: <20180827094423.GA14967@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-6-johan@kernel.org>
 <20180827102820.3abf7291@bbrezillon>
 <20180827084414.GZ14967@localhost>
 <20180827104842.26bce912@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827104842.26bce912@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:48:42AM +0200, Boris Brezillon wrote:
> On Mon, 27 Aug 2018 10:44:14 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Mon, Aug 27, 2018 at 10:28:20AM +0200, Boris Brezillon wrote:
> > > Hi Johan
> > > 
> > > On Mon, 27 Aug 2018 10:21:49 +0200
> > > Johan Hovold <johan@kernel.org> wrote:
> > >   
> > > > Use the new of_get_compatible_child() helper to lookup the nfc child
> > > > node instead of using of_find_compatible_node(), which searches the
> > > > entire tree from a given start node and thus can return an unrelated
> > > > (i.e. non-child) node.
> > > > 
> > > > This also addresses a potential use-after-free (e.g. after probe
> > > > deferral) as the tree-wide helper drops a reference to its first
> > > > argument (i.e. the node of the device being probed).
> > > > 
> > > > While at it, also fix a related nfc-node reference leak.
> > > > 
> > > > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > > > Cc: stable <stable@vger.kernel.org>     # 4.11
> > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > Cc: Josh Wu <rainyfeeling@outlook.com>
> > > > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>  
> > > 
> > > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> > 
> > Thanks for the ack.
> > 
> > > I'll let Miquel queue this patch to the nand/next branch, unless you
> > > want it to be merged in 4.19, in which case I'll queue it to the
> > > mtd/fixes branch.  
> > 
> > Note that there's a dependency on the first patch of the series which
> > adds the new helper.
> 
> I was not Cc-ed on this patch :P.

Yeah, sorry about that. I made sure everyone was CCed on the
cover letter, but guess I could have reused that list for the helper as
well.

> > Rob can pick up the entire series if the various
> > maintainers agree, otherwise I'll try to get at the least the helper
> > into -rc2.
> 
> If everything goes in 4.19-rc2 through Rob's tree that's fine, but if
> it's queued for 4.20 we might need an immutable tag just in case we
> queue conflicting changes to the NAND tree.

Ok, thanks.

Johan
