Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC6121471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="y3oC2qnj";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="QjS3mbQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC6121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeIRSpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:45:50 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:53462 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729665AbeIRSpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:45:50 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w8IDCcQQ021393
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:13:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=d6yTFU47ZvqfU4CHIMo7UanWGFPxlPQJKLOGF2l8R6I=;
 b=y3oC2qnjsCgucOt2ALfz/XYd4yvgOt3fMkaqarDC/gvV47x1d0I7dFDNI9fDtL403lJ+
 8Dl01M3cpdZlqOUhtKNqSPuIzIWosE2NnbPxHrxf+u0qyjMC3u2vAeFHwG8DdVkz7eqv
 9xk1xXgMoUJrjd2SO3eEvK5UqL22jwO1+Tdda3bdmDKwyJzrjXNauAHMKd+Iaoe02KgD
 CcJuj2YelmHt1DlcYrem7+f4lk8TA17cRr+Z3zyv0AofNIV7uP4IISZ0yGAKL4lnwDzR
 7GMXQg5yeLrftXgUetOuFjkmqTA8B3TwRFsKpt9gtLEAjpQ/KQuVTIJBJmKJg8FZRex4 qQ== 
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        by mx08-00252a01.pphosted.com with ESMTP id 2mgxu79hcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:13:16 +0100
Received: by mail-wr1-f69.google.com with SMTP id y32-v6so1897372wrd.19
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d6yTFU47ZvqfU4CHIMo7UanWGFPxlPQJKLOGF2l8R6I=;
        b=QjS3mbQBBAFRMftE3yKu7btmQMU7cVvtaWZKDZPkTvcHkwxWq1W7QptiDecESvfMeY
         KQLkGVADEkTynkOSYj0QbC4jPMBHhZ4XiIEfwZYCkfGDS73fDxOIAz73HkMMLzs/Xcg1
         vCxAq8LeZm4lwR4RcMY/nUgyNy1iYOGJwTVRVPuV7npU5y9I3nOnVehoJjQMTcIBnQ20
         qAJNwrEgUpECBXL275KEOPTn9S9CKHCP+fZIE86reP4osnzu5ohN5sT4XAVMnvOnz5Wc
         fXD6E1h2aQ7OV4/igCYgDMLB9Fmx5wNaQYun1IwDAnInJFXeU7nV4DJc5O3kPMl+L76S
         Ep4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d6yTFU47ZvqfU4CHIMo7UanWGFPxlPQJKLOGF2l8R6I=;
        b=i0eIcFSXfm3vUOQxmhh4kjKbZ9py8PwGUDhaBKUn3H0XLY00ylqC0N4Fn4STWUY6bd
         1jGMp7uIq11JT+YBZYPuVPIZ9xw5+f2L+bMp+ZaJwES8lRXGTqLmNiImE+Do63vY6BIu
         m47l0toOKd8WvChauF8gvLP200PWMY+5bTnXAV/GSh/5AZzV+ZUTZKW8CSnQgwh+U/Lf
         ecEiWz3Jn5PrJP11hH9UZeK9D5csba+MjbmsWLFB8ck6pte0zCRXQ/UuQpJQWr0ktCYa
         k/k2B4IXivh6U1AwXlVfMfGs/rhBUbw9SJP1vmRY37wB6XacXYm6UpXy3CJxA8gBVIIR
         ajPw==
X-Gm-Message-State: APzg51BUG8qz9lozpKM/0uDeU69kbpHD4gulHS7hrPF0psISg0rO6hoH
        grGH424DS58CISE9Q04nCiminwOfiTCkvXQNwg7gMy2hJ4lQ1+3Ukjx0BDVZtVEaa1AgMhrx3mh
        mxlKWwX+cdW7XS/xwIephjcXn
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr24200793wra.100.1537276395524;
        Tue, 18 Sep 2018 06:13:15 -0700 (PDT)
X-Google-Smtp-Source: ANB0Vda0tzYYNYgf5DDvjSPkVpzn/5WlwgPHR8bcxIuPSJr9/I7H6kJnp/1fGTNJXgLdiiFGhAloPw==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr24200751wra.100.1537276395129;
        Tue, 18 Sep 2018 06:13:15 -0700 (PDT)
Received: from ?IPv6:2a00:2381:fdf7:14:8894:d0fa:7bb0:10fe? ([2a00:2381:fdf7:14:8894:d0fa:7bb0:10fe])
        by smtp.gmail.com with ESMTPSA id d18-v6sm1324913wmb.33.2018.09.18.06.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 06:13:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] sc16is7xx: Fix for multi-channel stall
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
References: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
 <1536762716-30673-2-git-send-email-phil@raspberrypi.org>
 <20180918130243.GA25253@kroah.com>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <07ee2375-382c-154a-4c47-abb1a81b3351@raspberrypi.org>
Date:   Tue, 18 Sep 2018 14:13:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918130243.GA25253@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 18/09/2018 14:02, Greg Kroah-Hartman wrote:
> On Wed, Sep 12, 2018 at 03:31:55PM +0100, Phil Elwell wrote:
>> The SC16IS752 is a dual-channel device. The two channels are largely
>> independent, but the IRQ signals are wired together as an open-drain,
>> active low signal which will be driven low while either of the
>> channels requires attention, which can be for significant periods of
>> time until operations complete and the interrupt can be acknowledged.
>> In that respect it is should be treated as a true level-sensitive IRQ.
>>
>> The kernel, however, needs to be able to exit interrupt context in
>> order to use I2C or SPI to access the device registers (which may
>> involve sleeping).  Therefore the interrupt needs to be masked out or
>> paused in some way.
>>
>> The usual way to manage sleeping from within an interrupt handler
>> is to use a threaded interrupt handler - a regular interrupt routine
>> does the minimum amount of work needed to triage the interrupt before
>> waking the interrupt service thread. If the threaded IRQ is marked as
>> IRQF_ONESHOT the kernel will automatically mask out the interrupt
>> until the thread runs to completion. The sc16is7xx driver used to
>> use a threaded IRQ, but a patch switched to using a kthread_worker
>> in order to set realtime priorities on the handler thread and for
>> other optimisations. The end result is non-threaded IRQ that
>> schedules some work then returns IRQ_HANDLED, making the kernel
>> think that all IRQ processing has completed.
>>
>> The work-around to prevent a constant stream of interrupts is to
>> mark the interrupt as edge-sensitive rather than level-sensitive,
>> but interpreting an active-low source as a falling-edge source
>> requires care to prevent a total cessation of interrupts. Whereas
>> an edge-triggering source will generate a new edge for every interrupt
>> condition a level-triggering source will keep the signal at the
>> interrupting level until it no longer requires attention; in other
>> words, the host won't see another edge until all interrupt conditions
>> are cleared. It is therefore vital that the interrupt handler does not
>> exit with an outstanding interrupt condition, otherwise the kernel
>> will not receive another interrupt unless some other operation causes
>> the interrupt state on the device to be cleared.
>>
>> The existing sc16is7xx driver has a very simple interrupt "thread"
>> (kthread_work job) that processes interrupts on each channel in turn
>> until there are no more. If both channels are active and the first
>> channel starts interrupting while the handler for the second channel
>> is running then it will not be detected and an IRQ stall ensues. This
>> could be handled easily if there was a shared IRQ status register, or
>> a convenient way to determine if the IRQ had been deasserted for any
>> length of time, but both appear to be lacking.
>>
>> Avoid this problem (or at least make it much less likely to happen)
>> by reducing the granularity of per-channel interrupt processing
>> to one condition per iteration, only exiting the overall loop when
>> both channels are no longer interrupting.
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> ---
>>  drivers/tty/serial/sc16is7xx.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>> index 243c960..47b4115 100644
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -657,7 +657,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>>  		uart_write_wakeup(port);
>>  }
>>  
>> -static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
>> +static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
>>  {
>>  	struct uart_port *port = &s->p[portno].port;
>>  
>> @@ -666,7 +666,7 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
>>  
>>  		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
>>  		if (iir & SC16IS7XX_IIR_NO_INT_BIT)
>> -			break;
>> +			return false;
>>  
>>  		iir &= SC16IS7XX_IIR_ID_MASK;
>>  
>> @@ -688,16 +688,23 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
>>  					    port->line, iir);
>>  			break;
>>  		}
>> -	} while (1);
>> +	} while (0);
>> +	return true;
>>  }
>>  
>>  static void sc16is7xx_ist(struct kthread_work *ws)
>>  {
>>  	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
>> -	int i;
>>  
>> -	for (i = 0; i < s->devtype->nr_uart; ++i)
>> -		sc16is7xx_port_irq(s, i);
>> +	while (1) {
>> +		bool keep_polling = false;
>> +		int i;
>> +
>> +		for (i = 0; i < s->devtype->nr_uart; ++i)
>> +			keep_polling |= sc16is7xx_port_irq(s, i);
>> +		if (!keep_polling)
>> +			break;
> 
> This makes me worried, there is no "timeout" now?  What happens if this
> never happens, will you just sit and spin forever?  What prevents that?

The patch is keeping to the spirit of the original, which also has a
potentially infinite loop (in sc16is7xx_port_irq) - this just moves it
up one level.

I could add a limit on the number of iterations, but if the limit is ever hit,
leading to an early exit, the port is basically dead because it will never
receive another interrupt.

Phil
