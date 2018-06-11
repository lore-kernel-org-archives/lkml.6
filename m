Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2vlPCB8IHlvpEQAAmS7hNA
	; Mon, 11 Jun 2018 05:26:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0657B607E4; Mon, 11 Jun 2018 05:26:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxb29K5R"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9293F60791;
	Mon, 11 Jun 2018 05:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9293F60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932342AbeFKF0w (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932272AbeFKF0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:26:49 -0400
Received: from localhost (unknown [62.177.166.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B817208AF;
        Mon, 11 Jun 2018 05:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528694808;
        bh=dPVFcytT2OXrerKrBkDib+/yTsSY3UMdktRarmZJPJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lxb29K5RLPifYFlwBdP0IcX79eOttjH2tMstTDJFfXVJju50/wAHgjrwh7ByHt/IW
         HbvxgtKrDYm5jQsUWc8O4J7aSeLUxXfECsYHRfI6nX1f4fy5MGfXaKG7iUTEsCO+JN
         07hF69TMT+HhwMFMNe/tGPo/oIQmHg8x8KNXn/Vs=
Date: Mon, 11 Jun 2018 07:26:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Airlie <airlied@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.16 01/48] mmap: introduce sane default mmap limits
Message-ID: <20180611052627.GD644@kroah.com>
References: <20180609145947.679103414@linuxfoundation.org>
 <20180609145947.782225494@linuxfoundation.org>
 <CAMwc25rh7ZSO3mEFyTwbyh1qNy3k-5AHyRrRFq-Zih4kDDGsig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwc25rh7ZSO3mEFyTwbyh1qNy3k-5AHyRrRFq-Zih4kDDGsig@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 08:12:45AM +1000, David Airlie wrote:
> Can you make sure you pull in
> 
> 76ef6b28ea4f81c3d511866a9b31392caa833126 (tag:
> drm-fixes-for-v4.17-rc6-urgent)
> Author: Dave Airlie <airlied@redhat.com>
> Date:   Tue May 15 13:38:15 2018 +1000
> 
>     drm: set FMODE_UNSIGNED_OFFSET for drm files
> 
> Into anywhere this first patch goes?

Thanks for pointing this out, now queued up.

greg k-h
