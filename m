Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986A920C07
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk6QEKpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986A920C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933353AbeFUPzZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:55:25 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40723 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeFUPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:55:24 -0400
Received: by mail-wm0-f54.google.com with SMTP id n5-v6so7052084wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N1wLaDHlwUfDM6O9aqAHWjLWWZb5lL1Xjq4I4qcXtf8=;
        b=Lk6QEKpEpKqsW9CkPyQQ6hSWIbp5+udW1x2YBW4tTo64m/cKFFraRQ2u748LgR4j0P
         5/YRW4XA9CGGHUzCIZBhrlpPdqSCrPMrjcZR4ij9BJViYqt1lBzBf7i+YFglIEE0MHwy
         ry2Z0zDZP2M2VB48F7v5nlB3LGUOiw+qO5n9NiqPZv5EbuVs8G/lWbVVAgULcI8tsZUD
         NN9ho1IS5FSbjfY+7Yu9iNpTrZr9SXzTqgm6MW+q3c1upZmMnzE3+QoT2hsA0ArFHAEO
         uHBh6YuMl3IYOWEF571EBj3uNE7tbzrNJVvFu0LHDyukXEnA94ST+lm7KuzP7QTPSTja
         VN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N1wLaDHlwUfDM6O9aqAHWjLWWZb5lL1Xjq4I4qcXtf8=;
        b=mTmABgLDMsrBsGp1A1/ag785HvF/xE9q7wGRAsPWZoNKeXRVEtWZArQIhyt1FQiAHi
         kFgaqmmh53Q8e5In6oDMflqdGnOVjlDjyLZ9lsczkIhn42b80g8GrdsqVVVQ3SABzDzD
         O/1y9NF+7x67zhUkSqCi2ytnDo9LXY+rJZROn+IQBkxgl9bgqCwEYUqRMOZBo2Bpp4+k
         9KkXgUpHhABlmkdhSDEnicMTUH68u9WpzUDKTmX5TdsKwRz8vK9pWpioRJEl3uNlirnB
         q5kvXllUlEo0moh0PwSa2vcQnOoR4v2z1o91Lb6hCZ2shqcjTSUGtvJ1NespdWdgeEOK
         d8yg==
X-Gm-Message-State: APt69E3FlvG+G9tS1ESx58shtNpe+Ewb3T0DmHyrTQQ8em7qF0IWmQYU
        kCaWUBI7qdJaRXh3On/woDA=
X-Google-Smtp-Source: ADUXVKLCepfjfXQWMW0WuYyZEkZY+zyht/3KFIQIIkVTQV0m3/gUj022fXujBrk5Ad5c/VHWu/tYBw==
X-Received: by 2002:a1c:e546:: with SMTP id c67-v6mr5445953wmh.108.1529596523020;
        Thu, 21 Jun 2018 08:55:23 -0700 (PDT)
Received: from localhost (8ta-151-217-222.telkomadsl.co.za. [41.151.217.222])
        by smtp.gmail.com with ESMTPSA id b16-v6sm8470155wrm.15.2018.06.21.08.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 08:55:22 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:53:52 +0200
From:   Chris Opperman <eklikeroomys@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] staging: wlan-ng: improved readability of function
 prism2_add_key
Message-ID: <20180621155352.GA20712@kerdev>
References: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
 <20180620200829.qm2zxeyyl5kqh6gu@mwanda>
 <20180621044252.GA19583@kerdev>
 <20180621082225.xuhqvm7bevbiuaso@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621082225.xuhqvm7bevbiuaso@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
The header also states "DO NOT EDIT OR MODIFY". As you suggested, I
will rather leave this patch for now.

P.S. Please advise if there is anything specific I can help out with, or I'll 
keep looking for more obvious fixes I can make while I'm learning the
ropes.
Kind Regards,
Chris Opperman
