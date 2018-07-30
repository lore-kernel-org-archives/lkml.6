Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCDF20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl+d7S4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCDF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeG3LUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:20:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43859 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeG3LUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:20:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so9892107ljg.10;
        Mon, 30 Jul 2018 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9b+VfOzwrRKdL5+p9w4aZln1B34c/+RrM7WULfuRXb4=;
        b=fl+d7S4/eGpHAvZpR44uxjPO3C+A1TRlY4kXnJjmiR+uQKf1rEdH8T7tN5ZC/8FKpB
         3QFIVoWYPbuq0obNdRqtj08nFAzCYCnHTi64q3fCftDvJWx+al7GSQrkxw7HP2eGjqG+
         NRoEpslG53GrepF9tLX8b1DNF8nnOGDSYBkfR13/4Lgqp7TST5bDpTGwpvefBPrIoy5z
         D5//okGo+s4sgZqNzzM6X5HPS39vsc9jW3sn55mII80LVRyU07Yi5+xG+mv/CgdMUUDe
         vjA7ezlYQ13eIU+DJhCh7fJhtMPGs/6JRdWs3frUdLNyce4KTBedcgQVh9R/5Yt2QBZT
         /DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9b+VfOzwrRKdL5+p9w4aZln1B34c/+RrM7WULfuRXb4=;
        b=t/qLol6D8k4WP58rBhV4IaPL1OvQhJk+V6TSt9i0aOY3H6HqHt1CoR0r76c75Z3/pJ
         5AG5FhGhDXKBIPrWOXduBOQRK/24n2tscdR7cjpVj0SbMUiIoIWLSy6GvG2HwdV+Yi2P
         D/OJsNCyvxBODwEu2XcbBiMShkhu8bq7k8IVZShTPEegAMGHB8pi3eMNNsxHoLopG2Ki
         5bR5q8H620ZgAH1maLjszfOLt9dTrBQeA04lcIBZ8Layq+QIUQRMV3YGiXTpD1cFXi6P
         xHm2toEUceFtb8F00d098lfezJSAW3R1KEBS0k1vxqbRKByEGNql6fXvHJwae0eFBXl6
         S+Dw==
X-Gm-Message-State: AOUpUlFVTx8QLVj09uWNS7a82NUBwmbr3s/nbo3cgFZfSmiID9ligPrs
        Rc/az1bl7m9kOvaWGg4yVBk=
X-Google-Smtp-Source: AAOMgpfXmyG/2PgBWOg/7k8ZyeR3L/QzLyoEHTJlL7I2BpXkPWC2OvTmZoa/eNF+088HRDnW/1u0AQ==
X-Received: by 2002:a2e:3611:: with SMTP id d17-v6mr12936102lja.31.1532943952894;
        Mon, 30 Jul 2018 02:45:52 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id k77-v6sm1502426lfi.46.2018.07.30.02.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 02:45:51 -0700 (PDT)
Subject: Re: [PATCH] 9p: fix Use-After-Free in p9_write_work()
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <20180729130248.29612-1-tomasbortoli@gmail.com>
 <20180729233336.GB28684@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4ac26f97-778b-6527-9a5b-08b7bfc8a5e8@gmail.com>
Date:   Mon, 30 Jul 2018 11:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729233336.GB28684@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 01:33 AM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Sun, Jul 29, 2018:
>> There is a race condition between p9_free_req() and p9_write_work().
>> A request might still need to be processed while p9_free_req() is called.
>>
>> To fix it, flush the read/write work before freeing any request.
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
> 
> It looks like I have not received this report, I found it through google
> in the lkml archives but Dmitry do you have a convenient-ish way of
> finding the report on the syzkaller website with that reported-by tag?
> 
>> ---
>>
>> To be able to flush the r/w work from client.c we need the p9_conn and
>> p9_trans_fd definitions. Therefore this commit moves most of the declarations in
>> trans_fd.c to trans_fd.h and import such file in client.c
> 
> This cannot work as it is, because you're not just intorudcing the
> trans_fd types but you're really depending on the transport used being
> fd.
> 'conn.wq' won't even be valid memory in other transports so I don't want
> to know what trying to flush_work on this will do... :)
> 

Yep, Oops

> 
> Other transports also have the same issue see discussion in
> https://lkml.org/lkml/2018/7/19/727
> (that is another syzbot report, slightly different but I believe it
> points to the same issue)
> 
> Basically, a more global view of the problem is a race between
> p9_tag_lookup returning a p9_req_t and another thread freeing it.
> 
> Matthew wrote the problem himself in a comment in p9_tag_lookup in his new
> version that used to be in linux-next at the time (I took the commit out
> temporarily until I've had time to benchmark it, but it will come back in,
> just you're working on thin air right now because the bug was only found
> thanks to this commit):
> +       /* There's no refcount on the req; a malicious server could
> cause
> +        * us to dereference a NULL pointer
> +        */
> 
> So a more proper solution would be to had a refcount to req, have
> p9_tag_lookup increment the refcount within rcu_read_lock, and have a
> deref function free the req when the count hits 0.
> 
> 

Which commit ? that's a comment.

That sound like the proper solution. Let's do it that way then.

> Now we're here though I'm not sure what to suggest, I had promised to
> get some performance benchmark out by this past weekend and I obviously
> failed, so this patch might be delayed to 4.20 and the refcount approach
> would not work with the current req cache/reuse system we have right
> now.
> If you want to finish this anyway you can work on my 9p-test branch
> (I've kept the commit there), and I'll take that patch in at the same
> time as the other.
> 
> 
>> Moreover, a couple of identifiers were altered to avoid name conflicts with the
>> new import.
> 
> If we were to stick to this approach, two suggestions:
>  - headers aren't all-or-nothing, I think it's better to only expose
> what you need (and e.g. keep the Opt_* enum in the .c)

No we don't have to stick with this patch.

>  - instead of exposing trans_fd specific stuff, it's cleaner to add a
> new op vector '.flush' to the p9_trans_module struct and call that if it
> exists.
> 

I didn't thought at this way, it's smarter.

> 
> Thanks,
> 

