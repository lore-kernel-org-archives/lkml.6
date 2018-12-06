Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7416320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrrsJCLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7416320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLFSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:43:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44897 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:43:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so1113576lfe.11;
        Thu, 06 Dec 2018 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E32z9xwn3qZObIZh4aMlitInV53woXY+PqY/1bPeIVQ=;
        b=WrrsJCLomJ99yNzngG9xA4jfxlZoa9A9VoKkyQ61YfHIkYs6dYJt8DxrKDzbZYVzBZ
         7WZ4HJL9klVyFX42gYF2nk3fPm+RKWXMIf23bOcwxmm5qPlIyCGl76oI2hpM/kxJrz2h
         nU0X12oCWKJVkm8xgoiEyVItivC7AFIHMcZxv/4wWxcPtoogPc4oI2/c6IZstrvn1Sh6
         py49XjrQIdFKKl9P2raIEsMHjYeMQJnIlzf6ZrzQ+qdw6XRtZ8WaDjdsjJz8yMjS6bzA
         eSmpe8swqF7GrdoarE4X0v3uW9c7Yp8XeI7BwzT+DPzinSAPMZk0/gIoQNYJ1ePd6cg+
         nghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E32z9xwn3qZObIZh4aMlitInV53woXY+PqY/1bPeIVQ=;
        b=f+9FC0QAueQ80p5skT7SWzXK07Ky7mGUT3n/WwhDzX4wNnFY0XMClNpGHGbeH5lc0c
         urnLvI74p/4B+ebVTqn0sxK8EJq1FWp0o3Jz+iJ8kadkGj5HRlP8csKW2ezz6X9AWWod
         5bkIgdzZox6YeC7f7+c5h71zBpRZpKFfmK+N30f/HxChiyh4qQdkx/UorNYn4Wr6uZn5
         iDBu3rsNlfNS3QyjQjW4zuvMHxtSwpSxUWNedQv5EasTgrQ2pBGb0/ZRneayIrQAoKm9
         rENq6dGyufAXbtJz1m6jgl2eqTI1t4bF+fhpNzSqhmMAWq5MPFnAwBQsJM7+ScdAwWZl
         y2Wg==
X-Gm-Message-State: AA+aEWYqDz9DFrHKc8szUhdjdOeEHsIZI9wG4zOorKeBILREl+1+MG0c
        SNPbpPsrzj3A4EEcFxsboVC1bTbFGAOaNu5QYQ==
X-Google-Smtp-Source: AFSGD/WLEdDnDlGYXPR+T2Qbd3Bv7mFruC3zOalsn/UMcugWs0sSzc2lPIHr7nP5IHm2YEXRAqD9/yUnoDUlUInMSWs=
X-Received: by 2002:a19:d04d:: with SMTP id h74mr3196563lfg.52.1544121798836;
 Thu, 06 Dec 2018 10:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20181205110204.GA17143@kroah.com> <20181205235637.1079-1-amanoeladawod@gmail.com>
 <ccfa900f-114a-0a4d-1d20-22f8d390ce84@infradead.org>
In-Reply-To: <ccfa900f-114a-0a4d-1d20-22f8d390ce84@infradead.org>
From:   Amanoel Dawod <amanoeladawod@gmail.com>
Date:   Thu, 6 Dec 2018 13:43:05 -0500
Message-ID: <CACd_pd9Hjwgxm2RcFsBDpobnLK_XhCdox31ZAkzk-Mki4PCrFA@mail.gmail.com>
Subject: Re: [PATCH v2] Fonts: New Terminus large console font
To:     rdunlap@infradead.org
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 7:42 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>                converted
>
> Where does "ter-i32b.psf" come from?
> I.e., where can I find it?

The Unix/Linux Terminus sources are available for download
at SourceForge. Simply running "make" in source directory
will build the .psf font files.
