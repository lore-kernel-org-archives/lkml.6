Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECAFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460E92083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YTRmEkn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460E92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeJSCti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:49:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeJSCti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:49:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so34813451wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LuCsN7zRGi4kWhgVN+m+FPdRHfcPPRaDX2ba9R2oHrM=;
        b=YTRmEkn4Spva36U1ISIHENqGrRgYZI58zObIKO4X56FWZpkaYrhJ33punKpP+fDHEb
         zUP6rdMILsrNEs4vOok/aNriW0NkzSER13xsofRHUvUHHWmavT+ZoOcvTbp1jxN4o+Z7
         ySU1dXqTQ8aVdHJiBkAdsjdN2X5807r/me6d7hfkTk3mCB6xXLsVGw1qEHjCgeBiv474
         n4nGDGSBW45TxjcVoFYXJRQIHOgOGVNZhzya59hRcw8O1gvCSkM2vNPLmipVvwguUe78
         /mqO9f0jNjYTc6Zml/PUMb4VJAuORPRBgjDMQsbhdZkDmgC/jn1T/v4+FgBHlOOSTm+M
         0AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LuCsN7zRGi4kWhgVN+m+FPdRHfcPPRaDX2ba9R2oHrM=;
        b=CvatpNBofzWDhuJEK/IFKBVhyfelTJ0x9Aua5edU68hKMlWxtrqQad7KfYbU3qhsAG
         WL0MV/ltyuwn6Wki4tBBoGzBXD7hnRl/+kFnrYok2sU41SbqoG0sN91B5v2w9dvrGWKd
         0q0zg6LE/PvYdkGCgbeE1NvwhIheslMwmunlvrx8xhxKm2vbfINfTYhoc8qm6TysJ2hT
         cBw6HbzmCYDfd5dVsycTx4qVs5xRdQaSHE1xiVepKZic5nLvHMoT2xcc83Du5PIv7Uxt
         Ol46Xqn1fP5v/A6SBZj5Fz8YAZBuaxG1uGHofg65bUJsFX2rQeZF6aeV5bHTTEn+qqag
         ZLRw==
X-Gm-Message-State: ABuFfohMZYWSO8qmcCs+GBhb85hIk5egb4rvkGo4Jae2jBhhPnqsgfXG
        4UyXgFCeCXvYpWja3Z8shkE0iA==
X-Google-Smtp-Source: ACcGV62dp7Kq2OuARymnwjeBbuih5ALI6Wfl4G9HfJ5Ju+MssVtjExhAFa/BjqJ5HFad5YJgGV2gZw==
X-Received: by 2002:adf:f491:: with SMTP id l17-v6mr31394282wro.135.1539888437741;
        Thu, 18 Oct 2018 11:47:17 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g76-v6sm550348wmd.25.2018.10.18.11.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:47:17 -0700 (PDT)
Date:   Thu, 18 Oct 2018 20:47:15 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, fugang.duan@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
Message-ID: <20181018184715.GA31736@Red>
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:39:24AM -0700, Florian Fainelli wrote:
> On 10/18/2018 08:05 AM, Corentin Labbe wrote:
> > Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
> > This is due to missing SPEED_.
> 
> But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
> surely this would amount to the same code paths being taken or am I
> missing something here?

The bisect session pointed your patch, reverting it fix the issue.
BUT since the fix seemed trivial I sent the patch without more test then compile it.
Sorry, I have just found some minutes ago that it didnt fix the issue.

But your patch is still the cause for sure.
