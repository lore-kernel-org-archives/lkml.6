Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D19C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA562147E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jyD5jy2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA562147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeHQEz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:55:57 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:27015 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeHQEz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:55:56 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7H1sTxO014098;
        Fri, 17 Aug 2018 10:54:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7H1sTxO014098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534470870;
        bh=nZDgf0quRi0OAx/b0M3EJVFPiEZ5MyUzyvt46QwlaEA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jyD5jy2RwqmPJ8XQgkXMKMFcbk7rU8shiG4ogsH+x8/G/PfpYd252eFep76psyLFB
         M1RpGt129r4qaXoWO9gdKbsuv5KLAP6YSpd6/jXVz9wCUIYOlDGcuto469vikfOLrE
         oW/YxjdM1nQSi96k/Zn8NEOWDtP2cXrTeb22unkrUqEXdS1HrEvFiPNubG/9tvlsQd
         raeLGNLzqkmz8qsDW5O8aGAa8dezOsNX8uk+4Kp9EzvotQk1gwHbEKqkfQXNKiLVIA
         2InaNeuIFQ+HkSq0O9X2ohb/tugGYnCqdob2MP3DNTAOTrf9/M8bsNtotIqdBGjLe/
         X/Bgs+0YVpJxg==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id h1-v6so4840990uao.8;
        Thu, 16 Aug 2018 18:54:30 -0700 (PDT)
X-Gm-Message-State: AOUpUlH81wQ/VH5eblp9lmRhHwf19++3vqFG9EU97Xnc0jHrAic0+5Ld
        psyLN2Z6Gk4aczFKpWNY5O0hUdLi5GHfSJPjTrI=
X-Google-Smtp-Source: AA+uWPz3kyuDY15PJYlrXFEzD6SowrLIacFtxiNtFKzxbHQLoCSkkGNmtvy/jR7scRxtnFEbkkQ6RNAZgo/2mIgN5P4=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr21349330uac.135.1534470869273;
 Thu, 16 Aug 2018 18:54:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 18:53:48
 -0700 (PDT)
In-Reply-To: <4f6673db-5b59-c3b1-042c-b36057c31c13@redhat.com>
References: <20180816170555.21623-1-msuchanek@suse.de> <4f6673db-5b59-c3b1-042c-b36057c31c13@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 17 Aug 2018 10:53:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASy_SEORuAE-mbS6MXCFhxGbzjahpYrWRkLS8zT7ax_Kg@mail.gmail.com>
Message-ID: <CAK7LNASy_SEORuAE-mbS6MXCFhxGbzjahpYrWRkLS8zT7ax_Kg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix LOADLIBES rename in Documentation/kbuild/makefiles.txt
To:     Laura Abbott <labbott@redhat.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-17 4:23 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> On 08/16/2018 10:05 AM, Michal Suchanek wrote:
>>
>> Fixes: 8377bd2b9ee1 ("kbuild: Rename HOST_LOADLIBES to
>>                 KBUILD_HOSTLDLIBS")
>>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>
>
> Acked-by: Laura Abbott <labbott@redhat.com>


Applied to linux-kbuild. Thanks!


>
>> ---
>>   Documentation/kbuild/makefiles.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/kbuild/makefiles.txt
>> b/Documentation/kbuild/makefiles.txt
>> index 766355b1d221..7b6a2b2bdc98 100644
>> --- a/Documentation/kbuild/makefiles.txt
>> +++ b/Documentation/kbuild/makefiles.txt
>> @@ -680,7 +680,7 @@ Both possibilities are described in the following.
>>         Example:
>>                 #scripts/kconfig/Makefile
>> -               HOSTLOADLIBES_qconf := -L$(QTDIR)/lib
>> +               HOSTLDLIBS_qconf := -L$(QTDIR)/lib
>>         When linking qconf, it will be passed the extra option
>>         "-L$(QTDIR)/lib".
>>
>



-- 
Best Regards
Masahiro Yamada
