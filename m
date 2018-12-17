Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FDEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0088621783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaFJhUVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeLQWPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:15:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33770 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQWO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:14:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so12465831ljd.0;
        Mon, 17 Dec 2018 14:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2zzpODZ6KmJV4BHubr5YBpf4w20/yVSUBEnPmY/rsvs=;
        b=CaFJhUVnJ+7U54OlM6Ml9qkFC4ghRB6zAYaTGzAxu+Ispt9ejR0ZA/c2P78hpRzQgW
         baP0M23f2hQuyRJlW42A3BFljPixp4kwb22zQY26ziJyfvoEPnQotsT1H0zHBd7r0OP3
         P3/LGtm7hKPVQ1FKEFpylEpyFkpKNQ+Ty7vhvumx/2gM6u7iPk19s5JY5LDE193w+vVf
         eiyX/2RwxuNvIB05Ce5v0rVmoYy4E0fB85OSdsK5zGz+MQMxT7FAf2Rtk2lHTc2W2p1h
         iuA1HTvyoRHHRVpMUH8D/6KOxgvSrGIGNg4p8O/r6gQC2vp1KRB05nEvUgF+PIuYp+Bj
         7Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2zzpODZ6KmJV4BHubr5YBpf4w20/yVSUBEnPmY/rsvs=;
        b=PG6Nh1uIC13Ct+hHt6Ab/yYgCTnE3ZW6ybJ4k8lY+XdJ/Zt2GRhDTJFwlKN1cO+EO5
         7hzGN1PpkEz8tTNsnUziB6aU9tRPB16TkNE7KEmgpqIkjNdjrXx7UkJB8q/FezNIRdAc
         9Eeatwa1vzQjfP1T0dBzOH7pGleTmh3IgG7z/Pec6YCNWPpdn6D2i9QGJoZ7I5g60QX8
         Gcu8q38dY3Od3257r/5s8TNrXRbSAB1JaARIef+1aYKckU0ReyT3jYjS5I16Hpqz/ojI
         RplRY561hEV0m80BbVvYSFVrxdt7wLI0S7Le/beThPIYQinBAb8CZsff+QLdnI/ZAeiE
         s37g==
X-Gm-Message-State: AA+aEWYgDr3TW3WTeMWPTfXY0RDJqEBkZ3b+h5rNFQA863hSLADcEK/k
        1Ygx2OZcsUP41PSE5DhGh6WAi+Xq/IYJcw==
X-Google-Smtp-Source: AFSGD/UNc774piNgLwhUD9HklXvgQe1aox2B1ZXZ7MWbvllEIiRYtEjSOua6i0bNTOZ4zoVuiOPi1Q==
X-Received: by 2002:a2e:8446:: with SMTP id u6-v6mr9724985ljh.74.1545084895616;
        Mon, 17 Dec 2018 14:14:55 -0800 (PST)
Received: from [192.168.0.21] (87-50-154-159-cable.dk.customer.tdc.net. [87.50.154.159])
        by smtp.gmail.com with ESMTPSA id e14-v6sm2779076ljl.43.2018.12.17.14.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 14:14:55 -0800 (PST)
Subject: Re: [PATCH 1/3] 9p/net: implement asynchronous rpc
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
 <0da7d896-0d67-46f6-83f9-b346eba991a9@gmail.com>
 <20181217110111.GB17466@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFpCTZMBEADNZ1+Ibh0Z4pgGRcd1aOUMbe/YfHktmajjcoTnKmZZunjoUVAl8waeLITd
 BC2c8i1wHzHcnthrmb1izs5XlG6PZnl8n5tjysSNbwggzS1NcEK1qgn5VjNlHQ5aRMUwCC51
 kicBiNmlQk2UuzzWwdheRGnaf+O1MNhC0GBeEDKQAL5obOU92pzflv6wWNACr+lHxdnpyies
 mOnRMjH16NjuTkrGbEmJe+MKp0qbjvR3R/dmFC1wczniRMQmV5w3MZ/N9wRappE+Atc1fOM+
 wP7AWNuPvrKg4bN5uqKZLDFH7OFpxvjgVdWM40n0cQfqElWY9as+228Sltdd1XyHtUWRF2VW
 O1l5L0kX0+7+B5k/fpLhXqD3Z7DK7wRXpXmY59pofk7aFdcN97ZK+r6R7mqrwX4W9IpsPhkT
 kUyg3/Dx/khBZlJKFoUP325/hoH684bSiPEBroel9alB7gTq2ueoFwy6R3q5CMUw3D+CZWHA
 3xllu46TRQ/Vt2g0cIHQNPoye2OWYFJ6kSEvaLpymjNDJ9ph2EuHegonDfOaYSq34ic2BcdB
 JkCgXRLP5K7KtRNJqqR+DM8xByeGmQv9yp6S97el+SiM9R53RhHawJZGz0EPl+2Q6+5mgh3u
 wXOlkmGrrSrlB8lc567l34ECl6NFtUPIL7H5vppIXAFl7JZUdQARAQABtB50b21hcyA8dG9t
 YXNib3J0b2xpQGdtYWlsLmNvbT6JAlQEEwEIAD4WIQSKOZIcNF9TdAG6W8ARUi5Y8x1zLgUC
 WkJNkwIbIwUJCWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRARUi5Y8x1zLvCXD/9h
 iaZWJ6bC6jHHPGDMknFdbpNnB5w1hBivu9KwAm4LyEI+taWhmUg5WUNO1CmDa2WGSUSTk9lo
 uq7gH8Y7zwGrYOEDVuldjRjPFR/1yW2JdAmbwzcYkVU0ZUhyo2XzgFjsnv3vJGHk/afEopce
 U6mOc2BsGDpo2izVTE/HVaiLE9jyKQF6Riy04QBRAvxbDvx1rl26GIxVI6coBFf4SZhZOnc0
 dzsip0/xaSRRIMG0d75weezIG49qK3IHyw2Fw5pEFY8tP0JJVxtrq2MZw+n4WmW9BVD/oCd/
 b0JZ4volQbOFmdLzcAi2w7DMcKVkW11I1fiRZ/vLMvA4b79r6mn3WJ8aMIaodG6CQzmDNcsF
 br+XVp8rc58m9q69BTzDH0xTStxXiwozyISAe2VGbGUbK9ngU/H1RX0Y01uQ9Dz0KfyjA0/Z
 QOBa4N1n1qoKFzoxTpu0Vyumkc5EnTk8NdWszt7UAtNSaIZcBuWHR7Kp0DqRHwom0kgTiNXJ
 8uNgvvFTkPd2Pdz1BqbpN1Fj856xPuKIiqs5qXI2yh3GhntFDbTOwOU3rr3x5NEv3wFVojdi
 HcLM+KVf29YkRHzuEQT5YT9h6qTk2aFRqq3HSXrP56hQ3whR7bQtziJspkuj+ekeTxcZ5lr4
 9FJI03hQJ4HbHn6x/Xw0+WjIOo4jBeUEI7kCDQRaQk2TARAA4JCPcQcISPAKKC1n9VQxgdH3
 oMqxhJ+gh/0Yb394ZYWLf7qOVQf/MgALPQIIFpcwYrw7gK4hsN7kj1vwPFy9JIqZtkgbmJHm
 aCj1LkZuf8tp5uvqzMZGcgm28IO6qDhPggeUE3hfA/y5++Vt0Jsmrz5zVPY0bOrLh1bItLnF
 U3uoaHWkAi/rhM6WwlsxemefzKulXoR9PIGVZ/QGjBGsTkNbTpiz2KsN+Ff/ZgjBJzGQNgha
 kc6a+eXyGC0YE8fRoTQekTi/GqGY7gfRKkgZDPi0Ul0sPZQJo07Dpw0nh5l6sOO+1yXygcoA
 V7I4bUeANZ9QJzbzZALgtxbT6jTKC0HUbF9iFb0yEkffkQuhhIqud7RkITe25hZePN8Y6Px0
 yF4lEVW/Ti91jMSb4mpZiAaIFcdDV0CAtIYHAcK1ZRVz//+72o4gMZlRxowxduMyRs3L5rE0
 ZkFQ6aPan+NBtEk1v3RPqnsQwJsonmiEgfbvybyBpP5MzRZnoAxfQ9vyyXoI5ofbl/+l9wv8
 mosKNWIjiQsX3KiyaqygtD/yed5diie5nA7eT6IjL92WfgSelhBCL4jV0fL4w8hah2Azu0Jg
 1ZtjjgoDObcAKQ5dLJA0IDsgH/X/G+ZMvkPpPIVaS5QWkiv66hixdKte/4iUrN+4waxJLCit
 1KGC2xPJ2UUAEQEAAYkCPAQYAQgAJhYhBIo5khw0X1N0AbpbwBFSLljzHXMuBQJaQk2TAhsM
 BQkJZgGAAAoJEBFSLljzHXMuOb0P/1EnY4Y6LfQ6bmhJQ6epA3fB70hRWCQsuPYLAgPKRoXy
 kmWH4ljqQDbA55TtIpnod/woR0IDnZcD7E9cyGzM2rHvSLXTkHhgIWacZHZopAUzq4j0lhiJ
 Wu57freQPU4rzMVGZXBktUsDMsJwp/3Tl2Kjqylh90qIOlB9laUusLIbl4w5J3EscIJzWvdL
 y1lJLtBmus/t75wN/aIB8l9YBKGuy0L4SAmjhN52pCgP/S+ANEKvdghQco51a4jD2Pv2uYH7
 nUU/Y70AmqOHjPR+qZ0hAUw6B+UtWQ+Fl587Qqi2XPUzdA8G2EjGFFPRlnhf2H/gOyAfeVYL
 NDwDgm9Yzp7Rx0O1QOnQsXTHqk7K38AdSdM2li/I/zegeblInnLi08Gq6mT6RkD6wV9HE5U3
 EIU0rDPyJo54MW39wGjfC2+PM5I0xebbxtnuTewRchVVfm7UWgLAy11pV3xM4wMSJOuqVMOz
 jYpWKYxDTpvsZ0ginUUY993Gb8k/CxjABEMUGVHhQPZ0OzjHIKS6cTzN6ue8bB+CGOLCaQp1
 C0NRT5Tn9zpLxtf5nBExFd/zVENY5vAV2ZbKQdemO54O7j6B9DSgVRrm83GCZxbL4d+qTYBF
 3tSCWw/6SG1F3q9gR9QrSC2YRjCmhijUVEh6FhZwB58TNZ1sEEttrps8TDa5tUd9
Message-ID: <1bcb0d99-fc35-3390-e751-5c4ad623e418@gmail.com>
Date:   Mon, 17 Dec 2018 23:14:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181217110111.GB17466@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 12:01 PM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Mon, Dec 17, 2018:
>> sorry for the delay, I've been quite busy these days.
> 
> No problem.
> 
>> The patches looks good to me and should indeed speed up the code a bit.
>> I quickly tested them against Syzkaller tuned for the 9p subsystem and
>> everything seems fine.
> 
> Thanks, can I add your Reviewed-by on all three?
> 

Sure, FWIW.

>> And by the way, which refcount races?
> 
> There's a problem with trans_fd read_work and cancelled callback; I'm
> not so sure about refcount but we can definitely get double list_del
> as we're not checking the status. I think when we incorrectly remove
> from the list we also mismanage the refcount, but honestly need to
> test..
> 

Yeah, definitely it needs  to check the status. Btw, if a double
list_del happens the kernel should crash.
