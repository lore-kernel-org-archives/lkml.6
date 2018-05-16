Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-354822-1526479424-2-154225295146440380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526479423; b=IwffCvYP/O+WRlxGnQUOVnARx44o1FfMm0jgTSrUaQ5OkE2aQP
    O3WvawnTtVis7MYq698ym+tcyIJZ7deIJV9IAIjf1RJvZAmJRcHAOEHBwckFnhUQ
    cKzqaX6xRpyWdNVA85v4qEKxPI9HDlNriCs63jdDilxDPXqx5lMlLKvfs2O9536I
    nO47mPTiJu9jX1JycS/M8b/AqVe099ATW0f7xv4MO9ef6x8k4UdwaAJLcl1Fl8bS
    +yCQogjTXL+tYA+c2xAi7wbJhbEC/g9DvxbuhCCFyEPFqj/LUFQEqNMokzwMIVWD
    LILtREVFAIMLbP3U7FRJhCVcX17SMmeVYRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526479423;
    bh=kVDASPetBnNz8ZoPrsf0nOPog1CkgTOHzHY3W758Xw8=; b=i1coLnWHHNCa
    B0jVUXLvIeaoJboFqKmJrB0hYb4ltULtRKoB0cihnIsFiNBzq9Or8Wqu7dJJ+Gn2
    AC0o7o+f6ROJ9rLWMRpBkWgkVO8+nmoPkod/f0DjpEn9jHscXnVUYkoHzvFEdJQd
    c//7ynkjErQRpx5f4ShgwLHAO7VklNrYnWssKG4nCo3cDBKJieZAHlPe/Yge19DK
    UnoQqA1B9QxRKiatjGLG18tAxJPmxbIpk84zEjD7rX9Pv74CTDwVXKRE5Sv8meya
    ECukmWEdBzKv3JeR8H7vLoz2YPP+kQS0Fh4cAhzbJzg+oQcczLB2Sfr6pE77H2px
    jCCA9rUb2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJxwDmS51ao48/M0ND+FAoN8BwnFuppsiBpH4ku6PXnRN+glJuO/bbkTJXPFwZPj+uYqB96ux33KLjaostNlNpENbTDLW3posccy8jh5Tr6vasVnMI10
    vOZzt9jcPNRribsDpwcztZTbV5wEczGas/59NSwsROD5ivfFxOMeBYawik8FHwoOZr8jiTFcWXFpSzJSodNAnZ8OYUDA8D8Bh0ItLDGfDsQZnmUU6ozKB8ZY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=04LmZrBiSd2vAaYIvw4A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeEPOD3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 10:03:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:53626 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeEPOD3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 10:03:29 -0400
Subject: Re: [PATCH] usbip: usbip_host: fix bad unlock balance during
 stub_probe()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180515235723.30845-1-shuah@kernel.org>
 <20180516054909.GB29964@kroah.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <0fd916b1-ff46-a755-5198-06899f8211f6@kernel.org>
Date: Wed, 16 May 2018 08:03:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516054909.GB29964@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15/2018 11:49 PM, Greg KH wrote:
> On Tue, May 15, 2018 at 05:57:23PM -0600, Shuah Khan (Samsung OSG) wrote:
>> stub_probe() calls put_busid_priv() in an error path when device isn't
>> found in the busid_table. Fix it by making put_busid_priv() safe to be
>> called with null struct bus_id_priv pointer.
>>
>> This problem happens when "usbip bind" is run without loading usbip_host
>> driver and then running modprobe. The first failed bind attempt unbinds
>> the device from the original driver and when usbip_host is modprobed,
>> stub_probe() runs and doesn't find the device in its busid table and calls
>> put_busid_priv(0 with null bus_id_priv pointer.
>>
>> usbip-host 3-10.2: 3-10.2 is not in match_busid table...  skip!
>>
>> [  367.359679] =====================================
>> [  367.359681] WARNING: bad unlock balance detected!
>> [  367.359683] 4.17.0-rc4+ #5 Not tainted
>> [  367.359685] -------------------------------------
>> [  367.359688] modprobe/2768 is trying to release lock (
>> [  367.359689]
>> ==================================================================
>> [  367.359696] BUG: KASAN: null-ptr-deref in
>> print_unlock_imbalance_bug+0x99/0x110
>> [  367.359699] Read of size 8 at addr 0000000000000058 by task
>> modprobe/2768
> 
> Minor nit, no need to line-wrap this.
> 
>> [  367.359705] CPU: 4 PID: 2768 Comm: modprobe Not tainted 4.17.0-rc4+ #5
>>
>> Fixes: 22076557b07c ("usbip: usbip_host: fix NULL-ptr deref and
>> use-after-free errors") in usb-linus
> 
> Nor this, and the extra blank line isn't needed here either.  I'll fix
> it up by hand when I queue this up later today, thanks.
> 

Thanks. I will keep that in mind the next time.

thanks,
-- Shuah

