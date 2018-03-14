Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2690414-1521065075-2-6570247132479155807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521065074; b=Be5/CXhUVJtK74iZJJ75//M02vtIC/MjnmVb46Q1ZG5ki5T
    Ab7THAM/k6yehXkOK56BgseV9P/CvxSR5b1qnwvA35ynBRetVu6Tex5GbTJvlOPm
    P2IEXOrEt9RUZ0Bne48l0fUS/yov5SX4StBGSxy6NZUIVtIaMF/tl4ftktmc5OXh
    SjbYrlLjW+LJinOJwePIPj0k3jalPKuPiwTpQgzEjk3Lg876PjEG0lo7WnU+zmAR
    N2Z4sWQp3ioBUlqfVvpd1G/HrkMKWgkk+8ZTx2BaWs92rYw74kyqc5fVQfaiLhnF
    7fRBix3opfDv/SfWzN2QeuldKaIE/0XiINRL1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:content-transfer-encoding
    :subject:sender:list-id; s=arctest; t=1521065074; bh=qmwPgCbqrzg
    1ZRM/eVY0QjE4EmQfa01XBkF51Rx8lek=; b=lzQrffiaLd62rIJ1ris4apMxhd4
    8GHG1XWteHwUTXox6xeO+kR1eQe6BWMUg0gL1WNyPwv0QTMrfWU+KP4JlzhCk4L5
    F35I4g2WqFo1xppzFwdSZm/uFwC5+2DfsdOP0tvY7DNdXd2pK8DGuqq9CPdeU9KV
    sVRXncHpKxjR+fFuH6A3wRtVhvFEiYMbBPL1Ov35phSYhGajXTySsJI+gUmYBBQq
    KQ10Zzf1NNyelPs5peAklmxqsvXKzzuUA5UPg1F5XehT+XmLdcgV2M699mAuStup
    aB4spd9s31c0thS2H/DsZEVAuqnV6JsIZ0728QP5VjguC/B/+VUQGEqt++w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCNWEc convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 14 Mar 2018 18:04:32 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46216 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNWEb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 18:04:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, Nagarajan.Muthukrishnan@oracle.com,
        prakash.sangappa@oracle.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        <87vadzqqq6.fsf@xmission.com>
        <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
Date: Wed, 14 Mar 2018 17:03:30 -0500
In-Reply-To: <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com> (Nagarathnam
        Muthusamy's message of "Wed, 14 Mar 2018 14:22:51 -0700")
Message-ID: <877eqejowd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1ewEVP-0002aO-8r;;;mid=<877eqejowd.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/8FYuILUccqs9OYk7EMAxSH2KOdejhq30=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 274 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.9%), b_tie_ro: 1.76 (0.6%), parse: 0.79 (0.3%),
        extract_message_metadata: 13 (4.7%), get_uri_detail_list: 1.99 (0.7%),
        tests_pri_-1000: 3.7 (1.4%), tests_pri_-950: 1.15 (0.4%), tests_pri_-900:
        0.98 (0.4%), tests_pri_-400: 22 (8.2%), check_bayes: 21 (7.8%), b_tokenize: 7
        (2.7%), b_tok_get_all: 7 (2.7%), b_comp_prob: 2.2 (0.8%), b_tok_touch_all:
        2.7 (1.0%), b_finish: 0.54 (0.2%), tests_pri_0: 223 (81.4%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 2.5 (0.9%),
        tests_pri_500: 4.2 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RESEND RFC] translate_pid API
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:

> On 03/13/2018 08:29 PM, ebiederm@xmission.com wrote:

>> The cost of that ``cheaper'' u64 that is not in any namespace is that
>> you now have to go and implement a namespace of namespaces.  You haven't
>> even attempted it.  So just no.    Anything that brings us to needing
>> a namespace of namespaces is a bad design.
>
> I am not trying to implement a namespace of namespaces.

No you are using a design that will require a namespace of namespaces
to be implemented to support CRIU (checkpoint/restart in userspace).

So when I see your patch I see a patch that only implements the easy
half of the work that needs to be done.

>>> Following patch uses a 64-bit ID for namespace exported by procfs
>>> for pid translation through a new file /proc/<pid>/ns/pidns_id.
>> And this design detail is what brings the automatic nack.
>>
>> Use file descriptros and it sounds like your use case justifies what you
>> are trying to do.
>
> File descriptors are problematic for following reasons.
> 1) I need to open a couple of file descriptors for every pid
> translation request.

You can cache descriptors across requests.  I suspect simply
by tracking the origin of the shared memory segment you can figure
out it's pid namespace.

> 2) In case of nested PID namespaces, say a new pid namespace is
> created at level 20,
>     with unique ID, I could just record this ID in a shared memory for
> interested process
>     to use. In case of file descriptors, every level has to figure out
> the process ID of the
>     newly created namespace's init process and open a file descriptor
> to track it.

Toss in a bind mount of the file in some filesystem if that helps.

But if I understand what you are talking about you are talking about
having a shared memory segment shared between processes in different
pid namespaces.

In that shared memory segment for a processes in different namespaces
you are talking about having the conversation structured as having
information structured as pid-namespace pid.

And crucuially you want anyone in any pid namespace to be able to read
that shared memory segment and to make sense of what is going on,
by just reading the pid namespace id.


Namespaces are all about making identifiers relative to their namespace.

The only way I can see you gain an advantage with your shared memory
design is by making identifiers that are not relative to their pid
namespace.   As such identifiers will completely defeat the ability
to implement CRIU support.

The closest I have to such identifiers today are bind mounts of the
namespace files.  So if you also have a common mount namespace you could
use that.


In theory a name in some other namespace is possible.  However anyone in
a container will only be able to see the names in their container or in
nested sub containers.  Which is what you have already with pids.  So I
don't think that will help.

Eric
