Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA79C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB45E21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548098515;
	bh=RWy6sdDMBTjc4YRkkGmHRyLY8eAxQBE3TihOE9CwNZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QTJIGepGjbaYprCGqXXo6680Mhx7V77ZiCZ0yCqlJ61S3NG1BCc9fTPRXRHUYJ5Io
	 FL8xZCMtCOMtYngkFP1coTyNqt/Za/S5TYfac/cl7vlCCNbYwf8zTG6hDMmbYzncDB
	 lcU3HBUBuAcjnXLt5kgcD9ZIW8/1xK0kRGzmja8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfAUTVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfAUTVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:21:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E3221019;
        Mon, 21 Jan 2019 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548098511;
        bh=RWy6sdDMBTjc4YRkkGmHRyLY8eAxQBE3TihOE9CwNZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/awcj5WbXIjbGustIcFdrkXdB/bT4svW/AFFW/anM+6Qx4d+qMantFAJVYsXYxNn
         UTLSNlRObr3zhGSXvPtCCTpLlMbSuVv3oPSyy/a9yafqL92xE3Bl/tnDeFsYS/I+1C
         eYXNnBbm+JEUDJis9NF8fUhWw1VXoDEaCRuXWS+0=
Date:   Mon, 21 Jan 2019 20:21:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     ian.kumlien@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
Message-ID: <20190121192148.GC4026@kroah.com>
References: <CAA85sZum33M+1NRcfWkua+66CBTxM8ope+hoGASv6mR8NrwPTg@mail.gmail.com>
 <20190121151020.GB4717@kroah.com>
 <CAA85sZtizu_uvHhevg_B1Ok7K=O_J=agAmG5ic7M=1by5BCurw@mail.gmail.com>
 <20190121.104824.1888946069199769292.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121.104824.1888946069199769292.davem@davemloft.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:48:24AM -0800, David Miller wrote:
> From: Ian Kumlien <ian.kumlien@gmail.com>
> Date: Mon, 21 Jan 2019 16:38:11 +0100
> 
> > Hi David,
> > 
> > could we have your blessing to add the following patch to -stable for 4.20.4:
> > commit 41d1c8839e5f8cb781cc635f12791decee8271b7
> > Author: Paolo Abeni <pabeni@redhat.com>
> > Date:   Tue Jan 8 18:45:05 2019 +0100
> > 
> >     net: clear skb->tstamp in bridge forwarding path
> 
> It is already in my -stable queue:
> 
> https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=
> 
> I honestly don't know why I bother putting forth such an effort to publish
> what is in my -stable queue if people don't bother checking it. :-(

We should add a link to it in the stable_rules.rst file so that more
people know to check it.

Something like the patch below?

thanks,

greg k-h

--------------------------

Subject: [PATCH] stable-kernel-rules.rst: add link to networking patch queue

The networking maintainer keeps a public list of the patches being
queued up for the next round of stable releases.  Be sure to check there
before asking for a patch to be applied so that you do not waste
people's time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 0de6f6145cc6..7ba8cd567f84 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -38,6 +38,9 @@ Procedure for submitting patches to the -stable tree
  - If the patch covers files in net/ or drivers/net please follow netdev stable
    submission guidelines as described in
    :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`
+   after first checking the stable networking queue at
+   https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=
+   to ensure the requested patch is not already queued up.
  - Security patches should not be handled (solely) by the -stable review
    process but should follow the procedures in
    :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.
