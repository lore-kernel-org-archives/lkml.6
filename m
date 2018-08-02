Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9722BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017B2150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1017B2150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeHBOU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:20:56 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:46544 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbeHBOU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:20:56 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w72CTu1d017908;
        Thu, 2 Aug 2018 13:29:56 +0100
Date:   Thu, 2 Aug 2018 13:29:56 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Jeff Chua <jeff.chua.linux@gmail.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: How to secure erase PCI-E NVME SSD connected via USB3?
Message-ID: <20180802132956.6b7110ed@alans-desktop>
In-Reply-To: <CAAJw_Zvaw8yoyejg5T6CtRFjoS4i_EBYKRVWocpH+mpwfaVC1Q@mail.gmail.com>
References: <CAAJw_ZuQXrYaEu9_pXWtoDpUjR2au1gGT_FP9F1e1Y7veHSz2Q@mail.gmail.com>
        <CACVXFVPpSJDqR8ki2PiDBbU36KsGFMYsOEf_9bmN6Cpo3w_YoQ@mail.gmail.com>
        <CAAJw_ZtZ8hXi_B6+duiQYpaeSsQ7BQD-KwtE3H6K8Y8O8pAuig@mail.gmail.com>
        <CAAJw_Zvaw8yoyejg5T6CtRFjoS4i_EBYKRVWocpH+mpwfaVC1Q@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> # hdparm --user-master u --security-erase p /dev/sda
> (returns immediately and does nothing).
> 
> I've tried hdparm on an SSD connected via USB3 and it secure-erased ok.
> 
> Anyone working on this?

Sounds to me like you need to contact the vendor of the interface in
question. If it accepted a security erase command and didn't do it then
it's broken. It's at liberty to refuse it, or report it doesn't know what
you are talking about, but if it just returned and after re-plugging the
device its still using the old keys then it or the device is busted and
it's not something the OS can do much about.

Alan
