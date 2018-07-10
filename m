Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76085C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0720877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GTGkOHCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF0720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeGJAeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:34:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42285 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754579AbeGJAeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:34:09 -0400
Received: by mail-io0-f193.google.com with SMTP id r24-v6so18741853ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4s7lXAPOYioUlgb33EBj8Kuhngm7V/ZOp6+JHGgWFw=;
        b=GTGkOHCVEbt3fM6CIMY5pAuFt6oAdAGhlSZMjZAm2v5VsSDMzhwwYA2OtS7IobmJdL
         EWqT26+gtBM2JvqtN+58WkuNo+iTk3Dsai/UM/lmz2UeWYO/ngqYcNEkUNWk8RTw9b+T
         yBYBBTRbp1yi6s4/xPPcYYj0rN5yBUarI6AdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4s7lXAPOYioUlgb33EBj8Kuhngm7V/ZOp6+JHGgWFw=;
        b=j3/jubLOq87s4xfnXgT7As6fFt273waTiZ5yPNjpZVslO+Bw4TLl5eL9wnjpCy2r3y
         NZh8erVXlOcfS4bHr0TwBRfoGaNlNwjx191Q9UXlhscKIgbnLlS3lpSg97lsvb9pqtLf
         zPgQlt9ECDxa4T2kdzsAU768IvQBDDXYds8omXrR7vmr+hbhFtUR5YQYHAwutAqaPkS3
         HodSkEt1POWtIZamupZRj5yi+Oe9F5OaLAkR1zxg+QgtekSFJnFAsz0bWDU4kyZSl90f
         vKl19QsivJ64vs+uuCgFwvalJBIl92g+PTxWLytUUZ5qhnVJRLCwApAYqug7Xakb2Fc4
         MkUg==
X-Gm-Message-State: APt69E0Wzf6kEd+Mtp+o9zmtFtUK1FUhqHZBEX/1mje1Ttf8+zcR84xZ
        YsiXFHPbeLipevg41so33MZR5Vk7gODq3BDioLdYCw==
X-Google-Smtp-Source: AAOMgpeRNMj/Z7tvpkE8ArIJs3YwTMF3d7oI700uZZLsy3I3IlfFH+aqSrlnOIWiuSB6go515mcl9Wso0jAllJHPm68=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr3687982iom.238.1531182848541;
 Mon, 09 Jul 2018 17:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
 <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
 <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
 <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
 <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
 <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
 <CA+55aFzKmzC-2_6+RsRRu9KfK_r=UGgLN2Q0hSNBV=ScGR7=8g@mail.gmail.com>
 <6e3ca577f8dd5f3621d1054447d3f928a73dfcf9.camel@kernel.crashing.org>
 <CA+55aFy+ZSu5cPzk887N-ZgXqvTB=Bp1JQYMWT1SZY81MqLH6Q@mail.gmail.com>
 <1bc873980e7f63291fbe19dbc7e1607b8e126241.camel@kernel.crashing.org>
 <20180707164241.GB16279@kroah.com> <CA+55aFx-UX8nxewRFFWdBgYfPqfipnxaqJuJCUni9h4JvhoPFw@mail.gmail.com>
 <70f1312e76a9f53bf7749525ea881272c7007a34.camel@kernel.crashing.org>
In-Reply-To: <70f1312e76a9f53bf7749525ea881272c7007a34.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jul 2018 17:33:57 -0700
Message-ID: <CA+55aFzwjnL5C+kASzsP1rPOg+2BUanBAJsrOJKCKrJuhSwFUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:29 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> For devices with a class, we create a "glue" directory between
> the parent device and the new device with the class name.
>
> This directory is never "explicitely" removed when empty however,

explicitly

Is the mis-spelling why you had the quotes? I do find that spelling in
the kernel, but not in drivers/base/.

> This fixes it by instead doing an explicit kobject_del() when
> the glue dir is empty, by keeping track of the number of
> child devices of the gluedir.

Ack. This looks good to me.

I didn't see your 1/2 - you should probably re-send that one too so
that Greg doesn't have to fish for it. But I'll Ack that one too in
this same email regardless.

                Linus
