Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D278AC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987CB2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rF4d4pcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987CB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeLFIid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:38:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39818 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:38:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so22339071wra.6;
        Thu, 06 Dec 2018 00:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EXlVI6eyfrYHbwUajWJUciO1qZiYjViogF0ihcJf9sU=;
        b=rF4d4pcOATo6VECEx57W2et+bbiqHahyePjZnEzQuSylwgBrUhYQcVS3fdbFb8x2Yi
         iLDaivGyvienzhdIaonpql5PJlz9ZVCfm3v4OxGt1ZSL/izpyzjDxjrkIWWc5y2ocS3K
         Hd07JICS2LyEkJPRt45Udibm0d9LlTcZ469f1jkqEeA0SWeS0IvZQSbS6BDTZAPv6+wX
         vCJbOmpHw52YFt7/jjZsW8CGUlyaHHbYi1NSnkBSuiQKVf11k0bQos/zxqIOMZMe9G4V
         jbcIqIHSaoLfgvNME5yrjqhn0nr05ryELQ77CR0K4J6CVQ/EccUkUW/wM4MgtYn3tx/+
         +kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EXlVI6eyfrYHbwUajWJUciO1qZiYjViogF0ihcJf9sU=;
        b=BN7w15hJlNqIwOUSPZtxKWHm+NeV6fGwTbeyVEVRjhPruD5lNiDIER8NtSndF5K5qA
         6gbc3NQAUZDT7w9Ry3fg4ZpFsfDMXEby/9qnB84ThN18tC7F8gjg70uRHygjeL1ZdI4h
         O7ee1G6EmEYkePPrDwn7X6c09+qSu6V87y9TDg2hDds6PLWNdO1D14j9VJlowCjLUDvP
         FyfEQ3J042UndZ5+oRxxabp5Id5DMOoHHfoN1c4rz7MbvVfEIBGad/WS8hcBOgvz2yul
         WZ2Hoz0JRuDOkgyQ1KgDJO0d63cJdg81h0s3Tm9TOvqifWZU4A83KRTQk6M9oPHqXXss
         hdbw==
X-Gm-Message-State: AA+aEWba8h/XaAswn6lt4X00bddW79S/k51D5C9v9hO494PYiwM5Duj+
        03a432Sl9VnuAzWYLTXoijk=
X-Google-Smtp-Source: AFSGD/UOWi/tXFzWX2JSurQfvyvlsGOR+wjovqQ9Vm+LEeF16mJv9E1BPndqREBz6d2l8xKUGHgyTg==
X-Received: by 2002:adf:9786:: with SMTP id s6mr24214213wrb.283.1544085511293;
        Thu, 06 Dec 2018 00:38:31 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o81sm111225wmd.10.2018.12.06.00.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 00:38:29 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:38:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Bombe <andreas.bombe@gmail.com>
Cc:     Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181206083828.4bp3oypkto2ngobu@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se>
 <20181114113341.yx2wlzqku5yh3k4h@pali>
 <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPXf_qN66-Mi+o+9ENGqCDe-_2tHaf9uM3moRcCGNvmxwH3ExQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 December 2018 01:53:02 Andreas Bombe wrote:
> Pali Rohár <pali.rohar@gmail.com> schrieb am Mi., 14. Nov. 2018 um
> 12:33 Uhr:
> 
> > And... has somebody else time to look at those pending patches and do
> > some initial review? I would really appreciate if somebody look and
> > comment them.
> >
> > There are 14 open pull requests:
> > https://github.com/dosfstools/dosfstools/pulls
> 
> 
> I'll spend time on this again. It would help if you could make a list of
> higher priority PRs you would like see being looked at first.

So.. here is some list:

https://github.com/dosfstools/dosfstools/pull/92
https://github.com/dosfstools/dosfstools/pull/93
https://github.com/dosfstools/dosfstools/pull/94
https://github.com/dosfstools/dosfstools/pull/101
https://github.com/dosfstools/dosfstools/pull/104
https://github.com/dosfstools/dosfstools/pull/84

-- 
Pali Rohár
pali.rohar@gmail.com
