Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3178533-1523475546-2-15695154095802851117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523475545; b=M3e8pxlbZLefpSGzLwVqHdaOHO0FKMvTGahUrspbVip4eQsn5E
    lIIo+HC3y1MrR+NT5dSMQyg2pZyugYup3OsPsqIJRIuWXKrJC6PA//RYFsPUCw7u
    kRoTs+XfzOjBW6X9nkWb5RnVhapxrbVufa9JPWq+euJg22iBejBoOByMlfY9VhIy
    GkSF0GZzuENGwbC0JfPuh4GID8mhhWxYQ5dK9hXQOTUfBSrJSbQQKGt0n9zkK8yT
    W5yLeI6FK1hSQ2YuMJL8zIkh9g0hQEexjtmJZ58Uywj1xAUmvD7Y0P1vexjugfel
    8aOOtIyI8fO3shG/cgNWkdEwEemAIlFMcLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1523475545; bh=f3lD2jcYfNYY5b+qfY7D7nOZhwQm0BIfaa+gCitmpY
    A=; b=Hf54OjFemphv+OVf9X+E5U17zeRe20fNJA2ZGwgIzhTDVaWUq65bFSjvHJ
    KMXVeuG2AGPN17ba6wreWV2m910hNIVe2OYT8oV25kG56tMaNnL9o/r5nrfyHvAI
    BW85XjMO4epkKefjrtqsv6sBgAeZBZeuY+ezk8yzbPO969ldLexERbeCmRCGb8bt
    Rkw8ZQ33so557BspjjJjEe3A7sS4TQU+1WWDmQY4wla0ajX01Gs36qChUwp6LYzR
    ZuJV0hUp8hNFEwnr6xR0HVxF2biXI5KlwbryHXLuPpL5fo2eX/eeEuAQzu3R3tp1
    pQWzBTpttylMs6M3uHuiK+b4kYjg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAh6y2BtIaYdO2Jz2Z+WG5oYaG1/ywFcam7OPy6pOhUEsOEhW60COK7w1x92vPVPxdh43Qk77+rvzI7GAzbM9rBi2b8Ez0c1gOulDDgmIdUsoVQmeQlM
    Q3T06wGKDLAiv94yP27ESEKCF5PtatKC0zoGP0GLCXxvLxzxa9itIWNzaW1qnwk11CJgzhZgLw/4x0gsUwsjIhZaehxgs46EHH12vfV9g7Q3OwzMi671GLC8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=9Rt4o3Z7AAAA:8 a=PtDNVHqPAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=gh8pjzEqLyEMsN6mTXIA:9 a=kXfSGICM7I4A:10
    a=x8gzFH9gYPwA:10 a=jE01AiZSAJ7eki2zvjzZ:22 a=BpimnaHY1jUKGyF_4-AF:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756852AbeDKTBg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:01:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46231 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756848AbeDKTBd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 15:01:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
        <152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 14:00:17 -0500
In-Reply-To: <152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Wed, 11 Apr 2018 17:25:18 +0100")
Message-ID: <87po35k1q6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f6Kzs-0000BD-4M;;;mid=<87po35k1q6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Pn83xbg+a6bSqYlat/91KeajAvE0rELQ=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa04.xmission.com
X-Remote-Spam-Level: **
X-Remote-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;David Howells <dhowells@redhat.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 251 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.4 (1.4%), b_tie_ro: 2.5 (1.0%), parse: 1.49 (0.6%),
        extract_message_metadata: 34 (13.6%), get_uri_detail_list: 3.2 (1.3%),
        tests_pri_-1000: 18 (7.2%), tests_pri_-950: 1.42 (0.6%), tests_pri_-900: 1.17
        (0.5%), tests_pri_-400: 23 (9.3%), check_bayes: 22 (8.8%), b_tokenize: 8
        (3.2%), b_tok_get_all: 6 (2.5%), b_comp_prob: 2.4 (1.0%), b_tok_touch_all:
        2.9 (1.1%), b_finish: 0.71 (0.3%), tests_pri_0: 156 (61.9%),
        check_dkim_signature: 0.78 (0.3%), check_dkim_adsp: 7 (2.7%), tests_pri_500:
        9 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 06/24] kexec_load: Disable at runtime if the kernel is locked down
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David Howells <dhowells@redhat.com> writes:

> From: Matthew Garrett <mjg59@srcf.ucam.org>
>
> The kexec_load() syscall permits the loading and execution of arbitrary
> code in ring 0, which is something that lock-down is meant to prevent. It
> makes sense to disable kexec_load() in this situation.
>
> This does not affect kexec_file_load() syscall which can check for a
> signature on the image to be booted.

Maybing I am missing it but I am not seeing anything that would require
kexec_file_load be configured such that it checks the loaded kernel.

Without that I don't see the point of disabling kexec_load.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>


Eric




> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> Reviewed-by: James Morris <james.l.morris@oracle.com>
> cc: kexec@lists.infradead.org
> ---
>
>  kernel/kexec.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..1553ac765e73 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -199,6 +199,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
> +	/*
> +	 * kexec can be used to circumvent module loading restrictions, so
> +	 * prevent loading in that case
> +	 */
> +	if (kernel_is_locked_down("kexec of unsigned images"))
> +		return -EPERM;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
