Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577DC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB1521798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX8bzabM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB1521798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeHMU6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:58:18 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43914 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbeHMU6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:58:18 -0400
Received: by mail-lj1-f181.google.com with SMTP id r13-v6so13306036ljg.10;
        Mon, 13 Aug 2018 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xa5r/zHLaeAEcMnuv3I9wguncWiTA7EQevh4vAotT4=;
        b=NX8bzabMR/XGFb0hWc8U+be6w4OU0gLEoQAOlgJAYi6M7Sy/WPZBItiLSLyZMSWVFA
         zNo6nQQ+y77u8lLbjIzNk8/Pg2pZjK1T1i3ijC1aurqzdm/u4tc38iwOpgYvFGzCoMKE
         uO9tcihgSToyLg6sUvPIRiJuHbQsv+1hwerC1HPs7mOHPx8NLNerV+RhnvCa9giC6p8h
         gfNyG5F2svg9XO/buNY4m33kk3EkmvcMknSQl0ytDEjhq9MfVAJj2XuYa+mW1mjT+NF1
         1BPdaVElAv/Pmr3EQz6VBID6J6Bg3B2JY6rf0OW/eKQJSRE8sLUbW8x9j0DAJKAoYKsk
         UrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/xa5r/zHLaeAEcMnuv3I9wguncWiTA7EQevh4vAotT4=;
        b=jiGlv8BgM7wanFyWpqbvoM08oGQIjpIgXaceG6+PQQ877dxrEgEHuMRuC7jNJViduA
         G8Xdlcu5DlEJ8MMtmRr+dVFOqSbRJ1CMfhHwLBiMNPyegmG+Lx+5G8If1s6taQsfzWrG
         msW4zpOFf03mJR/wiX7mIHh9WiBG0uZFI2a9udIa77kA47XpHUqn01p4Yc79AmXZU8kF
         yiJAoZGuWJJ9ZZvSa3IpaVyocZ1F+0rT45Aaf43zdriHaE8KSLkZelMljqkqYfdGpEZ6
         SRHNk2GgxS2+1WvzvlIzZ5zNneqo6uBO9hSiYjK5p7vkcbdOwpULnEIarLF1AmNwsUyE
         D95g==
X-Gm-Message-State: AOUpUlEbvr7WL1MzdWx0/5F2J70CK77xF+tat9qD07SmbjaZg2UthVM+
        RxO7VlvU5M4FcoqkkuAtzoI=
X-Google-Smtp-Source: AA+uWPxo0yQ0sF2npW+dNT2ZcbsUBpTOz0jySsEbdAYHQqGapwttwff/wI+VY30DRICv2GwjoUpd3g==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9-v6mr7969720ljj.33.1534184096311;
        Mon, 13 Aug 2018 11:14:56 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id q19-v6sm3209669lji.14.2018.08.13.11.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 11:14:55 -0700 (PDT)
Subject: Re: [V9fs-developer] [PATCH 2/2] 9p: Add refcount to p9_req_t
To:     Dmitry Vyukov <dvyukov@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     piaojun <piaojun@huawei.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net,
        David Miller <davem@davemloft.net>
References: <20180811144254.23665-1-tomasbortoli@gmail.com>
 <20180811144254.23665-2-tomasbortoli@gmail.com> <5B70E0D1.2080300@huawei.com>
 <20180813014815.GB6777@nautica>
 <CACT4Y+YQckNWVcBoW1WtH=5pEU5KXB8J8A=QssWx8nbp5GtNnw@mail.gmail.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e8c653d4-2def-1581-a9ae-a47e91718039@gmail.com>
Date:   Mon, 13 Aug 2018 20:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YQckNWVcBoW1WtH=5pEU5KXB8J8A=QssWx8nbp5GtNnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 03:04 PM, Dmitry Vyukov wrote:
> On Mon, Aug 13, 2018 at 3:48 AM, Dominique Martinet
> <asmadeus@codewreck.org> wrote:
>> piaojun wrote on Mon, Aug 13, 2018:
>>> Could you help paste the reason of the crash bug to help others
>>> understand more clearly? And I have another question below.
>>
>> The problem for tcp (but other transports have a similar problem) is
>> that with a malicious server like syzkaller they can try to submit
>> replies before the request came in.
>>
>> This leads in the writer thread trying to write a buffer that has
>> already been freed, and if memory has been reused could potentially leak
>> some information.
>>
>> Now, with the previous patches this is based on this would be a slab and
>> the likeliness of it being sensitive information is rather low (it would
>> likely be some other packet being sent twice, or a mix and match of two
>> packets that would have been sent anyway), but it would nevertheless be
>> a use after free.
>>
>>
>> There is a second advantage to this reference counting, that is now we
>> have this system we will be able to implement flush asynchronously.
>> This will remove the need for the 'goto again' in p9_client_rpc which
>> was making 9p threads unkillable in practice if the server would not
>> reply to the flush requests.
> 
> 
> Fixing unkillalble task would be nice. Don't know how much they are of
> a problem in real life, but fixing them would allow fuzzer to find
> other, potentially more critical bugs in 9p. These "task hung" crashes
> are quite unpleasant for the fuzzer.
> 
> Thanks for all recent 9p work, Tomas!
> 

You are welcome, I have to thank Dominique that helped me a lot, I like
to help here, it's educative.

> 
>> Even if the server replies I've always found myself needing to hit ^C
>> multiple times to exit a process doing I/Os and I think fixing that
>> behaviour will make 9p more comfortable to use.
>>
>>
>>>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>>>> index 20f46f13fe83..686e24e355d0 100644
>>>> --- a/net/9p/trans_fd.c
>>>> +++ b/net/9p/trans_fd.c
>>>> @@ -132,6 +132,7 @@ struct p9_conn {
>>>>     struct list_head req_list;
>>>>     struct list_head unsent_req_list;
>>>>     struct p9_req_t *req;
>>>> +   struct p9_req_t *wreq;
>>>
>>> Why adding a wreq for write work? And I wonder we should rename req to
>>> rreq?
>>
>> We need to store a pointer to the request for the write thread because
>> we need to put the reference to it when we're done writing its content.
>>
>> Previously, the worker would only store the write buffer there but
>> that's not enough to figure what request to dereference.
>>
>>
>> I personally don't think renaming req to rreq would bring much but it
>> could be done in another patch if you think that'd be helpful; I think
>> it shouldn't be done here at least to make the patch more readable.
>>
>> --
>> Dominique
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.

