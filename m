Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36883C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFFD208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="WUX7zhmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFFD208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeHYCWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:22:03 -0400
Received: from imap.thunk.org ([74.207.234.97]:43548 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeHYCWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MW8Mo5WYV/jtB27uNo0lWYcPFClWZRNLFXHgrmRymlQ=; b=WUX7zhmUQaow2VmP74JlgUqwn7
        jg6ziRYU7ErCPdtQ4By5qasGjzmfKXl6n2uknAMGx8Gi1NQHZap8jjvxQ71akcLM4ytmLNniw/IZz
        CN4EmXIkMkAs1fXbM3xfSTBa6Jkqx8FLFcRtyECA8QcCTOHVu1P6iEEwUQs95DAhY7qk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ftKpS-0005i4-8i; Fri, 24 Aug 2018 22:45:18 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1A50B7A57A9; Fri, 24 Aug 2018 18:45:17 -0400 (EDT)
Date:   Fri, 24 Aug 2018 18:45:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin Walters <walters@verbum.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
Message-ID: <20180824224517.GF15262@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Colin Walters <walters@verbum.org>,
        Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
 <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 01:42:29PM -0400, Colin Walters wrote:
> 
> While I'm not too familiar with the vfs, as far as I can
> tell  from inspection of Linus' git master is that pretty much any change (timestamp, hardlinks) ends up
> calling notify_change() which calls the fs-specific one, and in
> the verity case basically denies everything, right?

That's not correct.  The verity case only denies truncate, because
changing the data of the file would break the Merkle tree checksums.
The metadata of the file is is not made immutable.  So a
verity-protected file can be deleted, renamed, can have hard links,
and the timestamps can be set via utimes(), etc.

Cheers,

    		       	      	  	     - Ted
