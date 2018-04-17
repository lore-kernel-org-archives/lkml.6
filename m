Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+9Eytk6miO0qzufgRk2ONMQakxBwH2MDcJVpY1jrD70q22OEcEyI/GM7LW2KwRFlJ9JzwM
ARC-Seal: i=1; a=rsa-sha256; t=1523971532; cv=none;
        d=google.com; s=arc-20160816;
        b=xEcrUxNSkrK2MwT03lpCHidiY94i2xuxmIaUHSj4KID+xEvtxAlZNzQCRsTOezZTPA
         AS/zvckRneekRBD0+8HrD1vc1pIYc8auU9C9FZTVGcKQE+4O/t2BWQuO5WagHHJRIgRD
         IV1J9PSLpLjHClg7OGr9CVxq0PSg1sqemL5HrvO1xJklGIOWbyFEZQq9ZvOjAuZr8W65
         XVB4fUixQiAoFs7MeKNZJAz6xKV5TjBMQzno/EGNHib2TQzSt8g0n272JQlbngvNBq0e
         ynU7X8x5F9jCM/73Pv8eVAZzd3phwlXmtBevph2+x7XGWooORozZxCupH5xDisWDMt4x
         P3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:organization:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Tv8TL28qK+Lem9Tc4vYDyb5onhzZELlpW4jZypGJz88=;
        b=CToq2j7aeuwIQfDwPgm7OIT/I+FxHsX2ts/6iMOJacI9xLnrZr1q/yykMnLjY8p2hL
         2nLfU1kJc4St2BRoc6SKSpWxTV3KrvP4CnSqyVSvJ7XNMS7lxdRIiGLUtSAaAC4RUSF2
         lQ4TBroZrGxcOCeLvAKXLf90wijFC75Ka23U/sytUAY6FHzrPRJyRDRLYXy2R7oGRpna
         dicJXXJHRYwnqpVqVFOUv8O5/eHKjJOn9p4BNWXmWLBj9YZuC/u9sSD2FXQM8oo9G6GC
         vOZAdTmtsKXdg3EyT5E9zpJ+Q/AwB/e5hAB2ErhLXeHXpziGpxEjFdA0MBDen5WYypCv
         Prtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeDQNZc (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 17 Apr 2018 09:25:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753074AbeDQNZb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Apr 2018 09:25:31 -0400
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
To: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?UTF-8?Q?Libor_Pech=c3=a1=c4=8dek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1804131118080.17969@pobox.suse.cz>
 <c9f4b440-c672-e45f-ddcc-63548b0411e2@redhat.com>
 <alpine.LSU.2.21.1804161329040.23118@pobox.suse.cz>
 <20180416150230.6ys6ya7alpodxp3d@pathway.suse.cz>
 <alpine.LSU.2.21.1804171004410.12184@pobox.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <771e3d3b-214f-a49c-20f8-d0e8a4baffac@redhat.com>
Date: Tue, 17 Apr 2018 09:25:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1804171004410.12184@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597999973884545756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/2018 04:06 AM, Miroslav Benes wrote:
> On Mon, 16 Apr 2018, Petr Mladek wrote:
> 
>> On Mon 2018-04-16 13:33:55, Miroslav Benes wrote:
>>> On Fri, 13 Apr 2018, Joe Lawrence wrote:
>>>> Thanks for reviewing.  I'll hold off on posting v4 until Petr (and
>>>> others) get a chance to comment.  Perhaps there are other tests that
>>>> would be helpful?
>>
>>> I think it would be useful to have tests for a stack checking and a 
>>> consistency. Nicolai has written some lately for our internal testing, but 
>>> it would take some time to transform them appropriately, I think.
>>
>> The future of the stack handling is not clear at the moment. We should
>> wait how the discussion goes before spending time on test cases for
>> the current behavior.

Roger that on the patch stack discussion.  Once we figure out where that
is heading, we can create tests to verify that we're accurately
following the new rules.

> 
> You're talking about something different. We have to check stacks of all 
> tasks while patching in order to achieve consistency. Tests for that would 
> be useful.

FWIW there is the "busy target module" test in this patch.  It's main
purpose is to verify the behavior of the callbacks in a situation where
one livepatch target holds up the transition (aka the "busy mod").

If Nicolai has created test(s) that specifically target the stack
safeness, even better for future inclusion.

-- Joe
