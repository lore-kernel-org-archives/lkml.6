Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03830C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A952075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A952075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIGMs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:48:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33420 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeIGMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:48:55 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so25778114oip.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GplQ6WkdLwHp52Ls0v3wVniUJDlZczfayLz3T9z5ynw=;
        b=Je9tTU0grvQoBStY9V/0FwcY2LEL0xI6E7s9yhZZU0YvIihkfPZZrg2LlUBSIkcv4R
         Ftf48sF8CSsJsrF0pHD9Sz1Fv90FhlA4Ikj0CVtAUxaHNJzyTAlfG2Dd2jYKnBIjw+u4
         GSWP/odXMsJ1tRgkNZWI99FNXe3lTubYQ66w/PNB1J4lmblDoKBj0RDzF6YLLipGSDAn
         5XMzLFGtHL548F2cqzkGUoFDLUOr95amRasRd7QYFcyauc0dL2BkkqoZJN9HLxewMCbH
         AYDRPYp/l4139N2aSRETr7KDvlBgsdkaux8KZyJvhqPbVSL4uC9d+OMVakXwioEnixyp
         fMDw==
X-Gm-Message-State: APzg51A0ccyaaAP/VXeiA8S1xLqvLtc8ZVTBM4X8Dvb+j846nlV3omnG
        YZC2+edDhJUEmM7ANoChmINKJ8/PpkMwRUQxBRKFqg==
X-Google-Smtp-Source: ANB0VdYU/MyelB437qi1J1ZzkX+zMn9xKhUfMTkRACxl48r2hRtdS+BOj3po94VDutsVtzwnaj6mWcb3VyUT/ocQIRo=
X-Received: by 2002:aca:5ad5:: with SMTP id o204-v6mr7227897oib.26.1536307748644;
 Fri, 07 Sep 2018 01:09:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:55cf:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 01:09:07 -0700 (PDT)
In-Reply-To: <20180906125843.GC1719@techsingularity.net>
References: <CAE4VaGA9KzX05rdfw2PhEATLisV-NVMc9rOyjzSg-rX1rug9Dw@mail.gmail.com>
 <CABuKy6MUNX85PBVchz_hqXy+FxXU2x0U9ZEZB13rVSLGpWOWvQ@mail.gmail.com>
 <CAE4VaGD12BLS_kk=pRwgTKL8YOU63Nowwa42cEdZObQ=P1MFnA@mail.gmail.com>
 <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
 <20180717100329.yfy7igdsrpk5ujf4@techsingularity.net> <CAE4VaGA_L1AEj+Un0oQEEqZp_jgaFLk+Z=vNoad08oXnU2T1nw@mail.gmail.com>
 <CAE4VaGDTNgu=JX=N7=uZu0Bz_vUdHszZQ9_SQuwrbjRvFjCwZw@mail.gmail.com>
 <20180904090053.GB1719@techsingularity.net> <CAE4VaGB-mFfAR_rKUbGx01HLDQtyjHQLNOrm3fc+aSq2D2O2Dg@mail.gmail.com>
 <CAE4VaGATB4M7-osmi0wqovGbZb7os+ukMHi+Lbum3tegpHxGNw@mail.gmail.com> <20180906125843.GC1719@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 7 Sep 2018 10:09:07 +0200
Message-ID: <CAE4VaGAD0NuO+bhQ=BXB-TC71CeyYJ+3WbY30r_vo7NKBQR2Mg@mail.gmail.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Kamil Kolakowski <kkolakow@redhat.com>,
        Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe 305c1fac3225dfa7eeb89bfe91b7335a6edd5172. That introduces a weird
> condition in terms of idle CPU handling that has been problematic.


We will try that, thanks!

>  I would suggest contacting Srikar directly.


I will do that right away. Whom should I put on Cc? Just you and
linux-kernel@vger.kernel.org ? Should I put Ingo and Peter on Cc as
well?

$scripts/get_maintainer.pl -f kernel/sched
Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER)
Peter Zijlstra <peterz@infradead.org> (maintainer:SCHEDULER)
linux-kernel@vger.kernel.org (open list:SCHEDULER)

Jirka

On Thu, Sep 6, 2018 at 2:58 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> On Thu, Sep 06, 2018 at 10:16:28AM +0200, Jirka Hladky wrote:
>> Hi Mel,
>>
>> we have results with 2d4056fafa196e1ab4e7161bae4df76f9602d56d reverted.
>>
>>   * Compared to 4.18, there is still performance regression -
>> especially with NAS (sp_C_x subtest) and SPECjvm2008. On 4 NUMA
>> systems, regression is around 10-15%
>>   * Compared to 4.19rc1 there is a clear gain across all benchmarks around 20%
>>
>
> Ok.
>
>> While reverting 2d4056fafa196e1ab4e7161bae4df76f9602d56d has helped a
>> lot there is another issue as well. Could you please recommend some
>> commit prior to 2d4056fafa196e1ab4e7161bae4df76f9602d56d to try?
>>
>
> Maybe 305c1fac3225dfa7eeb89bfe91b7335a6edd5172. That introduces a weird
> condition in terms of idle CPU handling that has been problematic.
>
>> Regarding the current results, how do we proceed? Could you please
>> contact Srikar and ask for the advice or should we contact him
>> directly?
>>
>
> I would suggest contacting Srikar directly. While I'm working on a
> series that touches off some similar areas, there is no guarantee it'll
> be a success as I'm not primarily upstream focused at the moment.
>
> Restarting the thread would also end up with a much more sensible cc
> list.
>
> --
> Mel Gorman
> SUSE Labs
