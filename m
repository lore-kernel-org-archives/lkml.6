Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7E12086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544547283;
	bh=1ywB8z3U2NPnha7Yi+fI2RReg0XIqXApRroyT5ZHqqc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=zT5GuC2BSxbQCqRY1PW4C9BngFHACqYbqhaTmEqysPWi36jXdpqoINBhi5u3oOzCC
	 +rENJWmkJTMMSjVoRSPExApvgskqSVZiDhodgNF+4Z2ApL0FwDUpcOXJm+shbQAj0X
	 QrSxu1R0xjnB+hb48xNm4wdOysiZ8uAUcVh/2100=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7E12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeLKQym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbeLKQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:54:42 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7E320851;
        Tue, 11 Dec 2018 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544547281;
        bh=1ywB8z3U2NPnha7Yi+fI2RReg0XIqXApRroyT5ZHqqc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mHB4+qf4TVEKi4Hi+zYZIMm5ZUY+ez1vmIxiOrqiopaCdkiUdVxb+eOta0Qg+RvPB
         74TK6mp98gcUEKz0tU66EipLcVd0dorDpekj5FXjb7JEGzp4QZgBbLiNt1x7+Licu9
         ts6inJKo6lVViof24J7DgrlAUStrHsDT7d4R6KBY=
Subject: Re: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181208214644.5374-1-okaya@kernel.org>
 <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <4aa65942-bf97-c957-7f77-38bfdf7d1d3a@kernel.org>
Date:   Tue, 11 Dec 2018 11:54:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 5:12 AM, Rafael J. Wysocki wrote:
> On Sat, Dec 8, 2018 at 10:47 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> Make PCI reboot conditional on PCI support being present on the kernel
>> configuration.
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> 
> Same comment as for patch [2/3]: make the subject say clearly that
> this is about CONFIG_PCI.

Sure

>>          case ACPI_ADR_SPACE_PCI_CONFIG:
>> +       {
>> +#ifdef CONFIG_PCI
>> +               unsigned int devfn;
>> +               struct pci_bus *bus0;
>> +
>>                  /* The reset register can only live on bus 0. */
>>                  bus0 = pci_find_bus(0, 0);
>>                  if (!bus0)
>> @@ -45,7 +48,10 @@ void acpi_reboot(void)
>>                  pci_bus_write_config_byte(bus0, devfn,
>>                                  (rr->address & 0xffff), reset_value);
>>                  break;
>> -
>> +#else
>> +               return;
> 
> Why not "break"?
> 

I struggled between break and return. Existing code seems to return on failure
when bus0 is NULL. I assumed it would be more logical to return as someone could
put some code after here that assumes everything is in order.
