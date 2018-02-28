Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbeB1Sn3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:43:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39617 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932311AbeB1Sn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:43:27 -0500
Date: Wed, 28 Feb 2018 18:43:25 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/5] sysctl: Add flags to support min/max range
 clamping
Message-ID: <20180228184325.GJ14069@wotan.suse.de>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-3-git-send-email-longman@redhat.com>
 <20180228004753.GY14069@wotan.suse.de>
 <23264b8f-e84d-48cf-0da0-eb328916b2aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23264b8f-e84d-48cf-0da0-eb328916b2aa@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 12:53:40PM -0500, Waiman Long wrote:
> On 02/27/2018 07:47 PM, Luis R. Rodriguez wrote:
> > On Tue, Feb 27, 2018 at 03:49:48PM -0500, Waiman Long wrote:
> >> When minimum/maximum values are specified for a sysctl parameter in
> >> the ctl_table structure with proc_dointvec_minmax() handler,
> > an
> >
> >> update
> >> to that parameter will fail with error if the given value is outside
> >> of the required range.
> >>
> >> There are use cases where it may be better to clamp the value of
> >> the sysctl parameter to the given range without failing the update,
> >> especially if the users are not aware of the actual range limits.
> > Makes me wonder if we should add something which does let one query
> > for the ranges. Then scripts can fetch that as well.
> 
> That will actually be better than printing out the range in the dmesg
> log. However, I haven't figured out an easy way of doing that. If you
> have any suggestion, please let me know about it.

I think a macro that also adds yet another proc read-only entry with a postfix
"_range" with an internal handler which prints the range may suffice.

  Luis
