Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5347DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179AF20896
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXQjmxop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfANPIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:08:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33433 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfANPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:08:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so9588115pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JiEEH8uwXkhabO65ZbIae/Tf7RTeVrA9CnBmBnP8oQ=;
        b=NXQjmxopigyf9Vfi4fYhRYmxyfJWcmKPxu4X55q3sqk3EP8HMIzhbNnFq/Wx7owswn
         h4agbhw4KsJ2xFwX6BqotL5YWIVWqZLqujIqr0d1W6vkaqB9q1SizbiAXvhH/8q+x7Tv
         M+lZDFJwx0qIzND81LQcLNrKlROth5389wfPBk2dqhxHg9jqHvaDYuGYZxSHoNoHDrQk
         0KR4oydwIlZTfsUHxcCxWzuR0mj7ntdPrNMDxs8GsWA7HrppniFS0erZ/g9emtBrTCEO
         BD9a8xC4SSQM+H8T38oGsTPapfYxC84N8XjBpf1OQr4RUYenat99T18N8+3n2JovuxeU
         zdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JiEEH8uwXkhabO65ZbIae/Tf7RTeVrA9CnBmBnP8oQ=;
        b=K5aJjMaKM+XT58ATTHk+FT91VEG98Cm+jcvld95CIFJwb4ShZRvfGO5Kn2l9bStySb
         8O7jWYF6xfSf1rkY7U1fcFS3gzHwsFIiZzoW5GZUnKyWPF+NTFngJkCQQCowN/ALEaF/
         DwCPZCVFrUQXMED5wmfR/ErKpI7EU/6+/vARC/kikhGXlQ6kvREN0msobed3wgtUT2DL
         GDNp3heDZTiQUEeth7FFywpDsTkBY7OeNGIrbkDCciKw5LOBHrzvBO4ftVfJuLUysW2h
         /n8gykefKeeaNX8wJIzMsklH1qSha5F4chf7IKnmul1e/Q5Ch+g3f4Tr+z07JZaU5I4+
         k6VQ==
X-Gm-Message-State: AJcUukc75RAXJRUNQYUTtWzSdg5xWNNyJsPK86WEWbYgUZ311yVmoW+n
        chrrso9RfDCzHzD+VKhNDmDBWaj5cIRda77Z
X-Google-Smtp-Source: ALg8bN4dGmXmQB9RB891NxgfqlP9gsPhPeXxYqLE8zT0qC4EeeOwZtrqfkABaX+VIu0Mn6apR+QPvQ==
X-Received: by 2002:a62:d005:: with SMTP id p5mr25815840pfg.175.1547478524787;
        Mon, 14 Jan 2019 07:08:44 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id z62sm1216984pfi.4.2019.01.14.07.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 07:08:43 -0800 (PST)
Date:   Mon, 14 Jan 2019 20:38:37 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH v6 0/2]  greybus: gpio: Switch to the gpio descriptor
 interface
Message-ID: <20190114150835.GA19794@nishad>
References: <cover.1547219996.git.nishadkamdar@gmail.com>
 <20190114090517.GB3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114090517.GB3691@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:05:17AM +0100, Johan Hovold wrote:
> On Fri, Jan 11, 2019 at 09:03:16PM +0530, Nishad Kamdar wrote:
> > This patch series converts uses of the old GPIO API to the GPIO
> > descriptor API. It also converts the GPIO driver to use the
> > GPIO irqchip library GPIOLIB_IRQCHIP instead of repimplementing
> > the same.
> > 
> > Changes in v6:
> >  - Patchset now contains two patches as the patch
> >    1 has been accepted.
> 
> All three patches look good now, but since Greg picks these up directly
> and applies them to the staging tree, it is best if you submit all three
> patches (with my reviewed-by tag) in a series.
> 
Sure, I'll do that.
> One last resend as v7?
> 
> Thanks again for doing this.
> 
> Johan

Thanks for all the reviews.

Regards,
Nishad
