Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32266C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56EE2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 02:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56EE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJIJWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 05:22:07 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:42276 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbeJIJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 05:22:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3A121180A8877;
        Tue,  9 Oct 2018 02:07:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tiger54_7be7e4fa4ec45
X-Filterd-Recvd-Size: 1786
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Oct 2018 02:07:31 +0000 (UTC)
Message-ID: <a4c9ceb0fb612aa9350423a1e1ce58b2e64fd029.camel@perches.com>
Subject: Re: CHECKPATCH: strange warning on alignment modifier
From:   Joe Perches <joe@perches.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Oct 2018 19:07:30 -0700
In-Reply-To: <15d77776-0551-5b7d-935e-16496c3800e2@gmail.com>
References: <15d77776-0551-5b7d-935e-16496c3800e2@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 10:56 +0300, Igor Stoppa wrote:
> Hi,
> 
> I have the following fragment of code:
> 
> +struct my_struct {
> +       atomic_long_t l __aligned(sizeof(atomic_long_t));
> +} __aligned(sizeof(atomic_long_t));
> 
> 
> triggering this warning, when fed to checkpatch.pl:
> 
> WARNING: function definition argument 'atomic_long_t' should also have 
> an identifier name
> #19: FILE: path/to/file.h
> +	atomic_long_t l __aligned(sizeof(atomic_long_t));
> 
> 
> gcc [(Ubuntu 7.3.0-16ubuntu3) 7.3.0] seems to be happy about it
> 
> I am using the HEAD from mainline.
> 
> My intent is to specify the alignment of both the field and the 
> structure (yes, probably redundant in this single-field case).
> 
> If I am doing something wrong, I can't figure out what it is, but I 
> don't understand why the WARNING is mentioning a function definition.

It's a defect in checkpatch.
For now, just ignore the message.
I will work on it later.


