Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FBAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB8A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojn0bLgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB8A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeK0MgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:36:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43233 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0MgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:36:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so7032568pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 17:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4zTEYAzpNZNQReLB1NJZXsZKt1ruriuRiGVGYwLd2gg=;
        b=ojn0bLgM7q754jh/wMLHTJR8LqtkDgpvNeJJBc7aJv8KQf93SSEc63jfWVKWPCsSb4
         Gvb5GZY3vKzulXs3qdfHbvMDg+Qx80oUI7F91YBXIN5MQfDYbpQDGFVU/UrxGYqswaL/
         5sZgsnYhzBkXwcbCamRNCWNHpT/dteXq3DKX4mKiyv1GTB9JjH8eOTzwqrCS1E1x6vzu
         E3YDGV081bgw8j8nN3F8SOr+7L1ozjdK2hb3gDP50lHw+OJMLu4x2LPsURCMJc1tgUPR
         HLdiaXAXbThA7MxzzY4YB7cJueZOiidkSLVPu2+HtVQYDgDAKUw/sNM27sNG5lrx6/Y1
         9cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4zTEYAzpNZNQReLB1NJZXsZKt1ruriuRiGVGYwLd2gg=;
        b=n9ezVyKhi8Qqca1P/nMhP/YaJ1fLPpA/Hx1WvTj1hzmeyp1/GBhCYP+8pwWnFTnnsu
         fpFCaYw3EXLRrA52/TUek/u1nH5d/xnJly6ECyATTZX89PP30aGExmdY4YSDMn9Ncgld
         ts3kUICcqmgKLLy1NbIJmsOGdAsbLpPJg4Mtklqxm/F0m5GyGvUt94c/qXTM4S4th/zk
         B1aVhug/A+oyiXpzJlb2LOx/kKyND38lA+xcn/z1FVon76i6EpWgs2vWoj9lgvGQbcec
         tCqRzrtUDqbFUk+zioAppl1zIpYTpfjf/VCq5j+WuNr8cLObxZOnd9Aa6Yc5ufKTL1XH
         HBcA==
X-Gm-Message-State: AA+aEWYwGyjptOh+dUhpK42pAUHWZ1KHGMJaaT1Fxvz4w03dNzzxIKrj
        OyPHWZESpjpYGCeOn77m6iU=
X-Google-Smtp-Source: AFSGD/Wc/Lv1KuDi2DvFIAu5IxVBlH4TRmSOEuLyF0RLVqrCQdi3infqpRt0GURxCCgFWfUxl1hn4g==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr26651826pgs.73.1543282813906;
        Mon, 26 Nov 2018 17:40:13 -0800 (PST)
Received: from localhost ([110.70.59.61])
        by smtp.gmail.com with ESMTPSA id p9-v6sm2317344pfa.22.2018.11.26.17.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:40:12 -0800 (PST)
Date:   Tue, 27 Nov 2018 10:40:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tamir Carmeli <carmeli.tamir@gmail.com>
Cc:     jthumshirn@suse.de, axboe@kernel.dk,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        bvanassche@acm.org, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] fat: Replaced 11 magic to MSDOS_NAME for volume label
Message-ID: <20181127014009.GA4732@jagdpanzerIV>
References: <1543096879-82837-1-git-send-email-carmeli.tamir@gmail.com>
 <7525d368-62aa-a288-b590-864f78cb69f5@suse.de>
 <CAKxm1-EWENsj5Ug+5zzivASNHVvJQY0DXC09fWn-V7mPiCW3kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxm1-EWENsj5Ug+5zzivASNHVvJQY0DXC09fWn-V7mPiCW3kQ@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/26/18 21:23), Tamir Carmeli wrote:
> Thanks for the reply and sorry for my noob question:
> Wasn't I supposed to send this patch also to the FAT maintainer, OGAWA
> Hirofumi?

Yes.

> His name wasn't on the get_maintainer output, and I think
> that this specific file isn't listed anywhere under the maintainers
> file.

Right. Not all headers are tracked; so usually you'd want
to ./scripts/get_maintainer.pl fs/fat (where C files are).

	-ss
