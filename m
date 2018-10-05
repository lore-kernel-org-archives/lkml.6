Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABADEC65BBA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790322084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790322084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeJFBXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:23:51 -0400
Received: from namei.org ([65.99.196.166]:35878 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeJFBXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:23:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w95INsEd014849;
        Fri, 5 Oct 2018 18:23:54 GMT
Date:   Sat, 6 Oct 2018 04:23:54 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/22] KEYS: Provide software public key query function
In-Reply-To: <alpine.LRH.2.21.1810060228100.8957@namei.org>
Message-ID: <alpine.LRH.2.21.1810060423370.8957@namei.org>
References: <alpine.LRH.2.21.1810040520570.16168@namei.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618449119.7946.11025480207548147086.stgit@warthog.procyon.org.uk> <22418.1538754702@warthog.procyon.org.uk>
 <alpine.LRH.2.21.1810060228100.8957@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2018, James Morris wrote:

> On Fri, 5 Oct 2018, David Howells wrote:
> 
> > James Morris <jmorris@namei.org> wrote:
> > 
> > > > +	if (strcmp(encoding, "raw") == 0) {
> > > > +		strcpy(alg_name, pkey->pkey_algo);
> > > > +		return 0;
> > > > +	}
> > > 
> > > Can encoding here also be NULL to indicate raw? per patch 01:
> > 
> > Ummm...  By the letter of the documentation, yes, though in practice it isn't
> > (it is defaulted to "raw") in the keyctl interface.  I wonder if it would be
> > better to require it to say "raw" and never be NULL.
> 
> Probably.

If you respin the patches please add all the signoffs.

-- 
James Morris
<jmorris@namei.org>

