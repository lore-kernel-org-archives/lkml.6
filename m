Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94832FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3837620873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRY/Rlep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3837620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeG3GXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:23:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41827 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeG3GXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:23:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so9247165ljy.8;
        Sun, 29 Jul 2018 21:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KAu0lnE+i48nXxt0r7z0sA8TcpvLp4I4zbDy5VBL3iw=;
        b=CRY/RlepBUjHt+a3sfpc5LWG0OCYd5018k4NQ0E9cEDTnsTkXFor68x9R4HhIsseLw
         Lr43RrB/vC35mVEWb+aZr4Mg9jK+EO8yf60XzttGe0gkz4cSflXPlLzCz0KRLLu6mp0o
         KJmxNCBiGv535PJFTemWkw4W7HHp1PpT+FS0ogxe2YslYqwVLGUQrYNni5t706HR7RCA
         Itdn74UEVXPRGWDM1YFzx0ZJ1DnliFncAHgsJ8O7zfhtIrjrcf1Ut6H85Mn8moe9owR6
         W27tw9LAcZ1IzC6G40qGoLBPyInPqxWodtt6PlxNCn1xiM92FltaHnjBumTZzWwDqcGj
         NSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KAu0lnE+i48nXxt0r7z0sA8TcpvLp4I4zbDy5VBL3iw=;
        b=huShZk61N4xnkI+FdDVuOkd5bEHJBmUDhJW0KYlejeksg/7/nGrzuQ/xwtc4rdy/A0
         +vq3jpcejCoPv+ONyIGM7YE1pO/r4N6nfUNppHHSYajBaw+V8ua3J0KP+PuycCu7VWgP
         GTOgXhJ5tpR7+cyIhSV8rQijDrsIHKZr0ZJDiaz+1BXv6+VYYT6P9m3rKww/0FWDYC1/
         8jrMPIH6cw9+l7yI0YBSZWKSYWEBE3ZDRpkzX0fA7cXzEkrTaFW/UPuxSAX77dtujaW8
         zM6vKKdH08I306ILa+uC6mCH/1HlUrR+Z4sUG+d2j7q3p33E79fVzPTFrdxfvnUQz62H
         kbkg==
X-Gm-Message-State: AOUpUlF9s0EdSEa8bR2M7nA1ey3XJuM8bWLgAPQcRh0UZqklJhsEKYIR
        csNCONCVroK11HMK1FeramRFbih2o0RiXV7jVWs=
X-Google-Smtp-Source: AAOMgpcicl3M/6OXtA+EuJMFkcYOKBMI0uSuv4wj7krTc2xTWjCR9z6zcr6BKnLdsBvGSTf+FML8daBZqGFIOsUAJ/Y=
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr12063455lja.96.1532926196687;
 Sun, 29 Jul 2018 21:49:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 21:49:56
 -0700 (PDT)
In-Reply-To: <bf0ac658-582e-25a2-3a1d-1046d2c6228f@kernel.dk>
References: <20180728095043.GA24085@jordon-HP-15-Notebook-PC> <bf0ac658-582e-25a2-3a1d-1046d2c6228f@kernel.dk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 30 Jul 2018 10:19:56 +0530
Message-ID: <CAFqt6zY2756xkqQruBtfRun+fQNHRRF2dXJHOQYfrhW4g1-HFg@mail.gmail.com>
Subject: Re: [PATCH] fs/buffer: Convert return type int to vm_fault_t
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 8:34 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 7/28/18 3:50 AM, Souptick Joarder wrote:
>>  out_unlock:
>>       unlock_page(page);
>> +     ret = block_page_mkwrite_return(err);
>>       return ret;
>
>         return block_page_mkwrite_return(err);
>
> --
> Jens Axboe
>

OK, I will post v2.
