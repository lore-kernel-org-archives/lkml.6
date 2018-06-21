Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3439D208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R5ntSLCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3439D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeFUOH3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:07:29 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36677 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbeFUOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:07:26 -0400
Received: by mail-it0-f68.google.com with SMTP id j135-v6so4950228itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NOzgmJAwMuEF9HezX9GzBZgjJCQiHmfEhnuiWJj8Wbc=;
        b=R5ntSLCOTvOBnYK/zsrlv50MaqRKhnLeGsylBYBzyTRify0OHgyXAZo5WiW0OTW5WW
         FkVgGBMQsAEmY6rl67/6A16gdUvx1sryDZLKOpOfZSoDTIY3AsxTygxoMdkWusQ0Wsll
         8J0LKHB9pWGS9tjkMH5+7Gw21AaPy6dnQBDdlx5CoAeWKKNZvQ4u4qlu/eX8Fnj8o6yY
         H5JtA5ftp9dbNqtDllufEiTOfiX28EcU6eCFtOxYUdc3s5wxrUg/Gbqbr3HXdeiqnPHC
         ZwG9Rzw9alFjcF839TDi7Br++pMEE5h534plmfFYjOZxeW1DIU+Pq2dYDlk7ptYIFhcg
         mFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NOzgmJAwMuEF9HezX9GzBZgjJCQiHmfEhnuiWJj8Wbc=;
        b=J78dm6nMSxpU09ykeEW9Jt/l1cLdsTQquhZsrBFudC3NL6bNwZMvz63SpBf+Xjbdkh
         rvHXcbhRO8YWu6rob18QMYtAw24QezwNVEIenCCH/12AcagtPx+nvtxiT+0HZQoahHO7
         2+j2RSXzRqk21Go4etykQ6oaTgoPOpLoSHml/pfNovKoXwBYcP0RclO1GPiz7hrvPhBM
         odZIlUdGiExs6ZjM+GMhdeVBvrFQLy7pbUVyZMJ+1C7oIK55Z63uNwxfC5PDe97lTBfD
         rYnHYooCniBVd604DtemoFRkfjNLLHx9EMkN1exItxswsogMpQV+wMQQuQh4yx7WPMwl
         ZkKw==
X-Gm-Message-State: APt69E0J6Nyg4qy4ZLUQF4UWLQd2O0n8jkw6JHG5tiIHV85EcIkOTape
        OtoAVfVU94kt6V7OQjL5qDTkrg==
X-Google-Smtp-Source: ADUXVKIc6Uye2tIAagjTY8kkUY8Jn+AbdKhoQPdB34PPtehVxKOfBx9lWCY3Nbe701D0pN4XZrXEOw==
X-Received: by 2002:a02:98b4:: with SMTP id q49-v6mr21030655jaj.122.1529590046175;
        Thu, 21 Jun 2018 07:07:26 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2598579itb.26.2018.06.21.07.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:07:24 -0700 (PDT)
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dgilbert@interlog.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        security@kernel.org
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
 <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
 <20180621123431.GA558@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36a641db-fb1d-6c4c-7f1b-172f2b1cde32@kernel.dk>
Date:   Thu, 21 Jun 2018 08:07:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180621123431.GA558@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/18 6:34 AM, Christoph Hellwig wrote:
> On Mon, Jun 18, 2018 at 09:37:01AM -0600, Jens Axboe wrote:
>> It was born with that mode, but I don't think anyone ever really used it.
>> So it might feasible to simply yank it. That said, just doing a prune
>> mode at ->release() time doesn't seem like such a hard task.
> 
> Let's try to kill it.  It is a significant amount of code, which does
> fishy things and is probably entirely unused:

I'd be fine with that, if we knew that nobody uses it. But that's
really hard to figure out. I did see Jann's source code scan, which
even if non-exhaustive, still shows at least one user of it.

How about we just make the write interface sync? Then any copy can
happen while the we block the task, and the read side is just
copying the header info back, or dumping it if the task didn't
read it before it went away.

That will still be functional, just not queueable. But that's not
a huge concern, it won't break any applications. And with pure
sync issue, most of the code goes away anyway and becomes similar
to the sync ioctl.

-- 
Jens Axboe

