Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241E7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BC820875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVkQSWrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BC820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeJFCEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:04:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36117 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeJFCEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:04:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so5134305pgv.3;
        Fri, 05 Oct 2018 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IxNzpZfrzf04aYB260LV+RsW+idnvKy2G4n6HkUa5Hw=;
        b=DVkQSWrANzQVEbIxB0Nlcx7OLj3wGT7nho/daPWb/qgY8XmmDOCiZ2HhYLGObgLlXb
         nYHR4tdV3WiXB4V3mlPY+Sx5DXoFCwYTGMkSZfqql0ut03o9CXI2yvzgi4gb5jFv5wal
         ycFjyEpjMO0Fl1c+ajYfx4s+FldyTa2HmrBGi7utt66hccZ5oP9rVjRA1ZL9bmxc8uym
         qKGpKZVKaerFJCP2N6De3p4PGkGigAFP+0hkiW+ogoieb8/i6p+xY4ZiHX3faHdPoyYM
         FBYdXEx487K2J6VD9APzzm0tjdswYvpMi/kNJKrx5KB+LPtt+5wm+bctuWrlZ4NWj1OX
         ec0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IxNzpZfrzf04aYB260LV+RsW+idnvKy2G4n6HkUa5Hw=;
        b=KLVXQu00Rx8TULz3ugwYWPOmMh6awx6pIpeT6LD2hnrIx9vmBzAS4nQAGgd3Z2XK6T
         BZH1Z/NJQD3Cv2fGhn7DFajx7eWE854gC/ch2ja7ekcg2mNN6jp3GBSkYhpu0+jWUFb5
         Pys8xExm5D54kppwsiTzq2eOVIuVVQJUSG+EYScAzzGGF1NsHfcjoEqpHzZcnFvzg3GG
         a/Inz1W/UCRTp4UknJRBgyJAvGZf8cx/9iWjuvMKeBfCVkyuezY+33nhkV/lLC4rCHRL
         80zJz6rYdt1Op+bbdu42dj1uFe5rQyqH08jb/7B19egEVtWEEf1gImcV9NTLixrHumkd
         +5Kg==
X-Gm-Message-State: ABuFfojDX0yi2qQ2w5frTeidQfEKnVySRnsOJmk9mksuAMbI1oaQ+vjz
        Ohh9UXERm6jLb6Y2vgrMpyk=
X-Google-Smtp-Source: ACcGV62yVMH0Ns+v8EkrWDksh8GtzkzM9J+zqUJnswaNs+zHA4lj5w4Stj2v9nfb+nDIDPwk4Te+ig==
X-Received: by 2002:a62:d841:: with SMTP id e62-v6mr13285662pfg.60.1538766268846;
        Fri, 05 Oct 2018 12:04:28 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id y128-v6sm11691843pfb.56.2018.10.05.12.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:04:28 -0700 (PDT)
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
 <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d251f99e-6618-f1d2-814f-7aaffb8f499f@gmail.com>
Date:   Fri, 5 Oct 2018 12:04:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+dqRr54_WAdBQ88sJytAuLL=U9kF_Xbj5rJv4PVn9gQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/18 07:53, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Callers of of_irq_parse_one() blindly use the pointer args.np
>> without checking whether of_irq_parse_one() had an error and
>> thus did not set the value of args.np.  Initialize args to
>> zero so that using the format "%pOF" to show the value of
>> args.np will show "(null)" when of_irq_parse_one() has an
>> error and does not set args.np instead of trying to
>> dereference a random value.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/unittest.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Does this need to be part of this series?

I do not know if it could be independently applied before the
rest of the series (I have not tested that).  I included it
in the series because the series has so many other changes to
unittest.c.

If you want me to break this out, I will remove it from this
series and resend it after the rest of the series has been
pulled to mainline (and rebase on the new mainline).

This patch is not fixing a known failure case - the current
test data does not trigger the problem.  The recent patch
from  Guenter that you already accepted fixes the known failure
case, so this patch is not urgent.  The same is true about the
other cases Guenter pointed out that this patch should fix.

-Frank
