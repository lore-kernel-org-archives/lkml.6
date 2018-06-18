Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2E4C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C9320836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JscAzfmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C9320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936040AbeFRTBw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:01:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37404 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935893AbeFRTBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:01:49 -0400
Received: by mail-io0-f193.google.com with SMTP id s26-v6so17810117ioj.4;
        Mon, 18 Jun 2018 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sgfX94el/0wEApQrpeej6G0XMDdTH8E3B/hil/sYlo=;
        b=JscAzfmdVLWj6mdcnQ7QKVB6u0M3XbZq0LprPiy9qWziQioOk3I9LiKKTRtztJGUA6
         oLKDDkL6W3isylf4QWaygkQ/nCblAV1Jvj1xgW1aG7aolNyqnUgcXE+A9clrGgqiVc+x
         a12ld1XhwkxHOsEpn3CEunjp55ve23+vp3sFQEG/wWeX2RXzfudcowYABQSpz/LG2+uX
         3+uvcR044dt24qj47im4HkXvCtDbYO/Fc2S8F68pie7yWCvayUU3vCOlPrppEzWP3aIK
         6bWVUO4evs4v3nW52ffvyNKgrBrio+RWpCbww+BrOpgQEFDh2yuV7EskS1WhHEDZVwLI
         Bouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sgfX94el/0wEApQrpeej6G0XMDdTH8E3B/hil/sYlo=;
        b=jIZZwqSVgxAdAX/UGznjivPf8UgVxRo0FLEHZ4hadj1hPu0DP4QxSjw1x+tvXDb2Qy
         DJkJwxQxjQ461rRDPj1KozAkrXBM58woVyV5FeqQ5NIlS7ruHd/Y3FXMp0NbJJDljEDW
         R4BO3W/HDPc9PNmSHSEwDpf8xDD52z++A3fZCc8+cMlS1Fz6RTEoP2RrjBKqaeu70Ptw
         IflxxTdTJu+tQZ/qiG7UfTiBKlj2oWlrwUgmZsVoryXYoJCYw5q1jcSd5TDJti6GRR/L
         xjjo5r/7BgEr81tM9cjoIItUXtH7dkQr5PHuKemMV5srIpiVA8U/toLAo8NKrxrEHVng
         H/IA==
X-Gm-Message-State: APt69E3s5t75/ClwSi8/m33bapoQaUj+mHRBI8B0KN+8rSArc7Rsb2ey
        We9tC/T55oHKRfcB2PYbxaZdmMjTsbgwdsNIkiM=
X-Google-Smtp-Source: ADUXVKIswAFW9F1U5yVw9tnro9+/MBIfZjKKuhmxgbFNeBX7TVycDsuLBd/M+lCGhlxEljVLGbGNuaS052nxRsznvow=
X-Received: by 2002:a6b:a58e:: with SMTP id o136-v6mr10449581ioe.142.1529348508969;
 Mon, 18 Jun 2018 12:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com> <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Jun 2018 12:01:37 -0700
Message-ID: <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI 6.1
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        juston.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2016 at 2:43 PM Toshi Kani <toshi.kani@hpe.com> wrote:
>
> ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
> as follows.
>  - Valid Fields, Manufacturing Location, and Manufacturing Date
>    are added from reserved range.  No change in the structure size.
>  - IDs (SPD values) are stored as arrays of bytes (i.e. big-endian
>    format).  The spec clarifies that they need to be represented
>    as arrays of bytes as well.
>

Circling back on this a couple years too late... where are you reading
this "arrays of bytes" note. As far as I can see this is wrong. JEDEC
says that vendor id is stored LSB of the id is stored at the lowest
byte in SPD, which is little endian. So it seems Linux has showing the
incorrect value for a long time now.
