Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33EEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB5720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544697571;
	bh=v6WOIZHa5S58mXL53mYQV/JzrLGnanywP7/tHzTx8q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HFrfuLOhliDTSjjhGP2tQ/IMc67J4QJ0+oc8i6GRuXsA5M0XVsUcId/uVoVS1WM+A
	 /Hu4kMY8uuF+FKRTp2beDPrmeIaoJB0aF9go9cMnW5VIxWEUzVtDMeRnFcc3Tvp1C/
	 vDLUMxyIefR+Wbo4MC0rTFutA4hYbRZp5wY19w8M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB5720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeLMKja convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:39:30 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39639 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeLMKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:39:29 -0500
Received: by mail-ot1-f53.google.com with SMTP id n8so1446583otl.6;
        Thu, 13 Dec 2018 02:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=shSWOQiGdBusltcExBTUi8voEbvnFB8hcp/Tinu8EOM=;
        b=DtHi2TH+gfek3XJMuGruwSSl0h/lgryRWW0077gV0Hm4SkJnKXPl8T2JejQQmudVBU
         UgMz1fv2mTOATw2QLMs1+aHIU1km+Jk6Jt0XxVA/tQc+80HzBURk+jJu+HGz0SJSzOdW
         wv4LhpLgzPbAC3/9SA7QrPy4bv34HI16EFvJ7hT0c2+tZSg/kQnqXI1G8cyWZ5dBJKCe
         giXHW3NT8rHonqbZuDXjwfHt6AddP4ZhQ88G6EIOsZqrmPM6EoMnImY/sjJpPgPwGr5k
         /Krb9+1/UmZhGdlI8X1j7aP8HDH+DSMZ8bjy4cXpjRgraI+vb+bXLagke45i9ygQJnoK
         +srQ==
X-Gm-Message-State: AA+aEWY8QMtYwx0dkEB1FQAPWCxo/UF61XUMuWRA2STyXqKEqV7btBLc
        4PfOETyb0Up67XI0NGhMBKv53XdnV3dZmo3Pefo=
X-Google-Smtp-Source: AFSGD/VL66s0fMMiFZV4CZjjvvxnupXpd8clyCfLkfZo99PGbCRL6pN1U6C+WFb8j6rNbP7iuH+ptfmPAxKpirAe1zY=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr15460316otf.124.1544697568481;
 Thu, 13 Dec 2018 02:39:28 -0800 (PST)
MIME-Version: 1.0
References: <000701d4926f$533eb270$f9bc1750$@net> <a4321c48-e9df-1a2a-cfbd-bac07a9c65d8@molgen.mpg.de>
In-Reply-To: <a4321c48-e9df-1a2a-cfbd-bac07a9c65d8@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 11:39:17 +0100
Message-ID: <CAJZ5v0gUDzy8vV=JajDHZJi2F0FyHUkFfYbbJhMioUa5XoKuqA@mail.gmail.com>
Subject: Re: intel_pstate: Lowest frequency not reached with Intel i7-6700
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:54 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Doug,
>
>
> Thank you for your reply.
>
> On 12/13/18 00:06, Doug Smythies wrote:
> > On 2018.12.12 13:40 Paul Menzel wrote:
> >
> >> Using *powersave* as P-state selection algorithm, on an idle system
> >
> > Define "idle system".
> > If your computer is running a GUI, or is even a server without a GUI
> > but with many services running, then "idle" really isn't.
> > Below is from my test server, with many services disabled, so
> > "idle" really is quite "idle"
> >
> > doug@s15:~/temp$ sudo turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
> > Busy%   Bzy_MHz PkgTmp  PkgWatt
> > 0.01    1608    27      3.71
> > 0.01    1619    27      3.71
> > 0.01    1600    28      3.71
> > 0.01    1600    28      3.70
> >
> > Note that p state 16 (1600 MHz) is the minimum for my older i7-2600k
> > processor.
>
> The thing is, on an Intel Kaby Lake laptop with Ubuntu 18.10 and GNOME
> running, it goes down to the lowest listed frequency.

Kaby Lake has hardware-managed P-states (HWP) which is a different mechanism.

> >> Shouldn’t it go down until 800 MHz?
> >
> > We would need some actual busy information, turbostat is the
> > recommended tool, to know for sure.
>
> Here you go.
>
> ```
> tools/power/x86/turbostat> sudo ./turbostat --Summary --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
> Busy%    Bzy_MHz    PkgTmp    PkgWatt
> 3.59    1167    31    1.68
> 3.21    903    31    1.34
> 3.21    906    31    1.34
> 3.27    901    31    1.35
> 8.23    2715    30    2.32  ← stopping GDM (systemctl stop gdm)
> 2.95    915    30    1.18
> 2.91    906    30    1.18
> 2.92    903    30    1.17
> 2.90    900    29    1.17
> 2.89    903    29    1.18
> 2.91    903    30    1.18
> 2.89    903    29    1.18
> 2.89    900    29    1.18
> 2.90    903    30    1.18
> 2.90    903    29    1.17
> 2.90    903    29    1.17
> 2.90    900    29    1.16
> 2.90    903    29    1.14
> 2.90    903    28    1.11
> 2.90    903    29    1.10
> 2.91    900    29    1.16
> 2.91    903    29    1.14
> 2.90    903    29    1.12
> 2.90    903    29    1.16
> 2.90    900    28    1.17
> 2.92    903    29    1.16
> 2.90    903    29    1.16
> 2.90    903    29    1.16
> ```
>
> 800 MHz should be enough to keep GDM running, shouldn’t it?

Well, depending.

> Otherwise only SSH was running.

There obviously is something that causes it to stay at 900 MHz.

Please check max_perf_pct, min_perf_pct and num_pstates under
/sys/devices/system/cpu/intel_pstate/ .

Also cpuinfo_max_freq, cpuinfo_min_freq, scaling_max_freq,
scaling_min_freq under /sys/devices/system/cpu/cpufreq/policy0/ .

However, please note that Busy% of 3 isn't particularly low.
