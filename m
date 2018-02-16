Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162193AbeBPRhP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:37:15 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:43402 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162146AbeBPRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:37:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name B1BE42F90AA
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>, Van Jacobson <vanj@google.com>,
        Jerry Chu <hkchu@google.com>
Subject: Re: TCP and BBR: reproducibly low cwnd and bandwidth
Date: Fri, 16 Feb 2018 18:37:08 +0100
Message-ID: <18081951.d6t0IUddpn@natalenko.name>
In-Reply-To: <CANn89iKqSkh=3D5-arubZkYdVTbb6C=OR5vK0sMDoO6S3A0GeQ@mail.gmail.com>
References: <1697118.nv5eASg0nx@natalenko.name> <2189487.nPhU5NAnbi@natalenko.name> <CANn89iKqSkh=3D5-arubZkYdVTbb6C=OR5vK0sMDoO6S3A0GeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1518802628;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=zFmYJBLkO+4pFmb5WBdZ7qo2nG/yjNLwJRAhGwHNEX0=;
        b=badOEPxUcMzo046ImKT6JYT4AK8ey576HdFk8k6TrJI/HscG6CTbuiQ2FuFtGPy2tOI8Um
        v2ML7yKOyjb3wnOTDGiPat8Vyjp86Au6G0oSSCY99gAmaFUmnDZ1DFsASE8dsQAsZwYfo/
        NbB3m1/bwFiUpMl519WBllHpb/FnYeM=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1518802629; a=rsa-sha256;
        cv=none;
        b=eCscNvstiUt4UwlTXC56SEFQDvyv5VqRD70dgtOlxlfBqta1oej6z/wzknpb+84ObMSA2/DI2yUT/QIVAPkkFW6YLOXwUgC8kmkykwlbeiYPHetPXUHclA2tZ4VKDXSu6B8Nq1sqW4z0SE6bcKDo5bhHN/+uRVughEwLye/veXA=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1GHbLJe027139

Hi.

On pátek 16. února 2018 17:25:58 CET Eric Dumazet wrote:
> The way TCP pacing works, it defaults to internal pacing using a hint
> stored in the socket.
> 
> If you change the qdisc while flow is alive, result could be unexpected.

I don't change a qdisc while flow is alive. Either the VM is completely 
restarted, or iperf3 is restarted on both sides.

> (TCP socket remembers that one FQ was supposed to handle the pacing)
> 
> What results do you have if you use standard pfifo_fast ?

Almost the same as with fq_codel (see my previous email with numbers).

> I am asking because TCP pacing relies on High resolution timers, and
> that might be weak on your VM.

Also, I've switched to measuring things on a real HW only (also see previous 
email with numbers).

Thanks.

Regards,
  Oleksandr
