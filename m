Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F381E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiZfuyeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F381E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeLEKUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:20:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44470 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeLEKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:20:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so9775030pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LLv4rQwGOTYyUO6wQYGMzXJ1dqbaE+LSzSrL1QOnafc=;
        b=SiZfuyegSA8Hghw1j5oqSsoIy5RFG6tTp4b5WZYUcSD6the9auDtkQqivNw3rapSyZ
         kjBnAW3va3RlKZf58h5IE2lDg8ZmRNFBvTTL/USCpiRbrS6aj0oZKl3QyGmuJnU324Ad
         lBs7K94cMci+Coht+8a4SH5RPm4eGq/iVFfdmAp0FdCMqG36tvsK5R/RUHEryAWALORd
         CndFccR6GK/8nINWI92vVNMMOQ9RtIo3cf33TbIr2EMdQn8wu2gwBCzHSl5nUTNUpp62
         kEU1Q22zdD3rZ6rh6N+IWj4EYxlptTeCZk3nLmbek9appM0O2W2vTwS/fMInb6PewVYg
         3cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LLv4rQwGOTYyUO6wQYGMzXJ1dqbaE+LSzSrL1QOnafc=;
        b=fRUrq5bJPJATxGnbZqqHzVnWZcakTkf/LW0cILueDfy25zndRQjh1J3masvc/TFLWW
         k4ZbW/Qbt6xr9A6Pu6jisWEGzRmbPmwi36hHhZP0bnKM6piDXTsRpKerXbXjw2zgnqPh
         k11o2HKnYt1lypTjU7xyrysvwLZlSZ3FPwWbTJJSyNNwzZ6Xj8ThJv1buAR7QMZ2+k2y
         s4lnAxdgFWqAqzrgg6uyxUpbWhdWGXNmCvLXM0Xgrf9Q0XHYZPo9aPycF41Rljg5Y5Il
         ZFnhpgwSjZZ4FzVaFgkix9623EVzZ9url5ykPRiPq7KcFZt1vHLsDDa75yOCUGztJyb6
         nDsg==
X-Gm-Message-State: AA+aEWa9W4SQ8fRCfufHUH97gqc9vgE2WKgQMgADxG/UZJ/it+y3HZtY
        6UqriV3j6nXYw2F/39EKsZl7TqwE
X-Google-Smtp-Source: AFSGD/XVyLbR0YKejwUm/AFuKmcfM7sAICOLjYl2TrIt728EU3Y3kkdljoLvaIScLxkmkoMPV3kslQ==
X-Received: by 2002:a62:5504:: with SMTP id j4-v6mr23813625pfb.166.1544005205257;
        Wed, 05 Dec 2018 02:20:05 -0800 (PST)
Received: from localhost ([110.70.47.191])
        by smtp.gmail.com with ESMTPSA id z14sm26820855pgv.47.2018.12.05.02.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 02:20:04 -0800 (PST)
Date:   Wed, 5 Dec 2018 19:20:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 0/7] lib/lzo: performance improvements
Message-ID: <20181205102001.GA453@jagdpanzerIV>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181205073029.GA30820@jagdpanzerIV>
 <c4a9e85f-498e-337a-5bb1-b9c5e58acacd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4a9e85f-498e-337a-5bb1-b9c5e58acacd@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/05/18 09:50), Dave Rodgman wrote:
> > lib/lzo/lzo1x_compress.c: In function ‘lzo1x_1_do_compress’:
> > lib/lzo/lzo1x_compress.c:239:14: warning: ‘m_pos’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> > 239 |   m_off = ip - m_pos;
> > 
> > Care to take a look? (could be false positive)
> 
> Hi Sergey,

Hi,

> This warning (it's a false positive only seen with gcc) was fixed
> by v4 of this patchset.

OK, cool.

> I've just tested the latest linux-next/master (next-20181205)
> and it doesn't have this issue.

Indeed.

	-ss
