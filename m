Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2022578-1524240822-2-13581895287264128875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524240822; b=NNlvsKJsYhJEfUn6R1RuuJajhnTZvK43+Av1RDmTKN/G98Jh8M
    p7fwIJDuj1R2QyzcksGW0SVT1Tw9pfjxMcDzD5gyd4tK4OCYX8Harmi7H9P7t0TD
    CG02vOs3Mt+NhjweiZ4FLb9ms8njbuJsa4pyFf+LXVGv8qSC58JdL3z0FkYalOyQ
    2WHgo6aN97pJv5BrykHIA3/vzkmx34eEKkX6DKdpnmXzmBKBzposHoDSxKhfXMHR
    kWtVHS3MdEb7DRewYAj8XEQUBBy7lZsaVnn6YOD3UzjHa9TL3lFN13fgOd1MPYab
    bNYtDu7x1SrLpQzGYvKyO6UKkWcs+rq21F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524240822; bh=OvXwdrBOqr7bmjNb4EyMXhtNpTa/ynaM510z7/64Fg
    Y=; b=sOHfyp6Hmo1wTnMHNNxRg+Np/UBhZkliL6aqxruZWFlI4km1PM4cIfm1/f
    XuD3PMrAwfyWs9JBN7GTOVWk1gjKeYh497oaekxTdqKVJNmC1Tl6L0oCXrRuqzMK
    +U5p7o6aHeVRtLYr+28J1HGMjQKUtfvom4JEmrI6F43F5PlQUekuhEvXcshsJwTa
    A6hct9uqL1mPK9a+atkfKW9GFwF7Dp7MJ2woCN8T9h46j0+ADMWY69zqo2t5sg5r
    12u2cSWX7/gjBaI7x/tQkYWjtAO7K0h6tpkBvo/qjTwZkZ+QbGdu2AmRV7aNG6dA
    JP/Yfont/TKOXfHg7605NpVEC92Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=DmHxRF+A x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H+YbL1zs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=DmHxRF+A x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H+YbL1zs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHKnLawYGCp9fHCDMXIV3aHOyqG0ZaHc6BHosHH58zuzn0hyClaiJi1Dw/PsukmA6KEqROv/wKGokfShO6aKaQmsev2ijSGbK0DK3LtwNljv43e30Nh
    aQjC05lJ3p5G8iJ0tAKu6/6ZNmSDEmJiHClOh3dfVWedpHkCBErS/5ipOOAOZcTBDT/NhKy6sHVOL4Xw6wbHZEeQTp1yE36uhLc2U4XkJoYPegdWBHCbJCzE
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=X9SXLyVxLOdWK8x973EA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeDTQNk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 12:13:40 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35813 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeDTQNj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 12:13:39 -0400
X-Google-Smtp-Source: AIpwx4/u5bK7mzyluVKDGzN8geWFWmp1O4phxTHXWBfkazAWXd6vzVWJFbok9Olao14PN87DUZ3xT1sPSJYRBjhBwDY=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180420010320.panie6mtdafxl65y@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <8c7ff567377f4a83edac48e962c1b5b824b523c8.1521179281.git.rgb@redhat.com>
 <CAHC9VhTy4fX1hYfD5tppbP-fRaVRMXOfeJ=Et96J_rc7Jw12Bw@mail.gmail.com> <20180420010320.panie6mtdafxl65y@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Apr 2018 12:13:37 -0400
Message-ID: <CAHC9VhREkg3uEkhMdKTM0S9-jXTR4LF_T5R2rgdNyfCo_4Meow@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 05/13] audit: add containerid support for
 ptrace and signals
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

On Thu, Apr 19, 2018 at 9:03 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-04-18 20:32, Paul Moore wrote:
>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:

...

>> >  /*
>> >   * audit_log_container_info - report container info
>> > - * @tsk: task to be recorded
>> >   * @context: task or local context for record
>> > + * @op: containerid string description
>> > + * @containerid: container ID to report
>> >   */
>> > -int audit_log_container_info(struct task_struct *tsk, struct audit_context *context)
>> > +int audit_log_container_info(struct audit_context *context,
>> > +                             char *op, u64 containerid)
>> >  {
>> >         struct audit_buffer *ab;
>> >
>> > -       if (!audit_containerid_set(tsk))
>> > +       if (!cid_valid(containerid))
>> >                 return 0;
>> >         /* Generate AUDIT_CONTAINER_INFO with container ID */
>> >         ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER_INFO);
>> >         if (!ab)
>> >                 return -ENOMEM;
>> > -       audit_log_format(ab, "contid=%llu", audit_get_containerid(tsk));
>> > +       audit_log_format(ab, "op=%s contid=%llu", op, containerid);
>> >         audit_log_end(ab);
>> >         return 0;
>> >  }
>>
>> Let's get these changes into the first patch where
>> audit_log_container_info() is defined.  Why?  This inserts a new field
>> into the record which is a no-no.  Yes, it is one single patchset, but
>> they are still separate patches and who knows which patches a given
>> distribution and/or tree may decide to backport.
>
> Fair enough.  That first thought went through my mind...  Would it be
> sufficient to move that field addition to the first patch and leave the
> rest here to support trace and signals?

I should have been more clear ... yes, that's what I was thinking; the
record format is the important part as it's user visible.

-- 
paul moore
www.paul-moore.com
