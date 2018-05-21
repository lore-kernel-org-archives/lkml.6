Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1150850-1526930424-2-4167312129880293974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526930423; b=IxczfSlWZu1uhwn+dIAzYDumXlh9qpMKnZEd2UqV7NBJQXl7Ip
    Yl0uSFMPWYs+Hr+ItT9hxQzS2GCT6ySmMB7zfF7ZiLbd+l2H+u/CdfRCXWBSc5ad
    sfLCxyfsSIda4klL2XV1ypaybX/WNPkUTfeF891u8OVsUQ0e/2LUFmBx+S/XsrHY
    79nDoogmueoSU7SDxvzuvAmorDczKZ5vdeQk38KEVwr4C7xs5xIOliG5gQikc1bs
    pKgJ9EQLv1Js1qALPLkbkP6DH7JBQARV6xMRCi9wyCV290ZWIJ5UGL23WV2N9X6B
    nGy5rxkE0Zso4ylynKCEOuUze1xsd0Z2Z5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1526930423; bh=SWM4mCWVVxmnxxnk51dW0vBsAvhU3mczfpwIOciSpV
    w=; b=fp8SQdYxjTU8JZqxJGtT4qW8ZCItuvs/aOsRF1jdv0Tlg8RlwRXENFCa0D
    lIj0zIrLedqAFe+8bJdzLSIpvjYTdAluHYzIB9EJln20/L4j+Ku701Ba2cLsMWXP
    KaNNMMKVg9hAMNGmO1ImPT0FW8gIcPp+ocxq8ONxi9lv/1i9J+WkRf4bcuOuEhLO
    DPzw/0z5v4gEi2wZwmFZctxOjhgLkmPdRDRTIByYQ4CmiGKOQNsUyYHVxDcr5uoM
    QVp9So9QrTsVXwqLao+W2i9zAUo+hDP6yUrq7068LwAXdjjXxIG5/xOWeD2u/XcW
    vYyL5DKJ1yzUklEMcBQsb5EEFKTQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfEGuykj8i9bl7UqmOHjgDhh46FTGUTLqKZ9yCTCFAF5xsPTKRblyvQhgB8etNi0z2IV36t8KVHSZ5Y6LKnrvpdlynlf60ACsWkjAX3ikuesVB0gw0+Yn
    qj4r1/6dFQc/+CWlYYihap703iM1fulJw9ekaNbhHgkZb7ZRuux6hNhWfSbgSGtydqL6qM1PTCZk+CDo6rw8MJ0l+CnFakf60QEGyLTWeT0tZD/3TfXtDJZa
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=lCzvVy68WgiYuwaTH6cA:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbeEUTTt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 15:19:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47228 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeEUTTr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 May 2018 15:19:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, Richard Guy Briggs <rgb@redhat.com>,
        cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        luto@kernel.org, jlayton@redhat.com, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com
References: <cover.1521179281.git.rgb@redhat.com>
        <1081821010c124fe4e35984ec3dac1654453bb7c.1521179281.git.rgb@redhat.com>
        <3001737.MkQ41rgtZF@x2>
Date: Mon, 21 May 2018 14:19:24 -0500
In-Reply-To: <3001737.MkQ41rgtZF@x2> (Steve Grubb's message of "Mon, 21 May
        2018 15:16:01 -0400")
Message-ID: <87muwshl4z.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fKqLC-0003Oi-9V;;;mid=<87muwshl4z.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Ug9mvPeJwcGcF/9q4Oo/nCE9BVq7lacQ=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
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
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Steve Grubb <sgrubb@redhat.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15022 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.88 (0.0%), parse: 0.89 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 0.77 (0.0%),
        tests_pri_-1000: 3.6 (0.0%), tests_pri_-950: 1.38 (0.0%), tests_pri_-900:
        1.22 (0.0%), tests_pri_-400: 18 (0.1%), check_bayes: 17 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.91 (0.0%), b_tok_touch_all:
        2.4 (0.0%), b_finish: 0.61 (0.0%), tests_pri_0: 147 (1.0%),
        check_dkim_signature: 0.63 (0.0%), check_dkim_adsp: 3.2 (0.0%),
        tests_pri_500: 14833 (98.7%), poll_dns_idle: 14824 (98.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFC PATCH ghak32 V2 13/13] debug audit: read container ID of a process
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Steve Grubb <sgrubb@redhat.com> writes:

> On Friday, March 16, 2018 5:00:40 AM EDT Richard Guy Briggs wrote:
>> Add support for reading the container ID from the proc filesystem.
>
> I think this could be useful in general. Please consider this to be part of 
> the full patch set and not something merely used to debug the patches.

Only with an audit specific name.

As it is:

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

The truth is the containerid name really stinks and is quite confusing
and does not imply that the label applies only to audit.  And little
things like this make me extremely uncofortable with it.

Eric
