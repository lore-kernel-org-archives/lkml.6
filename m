Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2182782-1527602544-2-5718588531644115997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527602544; b=Za3pgCNoNZMTGNpK6Zus1qvBk/ks4MqXSglvT4dKNIgYMMsJwx
    Zfew6xHsXeSVGh/2pJMQJbCpeavvYkKJIJxblEf6/RDkFhKnCyAw49rRHOTDYNtQ
    AOUs6AxO2eYxQRfitMNuk8ztxpMecHt0J8/luD+icbJpIoPpK4ivLQMLcyI/z5xr
    94kGpiTSZXM6E1yoHd3yuoTMcYbIUI4FrxSXLOkIylRvH88xp++bGo6Zb3Y2fi1c
    h3TbCHk66JM7GLldS6RGPegIBayhhokQB85voS4mtrOoy7J5+4ZK+ehxyFKNxyBg
    aLRdAnUfM9h141db9y++pZ3FM56e1qn5fQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1527602544; bh=wcKzi7khozt94hHKnXU+sUi5va8ptu6Ar6BmfYpBDO
    w=; b=PRjZyDII/hkwYcQDSahkNmvAElJVpQT2HI9idql0nh4DuabWPjcZRC8VmH
    dZlFN6MGBkMykSC14VfZH9dj6ClFm3Rn0iUloCcBCNqLxYqWQKP3CuJiPGtUypck
    SI9Jo8x90gkYl/whYhrrqDtKzYVqUhuYB/vc6E8mlTGiEHbvob/S+Zfp84jAf0ki
    owVreaWkBQ59oQQUrIGD+A/3isowZcT5EdrmxzUccIKqMZSpPT6QAh6z6GttImHQ
    akI2hn9cRR3SZ6ofnL7sENOzj29N+Thxf1ZHkZCMTqPgacFLwkeaqZ0QnRdUJoYd
    weonlpiW1z96CdJm7yQmhKA5TdAg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOGYosgFstpI549yxusRIIhRBfmldhRxiaGlGpvLkZ5j3H/Lwayc4oxG1fXMuL/N0+yhahmVHKXXUcwMFks6dpY4XTssczomYyDIfV1DbX2U++2vb3Jz
    1SeVYeKuiULURr4mN70eZiILNXAQYw2U8wEI7pd8NRWxI9Rx/fMQUSd64mz0RWzj5hgOwhqhhS5vT3h+yQ+aT5S2RnqhyGxMe9tk6JB5C6YHpq+rAdGWAFl9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=PtDNVHqPAAAA:8 a=7nb9Ao8528kwGKcT9hIA:9 a=SsLxlLYP9IwA:10
    a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934158AbeE2OCT (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:02:19 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47714 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933858AbeE2OCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:02:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <87r2mre5b3.fsf@xmission.com> <87wovubbdf.fsf@xmission.com>
        <877enmskec.fsf@xmission.com>
        <CAOssrKdS9gOsZrNfqJbk_j0Z8-hrqrYWW+=_Z5mUEX1KE-Kw6Q@mail.gmail.com>
Date: Tue, 29 May 2018 09:02:03 -0500
In-Reply-To: <CAOssrKdS9gOsZrNfqJbk_j0Z8-hrqrYWW+=_Z5mUEX1KE-Kw6Q@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 29 May 2018 14:55:25 +0200")
Message-ID: <87zi0io90k.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNfCa-0006IB-MN;;;mid=<87zi0io90k.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5jC3kvwtq7wXp65tT4TqcSCj++Ss7wy0=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 232 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.6 (1.1%), b_tie_ro: 1.77 (0.8%), parse: 1.28 (0.6%),
        extract_message_metadata: 16 (6.9%), get_uri_detail_list: 1.89 (0.8%),
        tests_pri_-1000: 9 (4.0%), tests_pri_-950: 1.76 (0.8%), tests_pri_-900: 1.64
        (0.7%), tests_pri_-400: 28 (12.0%), check_bayes: 26 (11.4%), b_tokenize: 10
        (4.4%), b_tok_get_all: 6 (2.6%), b_comp_prob: 3.0 (1.3%), b_tok_touch_all:
        4.1 (1.8%), b_finish: 2.1 (0.9%), tests_pri_0: 163 (70.3%),
        check_dkim_signature: 0.46 (0.2%), check_dkim_adsp: 3.1 (1.3%),
        tests_pri_500: 4.6 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fuse: Ensure posix acls are translated outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Tue, May 29, 2018 at 2:42 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>
>>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>>
>>>> Ensure the translation happens by failing to read or write
>>>> posix acls when the filesystem has not indicated it supports
>>>> posix acls.
>>>>
>>>> This ensures that modern cached posix acl support is available
>>>> and used when dealing with posix acls.  This is important
>>>> because only that path has the code to convernt the uids and
>>>> gids in posix acls into the user namespace of a fuse filesystem.
>>>>
>>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>> ---
>>>
>>> ping.
>>>
>>> Miklos are you around where you can look at this?
>>
>> Perhaps I got the wrong email address.
>
>
> No, sorry.  I'll queue this up for 4.18.
>
> Just wanted to finish off overlayfs stuff before getting into fuse.

After reading your overlayfs pull it looks like those were some tricky
issues you were dealing with so it makes complete sense.

Then I am going to send you the enablement patch as I think the initial
round of work is done and you can apply them when you are ready.

Eric
