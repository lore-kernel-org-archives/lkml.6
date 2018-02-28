Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333886-1519829784-2-1952547033457680293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519829783; b=CsXHQ1mbQvUkLvhdC+E44YZn2Y9Ixocnhlr/etwmRAK9/PL
    y9x6yDuOnMP3yLs/zzqBt4a9kiiCAerxKF+2qloJlV+tlB69ffCDLqrPbdAlzkTR
    uDX7xT3TRD+ssAxRfLF9Fm4mcHonbeXmcUE3SmiuBm/YzLTnTKndZwM7VErBg78e
    pPiGbuL3yeP1V5eJCc9IPH9neUR18/6Iu6FRHr07KzMj0SSvDFWXThh+GYHOmfTu
    kcm4ynsVMfylLSQZSkezUQ0pASQh1OIY/3zxdyZP2KSIYsgjjukY85UvHcRnRh4J
    hug+SWKrBYnCJu29pymjHbrPU7+YaTH4wbitj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519829783; bh=q3I7Rx8jjdcFuECnOWDFL7qb6kS4B68TpL8JvG04CwE=; b=q
    J4V34lwsmrUedOUzaGcQbegFnJL1tn8bArrvPIikupa0qvdZ66Ed8OQZBXVznPfQ
    Pvsgz+i6JJHMiEE89Pz1UH7clcQcMILDeTMJmwQiKzxoHPGZN1XaA4VGpb2vcgw8
    hEWtCkeeYlJIGrQSH5hK8RiNkbJbad7k5eVRq8wp8iSeMznzWoqgsgV1p/T4QLwd
    2mR9cLm//OYZ2v7MMzD0Nh18qGAMbF8jtq2TJQ9ZlikTnNsrzrjFDSBf+d5eEHmM
    kXILxVd4HryWTciPeuL8nIPLveD18wZYqBq+A0Ssst6AeFFiDPxpp9OH9i57HCc6
    X2wmv+HbHvxQg+RQk7H+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=rfPeS7eW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=rfPeS7eW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeB1O4V (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 09:56:21 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40916 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeB1O4U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 09:56:20 -0500
Subject: Re: [PATCH] xen/pirq: fix error path cleanup when binding MSIs
To: "Shah, Amit" <aams@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
Cc: "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20180228091903.99889-1-roger.pau@citrix.com>
 <1519809769.4965.26.camel@amazon.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <a4e23dd6-a013-772f-3167-cf4fd92c21e7@oracle.com>
Date: Wed, 28 Feb 2018 09:57:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519809769.4965.26.camel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280181
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/28/2018 04:22 AM, Shah, Amit wrote:
> On Mi, 2018-02-28 at 09:19 +0000, Roger Pau Monne wrote:
>> Current cleanup in the error path of xen_bind_pirq_msi_to_irq is
>> wrong. First of all there's an off-by-one in the cleanup loop, which
>> can lead to unbinding wrong IRQs.
>>
>> Secondly IRQs not bound won't be freed, thus leaking IRQ numbers.
>>
>> Note that there's no need to differentiate between bound and unbound
>> IRQs when freeing them, __unbind_from_irq will deal with both of them
>> correctly.
>>
>> Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
>> Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
>> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
>> ---
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Amit Shah <aams@amazon.com>
>> CC: stable@vger.kernel.org
>> Cc: xen-devel@lists.xenproject.org
>> ---
>>  drivers/xen/events/events_base.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/xen/events/events_base.c
>> b/drivers/xen/events/events_base.c
>> index b241bfa529ce..159faf1269fb 100644
>> --- a/drivers/xen/events/events_base.c
>> +++ b/drivers/xen/events/events_base.c
>> @@ -763,8 +763,8 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev,
>> struct msi_desc *msidesc,
>>  	mutex_unlock(&irq_mapping_update_lock);
>>  	return irq;
>>  error_irq:
>> -	for (; i >= 0; i--)
>> -		__unbind_from_irq(irq + i);
>> +	while (nvec--)
>> +		__unbind_from_irq(irq + nvec);
>>  	mutex_unlock(&irq_mapping_update_lock);
>>  	return ret;
>>  }
> Reviewed-by: Amit Shah <aams@amazon.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
