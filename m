Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0AC25043
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCihuuHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0AC25043
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeGBSv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:51:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40371 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeGBSvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:51:54 -0400
Received: by mail-io0-f196.google.com with SMTP id t135-v6so15622170iof.7;
        Mon, 02 Jul 2018 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vM7JqoTCvdgh2tRHN2RRzTxUY2Y6uUde2xkyFae6NoY=;
        b=BCihuuHiDYNBISXVZm1TMOGuv6zvrV7kzwIFn1BfkIBhuDr1meg4V/qtZ9hi6ynNHx
         ms9HhvVg8f6xdja1KhSsChQF/jzYpmHUy6Q1/9z4fystVsyZ/9Xm+k9/dwwSjn0xuh5W
         rmGtQlyour76EMXvYMFyEzTyGUV9AuQsxb4+iQ2hQx+NS1J/2/OBQ93sngBa6GoXa75w
         kKEm4kCSny403jC6WlLFW6y5TTKtrEaZyCaPPdp1KsRHpiyBhr9rl/UkEN/JzLoBne91
         w3/U6PdpptjQlo6VA8ql3ui6/q+XGGExbp8d6SP1HXvYT7rLClU/F9zXb1vrGzRcdg8Z
         BXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vM7JqoTCvdgh2tRHN2RRzTxUY2Y6uUde2xkyFae6NoY=;
        b=nc7Cf6DNIKZ2oHvV54P1AHxzonczjGYUghv02W11lO3VTuMOEuLANkmT7ZX2SPnpBu
         JAwytPdTk3W2XQJmG0ekOUFykAZXHQkviz7bGp7ZvmYu4Ls/Ixqa7XyjpDAEPez7HdqL
         JReK04SNn1+JVnPZwtYE5Us6L/2Qhb9o7FHM39zMWOqa4XTONf/5kyOTxJWmsBcNbjUG
         /qAf7LE0qibOSWfrDqsgmxknDbREWcKHHFG3Wll8ulgFaYCD7xgYOn4ldcJdh7eM4Phb
         eg4vvfoVx7jdiTroGeIGD52fZ79DiYEU2s5IW9SeIm8IB+rNLKRgwclXxAfbGUAIfbsd
         WIBw==
X-Gm-Message-State: APt69E3fJVgKN6Q5tWpmjbpCOu0LGUJJsf0ljzquGVJrE+E04bCgHdmm
        zJbgeNQVt/FyvnuuN49B2N6i+PNI
X-Google-Smtp-Source: AAOMgpeVtcrqstbDgE3mlPlM1bw3q2yXq4QF1n9gpO394S/V1sfGdttYFqKf5btaJr72Z6LhxrKpfQ==
X-Received: by 2002:a6b:b284:: with SMTP id b126-v6mr9925902iof.201.1530557513494;
        Mon, 02 Jul 2018 11:51:53 -0700 (PDT)
Received: from [192.168.86.235] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id h75-v6sm623275ioh.50.2018.07.02.11.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:51:53 -0700 (PDT)
Subject: Re: possible deadlock in sock_hash_free
To:     syzbot <syzbot+83bdee62c80cc044cb1a@syzkaller.appspotmail.com>,
        ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000222dd6056d4c4dfc@google.com>
From:   John Fastabend <john.fastabend@gmail.com>
Message-ID: <469337cb-432a-a03f-eb16-9b18852edc65@gmail.com>
Date:   Mon, 2 Jul 2018 11:50:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000222dd6056d4c4dfc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 04:16 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7a1a98c171ea Merge branch 'bpf-sendmsg-hook'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=131f4067800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
> dashboard link: https://syzkaller.appspot.com/bug?extid=83bdee62c80cc044cb1a
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17a0be2f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164cf10f800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+83bdee62c80cc044cb1a@syzkaller.appspotmail.com
> 
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.17.0-rc6+ #25 Not tainted
> ------------------------------------------------------

[...]

#syz fix: bpf: sockhash fix omitted bucket lock in sock_close

