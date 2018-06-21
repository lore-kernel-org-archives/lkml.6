Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81504C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375EC20652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375EC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeFUJXf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:23:35 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:45057 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932591AbeFUJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:23:34 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id C16091C29CB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:23:32 +0100 (IST)
Received: (qmail 6353 invoked from network); 21 Jun 2018 09:23:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 21 Jun 2018 09:23:32 -0000
Date:   Thu, 21 Jun 2018 10:23:32 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180621092331.p2pmaiu6563kp5u2@techsingularity.net>
References: <20180614083640.dekqhsopoefnfhb4@techsingularity.net>
 <CAE4VaGCzB99es_TpAaYvtjX8fqzFA=7HX-ezqgO6FaEB5if4zg@mail.gmail.com>
 <20180615112522.3wujbq7bajof57qx@techsingularity.net>
 <CAE4VaGBtasbDBoZ-c5R-AY++Y1BXgjrE7DwN0zOt113xmV95xw@mail.gmail.com>
 <20180615135212.wq45co7ootvdeo2f@techsingularity.net>
 <CAE4VaGAdXNYXMUn4eQgMqQtLKfp6-YHMa1NUSpL-L078oX7C-w@mail.gmail.com>
 <CAE4VaGBeTpxd1phR4rVAjqOXuLgLWPtVMPoRSOcG3HXfWDF=8w@mail.gmail.com>
 <20180619151803.bu6pehdu6wbd6l5x@techsingularity.net>
 <CAE4VaGAPOfy0RtQehKoe+443C1GRrJXCveBFgcAZ1nChVavp1g@mail.gmail.com>
 <CAE4VaGBMeL82SJK53gtcWkor-9eXeLX6VP9juw=FW=BOyp+hMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGBMeL82SJK53gtcWkor-9eXeLX6VP9juw=FW=BOyp+hMA@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 07:25:19PM +0200, Jirka Hladky wrote:
> Hi Mel and others,
> 
> I would like to let you know that I have tested following patch
> 

Understood. FWIW, there is a lot in flight at the moment but the first
likely patch is removing rate limiting entirely and see what falls out.
The rest of the experiment series deals with fast-scan-start, reset of
preferred_nid on cross-node load balancing and dealing with THP false
sharing but it's all preliminary and untested.

Furthermore, matters have been complicated by the posting of "Fixes for
sched/numa_balancing". My own testing indicates that this helped which
means that I need to review this first and then rebase anything else on
top of it.

I would also suggest you test that series paying particular attention to
whether it a) improves performance and b) how close it gets to the
revert in terms of overall performance.

-- 
Mel Gorman
SUSE Labs
