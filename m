Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1596C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491572172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUIFPXxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491572172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeHUIOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 04:14:11 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33119 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 04:14:11 -0400
Received: by mail-qt0-f178.google.com with SMTP id r37-v6so11597047qtc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S/M7KTeZpkAJf6OUt4/CSxp0s4dYx9ldyRPwUvhY+1M=;
        b=HUIFPXxQ8jTNnmCgkFcmc4wcWsYJ9QvvKO1oe9wPNCAFnMRmKViwb8H008A0JvPiiD
         Lz2ADcq+cZ2w8IQUOya+MYL+G7KrCdV2sshUVq9psC/3KBQvvVpv5XNt9PkiVPnmY23e
         n1O7wbeqsZSMfqaPDTh/M7lF5fI0rQqlk2EqZsz8KQIBFlbtvL6MSjKLyw9qbsXL9+6L
         RmXbgd+XvwPq+JnU3s3l1kJWWyTGqcBpqMUfnm1oeFwhvxOvbWMj32OrfHAn5Yp/Q7NB
         G8bEV/ghquO99sKyqQi8p5pBsnAT6YPLKfWC2PKndjAq25MSl3kyGCV27dB6dZFFHM8n
         zq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S/M7KTeZpkAJf6OUt4/CSxp0s4dYx9ldyRPwUvhY+1M=;
        b=eWBvC4gOotT1G++LVIxYpHxNwb5Jm2Wc8QCr5AD3l97B7CmqbFNsnOK0JxAPyjfaNX
         TvZ5q0KAHenNgAlftmWO07W8OZMdL238r1Uc9w2dnSdDma6u4nsbw4Y0O1Hw1csOIM9U
         IdTaZU0GLC5Kg9DsPUyi3jNRrrzUH6ccif/qhv2U7DQpuuhnJydSVCEcCbk4mPIjn0fh
         du5UN0AUfhIXJSERNl8FWPGNNKsRPU3SgA78+82YJzLbAjFh80VBh8S/o4cntiAGtz84
         zCaW8LwF5W/Zw8Ey+DOIypsiWFfH9LJMaK3exIW5FMIvErhJpZVDLlsX9iFR72s8pnRs
         8lGg==
X-Gm-Message-State: AOUpUlG4Gg7cTMr9eqo49gz0SEAJAFamh36d51Uao/6bMmgUEEaL54ZT
        btBt6/DDQhBs4cF+N7EW+Lfs7rVv18Slw4Dhk/A=
X-Google-Smtp-Source: AA+uWPzMyIcwAGJCFfE4S3ZO2DaOF8y5IJHEAd1cnt+LXIg7f/ZqQ8iX7lKGogPZVqYk3ACudo0bsgvPQPOAx2edYcQ=
X-Received: by 2002:a0c:8441:: with SMTP id l59-v6mr44227233qva.5.1534827339478;
 Mon, 20 Aug 2018 21:55:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 21:55:38
 -0700 (PDT)
In-Reply-To: <b0b9e181-0df7-dc8f-927a-a2cf52bed93d@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com> <b0b9e181-0df7-dc8f-927a-a2cf52bed93d@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 20 Aug 2018 21:55:38 -0700
Message-ID: <CAPhsuW4SQA+uu9=a2jT+KW0Yq=yCyWqe13KtsB_ATTMiNzCXkQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
>> root@virt-test:~# ~/a.out
>> 11
>> semaphore 0
>> semaphore 0
>> semaphore 2      <<<  when the uprobe is enabled
>
> Yes, this happens when multiple vmas points to the same file portion.
> Can you check /proc/`pgrep a.out`/maps.
>
> Logic is simple. If we are going to patch an instruction, increment the
> reference counter. If we are going to unpatch an instruction, decrement
> the reference counter. In this case, we patched instruction twice and
> thus incremented reference counter twice as well.

Yes, this makes sense.

Song

>
> Ravi
>
