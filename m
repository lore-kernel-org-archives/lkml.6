Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-765481-1526303666-2-13314771656443064690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526303665; b=YfUwaa8F+NdIzGzo5pCpJF3V0QZhUUamEqYu+Uz3HKalZ7cuYn
    SIXctXk8lue/BzTFpY6yXcP8JrxogdoR4MZF2x2jAJmIAGK1Pz07kJnNfQ9a1XKc
    2K6E4Leycr4MfrlbOZnfeBriTzMW3CBSvTFxcMDkiDPwQCerGHqnDH1nc1fcfpdr
    PsFmXY1dR9T3sp/1Sa96NUrV/Hxx0KWPXyJA07c1JMVs/W1ReK/cmSbz2cj3zi7z
    P3RjUPkU2CXF2uTCRHtYS4wmCbIy1duYpI4f763lT01L+Tkn3EIHKSl8IuauCLm5
    znjWqnji+/RxWN41egwFek/Zpf4L2OSbcA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1526303665; bh=+sawPPGOAWewHIVItF4D4lIROEyLB+1ilpsFKIjrYN
    s=; b=a52iQCrmahwkXPbMdEYYo8J07x/01EO+1J9JqyPIfj2Z3KczZlnM/E3ly9
    sDheB1pKmlbjSz638W5O8z5zB38+wDMcy/YtodDmR5V4e6Z9+DJsUpS/B1S2YJ5z
    5P3Es9SgUKXlTZDwnhAPMdtjlpfzXuF41ALNGloWFp+tSJ9ZTwEpniXjcy1uUfeI
    mg8PEcoGC95/nKrysiEda6MGkqO9yYEbxti6ocaOh/y14e2YqafN/5RmMAmZnI59
    gBCi/14HFr94+a3yC1kcjVijT+9Um0LoPOT11LysVCn2S+STx46IucdJgzYU00XK
    QffayxuPXPYcOFF2MGOUOAMNWRAQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN5ACGHDiwFC6DxEbn/fexkFeUrKGkVYggJrPgEOESXbl9QzQnzs/Hldh2KDobNOMkZClQaeHrYGx45GwKLWmwGFNVOrfLARj3nwGNKeZ3a9vfkDPusA
    TE8Vt/ksQdrulUE1bfDe1XJb+TkjR7Jo5Ie2rdJdZtmkmRVvN3Y4L845MmhjYVWq0QCv1hBnglIVc8wgHQiyNmICcz8Mq0VgVQ8epN5DQYV1KtrNbSohgIkm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=VwQbUJbxAAAA:8 a=hTLjO7snpvpKsWYbQCMA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeENNOM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 09:14:12 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40000 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932301AbeENNOI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 May 2018 09:14:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        aniel Micay <danielmicay@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, bfields@fieldses.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Solar Designer <solar@openwall.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Djalal Harouni <tixxdz@gmail.com>
References: <20180511093707.GA1403@comp-core-i7-2640m-0182e6>
        <CAG48ez0bXvp1iF=HqyhEP1p5B6PRR07_j0qRoypJqs8x3Z+=mw@mail.gmail.com>
        <20180514090117.GC28179@comp-core-i7-2640m-0182e6>
Date: Mon, 14 May 2018 08:13:50 -0500
In-Reply-To: <20180514090117.GC28179@comp-core-i7-2640m-0182e6> (Alexey
        Gladkov's message of "Mon, 14 May 2018 11:01:17 +0200")
Message-ID: <874ljamlbl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fIDIj-00047t-PO;;;mid=<874ljamlbl.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oTxV7Q02z19NeoohnjWhfkB0B1tj6Jlw=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa04.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 214 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.5 (1.6%), b_tie_ro: 2.4 (1.1%), parse: 1.44 (0.7%),
        extract_message_metadata: 3.9 (1.8%), get_uri_detail_list: 1.42 (0.7%),
        tests_pri_-1000: 9 (4.0%), tests_pri_-950: 1.83 (0.9%), tests_pri_-900: 1.47
        (0.7%), tests_pri_-400: 27 (12.6%), check_bayes: 26 (12.0%), b_tokenize: 11
        (5.1%), b_tok_get_all: 6 (3.0%), b_comp_prob: 2.7 (1.3%), b_tok_touch_all:
        3.4 (1.6%), b_finish: 0.72 (0.3%), tests_pri_0: 146 (67.9%),
        check_dkim_signature: 0.61 (0.3%), check_dkim_adsp: 3.8 (1.8%),
        tests_pri_500: 8 (3.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 7/7] proc: add option to mount only a pids subset
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Fri, May 11, 2018 at 03:58:39PM +0200, Jann Horn wrote:
>> On Fri, May 11, 2018 at 11:37 AM, Alexey Gladkov
>> <gladkov.alexey@gmail.com> wrote:
>> > This allows to hide all files and directories in the procfs that are not
>> > related to tasks.
>> 
>> /proc/$pid/net and /proc/$pid/task/$tid/net aren't in scope for this
>> protection, even though they contain information about the whole
>> network namespace of the task, right?
>
> Yes. The pidonly makes visible only pids subset. You can still access the
> process namespaces via /proc/$pid/ns.
>
> We can think of additional constraints since the parameters are not
> stored in the pid namespace anymore.

pidonly is fine.

You have to be very careful with this.  The existing hidepid option
needs to live in the pid namespace.  The issue is if someone is allowed
to mount proc and play with these options as in remount you this may
cause issues.

Eric

