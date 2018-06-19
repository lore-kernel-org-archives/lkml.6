Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A21FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53B120836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53B120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757232AbeFSNNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:13:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40779 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756675AbeFSNNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:13:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CA96ACD3;
        Tue, 19 Jun 2018 13:13:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79D5FDAD1B; Tue, 19 Jun 2018 15:10:44 +0200 (CEST)
Date:   Tue, 19 Jun 2018 15:10:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Allen Pais <allen.lkml@gmail.com>, linux-btrfs@vger.kernel.org,
        clm@fb.com, jbackik@fb.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop using get_seconds()
Message-ID: <20180619131041.6v3blgpegciu6fyi@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, linux-btrfs@vger.kernel.org,
        clm@fb.com, jbackik@fb.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org
References: <1528804105-24100-1-git-send-email-allen.lkml@gmail.com>
 <b40f794f-16b6-0369-cb0d-bbb5b12aa46a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40f794f-16b6-0369-cb0d-bbb5b12aa46a@suse.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:07:21PM +0300, Nikolay Borisov wrote:
> 
> 
> On 12.06.2018 14:48, Allen Pais wrote:
> > The get_seconds() function is deprecated as it truncates
> > the timestamp to 32 bits. Change to either ktime_get_seconds()
> > or ktime_get_real_seconds()
> 
> nit: In your patch you are only changing them to get-real-seconds. So
> the "ktime_get_seconds() or" part of the changelog is unnecessary.

Updated, and changed the subject line to "btrfs: replace get_seconds with
new 64bit time API"
