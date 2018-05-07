Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeEGT36 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:29:58 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:45376 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeEGT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:29:56 -0400
X-Google-Smtp-Source: AB8JxZq4KcoOSUiJdNp9faaDElA7o6ektA7R8PLAKoXY7NFYd6//INj7KvKPR9KFjpAVrA+SanEB6pt6NndWKEh9+yU=
MIME-Version: 1.0
In-Reply-To: <x491seni7tu.fsf@segfault.boston.devel.redhat.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org> <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com> <CAPcyv4hekYsXFy1PHg7zMyoWtj1pYVfnANfrhpk-+Hr_NBV=BQ@mail.gmail.com>
 <x491seni7tu.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 May 2018 12:29:55 -0700
Message-ID: <CAPcyv4gbnqv4=mKPyiDskGKE9HveN6S9rzSmYGQ7QjCPg6W0cQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem) zone
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, chengnt@lenovo.com,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pasha.tatashin@oracle.com, Linux MM <linux-mm@kvack.org>,
        colyli@suse.de, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 12:28 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
[..]
>>> What's the use case?
>>
>> Use NVDIMMs as System-RAM given their potentially higher capacity than
>> DDR. The expectation in that case is that data is forfeit (not
>> persisted) after a crash. Any persistent use case would need to go
>> through the pmem driver, filesystem-dax or device-dax.
>
> OK, but that sounds different from what was being proposed, here.  I'll
> quote from above:
>
>>>>>> But for the critical pages, which we hope them could be recovered
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>> from power fail or system crash, we make them to be persistent by
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>> storing them to NVM zone.
>
> Hence my confusion.

Yes, now mine too, I overlooked that.
