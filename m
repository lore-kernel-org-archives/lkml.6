Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518AFC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126D420892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544267140;
	bh=5wbzCEyxCXKgx7HJSF8HM5pU4xO7wYMTxM5OA7Dntzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WqYxd0CgpVUz2dbPHgxhMy5l5POWu9AlIUSKe3V6JX8T6PF+6fe9KVnFSeDH3dt+H
	 Hn3vAJ4NcbF9CBr9ig5XB6TvnqsfxB7WDwYl5rG39bcm3E5uhdsGObHj25vbwbSJ4M
	 L0uT4RW14NjLEzMgxj+VxMGPMFoGomtxVQqXlpfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126D420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeLHLFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHLFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:05:39 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1193920700;
        Sat,  8 Dec 2018 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544267138;
        bh=5wbzCEyxCXKgx7HJSF8HM5pU4xO7wYMTxM5OA7Dntzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vFOl9kB7Ym+RDJNxZi1278YwglBOd7cQHT80ONZw7XoLrn7ybjelbuy4knBt6YUnh
         NOnxIRuAAeRy81UBmmX3ny1gSVZV5ktc7SlUYLlEFpihNVCznnV82DJSnDJboNhO6C
         XLJzPWptRmLFukKU9RgkDTAcGUqPh774XsbaUtzE=
Date:   Sat, 8 Dec 2018 11:05:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: add binding doc for ad5933
Message-ID: <20181208110533.07d66422@archlinux>
In-Reply-To: <772d86622aea17e1c7b5ac05e096f1a129fc86b4.camel@perches.com>
References: <20181202165712.t6pd6ygq57llf2lr@smtp.gmail.com>
        <20181202185043.GA2007@himanshu-Vostro-3559>
        <772d86622aea17e1c7b5ac05e096f1a129fc86b4.camel@perches.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2018 15:22:15 -0800
Joe Perches <joe@perches.com> wrote:

> On Mon, 2018-12-03 at 00:20 +0530, Himanshu Jha wrote:
> > On Sun, Dec 02, 2018 at 02:57:12PM -0200, Marcelo Schmitt wrote:  
> > > Add a devicetree documentation for the ad5933 and ad5934 impedance
> > > converter, network analyzer.
> > > 
> > > Co-Developed-by: Gabriel Capella <gabriel@capella.pro>  
> > 
> > checkpatch spits out:
> > 
> > WARNING: Non-standard signature: Co-Developed-by:
> > 
> > Co-developed-by Vs Co-Developed-by ?
> > 
> > Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
> > Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
> > 
> > Confusing! Don't know which one is correct.  
> 
> I think neither one.
> 
> What's the real purpose or value of it?
> There isn't one as far as I can tell.
> 
> Just use Signed-off-by:
> 
> Or maybe add multiple "Authored-by:" if
> anyone is all that concerned about authorship
> crediting...

This is output of pair programming so only fair to acknowledge
both developers (or more if a larger group).  Right now
we have a guide that says Co-developed-by is the way to do that.
I would stick to that.  If people feel something else makes sense
then they should propose a change to the documentation and
hopefully we can reach some agreement on this.

I'm happy with Co-developed-by in IIO as I think it's a fair
reflection of what happened. Authored-by would be fine but
isn't a standard tag documented anywhere.

Jonathan
> 
> 
> >   
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> > > ---  
> > 
> > Use `./scripts/get_maintainer.pl <your_patch>` to list the DT
> > maintainers and the relevant mailing list.
> > 
> >   
> 

