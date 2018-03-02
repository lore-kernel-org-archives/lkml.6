Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1873148-1520005744-2-15237947911349641735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520005744; b=SCqup2jtYtTnPErb1RrwgTpNobG/auBZgx8sv1h376uLK0E
    t0I0PVpUJBetrR1Z5FyLcOCnUECIU5UAQdxhbL1gX/elTY6Lq9CP74IV7OIufDj+
    XXbx6Ieh5ayCMxD5OvavpiuZD+NBS8j0Ix40CEB4mIiN3PL01cXgxVSSly84diFq
    LrPSAqwc/VoEop/+ywe/DBaZMcupE798teUHp5ceAt18muNzlr6TaRw/73k5lmQQ
    ONsrCaNrQI348AvA/uZyR2N8SQUAzL9i+60f7hPBPVkQMFW9n5sHFczzRVPioJyF
    Tu1CgowI3d7uTC9u8n5vj9KK2Zxir01QL+u9u2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520005744; bh=NxXryif0Kp62TpGxWzCT/tZnkseC5Hs5Z+8ahv
    ftvVM=; b=tLiGyS6YQNIs9QdH/+xvyK9Ptfsx+/k8p9DDIHMgLbDdNC3YMdDpmb
    O2CYPp/LDVbWu+ASisurNWlxQM+nhJwBT0qv1gZenbYHBAxArv+AmJVVZcm4pnbO
    XNsLFOLoGcnLX76dbbny9/1MwEIO1AqiKeEIerbPyag/4H/+3Xbfu3Shc5koqIJW
    1AxpDgiKG+MLW4cW4iQN5hC1xD5sdyepDaezSMmyVjyMFp2NXDkqUUnDHGWinaYK
    3Gi5nHO6BgtxteFdHvAkd01fEvg4Vn1FM6LHwuYUhn7fCk94ojeIVyVqG1kexqCf
    xnX+F7LtooZqrpkHV8VV6OEv/RWhE6CA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=JPDMsPOp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TSztUL4S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=JPDMsPOp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TSztUL4S;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424550AbeCBPst (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 10:48:49 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:38545 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425054AbeCBPso (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Mar 2018 10:48:44 -0500
X-Google-Smtp-Source: AG47ELsXXnhAzfIJsieZK5mLOl9c7rjj0mMDT+womLlgozooJ+KihALJRbqShYdKjBf9yjAugel0UdmcUKUGhLKsqf8=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180302014101.jtfd2eeyxmvxcjpf@madcap2.tricolour.ca>
References: <cover.1519930146.git.rgb@redhat.com> <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <20180302014101.jtfd2eeyxmvxcjpf@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Mar 2018 10:48:42 -0500
Message-ID: <CAHC9VhQi2QC8_e1fgYr=bfTACdtpgXZubc6S18r+1+9qf6TJ8w@mail.gmail.com>
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, ebiederm@xmission.com,
        simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, luto@kernel.org,
        Eric Paris <eparis@parisplace.org>, trondmy@primarydata.com,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 8:41 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-03-01 14:41, Richard Guy Briggs wrote:
>> Implement the proc fs write to set the audit container ID of a process,
>> emitting an AUDIT_CONTAINER record to document the event.
>>
>> This is a write from the container orchestrator task to a proc entry of
>> the form /proc/PID/containerid where PID is the process ID of the newly
>> created task that is to become the first task in a container, or an
>> additional task added to a container.
>>
>> The write expects up to a u64 value (unset: 18446744073709551615).
>>
>> This will produce a record such as this:
>> type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
>>
>> The "op" field indicates an initial set.  The "pid" to "ses" fields are
>> the orchestrator while the "opid" field is the object's PID, the process
>> being "contained".  Old and new container ID values are given in the
>> "contid" fields, while res indicates its success.
>>
>> It is not permitted to self-set, unset or re-set the container ID.  A
>> child inherits its parent's container ID, but then can be set only once
>> after.
>
> There are more restrictions coming later:
> - check that the child being set has no children or threads yet, or
>   forcibly set them all to the same container ID (assuming they all pass
>   the same tests).  This will also prevent an orch from setting its
>   parent and other tit-for-tat games to circumvent the basic checks.

FYI, I think you may have a problem with something in your outgoing
mail path; I didn't receive the original patchset you are referencing
and it doesn't appear in the mail archive either.

-- 
paul moore
www.paul-moore.com
