Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B3EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F76D26A4E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F76D26A4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeF1ENY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:13:24 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35184 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeF1ENW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:13:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id u21-v6so2291473qku.2;
        Wed, 27 Jun 2018 21:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7VH7VPCh5cAI5Q6ik/KRRlbpR+d/qk29nNcRybPcwGQ=;
        b=C32q5scupFNf253XL8aGFidnmp6zDbrIqoZVAgfzxg6fgP+IM0zOj07r9LLlbZgBdf
         vJuG2DreB8H6ESX2eeAxzKPn0DJmlCvE93s61LYS1DEWQi2pbnw6cGIRkGidlj8PvnY+
         seG4yfyI+jzfuzi5fm1K7yhPujtJa/vg1BUL5ECZhIZ1npn9D9/ABwVUUhGhZzVyg4V8
         cHi42TXp/dR5USSeFYZCSspsuqD6gV7I/NNT/3/GJL0gSgYT7doh8nIi32+8BZFlW6ZD
         W5U2Ajj3Vay/Ffyadrv820FD1BsTghgHdWI2kBcK7kg0FS0c9znXdphZRhsYYY8JswBs
         OzVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7VH7VPCh5cAI5Q6ik/KRRlbpR+d/qk29nNcRybPcwGQ=;
        b=WZD6NMIUAYuYwg7Y8S0trvyZ2LN3PoxYpKUdnBkmyBpiOPict53ZxXsAupoYBkiilh
         WNnw8FBBuhQyhtPmmVhzWmbtiFY32YflAl3HdcT9wX3W66d6Sb5TLOd/u9FUnDxwgUCA
         klmXJEp/fIeape8PHWXq0Ts0W/ycCFSHRTsyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7VH7VPCh5cAI5Q6ik/KRRlbpR+d/qk29nNcRybPcwGQ=;
        b=mkqRVD1ZppmGayNcgP1Tq4tDfENItg+DulNtv3PE/xxkGjWs5dSfo6l3s0tAlEV4ax
         iSHXxu4F/jwjPvNqis99kYs1VqJdPONgYGrcaLtmncMRfEhdlSgubDR8FWfectvoFP3c
         OFFvcZ6DdbYDg81BmoW2Yj/Gp6Dmle0WuHqclFOIE8jSWW2t7vpDJxqBJ3Tg+ACsLcee
         yCrDndYApCZK7WfAJ6FX7isH0zwzTaoihLIpB6sRaZ4l9n1gugx9HtULwZmEOHdiFP3X
         x61lFVRctmhI9lBVlSp2BGgExZ78iT5X6yYGbahQ/3TSoHQrfHVW4KlUOj6yOid2Su/k
         zEqg==
X-Gm-Message-State: APt69E0U6M+/JBaGF9cUEKSDn2xDgsxhu0NwEEnrTE3Oa/m8NueuvolT
        u4UgmYPmX5N1NpiazysiVHUG7YXk4Symf225fk/drg==
X-Google-Smtp-Source: AAOMgpfGkMsXX1KhdHmVQOsOZ6FN4KpmiO2Kk7fzUUBNBZ4N+c9xW3tlsp68ZbVOcObBUYT3sjUx2d9QQjETAbd5UBs=
X-Received: by 2002:a37:6983:: with SMTP id e125-v6mr7370231qkc.352.1530159201171;
 Wed, 27 Jun 2018 21:13:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:13:00
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-15-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-15-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:43:00 +0930
X-Google-Sender-Auth: XDrBmHLEJNw2Ctut1Qg3JEBJp4o
Message-ID: <CACPK8XeLs9URZCO1KnoMmZawSwr9URpCBxn=5gKxKZbJT-p3Uw@mail.gmail.com>
Subject: Re: [PATCH 14/14] arm: dts: OpenPower Palmetto system can use
 coprocessor for FSI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This switches away from userspace bitbanging to kernel FSI
> using the coprocessor.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


As with the other patch, I will take this through the ASPEED SoC tree
once we've got acks on the bindings.

Cheers,

Joel
