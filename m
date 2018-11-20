Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07010C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC838206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC838206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeKUAlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:41:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeKUAls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:41:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C60B3154852;
        Tue, 20 Nov 2018 14:12:28 +0000 (UTC)
Received: from treble (ovpn-122-214.rdu2.redhat.com [10.10.122.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 120785D760;
        Tue, 20 Nov 2018 14:12:27 +0000 (UTC)
Date:   Tue, 20 Nov 2018 08:12:25 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] objtool: read_symbols() fixes
Message-ID: <20181120141225.c3kufvm2fwjvy3lk@treble>
References: <20181112125519.26855-1-asavkov@redhat.com>
 <20181120080548.26082-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120080548.26082-1-asavkov@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 20 Nov 2018 14:12:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:05:46AM +0100, Artem Savkov wrote:
> The series started with 'parent symbol search' patch, but I found another issue
> in read_symbols() while testing the failure-path.
> 
> Artem Savkov (2):
>   objtool: fix failed cold symbol doublefree
>   objtool: fix .cold functions parent symbols search
> 
>  tools/objtool/elf.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Thanks, looking good.  I'll run the patches through 0-day testing and
then send them onto the -tip tree.

-- 
Josh
