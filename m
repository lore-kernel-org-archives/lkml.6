Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E5824D71
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 00:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E5824D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeFXA27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 20:28:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44099 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbeFXA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 20:28:58 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWste-0000VS-Ba; Sun, 24 Jun 2018 02:28:50 +0200
Date:   Sun, 24 Jun 2018 02:28:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Howells <dhowells@redhat.com>
cc:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V7 00/41] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
In-Reply-To: <15108.1529795694@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.1806240226370.8650@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de> <cover.1529706536.git.reinette.chatre@intel.com> <15108.1529795694@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2018, David Howells wrote:

> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> >  - Stick the struct into the local header file and not at some random place in
> >    the source.
> 
> Why?  It's only used in that one file.  There doesn't seem to be any
> particular need to share it around.

It's not in a global header. It's a local header exactly to stick stuff
like that into it.

> >  - Get rid of the fugly camel case
> 
> It's not camel case.  It's the name of the option it's encoding.  But if it
> makes you happy...

Well, the option name slipped through, but that doesn't make an excuse for
making the struct member equally ugly. 

Thanks,

	tglx
