Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE57C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A201320874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A201320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966283AbeFSNC3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:02:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:39687 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965961AbeFSNC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:02:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00332AF5D;
        Tue, 19 Jun 2018 13:02:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51355DACD2; Tue, 19 Jun 2018 14:59:35 +0200 (CEST)
Date:   Tue, 19 Jun 2018 14:59:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, jbackik@fb.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop using get_seconds()
Message-ID: <20180619125934.GM24375@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Allen Pais <allen.lkml@gmail.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, jbackik@fb.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org
References: <1528804105-24100-1-git-send-email-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528804105-24100-1-git-send-email-allen.lkml@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 05:18:25PM +0530, Allen Pais wrote:
> The get_seconds() function is deprecated as it truncates
> the timestamp to 32 bits. Change to either ktime_get_seconds()
> or ktime_get_real_seconds()
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Reviewed-by: David Sterba <dsterba@suse.com>
