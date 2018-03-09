Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeCIUni convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 15:43:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751211AbeCIUng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 15:43:36 -0500
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
To: Mike Galbraith <efault@gmx.de>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
 <1520613285.12489.36.camel@gmx.de>
 <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
 <1520619426.27998.18.camel@gmx.de>
 <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
 <1520624424.27998.76.camel@gmx.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
Date: Fri, 9 Mar 2018 15:43:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1520624424.27998.76.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 02:40 PM, Mike Galbraith wrote:
>>>
>>> If v2 is to ever supersede v1, as is the normal way of things, core
>>> functionality really should be on the v2 boat when it sails.  What you
>>> left standing on the dock is critical core cpuset functionality.
>>>
>>> 	-Mike
>> From your perspective, what are core functionality that should be
>> included in cpuset v2 other than the ability to restrict cpus and memory
>> nodes.
> Exclusive sets are essential, no?  How else can you manage set wide
> properties such as topology (and hopefully soonish nohz).  You clearly
> can't have overlapping sets, one having scheduler topology, the other
> having none.  Whatever the form, something as core as the capability to
> dynamically partition and isolate should IMO be firmly aboard the v2
> boat before it sails.
>
> 	-Mike

The isolcpus= parameter just reduce the cpus available to the rests of
the system. The cpuset controller does look at that value and make
adjustment accordingly, but it has no dependence on exclusive cpu/mem
features of cpuset.

-Longman
