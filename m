Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE3C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4CA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="VMD9SF/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4CA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeJXUE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:04:58 -0400
Received: from mta-p2.oit.umn.edu ([134.84.196.202]:39196 "EHLO
        mta-p2.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeJXUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:04:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p2.oit.umn.edu (Postfix) with ESMTP id 9E7D05EF;
        Wed, 24 Oct 2018 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540381030; x=1542195431; bh=z9XQ4VzQJc
        Kps+aHG/lxTfnSLjuJ7rmPgK6CLxLMwTk=; b=VMD9SF/Zu9b9ZB54yNZQzfG4kf
        /DTdEEvhOwpRHwgQSFWw7XKciVrqii1GCfNwNtOXM3qVd1lHNg30/jpeSgSVMf+f
        /Wg0w6+ojo7fr7o3vww9uwu27moVBhkrZAGvdd7Z0OUh1FGkcGch/qhQCFVJqtFw
        WGCM8RzKPY2r3VI0KXgBfWw02cNo5AUKbhPpAruTbaBaPmUUU5iMaaainzKPDt7m
        V1Bg3Zq2yn9GAkkZaEX6vdOJJYa6wAb/bHvBmg16yn62cL4QQ2VYQMrWZot0DCS9
        q0svX1luAh/R1cM6ZKhL9OdcKhQfDc+W+7h5k6pBf681wQG72/TVNSZh49ZQ==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p2.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p2.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ARbr8hRRwtQH; Wed, 24 Oct 2018 06:37:10 -0500 (CDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p2.oit.umn.edu (Postfix) with ESMTPSA id 512A5523;
        Wed, 24 Oct 2018 06:37:10 -0500 (CDT)
Received: by mail-io1-f41.google.com with SMTP id l25-v6so2934189ioj.0;
        Wed, 24 Oct 2018 04:37:10 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLHoeTLBolwYoV+kQr25aAfgmyz7EKqAZwaPxZssET5GFb5XyAg
        n+Irbq2zUqRcy9aQA1kdIFr0uDFD40JjyQVPjUQ=
X-Google-Smtp-Source: AJdET5c2s6BQRRxtp0U3MLgYpWFWUIJcPJ/OGgJG655A4pOz6MCgKBrRlES8EO3gkq1CNk29kDzFRZixfOfL5pMlnMo=
X-Received: by 2002:a6b:7e07:: with SMTP id i7-v6mr3388740iom.16.1540381029995;
 Wed, 24 Oct 2018 04:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <1539988191-13973-1-git-send-email-wang6495@umn.edu>
 <CAH3MdRV2qLj_3KHFYmCKYHMx2wZk_4mQrdvRJe+znXr3Astm8g@mail.gmail.com> <ff23c4af-9e31-8a79-9c37-95766bff7619@iogearbox.net>
In-Reply-To: <ff23c4af-9e31-8a79-9c37-95766bff7619@iogearbox.net>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Wed, 24 Oct 2018 06:36:33 -0500
X-Gmail-Original-Message-ID: <CAAa=b7cwRdF+D9DZCeUkt6jvZs0yFeERoP3uDLdxQOeqmMkKJQ@mail.gmail.com>
Message-ID: <CAAa=b7cwRdF+D9DZCeUkt6jvZs0yFeERoP3uDLdxQOeqmMkKJQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: Fix a missing-check bug
To:     daniel@iogearbox.net
Cc:     ys114321@gmail.com, Kangjie Lu <kjlu@umn.edu>, ast@kernel.org,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 4:39 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Hi Wenwen,
>
> On 10/22/2018 05:57 PM, Y Song wrote:
> > On Fri, Oct 19, 2018 at 3:30 PM Wenwen Wang <wang6495@umn.edu> wrote:
> >>
> >> In btf_parse(), the header of the user-space btf data 'btf_data' is firstly
> >> parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the header
> >> is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
> >> verified. If no error happens during the verification process, the whole
> >> data of 'btf_data', including the header, is then copied to 'data' in
> >> btf_parse(). It is obvious that the header is copied twice here. More
> >> importantly, no check is enforced after the second copy to make sure the
> >> headers obtained in these two copies are same. Given that 'btf_data'
> >> resides in the user space, a malicious user can race to modify the header
> >> between these two copies. By doing so, the user can inject inconsistent
> >> data, which can cause undefined behavior of the kernel and introduce
> >> potential security risk.
> >>
> >> To avoid the above issue, this patch rewrites the header after the second
> >> copy, using 'btf->hdr', which is obtained in the first copy.
> >>
> >> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> >> ---
> >>  kernel/bpf/btf.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >> index 138f030..2a85f91 100644
> >> --- a/kernel/bpf/btf.c
> >> +++ b/kernel/bpf/btf.c
> >> @@ -2202,6 +2202,9 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
> >>                 goto errout;
> >>         }
> >>
> >> +       memcpy(data, &btf->hdr,
> >> +               min_t(u32, btf->hdr.hdr_len, sizeof(btf->hdr)));
> >
> > Could you restructure the code to memcpy the header followed by copying
> > the rest of btf_data with copy_from_user? This way, each byte is only
> > copied once.
> > Could you add some comments right before memcpy so later people will know
> > why we implement this way?
>
> Thanks for the fix! Agree with Yonghong that we should rework this a bit, so
> please respin a v2 with the feedback addressed, thanks.

Hi Yonghong and Daniel,

Thanks for your suggestions! No problem, I will work on the v2 and
resubmit the patch.

Wenwen
