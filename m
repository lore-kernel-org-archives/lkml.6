Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775732077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775732077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIFMup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:50:45 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45350 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:50:45 -0400
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so18859609oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EmrzoUzfT7zxPZ19pX+8kD6VAmZ9M/X6zaRNO2uMEAs=;
        b=orXGqDZ/i2ff8z7eRKCN58NghOfY4/pne4BEGMxQYv+SbCqaEj53plJfxDHy9XPvFJ
         XK+9gW0vuX0lJhNJ3gXPCZoTVStv1NpeGnDMCWtTivjsYWy2BIBk3k3V+souMFUqQsmv
         fobSHX0LM5PVvWGL2z8vog2+zhKkbhq3r30AQ+cZOEhKdmtsXqN+cyYkRzWWNAGL4Gnk
         j7OV+B02jbhTLx0jKQWekL3bLodafVw3h8OEnb9ZoA0leJwoez9yqFXknJBFtGhAcC9w
         LW6jb14qx1CdvX6GPe+kHJJCgHcc9DjZRkOcrpXFw63qRyt/4u6OdVc2ynLhmn3pF6eH
         45Ag==
X-Gm-Message-State: APzg51CP0qm/58TLl//8DhsXTxr/LEeMKGsPcIEjMhm5dWMk6ymfqEbk
        qJE4nOncQQmXntb0Krtkr/7+ldHM1EWrfsDib1+VlvxLnVk=
X-Google-Smtp-Source: ANB0VdblfacvgIZ2meyjSrN/Yid/O14Nrssm1GFu0BSSPRTfRj8C69bOhI8GnXG4yqVee7MmQD68NwqRfQAROfhCIFk=
X-Received: by 2002:aca:2cd3:: with SMTP id s202-v6mr1540591ois.253.1536221789187;
 Thu, 06 Sep 2018 01:16:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:55cf:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 01:16:28 -0700 (PDT)
In-Reply-To: <CAE4VaGB-mFfAR_rKUbGx01HLDQtyjHQLNOrm3fc+aSq2D2O2Dg@mail.gmail.com>
References: <CAE4VaGCQV+cS-vhdLyMwzftbB-xBHPt4Y4chg_0ykLHTE9cRfw@mail.gmail.com>
 <CAE4VaGDHcZbnDpJ+FiQLfA1DRftY0j_GJSnh3FDRi34OztVH6Q@mail.gmail.com>
 <20180627084954.73ucqvac62v5gje4@techsingularity.net> <CAE4VaGA9KzX05rdfw2PhEATLisV-NVMc9rOyjzSg-rX1rug9Dw@mail.gmail.com>
 <CABuKy6MUNX85PBVchz_hqXy+FxXU2x0U9ZEZB13rVSLGpWOWvQ@mail.gmail.com>
 <CAE4VaGD12BLS_kk=pRwgTKL8YOU63Nowwa42cEdZObQ=P1MFnA@mail.gmail.com>
 <CAE4VaGArxDYHzg8G203yKjgkuw3mULFSw8yCYbCcqvAUSUxy+A@mail.gmail.com>
 <20180717100329.yfy7igdsrpk5ujf4@techsingularity.net> <CAE4VaGA_L1AEj+Un0oQEEqZp_jgaFLk+Z=vNoad08oXnU2T1nw@mail.gmail.com>
 <CAE4VaGDTNgu=JX=N7=uZu0Bz_vUdHszZQ9_SQuwrbjRvFjCwZw@mail.gmail.com>
 <20180904090053.GB1719@techsingularity.net> <CAE4VaGB-mFfAR_rKUbGx01HLDQtyjHQLNOrm3fc+aSq2D2O2Dg@mail.gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 6 Sep 2018 10:16:28 +0200
Message-ID: <CAE4VaGATB4M7-osmi0wqovGbZb7os+ukMHi+Lbum3tegpHxGNw@mail.gmail.com>
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

Hi Mel,

we have results with 2d4056fafa196e1ab4e7161bae4df76f9602d56d reverted.

  * Compared to 4.18, there is still performance regression -
especially with NAS (sp_C_x subtest) and SPECjvm2008. On 4 NUMA
systems, regression is around 10-15%
  * Compared to 4.19rc1 there is a clear gain across all benchmarks around 20%

While reverting 2d4056fafa196e1ab4e7161bae4df76f9602d56d has helped a
lot there is another issue as well. Could you please recommend some
commit prior to 2d4056fafa196e1ab4e7161bae4df76f9602d56d to try?

Regarding the current results, how do we proceed? Could you please
contact Srikar and ask for the advice or should we contact him
directly?

Thanks a lot!
Jirka

On Tue, Sep 4, 2018 at 12:07 PM, Jirka Hladky <jhladky@redhat.com> wrote:
> Hi Mel,
>
> thanks for sharing the background information! We will check if
> 2d4056fafa196e1ab4e7161bae4df76f9602d56d is causing the current
> regression in 4.19 rc1 and let you know the outcome.
>
> Jirka
>
> On Tue, Sep 4, 2018 at 11:00 AM, Mel Gorman <mgorman@techsingularity.net> wrote:
>> On Mon, Sep 03, 2018 at 05:07:15PM +0200, Jirka Hladky wrote:
>>> Resending in the plain text mode.
>>>
>>> > My own testing completed and the results are within expectations and I
>>> > saw no red flags. Unfortunately, I consider it unlikely they'll be merged
>>> > for 4.18. Srikar Dronamraju's series is likely to need another update
>>> > and I would need to rebase my patches on top of that. Given the scope
>>> > and complexity, I find it unlikely they would be accepted for an -rc,
>>> > particularly this late of an rc. Whether we hit the 4.19 merge window or
>>> > not will depend on when Srikar's series gets updated.
>>>
>>>
>>> Hi Mel,
>>>
>>> we have collaborated back in July on the scheduler patch, improving
>>> the performance by allowing faster memory migration. You came up with
>>> the "sched-numa-fast-crossnode-v1r12" series here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
>>>
>>> which has shown good performance results both in your and our testing.
>>>
>>
>> I remember.
>>
>>> Do you have some update on the latest status? Is there any plan to
>>> merge this series into 4.19 kernel? We have just tested 4.19.0-0.rc1.1
>>> and based on the results it seems that the patch is not included (and
>>> I don't see it listed in  git shortlog v4.18..v4.19-rc1
>>> ./kernel/sched)
>>>
>>
>> Srikar's series that mine depended upon was only partially merged due to
>> a review bottleneck. He posted a v2 but it was during the merge window
>> and likely will need a v3 to avoid falling through the cracks. When it
>> is merged, I'll rebase my series on top and post it. While I didn't
>> check against 4.19-rc1, I did find that rebasing on top of the partial
>> series in 4.18 did not have as big an improvement.
>>
>>> With 4.19rc1 we see performance drop
>>>   * up to 40% (NAS bench) relatively to  4.18 + sched-numa-fast-crossnode-v1r12
>>>   * up to 20% (NAS, Stream, SPECjbb2005, SPECjvm2008) relatively to 4.18 vanilla
>>> The performance is dropping. It's quite unclear what are the next
>>> steps - should we wait for "sched-numa-fast-crossnode-v1r12" to be
>>> merged or should we start looking at what has caused the drop in
>>> performance going from 4.19rc1 to 4.18?
>>>
>>
>> Both are valid options. If you take the latter option, I suggest looking
>> at whether 2d4056fafa196e1ab4e7161bae4df76f9602d56d is the source of the
>> issue as at least one auto-bisection found that it may be problematic.
>> Whether it is an issue or not depends heavily on the number of threads
>> relative to a socket size.
>>
>> --
>> Mel Gorman
>> SUSE Labs
