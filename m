Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE6AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA8220844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA8220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeIFReJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:34:09 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:33725 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728758AbeIFReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:34:09 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 2A29C1C1EDF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Sep 2018 13:58:45 +0100 (IST)
Received: (qmail 13244 invoked from network); 6 Sep 2018 12:58:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Sep 2018 12:58:45 -0000
Date:   Thu, 6 Sep 2018 13:58:43 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Kamil Kolakowski <kkolakow@redhat.com>,
        Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180906125843.GC1719@techsingularity.net>
References: <CAE4VaGA9KzX05rdfw2PhEATLisV-NVMc9rOyjzSg-rX1rug9Dw@mail.gmail.com>
 <CABuKy6MUNX85PBVchz_hqXy+FxXU2x0U9ZEZB13rVSLGpWOWvQ@mail.gmail.com>
 <CAE4VaGD12BLS_kk=pRwgTKL8YOU63Nowwa42cEdZObQ=P1MFnA@mail.gmail.com>
 <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
 <20180717100329.yfy7igdsrpk5ujf4@techsingularity.net>
 <CAE4VaGA_L1AEj+Un0oQEEqZp_jgaFLk+Z=vNoad08oXnU2T1nw@mail.gmail.com>
 <CAE4VaGDTNgu=JX=N7=uZu0Bz_vUdHszZQ9_SQuwrbjRvFjCwZw@mail.gmail.com>
 <20180904090053.GB1719@techsingularity.net>
 <CAE4VaGB-mFfAR_rKUbGx01HLDQtyjHQLNOrm3fc+aSq2D2O2Dg@mail.gmail.com>
 <CAE4VaGATB4M7-osmi0wqovGbZb7os+ukMHi+Lbum3tegpHxGNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGATB4M7-osmi0wqovGbZb7os+ukMHi+Lbum3tegpHxGNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:16:28AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we have results with 2d4056fafa196e1ab4e7161bae4df76f9602d56d reverted.
> 
>   * Compared to 4.18, there is still performance regression -
> especially with NAS (sp_C_x subtest) and SPECjvm2008. On 4 NUMA
> systems, regression is around 10-15%
>   * Compared to 4.19rc1 there is a clear gain across all benchmarks around 20%
> 

Ok.

> While reverting 2d4056fafa196e1ab4e7161bae4df76f9602d56d has helped a
> lot there is another issue as well. Could you please recommend some
> commit prior to 2d4056fafa196e1ab4e7161bae4df76f9602d56d to try?
> 

Maybe 305c1fac3225dfa7eeb89bfe91b7335a6edd5172. That introduces a weird
condition in terms of idle CPU handling that has been problematic.

> Regarding the current results, how do we proceed? Could you please
> contact Srikar and ask for the advice or should we contact him
> directly?
> 

I would suggest contacting Srikar directly. While I'm working on a
series that touches off some similar areas, there is no guarantee it'll
be a success as I'm not primarily upstream focused at the moment.

Restarting the thread would also end up with a much more sensible cc
list.

-- 
Mel Gorman
SUSE Labs
