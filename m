Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1743198-1521034288-2-2923205134899124209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521034287; b=d7PhinNM91J39+058q3VQIZVrioFdeJ9mGR/Pt2hjOq1gqZ
    cBETpf6YdzwUbn+vCGTNXpkfmR+R8d6hpkFh99ZnrIayuw5+2dbpfhm9lvP4UWJv
    HSh8ic8EDUFcV0cZMKLwwPyoiQi7cseCMRgvocejJyZBk67PaO0CpoATimyeGd/m
    KlUBye/zH+VPrvAsBz6MKEGcusBBPgFsKsN4cyfZDsvbYlRNQdemPMX2iHke+1Sd
    cygdq4VgvH9HFWLfLFRtn2598S2NPD6WW9XgE9jZ8WkOYwb5U3c94Zs7cEFA9ecN
    3J8Z764pJTOaCUD0JgZ3LpXBruW7j2LAnJFm8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521034287; bh=IyXVauK3vHsCNr7BTHVHt3TMfxJAN3G3T8sxg3EVHcg=; b=d
    Ye2rYdtghL2iink0DGQ1vaBoIbTR6CtDGfMwtZRtkx9lY+X+FF6bR5OIkMmQmXPu
    XRp3atz1DyYb/iFBMeS5s2A4qEm7I7xh3gAMISIBqkRdu3NJ7I467Hgsyxbg8mUN
    VxSYxdc25iFLS2o/T6RMBa4rGWYBdrB+nU9oKHp3cYVKp5368UGe2KCUelkmdTyQ
    Hp0CongkAi+JYsBZCzYqwS3iXPKZWWkLrPBDnw/kIpnbRJ5eQ8fdb6rPdySxGx5Y
    QWnFipMCPjnDZIlj6+qinqJvZzxjTC13dE2OhO9ZYGfPRBNjKWt9kwLeXsOgoiLi
    MW3QCdGwDVTeDxXprvnAg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=skidata.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=skidata.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=skidata.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-50 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=skidata.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeCNNbO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:31:14 -0400
Received: from mail2.skidata.com ([91.230.2.91]:39583 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCNNbN (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 09:31:13 -0400
X-IronPort-AV: E=Sophos;i="5.47,470,1515452400";
   d="scan'208";a="1328259"
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
To: Oliver Neukum <oneukum@suse.com>, Richard Leitner <dev@g0hl1n.net>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC: <bhelgaas@google.com>, <mathias.nyman@intel.com>,
        <gregkh@linuxfoundation.org>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net> <1521029854.4511.12.camel@suse.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
Date: Wed, 14 Mar 2018 14:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521029854.4511.12.camel@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Oliver,
thank you for your feedback!

On 03/14/2018 01:17 PM, Oliver Neukum wrote:
> Am Mittwoch, den 14.03.2018, 11:29 +0100 schrieb Richard Leitner:
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
>> pci_ids.h
> 
> Hi,
> 
> in general, why?
> Does this patch generate any benefit for any developer
> reading the source? I don't see it. Does it cause an
> issue for anybody who has a log file with the nummerical
> ID and needs to grep for it? Yes it does.

I'll send a v2 where I also use this definition in 
arch/mips/netlogic/xlp/ instead of PCI_VENDOR_NETLOGIC from
arch/mips/include/asm/netlogic/xlp-hal/iomap.h.

Therefore it will remove this definition from the iomap.h
and move it to pci_ids.h

This will IMHO be a clear benefit as it removes a redundant
definition.

> 
> Where is the point of this patch?
> 
> 	Regards
> 		Oliver
> 

regards;Richard.L
