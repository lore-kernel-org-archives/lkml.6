Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABD7C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAFE21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZBPda2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAFE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJIWR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:17:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42401 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:17:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so974441pfn.9;
        Tue, 09 Oct 2018 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZxiI7aNf4MPsBPvgfy9JgBpDO30bdl/+v1RrtegkG4Y=;
        b=VZBPda2fulVDC5wvBjZHqGM9qs5rJqmd53Xu25Li4x7AUhpKYg6L/1Rv6on62Co/VN
         5MskN3oCnb6tJQvpYcNbUgUMzW6pxuSfCcBmn8HEK9055JhuZ6kExU8Hy+hRAGXHApqL
         1vKeI8PpEa45GJM/WMBAuT0qsvJ5gKScAygTpTdKZj2kaXPjIkAPCMtQqtIjS/uk6O3k
         7gLZp3wEwZTwFdlXWDN6l2NETq0mw1TcmRDo43sz9aGvj7a1/GbM3E+8sOcitgwMFDnc
         i00Ehv67erhQI3p+mmBwokCaWjtutWlOOKyzUlEIXluvbHsfl7Pra8N5I5IjxbRf6GIq
         Mnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxiI7aNf4MPsBPvgfy9JgBpDO30bdl/+v1RrtegkG4Y=;
        b=Kyr+KImvqrLOO0T5lQMSH8SV7eGHlv3oHimg6xf9U1MZUDXGOhunc1yBtCvZeT2iif
         b94GusXMtZyphWDjXSQM+r8u1C2vyZIrwbxzobhqKw4X0HXpAbbYAWNX0es5CCEaIWZd
         Mg42HtIEpVPJZ6HWvSGtLe3QkDVtNxnHDMX0ZBsuU4NbkrKY1UlpdeVcxH+LomQiA4qD
         Ctzb3Et7/kOLXAteSVJVoxjh+Bv5Jx+cjSOaQkKr0d24Qa03R3dN/xjfuYsxHiQXETn5
         pkHvrheqMUsxo7k7hrcW0f2foaU4i547XXL4LGd6uzX/gxZ/k9adlJQyOudJSXGDPqJ6
         KUJQ==
X-Gm-Message-State: ABuFfohJ1H8YzX4gQ7q3n8m/uAYvNbmOtvwHXB7yeUFUzeb+6jxZA8+v
        tDD5qRjTSdmSSiPDMD/UEKY=
X-Google-Smtp-Source: ACcGV60I0QngDVAyTPSh39T8Bkt2/zLhavLciSQ+oIrTGvKpgT0u2lNjzK9wJrNMU0SLc2jV72eauw==
X-Received: by 2002:a63:d84a:: with SMTP id k10-v6mr26232665pgj.314.1539097206854;
        Tue, 09 Oct 2018 08:00:06 -0700 (PDT)
Received: from [192.168.88.43] (150.sub-166-148-115.myvzw.com. [166.148.115.150])
        by smtp.gmail.com with ESMTPSA id 6-v6sm22705083pgl.6.2018.10.09.08.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 08:00:06 -0700 (PDT)
Subject: Re: general protection fault in __handle_mm_fault
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com
References: <0000000000009d47b2057782bab4@google.com>
 <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com>
 <CAF=yD-+Qh5f9kqmYLY5EyUwNPuyhMpBxz6dh_kfzFZsgE3UijQ@mail.gmail.com>
 <87va6bwlfg.fsf@linux.ibm.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <48d891dd-3f45-c03c-a55b-bb153080881a@gmail.com>
Date:   Tue, 9 Oct 2018 08:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va6bwlfg.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 01:53 AM, Aneesh Kumar K.V wrote:
...

>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cdb67e400000
...

> 
> Can you check with this patch

Well, this is a C repro, you can test this yourself instead of asking Willem who
already did a painful bisection.

Thanks.
