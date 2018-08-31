Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66265C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C562083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6c26jQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C562083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeHaMRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:17:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50714 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeHaMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:17:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so4335780wmc.0;
        Fri, 31 Aug 2018 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HWHotFyCbeXwo93md5yZJNBdp4L42J0NdqG+r75AZcw=;
        b=i6c26jQWF0Iu5z1TComV5mWy06NhZ6Ued+k6DJhLYX8383U9La+ZYB/DedYYKTed/Q
         CRFyNax2kZsUZhL5ZKr1myZ0itbCcnENl82I5FqUiuDBu4qXIyemN80ufQpxPjmKsB2P
         jbJ72Edsc4PbXJrq8O3uBcs4V3tvHuQvgrdoaedjxbqUb3EIht1Rxp5YFQWGoaNobbyo
         jcAklOWNYXNNq1xjaUa3YEMSdLp5jdQoO+83Q1memp4HP6vwtgZ9Td+MwP0Z7+ebcvsX
         SVYxvFpaNhBPZ6NW6I7FeuaFub3PQCsWHxbnR2TgeIwtZhCiT0PVW80BxeySdHTUgpvl
         H+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWHotFyCbeXwo93md5yZJNBdp4L42J0NdqG+r75AZcw=;
        b=DDoe/3yfhPxmwXgk72nuJp91aoVNqPyUJGc3JlLf9oeAqqCxETEi/4Y7w/xExWuzs3
         QDf5WM+31DmFeET6cyNFz2Liiyj1iafGxN9VQwh1QKsN+rCbxLrUeVlOgpTSZAlASs9D
         /GEVhXKRGaClzbQBXZsic74iiJ2YdeKgpYJJr8zHUTWORFwNNN3CUXtLiQUsgcyXcbDu
         58C8+U2Eaw2obUOmE3F8OjdfgSQZtMuAygZUFj5Bn+278jDf+sPPYZYGF+EmlJL5y39t
         d9LaSneyRfKGBbFNrVjT5GJmJoLb9E7Pi+Ekcbth1hYMafL8u4HCE06dbnS23qk440TF
         eGwg==
X-Gm-Message-State: APzg51A8DR/YaShO7YxyidO2qeQGM7Et25LItQDayaReLLAkgpDMomSB
        A8DiN9jaq26rgJDbUXJcJp8=
X-Google-Smtp-Source: ANB0VdZyC0gkqfYbJfQc0tcE49aZjO+0//Xw4TP/LnxrazxM4lifPw/5F4k35a8sIajf8MkHUJcDUQ==
X-Received: by 2002:a7b:c096:: with SMTP id r22-v6mr3508005wmh.118.1535703086966;
        Fri, 31 Aug 2018 01:11:26 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:41c4:f3ec:dcc3:6a2f])
        by smtp.gmail.com with ESMTPSA id l130-v6sm5093490wmd.16.2018.08.31.01.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 01:11:26 -0700 (PDT)
Date:   Fri, 31 Aug 2018 10:11:24 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
Message-ID: <20180831081123.6mo62xnk54pvlxmc@ltop.local>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
> This patch adds __force annotations for __user pointers casts detected by
> sparse with the -Wcast-from-as flag enabled (added in [1]).
> 
> [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292

Hi,

It would be nice to have some explanation for why these added __force
are useful.

-- Luc Van Oostenryck
