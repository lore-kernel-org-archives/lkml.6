Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC45C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4233D20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWaeJQnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4233D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLCOzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeLCOzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:55:32 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EA62082F;
        Mon,  3 Dec 2018 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543848854;
        bh=+hNVkVUiHtzZQllt43azXMAHQupcaM1gqqNuQdkHLe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWaeJQnneZYLBjrfxTRSflm4DrGgXvW6UeRAC2OG0+/9+zuHWgC44wKwhbdcg8T/x
         ha6lhV6af3wIJUr/jiBD2Gnr06Yoi/ARxPJJfzPuzVnZ7CrrgKTST4juHja7wegmqM
         T3a4BfS4vtDK4QUCdvDLCE5JjREEfDJn1oLgKf4k=
Date:   Mon, 3 Dec 2018 09:54:04 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, stable@kernel.org,
        stable@vger.kernel.org
Subject: Re: [for-next][PATCH 08/18] parisc: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181203145404.GF235790@sasha-vm>
References: <20181122003332.500796758@goodmis.org>
 <20181123073033.2083020863@mail.kernel.org>
 <511cb47a-a1bd-bb5d-69ec-0836c6b5abfe@gmx.de>
 <20181123121253.278146b4@vmware.local.home>
 <20181123183415.GB1917@sasha-vm>
 <20181123142617.3d3972ca@vmware.local.home>
 <20181123200011.GM1917@sasha-vm>
 <20181124134634.306192c2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181124134634.306192c2@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 01:46:34PM -0500, Steven Rostedt wrote:
>On Fri, 23 Nov 2018 15:00:11 -0500
>Sasha Levin <sashal@kernel.org> wrote:
>> What will happen with these is that once Greg's scripts process Linus's
>> tree he'll end up with this patch series inconsistently backported to
>> stable trees, which is not what you want here.
>
>It's not like it won't work and then start to work again. Once they
>start failing in older versions, they will probably fail in all
>versions before that.
>
>>
>> Sure, we can wait for the "added to the xyz stable tree" mails and
>> object then, but why risk breaking the trees?
>
>Again, it's not much different than other stable patches that need to
>be fixed for older trees. If they build, they are fine, if they don't
>then they need to be fixed. You'll know right at build time.

So the only tree it applied and built was 4.19, all older trees failed
on at least one arch.

I'm going to remove any parts of this series from all other trees.

--
Thanks,
Sasha
