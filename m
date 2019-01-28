Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496C4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB492147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="CuWKsfiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA1SZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:25:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34869 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA1SZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:25:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so9990457qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0TvI8XlvzQgp0hKNScvIv3Xp++Q8J8K9fYtVDjWpRGI=;
        b=CuWKsfiAVbLFJGRB25A6xk0Xwh0DCYOIRXX2iV+7gAVxtwHbQrwiiMPwglQ+OQCyuz
         trrkjXK0NU1UGrb4oU3AzHnuXhiGsMoh+dpr2RIwuDOITS1AlMYq08e3k1Le0P9XDudG
         CRNZn4BTDofJn87AK13oANNYFjVdv/xRYOUgpuqZ+H0IB7mB1aBYi3TqXRt6oib0Wl9a
         9gpxAvoZzjzPnblhqm7kauAanJdaYDhpN1XAFnnXunJ/I4NZEgKumxfvUjxRXlXZ2YZL
         6AdN5/1fl1du0bTMt3nhNE8NkqIT0xDhJN3ItzQ0T2y5/Vn7I+DiI/BCJhX5RY524Rvu
         X8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0TvI8XlvzQgp0hKNScvIv3Xp++Q8J8K9fYtVDjWpRGI=;
        b=R7kAk3HO6qm8U4MEgT1sMNQYHmJFEZDN0KAEoybXxz6HYZvXJCWbtEVN3aQNB5pCIu
         9gY7AmOGcUYh3cgZisqoQw24dvzJoDkaS58+tt5uvvbJQ1eg79+jGVNV7ah22UGLi3ac
         HOoKAZSya7JuupBBXEizOlJxO8D4pG4FSDxAeFSzAfltI63of+gnmqeooZm/5OjVMeku
         PJtUZ6ls7h2s3LY2c5b8FDU6gP9CwrXIau4w3uVd9E9VX1rdgjzmdsM8oWPgTWkv8lil
         YqLZpzpDLu4yJuX6HceVFCxHDM469DnpjczClotmqTbl0PvvdiMNmE2jTEErujgags/P
         Xxrg==
X-Gm-Message-State: AJcUukdzaah4sAdypt7ApD/0GPKiXXATzZ+WEbWeMvI2I5fly9sMGjo1
        ybUOdSY8/0yDwUbXdxN6tcI6ahRRgaEkWIXcCDyrO6Xc
X-Google-Smtp-Source: ALg8bN4pauox05IaU1iVGnmWFJcPISOTi2UH0mLq++ROxnB5CGLy5zgBM6V0xgLA/73JV0ICwoKHJi7ldhdNlNXfcEc=
X-Received: by 2002:a37:97c1:: with SMTP id z184mr20393428qkd.39.1548699951675;
 Mon, 28 Jan 2019 10:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20190117210258.7871-1-jeffrin@rajagiritech.edu.in>
 <20190122194352.GA11489@garbanzo.do-not-panic.com> <CAG=yYwmeGp7fT_3wPpnpHgzFUdYJuFCThUBaPL=DW9e4OZt_BA@mail.gmail.com>
In-Reply-To: <CAG=yYwmeGp7fT_3wPpnpHgzFUdYJuFCThUBaPL=DW9e4OZt_BA@mail.gmail.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Mon, 28 Jan 2019 23:55:14 +0530
Message-ID: <CAG=yYw=t1-oZy5=E1j_=Qwx_0epmPhqQPJD2HkCYpQnxDroT2g@mail.gmail.com>
Subject: Fwd: [PATCH] selftests: kmod: worked on errors which breaks the
 overall execution of the test script
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Mon, Jan 28, 2019 at 11:33 PM
Subject: Re: [PATCH] selftests: kmod: worked on errors which breaks
the overall execution of the test script
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, lkml
<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
Andrew Morton <akpm@linux-foundation.org>



>
> on what
> distribution and version of bash does this break?

$cat /etc/issue
Debian GNU/Linux buster/sid \n \l

$
$uname -a
Linux debian 5.0.0-rc1+ #3 SMP Fri Jan 25 21:27:20 IST 2019 x86_64 GNU/Linux
$echo $BASH_VERSION
5.0.0(1)-release
$


>
> The commit log should
> refer to this and it would help me confirm the issue.

i like to send another version of patch which has things in the commit log
>
> > because an array is passed
> Which is the array?

${TEST_DATA#*:*:}
the above stuff sometimes contains array but not initially

>
> get_test_enabled() is supposed to do what you do open-handed here.
> So the better question is why are you getting an array returned
> for your version of bash.
>
iam not returning an array but ${TEST_DATA#*:*:}   sometimes holds array



-- 
software engineer
rajagiri school of engineering and technology


-- 
software engineer
rajagiri school of engineering and technology
