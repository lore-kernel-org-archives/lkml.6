Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3EBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2456B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz1AAtTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2456B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeIGKAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:00:31 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:32819 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIGKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:00:30 -0400
Received: by mail-qt0-f172.google.com with SMTP id r37-v6so15065759qtc.0;
        Thu, 06 Sep 2018 22:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7q29B1CjI2KiKs0fvTpfEQyuz4g6P+UF7eVoKM4vzr8=;
        b=Pz1AAtTYbZn+07FvHpgXnA4GHLJgxtHJpbRBtdr+IbRArLtpsBGNVTPpq/A6WPmvPR
         roH67dF9maxm/IltpqbWZYMVjz6+wzEz5BzGbd/U/P8a2cXoTji3lY1M/DlUAHtJ9p/K
         GfaVO/wiHGNIARukzvawnW8v4DyOu2ZoMRypADBiTLelh/EkMMNIF/Ypfd3ewVzLLlPR
         +Q2UMMADClKiaBZtXe5Doh276pY82zUPIkNcrCahwANBKFjiUV6Sz0EczyevP6KGzhhL
         dilfyg4jiYWzXGeJPaGzw5P5q0JV8WnXWbhfg8fy2PMH812VtAUW+yvsqLDGk2fB2IWX
         81Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7q29B1CjI2KiKs0fvTpfEQyuz4g6P+UF7eVoKM4vzr8=;
        b=ZECQMMIL37fO7iF1ltHpCE16QhCCHT8Q1NMLIfhHdF58DhlfRNFeKUPNo7558eH9IC
         PmREElEp3ArDgq5hCB0vTY+OnVViqF11iB4c4v1TSps5HWkAEIsImBeXTRmJ7MIMs6Vg
         ayLxd+PsBuS82oZuda0sCSL++ju5eb26K/5VbOM493Aw3o2pDn2Q0x2uAm/+26ZGKb+B
         QwDXKMnJsqjxYnweiPGr5Eri99TVIH/WPRpU0ndT0Asqp9thQ/7k2Pw59w99bwK2VIwK
         14FD7EX5Bx8sSLK8JQbwUdSfAu7CPhr3xkgUSnYkQFGDfSQ9dG4ebCYwe4GGL9aCxggG
         EtRg==
X-Gm-Message-State: APzg51CStyXGDYkZrw57Men6UYQj5/4QrzQl1kjPfTV037qkZkjr8xvb
        GRUBxuap7AYIu4YwRb8ZbwSFvTF9kf0Iiy0UKaM=
X-Google-Smtp-Source: ANB0VdbmxsLoLoOQ1xYrS9/qFyay0pMg8cvIqU2X/1orHzIlaHChNS788PPwIkQTs7ABo5k9C5ym10qQZDxb9VU2xzU=
X-Received: by 2002:a0c:f208:: with SMTP id h8-v6mr4590426qvk.55.1536297677311;
 Thu, 06 Sep 2018 22:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180907101923.4d2a85c6@canb.auug.org.au> <20180907002223.tpizglyhrwn26oox@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20180907002223.tpizglyhrwn26oox@ast-mbp.dhcp.thefacebook.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Fri, 7 Sep 2018 07:21:05 +0200
Message-ID: <CAJ+HfNgRd5ztzwJ9HtgnrDyf8F0ykODY_EGC91d9KiAfDbhcXA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     sfr@canb.auug.org.au, Daniel Borkmann <daniel@iogearbox.net>,
        ast@kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den fre 7 sep. 2018 kl 02:23 skrev Alexei Starovoitov
<alexei.starovoitov@gmail.com>:
>
> On Fri, Sep 07, 2018 at 10:19:23AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the bpf-next tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > ERROR: ".xsk_reuseq_swap" [drivers/net/ethernet/intel/i40e/i40e.ko] und=
efined!
> > ERROR: ".xsk_reuseq_free" [drivers/net/ethernet/intel/i40e/i40e.ko] und=
efined!
> > ERROR: ".xsk_reuseq_prepare" [drivers/net/ethernet/intel/i40e/i40e.ko] =
undefined
> >
> > Caused by commit
> >
> >   9654bd10da60 ("i40e: clean zero-copy XDP Rx ring on shutdown/reset")
> >
> > CONFIG_XDP_SOCKETS is not set for this build.
> >
> > I have used the version of the bfp-next tree from next-20180906 for tod=
ay.
>
> merge conflict and build error...
> Bjorn, I'm thinking to toss the patches out of bpf-next and reapply
> cleaned up version of the patches...
> what do you think?
>

Yes, do that. I'll get back with a cleaned up v2.


Thanks,
Bj=C3=B6rn
