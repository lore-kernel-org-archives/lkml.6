Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26774C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7A2208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcyPCmYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7A2208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935191AbeFMQ17 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:27:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934563AbeFMQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:27:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so6556747wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qeRLlq+Ca0IShbxghKVyLsTxCCdGcQXzYPbwz/0kpPE=;
        b=JcyPCmYSc07aRhBnbwTRWMquMiLGp964eiWp7laWIcp7+NNkyeKZSTpTiB42CpWkPs
         wOE3tHU+j2QCoZ4JWABeJyLaA0tziDVD9IQicwrS//mgeD7iHf6Fs8gAi4hVh7SSmcBN
         fhUZPbljJPeffmv2VBYE/B0KKUVy7K5NV7NGP6wRlhsMbPQBocoXiWsu4oXfFB3HuXPV
         z+OEx8I+NZO6lpljGRYmHkHPhf5RxY8eaF5NEibK4wpAmcqsbchGolK0x1rvSSqhsQWv
         9RKzKk4m0W5bt18XTth6A4Qfl6nbzXixpGDesgZ39T/xY9sEBk0MNYBA63Ij5wInu9a4
         mLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qeRLlq+Ca0IShbxghKVyLsTxCCdGcQXzYPbwz/0kpPE=;
        b=cuFWP5ovWp543jZThfKVBP1nGZZulZGvQ1o9CYGEmU+MXQhRWkTzn382J0gTCqZdpL
         kefrxx+VHXykGMYIdsinNVzkbkhZLkyoH5ZQN5LMFhLKG+c3nCNFpKGLDVro580gOB88
         XFZ2w8oiyr4yC+ClzcPcSTq1dQZ5w7ZwHy5ZIL9wt80i+RPy2Gbf22A1PEYlv2VR+gxK
         lAVRyszwtk7v7CyLKbT/V45wVC/ghSovAKrD8qIaqyXYMH2bq/Bph2ZsHOh+LfbK8wPC
         YFSs7dS/1ZmePoXAl9tc2Am5FlZm/E182UA+rJEh3bOyIMSJQG4O/S0IwrJEarHCbfl/
         Zldw==
X-Gm-Message-State: APt69E3z3hZqsYcKbvnFwPcMlE0SxTW993/RqdVf+z0pULRKw4MGKPNH
        lYNLKcTSZ48DqLohzlZzQdk=
X-Google-Smtp-Source: ADUXVKLIvFRZxD8vYNTmHmrl+k/7umFxnGiyIo4PDRmEEma/Ez04yIdGTYEp6BaTScHvaWUZ0q4csA==
X-Received: by 2002:a1c:934e:: with SMTP id v75-v6mr4415948wmd.52.1528907277302;
        Wed, 13 Jun 2018 09:27:57 -0700 (PDT)
Received: from localhost (8ta-151-219-142.telkomadsl.co.za. [41.151.219.142])
        by smtp.gmail.com with ESMTPSA id y3-v6sm3357804wro.21.2018.06.13.09.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 09:27:56 -0700 (PDT)
Date:   Wed, 13 Jun 2018 20:26:43 +0200
From:   Chris Opperman <eklikeroomys@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v4] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180613182643.GA14100@kerdev>
References: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
 <20180613092955.vc5impf46prhcur7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613092955.vc5impf46prhcur7@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan/Ian,

Noted your comments regarding additional text, thanks! Just curious whether 
the "scissors" format given at the link below is valid? 

https://kernelnewbies.org/PatchTipsAndTricks

It is given as an alternative to placing additional text below the
cut-off line.

Kind Regards,
Chris Opperman
