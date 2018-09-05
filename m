Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1EDC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264A02077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264A02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeIFCzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:55:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34278 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIFCzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:55:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fxgCF-0005DL-Qr; Wed, 05 Sep 2018 22:22:47 +0000
Date:   Wed, 5 Sep 2018 23:22:47 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-ID: <20180905222247.GT19965@ZenIV.linux.org.uk>
References: <20180905185922.GA25461@avx2>
 <20180905192636.GA13608@kroah.com>
 <20180905193111.GA27217@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905193111.GA27217@avx2>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:31:11PM +0300, Alexey Dobriyan wrote:
> On Wed, Sep 05, 2018 at 09:26:36PM +0200, Greg KH wrote:
> > On Wed, Sep 05, 2018 at 09:59:22PM +0300, Alexey Dobriyan wrote:
> > > > On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> > > > > 
> > > > > Here's a set of patches that inserts a step into the build process to make
> > > > > sure that the UAPI headers can all be built together with C++ (if the
> > > > > compiler being used supports C++).  All but the final patch perform fixups,
> > > > > including:
> > > > 
> > > > Wait, why do we care?  What has recently changed to start to directly
> > > > import kernel uapi files into C++ code?
> > > 
> > > I think David is seriously trying to compile kernel with C++ compiler
> > > and this is first step.
> > > 
> > > He isn't alone. Resistance is futile. :^)
> > 
> > "struct class" is going to be a hard one to overcome :)
> 
> "struct class" makes you hostis publicus #1 of the Linux++ empire. :^)

Don't tempt me...
