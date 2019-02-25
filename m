Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08649C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C102E20643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBfxxcf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfBYOrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:47:03 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:38051 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfBYOrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:47:02 -0500
Received: by mail-qt1-f176.google.com with SMTP id s1so10732831qte.5;
        Mon, 25 Feb 2019 06:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHl+Ow8APJ1nBv2dS88ehPTsZL9SsvW6hgb3mHpsbGA=;
        b=dBfxxcf7WC8VrrXLZXEzrh8zF7YRXx+pmKSXsQmHGyb3eNbzKqrNMB8abZ3YeBgJx+
         3eBabT43JnMMS6waGheMl7ZfS17EDxXZL2SYn5MgQxkDpRSSxllRan6JUXvN7E+495nU
         1jiaoZi2bvkcuOb4gf4r1WqoKyktC7I1xwXl3C+vycnqcK/7Dkj+odfOUtnr9f5LaU2Q
         pzDhDRccHqJGlGonQ6l1S1pLi2NwetFDCVrNhqKG0wK7UqcVv5NfhTJqeRNZhiz+QSFZ
         MHHyEpgSz6XyYTMUW2/VBxksjgQvOE6+Xg+y8TzVvLW7lUf3gMiefPxY7y/Jw7mvqYpt
         yw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHl+Ow8APJ1nBv2dS88ehPTsZL9SsvW6hgb3mHpsbGA=;
        b=DsHwO9bcmQtdUATn+uBcJPvUu9ZQ7aHqIMYPsPV7Pk0VUBTuF8Hto/KqzwmOZ+M50R
         6mv2UMZWXmC3YnSX6kum7H1nDTGSHdq3p/G2JzLhST8WCSeVk1u9rYgQglLzVOHI7/Sb
         gNGJnpU7m0W7uvIvlNt6EXj/v61C6y0CGbh7QB4FnW1Xp//KFh4PNM8sICgFzgP/UdxQ
         FDjlMRi4kOoP8XWUlBTU2TMmZaiEgoFhOcf669UmnqGxWgmRg1X2Ou+moeFwKdvZw7f1
         u42yDN3lXLsiQFMi9SZEGBKkcq8WQHq3X7l2/PuEFZixHacrv+4hBfoYqmPl+Cep++37
         yaDQ==
X-Gm-Message-State: AHQUAuYAFkIHDpwQ8XiEqqUHiSIURYVZNiAE4DR/AW678Yof0Dj0qbPv
        RIOYGilURAm9e4YP/ENU/cXiCqtq
X-Google-Smtp-Source: AHgI3Iahke9M7Sl4wYKktCB8UYKcPSe9k1S8geUMWSi3yaaR+j1mhdRrw+FsSVZD3957QJW2lRSbzg==
X-Received: by 2002:a0c:c60c:: with SMTP id v12mr13823589qvi.29.1551106021507;
        Mon, 25 Feb 2019 06:47:01 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id u25sm5312811qkj.96.2019.02.25.06.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:47:00 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95E584039C; Mon, 25 Feb 2019 11:46:57 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:46:57 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 12/15] perf script python: add Python3 support to
 stat-cpi.py
Message-ID: <20190225144657.GL31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-13-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-13-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:16PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the stat-cpi.py script

Applied
