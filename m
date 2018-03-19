Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755913AbeCSPjX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:39:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755453AbeCSPjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:39:20 -0400
Subject: Re: [PATCH v5 1/9] sysctl: Add flags to support min/max range
 clamping
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
 <1521224030-2185-2-git-send-email-longman@redhat.com>
 <20180317011021.GB4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <35f54e8f-b80e-aa3b-b008-79ba7ca3bff2@redhat.com>
Date: Mon, 19 Mar 2018 11:39:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180317011021.GB4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 09:10 PM, Luis R. Rodriguez wrote:
> On Fri, Mar 16, 2018 at 02:13:42PM -0400, Waiman Long wrote:
>> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table
>> entry, any update from the userspace will be clamped to the given
>> range without error if either the proc_dointvec_minmax() or the
>> proc_douintvec_minmax() handlers is used.
> I don't get it.  Why define a generic range flag when we can be mores specific and
> you do that in your next patch. What's the point of this flag then?
>
>   Luis

I was thinking about using the signed/unsigned bits as just annotations
for ranges for future extension. For the purpose of this patchset alone,
I can merge the three bits into just two.

Cheers,
Longman
