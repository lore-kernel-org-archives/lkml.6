Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ADBC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB98524D9B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 02:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWhjC6IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB98524D9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeFXCwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 22:52:41 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41043 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeFXCwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 22:52:38 -0400
Received: by mail-ot0-f194.google.com with SMTP id d19-v6so11556199oti.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FO/gRy5T3cS848/CG7NpvWJdRDnaZ0kWCEJ+EJPbD5Q=;
        b=JWhjC6ISyzt0ZwJ31vW/HE6r5kgd9cdrgnGOtPYeZW38XOn+B+ZSPCx1zEZ2uXXsXL
         3cEajQnrDzojXE9Iy5JZS6vuDwS+o7YizGqb7tiO4jt0QxyCeaUXrG5grSdD5VuCh7Hn
         KOq3uHTahrrJ+pXy+xUPlUwshv546PzuMAYIGzr5EFjGgCEqWYXRUE8RvH8gL088ZLtb
         JdXufKg2pOFih04+Wj37h4GvJp+S/bBFuwESaNtafSW8+njDiVpLnfG6aABDBvdIkH5M
         Ozi2dOzVbbKVhonFYdXxyGjj8m+wQSHLE03RSpHLyrqV5ymLVX1+FovtrusGesCQx6Cc
         WbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FO/gRy5T3cS848/CG7NpvWJdRDnaZ0kWCEJ+EJPbD5Q=;
        b=LHaUYmu2oVomfO/8UPWw4vTgHMPfuqptmmdO007ALPosjZ+1RXsU6ilxRa8rh9dnuQ
         xCuxGelFeNmCcGIddPZkk9DyyzidIF9G1Lle65bRdOhOTuSu+hSnmO8mA2SyEEBGBTjs
         3leekxo6Lk4fZpYWu3o6rQq4fl38ysePMlPiLX/9IdD2oh1SLZGdUxZ/iqkpl3kN8dpo
         ibpeUYBfnT61pUXNBS/+IrKNqfLZqq0K5LgUDXhKjulmLyJpK+7CtWsXGjaQU8bUWgUO
         tOpEHUVGF55Bl3xn3jzDZvD2UE/NArloC0wRR5GWk+rds289xzJbTHSOZL1BJ6KeGBsX
         KR1A==
X-Gm-Message-State: APt69E1mUtq2dIvHQV/KohnvRyTd9OymKIELwAIpftOJmNCIc4HiDpN/
        /FzF0fDzHUztUc5oKvrknXeUKQ==
X-Google-Smtp-Source: AAOMgped11UPbLmFEdLM2p0qVnyg7CXVp7N2jEYNSXt4IR1Z2YP5LVXtZdajG7tTGJ+ln9mKsTxWAA==
X-Received: by 2002:a9d:2774:: with SMTP id r107-v6mr1515260ota.93.1529808757869;
        Sat, 23 Jun 2018 19:52:37 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r40-v6sm10880228otr.62.2018.06.23.19.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 19:52:36 -0700 (PDT)
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
 <20180624011703.GH18630@bombadil.infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a62d8a6a-0376-2cbe-a34c-13e1242f06c6@roeck-us.net>
Date:   Sat, 23 Jun 2018 19:52:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180624011703.GH18630@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/2018 06:17 PM, Matthew Wilcox wrote:
> On Fri, Jun 22, 2018 at 03:33:35PM -0700, Guenter Roeck wrote:
>> It may be odd that fs/quota/netlink.c:quota_genl_family is not word
>> aligned, but on the other side I don't think there is a rule that
>> the function parameter to genl_register_family() - or the second
>> parameter of idr_alloc() - must be word aligned. Am I missing
>> something ? After all, it could be a pointer to the nth element
>> of a string, or the caller could on purpose allocate IDRs for
>> (ptr), (ptr + 1), and so on.
> 
> This is probably going to cure the problem for you (apply on top
> of the existing radix tree / IDR changes).
> 
> I realised when I was reviewing the patch that it's no good; if you
> call idr_replace() with a radix_tree_is_internal_node(), then you'll
> still get a crash.  I'm going to have to disable the optimisation of
> shrinking the tree all the way into the head for the IDR.  But this
> will probably get m68k working again.
> 

It doesn't crash anymore, but there is still a backtrace.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/idr.c:250 idr_get_next+0x62/0x82
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc1-next-20180622-mac-00001-g6731a81057be-dirty #1
Stack from 07c19e28:
         07c19e28 0036d5b2 000180d6 00000000 0036e0d6 0055a040 00000000 000020e8
         07c19eb0 002b5326 0001816a 0036d5b5 000000fa 002b5388 00000009 00000000
         00000000 00340b1d 002b5388 0036d5b5 000000fa 00000401 0036e0d6 80000000
         00000000 00036fa0 0036ddc0 07c19eb0 00246164 003abf1c 07c19eb0 00036fa0
         0036e0ce 07c19f8c 00000011 00246f04 0036e0d6 003abf34 00000400 00000006
         0055a040 00000000 000020e8 00000000 00036fa0 003ff8e0 003f751c 07c19f8c
Call Trace: [<000180d6>] __warn+0xc0/0xc2
  [<000020e8>] do_one_initcall+0x0/0x140
  [<002b5326>] idr_get_next+0x0/0x82
  [<0001816a>] warn_slowpath_null+0x26/0x2c
  [<002b5388>] idr_get_next+0x62/0x82
  [<002b5388>] idr_get_next+0x62/0x82
  [<00036fa0>] printk+0x0/0x18
  [<00246164>] genl_family_find_byname+0x1c/0x4c
  [<00036fa0>] printk+0x0/0x18
  [<00246f04>] genl_register_family+0x74/0x55c
  [<000020e8>] do_one_initcall+0x0/0x140

Guenter
