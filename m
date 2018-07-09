Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1146BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23232089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzQ5tRFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23232089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933506AbeGIS46 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:56:58 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35877 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932738AbeGIS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:56:56 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so7607629ybk.3;
        Mon, 09 Jul 2018 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x9GwvneSUkw5UC+lzeiLpn8sydp3IJ2Wo1a2hE1ANUw=;
        b=XzQ5tRFz9CNuikSqvRH7s4nHnK+MVTvDCCEuydkzZevRf7VWUAyxty6elWZMw4eJ2q
         f8oA3eh7xhSglZL4Yw8qzku/zFfKqknc9M9N+LjdTWyEIJDZdt+IMHGykkIbaDksBaHO
         zcpenpXGeN2qvpThCwoz5pmnFd1Gu3uU/go1/anjDUDFcJ9OUhF6P65IxHcB9xMVXSkv
         9pZfr2XFfmDNQ7SFj+E+GGkk2XR0AFQrJR/884RvjqFYSvGOa0G8uB2F4eeQUv+HUfv9
         SzAb1IS1VPqco+jexiqUZ8KBczCKOoN3DFvRurWabEEPtZ8ms8e2Z/FlyAdz4YcutsFd
         jmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x9GwvneSUkw5UC+lzeiLpn8sydp3IJ2Wo1a2hE1ANUw=;
        b=EASdWRk9Xs3U2ngZ3QwwQtbyY1Tn0TXgKS0NniN/aajNPStMOZdODnN5Wu2GgfrbOZ
         GI9rS7HXToitPKgPbyBwHs5VZd3v2h6NF6IPGL1tQLBYGebTsd5z9TKD9fTXAOqDiQZQ
         An/7rptIsyi2tYoJh7e8AdbzI4145/xfN4oylxh5nbb1qcae/4MOsXxgNR829/rI5nWI
         jNIfVBMs9gRMQuk40BjBwvFDHTta7YqnhVIdZre8iGeACuBbGnNFUbtQXdgoXliJLozP
         SgTtZoJ+RwNFJ9jeaZrTmFlPsPeYFfiw9gwDdK21M4F/xPSIMBrUsiRSzX2kI4VXWzwd
         F2Xg==
X-Gm-Message-State: APt69E2vuaeIWoVtI+HDKna7pr5xo9RQthNnvXN6TbHh8zZOJ4agXrXg
        jWuZdqHnU02mRjHoZrKkoTs=
X-Google-Smtp-Source: AAOMgpckchofqe0UOWJua17FkMVbnFnhii6gFc13V7yxJDAHH7DGgGE996DU93iTuGOZ+CCcoDlSug==
X-Received: by 2002:a25:3a45:: with SMTP id h66-v6mr11349682yba.360.1531162615935;
        Mon, 09 Jul 2018 11:56:55 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id n3-v6sm603607ywh.14.2018.07.09.11.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 11:56:55 -0700 (PDT)
Date:   Mon, 9 Jul 2018 14:56:47 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
Message-ID: <20180709185616.GA30783@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
 <20180707151622.GB410@kroah.com>
 <20180709174026.GA29186@sophia>
 <20180709185417.GA17528@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709185417.GA17528@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 08:54:17PM +0200, Greg KH wrote:
>On Mon, Jul 09, 2018 at 01:40:36PM -0400, William Breathitt Gray wrote:
>> I'll make the updates noted in a version 8 submission, but I'll wait to
>> submit it until you have a chance to review the rest of this current
>> patchset. The counter device drivers in this directory (104-quad-8.c,
>> stm32-lptimer-cnt.c, stm32-timer-cnt.c) should give you an idea of how
>> the counter.h file is used at the moment.
>
>Please do not wait for me, I will not have a chance to review the other
>patches anytime soon.
>
>greg k-h

All right, I'll go ahead and proceed with these changes for now then.

William Breathitt Gray
