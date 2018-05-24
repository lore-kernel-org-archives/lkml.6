Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2246768-1527180336-2-10467535775644127964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527180336; b=cfd7rx2HAHLzTqIoHdnOype5w86BfiqssbHmIDBqGkYliwrQ5v
    IbQu5aP1cZRXxF/htO5CDW5bNNtcaIGQXRPU0izBfSrs/6hhuNpk8F+Y029TqQIu
    lW8C9FpOLQTDdkHMCfDWvjPqb/2WI0D8AfFasQ2dlmjNx3WK1/+t9G+Jrw4E6zfh
    z6uHoV2L5zM4OFjhN80iBsBa5e3QAnLes9Dy5NEpKruUgi1wLtm645J150c5j48I
    1Dv95PotY9j8MCv8XrvPGf16W7WuIlGHLWYApChGcYAqq5XiBgLhwt2h0FjGv3QO
    Asf4/lgJg9ljwvzu4GCIndU4gvHCmhfBH9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1527180336; bh=tHhDIY6s4buUZAopS9sjm2em1xrapLLjqqj7cSi+jd
    w=; b=fQmQq4cWAWMWveWaZiA1xIVC/+DXTnGInr/CJBDu3ugLIP+OdC9Q+nWJuw
    eMAp1WSXpltlndiZ3bQ+p3sMs2PnrnyWdUiM5sW1hE4EN2qFRRYxL/2O3Z5855AT
    SSAi6GK4Lz2NqvWV8AV6ftEnI+CiJwNSJVrfrNCR2GQfVHJfmYubtaITpwVJWCqp
    kMS426+QDBaNtSotmMA3PnAzcfavgdGfNTQFrffBXtRCCrkjM6k7O4+m7tpzv2Ja
    HcvBcnce40pRWrRvhRfB4XEQmWHpnzDR4kRLbTjxNojAP/tDKlivKLtEwjzI0kZ5
    QguU8BVb324mLDugP5wbH8O22FHg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfMN3q9gmujAv6OvZmW1gUrNdJyUST3pR4E9oSv7S98towqthCls90pxThMG5pQWuJ4CY0kZ29lTKso1z+gnYEdcbpXqYkzx1nzd2MELwLkK8ekcbQLad
    oFSgxiDl5hKzKbxrzULKNnO8SldKESWF33mgAEGdB+GJQwjPs0xAy/Bfn0c83ijXHy0IcrkPA3JlZ4S3IpJTJQUsR0RqqriOsr3UltssGOWuzgcJV7h1YFJU
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=DfNHnWVPAAAA:8
    a=PtDNVHqPAAAA:8 a=hBqU3vQJAAAA:8 a=laIR_A7CoLLY0aeI2CwA:9
    a=rjTVMONInIDnV1a_A2c_:22 a=BpimnaHY1jUKGyF_4-AF:22 a=WLjMIN4s_96MqnBbPenP:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033800AbeEXQpc (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 12:45:32 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45856 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030888AbeEXQpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 12:45:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian@brauner.io>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-fsdevel@vger.kernel.org
References: <87o9h6554f.fsf@xmission.com>
        <20180523232538.4880-4-ebiederm@xmission.com>
        <20180524155803.GB19932@mailbox.org>
Date: Thu, 24 May 2018 11:45:06 -0500
In-Reply-To: <20180524155803.GB19932@mailbox.org> (Christian Brauner's message
        of "Thu, 24 May 2018 17:58:03 +0200")
Message-ID: <87603d3svh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLtMY-0006v4-7S;;;mid=<87603d3svh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rHbanN0n/ChZkGo1RnKZgYO3qoGMhUWQ=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15032 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.0 (0.0%), b_tie_ro: 2.00 (0.0%), parse: 0.72 (0.0%),
        extract_message_metadata: 17 (0.1%), get_uri_detail_list: 1.11 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.18 (0.0%), tests_pri_-900:
        0.98 (0.0%), tests_pri_-400: 17 (0.1%), check_bayes: 16 (0.1%), b_tokenize: 5
        (0.0%), b_tok_get_all: 5 (0.0%), b_comp_prob: 1.67 (0.0%), b_tok_touch_all:
        2.4 (0.0%), b_finish: 0.57 (0.0%), tests_pri_0: 124 (0.8%),
        check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14862 (98.9%), poll_dns_idle: 14847 (98.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 4/6] fs: Allow superblock owner to access do_remount_sb()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian@brauner.io> writes:

> On Wed, May 23, 2018 at 06:25:36PM -0500, Eric W. Biederman wrote:
>> Superblock level remounts are currently restricted to global
>> CAP_SYS_ADMIN, as is the path for changing the root mount to
>> read only on umount. Loosen both of these permission checks to
>> also allow CAP_SYS_ADMIN in any namespace which is privileged
>> towards the userns which originally mounted the filesystem.
>
> Acked-by: Christian Brauner <christian@brauner.io>
>
>> 
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
>
> Note, I just talked to Serge. This should be Acked-by: Serge Hallyn <serge@hallyn.com>

Now you know how long these patches have been sitting waiting to get
merged.

Eric
