Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188FCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D2622ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTmQMINH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D2622ACC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeGFV54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:57:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45186 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753905AbeGFV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:57:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id y24-v6so9399588pfe.12;
        Fri, 06 Jul 2018 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u8lMamAKkcTosnb2ZXqMSuaXBPAjq4Fe8bFCSCywB3E=;
        b=fTmQMINHdjZacV8EdsIwSZzye35NjsYiXZ43SOIT448Qx/SAUbsZ6WY5i87DJp93Kl
         IsElrJreV+rTNt+J3MGMAIAqZ6pFZ1XOhZ9A3yZZaT1gTvvGJQ67wsjJHKS0OxlVFbt9
         The1WLFp/6FNzT49GlBpGTOGSsArte6TNlvG3EAXIuaF9cG3YHktQmSXhwwCQ1JlQYgk
         4uUmxLLcfcevBO+xohkJd9EkwFRUkaDFhiW3lsyg40+Mg0RJ/mR1Pqf9wBH3duduMfJe
         wVBeLM2LSkFKqFVZrAayjpUaC0mA9GqimhNFE7ljzSu2+Zcx5+naMta6RTIVEJph4lCn
         6/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u8lMamAKkcTosnb2ZXqMSuaXBPAjq4Fe8bFCSCywB3E=;
        b=C9AINXFjL0u7qldLBTn/PRDJdaT1yl6ypq4v/fAr+UQO2ISJsHs0zWU8oV85Bv/h6S
         jHjEuwXOuCFs0V4r+MYQdn77ojDDO82V6RDjta9ga/tdj+5pC/IHy3HLf+Bzxd40uXzF
         aIHsvfSJ72zdoNP4mc+OeoIjKZs8icvcSHxWoBJyHTx7wKupaSjD6sPIZuMfi9DCHCxr
         W7QBtLXmh1P2dACIlRKuloh03TRY0WaPsAFS4+NWxkAvkkYAKgm+9Z8f4WJbLE4hkJLY
         6tMM8zBb0D5rQsizdqtLtQ6nVRkIwszzA4f7U1tB/pxJOfNjMmkIlWH5f5rutAPxAlrQ
         Pw0Q==
X-Gm-Message-State: APt69E3y8eIaTFH596080sI1JrMgi9wpyBt6IqTP4FbR6AWOJq+JzXbs
        gP4LCtID/NSkDWZbjOa1PjQKQYWl
X-Google-Smtp-Source: AAOMgpdE5I2I1nZI2d1IEi3pBSw1C1WtipjiKibS4sbilFn4BMijCuP6xFSKkgaltiIo638QaqAhFA==
X-Received: by 2002:a63:f948:: with SMTP id q8-v6mr10565481pgk.292.1530914273480;
        Fri, 06 Jul 2018 14:57:53 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id w11-v6sm18625536pgm.82.2018.07.06.14.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:57:52 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:57:51 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v3] AF_ALG: Initialize sg_num_bytes in error code path
Message-ID: <20180706215751.GB109361@gmail.com>
References: <00000000000092ad87056950ef9e@google.com>
 <1616306.R4SzcgHSdy@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616306.R4SzcgHSdy@positron.chronox.de>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 09:50:55AM +0200, Stephan Müller wrote:
> Changes v3:
> * Fix syz testing line
> 
> Changes v2:
> * Addition of syz testing line
> 
> ---8<---
> 
> The RX SGL in processing is already registered with the RX SGL tracking
> list to support proper cleanup. The cleanup code path uses the
> sg_num_bytes variable which must therefore be always initialized, even
> in the error code path.
> 
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> Reported-by: syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com
> #syz test: https://github.com/google/kmsan.git master

Can you add Fixes: and Cc: stable?

- Eric
