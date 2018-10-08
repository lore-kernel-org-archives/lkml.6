Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C459F2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C459F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJICm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:42:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:52641 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeJICm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 8987921CC1;
        Mon,  8 Oct 2018 19:29:09 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BIoLMGFUQ3lF; Mon,  8 Oct 2018 19:29:09 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 718D720F77;
        Mon,  8 Oct 2018 19:28:58 +0000 (UTC)
Subject: Re: [PATCH] usbip: vhci_hcd: check port number before using
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20181008191913.11527-1-sudip.mukherjee@codethink.co.uk>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <c7da9adc-3cb3-c5a6-519c-ba4440897c28@kernel.org>
Date:   Mon, 8 Oct 2018 13:28:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008191913.11527-1-sudip.mukherjee@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On 10/08/2018 01:19 PM, Sudip Mukherjee wrote:
> From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> The port number is checked and it just prints an error message but it
> still continues to use the invalid port. And as a result it accesses
> memory which is not its resulting in  BUG report from KASAN.

Yes there is an issue with out of bounds access. But this isn't the
right fix.

> 
> Reported-by: syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

I sent in a fix for this last Friday.

https://patchwork.kernel.org/patch/10628833/

thanks,
-- Shuah

