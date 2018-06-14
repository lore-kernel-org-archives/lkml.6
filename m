Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4566EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDB9208B2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjL9abGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDB9208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964829AbeFNQTI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:19:08 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50953 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755214AbeFNQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:19:06 -0400
Received: by mail-wm0-f45.google.com with SMTP id e16-v6so11545624wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z7Idotg3ND735rVDl+d/Xu5Y8syjqRB7YMDQLdDGy98=;
        b=RjL9abGdLr56qVb8EW3UMhQ3HXdUOR2JljjsVH8IZcmrZH7j1d1cfCOCMaLjG0j1ik
         IXKN8DJDgdBZmozYfTOaaR74N/fIPZH6Zlvzs8NhRvSRmDAMmuLuNAEbf8PuAXgtDajL
         nqxuapaWS3oR4Ugs7dPWtV7Xcm7b46iW9hoerXNHAWsNHL1qO0l8om9wNLLucb3Xsdum
         fH2KuSE5i/GqUdv080EdsDCmMv5VxnZXr/x3juAptOLbfzS/L9NF6pz2H6zskjlYTB0R
         zCUNwq09/oLEd2gWfyJZMAYYjl0n5HnUC4eYf4zVZiganUDIN0IKsn9RmokC6pZmiXqa
         ur+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z7Idotg3ND735rVDl+d/Xu5Y8syjqRB7YMDQLdDGy98=;
        b=DVJZdU29tZFhdnft4suyA5RhbYIwPd7zM2FljL1whSUHMnAveuk8z5SQJCSyO6huUj
         qQnR4AUqcOs6r3G9FBPymBeF8YjyERqyhzRnBzpAti60jxQL6LV6BN+/ahDtwva9gRno
         U1yUGrEQTDgDj/7LIxWOwI4x7MJ7A11LV9mx6M/GS7/s49b0X8YjSA+ELCF9RJkd1htA
         y6oyQJiZJyTYQnlVRwmhBJ1LqpVD5hJJelTtcnCsUPcF8NP5EMvgrUb7kpjPj8V6HpKh
         cHVcBekeFcabmUNyxdwoDsN7NnbsKxEMqZ2eitCFrLDqgBFxPt4K+YVtMkY7iX2nB752
         93bA==
X-Gm-Message-State: APt69E0Zma29Zm1JhPtOTixfLiw51u35KD2NlVKZ1ERLvd7DQy9ZbzV4
        6lkWv+FsmS2Ot/o0xOViegY=
X-Google-Smtp-Source: ADUXVKLeBErtGE4SZ0hDQ4wCNJS5ur8tExbt8oprt4y0xnyy1djzboWkKCQlHJVuVG1qCfmk+G5hIA==
X-Received: by 2002:a1c:8c55:: with SMTP id o82-v6mr2310429wmd.60.1528993145529;
        Thu, 14 Jun 2018 09:19:05 -0700 (PDT)
Received: from localhost (8ta-151-219-142.telkomadsl.co.za. [41.151.219.142])
        by smtp.gmail.com with ESMTPSA id a9-v6sm5393267wmh.38.2018.06.14.09.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 09:19:04 -0700 (PDT)
Date:   Thu, 14 Jun 2018 18:17:18 +0200
From:   Chris Opperman <eklikeroomys@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Koskinen <koskisoft@gmail.com>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180614161718.GA3846@kerdev>
References: <1528910104-1360-1-git-send-email-eklikeroomys@gmail.com>
 <4c33a400-f840-0a21-efad-2a9318dfdb09@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c33a400-f840-0a21-efad-2a9318dfdb09@mev.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

Thank you! Are there any more steps for me to take to complete this
patch process?

Kind Regards,
Chris Opperman
