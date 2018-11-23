Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DF6C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC0420866
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Bscsc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC0420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395272AbeKXFTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389262AbeKXFTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:44 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0A220865;
        Fri, 23 Nov 2018 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542998060;
        bh=F09aAu/utoXDg3Q1IfaFOFyzokDCuzL9ZU4E0ZjigYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7Bscsc2dWkrlNaxWo8LR8pm8skPe/XZHrt1yL71BnaamhmooW7QPGJHUqLlNdUuK
         cScI5Is/4ZsY5kZi3KKFDtk8Ji6QEWwS5vjTF9YB9twOT4ogOI77nW0Pye+qPGvnOW
         +NcAmIAB2yDNT2MD1NLxTT8Dz9EQqX3ldA8DRM7o=
Date:   Fri, 23 Nov 2018 13:34:15 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, stable@kernel.org,
        stable@vger.kernel.org
Subject: Re: [for-next][PATCH 08/18] parisc: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181123183415.GB1917@sasha-vm>
References: <20181122003332.500796758@goodmis.org>
 <20181123073033.2083020863@mail.kernel.org>
 <511cb47a-a1bd-bb5d-69ec-0836c6b5abfe@gmx.de>
 <20181123121253.278146b4@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181123121253.278146b4@vmware.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:12:53PM -0500, Steven Rostedt wrote:
>On Fri, 23 Nov 2018 10:06:05 +0100
>Helge Deller <deller@gmx.de> wrote:
>
>
>> > How should we proceed with this patch?
>>
>> My suggestion, although I didn't looked too much on it:
>> Apply it to v4.9 and higher only.
>> I think I started fixing trace functionality on parisc around 4.6,
>> which is probably why applying it fails on v4.4 and v3.x
>
>The problem is, if you backport the generic patches, it will completely
>break any arch that isn't updated. This also includes the archs that
>are no longer supported upstream, as they were not changed to handle
>the generic updates either.

Does this mean that someone (Steve) will send a backport of this to all
relevant stable trees? Right now it looks like the series will randomly
apply on a mix of trees, which can't be good.

--
Thanks,
Sasha
