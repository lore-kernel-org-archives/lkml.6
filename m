Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE366C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916BC21565
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C17LXfQ/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dWbT8CGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916BC21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeFUUb0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:31:26 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43276 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933179AbeFUUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:31:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id r19-v6so1624551ywc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=82cQoga8U3JP4qIyKPTCCko0vtq+GBfnMIGH3HnHvw4=;
        b=C17LXfQ/XycIm+iIN/piL2/4WWPm2a3wciB+xI/pk0M6qhm6qKsAnJjsEAWslteFNt
         +awgWI8XHZgJffG7jtoR0MI/rUTlshR1IpYZGZI5sOxd1OO4ee/WZ0b7bodO+IXN/PHq
         VjPG5sw9rhgg6R8fNVJAFY1vKSaLjUvlDmTZxMNd5TmyxWQObxLjuabWzmP683QtX6nL
         kbOndRaI5GYYYzYJumRZ6apieEUh0/h9Aevis4HOOY2z/xwGq+kvZMI7m/hyF5qekLs/
         xKVu30cD1fWu8OHCDbxuFZWqKPLgFUUG70hrdyi5UMas4ohmQJ88AHn/EjiwhXmdA3f5
         wFrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=82cQoga8U3JP4qIyKPTCCko0vtq+GBfnMIGH3HnHvw4=;
        b=dWbT8CGxT9EbO52aYjjWI0aFWLtNpCLaoxSMATHpEOVX4KbXsJyGBNmCsYEueRWDFl
         n5RNvrLGVE0715Rm4nQTgTuh+t+s+YpN8dZvDMITKC+Goo5DyJpnziYyYHmQT6lqIOkk
         Kw31sXiwTwZ16G2BNeBvpnAwAErwjWQjPSXfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=82cQoga8U3JP4qIyKPTCCko0vtq+GBfnMIGH3HnHvw4=;
        b=m97GDEYuLfUY8wcmlwJ6MPZ+nce8eQ9a0CeO2wa6XewbK/pLDFIvG2P9ZTUQut9vFO
         N9wyz1R1zyWTqYBgp3j06Es+AtbofK3237tzHiok/btSkHrA+T5qZ2+ZV5tFu7k+fmeR
         jmqMXL1Q1TkFQCh/5JoCE0ubby6QKxuL9JbqbuMumfjIxT1XWhUAJBgsfan3pOTPLgv1
         potc57ceNisDYc43LZYmGeAl6YBpWiTz1BemlcJ8/QS5IAi+tMkCB+Jcustwg2qKBMDQ
         pYxU3YcZ8fHjZXGbH9tCZZDHRpoPK2ANj+rw15LNMHK0UlkoIzXsTQU0U2uGEWl7Dq8H
         oI1g==
X-Gm-Message-State: APt69E2sneUokgGWDLdX/WvijDXIoiPr2e4gksctT+oy0iL2dkvUvUQY
        hBVeAKDxjyfB7FI5r166rayqdi2ueHYIqJhevOA2sw==
X-Google-Smtp-Source: ADUXVKLDISrMXX3vKc0GnfZRgZGWDhcLsHt0YhT2yr7AisVA+7e9x1bbGT6GrewtexvTqpOW9yit4e1sr/j7kMOJCLE=
X-Received: by 2002:a81:3b04:: with SMTP id i4-v6mr12837614ywa.38.1529613084443;
 Thu, 21 Jun 2018 13:31:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:31:23
 -0700 (PDT)
In-Reply-To: <20180621100003.GF2847@kuha.fi.intel.com>
References: <20180620182840.GA24775@beast> <20180621100003.GF2847@kuha.fi.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Jun 2018 13:31:23 -0700
X-Google-Sender-Auth: DCytfGXU1c1inZBmTIAbh8SQj5U
Message-ID: <CAGXu5jJ8ROmGh0HorCZhbodhxcCBjze-9TwLEX=iO3D4MqtwTQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tps6598x: Remove VLA usage
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 3:00 AM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Wed, Jun 20, 2018 at 11:28:40AM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> uses the maximum buffer size and adds a sanity check.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/usb/typec/tps6598x.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
>> index 4b4c8d271b27..396193f85e6d 100644
>> --- a/drivers/usb/typec/tps6598x.c
>> +++ b/drivers/usb/typec/tps6598x.c
>> @@ -81,12 +81,17 @@ struct tps6598x {
>>       struct typec_capability typec_cap;
>>  };
>>
>> +#define TPS_MAX_LEN  sizeof(u64)
>
> That is not big enough. The registers of this chip can be as big as 64
> bytes. The identity register alone is 25 bytes, so the above would
> make the driver fail quite fast. Can you set the maximum to 64?
>
> #define TPS_MAX_LEN     64

Oops! Yes, thanks, I missed this usage:

        struct tps6598x_rx_identity_reg id;
...
        ret = tps6598x_block_read(tps, TPS_REG_RX_IDENTITY_SOP,
                                  &id, sizeof(id));

struct tps6598x_rx_identity_reg {
        u8                         status;               /*     0     1 */
        struct usb_pd_identity     identity;             /*     1    12 */
        u32                        vdo[3];               /*    13    12 */

        /* size: 25, cachelines: 1, members: 3 */
        /* last cacheline: 25 bytes */
};

But that's still only 25 bytes. Where is the 64? I see these:

   return tps6598x_block_read(tps, reg, val, sizeof(u16));
   return tps6598x_block_read(tps, reg, val, sizeof(u32));
   return tps6598x_block_read(tps, reg, val, sizeof(u64));
   ret = tps6598x_block_read(tps, TPS_REG_RX_IDENTITY_SOP,
                             &id, sizeof(id));
           ret = tps6598x_block_read(tps, TPS_REG_DATA1,
                                     out_data, out_len);
           ret = tps6598x_block_read(tps, TPS_REG_DATA1, &val, sizeof(u8));

1, 2, 4, 8, 25, and "out_len" in tps6598x_exec_cmd(), which is always zero:

   ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL);
   ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL);

I clearly need a v2 of this patch, but I just want to make sure I get
the right value. :)

Thanks for the review!

-Kees

-- 
Kees Cook
Pixel Security
