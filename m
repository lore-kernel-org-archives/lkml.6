Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC83C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0962D21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCTJNLys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfAKGKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:10:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37929 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfAKGKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:10:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so13866127wrw.5;
        Thu, 10 Jan 2019 22:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L/iotYi1UnvAborjb6KMRqYSwxpEZRYKhqYyPDgZMGc=;
        b=tCTJNLysNUZ306PWsot0o9msllhJRRRaccpVt/AhM6R8SbiSfiSfxf7JachRSTYc/u
         F7W277/KnAdSMzQkSLvd1x1y5n0QzqTywQm5iIlEQUqoo1jgw+SmRNDKpEbBAyYjzv4j
         zZNcU4+sb0Nnc6wmssYx/ROmEkJz/68M8YZKyuSdPfVXXXbNVSenH9H0aJwnVH+HtDw9
         DEf+dUeg9sFd79s8b0mdT3z/xygx1Y/5OvbuyaX+sUuG220mvEGZK5pL6jFjxlJ4jnQS
         re2I5hLDYEKA1PwUr6Y329oR/hobSnxFXW51Y5+40Rq55w7dmh6YGX3++NnFApS/ism7
         afuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L/iotYi1UnvAborjb6KMRqYSwxpEZRYKhqYyPDgZMGc=;
        b=Wbn3mVa9iMTSq+xH0ygilh0x3B76QRb5RSh6MyH1W6zHqSAnhb0e3PfoLDl1oGzDj1
         Au35VC1J01XOaT5Nz/Fh7A+zF11nfixrZTV7EhhWAt6faKCNzWp4hHGARNCRj1knAoaG
         1Gim8dH893eSy/LjfFpEQ7Ub8TnB2nBqswgjYvT86jE9W2KXyeRwIurUr7ABpfc25gnx
         xRkmYDG5Ewcw2S9Lus8wxMb3aychOvOIuXYp4U11hDW9RCDmpHcnM/9Vz1zJvhcqMT7t
         7NQffxMHaTw1BKMtzIhGRZKCOjQuOhjxRdLiA5eM9fQm3nP7QiOME+lXm3SWXMYC6AiZ
         P6bQ==
X-Gm-Message-State: AJcUukfcjXo+YdScfRnU9YuRx8a2sfPw/GeQpX9zr15eSX7eNpiQmkZI
        z0h+y901nwUEoqoAW7yF1plE2RkS
X-Google-Smtp-Source: ALg8bN7R9+tCo1iBpSbWDPo72p0BfdrYaGw9VsRvhhEylhzR9WsRB9aTavpt9Y0rgRK6B+AuF6ZzTQ==
X-Received: by 2002:adf:84e4:: with SMTP id 91mr11865073wrg.237.1547187029592;
        Thu, 10 Jan 2019 22:10:29 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:e930:1d02:8fe9:d67c? (p200300EA8BE2E400E9301D028FE9D67C.dip0.t-ipconnect.de. [2003:ea:8be2:e400:e930:1d02:8fe9:d67c])
        by smtp.googlemail.com with ESMTPSA id c202sm20146367wmd.40.2019.01.10.22.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 22:10:28 -0800 (PST)
Subject: Re: linux-next: Signed-off-by missing for commit in the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190111144818.0fe8bde2@canb.auug.org.au>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <685063fd-a1c2-954a-db1e-b1339ad90e15@gmail.com>
Date:   Fri, 11 Jan 2019 07:10:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111144818.0fe8bde2@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.2019 04:48, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   b19bce0335e2 ("net: ethernet: mediatek: fix warning in phy_start_aneg")
> 
> is missing a Signed-off-by from its author.
> 
I suggested the changes and Frank prepared the patch with me as author.
Therefore:

Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
