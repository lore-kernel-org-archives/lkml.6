Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13821C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77D120859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="r9JNr9OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfAQVyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:54:21 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39964 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfAQVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:54:20 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so3243941ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgm2BrNo/qVMVeS2aITwps2BcZclDrBihugIrwrVeQE=;
        b=r9JNr9ODvQ2/EZbzAoiBQ4r/31zo/eLgJEz/ov5ktMq8uAfBW/5rFRW1aaZQsCXFgD
         wM/McYgz9UT+O3o7UFkE0SpUwt+h9zeckyXxwdFe1jkJFnponOMI24Z+Xc53qeu2wHsS
         gDJhTXU8JGSdJzMPquurHJma6ifOLQ1oQphFuPKhEZutwoxYgPIYs4giBlI114f+ZqNe
         Ar3i0wa/C32kOcEXOFjvKc41bWoICgmvBe6/aJ9Yr1tkl7AwA+SxJISfPHQaBFpfVKhp
         c0q5f8ae0lDZ/HhTm++cmHcMsh9MvF7oCJeamrDC0bgL4KWExKdZ988mCLe+p5CiTx2B
         P8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgm2BrNo/qVMVeS2aITwps2BcZclDrBihugIrwrVeQE=;
        b=UeqUNzwf1T1E58WQgtXGCoKrNvV39pGRiZIdIR9P41Noz4npvamnXeTK0G7z7qHyMo
         9MW/NMlVULsw73fPr/FhhvHUw1OzrHZKD6NFXfTJ8JA4H5U6YrV7MZpv5+YHfXrK2vkH
         nHdni8ivnZi6x1Ruuf5ubwcqS8RDldYyCJ/DWgd950If3CmHfWki2lKDgV7oV8YaKTtz
         HFXaY973ynq0/iDq2kNqRog6+kDclp6wIGvNUsFhiANGJNfCL1AdOc43z+HIuPiUvAxM
         1QybD8laebu5jU+iC/IB+QD/eZeEu7HZqyDkUh41iANlMzODSejOocfOmrwCV/Cv5Zsc
         I6Tw==
X-Gm-Message-State: AJcUukezvM4rDJSQciJ9IHbbGrQr6DucvI4vmaPJbXTS/yo8uWl5kp4C
        OnCY1XbZ3WIOOuJfmxDDe00VoIrO1PUNqYx4DMg=
X-Google-Smtp-Source: ALg8bN6GTSk7UtF48InDlv2aRstXy/nPXOTCnbM+mrv4Lm+pRRl3mFiXiM9TCs6Rq9Ycst/4gGJFv5TG94yUs1HCa1M=
X-Received: by 2002:a02:152:: with SMTP id c79mr9315073jad.138.1547762060003;
 Thu, 17 Jan 2019 13:54:20 -0800 (PST)
MIME-Version: 1.0
References: <87h8o0ocul.fsf@gmail.com> <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
 <877eovobxl.fsf@gmail.com> <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com>
 <87wowumj21.fsf@gmail.com> <CAKgT0Udtw2ZffwmPf16efcKPKz=C0BVZaJ_DofnyF6LxbH_nPw@mail.gmail.com>
 <87603lbelc.fsf@gmail.com>
In-Reply-To: <87603lbelc.fsf@gmail.com>
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Thu, 17 Jan 2019 13:55:07 -0800
Message-ID: <CAL3LdT5DV1faoFsX6CH4LRSQa9rn-Eg71sRu64=bs3w7WCGg4g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [BUG] igb: reconnecting of cable not always detected
To:     Holger Schurig <holgerschurig@gmail.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:36 AM Holger Schurig <holgerschurig@gmail.com> wrote:
>
> Alexander Duyck <alexander.duyck@gmail.com> writes:
> > Thanks for the data. It is actually useful. There are a few things
> > that I see that seem to point to an obvious issue.
>
> Any news on this?
>
> A collegue of mine states (I have not checked this) that a kernel
> 4.9.0-6-686 from a Debian Live ISO (debian-live-9.4.0-i386-kde.iso)
> didn't show this behavior, so we have some kind of regression perhaps?

Our validation team was only able to reproduce this once, but is not
able to reproduce the issue again or even consistently to be able to
adequate debug the issue.

Are you still seeing the issue with the latest upstream kernel from
either David Miller's net-next tree or Linus's tree?

-- 
Cheers,
Jeff
