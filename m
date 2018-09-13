Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33FFC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2763E20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2763E20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeINExt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:53:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45670 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeINExt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0bFM-00071y-OQ; Thu, 13 Sep 2018 23:42:04 +0000
Date:   Fri, 14 Sep 2018 00:42:04 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-ID: <20180913234204.GW19965@ZenIV.linux.org.uk>
References: <20180913221546.GV19965@ZenIV.linux.org.uk>
 <20180905185922.GA25461@avx2>
 <20180905192636.GA13608@kroah.com>
 <20180905193111.GA27217@avx2>
 <20180905222247.GT19965@ZenIV.linux.org.uk>
 <20180913220124.GA12570@avx2>
 <26412.1536881269@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26412.1536881269@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:27:49AM +0100, David Howells wrote:
> Al Viro <viro@ZenIV.linux.org.uk> wrote:
> 
> > 	It's too early for AFD postings.  And you *are* tempting
> > me to throw into the tree as many anti-C++ devices as can be
> > done tastefully, just to stop somebody attempting that insanity
> > in the earnest.
> 
> You would deliberately break the UAPI header files to make sure that they
> couldn't be used with C++?

UAPI - no; userland folks can use INTERCAL, for all I care.
Kernel-side, though, it's quite tempting...
