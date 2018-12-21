Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC399C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918CE21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="CpeXKJEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeLUHyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:54:50 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37664 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbeLUHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:54:49 -0500
Received: by mail-wr1-f47.google.com with SMTP id s12so4198374wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TcTH1uBrFbHM5TUqFyAKGfLE4fV/8PIXa4Xv+tWOZjI=;
        b=CpeXKJEBH38B+wV+JUeB94LQ3Kcg9u7+xeYzoJfGaYRAIwChs2bscpIdcTVnmP18yr
         ONzXKOkXXPtbACGGt0r5g7wXElmn1/ep2CynWDc1xMXtU4OfB3o8P650+zawwZlEaYiR
         B0IAKvSl3q4M4sWD7l6Ulxw1wNQXDO4OIvF8c8o98XMH+Y7gejD50t7il1UJtIldm+M5
         sxLDp6GjNhxzDpEokLkKW00wvnBl5whnxckUl2Rl16YX9q38ziFyx8ptTHi//Z+E5oqM
         ueyGQTcKDt5WMkfy5J99tYtt8U8YaY9KJvLuWrAe6TsSoG/iY1SvTgYFO3yCkF7Z6mGT
         FxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TcTH1uBrFbHM5TUqFyAKGfLE4fV/8PIXa4Xv+tWOZjI=;
        b=NZn/Y59MECGq/s1Gg98sHPq6ix557zNBiEklEienwYBIdJKi2tufzJSD+x+AlrYnhC
         rc8LKQPDp6bpgaX1Wno+oPkgnEGK+hpNcn1YNXJzxQql+u6Gq3N4gaO0pnq7atQVFI6S
         EdnjbXT01tbb93T2a8lMHoXWIOdungc1xqvuEJ+lxsI+q02DGoIEUkkUpfqVnu4TRIk8
         F+dQ4afqgqv+9swE0T5ma24ghi3aVxQa/7eWFU18+P7QPXqQ6DziSb2hSN2BN83bhvrd
         58zipPof27xHVDEUC1liFSsUR8Bhu4/JA/Qv2Wig0iGuHG/sv0PGTp2OQdP/aXHjYgpl
         cJGg==
X-Gm-Message-State: AJcUukdSxfeVE2HMNhUoy2eeVBjZILOFs8NpmxVIlpFTwJhj854O17q1
        M6auiBucbdFZ75A69Nx4uQ0of9cqzjnvhTXqqDbcMg==
X-Google-Smtp-Source: ALg8bN63KWoeoOyTYrK/XtwpSGMkeJnYLX/sE5rZktbWmnkvtM19JARegC0/xIW6cDDKw+GrYmJu56bnhgu6YDAVSAA=
X-Received: by 2002:adf:e9d1:: with SMTP id l17mr1298188wrn.73.1545378887337;
 Thu, 20 Dec 2018 23:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20181220085922.332225035@linuxfoundation.org> <CA+res+QQt7GEL0td1FraSJNnR2yOcDgXGahW+YyiuMSeWTshfw@mail.gmail.com>
In-Reply-To: <CA+res+QQt7GEL0td1FraSJNnR2yOcDgXGahW+YyiuMSeWTshfw@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 21 Dec 2018 08:54:35 +0100
Message-ID: <CAMGffEn_TMi_17YBbg2KYk=_QArEJkdPdfV52wSqM+8QMhWyNg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/72] 4.14.90-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jinpu Wang <jinpu.wang@profitbricks.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        patches@kernelci.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        shuah@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: 2018=E5=B9=B412=E6=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=
=8D=8810:39
> Subject: [PATCH 4.14 00/72] 4.14.90-stable review
> To: <linux-kernel@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
> <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
> <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
> <stable@vger.kernel.org>
>
>
> This is the start of the stable review cycle for the 4.14.90 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec 22 08:59:06 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.90-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
> linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Merged, basic functional tests, no regression found.

Thanks,

--=20
Jack Wang
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
