Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346DEC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0023C21019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546947471;
	bh=JPaMwAyOxxUsbhTmGN3pkcSlfwk+fP+ry46b0OxtO3o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=clvKQwGEfzyKQPNaZbTKesED6PUohoXaS1J31RCwqEbncNhocruoWIdpQsdW/SlRC
	 t0xyWca6WY5H1CwxvWykdt9Twao7JuU2d4tSxEuXEW+ZY23SiOYl4faAKR1KY6mzZ7
	 hzuSC+nT5CQGVmta94apPgsnhTnsEq9aH/mOHRKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfAHLhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:37:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfAHLht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:37:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D5A8AD6F;
        Tue,  8 Jan 2019 11:37:48 +0000 (UTC)
Date:   Tue, 8 Jan 2019 12:37:46 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <047f0582-a4d3-490d-7284-48dfdf9e9471@petrovitsch.priv.at>
Message-ID: <nycvar.YFH.7.76.1901081235380.16954@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <d4846cb2-2a4b-b8b3-daac-e5f51751bbf1@suse.cz> <nycvar.YFH.7.76.1901052016250.16954@cbobk.fhfr.pm> <fb0414ea-953b-0252-b1d1-12028b190949@suse.cz>
 <047f0582-a4d3-490d-7284-48dfdf9e9471@petrovitsch.priv.at>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Bernd Petrovitsch wrote:

> Shouldn't the application use e.g. mlock()/.... to guarantee no page 
> faults in the first place?

Calling mincore() on pages you've just mlock()ed is sort of pointless 
though.

-- 
Jiri Kosina
SUSE Labs

