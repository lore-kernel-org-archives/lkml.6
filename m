Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E18C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D4420676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKWoJF3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D4420676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeI1XbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:31:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40521 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1XbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:31:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id r83-v6so6513124ljr.7;
        Fri, 28 Sep 2018 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AmN2RLUraPOowbTm6/9lMPvStBmCf7yyXoO+5eYuees=;
        b=gKWoJF3ieKDgME2u0UTZFG5T+lU2mbZHUR7wYeb5yx9A5xkNJJMp7DYRqiCoGiLuG5
         E+JAiOgh2mStxxNFYr0+0A1+WUh/2hJk7JClph8pHwKpbgTHi1thC8zU36K5BsKovJGK
         TyWRPYRDPDTUpmmxEvlEfo/9C3pEzj4etZlRb9CAl2FRqiIVGldz2BZPP2Vi4ccoCI9C
         E133sNa8a3hSy4WzwFtcfZL30t6/ju6suvVC0yTsVkbngKYmEyVPr8RPEopkYhKmAExi
         ElwvvPJbjLszwvD/MM+JQkQHxVBfQ9fJnoY11AgXXlEtyEF0aRlau/7mvFGvUQUjKejk
         TAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AmN2RLUraPOowbTm6/9lMPvStBmCf7yyXoO+5eYuees=;
        b=qfG1KOo7FvnoevFitXSJ0XJ6SwexJhNbZFLNY+fhE283C3bXN++SWKl28qSUSXjXQs
         knQtKiZeVyNdtJY3jM/EyOqZUacxLE34Eio3TeVzzVFqFfIohBgahEtZp+WW88v7PI2a
         wmNcqSJh1ZHa3PsN1ESNhYtSLKsaEyPEYtdK+GApq4k13fTg6qw1UoLUNfJ5j6Vl30rY
         9SFCum77L/tYsv+yuJ5bpQSEtCaXfsER0xswOLgzd2cupbLXoHQMVYOXKWJeozNDRb5q
         hXhfrebKH9NeZR21fjAil+XB0hxIOoY1u+pros9xKQ1tiHon3tfdLfpD2w1KwSjpMzaR
         xZoQ==
X-Gm-Message-State: ABuFfogcvuGYkCQW0tWUozo+tzVIZUKAi0j6m41CNCTlvfDakgnhqJR/
        ewO9AcwYphCais3tZhGrFw4=
X-Google-Smtp-Source: ACcGV609O+PVj14DY3yPpop98aI/qeujaeRsKT0zLXAcXdoggQRp84E0ToVaJYxmQfA3EJNIjxmQDw==
X-Received: by 2002:a2e:84a:: with SMTP id g10-v6mr4752440ljd.158.1538154391645;
        Fri, 28 Sep 2018 10:06:31 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id w19-v6sm1019210lji.73.2018.09.28.10.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 10:06:30 -0700 (PDT)
Subject: Re: INFO: trying to register non-static key in tun_chr_write_iter
To:     syzbot <syzbot+e662df0ac1d753b57e80@syzkaller.appspotmail.com>,
        brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com
References: <000000000000c1119b0576efc7f6@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7ea5ea14-718c-6845-32d8-f8bc862949a1@gmail.com>
Date:   Fri, 28 Sep 2018 10:06:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000c1119b0576efc7f6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/28/2018 08:05 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    100811936f89 bpf: test_bpf: add init_net to dev for flow_d..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=145378e6400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
> dashboard link: https://syzkaller.appspot.com/bug?extid=e662df0ac1d753b57e80
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
>


I took a look at this report, I will send a patch series fixing the issues
I found in tun driver.

