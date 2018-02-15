Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033785AbeBOTuV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:50:21 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44241 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033540AbeBOTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:50:19 -0500
X-Google-Smtp-Source: AH8x225QfEH4es7h3f/dETDrHwEmKVzuidqBjDvWbyl0TymS2QSlNr9MFzzdQ8d9RcumEG4+bOoPVw4T20WjBQ1fPYw=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <cover.1518662391.git.rgb@redhat.com>
References: <cover.1518662391.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2018 14:50:17 -0500
Message-ID: <CAHC9VhTPs-OdzHYeh+OWQ5Fd8q0b-5RG6rTnGc9thWr1w-GUWg@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] audit: speed up audit syscall entry
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 9:47 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> These fixes should speed up audit syscall entry by doing away with the
> audit entry filter check, moving up the valid connection check before
> filling in the context and not caring if there is a bug when audit is
> disabled.
>
> Passes audit-testsuite.
> See: https://github.com/linux-audit/audit-kernel/issues/6
>
> v3:
>   - squash patch 1 and 2
> v2:
>   - bail earlier to avoid setting up unneeded state
>   - don't bother checking for bug when disabled
>
> Richard Guy Briggs (2):
>   audit: deprecate the AUDIT_FILTER_ENTRY filter
>   audit: bail before bug check if audit disabled
>
>  kernel/auditfilter.c |  4 ++--
>  kernel/auditsc.c     | 22 ++++++++++------------
>  2 files changed, 12 insertions(+), 14 deletions(-)

Both patches merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
