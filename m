Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B466D21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545313569;
	bh=vYhl2x6davozELHgiO3RCxNb/jJ52aJCASJhYrZEf8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nCzRjuyvGTB2oADUF+GPDUaEXCLrDqb0+PQyW6h5Lk/0/ucaIvQADLQFSml7Kn5um
	 5+mZ6gY/Zb5Tg2uH9ATP8ipiwyTkRGou3iq+ZrVXdSW7lqFDz+wvqIq6ce21EFAVCo
	 LciefC7D4hbhPikMs6AjhCVUDKM15Sp0BGHo6GNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbeLTNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:46:08 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:37320 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeLTNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:46:08 -0500
Received: by mail-lj1-f175.google.com with SMTP id t18-v6so1620490ljd.4;
        Thu, 20 Dec 2018 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fzjEFGg0X42D8Ypua1GYnw5I4LyM9JSBHvzpTSssFqg=;
        b=AfFt1ydRgzY3/1aT3fHgz3Q9Qbp2ACXQr4GaYj4T1jBEPhu7JgdhXbMh/dPMNxz8bt
         3AkmiCY2vcVWsEcnHq2BcT2b/bFnYRZpdeewLVEKJNMFp8TrWxARUfbxrX4/sQEdwKaG
         SgtcoZl9AWAjb5xmkOAYAkfBj/Ncn6vh1/ptMpLInVTKYbB+9WCdFcovbnhe18+t12BC
         +WjZAcRWPybFHW4yc3IwGt061wAgICWPmF26ePWzf0P1xWyJ7eVBdVitEHjsdkIeI2ze
         CbIgZ6c6NW/a48K0+2JMjqk+4AGI+c69Umgl7FOr5vTGg0FdMFSOdCP30Wdzj0BjKHY/
         CHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fzjEFGg0X42D8Ypua1GYnw5I4LyM9JSBHvzpTSssFqg=;
        b=WuoZ/JeUy8aNR8gfD5UeL4czzFHVc8/Db6wdAx3a31/q4kq0SU2icd7Nz0oL32QbPt
         wyhyXlCpfThfdjKhLolBdWP/FJRurNccEsbSsiqXxyV+2W2RABvNOkw3OzEhjF8xV2Pw
         EGo3QFhbqAoBfFxag4paaQpAODnTyuoA6rtkA2bAJUBqyw0Ewal4j7uOMc3zljeDh56v
         v4znplnWazofmR3MisJVwqxRLmq4MLQB+kWkv9/UODo9wlvHckxbKG0UdaHXjyYCITUZ
         aLVQfQu6LohD3gwuLuyWwRUIDic4GQbv/raeLCTQFeM7wKNbqmei3ci5KbuKQswU0e4Z
         IzWA==
X-Gm-Message-State: AA+aEWafnv7ERNS0NeLCSGWRJXNrVDdVH11e8TXnuFhYBbliuInjZf5X
        Ihl4tL18kKcQepCtBEhTS+I=
X-Google-Smtp-Source: AFSGD/Wfv80ikCE9pAZucAUnv8d/uo2N2bpIS/i7vZNAByTv5D6tj2Ysbc63yPuzMEeRiGD/zAnRRw==
X-Received: by 2002:a2e:9bc3:: with SMTP id w3-v6mr14985827ljj.70.1545313565888;
        Thu, 20 Dec 2018 05:46:05 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x16sm4213598lff.26.2018.12.20.05.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:46:05 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gZyeP-0007EU-Kr; Thu, 20 Dec 2018 14:46:09 +0100
Date:   Thu, 20 Dec 2018 14:46:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] usb: serial: garmin_gps: A possible concurrency
 use-after-free bug
Message-ID: <20181220134609.GA27701@localhost>
References: <8b24e2fc-df9a-8e06-aa49-a27675fd36e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b24e2fc-df9a-8e06-aa49-a27675fd36e9@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:41:16PM +0800, Jia-Ju Bai wrote:
> In drivers/usb/serial/garmin_gps.c,
> the functions garmin_read_bulk_callback() and garmin_write_bulk_callback()
> may be concurrently executed.
> 
> In garmin_write_bulk_callback() on line 969:
>      kfree(urb->transfer_buffer);
> In garmin_read_bulk_callback() on line 1165:
>      unsigned char *data = urb->transfer_buffer;
> Thus, a concurrency use-after-free bug may occur.

No, they operate on different struct urb.

> This possible bug is found by a static analysis tool written by myself.

Seems you need to update your tool. Please also make sure to review its
output before reporting anything.

Thanks,
Johan
