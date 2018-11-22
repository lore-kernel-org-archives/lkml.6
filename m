Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1852CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D000C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMV+t8eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D000C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391587AbeKWAiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:38:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45922 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbeKWAiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:38:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so8050207ljd.12;
        Thu, 22 Nov 2018 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0FdJWlttdcfx1vvyGNs5jX+WBsrIxwmgJ7nDcXUL+zM=;
        b=hMV+t8eW1ECVHtpiApxQkz3/dDOsjqt+T3SUJewTdceUmdGcQY9euvpcCKfOm59VkE
         R0m4eQ41qNd6lEgag829R4WJnKrFA007BeTMCiP8YIux5WQKwcRBtBk9s0aLy5ISngLo
         bmZt/3MW4aCYzIcwY1PIOAwhNfXCQnEsvl3GR9X/T02GVZ+3KAsUxOGLXHgP3EvauDDG
         pySwWPJFhg11i3g6NS+xkQs9IlIA4gqtEG/XXB5kOeVPQrK9n3Rf6zZgBaM7w+Td+0br
         5J96nsQlek67ksGeCk35D2hwFKLGeDRz/nZSvIP15LURIkBjkH9AjeEbQfqtBMJRRPHt
         QhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0FdJWlttdcfx1vvyGNs5jX+WBsrIxwmgJ7nDcXUL+zM=;
        b=IRee5cQBilS0DYbOAlX36/57sjp4R286Ajvhvwp9klFsODDjHa7s2X3w1S42Ph0m+K
         3hII07wcNJy+BhUayl5oCeEWHJqF3/jfkUDYuzFcrTowvzGQcTDAhHJ4f5IkV7JelZ+E
         M3/lZbljzk/hmcl1LlSWg+q79FEp3b38SObN8WzkBo3CLO1so7Xsk4ChlOdt9p8S7CPk
         JwQptQk6aDGjqdbHX93IHciqhVDYQlNcPrLYgN+Mrq/UISTgG6QYM5RsYvWO0Jetr/6F
         EJ+MczT4bb91NBDOYE/KzMO3bqB9jXzg4qJ3Mw4csmBz5/hfVb0il9Gy4dP0c5BkhiGk
         j6Ug==
X-Gm-Message-State: AA+aEWb97fD9ZKRG7hHZldKNoKso4MxPUejoNm+RPGH+oyCJniJWc4Tz
        KI17jIkH8J3MLzdSPn3xbS0=
X-Google-Smtp-Source: AJdET5c09QDBjdzU99r6gnc2wWMKoS5VXUxBdkPj6g8cx8Bq97CCiEA/6DOH/u4paS9P4O/umiui4Q==
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr6831255ljf.5.1542895116044;
        Thu, 22 Nov 2018 05:58:36 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id p23sm7160394lfh.47.2018.11.22.05.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 05:58:35 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 67ECB4606DE; Thu, 22 Nov 2018 16:58:34 +0300 (MSK)
Date:   Thu, 22 Nov 2018 16:58:34 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        jpoimboe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Add /proc/pid_gen
Message-ID: <20181122135834.GA29449@uranus>
References: <20181121201452.77173-1-dancol@google.com>
 <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
 <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
 <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org>
 <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
 <37255927-1A93-4B8B-A916-B5A3983D56B6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37255927-1A93-4B8B-A916-B5A3983D56B6@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 04:35:34PM -0700, Andy Lutomirski wrote:
> > 
> > I'm going to have Android's systrace and Perfetto use this approach.
> > Exactly how many tools signed up to use this feature do you need?
> > 
> >> Those people are the intended audience and the
> >> best-positioned reviewers so let's hear from them?
> > 
> > I'm writing plenty of trace analysis tools myself, so I'm part of this
> > intended audience. Other tracing tool authors have told me about
> > out-of-tree hacks for process atomic snapshots via ftrace events. This
> > approach avoids the necessity of these more-invasive hacks.
> 
> Would a tracepoint for pid reuse solve your problem?

FWIW we've had similar problem in criu for memory snapshotting,
because memory data is PID-driven and snapshots are rather
discrete events. So we use task_struct::real_start_time as
a second guard agains pid reuse.
