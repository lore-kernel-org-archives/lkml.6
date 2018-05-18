Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeEREXk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 00:23:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeEREXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 00:23:38 -0400
Subject: Re: mmotm 2018-05-17-16-26 uploaded (autofs)
To: Ian Kent <raven@themaw.net>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20180517232639.sD6Cz%akpm@linux-foundation.org>
 <19926e1e-6dba-3b9f-fd97-d9eb88bfb7dd@infradead.org>
 <49acf718-da2e-73dc-a3bf-c41d7546576e@themaw.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e3dfece-46a0-8ab2-2c7e-3edf956703a8@infradead.org>
Date: Thu, 17 May 2018 21:23:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <49acf718-da2e-73dc-a3bf-c41d7546576e@themaw.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 08:50 PM, Ian Kent wrote:
> On 18/05/18 08:21, Randy Dunlap wrote:
>> On 05/17/2018 04:26 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2018-05-17-16-26 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (4.x
>>> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>>
>>> This tree is partially included in linux-next.  To see which patches are
>>> included in linux-next, consult the `series' file.  Only the patches
>>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>>> linux-next.
>>>
>>> A git tree which contains the memory management portion of this tree is
>>> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
>>> by Michal Hocko.  It contains the patches which are between the
>>> "#NEXT_PATCHES_START mm" and "#NEXT_PATCHES_END" markers, from the series
>>> file, http://www.ozlabs.org/~akpm/mmotm/series.
>>>
>>>
>>> A full copy of the full kernel tree with the linux-next and mmotm patches
>>> already applied is available through git within an hour of the mmotm
>>> release.  Individual mmotm releases are tagged.  The master branch always
>>> points to the latest release, so it's constantly rebasing.
>>
>>
>> on x86_64: with (randconfig):
>> CONFIG_AUTOFS_FS=y
>> CONFIG_AUTOFS4_FS=y
> 
> Oh right, I need to make these exclusive.
> 
> I seem to remember trying to do that along the way, can't remember why
> I didn't do it in the end.
> 
> Any suggestions about potential problems when doing it?

I think that just using "depends on" for each of them will cause kconfig to
complain about circular dependencies, so probably using "choice" will be
needed.  Or (since this is just temporary?) just say "don't do that."

-- 
~Randy
