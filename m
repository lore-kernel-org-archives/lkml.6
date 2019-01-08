Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68512C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E6C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfAHGSU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:18:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60437 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfAHGST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:18:19 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ggkiQ-0008SP-4i
        for linux-kernel@vger.kernel.org; Tue, 08 Jan 2019 06:18:18 +0000
Received: by mail-pl1-f198.google.com with SMTP id x7so1529639pll.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 22:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Up8N7FQ/6xJBlzq81KS35U9QVvJAjRWhXzCViRUoYs4=;
        b=DvJsMSSDmrHRU4grBgZuySxqEzWkwi6RKzuT1EZcRpoUh5JW8BzWHxXg3F5pkzUxSI
         oyfsm2UHoIWBAiFsQeI24HGmAsP5OXnTLzK6XpGYAUPvvx8OdoxAWRt36tkhsxiVI1U4
         Jhaqn6KY0fDLnnPd2zbHd0BObG9dvwh9HvLMRbDvEqaWEBMsvbfcyVF8PhG3Hs2HXCyS
         eQDd132bSOFYOj25eoFoXVMPBbwHKeu9eoa6bt5rQFw6iY58KU8cxMQUoAhPgfGIw6u3
         j2eiX5t1cSSESbcchFCW2WZf2LBbfsgTRdwU7Hl4Kev6rfie8EM+Tbpvl7nfHaK+6wsi
         oWDw==
X-Gm-Message-State: AJcUukcjhyO5/7WUfi9OGoUoEsZyf7/gqU2OtNCYKYKipa1HR1tiCvvl
        1QjP4fKccKyADoaz09hBWxrTJr3NGZLDuWdr3Qm1S9hZl4f+VvRL7j7MA+zK84sHJf4jnHzpWmg
        rLF62xfyw1hwlmhiAklYu+owQD7Xgo+ZzxmqcT6nHTw==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr412209pgi.291.1546928296413;
        Mon, 07 Jan 2019 22:18:16 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7X3gvd4t/++07hTdOTebE8tqCezCdoq//hVyewq+lW1NGGMPHbY9O64I/f4B9HdJi34JHo7g==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr412200pgi.291.1546928296101;
        Mon, 07 Jan 2019 22:18:16 -0800 (PST)
Received: from 2001-b011-380f-3f3d-954c-1740-8790-dac9.dynamic-ip6.hinet.net (2001-b011-380f-3f3d-954c-1740-8790-dac9.dynamic-ip6.hinet.net. [2001:b011:380f:3f3d:954c:1740:8790:dac9])
        by smtp.gmail.com with ESMTPSA id n68sm114721837pfb.62.2019.01.07.22.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 22:18:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190107161620.GB2292@kroah.com>
Date:   Tue, 8 Jan 2019 14:18:12 +0800
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <18B0565E-1B36-41AC-904A-CFCCFDAC6EAC@canonical.com>
References: <20181203102643.22690-1-kai.heng.feng@canonical.com>
 <20190107161620.GB2292@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 8, 2019, at 00:16, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Mon, Dec 03, 2018 at 06:26:43PM +0800, Kai-Heng Feng wrote:
>> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
>> after S3:
>> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
>> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
>> 
>> After some experiments, I found that disabling LPM can workaround the
>> issue.
>> 
>> On some platforms, the USB power is cut during S3, so the driver uses
>> reset-resume to resume the device. During port resume, LPM gets enabled
>> twice, by usb_reset_and_verify_device() and usb_port_resume().
>> 
>> So let's enable LPM for just once, as this solves the issue for the
>> device in question.
>> 
>> Also consolidate USB2 LPM functions to usb_enable_usb2_hardware_lpm()
>> and usb_disable_usb2_hardware_lpm().
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> What kernel patch does this one "fix"?  Adding a "Fixes:" tag would be
> good to try to figure out how far back in the kernel releases this
> should be backported.

Fixes: de68bab4fa96 ("usb: Don't enable USB 2.0 Link PM by default.”)

The usb_set_usb2_hardware_lpm() was added to usb_reset_and_verify_device()
by this commit.

Kai-Heng

> 
> thanks,
> 
> greg k-h

