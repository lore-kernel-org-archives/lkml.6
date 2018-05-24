Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033242AbeEXOW2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:22:28 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:34343 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030742AbeEXOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:22:24 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w4OEM7UX018633
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AB8JxZoq5xW8920qyQerq3asFsiTFpPmTW0YxBsAvPgOFjIFOirdMH78Tsko84Ob+oK5/JAAAOE499f12IYYxqg40cM=
MIME-Version: 1.0
In-Reply-To: <20180523044609.GA23800@ravnborg.org>
References: <20180522194928.GA29900@ravnborg.org> <CAK7LNAQUF6YbHRTJOtQ9F91M-iqF1U+PemDAbsdx3qzcqg4Ufw@mail.gmail.com>
 <CAK7LNAQWHeR71=H5Z94jAMjRjE-kmjFaPrQy6_cd5=G_WHEpUw@mail.gmail.com> <20180523044609.GA23800@ravnborg.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 24 May 2018 23:21:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARata6s_Dm_ykVNX2o15psE0LyuFvXQFESa7=n58s+nxg@mail.gmail.com>
Message-ID: <CAK7LNARata6s_Dm_ykVNX2o15psE0LyuFvXQFESa7=n58s+nxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] kconfig: drop localization support
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,



2018-05-23 13:46 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> Hi Masahiro.
>
>> > Ulf Magnusson originally mentioned this removal some time ago.
>> >
>> > So, here is his tag.
>> > Suggested-by: Ulf Magnusson <ulfalizer@gmail.com>
> Added.
>
>> PHONY += xconfig gconfig menuconfig config syncconfig update-po-config \
>>      localmodconfig localyesconfig
>>
>>
>> The 'update-po-config' is left-over in the PHONY assignment.
> Good catch.
>
>> This is simple, so I can fix it up locally.
> Fine
>
> If there is any other feedback I will respin the patch.
>
>         Sam
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Applied to linux-kbuild/kconfig.  Thanks!


When I applied this, I added the following fix-up.



diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 54266f3..0aabc1d 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -2,7 +2,6 @@
 # Generated files
 #
 *.moc
-*.mo

 #
 # configuration programs




.mo is no longer generated.

It was added by
commit c26dd719a5b9d94d12211f2d101bd7dffb7f9f1f



Please double-check if it is OK.



-- 
Best Regards
Masahiro Yamada
