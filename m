Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /NBwGPWjFlsQcAAAmS7hNA
	; Tue, 05 Jun 2018 14:54:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 57D8E606DD; Tue,  5 Jun 2018 14:54:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsq856Fd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CF63C60261;
	Tue,  5 Jun 2018 14:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF63C60261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeFEOyA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 10:54:00 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:39013 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeFEOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:53:58 -0400
Received: by mail-yb0-f169.google.com with SMTP id m137-v6so868706ybm.6;
        Tue, 05 Jun 2018 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CIKxo5ao7x24uHmBt4yAKl8aZP5iO/dECkcNwXPkgo=;
        b=Gsq856FdVJW578SB1omcTzKA13xMl+zIhzlxZ1sKxO66fzRwBWQmWvEpfRc4nqwA8f
         CQVJOEnNgAqZD1/YgqAPYVNFfrDyqUTpjgLGhFQikHXISdXOm7Vg2noW4j6OuTO3K4c7
         hB1yUNAwyoc62CvJrh7O/Ahckj1R1Wl/qH9dQCqkFpd2FdHohVH7k110UES9TOqgRWcj
         H1mw/TIG7tCyDK15flH9ge/DcqT3N7mOtvcmZwLDQLREA/yCcbeMr6OZA9zi0rig/zA4
         VJTSezun3560fT4Wi/n5uVDE7dS6y2uaPm8K/SEgN9PF8E1IfE3OdGcIQPFYGS/7Dc32
         ZAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CIKxo5ao7x24uHmBt4yAKl8aZP5iO/dECkcNwXPkgo=;
        b=rBttUHcjgyGpkoElws09VyowNRaEPJPzA4U6ah0hBtr/6nFAirlkyUVPslrGnQbWJy
         yfB1R3T49WMIQE1M6gYVuhG2VXFbd7KOpv7VJpzTwMfzYPdX8i9HoXYAlzOKMuh9AbIS
         bpCMJMmeueqqmCCi1a7P4SBlX2elYQLqXae6EEIJ+J9oB2SP1yinoIp08OF2r2jSILz6
         le9/Kop0GZ4NmbLyaVoIRyWlCGL/F50o8KGdXAfkX063D3m6Drx8Q+fCmZOQVLZgABhQ
         01mIQFuD9sn8E5HZuINZfzVD/uQubElEeb/mnZ071GyXEN5o6ki8fA9o9WFemsHtjKDZ
         0NIQ==
X-Gm-Message-State: APt69E3rthK06XwE4aMZVlHBDn9qpC9oEm5m+NW1VBi+4XnHvYPBOLZm
        hiuhTwZcbpLJgcWwTpmgiyclI6PydPvfc2a2bg==
X-Google-Smtp-Source: ADUXVKLP7VQ9M4ZODW3MPuTlz+JLgdbj4ZMchqqBC5+zRd0+iIRPHy8qJmdjdqzw+n/BcwVvr3/gcv0Vy430yDHxvvU=
X-Received: by 2002:a25:cc91:: with SMTP id l139-v6mr1621709ybf.121.1528210436209;
 Tue, 05 Jun 2018 07:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180605101741.658efe5f@canb.auug.org.au>
In-Reply-To: <20180605101741.658efe5f@canb.auug.org.au>
From: Trond Myklebust <trondmy@gmail.com>
Date: Tue, 5 Jun 2018 10:53:44 -0400
Message-ID:
 <CAABAsM4sBJukct3Ah7L7h2vg1dxzLWiVsSthk6ZECm3Guem4Pg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the nfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: List Linux Next Mailing <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Fred A Isaman IV <fred.isaman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180605145344.6fUEO4IeQAhxWT6IRj7HjS6DF3Fzdrarun7BhUAGxNY@z>

On Mon, 4 Jun 2018 at 20:18, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Trond,
>
> After merging the nfs tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> fs/nfs/nfs4proc.c:910:13: warning: 'nfs4_layoutget_release' defined but not used [-Wunused-function]
>  static void nfs4_layoutget_release(void *calldata)
>              ^~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   30ae2412e90f ("pnfs: Fix manipulation of NFS_LAYOUT_FIRST_LAYOUTGET")
>
> in combination with
>
>   2409a976a299 ("pnfs: Add LAYOUTGET to OPEN of a new file")
>
> # CONFIG_NFS_V4_1 is not set

Thanks Stephen! I've appended a fix to the linux-next branch.

Cheers
 Trond
