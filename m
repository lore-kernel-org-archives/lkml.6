Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB682086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="F7rC61w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB682086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeIKXYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:24:12 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41146 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIKXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:24:12 -0400
Received: by mail-ed1-f49.google.com with SMTP id f38-v6so19975853edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5931aHJ0SiTio5MsKfcYNyT3U/UPc5zo3OJiAvM50Wc=;
        b=F7rC61w43ZpA8t/XxwarunPvBwThI3vo6CoVHcPpmMbJ5arKeVpjRi1CKMsIiq31wG
         WCKD86G19rc+7QcEnelFI2pGpCNifK7EKQvDYctg+rrgq98eyVdxXh2chq9BJg/9zKo5
         +7imP7c2y8FQ/FouWeD6GdpcSdq0xD5Mbt9yQXETA0X52lKnlIacklZWWI4FkwUrX7JS
         SxUk0Me8zqkfZ6BqGBua2o681zvOoLHXcj4IG61kFNQA3HWKTiKLm18XBpPF5T0T29Yd
         6/Lh4ks8pY1qN8Z12QhlvrpkCTGmSvpzgbMWs+t//zeoo5iurfyqBA7TwBhigMu+UAgb
         NhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5931aHJ0SiTio5MsKfcYNyT3U/UPc5zo3OJiAvM50Wc=;
        b=frGqoe7i3QvmglHkbPJo+/2pyM8TL2qbseemxw29CV5WWn86lkzDUwh3m4/chOUFaD
         VsNl4F34hgKw5Spn4Z/Z4A+rjv5WOl8izzT40AISWoMkmr+BDO1XwyhHy7DswD+6GZRe
         JbBocXOeWtzSdHD5xG6OCmtbllv1RFAqbRJR08JO2eyfqPZH9Kg9DCjIaqYHk7thVPy6
         VMJ1guC1Vyvl5CNWsT9ANAQuFvNwpgoSBbBh7z5og7hG78PAW3pmY4FISmBgOIWWiVF4
         e7oyEew7VZJxplXaKJ7YTWIaXcLorpa4/6wO8pcyaIkG+uMvjdtEy63dvuuaZxvYwLU8
         jq/w==
X-Gm-Message-State: APzg51CTTtXiEwh/Jjp5HZSYKEL+e8nUbJ99Gxd2vW1VLrt7iS49yjKB
        IPzO+VFNQBZQZwbEi3HksX+TAFSBWeviZb6UTCuvow==
X-Google-Smtp-Source: ANB0VdYR0/j40UCkr0Vl7U+q8wrsaTuim2GuM9TnN0I/0FOsfJUOav5ecfsq3s44r+33MlnI3eXSJSk8se0at6fewyg=
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr30461746edk.12.1536690218997;
 Tue, 11 Sep 2018 11:23:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:955c:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 11:23:18
 -0700 (PDT)
In-Reply-To: <20180911111217.3e3679c5@xeon-e3>
References: <20180911180406.31283-1-vasilykh@arista.com> <20180911111217.3e3679c5@xeon-e3>
From:   Vasiliy Khoruzhick <vasilykh@arista.com>
Date:   Tue, 11 Sep 2018 11:23:18 -0700
Message-ID: <CAL0zPMPx3B+TXvHTzAW+RcgO6a6jPN47zS8E6nA4+2cRzFM+Tg@mail.gmail.com>
Subject: Re: [PATCH v2] neighbour: confirm neigh entries when ARP packet is received
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jim Westfall <jwestfall@surrealistic.net>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ihar Hrachyshka <ihrachys@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:12 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 11 Sep 2018 11:04:06 -0700
> Vasily Khoruzhick <vasilykh@arista.com> wrote:
>
>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>> index aa19d86937af..56a554597db5 100644
>> --- a/net/core/neighbour.c
>> +++ b/net/core/neighbour.c
>> @@ -1180,6 +1180,12 @@ int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new,
>>               lladdr = neigh->ha;
>>       }
>>
>> +     /* Update confirmed timestamp for neighbour entry after we
>> +      * received ARP packet even if it doesn't change IP to MAC binding.
>> +      */
>> +     if (new & NUD_CONNECTED)
>> +             neigh->confirmed = jiffies;
>
> You might want to do:
>         if ((new & NUD_CONNECTED) && neigh->confirmed != jiffies)
>                 neigh->confirmed = jiffies;
>
> This avoid poisoning the cacheline with unnecessary write.

Sorry for duplicate - this time in plain text, so it should get
through lkml filter:

I don't think that it's performance-critical path, so this
optimization is unnecessary
and it doesn't improve code readability.
