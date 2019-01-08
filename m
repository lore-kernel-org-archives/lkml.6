Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC08C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6096A2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfAHNyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:54:08 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4664 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfAHNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:54:07 -0500
Received: from thorin.petrovitsch.priv.at (80-110-99-3.cgn.dynamic.surfer.at [80.110.99.3])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id x08Dr8lI011223
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO);
        Tue, 8 Jan 2019 14:53:09 +0100
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <d4846cb2-2a4b-b8b3-daac-e5f51751bbf1@suse.cz>
 <nycvar.YFH.7.76.1901052016250.16954@cbobk.fhfr.pm>
 <fb0414ea-953b-0252-b1d1-12028b190949@suse.cz>
 <047f0582-a4d3-490d-7284-48dfdf9e9471@petrovitsch.priv.at>
 <nycvar.YFH.7.76.1901081235380.16954@cbobk.fhfr.pm>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <8c9feac8-fecb-a56a-afaf-c1352a666991@petrovitsch.priv.at>
Date:   Tue, 8 Jan 2019 14:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1901081235380.16954@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC-debian-Metrics: esgaroth.tuxoid.at 1169; Body=10 Fuz1=10 Fuz2=10
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 12:37, Jiri Kosina wrote:
> On Tue, 8 Jan 2019, Bernd Petrovitsch wrote:
> 
>> Shouldn't the application use e.g. mlock()/.... to guarantee no page 
>> faults in the first place?
> 
> Calling mincore() on pages you've just mlock()ed is sort of pointless 
> though.

Obviously;-)

Sorry for being unclear above: If I want my application to
avoid suffering from page faults, I use simply mlock()
(and/or friends) to nail the relevant pages into physical
RAM and not "look if they are out, if yes, get them in" which
has also the risk that these important pages are too soon
evicted again.

But perhaps I'm missing some very special use cases ....

MfG,
	Brend
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
