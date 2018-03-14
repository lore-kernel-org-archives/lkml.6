Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeCNAWp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932634AbeCNAWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:22:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCAC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELsZ+8FVIH8NV/ieZ2kOtKmmXuv5aQN4bzWOizEin1S2xeMwX+N3LGKZMjQJ6ccZGZ96PpW5LCixlKaTlXQcJrg=
MIME-Version: 1.0
In-Reply-To: <20180310111535.2e3202bc@ivy-bridge>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm>
 <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
 <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm> <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
 <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com> <20180310111535.2e3202bc@ivy-bridge>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 14 Mar 2018 00:22:22 +0000
X-Gmail-Original-Message-ID: <CALCETrUV9Q8o2TkydO7NNjHAQNsZM-m9nEV8n_XnoaE+RmGoXw@mail.gmail.com>
Message-ID: <CALCETrUV9Q8o2TkydO7NNjHAQNsZM-m9nEV8n_XnoaE+RmGoXw@mail.gmail.com>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
To: Steve Grubb <sgrubb@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Jiri Kosina <jikos@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, linux-audit@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 10:15 AM, Steve Grubb <sgrubb@redhat.com> wrote:
> On Wed, 7 Mar 2018 18:43:42 -0500
> Paul Moore <paul@paul-moore.com> wrote:
>> ... and I just realized that linux-audit isn't on the To/CC line,
>> adding them now.
>>
>> Link to the patch is below.
>>
>> * https://marc.info/?t=152041887600003&r=1&w=2
>
> Yes...I wished I was in on the beginning of this discussion. Here's the
> problem. We need all tasks auditable unless specifically dismissed as
> uninteresting. This would be a task,never rule.
>
> The way we look at it, is if it boots with audit=1, then we know auditd
> is expected to run at some point. So, we need all tasks to stay
> auditable. If they weren't and auditd enabled auditing, then we'd need
> to walk the whole proctable and stab TIF_AUDIT_SYSCALL into every
> process in the system. It was decided that this is too ugly.

When was that decided?  That's what this patch does.
