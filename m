Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F6FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D134A20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D134A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeINXfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:35:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeINXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:35:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 99013BBD;
        Fri, 14 Sep 2018 18:19:29 +0000 (UTC)
Date:   Fri, 14 Sep 2018 20:19:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4.14 103/115] x86/xen: dont write ptes directly in 32-bit
 PV guests
Message-ID: <20180914181927.GA20957@kroah.com>
References: <20180913131823.327472833@linuxfoundation.org>
 <20180913131829.701763608@linuxfoundation.org>
 <20180914171222.GA30580@u40b0340c692b58f6553c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914171222.GA30580@u40b0340c692b58f6553c.ant.amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:12:22AM -0700, Eduardo Valentin wrote:
> Hello,
> 
> On Thu, Sep 13, 2018 at 03:32:03PM +0200, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Juergen Gross <jgross@suse.com>
> > 
> > commit f7c90c2aa4004808dff777ba6ae2c7294dd06851 upstream.
> > 
> > In some cases 32-bit PAE PV guests still write PTEs directly instead of
> > using hypercalls. This is especially bad when clearing a PTE as this is
> > done via 32-bit writes which will produce intermediate L1TF attackable
> > PTEs.
> > 
> > Change the code to use hypercalls instead.
> > 
> 
> Good that we got this in. Should we also take this one:
> b2d7a075a1cc ("x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear")
> 
> Which is under the line of the same issue?

It's also in this patch series, the very next one in fact :)

thanks,

greg k-h
