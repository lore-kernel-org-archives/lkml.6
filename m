Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeFAWPx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 18:15:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39250 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeFAWPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 18:15:51 -0400
X-Google-Smtp-Source: ADUXVKJRso6ErK2PlhGejY/F6HXtDUZR/yEWvoNM7EPuOoIjZo05K4ieoGsnwTIqXuqXeVBnldH/PsFJUnfmpbun7hc=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180531163811.7m7c3q75duqkicl4@madcap2.tricolour.ca>
References: <c390a53d148593016df96e880a35e64f42edcf91.1527726830.git.rgb@redhat.com>
 <CAHC9VhQji1JrZ-QHMJ-965s+a5UJx-wRqpEdb84r=v+t1oH-qw@mail.gmail.com> <20180531163811.7m7c3q75duqkicl4@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Jun 2018 18:15:49 -0400
Message-ID: <CAHC9VhTABDT0FKb=vY4G06aY9Ky+NctArCRo8-iUQF6=eWKy1g@mail.gmail.com>
Subject: Re: [RFC PATCH ghak86 V1] audit: use audit_enabled as a boolean where convenient
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 12:38 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-05-31 11:48, Paul Moore wrote:
>> On Thu, May 31, 2018 at 11:13 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Most uses of audit_enabled don't care about the distinction between
>> > AUDIT_ON and AUDIT_LOCKED, so using audit_enabled as a boolean makes
>> > more sense and is easier to read. Most uses of audit_enabled treat it as
>> > a boolean, so switch the remaining AUDIT_OFF usage to simply use
>> > audit_enabled as a boolean where applicable.
>> >
>> > See: https://github.com/linux-audit/audit-kernel/issues/86
>> >
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  drivers/tty/tty_audit.c      | 2 +-
>> >  include/net/xfrm.h           | 2 +-
>> >  kernel/audit.c               | 8 ++++----
>> >  net/netfilter/xt_AUDIT.c     | 2 +-
>> >  net/netlabel/netlabel_user.c | 2 +-
>> >  5 files changed, 8 insertions(+), 8 deletions(-)
>>
>> I'm not sure I like this idea.  Yes, technically this change is
>> functionally equivalent but I worry that this will increase the chance
>> that non-audit folks will mistake audit_enabled as a true/false value
>> when it is not.  It might work now, but I worry about some subtle
>> problem in the future.
>
> Would you prefer a patch to change the majority (18) of uses of
> audit_enabled to be of the form "audit_enabled == AUDIT_OFF" (or
> "audit_enabled != AUDIT_OFF")?
>
> I prefer the approach in this patch because it makes the code smaller
> and significantly easier to read, but either way, I'd like all uses to
> be consistent so that it is easier to read all the code similarly.
>
>> If you are bothered by the comparison to 0 (magic numbers), you could
>> move the AUDIT_OFF/AUDIT_ON/AUDIT_LOCKED definitions into
>> include/linux/audit.h and convert the "audit_enabled == 0" to
>> "audit_enabled == AUDIT_OFF".
>
> I'd be fine doing that if you really dislike this patch's approach.

Like I said, I'm don't really care for the boolean-like approach of
this first patch.

-- 
paul moore
www.paul-moore.com
