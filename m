Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3687182-1522285476-2-10360332405752361159
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522285475; b=Jh4reFrlo3TiRTHZ6GkcKc3eSqHsLn5+AB1t+ukNT6+URQt
    Ryo8ggXI8nzj5N0btJWNYalNN8s6deE45HmW4gq5KPtzQrYKZFgb8N3X2r3ue4sY
    VqU5HhVhWi/IG+n4jBcmfa7Lzae5ZkvnV+Towr/5VA78j4C4rGY2ZRrl0pNkzFvH
    3vvzvwtmJthJ18GBYE+LytNU+W23E82kkuBWsER+JtCPI/35XodkHBx2VkiYnmZB
    UivyLlZD1CZEISV1Xee35dMA5mGpEI4YIjFZzA5pdMc+o9LerEuewlPud/sGPTgE
    4bWrDh55QbcOfx6S8LQeVhm6BjSI3PpmjaxEVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522285475; bh=CDs6sm4VCJSiTeQ6uWLPg6dTF+
    9RrZU4RttmbmnU0C4=; b=KZx5ML0N9ChWut9RwdRf3n2pL+DqCn+YdVuoZsYyXQ
    f/UQMenGygbtuuO8Q2MkWYozGa6hsDwCUIwDcXf3IT2aqFSWbfyp9hmrULjVqG7p
    lKQnT88+/R+5wV83wAWeKO8xXdHRWtQa/V+FUuSptgFuGBdkhKEeTTo/Q6+yLrB2
    h9eylNPTgsLoHZ7lySS2jobeE855Y8ziS0r/qheUt/hq2NG8Kzt1GdlgVZwXBHoR
    8m5UfWFnyEin/y96wlQ14hteI94HLNPDzL7c0YF+4FOrIp0YPewRRV9jTP/CXg6h
    qRjq/XYw8SfMzSAGS2YcvTXa0D0a1q9/qwzlPHqjPm5Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCjpSamVQvoGIvGgo4ZaTN5s06VX7KkzC/eIyJEPPLTC8Fi0iB8gf+/JsUwHEzquGWVNzsFteFs7S2ZGroMh0t6LqEHFqwqJh5XPVBnM/1/BZ8tmwTXZ
    cJGbIc6t5JDSTrUm6pVdAD77YzzIRrYQDElbhXfDi2+OmGz4vXQni6FvAk3BR2RFLSW3Bv06HJoicdfJY/v3u9+hDVytODDW+pEAA8ek1L8sM6elHsFWN9u0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=Hp-sbZQ5ZKWoTNnHJRoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeC2BEd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 21:04:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751088AbeC2BEc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Mar 2018 21:04:32 -0400
Date: Wed, 28 Mar 2018 17:52:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Subject: Re: [REVIEW][PATCH 11/11] ipc/sem: Fix semctl(..., GETPID, ...)
 between pid namespaces
Message-ID: <20180329005209.fnzr3hzvyr4oy3wi@linux-n805>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-11-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180323191614.32489-11-ebiederm@xmission.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018, Eric W. Biederman wrote:

>Today the last process to update a semaphore is remembered and
>reported in the pid namespace of that process.  If there are processes
>in any other pid namespace querying that process id with GETPID the
>result will be unusable nonsense as it does not make any
>sense in your own pid namespace.

Yeah that sounds pretty wrong.

>
>Due to ipc_update_pid I don't think you will be able to get System V
>ipc semaphores into a troublesome cache line ping-pong.  Using struct
>pids from separate process are not a problem because they do not share
>a cache line.  Using struct pid from different threads of the same
>process are unlikely to be a problem as the reference count update
>can be avoided.
>
>Further linux futexes are a much better tool for the job of mutual
>exclusion between processes than System V semaphores.  So I expect
>programs that  are performance limited by their interprocess mutual
>exclusion primitive will be using futexes.

You would be wrong. There are plenty of real workloads out there
that do not use futexes and are care about performance; in the end
futexes are only good for the uncontended cases, it can also
destroy numa boxes if you consider the global hash table. Experience
as shown me that sysvipc sems are quite still used.

>
>So while it is possible that enhancing the storage of the last
>rocess of a System V semaphore from an integer to a struct pid
>will cause a performance regression because of the effect
>of frequently updating the pid reference count.  I don't expect
>that to happen in practice.

How's that? Now thanks to ipc_update_pid() for each semop the user
passes, perform_atomic_semop() will do two atomic updates for the
cases where there are multiple processes updating the sem. This is
not uncommon.

Could you please provide some numbers.

Thanks,
Davidlohr
