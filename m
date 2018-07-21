Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3119CECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19A220849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoNdj5tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19A220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeGURTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:19:35 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44891 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeGURTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:19:35 -0400
Received: by mail-yb0-f193.google.com with SMTP id l16-v6so5775992ybk.11;
        Sat, 21 Jul 2018 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rvJGNyqbxXUdov3UpMvLUnDCSV18eeMuFAPnt8IuKeA=;
        b=uoNdj5tQK1IKdLs3SNdGPO3oPjAYKIJZUW6n6EwcqvTTz2QOF0XOU58tJS1JAW7Rz4
         ou4h1YmMkG2IlCWPYRbfuTvEKq70TiO8qgcSsmsXJyPNqcsWx5V/Fi2A2YU+C+w33W87
         EwjOHLTA9scAX+hw/6jgtmhC9gFZHVPi5HZNKhj45JU9blE7UmN1bZAd3Zh3c4LFXm3J
         9mnPV2DrgpjeIC3hpLOwBcVlT25cU+73bTlRwkp8+BpfJ4r7fwpCZsqpnB2+bD6Np9y2
         ysfyxGx9ngU2tUlVggqfBm66C9/SLD8iWSgnqwyklwekVmXiJocAFC2sJdXBF4kdNvNX
         NQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rvJGNyqbxXUdov3UpMvLUnDCSV18eeMuFAPnt8IuKeA=;
        b=PHLKMnueJXwvfKriJ9rLwwOSVccOSBrnmDPhPp8Kwvn7sD3wHo5JTbbhZHfEUUBPCS
         9ro+VP2bRbLAdVkhVqfPZ3HkniYFWK7woYu1W1Wi04lO6N+RzTzry0RJVrKFmG4kx7E3
         cIl3WZeIzoEUYWI/3rwGQ1Fg32+ygTP22udPiRaDHYYy0Odmb3ASGAAL+CpNwctzcP/O
         Za+IB3o0xJrrPuU79M51XNTLcbx6/GlkhQmKUpAsRI4QHv5bklHI/rESRGv7iEub1OXz
         KisYV6GapUKPcvPACxrjc7jwS+y6FKUP/n+ZEZtBLZaRE8yP7F9pBJ3p4h5m6svnNb/5
         BOEQ==
X-Gm-Message-State: AOUpUlE4pyA+qFTaK4GMpQ34riNfyxAChPvfIxjkR7Cf7Wca+Cfib4w6
        V0c0TM6x+QyZirkdSKMkCLg=
X-Google-Smtp-Source: AAOMgpfh36vHu0BlO4zlFCc6BKEuYZUWNnz6NiE/B0SpMrRAJR3f5zTV3BFBAoyYf4uVJ0gP3wVz3g==
X-Received: by 2002:a25:6546:: with SMTP id z67-v6mr3292900ybb.453.1532190378201;
        Sat, 21 Jul 2018 09:26:18 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id q127-v6sm4966244ywq.83.2018.07.21.09.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 09:26:17 -0700 (PDT)
Date:   Sat, 21 Jul 2018 12:26:10 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
Message-ID: <20180721162610.GA15622@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
 <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:49:54PM -0700, Andrew Morton wrote:
>On Thu, 21 Jun 2018 17:07:08 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> This patch introduces the Generic Counter interface for supporting
>> counter devices.
>> 
>
>+EXPORT_SYMBOL(count_direction_str);
>+EXPORT_SYMBOL(count_mode_str);
>+EXPORT_SYMBOL(counter_signal_enum_read);
>+EXPORT_SYMBOL(counter_signal_enum_write);
>+EXPORT_SYMBOL(counter_signal_enum_available_read);
>+EXPORT_SYMBOL(counter_count_enum_read);
>+EXPORT_SYMBOL(counter_count_enum_write);
>+EXPORT_SYMBOL(counter_count_enum_available_read);
>+EXPORT_SYMBOL(counter_device_enum_read);
>+EXPORT_SYMBOL(counter_device_enum_write);
>+EXPORT_SYMBOL(counter_device_enum_available_read);
>+EXPORT_SYMBOL(signal_read_value_set);
>+EXPORT_SYMBOL(count_read_value_set);
>+EXPORT_SYMBOL(count_write_value_get);
>+EXPORT_SYMBOL(counter_register);
>+EXPORT_SYMBOL(counter_unregister);
>+EXPORT_SYMBOL(devm_counter_register);
>+EXPORT_SYMBOL(devm_counter_unregister);
>
>The naming is a bit chaotic.  Most of the symbols start with counter_,
>which is good.  But a handful do not.

I can prefix these exported symbols with "counter_" to help make it
clear they all belong to the Generic Counter API. I'll keep the devm_*
symbols the same to match the naming convention in the other subsystems
I see (watchdog, IIO, GPIO, etc.).

>
>Also, symbols called signal_* make my head spin - Linux already has a
>firmly ingrained notion of what a signal is, and this ain't it ;)
>Although the kernel tends to use sig_ for signals-as-an-IPC-thing.
>
>Also, many many drivers deal with signals-as-an-electrical-thing - is
>it appropriate for this particular driver to take that namespace?

In the context of the Generic Counter paradigm, a "Signal" is an
abstraction for the stream of data that is fed to the counter device for
evaluation (triggering updates for the readable "Count"). In many cases
a "Signal" correlates with a physical electrical line (for example the A
and B electrical lines for a quadrature encoder), but this isn't a hard
requirement as the paradigm permits more abstract data streams.

I decided on "Signal" to match the naming convention that appears in the
datasheets of many counter devices, but "Line" may be a decent
alternative name we could use to indicate a counter device input data
stream.

I'd like to get some other opinions as well before I make a naming
change to "Signal" -- whether to stay with "Signal," switch to "Line," or
rename to something else. For what it's worth, I think it's unlikely for
a counter device driver author to confuse a Counter Signal with the
Linux OS signal within the context of the Generic Counter paradigm and
their respective counter device datasheet.

William Breathitt Gray
