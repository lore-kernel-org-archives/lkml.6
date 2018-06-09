Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pLrhFmOUG1v/GAAAmS7hNA
	; Sat, 09 Jun 2018 08:48:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7DDE0607A4; Sat,  9 Jun 2018 08:48:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0rJ3YvA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 01325606FA;
	Sat,  9 Jun 2018 08:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01325606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbeFIIsi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 04:48:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40725 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbeFIIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 04:48:36 -0400
Received: by mail-wr0-f194.google.com with SMTP id l41-v6so15506593wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l4L90ceYozPwTev5VEJ8+yxxlv76jTJtAlwFgqI71OU=;
        b=B0rJ3YvAYTNyFpe5UUy8lsgiuFezDzyZXhW+MrS21/wQnNraY/Ip0JblJnZT8VXdJl
         M2aIDWMrEBUPX7fO7948tVs1DTLKw6/wEVskv9Sw2884+22SaSSDDkwJzgMzcd3wcPpw
         RSBlZAdNF1RgAtOFxmXv6aZt5gxpYmSCv71wyDrHnFXDEzlOie7GyE7wanepRkg9irqS
         O/7MDwtJjRiuJvj48M+6lZKbVfy4ULy3WkzM8RVCVSPq1rq4A4qh/zC7OV2AoLe5cylQ
         /ATCWC3oHGR1ERVVA+kwCJ7qLOl2a+h5oyTcdTbpUVYESSG9/gkusOgrZ+ZsRbFWaffU
         PEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4L90ceYozPwTev5VEJ8+yxxlv76jTJtAlwFgqI71OU=;
        b=o5NYntohLqYD5naTEPKzKkVkqbHjQvMtFoJ43GnBpCwZ00mbsDbQdUfhIV5yMsG8W0
         Q0ks0myKhsLlptUCr4E/YxmMSOCYRNcqu+CgChDgsmlb/jBcGoPNaUSLqm5eSFd6v4sD
         rH1PgM2Vuv6cSvxtDaNn0eimahJW53qGhONxurpWdm6Kp84WY9SR+ATifLVQaIcqMgNq
         OPNpLCbMVjOIaMX6GXkz73MHrjDcaR3gohA3mnAK9WN+dgiBWR+OECAO1T3veNZhZoTJ
         cs5m/pEd8knFUNYT+tM4es+y4tuUNQeqJw47T2yq2CJO9MePTXFMDrZi/8arSWVq8zHa
         H8bg==
X-Gm-Message-State: APt69E13dABFdtmKLvjhyFErilX9CSf03l6bnFWlhGik4SWRsDO9RwOu
        g8c/LsmwBa4LqQ/eSC8Evrg=
X-Google-Smtp-Source: ADUXVKLRwbmq8aepure+Zhrq+3s3q9+ChdXZBKH3dWXMS4Q/D7bReAJMI1n39DxuOTHGmTgy1knZ9w==
X-Received: by 2002:adf:a54a:: with SMTP id j10-v6mr8073393wrb.155.1528534115451;
        Sat, 09 Jun 2018 01:48:35 -0700 (PDT)
Received: from localhost (8ta-150-94-26.telkomadsl.co.za. [41.150.94.26])
        by smtp.gmail.com with ESMTPSA id h193-v6sm2740250wmd.25.2018.06.09.01.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 01:48:34 -0700 (PDT)
Date: Sat, 9 Jun 2018 12:47:12 +0200
From: chris <eklikeroomys@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] Fixed coding style problems.
Message-ID: <20180609104712.GA1366@kerdev>
References: <1528483959-23158-1-git-send-email-eklikeroomys@gmail.com>
 <20180608221154.zghkrw5sc6zjtmaz@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608221154.zghkrw5sc6zjtmaz@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback! I will retry the submission.
Regards,
Chris
