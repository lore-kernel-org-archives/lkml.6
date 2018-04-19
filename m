Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625563-1524098523-2-3399234925144684670
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
    1524098522; b=wcWmVkqSHi20zoiPRSHYIAcFHMAxE3sEt6NrkE6k6ONGNgD22J
    QH3JvbqWZvdTZl/Cm7DlLyTG/ZViSs/OG3Z5k6hHKG4GFvi+NZeL6fFg0F2/GnqW
    FwYgDL7sDkMxsE4quj8grYuXZLxIuuF9e/7X09wjbzrZ9YDMKkqDCQHyx7rcOiRB
    9yDhQl0ocxW4NQAEQogfOnG/LiV3SnywLvUDK7SMbHoyEXbb0XheN+gY6JlqvtT6
    u195cANbmwxhxpTa6oXJbHXk4XGrYp09VqcGhZWyDvwITuZfIDaE0yYSlQ5BDC8p
    iExi9hTm6jbcoofxrE4+uFHdXeYsrkJxm2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524098522;
    bh=iyH7O6Yv8zE3WUvwlrk2SHiRCaba/aoVVmf4TySC4nA=; b=SgAjpZn0yNxM
    cemFLaSO9ez7NifvIvEFQjTLePN9riXp5tc/2XrFQ24AzkKAr/BRo58ScwyfNG/N
    NnpGAhjoupzXry5CQ/t4bwr5XoQfP7DaW4F1u121D4RzFBrzW7J1rFuILSaxmKB5
    ni5GGjdJ12uZmZjC6glqXyTPEDHnN3UJmG71tjbiR/yNquzYQqJDQpZVbP63eICY
    i02V704ty+JHq61CTSDPjkWRS9lO1PFM9cGSdkc8IJqHfzHRIEROkeXVvJMbj2MZ
    2fGeGkM/Xglwhd6JWbxZWIsoD5ejAZY69RvPju6HLQ41qcATcz05MbhvBfb9dxxn
    u9Z8BgwgkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=gG3XT5QR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=gG3XT5QR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJVqSFuBCK0NeIHeuMM4a03sWK/PymlVLyz7D0fet22lJS4vslBGbShiGMyUdNe9Js8JFMHWoherwb/VOgLcPJtHh560gGEuOLkNeZFzjDPOB4f7Bee8
    2Cr1YcxBApeNf/x4ooxrK/53cXD34Ina9lPPPGJJ/Zt1nDrDpfXQDbmk8boTdnN85DHXnkNOVSPb7tpS5XTWsn/4UTXifpJLV6O7+4x3tJNeQyj9jSO/KJGU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=Kd1tUaAdevIA:10 a=YOyEBbWWr2YA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=hiQYcd53wgmS5SBDzO4A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeDSAlm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:41:42 -0400
Received: from sonic314-20.consmr.mail.bf2.yahoo.com ([74.6.132.194]:35066
        "EHLO sonic314-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752391AbeDSAlk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 20:41:40 -0400
X-YMail-OSG: YNypZAMVM1l52JEe.RpRLEVlGeCZ0hGU.WqV0uDDLL3DrAu5qlrvH7XALmThr8l
 00_KA4lBSWFhIQiZ1YUbe2NpMpjtE8HRoljGaQ2aCl9IYnn5j.lQw_FeR7ioS5nJdApyjPspDb.Z
 eXlmKzh671B2s3nU0EKvxVD9jX91HPIm0SzpWskeerXVstL2Bk6A1pTaXQ5KrB8FtDA1.HUfg5Rs
 c0jHmd08aNIdA2LmSiO3.hTn.7nqoifjDH3GpRtrO80Ewd4PgIM526m3SY064wmPxDGYGDSkJ4Qk
 y2E8LWB4waCFSD3nqAD7FQ2aYD66bosIHhAf7SDYwYuJfV8gol5HXsJOayjwoMF_gioYYdVipXZ9
 anqQOQBtuSjPLzHqrpZHpEx5er7yydEUp_m_iqQoOAkhzIc9t9r4Vpl_maSm_fnyM8k7.DaiheEm
 c4uTl3hIusGIf2JuKtszqyREicO0zNn4VowsRpGqBGaeu1_To90vJKv1wrE.DHyQAbpBWJd1vGoO
 voTXNxxmbg_K4I.RC_sQ_EK70TeeElqXg4qOEmyo6M7Moop3e8Z3Blc3dR94F3Uy5zB1fkGrrjHb
 QH1NH09FOB8X3PwLS5a9f
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
To: Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
References: <cover.1521179281.git.rgb@redhat.com>
 <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
 <CAHC9VhTyvxxj2e2Gn+iyW6iLLeYB7hp8a+JvfeMmJ2nUPqtEaw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <32d3e7a6-36f0-571a-bb91-67f746c7eafa@schaufler-ca.com>
Date: Wed, 18 Apr 2018 17:41:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTyvxxj2e2Gn+iyW6iLLeYB7hp8a+JvfeMmJ2nUPqtEaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 4:47 PM, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> Implement the proc fs write to set the audit container ID of a process,
>> emitting an AUDIT_CONTAINER record to document the event.
>> ...
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index d258826..1b82191 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -796,6 +796,7 @@ struct task_struct {
>>  #ifdef CONFIG_AUDITSYSCALL
>>         kuid_t                          loginuid;
>>         unsigned int                    sessionid;
>> +       u64                             containerid;
> This one line addition to the task_struct scares me the most of
> anything in this patchset.  Why?  It's a field named "containerid" in
> a perhaps one of the most widely used core kernel structures; the
> possibilities for abuse are endless, and it's foolish to think we
> would ever be able to adequately police this.

If we can get the LSM infrastructure managed task blobs from 
module stacking in ahead of this we could create a trivial security
module to manage this. It's not as if there aren't all sorts of
interactions between security modules and the audit system already.


