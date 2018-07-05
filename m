Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9E0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF402411D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwk8jS0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF402411D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeGEFuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:50:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38711 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeGEFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:50:38 -0400
Received: by mail-yw0-f195.google.com with SMTP id r3-v6so2566047ywc.5;
        Wed, 04 Jul 2018 22:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AATu/7Sofmj/hXBqaUdrctu0kIXjWLscqve/jLO7UZ8=;
        b=hwk8jS0or3kwoqn/tMwf3UKoFxqtXq4dleUFMqcZYjgmEEUKm8U9PIfjOyN3mOAM8w
         sR6wRKEygeFTRuj+p5lxAH9EtsgaOb/gFAjEc7ratkEQO/cBjaKmJ0sdWz8zmDz2vUKl
         +S+E/pkG7/jxLQe4/EWj6M8FlTisTlN07fb3YBDDOUc2zzim92KTOAR/5OnV/IG5Fbsm
         yuZasb2Ry5Ao0FvWtAx/r0+75Jf+39LkeQN/i51YR1f1Dsurj/y7SEynRX+PbwAezqPm
         sRtB4cwkkAqtK/sSSUtywC1eGOpxL0uGKqiy/OQIKMda+4TP81S9PvYq4xNJQJkL5f3U
         onqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AATu/7Sofmj/hXBqaUdrctu0kIXjWLscqve/jLO7UZ8=;
        b=N20nU7W8U7WXguOtH88X68gu3XHaAEVfEuO+tlZ/N/iS9oNkxi4joojlqOUEhKT5yn
         CLNMSvpF+FBxmBN7BSSWS7m/IUqHo+I8N4Gb3v2Tve03B72xaH+S1bR9cWFuUgdP+Qkq
         sdDO1aKpSUaiwpJJcNzb1XJz4xNTCEQtj2mVWQQPeovGD4vWLHufEOBb0sRBfqludcaa
         wqkMasvYFgfU/TWGGQ4ssxlqA12Nf2Fy0Ol+eFW5pAl3PLRlelHTYShc1fQA4E9oUPxE
         IUt+Z0N9U7j40nF/D37RloldGb5cgk3M5N3ZIRDzR/X1zxo0WbIvKkdOQQW/4/zQbAPN
         UdGA==
X-Gm-Message-State: APt69E3q0qBorvRCEV+NB+9hHN8epGxhuY7IR/h3w76ZnPoaZC8XY/Qf
        H+gRk84nF0sipYVe94gDyHJTDrhmaMVoFQPWtaA=
X-Google-Smtp-Source: AAOMgpdbzfAMIBGJLySVwpqKONYyUn/+FOnhU7ectRDiV9WYEI60bYl07DqbI2zjF+Lk4bzUVEYCx55yDg4NtAD56ag=
X-Received: by 2002:a81:a87:: with SMTP id 129-v6mr2135157ywk.379.1530769838018;
 Wed, 04 Jul 2018 22:50:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:7dc5:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 22:50:37 -0700 (PDT)
In-Reply-To: <CA+55aFxaBZ+9RQcNbeJZPAUeutJhVe5QLsRYEzTeOX_8vROAFQ@mail.gmail.com>
References: <CAOQ4uxgRXzq+ZSmwRB_nyGijFJsiuWXaM_F74W-3JOyTvAEz-Q@mail.gmail.com>
 <CA+55aFy-tgKkq_oiQaZge3URgZL0ruvoJ6pUCf=H+aschPdqAw@mail.gmail.com>
 <20180704233415.GA30522@ZenIV.linux.org.uk> <CA+55aFxaBZ+9RQcNbeJZPAUeutJhVe5QLsRYEzTeOX_8vROAFQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 Jul 2018 08:50:37 +0300
Message-ID: <CAOQ4uxh6E_sQY0zQM=VLO_Xk7ddG04tqUUpRQX=KRLzMxUxWEg@mail.gmail.com>
Subject: Re: [lkp-robot] [fs] 5c6de586e8: vm-scalability.throughput +12.4%
 improvement (from reorganizing struct inode?)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        kernel test robot <xiaolong.ye@intel.com>, LKP <lkp@01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 4:37 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jul 4, 2018 at 4:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> I don't hate that patch, but there are immediate followup questions - e.g.
>> how sensitive is relative position of i_lock/i_hash/i_sb?  Those are *not*
>> close to each other.  E.g. what happens if one moves i_hash right after
>> i_ino?
>
> I think that's a separate issue from just packing things better.
>
> The original patch is at
>
>     https://marc.info/?l=linux-fsdevel&m=152880180732361&w=2
>
> although I certainly agree with the "just re-send as a proper patch,
> now with a note on potential performance improvements".
>

Will do. But first, let me CC this discussion to some public lists,
so I have somewhere to refer to in commit message...

Thanks,
Amir.
