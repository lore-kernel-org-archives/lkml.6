Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1243379-1526933216-2-13297459091515418536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526933216; b=jqD+BIvUIkn1R8XQM/47hh9nMiuQ1a/v70lxhsR4+FqsDCDRvN
    QvZR+P3lxXF0ezoIR7MEAYtRek7jZ/SP3BYTUFYZB5EysRLwQBxx19iW3CoBGmgY
    x/0e8pZ76K7I9EzZuGIGR3ZKlests06ehIgDH+tF5RByz3LoHILwZHYUCyX8gooj
    2qxN5oWEvl8ZICVZ+j+AeNjLKabHxO/NhOLKs1FmXCSu+PZUw+QI8Z0hkve2xhkP
    EDWLtqI8MRDvD5PgsgHeZxNAmxFdfEuMbPczCYsgPh8FiXtxUuV4/dcpCO7JvGy0
    QDLd5+q6fRlzvfOmhJbt5/dzIJWuBvR+Pwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526933216; bh=A+ifNwp/hGRf+3KEr2NsUJEWgK960Y/OnMI21ViItn
    o=; b=gHkGHjA0R0xgS95HdCDk3yHAvnQ7X7ff2DJ+wSHj31YQrDM/ogpHN6xx94
    syQhEpOUgC8dAl/yKLrZzEZjn12bcWppj/v8b91ozhR2+q+CePVrQWOh0HuWPKEa
    zkhsE8zTF+zYC0oIRJNcZEqpuIcGXWzJUEPPawn+KSSNKDvTYpHQj1FlHI+u1pwa
    +zETJtorfuTL7wxqB4QOtdf54EoPlVI2GwsBxyWQDsJSFDY6BdJ7dutPeGwSfFij
    yGf1SIYnJFqvPvyrMhaZumD0kKA0NVb+q3j1Qfv7RIhYihE3zqCXG23TTaOsZ83w
    KJBNb/7rSY8ekFcMBTrOFkmDN97Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=NqpDI/jM
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=jzxGH69G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=NqpDI/jM
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=jzxGH69G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMSVgPPz26J6jsE87t28AYoHb5IGzArVuIUTU8mtJsCbEoeaSauOn87dhkV3tScti/Kq06r5qCd2AzNIxM/8IipydAqqrGxeqd5XirKdOVV4YGHMybzw
    O1z0fauPz00Ycql56NJAOTiCg3tfEVijSBrMQuZbDl8eXAQfCVQeGWv0jnUZAz+Uljw+A2qS9ATFlK2hGZxRE6IVWqnAXxNeCpgWbC5O5C5bON4k6u8kl8V9
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8
    a=VwQbUJbxAAAA:8 a=79sVvFtQNcS5pcJyG9EA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeEUUGf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 16:06:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36725 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeEUUGd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 May 2018 16:06:33 -0400
X-Google-Smtp-Source: AB8JxZoq34fhjxAU3R37kukTx02gtZGQ6dNekBhBztVXOAMo+/WYiJtEkM/LjviWDIhjAOKrt5fdF5ZfjxQp992t6Ag=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <87muwshl4z.fsf@xmission.com>
References: <cover.1521179281.git.rgb@redhat.com> <1081821010c124fe4e35984ec3dac1654453bb7c.1521179281.git.rgb@redhat.com>
 <3001737.MkQ41rgtZF@x2> <87muwshl4z.fsf@xmission.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 21 May 2018 16:06:31 -0400
Message-ID: <CAHC9VhQruN88t-R9Qo3e4hwCZ58RAyrmEmH1nY4RR6NZaiBzGQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 13/13] debug audit: read container ID of a process
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc: simo@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        carlos@redhat.com, linux-audit@redhat.com, viro@zeniv.linux.org.uk,
        luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 3:19 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Steve Grubb <sgrubb@redhat.com> writes:
>
>> On Friday, March 16, 2018 5:00:40 AM EDT Richard Guy Briggs wrote:
>>> Add support for reading the container ID from the proc filesystem.
>>
>> I think this could be useful in general. Please consider this to be part of
>> the full patch set and not something merely used to debug the patches.
>
> Only with an audit specific name.
>
> As it is:
>
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> The truth is the containerid name really stinks and is quite confusing
> and does not imply that the label applies only to audit.  And little
> things like this make me extremely uncofortable with it.

It also makes the audit container ID (notice how I *always* call it
the *audit* container ID? that is not an accident) available for
userspace applications to abuse.  Perhaps in the future we can look at
ways to make this more available to applications, but this patch is
not the answer.

-- 
paul moore
www.paul-moore.com
