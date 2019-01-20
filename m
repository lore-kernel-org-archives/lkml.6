Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2AC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E15C20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548012562;
	bh=codQFZpxeOJLqtj7CajptDaBvYjN1wmchF7TObZhcHc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hjP+9X2xxZ1P+80VPPxbdac0cFEk9vSNLlPG00/Cz30RIza1xhLu/FTD7ctRT/SUM
	 RAh4Fn3Nozhxv9QTJj+oV8UUSYc+E5spLWNDUxBFInFeCvpxeD+vQxSKIjDlM7aHCw
	 oYbG0Czqq/ZzWjsRuOGVfGBJWZhiFSOi3AICHb1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfATT3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfATT3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 14:29:20 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43F320861;
        Sun, 20 Jan 2019 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548012560;
        bh=codQFZpxeOJLqtj7CajptDaBvYjN1wmchF7TObZhcHc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dkSDCU8NCWAq4fwmjk9tmv32Tpcv+Q/9yXTZsOLixBnxgQMsLGt52qUqipaS3zLNs
         VcBRODl8Uh9wX4klQpwWn8Nwd5cE342FTO+JXYMqeaWh4GliAJ0fGNAMHBjl72xkYx
         UcI4VLNU+K/KAiVHOa5XY+HQCzqjlV6gam5XcUUM=
Subject: Re: [PATCH] usbip: Fix vhci_urb_enqueue() URB null transfer buffer
 error path
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
 <20190118212931.18482-2-skhan@linuxfoundation.org>
 <bf3e3361-2cab-3229-21a0-b4b12241afaa@cogentembedded.com>
From:   shuah <shuah@kernel.org>
Message-ID: <4b4a2764-257a-6a30-19c0-9eabf66d62c4@kernel.org>
Date:   Sun, 20 Jan 2019 12:29:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bf3e3361-2cab-3229-21a0-b4b12241afaa@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/19 9:58 AM, Sergei Shtylyov wrote:
> Hello!
> 
> On 01/19/2019 12:29 AM, Shuah Khan wrote:
> 
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Fix vhci_urb_enqueue() to print error and return error instead of
>> failing with WARN_ON.
> 
>     It's BUG_ON().

Thanks. I will fix it.

-- Shuah

