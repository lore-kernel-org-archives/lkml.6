Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F393C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C725B2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oM5gJI97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C725B2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJECRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:17:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41382 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJECRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:17:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id q17-v6so5645041plr.8;
        Thu, 04 Oct 2018 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PDAXGuik59FtHdBSCQdlM93BjbA1AEBUywHJ+lxA/7U=;
        b=oM5gJI97IxjkitgBa0JxU8Ymsk5jTMN5bTgFmLSetFmI7RLaAHarqWkplPpfOxAcW7
         DCoWd0t4GOF/iY+UxZTuDakT1pk6O9VwhyJ8WP5doNBk8ct+ITsQkbh3erznNvMIG8Gl
         RNbYGgsdoOXQ6URpiQ4fxm5O2uYO3Rh9zAMrnNzX43gf+cUowoo/ZhPrSPzOJAoQ8gqT
         cUz/1iImoJX0inIXr3uTEtTqD8c7N56VhN1soqcGtsESqmipeZxlA8fkBZGMiCp4Ou66
         cimJpyvDx5ZxgBTqYGX9vejCgA8B/ySM4vLtwEHVVxYh60an+InEnJnaj6jZ3H7bDtOv
         65ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDAXGuik59FtHdBSCQdlM93BjbA1AEBUywHJ+lxA/7U=;
        b=UhhXkUtTsU8XwzMPi0ZgdmaOtIjVKNmA6AhQxTwjw56nKEmCRhu9JP8LKWt0GBuWCd
         nWjtRhZ2V0sTYAPru4X+1QO2GaAnH1KJxSIP24PNmjeEzqB2G3n6PCBeymy38Ejo70rL
         yesmXLHRzQ597xyraqFAgZ2SUD2MZuCGLZN8nIqwIu0fHFMpgH80NSVoR+YkFFJrs0Ne
         W1ChlGwLKK5QN2zIoE04fHENvnwIIpUopYds0gLdg4f7/cGQ/9aS0P0MIiMBCZY6Wj16
         mmUByfJC4d7ZVqgHUpm4q1ispmH3EYX1gf3u9JmbltZHmPjxswS5senU+Nn7mXMMb2mw
         LBTg==
X-Gm-Message-State: ABuFfoijPiAJ7iLoptDZKGnrlX6gqEPWtUqNVqLipK5t3HT/AFky3cBv
        0x14OfM+vr+YNrJFaWyvOTtSX4zY8jIsxw==
X-Google-Smtp-Source: ACcGV62OuOxQeAIRsibVFUN+7Jzq/VWD7k6xExUlbqapBFdbIqkUDQMXq86vuA8wRCu5p38rcW73dA==
X-Received: by 2002:a17:902:b484:: with SMTP id y4-v6mr7986220plr.262.1538680955853;
        Thu, 04 Oct 2018 12:22:35 -0700 (PDT)
Received: from localhost ([82.102.30.219])
        by smtp.gmail.com with ESMTPSA id p64-v6sm8189883pfa.47.2018.10.04.12.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 12:22:35 -0700 (PDT)
Date:   Thu, 4 Oct 2018 12:22:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] drbd: avoid clang warning about pointless switch
 statement
Message-ID: <20181004192231.GA29744@localhost>
References: <20181002171447.10765-1-natechancellor@gmail.com>
 <20181004191854.GD10984@soda.linbit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004191854.GD10984@soda.linbit>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:18:54PM +0200, Lars Ellenberg wrote:
> On Tue, Oct 02, 2018 at 10:14:48AM -0700, Nathan Chancellor wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The drbd code causes warnings that we cannot easily disable when building with clang:
> > 
> > In file included from drivers/block/drbd/drbd_debugfs.c:10:
> > In file included from drivers/block/drbd/drbd_int.h:48:
> > In file included from include/linux/drbd_genl_api.h:53:
> > In file included from include/linux/genl_magic_struct.h:237:
> > include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'
> > 
> > There is nothing wrong with the code, and adding 'default:' labels
> > in the right place is enough to let clang shut up about the warning.
> 
> Actually, I think I'd prefer a "case 0:" instead of the "default:",
> because that would assert that we don't use a 0 for op or field numbers.
> 
> As at least some people seem to care, I suggest we bundle up
> this and the other clang warning you just resent the patch for
> with whatever else we may come up with for the next merge window
> and send a pull request to Jens then.
> In case we forget, please send a friendly reminder.
> 
> Thanks,
> 
>     Lars
> 

Hi Lars,

I will go ahead and test that change shortly and send it over for
review.

Thanks for the quick reply!
Nathan
