Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFBCECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8744820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKV3fAzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8744820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeINRYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:24:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeINRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:24:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so4119087plp.7;
        Fri, 14 Sep 2018 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u4mrFzQch0+fNESchU2ZODdGxUaktajvU+olTbZQQCI=;
        b=fKV3fAzH+C4kXo8xJIs8JjdIkNZuw8XrKt7hFm4+z2ny/tKxQ3pmwWkOqB1vSYwkzo
         vwr3HbUjMxtBamFc8L6FdK9kxC4LwJ1syComG2S8IzjynmcIbvJxrn6qeI1Vh3WDHT6a
         xErp+iWiNEUJ+6SNKB+XH4ifThNe0Oip1KkzquOjHAY0llh9BC4B8ADHVaaecvO02NjZ
         CtxDABd8hi94TQdWbugk7nrciVV6I2ynFzNcUPnGtjD0/oT8VOiaYYX3x3FwqB95AK5D
         ktp7tc2JxB/E055xrZpETKLobL6ndCHBQLl/N40yBDn7YyZSQTF51fAoLLObacU/P4NL
         hvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u4mrFzQch0+fNESchU2ZODdGxUaktajvU+olTbZQQCI=;
        b=A86kvfAne5BbKN+79Vo4XeJRx92xpLCCI/g2yarD6wK9dp1aaHkZskbMNeWi2iNjdQ
         k8cMNA68Rqom0L6BhKZzt7eHPB90y8AVLIErxbqao7xj/VkO8bfpMnJ1KiVKKVwf2rn1
         +XT3HJs4hr9PTpTO/uW/fb3wxXPwnl3Y7vyq8Lsxrk2rMDTWHFmnEs5uixh7eFAlzqwD
         KiPl6Qa2n7l/XVhXzARpGYxIoQf1jDVLIAu/YKz8+36uAWeQaRwiu1x1eyyktP+dhNy8
         qc/FZSdFSzg6AC/NQiZC0if7PlnrUAP2v/9LjgyRyvl4lfTo48Ay6v4UMcuMZqz/30AX
         K66A==
X-Gm-Message-State: APzg51BP0updN4DCl3LeADIdx/ibCt0FPArMKSATpSeVOc5AvmWKUEwH
        zdmP2qf/fMv837SQAM+H3rM=
X-Google-Smtp-Source: ANB0VdY1O3ZlFkg9pCNP2BQpKC31Fp+JjmYzDrMIIBmZDijQ/lX+P2Q9dLNQjSZRUHw3A4lLh7+SiQ==
X-Received: by 2002:a17:902:a716:: with SMTP id w22-v6mr12053146plq.334.1536926999082;
        Fri, 14 Sep 2018 05:09:59 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id f75-v6sm11572424pfk.85.2018.09.14.05.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 05:09:58 -0700 (PDT)
Date:   Fri, 14 Sep 2018 17:39:51 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, matt.ranostay@konsulko.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: Re: [PATCH] iio: proximity: lidar-v2: replace i2c block access
 method with the one already implemented.
Message-ID: <20180914120950.GB6465@himanshu-Vostro-3559>
References: <20180913035145.28056-1-songqiang.1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913035145.28056-1-songqiang.1304521@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:51:45AM +0800, Song Qiang wrote:
> This driver tries to access a block of data on a i2c bus and it tries
> to manually make a device command frame and a consecutively read frame,
> then uses i2c_transfer() to read data. But this has already been
> implemented in i2c_smbus_read_i2c_block_data().
> Sorry for not having this device by my hand, which is a little expansive
> for me, but I have another i2c device and tested with both i2c_transfer()
> and i2c_smbus_read_i2c_block_data() and they all ends the same.
> I'm not familiar with the SMBus, don't know if the lidar_smbus_xfer()
> function is the same as i2c_smbus_read_block_data()? The original code
> is commented with something I'm not sure, but I think if it's a standard
> SMBus, it should be able to use in here.
> Hoping for someone to explain.

This is not how you write a commit message.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> ---

Your doubts/suggestions/rants all should be here just below
the `---` line, so that if maintainer applies the patch
then your queries doesn't get included in the commit
message.

And no need to reply an explicit "thanks".
That is implicit ;)

We already have a ~30k email traffic on LKML...
https://marc.info/?l=linux-kernel&r=1&w=2



Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
