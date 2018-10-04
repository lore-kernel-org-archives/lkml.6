Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520022083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="XobNOS6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520022083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJECNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:13:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37963 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeJECNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:13:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so11104935wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gJOZU2G9npsMt8sbCGivn0hVgOJZA+BjT3B/aTKdDqo=;
        b=XobNOS6CsPXexi8EMYSnGgSzFsZFocttzg5XYRaG/gVvL9R4rDY/QOb15oe5a2dg+G
         Aujvuf7OCwjLRkEoexck51SRQub2qE+CTOmrVFJfei/FW+1oWw03HFPgkkugbcv0e8X/
         bEjoqx+WZRK/H2Z8AxPuvTH0UGdl63/J900Xp1Bm7ekRg+5vV9bfJ7S8lSw5dGHDmtf7
         3oYj0eoGbMnw3f1j+NKpfChrsYwf4CrNYmictWqx/KJgzJ5TrTsc4fx/a6V+Hno9Rj44
         MuJwhy+KJP6kNF4Qfgn7lwzET+MmQGjdvaweqsexa97IZAqgYg2A3cPK5TX7xa401Brw
         LseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gJOZU2G9npsMt8sbCGivn0hVgOJZA+BjT3B/aTKdDqo=;
        b=dPmGGFXXvtevZZpahcrUvMiZHrkOBXJ/ZPmQv/Ct/8hCYZnSItKIZNmVMVimT9Z6eh
         yIlw2qv56N9fPHcUtDo5yh59Mbavet5wLYDnQwVAtJerSQWzu1BJhD49Kl6S/tfJBNKf
         j1NmYytXiBaRQrkAev0erJgX6bOHsMwrux2+2A7QIt540X4d8rA1AF/UjRKKRm7tQElq
         hCrR9++2Qx1Xsycyh4gdXMIPe8M1QN1qqiTDe0Tt+hSJ1n7OF7ZNwB4vQmjhOYQq4ybx
         VCtqtLr7GtLV/rXzrp90IK0k0bkvtwlEWjGfZ7JxL1aN8qasxM7+FpoY9MUMyWL1kdOR
         KRYg==
X-Gm-Message-State: ABuFfojOOlzfVCyPRVFQWbPJn4qr4mAOXMo6K4byzwFp/UkhG6udmKRy
        rv3xJ8pKHKGJqTDBArqVVKXFbQ==
X-Google-Smtp-Source: ACcGV62rDMqXbhqEWuiDZUAJNv6/OegO+qrd7AMfQlAwziq0mQ9ELtikuVx5dNJtM8WcARAzwYoCAA==
X-Received: by 2002:adf:bc13:: with SMTP id s19-v6mr6262932wrg.255.1538680736512;
        Thu, 04 Oct 2018 12:18:56 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id j203-v6sm7025261wmd.46.2018.10.04.12.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 12:18:55 -0700 (PDT)
Date:   Thu, 4 Oct 2018 21:18:54 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] drbd: avoid clang warning about pointless switch
 statement
Message-ID: <20181004191854.GD10984@soda.linbit>
Mail-Followup-To: Nathan Chancellor <natechancellor@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20181002171447.10765-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002171447.10765-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:14:48AM -0700, Nathan Chancellor wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The drbd code causes warnings that we cannot easily disable when building with clang:
> 
> In file included from drivers/block/drbd/drbd_debugfs.c:10:
> In file included from drivers/block/drbd/drbd_int.h:48:
> In file included from include/linux/drbd_genl_api.h:53:
> In file included from include/linux/genl_magic_struct.h:237:
> include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'
> 
> There is nothing wrong with the code, and adding 'default:' labels
> in the right place is enough to let clang shut up about the warning.

Actually, I think I'd prefer a "case 0:" instead of the "default:",
because that would assert that we don't use a 0 for op or field numbers.

As at least some people seem to care, I suggest we bundle up
this and the other clang warning you just resent the patch for
with whatever else we may come up with for the next merge window
and send a pull request to Jens then.
In case we forget, please send a friendly reminder.

Thanks,

    Lars

