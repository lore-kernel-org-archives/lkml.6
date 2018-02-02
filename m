Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2074586-1517563982-2-16192193221498755433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_03_06 1.592,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517563982; b=PM5bNKNbFNCgaQoie+KlCiUqxX775hjnJBW4YIhydR7QPZb
    59FWZp16p1nt8GoiqTl7sX+avmHBw/lHgmceZDzC2PnWfhpol3wxPrB4X0WLtTrO
    C902sjbo4W4WnTbFnfX4REmdverxK67yXu4LM/AZ2EQUeYwGAAWGopwR/dF6lNXF
    EVGZC3wgZVLYrbVSXGfZEqJ7Rd3BHU1czEyWJ5791p08WeUKnIPv3kID9sgy1WDL
    IcXNh4QbtFVfzCGBAI/5WWUEwJ0ntUWm3j8eg3/cEinJ+ck/s6iT5sitmTUZcxKl
    g/9y4zwr89ny0P+eayczoTZO2OoGCi55167P+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517563982; bh=PelU/mBgoHhagA5Qu8lbssM1C0RCskRXG0wV5z6S88E=; b=N
    yIuNv3T1ANXbsOylfNaM4iAKWV/o2eDA1Bzp8XpsON1VkUMJDH+t+u5JNyBOJ8QQ
    zGdttP3tckl5W0hZ2XxDysxrVYRjBn97UD07lR+PfibQrUhshjZaoaN8k61VzMVw
    6xLDDaukMgTVUUp9f6zowLYQEp3yaW9DZzBa938Ki9/4oVNwVbOXZUet5dLKGNFv
    5w6b8IzWKhOoZE3FkmSKFeXXQWDpCD97RhbJ3cIm3prOy8T134B2zrQAC8Lt+4cQ
    UPeol1ngd5obEIj56i3sOXAyFROlvIi5qGDLoZz79+Egjnc501K+w5KBRChmydvx
    tgNeF39AL9mHQO54la7hg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeBBJdA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 04:33:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:41335 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbeBBJca (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Feb 2018 04:32:30 -0500
Subject: Re: [Xen-devel] [PATCH v2] x86/xen: init %gs very early to avoid page
 faults with stack protector
To: Chris Patterson <cjp256@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        stable@vger.kernel.org
References: <20180201124019.11693-1-jgross@suse.com>
 <b8f04374-97f1-76d5-81b5-3583441833f4@oracle.com>
 <CABZSBQcmKBGZ2-i-YRL=Ux6hcAP0peR1zfaVh4Go9vr=JTRThQ@mail.gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <3a4fa32b-7909-9fa6-4b6c-71d6b51ad35d@suse.com>
Date: Fri, 2 Feb 2018 06:56:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CABZSBQcmKBGZ2-i-YRL=Ux6hcAP0peR1zfaVh4Go9vr=JTRThQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 01:36, Chris Patterson wrote:
> Works great, tested it and it fixes booting Linux v4.15 kernel for me :)

Can I add your "Tested-by:" to the patch when committing it?


Juergen

> 
> Cheers!
> 
> On Thu, Feb 1, 2018 at 3:17 PM, Boris Ostrovsky
> <boris.ostrovsky@oracle.com> wrote:
>> On 02/01/2018 07:40 AM, Juergen Gross wrote:
>>> When running as Xen pv guest %gs is initialized some time after
>>> C code is started. Depending on stack protector usage this might be
>>> too late, resulting in page faults.
>>>
>>> So setup %gs and MSR_GS_BASE in assembly code already.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>
>> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>
>>
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xenproject.org
>> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
