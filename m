Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA75C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2186020671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6VgFBd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2186020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJWO2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:28:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43050 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJWO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:28:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so399066eds.10;
        Mon, 22 Oct 2018 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LYSO8bfycwzAUHiZIUjGLiAemo6BhALMiLTu88MrWPg=;
        b=C6VgFBd4C4OQ4XYHGp1EUHrmNo/6RBKgoKE1mdy4vbLBtr8u9/IXWixM93brXUAecT
         GtquBK9pPFmPTFcU413EFV1y/uXDxjREyZZI+K5//cHtaNyd6eg3CJsaxnvWEGltZK0r
         S/D1oXx4z+q0jxZXRvZPvCTinnO0wga4XhphB9YebJ9nz/LlMyC8m1fwcm8UlFo7EJYM
         8PLx8+6bGuKO+PJpAOQXwGsRqPxY6V2DlQQCyttHAFABRHuhLiiOnGgLNm1B34BTU/zv
         CAHIiE7xFeUQ6YJJg3BxtcYayBAWDUxIG60wj29GywTmSxvmltQyGutmz2vN2+kzQdc0
         EW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LYSO8bfycwzAUHiZIUjGLiAemo6BhALMiLTu88MrWPg=;
        b=Vo7wUH/4W3eBkvrCKMuZPgwsKJwVO80rX+DgBO/Iv1amj8UWU2tL3SBao+51wrEOVH
         asaKQj9Fma/+JmgSJre1ga9y9jT50YKIrHqScea3knhCeghqMudNrtReR0KRhY4jGHYD
         5+9oikkwNdFQmVz1nFS17PHmCDco2Oi2c+K3Md2FCqMz6DWVGtDLmlMG2RAX3r3a33lT
         sgbeU7Nvv3gPPyCyNJCkiCsqPI8I5Ue+MB6QDrH0jqqbWOnVnYmlYlgdavn/BkYcTJOF
         BqCI5lyIY+AYlR0kaBsfZhb7JcayiihgkFNYw0uLfZZZrX/cMG9vza9PGJURbLzA+74t
         ivaQ==
X-Gm-Message-State: ABuFfojrDZq9j2zFkkHloZ4BT0MO1nglddPvU42Legde7afeFURrFjgU
        5vq2SCfiHNuv2ssDwu9vR+irdawvjAo=
X-Google-Smtp-Source: ACcGV6323TzXCSXbEL6RAm2LMX/gjS1iC2MbrwLB5GNxMxvllxsFu1+eVEXJ5N4T4qPYqUYDPRNIZQ==
X-Received: by 2002:a17:906:617:: with SMTP id s23-v6mr36238273ejb.207.1540274770353;
        Mon, 22 Oct 2018 23:06:10 -0700 (PDT)
Received: from [192.168.0.48] (ip5f5bfb8f.dynamic.kabel-deutschland.de. [95.91.251.143])
        by smtp.googlemail.com with ESMTPSA id q15-v6sm114700eju.51.2018.10.22.23.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 23:06:09 -0700 (PDT)
Subject: Re: Reiser4 Linux 4.17.19-1 hangs in Google cloud VM, too.
To:     Jose R R <jose.r.r@metztli.com>, viro@zeniv.linux.org.uk
Cc:     ReiserFS Development List <reiserfs-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181022101912.3CE2E292B005@huitzilopochtli.metztli-it.com>
 <20181023033852.GR32577@ZenIV.linux.org.uk>
 <CAM12Q5Q5qfrKQrw-2f_PX_FBgFsC6C=dde0gwn8ugBXEx05S_g@mail.gmail.com>
From:   Edward Shishkin <edward.shishkin@gmail.com>
Message-ID: <92ce097a-a896-c346-17e9-4789eb5c3c59@gmail.com>
Date:   Tue, 23 Oct 2018 08:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAM12Q5Q5qfrKQrw-2f_PX_FBgFsC6C=dde0gwn8ugBXEx05S_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 06:28 AM, Jose R R wrote:
> Thank you for replying, Al-
>
> On Mon, Oct 22, 2018 at 8:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Mon, Oct 22, 2018 at 03:19:12AM -0700, Metztli Information Technology wrote:
>>> I installed reiser4 -enhanced Linux kernel 4.17.19-1 --thus replacing the prior hung reiser4 -patched kernel 4.18.15-1 in the Google Compute Engine (GCE) cloud instance. After less than 24 hours the 4.17.19-1 hung in similar way to the 4.18.15-1.
>>>
>>> Please note that I had been running my custom Metztli Reiser4 Debian Stretch image with reiser4 linux 4.14.20-1 without issues for several months
>>> < https://github.com/Metztli/reiser4-debian-kernel-packaging-4.14.20 >  --until I decided to upgrade to newer kernel(s).

Hello.

Looks like a regression because of VFS/block-layer changes (I don't test 
new releases carefully enough). Once I am back from vacations, I'll have 
a look at this..

Thanks,
Edward.

> That link you referenced is just my hack for the corresponding Debian
> kernel packaging (wrapper) to build 'Reiser4 the Debian Way', i.e,
> generating reiser4 module & kernel -- suitable for installation media
> -- in addition to Debian's.
>
>> Er...  Does anybody maintain reiser4 these days?  I can't recall a single mail
>> along the lines of "such-and-such VFS/VM/scheduler/etc. change would break reiser4"
>> in quite a few years (more than a decade, most likely)...
> This is the actual patch for the Linux 4.14.xy series:
> < https://sourceforge.net/projects/reiser4/files/reiser4-for-linux-4.x/reiser4-for-4.14.1.patch.gz/download
> And yes, Mr. Edward Shishkin, still develops/maintains reiser4, please see:
> < https://github.com/edward6/reiser4 >
>
> I have a couple of reiser4 custom Google Compute Engine (GCE) cloud
> instances which have been running LAMP for a while. One of them runs
> reiser4 -enabled Linux kernel 4.15.x whereas the other one was running
> 4.14.x (both for several months/years already) until I decided to
> upgrade the 4.4.20-1 to newer reiser4 -enabled kernels. By the way
> this last kernel that I installed:
> uname -a
> Linux cohuatl 4.16.0-2+reiser4.0.2-amd64 #1 SMP Debian 4.16.18-2
> (2018-06-27) x86_64 GNU/Linux
>
> seems to be performing nicely --if things continue fine I can assume
> that the drastic change affecting reiser4 hacked kernels occurred
> beginning with upstream Linux series 4.17.x and on...
>
>
> Best Professional Regards.
>

