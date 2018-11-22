Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1577C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2E920831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="R+qxkSn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2E920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439188AbeKWKfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:35:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33853 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389089AbeKWKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:35:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so8943343qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 15:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nPTGdUADIXtInbJXljs6ZE0po/cjok/A16n77ewkYBE=;
        b=R+qxkSn3n1EHXMWXflXIYShfYFStKFCpWtSoMK8afKhJHdD+yHeY+wiKn8Z+hGSCcm
         Kq1BL3mldOUWSXllMQ/zQxWaSIOGSL7WrE4DQsk7I/K0+5nrkEsA+PpTM3NVHFmVn2tn
         iE4bhygn+7xAmbT/4aRYqNRCLdWR36Mm1Ci5r4YWQqPgDA37pqMTaMQVUJ00FK6QRu1L
         YJa0kdCz4lfXLRkmQhqz1gRYIsZC4oV2nhHnrvFltToo0pVCvMU+EY2kK+h7OqbShgpT
         2av6RCWb3wJt+2an34Q5GPTg7VtHMMq+jzOAP9LUR5tADs7+7r/l0FgrtWTGeooClJEM
         Cyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nPTGdUADIXtInbJXljs6ZE0po/cjok/A16n77ewkYBE=;
        b=QSkx80fi4CCktm14XsGH0IeJFfgc7c5SeNghlJNGBIUUbECgVW2nWWgkBcYF1Cq14s
         chu3IOTaOs79L11hsHk6B1V9z9HZoGNhIic5XmlJEiN/jfhDxYnL+dJcqg0A66n9O7om
         tWspAaFt3KTGMuR5H09r4r8XT6E01H3VE8NIlHPKJ646jXkI2tuwvORFYDP0yu6mOeYc
         9ESikxWLiD9rJCNdVobArc9mamVBv12qINJ92mCtAD16DWBm6lPYzyfeMNvC9d53PFPA
         7gg431X1hKYrgNHV9G0ayqzx5+pcWJ3HPp4DxNAtMbu/t/purWrFAHC9pvldIGUxFHy7
         citg==
X-Gm-Message-State: AA+aEWb+SBbvHa432j2l43aJS4kNOBgVDb0O1SMODgCBhYaY/1zCAd79
        0+qpHg5Lw7TTnxhZwVuckbZ3sw==
X-Google-Smtp-Source: AFSGD/ViG39BlsWGGBaniw0oqHp9ECJmk8gRXwwPKZgttqguioe37wYPQGaEPJ0ySgNYsODcpUPlYw==
X-Received: by 2002:a0c:b02c:: with SMTP id k41mr11728052qvc.154.1542930821447;
        Thu, 22 Nov 2018 15:53:41 -0800 (PST)
Received: from skullcanyon (cable-192.222.193.21.electronicbox.net. [192.222.193.21])
        by smtp.gmail.com with ESMTPSA id e89sm25741521qtb.78.2018.11.22.15.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 15:53:40 -0800 (PST)
Message-ID: <cce537955998a62d4fa36e466940fb3b5a9f21cf.camel@ndufresne.ca>
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 22 Nov 2018 18:53:39 -0500
In-Reply-To: <CAPBb6MVzqqgUD5faN06=s-UNA9obxjiBQdMDNDK7m=m3=Utk3w@mail.gmail.com>
References: <20181113093048.236201-1-acourbot@chromium.org>
         <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
         <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com>
         <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
         <CAPBb6MVzqqgUD5faN06=s-UNA9obxjiBQdMDNDK7m=m3=Utk3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 22 novembre 2018 à 17:31 +0900, Alexandre Courbot a écrit :
> On Fri, Nov 16, 2018 at 1:49 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > Le mercredi 14 novembre 2018 à 13:12 +0900, Alexandre Courbot a écrit :
> > > On Wed, Nov 14, 2018 at 3:54 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > > > 
> > > > Le mar. 13 nov. 2018 04 h 30, Alexandre Courbot <acourbot@chromium.org> a écrit :
> > > > > The last buffer is often signaled by an empty buffer with the
> > > > > V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
> > > > > bytesused field set to the full size of the OPB, which leads
> > > > > user-space to believe that the buffer actually contains useful data. Fix
> > > > > this by passing the number of bytes reported used by the firmware.
> > > > 
> > > > That means the driver does not know on time which one is last. Why not just returned EPIPE to userspace on DQBUF and ovoid this useless roundtrip ?
> > > 
> > > Sorry, I don't understand what you mean. EPIPE is supposed to be
> > > returned after a buffer with V4L2_BUF_FLAG_LAST is made available for
> > > dequeue. This patch amends the code that prepares this LAST-flagged
> > > buffer. How could we avoid a roundtrip in this case?
> > 
> > Maybe it has changed, but when this was introduced, we found that some
> > firmware (Exynos MFC) could not know which one is last. Instead, it
> > gets an event saying there will be no more buffers.
> > 
> > Sending buffers with payload size to 0 just for the sake of setting the
> > V4L2_BUF_FLAG_LAST was considered a waste. Specially that after that,
> > every polls should return EPIPE. So in the end, we decided the it
> > should just unblock the userspace and return EPIPE.
> > 
> > If you look at the related GStreamer code, it completely ignores the
> > LAST flag. With fake buffer of size 0, userspace will endup dequeuing
> > and throwing away. This is not useful to the process of terminating the
> > decoding. To me, this LAST flag is not useful in this context.
> 
> Note that this patch does not interfere with DQBUF returning -EPIPE
> after the last buffer has been dequeued. It just fixes an invalid size
> that was returned for the last buffer.
> 
> Note also that if I understand the doc properly, the kernel driver
> *must* set the V4L2_BUF_FLAG_LAST on the last buffer. With Venus the
> last buffer is signaled by the firmware with an empty buffer. That's
> not something we can change or predict earlier, so in order to respect
> the specification we need to return that empty buffer. After that
> DQBUF will behave as expected (returning -EPIPE), so GStreamer should
> be happy as well.
> 
> Without the proposed fix however, GStreamer would receive the last
> buffer with an incorrect size, and thus interpret random data as a
> frame.
> 
> So to me this fix seems to be both correct, and needed. Isn't it?

Totally, thanks for the extra clarification.

> 
> Cheers,
> Alex.

