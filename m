Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BF6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCDA20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ocallahan-org.20150623.gappssmtp.com header.i=@ocallahan-org.20150623.gappssmtp.com header.b="c/WGDa2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389373AbfAOThD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:37:03 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34709 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbfAOThD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:37:03 -0500
Received: by mail-lj1-f180.google.com with SMTP id u89-v6so3401991lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Ii7YU/jXaruO/Mt/Yy7vVi3JkjrzxrH2AytJsE7c0ZY=;
        b=c/WGDa2VD8B4Fo33hDJTXnG3E+NSwq5uHtYhcNHdz37dW6Pgu79jk9vgZNAu+GATJT
         +gBrLP2f2j/4euHCBdLnsgz0RtLuoFkwWkuZgP3XuKOEIscq0/u/lX9oiSf3hQQ/Wv8E
         5ekoNp+fXdMcJAOaBCqTJv5uT7y8hJ0UttheCYc/YfSswrcH1PchgaXSKsR06l9nKZEw
         Bx88Syyghh1O6b6X0isuM0Cbwdbs+oxor5a05nBMCX9xCsWepdiTGlq4KowBnaDR0CG/
         iLUH4/GmkcGzxWbBcmpqay+igG6SPmrXbsYtPEg/fXpT65yytE/FZBj9n5MAgjfYQqLn
         wVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Ii7YU/jXaruO/Mt/Yy7vVi3JkjrzxrH2AytJsE7c0ZY=;
        b=GpmyMjR9l7NCt4QjThJEbQNhbJh+H6b6955AVtPsSnas+XnjEUB+X8D7I2grkTQegc
         Wb/Tg1ndVm2o2onBDf9l/KMtIaMDvQc4zyrJ6ZX+qOx+3mKpIREuFJLFnbtPwRQvO42g
         ENfg1sEZofoVWxN5ERTnifMSC5qUUioTIFNbSZU1J3CmzfJ1ZbLvdYdgogw1XgOAXqvf
         Y1UureREil7Sb4paIE4bz0IiX8IJORirkePk6YpiS0Y+aH7ckSSFEMo1wSAPxpLBrYls
         CgIZxyEKJghFAwuM5l67l8NFIqNfkOwNeVuRqX89bKEsn6ELma/UlK8Ljh0XNuMzGQWV
         OZ4w==
X-Gm-Message-State: AJcUukdQTKQpddXBxihdJqVb8vTlomcDt9v/xFMipiZTHw2TsPC5B0a5
        G77HRSDvHb3atlyP+1rCOMf3QpyljTJXhrJI8HQ=
X-Google-Smtp-Source: ALg8bN4NtTR8kbl1VCHmVMSEqnEhwWJzC8q5W3dfxAusab3IhLgqMca3ea10GWwiLSiIOPGD6/NDMjkFOgstlWrZAEA=
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr3896579lji.112.1547581020955;
 Tue, 15 Jan 2019 11:37:00 -0800 (PST)
MIME-Version: 1.0
References: <CAOp6jLa8rRw2ZQN9yWYZv_USrZw98D+U2rnk9V7M2EVY7O=VpQ@mail.gmail.com>
 <87won67580.fsf@xmission.com>
In-Reply-To: <87won67580.fsf@xmission.com>
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Wed, 16 Jan 2019 08:36:49 +1300
Message-ID: <CAOp6jLaGei=ALRuRaQxtD2VK_vY_ViAupgcmdouuzgwUCjC0BQ@mail.gmail.com>
Subject: Re: Regression in 32-bit-compat TIOCGPTPEER ioctl due to 311fc65c9fb9c966bca8e6f3ff8132ce57344ab9
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 8:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Can you confirm this fixes it for you?

Sorry --- I made a mistake. It looks like this is already fixed on
master, by commit e21120383f2dce32312f63ffca145ff8a87d41f5 (though I
don't think Al Viro knew he was fixing this bug). So, nothing to do
here.

Thanks,
Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
