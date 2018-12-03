Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E06C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0520848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dmyiMPaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC0520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeLCRQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:16:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38515 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLCRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:16:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so12334332otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R7//ouQOHJxMmF+Hv4PttcsPESm78QHjH+fq/les3KE=;
        b=dmyiMPaAFzFy3QX1b0jps6exvCJySRySHWYW0DPVff4LBG0lKU7f4cEcZiUcvQHD1z
         F6ehGkGKpcYQlaephvO8LqprxL9JK4FLIhspS5zDOZCbGXKwDwv4cCoGqr4AQS9eK48b
         bxA9oOYuNMUlughk8h3eh1aU2m8qCPezagOiUQDUbKgfGAJos4BZ6Mhjs3euDr9lyCGa
         oy5atu0yp6liTqap4eMQYz/tq6T7ZE3vPjRETb3fPmYCG2qq4z6mzDCR6ZdV9CO+82ga
         Q//pHZXTm6XZ4MTQvFxIp9mqK7+bECogoea4hElo8yetGx1NigBE3XvOl+DnJYuvN/Vm
         OJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R7//ouQOHJxMmF+Hv4PttcsPESm78QHjH+fq/les3KE=;
        b=U6gPvceiz91INdaIAK9GJK539ETrblzS8hOla37DKX1pz6n3mHsrfgkXxoCLrz9Q5A
         CPvQtADWEByT0/FeFRZsmzTiimH3nD6yIz+u6+mk8eBdwlTL8RekdXkgWFa8ydrHjQfu
         4UATb7pZHt7l9UoLiNyHJJHo95phv7dsR6aEcnS8wSVnYVctM1Q7yzY0/gcROepS4QuE
         VNafio8SMvRuW7GAU/JsUssVZsXWoJV2qWF67OmMDtrXkZzWaTyozSgp29h1ezrzuaZy
         YfTZHHGnQC70+06ujUjzkk/3dtkmkxEbCezD4VIknHOUbrENJ8BTPlNUAiJ7FjCUyTgG
         8NhA==
X-Gm-Message-State: AA+aEWaaHfOAux9izUPgnuJsEvZkWb1dDf+0h/StM+tuWZbpF8hQ3wYa
        yLpYFwcFzHHcDKvR56Xck23IlJ1szcKUEyA0BlbQ8g==
X-Google-Smtp-Source: AFSGD/UOEXuLcWsBc9pzYf3aqSlpIpOYgtFRaVTpHLi9mFjtCOmThruWOE7Yo0+CFJ1xgdOKIxA30R5PueiX+K+dGbk=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr9890972otn.95.1543857372870;
 Mon, 03 Dec 2018 09:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20181022201317.8558C1D8@viggo.jf.intel.com> <ffeb6225-6d5c-099e-3158-4711c879ec23@gmail.com>
 <48d78370-438d-65fa-370c-4cf61a27ed3d@intel.com>
In-Reply-To: <48d78370-438d-65fa-370c-4cf61a27ed3d@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 3 Dec 2018 09:16:01 -0800
Message-ID: <CAPcyv4jU1A93J4pqme3bGHE_KJE2TZ_F9pncgesuksT8YaR-FQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Brice Goglin <brice.goglin@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 8:56 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/3/18 1:22 AM, Brice Goglin wrote:
> > Le 22/10/2018 =C3=A0 22:13, Dave Hansen a =C3=A9crit :
> > What happens on systems without an HMAT? Does this new memory get merge=
d
> > into existing NUMA nodes?
>
> It gets merged into the persistent memory device's node, as told by the
> firmware.  Intel's persistent memory should always be in its own node,
> separate from DRAM.
>
> > Also, do you plan to have a way for applications to find out which NUMA
> > nodes are "real DRAM" while others are "pmem-backed"? (something like a
> > new attribute in /sys/devices/system/node/nodeX/) Or should we use HMAT
> > performance attributes for this?
>
> The best way is to use the sysfs-generic interfaces to the HMAT that
> Keith Busch is pushing.  In the end, we really think folks will only
> care about the memory's performance properties rather than whether it's
> *actually* persistent memory or not.

It's also important to point out that "persistent memory" by itself is
an ambiguous memory type. It's anything from new media with distinct
performance characteristics to battery backed DRAM. I.e. the
performance of "persistent memory" may be indistinguishable from "real
DRAM".
