Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB17DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE56208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uHvQAjjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE56208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJFFKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:10:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeJFFKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:10:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so10510201wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvPfx0aEmiY+IQxRq8EXo/Che3Aud79iC/Wa0J7xcRM=;
        b=uHvQAjjCYMcooY7TYnF8LKqybiV2kfSlNGB7Kzh1ItpmHQnlsDnCzt39pdIFnc1uj7
         KGU8D9m/eYtxdfn/LjW0550KknH8qrFoLwxcGJ/PUB94u/9jIlEmvuig4+Caw2FDwR8A
         msVidIiXxP7SewRDf0gADvl6fEROYIMaKIFwu8vgA6ihn0vQPE9eTaVySqNYoKT45UV7
         HY1CFqVdolMHPlY8yi0Fb3HlO7zsyDLnnN+5PciyRnSkjDOzCGefBoYbd4ZO8+stNBNn
         QcoQKnHMy+Ca7VE/9uA8NRgdbxobFETMtKYADKPwxNH4yXKDmtVq0L55C1k0WmuNz5vh
         9p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvPfx0aEmiY+IQxRq8EXo/Che3Aud79iC/Wa0J7xcRM=;
        b=YB3KH9PyOsBz4m9Oj3WfPJTw83rpR9lKFjHUGhHclLtmffB3rxPoal1oBGquvGB8gh
         KVYJrOnRhs2cLWG7Gzb492CmZHWbyoFKjM00N/pfw0Yi4m7I0XAnxyK7sR8vNUsLHU5Y
         0hp9ZRNBIYld9C1daS4Xymri8q/SRkpAu3sfsM4t+IvLvtbauxn26yTrGy/FA0p9Ctol
         2tBSH8DTYtoTX888CPngePuHR8dJPgTGyRmXyyVw1ih7AasrNyNKQrAcqcTQb9YPJ4oY
         ogHw22yNr0QWIiYZjH5+wwFYTxffxCrmz9nJZrLcv1Ytc6TO0Dkrec5tFkd8BaqJZAvN
         LyjA==
X-Gm-Message-State: ABuFfogMav3g62Vmke1FTx4gtuKW8n5VbB0Ivaah626XrPFjckM1EXUS
        pxvzyv3UbpGDD06UpAJxbcyhbeCh8rFAhMwcH24z8Q==
X-Google-Smtp-Source: ACcGV60e/iboR58P/LprS6j3L0ynzON6PFHfjebUqfDiV1t7qMvCN4+OuT5pVtbFcSJDqEmrFEfs9QHDKdc/YZ7Ysl8=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr9583415wra.95.1538777372157;
 Fri, 05 Oct 2018 15:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181004025750.498303-1-ast@kernel.org> <20181004025750.498303-2-ast@kernel.org>
 <20181005044659.GU32577@ZenIV.linux.org.uk> <20181005220518.747ri4q34obrnaoc@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20181005220518.747ri4q34obrnaoc@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 5 Oct 2018 15:09:20 -0700
Message-ID: <CALCETrVURVaqJChL=RwZPe74+JfX-6Zzp9kLR9-mLiownSOexQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 3:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 05, 2018 at 05:46:59AM +0100, Al Viro wrote:
>
> > Another problem is your direct poking in ->i_ino.  It's not
> > something directly exposed to userland at the moment and it should
> > not become such.
>
> The patch is not making i_ino directly exposed.
> Only 'struct bpf_file_info' is exposed to user space / bpf programs.

I think Al is saying that the valie of i_ino is not something that
user code is permitted to know regardless of how you format it because
it may or may not actually match the value returned by stat().
Another way of saying that is that your patch is digging into an
internal data structure and is doing it wrong.

--Andy
