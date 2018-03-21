Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-637178-1521661846-2-1890051214617771467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521661846; b=Y6Xd9AkSQOR3yWL06mHXQohAuR8OJn7EPnPda2ygND9EAPj
    2rC4Ov5FA0KWvpvsCingkLNXgMmC/Jd+uujTvAQGiJ5JvnZaAxGvj5QWc06TH0hK
    2OBOp154imh8kKJBBJj8zm6okParszj6sG+VjcNLsBoSw1p+PJH+sKmtw/fKNkE0
    H7r1oZLL2TDFCTXO0dZ33ZZpVEXr0nd2bHCBGqtZZm6RXi66yMcJN2jXL0IJiowZ
    DrWu+4pgfngbKeNvH0x7RAqpOA4RJADZVirMfpUo3XP3O3ok7p315snMyc0CRiPs
    1Gk+GBh/fGtoKbMACEgDGQPlcfz77QIuw51NyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1521661846; bh=XAeFuyzaXZBN2ayklhwDLZLyYx52dBOPTZNn4I
    hdMkQ=; b=Xf6b2d7VlMZx/5kLPmZO+XwRioJ4VkEkX3KO3uw48gMyOESyteKGaD
    XoXvCVwxDUq5r7s6BHYgKNJQe3Gy3LFoEJpO7CXec7qxJL0lIk/FjYWGU3+wvL49
    V2vHAercQOPuRxb2+USHoUPdt9nBoIw9E0gaZuP/idT7x90C4O0a0cKJ1RyMTGth
    FkwqW01/x6RzZxo2oiltNdy8B2BBjj2eI0ZmjvHhF5kaja2uIyqfJJAgv2M+jth+
    Xq5xDTnngANDrKpSlggnxZWHCgVXjET90jjYiWh5cQqeKWejTpXap4fcSR7A/N4A
    1B8tIOOG+kYMESfmQ5z3adwUQH8Y/SXw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbeCUTuk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 15:50:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42437 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeCUTuf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 15:50:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable\@vger.kernel.org" <stable@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc\@vger.kernel.org" <linux-parisc@vger.kernel.org>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
        <20180319154645.11350-118-alexander.levin@microsoft.com>
        <87zi327ozu.fsf@xmission.com>
        <20180321181842.rhniantbvz25bu2f@sasha-lappy>
Date: Wed, 21 Mar 2018 14:49:25 -0500
In-Reply-To: <20180321181842.rhniantbvz25bu2f@sasha-lappy> (Sasha Levin's
        message of "Wed, 21 Mar 2018 18:18:44 +0000")
Message-ID: <87370txl8a.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eyjkZ-0002gO-F7;;;mid=<87370txl8a.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19bS3Q93MZLJw+d0JrMjp9xACP+F70VROg=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: ****
X-Remote-Spam-Status: No, score=4.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XMSubMetaSx_00,XMWhlSbjSex autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  2.5 XMWhlSbjSex Whole Obfuscated Subjects
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4739]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ****;Sasha Levin <Alexander.Levin@microsoft.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15018 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.0%), b_tie_ro: 1.78 (0.0%), parse: 0.76 (0.0%),
        extract_message_metadata: 2.6 (0.0%), get_uri_detail_list: 1.11 (0.0%),
        tests_pri_-1000: 4.0 (0.0%), tests_pri_-950: 1.19 (0.0%), tests_pri_-900:
        1.03 (0.0%), tests_pri_-400: 19 (0.1%), check_bayes: 18 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
        2.4 (0.0%), b_finish: 0.61 (0.0%), tests_pri_0: 141 (0.9%),
        check_dkim_signature: 0.69 (0.0%), check_dkim_adsp: 3.6 (0.0%),
        tests_pri_500: 14838 (98.8%), poll_dns_idle: 14831 (98.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a conflict with SI_USER with SIGFPE
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sasha Levin <Alexander.Levin@microsoft.com> writes:

> Hey Eric,
>
> On Tue, Mar 20, 2018 at 10:20:21AM -0500, Eric W. Biederman wrote:
>>Sasha Levin <Alexander.Levin@microsoft.com> writes:
>>
>>What is the justification for backporting this and the other similar
>>Documentation commits?
>
> It was flagged as a bug fixing patch by a new process we're testing, and
> when I looked at it I thought that the commit message suggests it fixes
> an ABI issue.

Unfortunately they just reveal an ABI issue.  I believe there are some
fixes coming but given that the issues are a decade old in many cases
actually fixing these things must be approach with care so as not to
create regressions.

>>These commits just introduce a define _FIXME with value of 0, to
>>document that the userspace ABI was handled incorrectly long ago.
>>
>>These commits do not fix anything.  Thes commits do not change anything
>>except a little how they are handled in siginfo_layout.  And I don't see
>>the changes that introduce siginfo_layout in kernel/signal.c being
>>backported.
>>
>>Further these commits don't even have a fixes tag so I am curious
>>what is triggering them for backport.
>
> We're testing out a new mechanism where we train a neural network to
> detect bug fixing patches and flag them for manual review. We're working
> on a FAQ + more detailed information right now.

The neural network did seem to pick up on something that is worth
looking at.

Eric
