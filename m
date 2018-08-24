Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B751C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FA921567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZVy7wyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FA921567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeHXQnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:43:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37779 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeHXQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:43:25 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so15202035oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z53AxicZWv6DxRmxP0tuR+5b8PioRonq1aULQ3Sh0F0=;
        b=KZVy7wynFrHXZL10UHwobBVuViQqGvlplF3chnNQrdC4eN6JC7UUh8K5JGvm36j9ph
         qoK505MSK/Ccfoe6dQultZPMP9sPcIYvnEUNB2hC+5SEdL69LJetxeRAcJi9sy1bKIho
         RYhmcTIhG5h0GbzZPX/VzSP9Roat7c98WfR0RP57ox6Esw6lgXwZf4EBSAPWvqN3Y+P7
         45+VCSnjDRMhxeYn2l8DdFe5UtuBBwj5TOvg6nEfJp5ITLAyRzpYuuHmxtuneopNTQfH
         PlccnnTukY+9gqqF6t80tU1ZYwa1DGnrVE7oPmxmYPn1TRC5W8tz7h0drngth7rtSD6h
         FqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Z53AxicZWv6DxRmxP0tuR+5b8PioRonq1aULQ3Sh0F0=;
        b=cl9MtuyuFfzu3/5TdAwPQ02EcBkHK4dKTARkkWYH3i/Mi6lW6PEybbRqdc5JnYadBa
         xSpjtRJEAXkFw/Vfn6UeYqF1EzSa/uK+0hCsLNt0UTSJY2uCiloqCqPYX8kTdZ3koB+v
         VARTeevWsHeUD+1DEWEwV2b50r5OCp8NLKbDVfO0TVOP4Un3qDC1eG1rYhFVBqX8zx9i
         e+wSqA5KtIr0MhG8Jq8Qbe4GG6VZ/BTjMH1egK/YAXv8c+hqFSpyLVJsUH9T32blYLuS
         5mxgi95qGceVMbaHN9l/ZVlS4j+GglloiVpOLxGAfx7hEQdU1XlsBx9NW0UstF0koOlR
         WhCA==
X-Gm-Message-State: APzg51B3QgxKn7pP2Ms6JcMMZcI6EXRGH7GptzIJQqzNoHU6ncNQHNho
        4ybplpJQ8TfXNSWuybQZ6A==
X-Google-Smtp-Source: ANB0VdaZ7dw3mPs31Lct2Vgkr9LHwZi+AWFylqA8wO578x9f/Ggu9EJrOZDHBmtyxqUo0i0tl1GwEQ==
X-Received: by 2002:aca:b48b:: with SMTP id d133-v6mr1308825oif.165.1535116129059;
        Fri, 24 Aug 2018 06:08:49 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id a144-v6sm13381481oii.30.2018.08.24.06.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:08:48 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:55dc:837e:d5b5:84dc] (unknown [IPv6:2001:470:b8f6:1b:55dc:837e:d5b5:84dc])
        by serve.minyard.net (Postfix) with ESMTPSA id 6EEF13A8;
        Fri, 24 Aug 2018 08:08:47 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH 2/2] ipmi_ssif: Fix crash seen while ipmi_unregister_smi
To:     George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
 <1535109010-5074-2-git-send-email-george.cherian@cavium.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <cb0a1ee4-69d7-b66c-b79b-6f8f542a4af0@acm.org>
Date:   Fri, 24 Aug 2018 08:08:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535109010-5074-2-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 06:10 AM, George Cherian wrote:
> Dont set ssif_info->intf to NULL before ipmi_unresgiter_smi.
> shutdown_ssif will anyways free ssif_info.

This is correct, but it goes a little deeper.  I just sent out a
patch yesterday that included this.

Thanks,

-corey

> Following crash is obsearved if ssif_info->intf is set to NULL
> before ipmi_unregister_smi.
>
>   CPU: 119 PID: 7317 Comm: kssif000e Not tainted 4.18.0+ #80
>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference firmware version 7.0 08/04/2018
>   pstate: 20400009 (nzCv daif +PAN -UAO)
>   pc : ipmi_smi_msg_received+0x44/0x3bc [ipmi_msghandler]
>   lr : deliver_recv_msg+0x30/0x5c [ipmi_ssif]
>   sp : ffff000037a0fd20
>   x29: ffff000037a0fd20 x28: 0000000000000000
>   x27: ffff0000047e08f0 x26: ffff800ed9375800
>   x25: ffff000037a0fe00 x24: ffff000009073000
>   x23: 0000000000000013 x22: 0000000000000000
>   x21: 0000000000007000 x20: ffff800adce18400
>   x19: 0000000000000000 x18: ffff00003742fd38
>   x17: ffff0000089960f0 x16: 000000000000000e
>   x15: 0000000000000007 x14: 0000000000000000
>   x13: 0000000000000000 x12: 0000000000000033
>   x11: 0000000000000381 x10: 0000000000000ba0
>   x9 : 0000000000000000 x8 : ffff800ac001fc00
>   x7 : ffff7fe003b4d800 x6 : ffff800adce1854b
>   x5 : 0000000000000014 x4 : 0000000000000004
>   x3 : 0000000000000000 x2 : 0000000000000002
>   x1 : 567cb12f8b916b00 x0 : 0000000000000002
>   Process kssif000e (pid: 7317, stack limit = 0x0000000041077d8a)
>   Call trace:
>    ipmi_smi_msg_received+0x44/0x3bc [ipmi_msghandler]
>    deliver_recv_msg+0x30/0x5c [ipmi_ssif]
>    msg_done_handler+0x2f0/0x66c [ipmi_ssif]
>    ipmi_ssif_thread+0x108/0x124 [ipmi_ssif]
>    kthread+0x108/0x134
>    ret_from_fork+0x10/0x18
>   Code: b9402280 91401e75 f90037a1 7100041f (b945bab6)
>   ---[ end trace fb7d748bc7b17490 ]---
>   Kernel panic - not syncing: Fatal exception
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x23800c38
>   Memory Limit: none
>   ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index ccdf6b1..1490636 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1226,7 +1226,6 @@ static void shutdown_ssif(void *send_info)
>   static int ssif_remove(struct i2c_client *client)
>   {
>   	struct ssif_info *ssif_info = i2c_get_clientdata(client);
> -	struct ipmi_smi *intf;
>   	struct ssif_addr_info *addr_info;
>   
>   	if (!ssif_info)
> @@ -1236,9 +1235,7 @@ static int ssif_remove(struct i2c_client *client)
>   	 * After this point, we won't deliver anything asychronously
>   	 * to the message handler.  We can unregister ourself.
>   	 */
> -	intf = ssif_info->intf;
> -	ssif_info->intf = NULL;
> -	ipmi_unregister_smi(intf);
> +	ipmi_unregister_smi(ssif_info->intf);
>   
>   	list_for_each_entry(addr_info, &ssif_infos, link) {
>   		if (addr_info->client == client) {


