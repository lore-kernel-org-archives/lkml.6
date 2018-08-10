Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD988C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7027D223E9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b73anoaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7027D223E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeHJK6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:58:05 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45720 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeHJK6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:58:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so14448939oic.12;
        Fri, 10 Aug 2018 01:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qhfzfyiSFxtUHvRLdHQJUeQxcaonyKKvrjCdkzXY9bM=;
        b=b73anoawBLYOgqQAG9HeANyOxs37vldprumRL1Q/8zrmk3U2kua0drvhOqM6OqFfa7
         vwKOKkaSHETqEYc4XDWxnNy6intBmL5/LzBJTGF4DrrtlqKc7DoNnAkB7lkbj+VmLzvZ
         XLOWXctUUpLL45lk3QcDkO2cPOcpAEQfNKXmkk9Ik4A3yrwB6upSMyvvp2xgTImXH4di
         ubea66CfNA/8fyBi3ZioyJUucnxqPf8kEiedOagLPhJrWZWC4jdosACzq7vsHge2YpSP
         ddVhcE1X7UB/QC8UL2+7Mc/gt9lN6rUPZH+R+KLlAak0CYZKi2LEL/gg1jy5fUfkASrx
         uYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qhfzfyiSFxtUHvRLdHQJUeQxcaonyKKvrjCdkzXY9bM=;
        b=hA/I5GevEJshyGFFzfy0EQLBHDawtC6cV1YQCtudYnaqyHEm9kpi+RoIBMqOkVrDTp
         Z5t4n2l0OokE40XT88ylQjppJzXVxmIBlBNtWjK4UKimI7DD+Em5ZP+STdYcKpylsNtb
         fPZQCvhgcJn/pZMUeOvh07iIcoy8oTSsE4nL66Y+uROxqjWIMaZLUWs0fqcMwjpVVPGx
         FTrNfgWOct+I9EJCdD6ZE/gRYfAm5uKxTj2JQuqN0puPDSdAFS63SvAInEvTzEyJYkiN
         +nV7coyF8o1trZN8EA6qo/MPmRhkiWvSRfqtjFrFsGzNRM8AUIs9WxQiVnPcx9oYTCiB
         G9ow==
X-Gm-Message-State: AOUpUlEB8rAsvU4EUp6ye9Ydi5yKiVmVmbH/WCqBAb43eU/X4Cq01w6R
        F5WYqbq2PoIpRFhgjByRdcBiW13Tie+ZwWEUCss=
X-Google-Smtp-Source: AA+uWPx5Oc1fGfhx5nEPWgvRk4ESi2Cq3SYHR5tGlprrqMfng8F7XLHoRsDdsjXOCJkhVaSupYhTl/JDm371n5PYJKc=
X-Received: by 2002:aca:dec6:: with SMTP id v189-v6mr5928565oig.98.1533889753685;
 Fri, 10 Aug 2018 01:29:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:734:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 01:28:53 -0700 (PDT)
In-Reply-To: <CAADWXX-bXeVdWPrn3BeA=wF3d4rn1S69BYhf398_=T=NF2t44A@mail.gmail.com>
References: <20180809181103.15437-1-matwey@sai.msu.ru> <CAADWXX-bXeVdWPrn3BeA=wF3d4rn1S69BYhf398_=T=NF2t44A@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Fri, 10 Aug 2018 11:28:53 +0300
Message-ID: <CAJs94EamyYZQo+AYZtBGYP4qk-82QqOQa-qW7UiRCFqmmBzGsA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for pointing it out, I'll try to do my best to avoid this in future.

As I see now, in my case, the 'sender' in DKIM is triggered when using
GMail with alien domain in "Send From:".
I would not say that it is configuration "bug" (at least I can imagine
why do they do that), but it definitely must be avoided for maillists.
It is also interesting that if I use alien "From" email address with
google-apps (g suite) domain, then GMail generated two DKIM-Signature
headers, both for gmail.com and for the google-apps domain.


2018-08-09 22:31 GMT+03:00 Linus Torvalds <torvalds@linux-foundation.org>:
> Matwey,
>  your DKIM signature is garbage, and it causes your emails to be
> marked as spam when they go through a mailing list.
>
> The reason is this:
>
>   DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>         d=gmail.com; s=20161025;
>         h=sender:from:to:cc:subject:date:message-id;
>
> where the problem is that the "sender" field is included in the DKIM
> hash calculation.
>
> That is completely incorrect, since a mailing list will - by
> definition - change the sender to the list, not the original sender.
>
> This is not a mailing list bug. This is a bug in your DKIM setup on
> the sending side.
>
> I'm leaving everybody cc'd., because this problem is starting to be
> annoyingly common. We had two people with chromium.org addresses with
> the same misconfiguration, and I want people to be aware of this.
>
> I get too much email, and too much spam, and so when people have
> misc-onfigured email sending that causes problems for spam systems, it
> needs to get fixed.
>
> Your situation *may* be the same as the Chromium guys. Quoting Doug:
>
>  "Looks like it's all fixed.  Both Kees and I setup our chromium.org
>   accounts a long time ago.  IIRC during that time the suggested way to
>   do things was that you'd use your @google.com SMTP settings even when
>   you were sending as your @chroumium.org account.  These days it
>   doesn't appear that there's even any UI in gmail to configure things
>   that way, so presumably nobody else will be stuck in the same hole
>   that Kees and I were in"
>
> and he may have been wrong about that "presumably nobody else will be
> stuck in the same hole" guess.
>
> So you might want to check what the SMTP settings are for your setup.
>
>                Linus

-- 
With best regards,
Matwey V. Kornilov
