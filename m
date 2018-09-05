Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32279C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8B620659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8B620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeIEX6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:58:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIEX6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:58:14 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E51E7191F;
        Wed,  5 Sep 2018 19:26:38 +0000 (UTC)
Date:   Wed, 5 Sep 2018 21:26:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-ID: <20180905192636.GA13608@kroah.com>
References: <20180905185922.GA25461@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905185922.GA25461@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:59:22PM +0300, Alexey Dobriyan wrote:
> > On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> > > 
> > > Here's a set of patches that inserts a step into the build process to make
> > > sure that the UAPI headers can all be built together with C++ (if the
> > > compiler being used supports C++).  All but the final patch perform fixups,
> > > including:
> > 
> > Wait, why do we care?  What has recently changed to start to directly
> > import kernel uapi files into C++ code?
> 
> I think David is seriously trying to compile kernel with C++ compiler
> and this is first step.
> 
> He isn't alone. Resistance is futile. :^)

"struct class" is going to be a hard one to overcome :)
