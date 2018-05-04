Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3350284-1525392726-2-17421880315540267186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525392726; b=Y9ZZV7/FWgwkazdtyEeJb323UIOgOMkiGFKR+YsJuGhMs175ci
    lhCi56XGdHTfCd4up2DsAOl4WPxJlqKNb2G/LOADvlcHYdVsrvUUJXE5AeSK3FEb
    QcSGNOi5wYLxTV0SUza409LQ0P7U1I3Br+VNtDSovqsc0ut5Hbn5/JgBF6eyj6tr
    L4AVxt1ZVKo5LOoz8cZpACGA6BF0i5/Mq74Yu6C1Mp9opA+iPwn7pyePvKP+w6SU
    LLWyTyMd4toPt80ZSi9n7QM95OgBxqJh9Ap7/23yS8EsA1EMrrQpaKJpSIfcE+ha
    IGMguvM34XLajA8Gq8Ghbj1dMHs5wTRdkmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1525392726; bh=kRfx9Z8sETKXycMfeaNqrPTSxJusymz
    ezYxjsWuLkb8=; b=E5D0RLD4rqD+KQDAkrn7znAEvjIL8heSrUJFAoWkPJ/Z5M6
    Elx6EgTOnWdAijhgnny5Yfey2jnEJF9ixeGo4fQzOhbJkibwYB4Ji5R3aYDNaFpe
    L2r7f1ZwfzYpG6hisod7387N4vWyxL5JChLV6n0aEOsZ/8lfuEjQSIdLCYqO6pOU
    37QKcda2lQ+LcQ4NDt4kklparTWErJmWg0D+zcktOymYR2nOoHqw4dLao5jIH4ga
    tbdY8fKnaR+MXL6A4o63hkfn5QMUYoOFs0WINioby4rOoodb6ZWyy2pQDwveK1dr
    6m2TtTV+OuYQla37qmQ/3EWWE2JSVYyixj1lWxA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKixWP0DXxXiVDQgZRU/OvYnl8xRTgF78cHomrmwSLsVAIpEbK4TFYehCJqakXN9Oij+RrJbBFlNJSdzeRJJdXko7TaCLDQDxEbbWp7N1eI+1H9B7Cfz
    ZB4kgfjUYASe2FvzP4G8UzScRiu2J8iPt01YonncH20YLnv/OfYtFb1151OJTfMjxKakEh6cBxkni+M3sLkmMMxfX6uwjUyb16p1twjIbqWfG9weZ6NaOOqc
    NC9Z0ZTJgQYWK09659n69g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=AycjEXJFu3AA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hlpFoNB0AAAA:8
    a=lB0dNpNiAAAA:8 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8 a=f6zP6Sig0-hto9aFZIgA:9
    a=CjuIK1q_8ugA:10 a=kMYpNb-kQgMLPvQdVK_m:22 a=c-ZiYqmG3AbHTdtsH08C:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400"; d="scan'208";a="221488513"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 1/4] staging: lustre: obdclass: change spinlock of key
 to rwlock
Thread-Topic: [PATCH 1/4] staging: lustre: obdclass: change spinlock of key
 to rwlock
Thread-Index: AQHT4uWKeBM3CaAgP0S7TBmjqoBdPaQfKJCA
Date: Fri, 4 May 2018 00:11:54 +0000
Message-ID: <55458B75-4105-4F4F-BB50-3D506611AB24@intel.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-2-git-send-email-jsimmons@infradead.org>
 <a3594bd7c393418c8fda5150a075ff1a@AcuMS.aculab.com>
In-Reply-To: <a3594bd7c393418c8fda5150a075ff1a@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-ID: <D4A96B45CF899248B046359C410FCF29@intel.com>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gu Zheng <gzheng@ddn.com>,
 Li Xi <lixi@ddn.com>, NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>, "Siyao,
 Lai" <lai.siyao@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On May 3, 2018, at 07:50, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: James Simmons
>> Sent: 02 May 2018 19:22
>> From: Li Xi <lixi@ddn.com>
>> 
>> Most of the time, keys are never changed. So rwlock might be
>> better for the concurrency of key read.
> 
> OTOH unless there is contention on the spin lock during reads the
> additional cost of a rwlock (probably double that of a spinlock)
> will hurt performance.
> 
> ...
>> -	spin_lock(&lu_keys_guard);
>> +	read_lock(&lu_keys_guard);
>> 	atomic_inc(&lu_key_initing_cnt);
>> -	spin_unlock(&lu_keys_guard);
>> +	read_unlock(&lu_keys_guard);
> 
> WTF, seems unlikely that you need to hold any kind of lock
> over an atomic_inc().
> 
> If this is just ensuring that no code holds the lock then
> it would need to request the write_lock().
> (and would need a comment)

There was a fair amount of benchmarking done for this that shows the
performance is significantly improved with the patch, which can be
seen in the ticket that was referenced in the original commit comment:

https://jira.hpdd.intel.com/browse/LU-6800?focusedCommentId=121776#comment-121776

That said, it might be good to include this information into the
commit comment itself.

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation







_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
