Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D882C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C38E21557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtjjLGb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C38E21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeJHWrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:47:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40055 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeJHWrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:47:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id t22-v6so14250365lfb.7;
        Mon, 08 Oct 2018 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bt53+167I3T/zTBF4LYtloYNNwDDYlflVUXxJ0D51tU=;
        b=gtjjLGb7d/cRjOlQke3dLFIVuK2+g6Bzf7ygH+vYfOe/j4NhRhSuK/GbI5BFLfrkwi
         dAZCQ4sVEGkeurjAn9chZUgAlQdoErs3kJL9PA/E5V+jssYmCLxxXJdQUYMutjSmeLec
         KseYPXmf2rgXF7xvBdmeWjx1tSQJhRlsbgl2hU9758Eui8QOlo/uAULCWb6bvvRlfq6p
         J+hz1JRVMCiSARQWz5eo6hqv4kkSXdR4L+usupwEXuEx5Pgw7i4kkKbMc2MGHSaPYh9z
         UvlXpTiI7leU97J1/TBu2zEOPQ6eAdL39u3bRwWVzupmjGfwdkvgax11NWT/v167GBWO
         /1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bt53+167I3T/zTBF4LYtloYNNwDDYlflVUXxJ0D51tU=;
        b=o/BxRqQGM1WjxvnDg3kQHEyrdzsjTy72b77WqUKvrKm7R2ahOx2sKUmclT/2L/za+4
         i96Vp3RGAM7ynoIAQiJ09L2KO56Buy9UTmrtgMXcu97NNIuaqelPhSZ77igHO8iFW9p9
         xNJuxrS5W1X6pZLKRXxZD2rm21AplAEPZkf3V3eESQyez/27kFnKnub96XvfBpnNaeKr
         CmO5v+lSsJiX1OlXU88EP1v4GZ7ZiwDsmPw7I9uhzaZ5I3UWJ33kcrkfoRosvsB9JKtu
         Q22B0ecG+uPd1K5KTCSsmQI9oZc45CUICJolT2vpJZ4ujZp9PFVyblUIzf8U3NotULT7
         BCIQ==
X-Gm-Message-State: ABuFfogifis6IQ9lIPQb7X/yNd9dKdlMWJz9yKV5oBvo+16Ad/L3Ivd8
        D9M6H/RF+QbQz54tQ4qmGeA=
X-Google-Smtp-Source: ACcGV62cNUWr5I1/g2Tyi4mILqn+h+i2k9z46VcdWW2MeJfbEjAxkpg/XMdI/E6Tt2nLlas9CCHzCA==
X-Received: by 2002:a19:8f57:: with SMTP id r84-v6mr12550658lfd.131.1539012898904;
        Mon, 08 Oct 2018 08:34:58 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 9-v6sm3968466lju.61.2018.10.08.08.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:34:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g9XYg-00032u-IP; Mon, 08 Oct 2018 17:34:58 +0200
Date:   Mon, 8 Oct 2018 17:34:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Tobias Klausmann <klausman@schwarzvogel.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
Subject: Re: [PATCH stable v2 0/2] termios: Alpha BOTHER/IBSHIFT,
 tty_baudrate fix
Message-ID: <20181008153458.GY3774@localhost>
References: <20181008040620.1248277-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008040620.1248277-1-hpa@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 09:06:18PM -0700, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> It turns out that Alpha is the only architecture that never
> implemented BOTHER and IBSHIFT, which is otherwise ages old. This is
> one thing that has held up glibc support for this feature (all other
> architectures have supported these for about a decade, at least before
> the current 3.2 glibc cutoff.)
> 
> Furthermore, in the process of dealing with this, I discovered that
> the current code in tty_baudrate.c can read past the end of the
> baud_table[] on Alpha and PowerPC. The second patch in this series
> fixes that, but it also cleans up the code substantially by
> auto-generating the table and, since all architectures now have them,
> removing all conditionals for BOTHER and IBSHIFT existing.
> 
> Tagging for stable because these are concrete and immediate
> problems.

This isn't stable material in its current form. If you want to plug the
alpha and powerpc info leaks in the stable trees, then you need a
minimal fix for that, which you can then your clean ups and new features
on.

Johan
