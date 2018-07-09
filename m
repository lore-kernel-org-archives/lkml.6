Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6FDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752B020881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1bLLpxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752B020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbeGIWO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:14:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44658 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGIWOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:14:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so12523762wrt.11;
        Mon, 09 Jul 2018 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X3gSx+iTRmC/ZpwiUkRnuh65hOij+TbE/z06RE5jJU8=;
        b=o1bLLpxIy0Q+p4MHtlcNH0MKDU6jl0hjt4OTSAwQv5fVH4FJLnudLKOBaWPgYxVHro
         gWtUxxpzSkbcjSkSfRqnjvZdHu3OCfAekUWSzxB8Q7jIWs0XJ5h/IgO/kp/b5xxU1y+H
         Yz6b8vtwTE7Hd4mkFiM59a01mc+ehr2yKIH1f6IAMJNlczIPiFPjI6Ewq0mLyY3Cbrat
         TrV6m3Kku0CdMIVWS8comQ+g9mBTqb4pJqSOPV0w2v70u6sW622OSf+9hcHKVO+82xsg
         dKHIU5Pt1mU0+ax7j1GZw5/1RaHY2Ni4ndR62yB8S0b5spruxuj58yLYK1RMMX/S+wyR
         uX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=X3gSx+iTRmC/ZpwiUkRnuh65hOij+TbE/z06RE5jJU8=;
        b=FwlzyhBH6AA7qiYHWxUvlHX6W0aBjnsLEY0vw4B5tA/WgZmtxTrvjNMgW3OkokuS8N
         o46rk9JD19ir1t7vQ0fqu909Q20ue2cQIorI5nopEnR9cBRz/ytJzDNb6sXEbP+WZeTt
         AnK9eUOOZ7ZsSu0ZxBHLF4R2hIMKANSTmkNruX5gglzCIz0Y1uj61PA9wkdvYJFqwFDq
         /hAdeSnFjFC1Mmb4X2W5zHnVR/MQjjtqXTL8JDKvCsLg9K1MxLQ49unecgYJ3QjcnBYW
         O0MGktV3mgoOlMMj13MkHPrbfEktN+1+/VDrOc0qRKVV/Qx1vgT6XGaxysdm9Gle+Dtx
         200Q==
X-Gm-Message-State: APt69E2d7AGxbpMNiUB7okOppdu5W8kNoCSeD/Xc/WEHUOLuqctj96fk
        +xwFm3c9KSnKP3YqX2+4dNU=
X-Google-Smtp-Source: AAOMgpebcKfBwwzRh6qxVqdRAD9dsR5M4jIWq9k/kGj8k5KPKgJQfdGWt+218QEfdBMpPS9QQPJeqw==
X-Received: by 2002:adf:d08c:: with SMTP id y12-v6mr16545445wrh.152.1531174464436;
        Mon, 09 Jul 2018 15:14:24 -0700 (PDT)
Received: from [192.168.8.10] ([185.175.214.210])
        by smtp.gmail.com with ESMTPSA id s17-v6sm12260230wmc.34.2018.07.09.15.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 15:14:23 -0700 (PDT)
Subject: Re: [V9fs-developer] [PATCH] Integer underflow in pdu_read()
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <20180709192651.28095-1-tomasbortoli@gmail.com>
 <20180709193151.GI30522@ZenIV.linux.org.uk>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bc857171-8abb-765c-d722-908ab743cd6e@gmail.com>
Date:   Tue, 10 Jul 2018 00:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709193151.GI30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 09:31 PM, Al Viro wrote:
> On Mon, Jul 09, 2018 at 09:26:51PM +0200, Tomas Bortoli wrote:
>> The pdu_read() function suffers from an integer underflow.
>> When pdu->offset is greater than pdu->size, the length calculation wil=
l have
>> a wrong result, resulting in an out-of-bound read.
>> This patch modifies also pdu_write() in the same way to prevent the sa=
me
>> issue from happening there and for consistency.
> What does cause the calls of pdu_read() in such conditions and shouldn'=
t *that*
> be dealt with?
Mmh I think that's caused by p9_parse_header(). That function reads the
first 7 bytes of a PDU regardless of the current offset. It then sets
the PDU length to the one read and then it restores the original offset.
Therefore, it's possible to set a size < offset here.
(to be 100% sure I'd need more debugging)

We can prevent it in p9_parse_header(), but if the invariant offset <
size gets broken elsewhere we fall back to the underflow. Enforcing it
in pdu_read() should be the safest thing to do as it would detect *any*
bad read.



