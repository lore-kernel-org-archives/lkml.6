Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC119C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C3120C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="vPSncn1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C3120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIMjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:39:09 -0400
Received: from imap.thunk.org ([74.207.234.97]:55496 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbeJIMjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mnML//55Ixb0b4sata76z7h4mJ7WBODMfJqzB1O6bqY=; b=vPSncn1PprbcmusmOBKQ+tLT7B
        Wt5WBAxMyxaxvJKsTLPH/eibAl4esNGjv28ALu9u7Gmidrsbp8I57oLCQblKv5IND5F6GedipF5yX
        X9wLwAclUkf2N4CZ48YRY5a/dtMzwpSWHbQUpC2/H6WkRWkpfPCpR7VNzHl09IM120p8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g9kUv-0002lA-NG; Tue, 09 Oct 2018 05:23:57 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 62F597A7900; Tue,  9 Oct 2018 01:23:56 -0400 (EDT)
Date:   Tue, 9 Oct 2018 01:23:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ext4 tree
Message-ID: <20181009052356.GA30286@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181009105102.752dd9ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009105102.752dd9ee@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 10:51:02AM +1100, Stephen Rothwell wrote:
> Hi Ted,
> 
> After merging the ext4 tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:

Oops, my bad.  Thanks for catching this.  I failed to a new helper
function inside #ifdef CONFIG_QUOTA .. #endif.

Should be fixed now.

						- Ted
