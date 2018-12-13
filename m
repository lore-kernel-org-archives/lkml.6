Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B84C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AA520879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544723790;
	bh=nJmeHjUKPmHTRmF+Pe1EKl9VWyx8Us4YXaU6Rn3m2BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ffm72HF82DUIvmgDUZr1GSklg2ys4DCvmqwzyazo1GFoAdj2unModdDx1diz+yWfO
	 hhjrYj3oOK4BV80vye72C1b61fRHwlquOtHMAkaWDZy1PmI4QYGwQPJsL9ALFcGpkm
	 HUE3m1KjoqmyLJ1H6gqlDSz4CCQO5QOXscnAAQDk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AA520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeLMR43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbeLMR42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:56:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EF320851;
        Thu, 13 Dec 2018 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544723788;
        bh=nJmeHjUKPmHTRmF+Pe1EKl9VWyx8Us4YXaU6Rn3m2BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+T08u2mK82SVUcPzEhagqaIZ75zJ9bgxQ5MuVuweJF1U+/NJ060pA4dT2M79UST+
         /vH13YuIzwNc99I+OAZa4I9MkLunVpUsqhXJy+ZUnW7smIYdfbbBxkWYTCetPr+KVC
         GTsWp1GsAijLjECSHmkKFPABNAJ0KygrsynO7dok=
Date:   Thu, 13 Dec 2018 18:56:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Todd Kjos <tkjos@google.com>, Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        joel@joelfernandes.org, darrick.wong@oracle.com,
        david@fromorbit.com, kilobyte@angband.pl,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        chouryzhou@tencent.com
Subject: Re: [PATCH v1] binder: implement binderfs
Message-ID: <20181213175626.GB7218@kroah.com>
References: <20181207232509.31771-1-christian@brauner.io>
 <CAHRSSEzxR2wRw9UxaKkXTZ7cu989+70-V07PxMm6o+BfLTQ=6w@mail.gmail.com>
 <20181212125126.4lhnjvrvaz5wwpib@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212125126.4lhnjvrvaz5wwpib@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:51:27PM +0100, Christian Brauner wrote:
> > > Cc: Martijn Coenen <maco@android.com>
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Do we plan to bring this into mergeable shape before Christmas? I'm
> happy to do it. :)

I haven't had the chance to give it a good review yet, but you should at
least fix up the kbuild warnings that the 0-day bot sent you :)

thanks,

greg k-h
