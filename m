Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763119-1524100578-2-6365007015760241858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524100578; b=hADPJ2A8tfv62KdlBD6LN9/EFjZUn2Lvdjoaw5ylA+HXXwVaih
    y/q/gmzS9v6iVcAjATB3e8XwaNCmMoCvYATEGqKjr67HrO/q9UOoBp/LIPc1QodZ
    xtCPi/7wJdLX7ycqLrw//GGWI+FnYkOB38CpS12ioiwn/dGBVycO+5HSCeBJb3J4
    zlmdS5WAFd61/zTmTb85fdHOnHbD+9cPISXIFn2gEaxO8F3wrQ8nUpnwPA+CAJbZ
    EuDcjvMlRc2DhkOdAVNdiFv704G3sJXYmthtAmbVhHZTTKIy2Q3PjTAjnyLlv9yD
    UpdmBDS+oMgbc7itB4GGPwJQ1qtgCrnmzZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524100578;
    bh=bZyRvNFsE3MuHCIIyc+sOl+9HIdDqmbPD1XpEUlfxPs=; b=vPRfoFFhQwMc
    2AnpEfY9PiT0vrNzPep+HfGliHMrYVFeN9fHIqNvPmX5snEFq+SmDBPpxQAIJCb3
    exLuJjZMzr3G/luv1q2+9PgBjHx85rieZovW/6yqH0Sk0Fi1xShjJF5+l54Jte+T
    lzJ0F2T8tgv9rD5In2k1KnIZ4KXfWJ253OVvc5+/HdIqDzCDjWs9rZZ5yBFAvrO3
    3guTBeK6V2Ym2/TzKLiZzorpqsqXclthZozocyQv5x8fIiIPgekjYh6PrSi6e3Cb
    H+w91mDQEEL6ps38brF4evQfBxI1G/QpsSYj6uEcHt8qz1hlnwe/BE0y9WT9Jxer
    OrNwT9HAHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=PLazFpB9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=PLazFpB9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK1edi2tTXidpUT4EvyGJwmHml3p1t5EN1+Im/5owjE0iT7fXriMgfXzwN0vCbTywAHjwwll0dn0gs3glxXmQ2WRcDr3/BXQCcIWrngpIM7PKDrvvQ5a
    7Dxy18KWx1y6bgoiHkhiZ2Ra5K+qgZwl/iSc5REEOaAjGLRJ0Qu1oQ47KhswEVD01voRbO657zGrQs7XPHzTsgwmjRvJ+A595BfW0Y4HsBrE8PjcNkxofJaI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=Kd1tUaAdevIA:10 a=YOyEBbWWr2YA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=vpqfxihKAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=0Oo42m8BVYP7GxH5SdkA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AULIiLoY-XQsE5F6gcqX:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeDSBP6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 21:15:58 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:44946
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752135AbeDSBP6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 21:15:58 -0400
X-YMail-OSG: 6ETDIScVM1ngf1IZvXwAtgJzQf3EaZScWdTJ3y9dzUpW7u3iFXGKYLj96v7W8.U
 _l8R9HTkwUwcQCBvSsmR4Aj9YuvZQ9idZBrfU6WmCFwJWHXrt3aSVqampSfcwFZR5V678QMqn8w4
 gztM39f33TfQIt1nVV5QsdLe1qwshjrxZlTToqlHRTJHKE.swX0pB9fBQc6qoFvXWAd2Wjf_l0LB
 N.WtZQb0OkJG12xgjk_9QymAMzREFD8pG7wqRBdee4tA3us.MAGmmr46SmYqqRsdZXRBbtTPeLob
 4dXB.EvZDYVA0D2dw87ROb1coH2DqDFgiPAdbTzGyvYRlO2VXCDZOO9XffcU80d4NqxnUvnSd3Ax
 4GpSWYRIkoN.ZTMyuL0VmHwMW1XMdPgmn4MC4m3f2.hcNy4qJ1.NWe3rTs2Evga8S08ZWwuez2rX
 ge.48rT_Q7txMtoL1x.dwdU1CHnRVmrT8AWsS_mPs8gDqtE6Kesem5DMHTO6iDzPE_PWqkH1Gwqi
 UtJl5gMRCmXS4mG8Y8o0riNhoyssuRhaDXQuqz2E9B4W082W0yleUHA8v7xdJaknJMTsAjCb1SB0
 jxN.kHK2HZjjpRTFgZToW
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
References: <cover.1521179281.git.rgb@redhat.com>
 <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
 <CAHC9VhTyvxxj2e2Gn+iyW6iLLeYB7hp8a+JvfeMmJ2nUPqtEaw@mail.gmail.com>
 <32d3e7a6-36f0-571a-bb91-67f746c7eafa@schaufler-ca.com>
 <CAHC9VhTz-pr-iUVv-+R3ShwEKSHDsweDGuN7255HV7Cu3ZYPEw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1adffa90-020d-54e1-fbf5-7fc929ccb44c@schaufler-ca.com>
Date: Wed, 18 Apr 2018 18:15:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTz-pr-iUVv-+R3ShwEKSHDsweDGuN7255HV7Cu3ZYPEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 5:46 PM, Paul Moore wrote:
> On Wed, Apr 18, 2018 at 8:41 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/18/2018 4:47 PM, Paul Moore wrote:
>>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>>>> Implement the proc fs write to set the audit container ID of a process,
>>>> emitting an AUDIT_CONTAINER record to document the event.
>>>> ...
>>>>
>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>> index d258826..1b82191 100644
>>>> --- a/include/linux/sched.h
>>>> +++ b/include/linux/sched.h
>>>> @@ -796,6 +796,7 @@ struct task_struct {
>>>>  #ifdef CONFIG_AUDITSYSCALL
>>>>         kuid_t                          loginuid;
>>>>         unsigned int                    sessionid;
>>>> +       u64                             containerid;
>>> This one line addition to the task_struct scares me the most of
>>> anything in this patchset.  Why?  It's a field named "containerid" in
>>> a perhaps one of the most widely used core kernel structures; the
>>> possibilities for abuse are endless, and it's foolish to think we
>>> would ever be able to adequately police this.
>> If we can get the LSM infrastructure managed task blobs from
>> module stacking in ahead of this we could create a trivial security
>> module to manage this. It's not as if there aren't all sorts of
>> interactions between security modules and the audit system already.
> While yes, there are plenty of interactions between the two, it is
> possible to use audit without the LSMs and I would like to preserve
> that.  

Fair enough.

> Further, I don't want to entangle two very complicated code
> changes or make the audit container ID effort dependent on LSM
> stacking.

Also fair, although the use case for container audit IDs is
already pulling in audit, namespaces (yeah, I know it's not
necessary for a container to use namespaces) security modules
(stacked and/or namespaced), cgroups and who knows what else.

> You're a good salesman Casey, but you're not that good ;)

I have to keep the skills sharpened somehow!

OK, I'll grant that this isn't a great fit.

