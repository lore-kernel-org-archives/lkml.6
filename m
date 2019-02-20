Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74241C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419282147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua8MmsaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfBTGqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:46:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37917 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfBTGqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:46:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so11707828plb.5;
        Tue, 19 Feb 2019 22:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ROb/RejqZ0N/E3dCv+QO9wYT6jcX40iiHO7okLpCa0s=;
        b=Ua8MmsaLdC5TtFUunGkh0TrS07JPSDxbZIiqxycPe4wRv8on8IuYZC6lfzhbCcRUt5
         RIrYJy5+P+f3RwiEqA6TQ+JV/jaT3bQ7EDS/8xwGfljyiN7Zk6KpQILU0oI0PFUvuENQ
         9fW8apGOS3JK4e+0vdQ/bj1X//O/4t995wZu/swz4X9kigKrGwUhraZ/8/3J9f8JxCUF
         rHbhuDdEhC0ncJKswh29lSHqk9hM63H9rwSt/Gdf18dcfNy2merQUaOhl+wMaQeJ+aii
         c30PWj6veRUWM3n6YC2+KnkpDgU0g8Yz7jf1Y3RcF3cnmfEooYa6U+Hgi3NxMQOWmuQm
         IWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ROb/RejqZ0N/E3dCv+QO9wYT6jcX40iiHO7okLpCa0s=;
        b=a6G4n/mTWD01Q50Z0SsIwN7YzY35FA05AWGorBVvASUGVMCwstRmxa6NHvHdR+NTIS
         nHfG3Lr8VHJA+FEAFjmsWsYD5Jvpv991cAKME2qUkMoFap/bPEuKo18P9nCH4QIbYEzx
         +ctFIc1DysbbRQ5gT38FdmrGW9q18zBchGnzZRLIIhssmvYHTqFHU6+5YuHdiaGGnZAs
         fNqt/WAe7paGsyTQxW8qBS7VZBjihWWjB+wpUgcuGvgSJ+N/JSYOZwuoqT+j7hjHjzcD
         AO+57jtHv+mAd00WmkhlvAue1BjQRV6tvKQVeP9nR3n49TcF2czkM7NkBpESjYbPS3Om
         3vLQ==
X-Gm-Message-State: AHQUAuZmpNJmryB5EOwjx4Tegr8mYy7mLSVDW0ESeHjtVoiX+GpSwAaS
        SeFRPHoeJS3Ng2CMCoTHsQA=
X-Google-Smtp-Source: AHgI3IYZqYX41ndpZ4DNXcOkaMB4wRloN9t2xbOloz7ON8DvDdcMQg6/LycWQsN/gEcZsgYIbnUYYg==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr33505388plb.70.1550645182508;
        Tue, 19 Feb 2019 22:46:22 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 15sm26234874pfr.55.2019.02.19.22.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 22:46:22 -0800 (PST)
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, dan.carpenter@oracle.com,
        wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <a6ae907e-391b-993e-6011-6f40c761b339@gmail.com>
 <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4dff3b1a-7ded-7218-5325-3c397cc3c73e@gmail.com>
Date:   Tue, 19 Feb 2019 22:46:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44AmF6eN-HKwHOqPiGZHNc2K_wAmWR3PkV0OX-=YNUKDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 10:34 PM, Brendan Higgins wrote:
> On Mon, Feb 18, 2019 at 12:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
> <snip>
>> I have not read through the patches in any detail.  I have read some of
>> the code to try to understand the patches to the devicetree unit tests.
>> So that may limit how valid my comments below are.
> 
> No problem.
> 
>>
>> I found the code difficult to read in places where it should have been
>> much simpler to read.  Structuring the code in a pseudo object oriented
>> style meant that everywhere in a code path that I encountered a dynamic
>> function call, I had to go find where that dynamic function call was
>> initialized (and being the cautious person that I am, verify that
>> no where else was the value of that dynamic function call).  With
>> primitive vi and tags, that search would have instead just been a
>> simple key press (or at worst a few keys) if hard coded function
>> calls were done instead of dynamic function calls.  In the code paths
>> that I looked at, I did not see any case of a dynamic function being
>> anything other than the value it was originally initialized as.
>> There may be such cases, I did not read the entire patch set.  There
>> may also be cases envisioned in the architects mind of how this
>> flexibility may be of future value.  Dunno.
> 
> Yeah, a lot of it is intended to make architecture specific
> implementations and some other future work easier. Some of it is also
> for testing purposes. Admittedly some is for neither reason, but given
> the heavy usage elsewhere, I figured there was no harm since it was
> all private internal usage anyway.
> 

Increasing the cost for me (and all the other potential code readers)
to read the code is harm.
