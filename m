Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1976C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC922085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="QdZ5YFUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC922085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeKEXEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:04:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41117 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeKEXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:04:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so6149594lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+NPiq7vLjvEOHmNcnyL8R8foeBZVMhF6ywxgFk0qaz8=;
        b=QdZ5YFUoodRESy84AK7eiDUwrjqySQM6bbEiA22rwHnDBF7mv/LnqbnItcR+BCvlZq
         t3HMgEPUkwwHCNGOnzJdOsEwD7HcOzEBvE4DuzMV+nP/QvboOUjsG+DPlGjSw1KyXBtc
         a9+qkJA6Yk+Ts4G/0mS2dGWR4FhEuXtLvGoINxlDKcoDQiZvK27fqI9w3+5XzAHWoSwj
         Dsi8Sb+3hnMEjP0FgVCY5vY3n8CgJFzFw7qiJuQjZReIuaUZf1N8Skl/iI49pEp5nUNe
         xIxH+Y/A7KO4+tDhofa1Awi2hHzXDlB280/AaXLr7WTLQdcFdxXFB4gsRovn82eWKjaD
         P2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+NPiq7vLjvEOHmNcnyL8R8foeBZVMhF6ywxgFk0qaz8=;
        b=QXadg7WPLMu+OGUV6UNdPJF/XPh0n9FrUHA9cb4ssJyrqLIEZu9U4au7qCdkIiJDOh
         8Mf6M0DCnH962G6mPLPBA66MwmwAYhg3jnx2Sb3Noh52hEIDZ9XVQtmsrKh9d5uTDKIp
         s1IP92UNhb9W1LM5MB9SW5m60WERvjgny+9UYqSsvw0DsfibScByxbIAdiMgCoojLzAe
         9ioe3KHMGsUYTkkSuY1+0HafKiXGI0ZfBLnh+4iBEjnulOXP04ORSe8egJUxx1VBStS/
         lhMbrGEWJ/fFGoKFdB7RvtWpWtS4e7PmwTKQNo1nlbnCZmNhMZUMdoNkRUwn1I+FxOhk
         4ihg==
X-Gm-Message-State: AGRZ1gKCzLCRpfIiNiNymcz5ht+aUybT5Z8Zn1e7FeZbGDWjhy9SQFUk
        0kciJ0+7zOLMJD8PO1tsjYJpFg==
X-Google-Smtp-Source: AJdET5fI7/4DcpbjChAWvy9G9tgbjtZeLS8KKyNdIAX8amvYmpCfkgxOuOmgZbn7hFEfT846idnmrw==
X-Received: by 2002:ac2:4354:: with SMTP id o20mr12975283lfl.129.1541425464765;
        Mon, 05 Nov 2018 05:44:24 -0800 (PST)
Received: from [192.168.1.169] (h-137-80.A159.priv.bahnhof.se. [81.170.137.80])
        by smtp.gmail.com with ESMTPSA id n3sm827274lfl.44.2018.11.05.05.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 05:44:23 -0800 (PST)
Subject: Re: KOBJ_BIND uevent
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
References: <f844342b-14fd-6ce5-55b0-5c224d0c841b@norrbonn.se>
 <20181105132106.GB20797@kroah.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <c9fffc1c-b12c-537f-20a2-6c4ab3b0430c@norrbonn.se>
Date:   Mon, 5 Nov 2018 14:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105132106.GB20797@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/11/2018 14:21, Greg KH wrote:
> On Mon, Nov 05, 2018 at 11:35:57AM +0100, Jonas Bonn wrote:
>> Hi,
>>
>> I have a question about the ordering of uevents, specifically concerning
>> complex USB devices that present multiple interfaces/functions.
>>
>> Before KOBJ_BIND, a USB device would typically present itself as:
>>
>> add usb_device
>> add usb_interface-1
>> add subsystem-device-1.0
>> add subsystem-device-1.1
>> add usb_interface-2
>> add subsystem-device-2.0
>>
>> I have noted that the recently added "bind" actions, however, present in the
>> reverse order.
>>
>> bind subsystem-device-1.0
>> bind subsystem-device-1.1
>> bind usb-interface-1
>> bind subsystem-device-2.0
>> bind usb_interface-2
>> bind usb_device
>>
>> This secondary ordering could be useful in the sense that the final "bind"
>> action on the usb_device is an indication that the kernel has finished
>> enumeration of all endpoints and has bound all drivers that it could to the
>> available interfaces... i.e. no further events for this device are expected.
> 
> Maybe.  Maybe not, as userspace might still be in the process of loading
> new kernel drivers based on the add uevents that got sent out.  Then
> binding would happen later after the usb_device was "bound".
> 
>> The question, then, is:  is the above ordering of "bind" events stable, or
>> is it just a consequence of the current implementation and may change in the
>> future?
> 
> Not stable at all, sorry, you can not depend on it.
> 
> Nor should you even try to, what problem are you wanting to solve here?

Specifically, I'm dealing with USB modems that fall into two categories:

i)  present a bunch of USB interfaces with one ACM (or similar) class 
device on each interface (one TTY for data, control, GPS, etc.)

ii)  present one interface with multiple endpoints that end up as 
multiple Linux devices (typically usbmisc device + network interface)

In both cases, the modem really isn't useful until all the 
interfaces/endpoints are ready.  It would be nice to be able to have one 
uevent that indicates that the kernel has done all it can with the 
device so we can evaluate whether we have everything we need.

Currently, we set a 1 second delay from the "add usb_device" before 
proceeding to evaluate the available modem interfaces; this delay is 
normally sufficient for everything to be enumerated and drivers bound, 
but it's still just an arbitrary delay.

Thanks,
Jonas

> 
> thanks,
> 
> greg k-h
> 
