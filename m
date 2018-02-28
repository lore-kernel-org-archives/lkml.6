Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813331-1519806438-2-466436042572651765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519806438; b=ZxRFcLw6VQWC03uDHmnm1Sp9LaxNFSti5hRR8+KMiGWJG8M
    M/5ubD0K0SNS6/oyAJFGHVPdUdST9ROOzBQWQPRR/GS4z2RjvDidPgwStZazdHtG
    diR0T4VMrMv/qy51xH6N3wJLjnqDIT4MHgsW2F8g7c/s4Aztg6QvMf38zmZdBzP7
    PLQbwJ0ZJeAWydNxHefJccWYjFN+T7gEdfnwIfchYonxdbjo81Qv54WKc2BiC57R
    QxixtSovYX+1yhb6CiO+8k9uwTCY8H/e/zGXhoGK0d/XE17YJafH7dvM2Pu9z0gj
    bQ20DO03dUFZpA1L11jSA4oCEuRBmJv9eNLye4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519806438; bh=gHhAfmwukSr5fCVw1+jOQYoAqvyHiXYleFDxNNbMfeQ=; b=r
    bq7FFsK8EZlABB+BkJArOi1gdW6u5XePWWhGPq0FLzYvIcmqd3fJ4vGV7eyXxFtE
    5P+FP0cW5/0t6zXGxcGhNUxBtiP8wC0yHzgpO6YEGerROX66k2s/duhzGYSfBlZ8
    Sv6x6gGaJpeluwpKLCeD0JUMD8iwOL2h6IHCYxLFoiqIRUKHPuat3mOthlgSxg84
    r9qjSVdFPApuNsnYWGOOYAV0CtH7+K5BX6XxNtfwqd46nbc74xKjF8V5XD0QDs2V
    6qGFBhncGFdXMw2D2QAYpuCt9vCcMPSSl+NjnyS2to73mpYi0ZssbJJ5jEEMlpJB
    7gRX1QEq6CnT7w5EadjoQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeB1I1Q (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 03:27:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:42289 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeB1I1Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Feb 2018 03:27:16 -0500
Subject: Re: [PATCH v2 2/2] xen: events: free irqs in error condition
To: "Shah, Amit" <aams@amazon.de>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
Cc: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "shuo.a.liu@intel.com" <shuo.a.liu@intel.com>,
        "anoob.soman@citrix.com" <anoob.soman@citrix.com>,
        "Valentin, Eduardo" <eduval@lab126.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <1519746958-52077-1-git-send-email-aams@amazon.com>
 <1519746958-52077-3-git-send-email-aams@amazon.com>
 <20180227170740.jcaxsvpepsn6eot2@MacBook-Pro-de-Roger.local>
 <1519752774.4965.23.camel@amazon.com>
 <20180228081623.umnyv4w67h2rsrwk@MacBook-Pro-de-Roger.local>
 <1519806324.4965.25.camel@amazon.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <ea7f2264-08e4-d107-ac95-89488c144fa4@suse.com>
Date: Wed, 28 Feb 2018 09:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519806324.4965.25.camel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/18 09:25, Shah, Amit wrote:
> 
> On Mi, 2018-02-28 at 08:16 +0000, Roger Pau Monné wrote:
>> On Tue, Feb 27, 2018 at 05:32:53PM +0000, Shah, Amit wrote:
>>>
>>>
>>> On Di, 2018-02-27 at 17:07 +0000, Roger Pau Monné wrote:
>>>>
>>>> On Tue, Feb 27, 2018 at 03:55:58PM +0000, Amit Shah wrote:
>>>>>
>>>>>
>>>>> In case of errors in irq setup for MSI, free up the allocated
>>>>> irqs.
>>>>>
>>>>> Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message
>>>>> groups")
>>>>> Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
>>>>> CC: <stable@vger.kernel.org>
>>>>> CC: Roger Pau Monné <roger.pau@citrix.com>
>>>>> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>> CC: Eduardo Valentin <eduval@amazon.com>
>>>>> CC: Juergen Gross <jgross@suse.com>
>>>>> CC: Thomas Gleixner <tglx@linutronix.de>
>>>>> CC: "K. Y. Srinivasan" <kys@microsoft.com>
>>>>> CC: Liu Shuo <shuo.a.liu@intel.com>
>>>>> CC: Anoob Soman <anoob.soman@citrix.com>
>>>>> Signed-off-by: Amit Shah <aams@amazon.com>
>>>>> ---
>>>>>  drivers/xen/events/events_base.c | 5 ++++-
>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/xen/events/events_base.c
>>>>> b/drivers/xen/events/events_base.c
>>>>> index c86d10e..a299586 100644
>>>>> --- a/drivers/xen/events/events_base.c
>>>>> +++ b/drivers/xen/events/events_base.c
>>>>> @@ -750,11 +750,14 @@ int xen_bind_pirq_msi_to_irq(struct
>>>>> pci_dev
>>>>> *dev, struct msi_desc *msidesc,
>>>>>  
>>>>>  	ret = irq_set_msi_desc(irq, msidesc);
>>>>>  	if (ret < 0)
>>>>> -		goto error_irq;
>>>>> +		goto error_desc;
>>>>>  out:
>>>>>  	mutex_unlock(&irq_mapping_update_lock);
>>>>>  	return irq;
>>>>>  error_irq:
>>>>> +	while (--nvec >= i)
>>>>> +		xen_free_irq(irq + nvec);
>>>>> +error_desc:
>>>>>  	while (i > 0) {
>>>>>  		i--;
>>>>>  		__unbind_from_irq(irq + i);
>>>> It seems pointless to introduce another label and another loop to
>>>> fix
>>>> something that can be fixed with a single label and a single
>>>> loop,
>>>> this just makes the code more complex for no reason.
>>> I disagree, just because there are two different cleanups to be
>>> made
>>> for two different issues; it's not as if the if.. and else
>>> conditions
>>> are going to be interleaved.
>> Oh, I don't mind so much whether it ends up being two patches or a
>> single one, but IMHO the code should end up looking similar to what I
>> proposed, I would like to avoid having two loops and two labels.
>>
>> Could you rework the series so that the end result uses a single loop
>> (and label)?
> 
> That was the part I didn't like much, so it would be better if the
> patch came from you :)

I'd prefer Roger's solution, too.

Roger, in case you don't want to write the patch, I can do it.


Juergen
