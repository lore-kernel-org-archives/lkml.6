Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848B020873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMIPCJdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848B020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934385AbeGJP63 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:58:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34350 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933846AbeGJP62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:58:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so7801914plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RWhd2skemWnD9Td0IKlpOvYZSKBB0Oe9ZHh3dn4k588=;
        b=qMIPCJdR4nc/tk58jQPxTv09MPydEwoU7dETiJkJLf5N3xwlc2uMubgKbB8H/BodUJ
         hEGWoM8Bg7lNBQgcLFM6G+xc9UwhseCArMuvBsk7mhwyhbCNdx8nsEcgQzFG/yNECYN6
         9YvMZtCQXQLqlQiuTP/ZjCpMrUAgNM13RWRwxzIFPSqCc1TTGfTl9BiLC1u/mtUzqCvG
         xFDQMfue+bCUtBMPUBOsON+P3ZsdhS+UIm0Joqo98/hKTlB+IwS08z+JSYOQlxpHulNe
         5FMe3C2WLMHeYkXG+5p0itjvZ4bsBnz3DPVyVrjtT3Kb8Jxz9GpAjHBR+YQDlr3CXTUy
         XhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWhd2skemWnD9Td0IKlpOvYZSKBB0Oe9ZHh3dn4k588=;
        b=g1HcG3lP22uyyFjmX2SxVQTjO0KsZ7hPp5yS1bOOf2IdvHWAIChTsAG33KzaPV1M5O
         CKzR0+8e6fMe556BCPEexE/o1TTW2cuRi5sfcRvLjOzmJyVV2NgVT4/jnVhuIYHMHxi9
         nuiPqvWEY0VhZn7TLawB4tFPyGaYdiIgBWqnejEE4tR+IaboII5yMceDhOEawKF1dubr
         Owj7oyDBgFHCWZohwKgJHQ8SACVKw7q7pGNFQ/GDteECMnmux8TS0Lvzy//9UPDTTNMb
         RSCfinN+NZrhcgMl1h4aSoY3n9IJ1T1ISJd02EIBkOW6V570sbnkklJ7MLVhWk11BeBT
         DC6Q==
X-Gm-Message-State: APt69E3VoHf/Eju9I6/TzJP8iuII0MQpEDWgKXKkvfVq3agqDDJCVV+H
        +foWlohq/5AQkENUq9jO4tU=
X-Google-Smtp-Source: AAOMgpfF4hE61mcTPu63jCtq60BT4ETvH7+2tBxvYS1A5LCUgxNaUj5mbSznKtBIH4pqupGMAbePlg==
X-Received: by 2002:a17:902:9681:: with SMTP id n1-v6mr25964723plp.244.1531238307453;
        Tue, 10 Jul 2018 08:58:27 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c185-v6sm14789768pfa.157.2018.07.10.08.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:58:26 -0700 (PDT)
Date:   Tue, 10 Jul 2018 08:58:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: Replace strncpy with memcpy
Message-ID: <20180710155825.GB10635@roeck-us.net>
References: <1530478626-15753-1-git-send-email-linux@roeck-us.net>
 <0250de00-adf7-7b43-5f7c-44704119e2f9@huawei.com>
 <367fb12b-3ae0-4a6a-b59e-31d3a360bf05@roeck-us.net>
 <ecb4f083-1d61-d882-c85c-53cb33fa793e@huawei.com>
 <CAD14+f0eRF9y-QNMXwXEymQGOZ_D22sbdqwAuXg5Cv=SXryApQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD14+f0eRF9y-QNMXwXEymQGOZ_D22sbdqwAuXg5Cv=SXryApQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:35:08PM +0900, Ju Hyung Park wrote:
> I must be missing something here.
> 
> Shouldn't the third argument be 'strlen(name) + 1', if we were to use
> memcpy()?
> strcpy()/strncpy() appends null terminator to the destination whereas
> memcpy() doesn't.
> 

strncpy() does not append a null character if the passed length is smaller
than or equal to the string length. strncpy(dest, "x", strlen("x")) copies
exactly one character. The code as written specifically does _not_ append
a terminator to the end of the copied string.

Guenter

> Thanks,
> 
> On Mon, Jul 2, 2018 at 11:57 AM, Chao Yu <yuchao0@huawei.com> wrote:
> 
> > On 2018/7/2 10:16, Guenter Roeck wrote:
> > > On 07/01/2018 06:53 PM, Chao Yu wrote:
> > >> On 2018/7/2 4:57, Guenter Roeck wrote:
> > >>> gcc 8.1.0 complains:
> > >>>
> > >>> fs/f2fs/namei.c: In function 'f2fs_update_extension_list':
> > >>> fs/f2fs/namei.c:257:3: warning:
> > >>>     'strncpy' output truncated before terminating nul copying
> > >>>     as many bytes from a string as its length
> > >>> fs/f2fs/namei.c:249:3: warning:
> > >>>     'strncpy' output truncated before terminating nul copying
> > >>>     as many bytes from a string as its length
> > >>>
> > >>> Using strncpy() is indeed less than perfect since the length of data to
> > >>> be copied has already been determined with strlen(). Replace strncpy()
> > >>> with memcpy() to address the warning and optimize the code a little.
> > >>>
> > >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >>> ---
> > >>>   fs/f2fs/namei.c | 4 ++--
> > >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > >>> index 231b7f3ea7d3..e75607544f7c 100644
> > >>> --- a/fs/f2fs/namei.c
> > >>> +++ b/fs/f2fs/namei.c
> > >>> @@ -246,7 +246,7 @@ int f2fs_update_extension_list(struct
> > f2fs_sb_info *sbi, const char *name,
> > >>>             return -EINVAL;
> > >>>
> > >>>     if (hot) {
> > >>> -           strncpy(extlist[count], name, strlen(name));
> > >>> +           memcpy(extlist[count], name, strlen(name));
> > >>
> > >> How about replacing with strcpy(extlist[count], name)? Because name
> > length has
> > >> already been checked before f2fs_update_extension_list, it should be
> > valid, and
> > >> will not cause overflow during copying.
> > >>
> > >
> > > Your call; feel free to submit an alternative. Since it is different
> > files, static
> > > analysis might not know and complain, though. You might want to make
> > sure that this
> > > doesn't happen, and also add a comment explaining the reason for using
> > strcpy().
> >
> > Yeah, that could be changed in another patch, but it will be trivial.
> > Anyway, to
> > fix this gcc complaint, this patch looks good to me, thanks for the patch.
> > :)
> >
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >
> > Thanks,
> >
> > >
> > > Thanks,
> > > Guenter
> > >
> > >
> >
> >
> > ------------------------------------------------------------
> > ------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
