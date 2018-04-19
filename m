Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3169877-1524143245-2-14952397673530003883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, TVD_PH_BODY_META 0.001, TVD_PH_BODY_META_ALL 1.799,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524143244; b=VJD0Dh7l+d5EQfk+ttGX2Xp+VpjvaOl27PYUspUeaJqRuJjPXP
    JXPFrpAjqyd5pNn844zEFHNH3vBF8ZeKOQ42qpppOC2Q5cORhoCUVvwJxAtQ9pkE
    /8YDFcijlorzjJvq94C1BASItQkhCY8jj0cqtM7dBn1NaEZzLLRcQ5fmjgIXMRuS
    BMgEyMH3OQDuuYyndeMQkoxffDSc8FgFOnCJxw79mUNP/1F/4R0mRX2Cp+ptwp22
    wjDeR4GFSoGdwQpfnocDl4ZoVhAZOV8BWM6JYIhz/uRSbKuLg3llA6JuBlJj1xQc
    WaytgLYB1In30oFIHdDvbm6/eQbrqAZJiKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524143244; bh=pzKdzzKUIglkEYRMoE1UUiEX2icTpo0v7cF5JfKVvQ
    4=; b=IpriS6LGzk3gJmQAvAgZq78VAng4y+xhOvzROKaQInAGfAu5PFBZf4DTBf
    sL6EdX6KSWc3YQ6BgKYN50vqWZybOVke5FPUFQKZo6Fyvl+Ga8uyf0fwMhlqMKV0
    H5Mo2wWz/CYOKRFdWFy/+yWwSb8HLzoo7y0m0NuZwEt/qpYHhWxVgegZst+krRes
    ZFesQ60ZHTd0rZhPTUK8qKybwmqsdAjM5+rrDMwq9k+AHPNX1BHy1iZrIOgPG39P
    GSOwOtqVXvIFr5pnFXe8z67nH80w0CBDMOewM8nPWRLohFUt8kNmo7FOENHxlXG9
    Nnalf8VWXzaUz1Jf/Eca0eWYs3ew==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=KhiS4Naw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uhx98SeH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=KhiS4Naw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uhx98SeH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC2++9ZcrXTTEUQxa1+tSBIj80pWndCGCceTpOim7WUBgpBwuiroBEX0tZhFGp/dyPzvDLRBXGRht1QRqE3nmfoZ5hCkum/EhHhdmCNkIs20Vqq5AMcd
    Vmju8DKQ2zdsBmK7P/GCbpdfTg8dkkYGSfFLwxR1nLTqfXAXKs379DU0BCDKhP2rPPqbp2a4TQBcxn47o2ogjNhlH1vagmAawERjulAbABjfDOcGpwpS3ovD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=x5Lm99rlCkR1DWchEPEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeDSNHW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 09:07:22 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39497 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeDSNGq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 09:06:46 -0400
X-Google-Smtp-Source: AB8JxZpEOVEUq/18WLwTkvUZw/BHIKa/ZFWhGp/aaiMeoU4RVZqdVxq8Y64GWip2eNeZrB+NLq+EzgM68yqom9ekdUI=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180419123109.ab7gsnwrbtog4tbf@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <c34a7a95eb045a62e2443457979db9d7afbd9aee.1521179281.git.rgb@redhat.com>
 <CAHC9VhQ-i5oA48sXXnN2fP06t5=9-NMoY0bKcGXorQw2k=CK0Q@mail.gmail.com> <20180419123109.ab7gsnwrbtog4tbf@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Apr 2018 08:59:29 -0400
Message-ID: <CAHC9VhRL2PT65_c1OR=SNnicR+XVx33ZuuCttJ-OG+g3aBzsxg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 09/13] audit: add containerid support for
 config/feature/user records
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 8:31 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-04-18 21:27, Paul Moore wrote:
>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Add container ID auxiliary records to configuration change, feature set change
>> > and user generated standalone records.
>> >
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  kernel/audit.c       | 50 ++++++++++++++++++++++++++++++++++++++++----------
>> >  kernel/auditfilter.c |  5 ++++-
>> >  2 files changed, 44 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/kernel/audit.c b/kernel/audit.c
>> > index b238be5..08662b4 100644
>> > --- a/kernel/audit.c
>> > +++ b/kernel/audit.c
>> > @@ -400,8 +400,9 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
>> >  {
>> >         struct audit_buffer *ab;
>> >         int rc = 0;
>> > +       struct audit_context *context = audit_alloc_local();
>>
>> We should be able to use current->audit_context here right?  If we
>> can't for every caller, perhaps we pass an audit_context as an
>> argument and only allocate a local context when the passed
>> audit_context is NULL.
>>
>> Also, if you're not comfortable always using current, just pass the
>> audit_context as you do with audit_log_common_recv_msg().
>
> As mentioned in the tree/watch/mark patch, this is all obsoleted by
> making the AUDIT_CONFIG_CHANGE record a SYSCALL auxiliary record.

You've known about my desire to connect records for quite some time.

> This review would have been more helpful a month and a half ago.

If you really want to sink to that level of discussion, better quality
patches from you would have been helpful too, that is the one of the
main reasons why it takes so long to review your code.  Let's keep the
commentary focused on the code, discussions like this aren't likely to
be helpful to anyone.

-- 
paul moore
www.paul-moore.com
