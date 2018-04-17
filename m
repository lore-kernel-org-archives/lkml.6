Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/uhY9l3ljPxigQntbsslwRvJtV6PGZ/903WIDS2+3LjSyNeMmZiaMkJrZboBGhFbKEO8Gp
ARC-Seal: i=1; a=rsa-sha256; t=1523952371; cv=none;
        d=google.com; s=arc-20160816;
        b=RfeW5yiA5gOK25/SzPS+y2BI4bnL6trNSyq06vWo+3RnSSJdX+QlUhQzhTbb4qlqS8
         cJehcHp/PtPB2GeRlIyJLw4EXb0mQP9zlJ6Pb3sBrq62eVRw1z5zrCETf7PdsuKHOs/b
         ILlwYp+nGI5QLLFlmK8eZUl6PM+vrqMNi/UUl9q7jeToLzwPhF0klKesfWl2XsDnhCYM
         OJp6bzs7uva2K4kNOaB564A/7Gml4yXVABqsUIKXOw/z5ylBZ8sXINNPV+MExKKpBOjS
         8LdGU2WFcxAPLPoUNpjLEK9owAhDyqN2xDakVmrc+cgx7WqiY4KKDcccb9jp+zzikJee
         uJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ywvFQCx/pAMC9bsQAL8ZpopkVmHUnLiH93DfNxva8Jc=;
        b=j5dwP8BdCPsvWV0OwQVYbs/qJqWjYri9QsNVdE8OOpnULjLM5DWDQVBftBkrwRjuoa
         Sffe4/XGx78OiVkrAMrql4rrrqfGhMEaVZQ0O1F4+4I+l3FCwWIsjNX6YSovFyWrFbXM
         Eo3Whi5n+ccR6laaTc+E559vpwyszTm0at0a5lh603TkmnEjRDSJX5yPv1rMbxP6KEA9
         6WITUwP8xsmiLDGl+0cLbZSux86ao/uqFscVTP5rgsBsajvEmMwwS4wPoDX+vM+IWJsY
         u7VjBcRaTHA8tV/P6TwvSl+/GOeO4BmRLKSOXB4VavmeNMxemF10sFVhbenBo3a3rm80
         NIIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeDQIGK (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 17 Apr 2018 04:06:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeDQIGH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Apr 2018 04:06:07 -0400
Date: Tue, 17 Apr 2018 10:06:04 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?ISO-8859-2?Q?Libor_Pech=E1=E8ek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
In-Reply-To: <20180416150230.6ys6ya7alpodxp3d@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1804171004410.12184@pobox.suse.cz>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com> <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com> <alpine.LSU.2.21.1804131118080.17969@pobox.suse.cz> <c9f4b440-c672-e45f-ddcc-63548b0411e2@redhat.com>
 <alpine.LSU.2.21.1804161329040.23118@pobox.suse.cz> <20180416150230.6ys6ya7alpodxp3d@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597979881998493143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018, Petr Mladek wrote:

> On Mon 2018-04-16 13:33:55, Miroslav Benes wrote:
> > On Fri, 13 Apr 2018, Joe Lawrence wrote:
> > > Thanks for reviewing.  I'll hold off on posting v4 until Petr (and
> > > others) get a chance to comment.  Perhaps there are other tests that
> > > would be helpful?
> 
> > I think it would be useful to have tests for a stack checking and a 
> > consistency. Nicolai has written some lately for our internal testing, but 
> > it would take some time to transform them appropriately, I think.
> 
> The future of the stack handling is not clear at the moment. We should
> wait how the discussion goes before spending time on test cases for
> the current behavior.

You're talking about something different. We have to check stacks of all 
tasks while patching in order to achieve consistency. Tests for that would 
be useful.

Miroslav
