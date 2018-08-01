Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAD920862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="dmIh/Wru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAD920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390240AbeHASPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:15:25 -0400
Received: from imap.thunk.org ([74.207.234.97]:53078 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389980AbeHASPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wJFfK9KRAu2FxKSrmo/xz6zDGrMFO9dWqzgFf1L0qKk=; b=dmIh/WruqbVFZKlCMMse3FiI9a
        bfyJCuPc2apoypMxHm6iEahXU6KM+9F+MQLbzNj97DcvcrJsvz/zIFiC5FyHycWSfSvlVVVRoqgel
        sAgoQgXkXLHshaw91Ok39r1sT59kqBbbzg+GCGon11zTnatpK4R59SKllHXx4fdNEXDw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fktzW-0004RJ-Qf; Wed, 01 Aug 2018 16:28:50 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 530307A614D; Wed,  1 Aug 2018 12:28:49 -0400 (EDT)
Date:   Wed, 1 Aug 2018 12:28:49 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] vfs: syscall: Add fsinfo() to query filesystem
 information
Message-ID: <20180801162849.GA9187@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153314002975.18964.1773855756473041897.stgit@warthog.procyon.org.uk>
 <153314004147.18964.11925284995448007945.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153314004147.18964.11925284995448007945.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:14:01PM +0100, David Howells wrote:
> 
> Some attributes (such as the servers backing a network filesystem) can have
> multiple values.  These can be enumerated by setting params->Nth and
> params->Mth to 0, 1, ... until ENODATA is returned.

How does the caller know whether or not a particular attribute has
multiple values?  Is that a fundamental attribute of a particular
attribute?  (e.g., the documentation for each attribute must state
whether or not that attribute returns multiple attributes or not)

	       	    	      	      - Ted
