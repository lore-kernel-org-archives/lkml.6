Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9432183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2VMm/GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfAGOsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:48:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35285 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfAGOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:48:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so277648pfi.2;
        Mon, 07 Jan 2019 06:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JiRNgDqLcXa6QXy2/b0Y3bhC1VyiNB/lPe/tkkAhYiM=;
        b=k2VMm/GISBT9LqqZ7PKcNNVtnkWslHBidoDW6YIZ3fRt8vrZjA20jCVxGhEOpcZdEX
         SSygT+fhsiiWo4xRyFMr2LYbQSJBz6GgCXBDYiR7+eySglMQXHaSQ40ZeGUR5L8ABVwz
         fHqEawrXlb7ioZp4W3MSfU8pfJkPONusJd3jCty5Ksdhuc6WIpdRyOKMj0HdRmUeslf2
         Kr5JfYKtQDLPPEeo5MFlFyEr5kbSIf/EP/+seXe2TLbUCweFGXw/ND2ebvIZiSPOou/Z
         hDo2FK+i4euo1HUJMJf21WWSbTIZoVSgxLyAxzD2Umh8gGa9iiFuhWVoP0r0S6mHjzUe
         eEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JiRNgDqLcXa6QXy2/b0Y3bhC1VyiNB/lPe/tkkAhYiM=;
        b=YW3raB/Kv7b36FwTVK9b9e5fdo4h+ONzEHcJ9P2WFyJ/NV5ycloW5Z6X/nIY5C33RD
         bgpKCZvpxdzJZnzqu2aPl+EqOFUzjV0ymfCfKkbdh5/esVwsxrFJd0rURIrvz7G+nK+q
         IsgZPorCEAuMPr5nMQxIsN26rPNEiAAQG+BJVPbDU6YEtQhSznTu7VShU8FlqzjG5VE+
         yx+Kxwe8qfYQ5z527vnNYaS8DoAafbZwqLuR5q33tcJBFsx3UhKKrxklLLMBWt54qL+T
         vZK8xUaFH5hF4hkM+ILSjHBI6A2DxMkw7eitILpy/OHLriizd+9/Mrvc3Jk0WcZyVIpA
         T3qw==
X-Gm-Message-State: AJcUukfGA/+Ej2ouXRpooIU3/stVVNK+wWNbI9CnYR5gzDSEaj+Mgx1Y
        j8GOMPGnqA3+eqmSFGi0dWY=
X-Google-Smtp-Source: ALg8bN5zpka1L9RApT0epFIsIhndGfemXNYGNmH+t2NJbg/Yxk2yaGfMu5M4wYpQTU/SbXZNqT7v6w==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr11302613pgh.164.1546872494325;
        Mon, 07 Jan 2019 06:48:14 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 6sm140792297pfv.30.2019.01.07.06.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 06:48:13 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 7 Jan 2019 23:48:09 +0900
To:     kbuild test robot <lkp@intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kbuild-all@01.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] ia64: tweak BREAK_LOGLEVEL and RESTORE_LOGLEVEL
Message-ID: <20190107144809.GA968@tigerII.localdomain>
References: <20190107095433.6497-1-sergey.senozhatsky@gmail.com>
 <201901072128.HGGbw9UZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901072128.HGGbw9UZ%fengguang.wu@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/07/19 21:26), kbuild test robot wrote:
> Hi Sergey,
> 
> I love your patch! Yet something to improve:

Well well well, guess who didn't compile test his patch; again.
Thanks for the report! I will fix it up and resend. Sorry!

	-ss
