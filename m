Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2908601-1520175712-2-16345479324368744347
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520175712; b=X0RxUoSN6t2Oy0vd+y+SqzJ2vV4FuRS4+AXC0wLsgG8pg97
    +uyUrm+YDsvHhKJJEruhJ+W/MoYvusXteUtgiB+tngvMm+Dih1YVSPHb94T+6AiK
    Erx1GpifK41XPbb577VL+ywQF7otVr8xvqet9792k90oKnsMtDvVoyVhtKwoD5Sk
    zN9A5dgfCjDmT39Vbbb0hVI7+kTM6KNUD+RY7GO8yPqiIEeW58O+MVAYI0f2Z0kI
    F5vl8woHKRvE3EQGkND336nH3wyH5KH6XQyPBHxKJnZkEUTC+mSfNYCRCiq5Fjfc
    h51Wo4PUJSeq27O/3TRntTj2sfKbGd8qy2+vNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520175712; bh=rXr0D4mTk4Fy9jT2SVPYxNj14vaKgOcoCcco7p
    A5F2I=; b=APFVQayN1jb/dokcOB3GyohpJ2S/YQWU3cRnosp+YTiqAzn6mY/sJe
    WOhTiGf8k9JVQGopEitaiAqNC94GNfB4orx2obMCd6GNcGs/XJ3N9mJuH3UlN5o8
    zFpcl20TFDDA2oSoiIRCMHJ2EfB7X8HLQVoUIgdmNlKUHeWIvesUnaxkXC7z7Jo9
    At/ZSdpe4kcNvZpzrP/j2wnCf0PRdqYiC1aocwgUIbZJkAW//WW5i9asTRf8FTML
    lOxgAhJItjIVRPApdNtNoDoP/yUFUW0/VHlyieknaDQM+cQs2+TCPktitVX1ulU0
    kdLfdwCu0g2zvpf93nTYdVdkkrzP2KIQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=fuOIBeKF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OxgOIA5C;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=fuOIBeKF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OxgOIA5C;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeCDPBs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 10:01:48 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:42021 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeCDPBq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 4 Mar 2018 10:01:46 -0500
X-Google-Smtp-Source: AG47ELst6aLqIDem5HIFKoiEAq68sXsannme/kDtee7n/HRSmC6ASTJN7kFa6XpxyhiKzozgMpJPt4hFgFDFPw56xNs=
MIME-Version: 1.0
X-Originating-IP: [2600:3c03:e001:a800:65d3:9b72:327c:cd37]
In-Reply-To: <20180303091913.GA13118@mail.hallyn.com>
References: <cover.1519930146.git.rgb@redhat.com> <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <20180303091913.GA13118@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 4 Mar 2018 10:01:43 -0500
Message-ID: <CAHC9VhQA23w39aaho1wkPawX7zxiGyTVQroZzpACKk8DK8-F8w@mail.gmail.com>
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
To: "Serge E. Hallyn" <serge@hallyn.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc: mszeredi@redhat.com, ebiederm@xmission.com, simo@redhat.com,
        jlayton@redhat.com, carlos@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        viro@zeniv.linux.org.uk, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        trondmy@primarydata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 3, 2018 at 4:19 AM, Serge E. Hallyn <serge@hallyn.com> wrote:
> On Thu, Mar 01, 2018 at 02:41:04PM -0500, Richard Guy Briggs wrote:
> ...
>> +static inline bool audit_containerid_set(struct task_struct *tsk)
>
> Hi Richard,
>
> the calls to audit_containerid_set() confused me.  Could you make it
> is_audit_containerid_set() or audit_containerid_isset()?

I haven't gone through the entire patchset yet, but I wanted to
quickly comment on this ... I really dislike the
function-names-as-sentences approach and would would greatly prefer
audit_containerid_isset().

>> +{
>> +     return audit_get_containerid(tsk) != INVALID_CID;
>> +}

-- 
paul moore
www.paul-moore.com
