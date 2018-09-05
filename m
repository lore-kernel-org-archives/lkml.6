Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85F72075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85F72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIEWAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:00:11 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:60296 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbeIEWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:00:11 -0400
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1fxbbv-000053-Oz; Wed, 05 Sep 2018 13:28:59 -0400
Date:   Wed, 5 Sep 2018 13:28:58 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] UAPI: coda: Don't use internal kernel structs in
 UAPI
Message-ID: <20180905172858.pv2vafetjzzk5jxs@cs.cmu.edu>
Mail-Followup-To: Yann Droneaud <ydroneaud@opteya.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <153616291029.23468.16421004714304578585.stgit@warthog.procyon.org.uk>
 <1c57005277ac723ebb670a1dc847a205f0529d53.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c57005277ac723ebb670a1dc847a205f0529d53.camel@opteya.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:12:37PM +0200, Yann Droneaud wrote:
> Le mercredi 05 septembre 2018 à 16:55 +0100, David Howells a écrit :
> > The size and layout of internal kernel structures may not be relied
> > upon outside of the kernel and may even change in a containerised
> > environment if a container image is frozen and shifted to another
> > machine.
> > 
> > Excise these from Coda's upc_req struct.
...
> 
> This structure should not have been exposed to userspace in the first
> place: it's unusable by userspace as it is. It was incorrect to have it
> outside of #ifdef __KERNEL__ before commit 607ca46e97a1b ... 
...
> So the structure can be moved back to <linux/coda_psdev.h>.

I found a year old patch that clearly fell through the cracks that
fixes this exact thing.

    https://lkml.org/lkml/2017/8/6/186

Jan
