Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADF12C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D198208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpXQX7a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D198208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936000AbeFNAlG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 20:41:06 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44027 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935557AbeFNAlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 20:41:04 -0400
Received: by mail-pl0-f54.google.com with SMTP id c41-v6so2474107plj.10;
        Wed, 13 Jun 2018 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QWgZ6Oa4oX8huUwVd5Z8BFTS2XqecKfcfMSzJfbxiaM=;
        b=OpXQX7a2ia4I+pZK9j/Hbp1tyIAKNIEakjYBi8cDxzBuZMneChkqyTHIDAK9E5oZ+u
         pX2gh5RQWR4502sSWgoSvnTCBBuWWfMLoNAG49E2RuTL1wKYSieKukHJ87RQ5s2t301M
         MlvRa1yg774ZQwUy0tVVKMcyu/Rfu8s7KWuyygd3xZAIZpfLS8nQY9ikfcf0mMGmz/Ea
         sotZDa41gLigzX5VuUG6sPE5fWvBt4YPwg5YU5ACHa+TQgbCKnWa2PNqSaZtMTS+T3ad
         pS6vI0fbQJ63ovaoZ6D6/mfSRyr1H5H/66xtJQIxh7eiquEnN85wlwj3Ym2rUBI+ZQLU
         auzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QWgZ6Oa4oX8huUwVd5Z8BFTS2XqecKfcfMSzJfbxiaM=;
        b=lUDP02AnGh+hULHVRKJmnWI32PzaGWdGIr0+uY3KGPFtDHiflYcXeeSsuNkS9qy6ir
         YonoBvXbxDf1jAkmHc3RVaMNgrI38zeDHJ/1OeetVjlpw2Ecpl3zWqY0FtK9PlEKEKpv
         16AjcgI1B0Tnld3BrJKdoKehHVTzFSu+sJLUTUaKVyrhr/03EqV+pWSzQBgbhxoOTUfa
         8jGyTO3cKiKJp99jOdPeWbqOkyGEd7oiqJcqkKFq3k/ahh8DHbAbWNGHXD4VEFVs5Xy9
         7awxGRev40E5oNxvxWl2HT0BNU7wDf56NkZTOlIqFBRs1/uhWCF/ENQ+d3HZK32EQ5or
         e7zw==
X-Gm-Message-State: APt69E0+iGtmrrg1rl9TTqYbU2IoPZSapgfFE8pmBT2cDTa4lju/URlm
        I5rhPsqSbPi4lxodfu5wkb7s0/NOibAsuhYNOB0=
X-Google-Smtp-Source: ADUXVKJRpZ2lyWRN5TjWleNXGISeGzdvCyJApGsEXVlrPpzunLB6dgjyE6ta2Vb8PjWA+qPeVsnubmJ7DXyR8eS+84A=
X-Received: by 2002:a17:902:7009:: with SMTP id y9-v6mr420825plk.217.1528936863624;
 Wed, 13 Jun 2018 17:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:80cc:0:0:0:0 with HTTP; Wed, 13 Jun 2018 17:40:43
 -0700 (PDT)
In-Reply-To: <20180614090135.1d71babb@canb.auug.org.au>
References: <20180614090135.1d71babb@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 13 Jun 2018 19:40:43 -0500
Message-ID: <CAH2r5msZ1Zi-MEqCE2eF-7Y50r=Kh4BUVYc6dwORC0iByJ+tBQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the cifs tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Aurelien Aptel <aaptel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ronnie,

I fixed up that patch and repushed to cifs-2.6.git for-next.  Seems
trivial. Let me know if any issues.

On Wed, Jun 13, 2018 at 6:01 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the cifs tree got a conflict in:
>
>   fs/cifs/transport.c
>
> between commit:
>
>   6da2ec56059c ("treewide: kmalloc() -> kmalloc_array()")
>
> from Linus' tree and commit:
>
>   1560d69e21c6 ("cifs: push rfc1002 generation down the stack")
>
> from the cifs tree.
>
> I fixed it up (the latter removed the code modified by the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
