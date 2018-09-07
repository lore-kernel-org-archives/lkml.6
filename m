Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34143C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A5220652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="tmWZFRgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeIHDbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:31:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36207 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeIHDbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:31:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so7657795pgo.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UQYZyQ0VxJf4pviIVKEXs3ZetDN/d6IcQ+ILJuy8dYY=;
        b=tmWZFRgGrLghh9RZ/AD4WJC5uuxrkLQe0Zh4onMT5q12q++pygSGHNCFOyh1fGPOap
         ad54X9Sj29mZZ8w68m8ukP7zr/9G4dfAkeLuNaWh7v4F6pmjrkeNbawl42VcH0j/ev5H
         f2oa8KCUrzxm4/TYFTEIhA/JVgnhyhl5p5Uymt9VZmcj9BcIlRzWHIbxulEE0e+J0L9W
         xSMrxTZ1XtsaLHKAS0PIwT0rZefPxJMPhWts37vw3R9kDz0wTUJKf6ErpaC7TejDAmEi
         0D2I8AhBv7m52RTdtXxqaRHtb/bFzgaJQUB7BVQEISVmqfM1W4STtHbtfhDiqVpS6y84
         NA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UQYZyQ0VxJf4pviIVKEXs3ZetDN/d6IcQ+ILJuy8dYY=;
        b=Gv4VKHy1XNaaF/IJeQCqNBb4f5UtbF9xTk5/wngVs5C8sKHxDMEjY/jtF7fsbp1EMm
         0zqriYv8mfAesZbVHdFdBd3D1yV5rFCZI0cVfY379w+emj/MyShzopVnaBaYpeGCeSjB
         5as/mLx1zeJ6ZwjErSDCtpqbyQmZaWw8Lkvwj9b+GTuXpItTeT1keVJGb5zxm8p6jXzz
         zjqa+dFw/E9jm7BG/BiCpo7QXzaBP6f/3+/9pJZgmCd7tx5G2ZTbuA32IyjcvViJoFXy
         VErWnzQX2bey9j6bfhzfKffL1fIibwFEaFGURcGCb6Jtm2W/oTbrlfJp6yhDXnLzdCwB
         Cn0A==
X-Gm-Message-State: APzg51Bw1hkxTYnI/irO+KHi0BkYRidTkA9Yer5CUaayEVC3/zX0h/94
        7Lk1Ecdva6ou27J3EV2h0sTlHg==
X-Google-Smtp-Source: ANB0VdZl9K7ducMDIzQFuA2U8O3mK6RJ9wFs2gUfbBbFegT/5U79b9wgPA6yu7Rlz1r06MT/dmUZzg==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr10912794pfe.209.1536360501121;
        Fri, 07 Sep 2018 15:48:21 -0700 (PDT)
Received: from ?IPv6:2600:1010:b062:3446:55bd:a895:1fd7:cbdb? ([2600:1010:b062:3446:55bd:a895:1fd7:cbdb])
        by smtp.gmail.com with ESMTPSA id b21-v6sm20809474pfm.97.2018.09.07.15.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 15:48:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 1/8] x86/mm: clarify hardware vs. software "error_code"
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180907194854.74729D71@viggo.jf.intel.com>
Date:   Fri, 7 Sep 2018 15:48:18 -0700
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        luto@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <561334F6-9C13-424A-95ED-D377CE48DA46@amacapital.net>
References: <20180907194852.3C351B82@viggo.jf.intel.com> <20180907194854.74729D71@viggo.jf.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 7, 2018, at 12:48 PM, Dave Hansen <dave.hansen@linux.intel.com> wro=
te:
>=20
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> We pass around a variable called "error_code" all around the page
> fault code.  Sounds simple enough, especially since "error_code" looks
> like it exactly matches the values that the hardware gives us on the
> stack to report the page fault error code (PFEC in SDM parlance).
>=20
> But, that's not how it works.
>=20
> For part of the page fault handler, "error_code" does exactly match
> PFEC.  But, during later parts, it diverges and starts to mean
> something a bit different.
>=20
> Give it two names for its two jobs.

How hard would it be to just remove sw_error_code instead?  It seems like it=
 adds little value and much confusion.

I=E2=80=99m also unconvinced that the warning is terribly useful. We=E2=80=99=
re going to oops when this happens anyway.

I=E2=80=99ll rebase my diagnostic patch on top of this series after it settl=
es.
