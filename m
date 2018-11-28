Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA13C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477A62081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="aomshsj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477A62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeK2C7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:59:06 -0500
Received: from imap.thunk.org ([74.207.234.97]:40202 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2C7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YYORD0OaGQwPsj2K4nIO3gfKNzOKjQpN9AxJ23cFiko=; b=aomshsj3+aiGSbeQSWm89Sx9Pc
        Oqnhn6bORwn23b1uncRmkPELlVuiTVgIh+AZ4w+ARUvO/j3I0nae4NXA+SG+ZCfRafOG/RJdh9NNU
        Yo47AhfO365zh/7uN0NNDo8JQYSbfBKNy/r2hOFkZJPbAqmgODwdKCC+0WJeUrYQp/tU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gS2Cw-0000sO-9z; Wed, 28 Nov 2018 15:56:58 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 852AD7A45D8; Wed, 28 Nov 2018 10:56:57 -0500 (EST)
Date:   Wed, 28 Nov 2018 10:56:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: oops when ext4 fs is full
Message-ID: <20181128155657.GG31885@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181128085038.iaklny2yuygrixhs@inc028000049.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128085038.iaklny2yuygrixhs@inc028000049.lancs.ac.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:50:39AM +0000, Willy Wolff wrote:
> I got a Oops when the hard drive was COMPLETELY full using a ext4 fs.
> After it, any command on the directory where the last write should have occurred freezes, while any other directory behave just fine.

Was this true after you rebooted?

Can you get a log of running e2fsck -n on the file system?

    	      	     	     	       - Ted
