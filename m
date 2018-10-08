Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE75FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE6420C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUxPFTnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE6420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJIDPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:15:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42177 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIDPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:15:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so21167190otl.9;
        Mon, 08 Oct 2018 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kKzKuYLxFmOznQF7FZm25ikVnhG5wW3QzkssWMOODM=;
        b=SUxPFTnhXA5Lwizkj7EmFvhWmOU/5Cg6ICG4DtuuYWw7JMVmoIf5TqaVPgSEYDqM66
         lSIpKVlb3tUna0tJ/yOl3qF6QE4QRHdefD64khGwQrFK67l3w3myhNf1XI0qEZ96gQgX
         NM3Rz749aVLiQ7WjsDQV33BBQd/fRj25YAorxLScJc8uFLX7W7R2y4Y6YE11aoI/nVDc
         g75kQjJ9GMv1NmxArfjoclwdulrYaZcOUU9qtlnW8RZ6Ip0WA8Ie6FNRGLayXDbgDZ67
         FJy6MD+qlCdNwGdawycKIl/MGK05NckH+3C8Mh7pzE6G9u2j8YIipRova7c1x2IdpXgf
         74JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kKzKuYLxFmOznQF7FZm25ikVnhG5wW3QzkssWMOODM=;
        b=mWIgE0HBUflusOVQqlgM09555BRJM1yyiNK07/iQI/cy2nRe+a3UWCDFIR1Euo+v9Z
         cBL5cAN4tbhDMK+cUUFmIq8/Hkx4kw7b1n2zYCkZrSit0mKKp/3Z9m8gBzjeWsdkQzWq
         Y9cNYHCBI1GH2D5EtVdaRJ8ZDVzs29gIiA6Gpv+mC9vupA73vvkYkCfxZqRzVqh5QMFj
         MuqBBVOXHAzWNw99VH928CUZXWPP4mj6JuXyWSy3vYAKv1PS2WWX/G3c1G9tN35LPMOR
         LtN3tvyz+8JEuSSFw647A6n0iOxK+nkEP+d9lg491Gxc1qP6whId9zmTKHC4/sTHgiYV
         iKsw==
X-Gm-Message-State: ABuFfoh3RVZsJdoB8mEsAdY99tWWqbGjaCfckTi4Q1+LhmLqBXUG+y53
        7td5Jjsd7hXXmQZzVuN0E15Mxn8oWm7vzRt0/UM=
X-Google-Smtp-Source: ACcGV61vhlGnJyE8TpuKBWijPIj/pA9U6Ne44+NQl5AzeHhVDn33WKdHcCN3i840xcqt6ZD3Wihhl9PBbFj6d3sJjUw=
X-Received: by 2002:a9d:30c6:: with SMTP id r6mr14235922otg.344.1539028909567;
 Mon, 08 Oct 2018 13:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181008191913.11527-1-sudip.mukherjee@codethink.co.uk> <c7da9adc-3cb3-c5a6-519c-ba4440897c28@kernel.org>
In-Reply-To: <c7da9adc-3cb3-c5a6-519c-ba4440897c28@kernel.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 8 Oct 2018 21:01:13 +0100
Message-ID: <CADVatmOZ943m_bmXS9vQs8Fy73aaG1PNP1YCzX-J2HN_f5Zigw@mail.gmail.com>
Subject: Re: [PATCH] usbip: vhci_hcd: check port number before using
To:     Shuah Khan <shuah@kernel.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 8:29 PM Shuah Khan <shuah@kernel.org> wrote:
>
> Hi Sudip,
>
> On 10/08/2018 01:19 PM, Sudip Mukherjee wrote:
> > From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> >
> > The port number is checked and it just prints an error message but it
> > still continues to use the invalid port. And as a result it accesses
> > memory which is not its resulting in  BUG report from KASAN.
>
> Yes there is an issue with out of bounds access. But this isn't the
> right fix.
>
> >
> > Reported-by: syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>
> I sent in a fix for this last Friday.
>
> https://patchwork.kernel.org/patch/10628833/

And I can confirm this patch also fixes the issue tested with the
reproducer I was using in my vm.


-- 
Regards
Sudip
