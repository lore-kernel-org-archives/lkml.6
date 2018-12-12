Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADDEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E19C20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544632974;
	bh=CEfOnDUl2orlVP/IkFeOrJck/rMIS2yqKxZdBlq5o/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GcjvKAstoRJgWe9jKgXi9TNQP/khb2qPBGJTQKa57qpgR1OB2qPxb/XQTwMibnNtu
	 h64sv3tLgsAH24MaR+GpjE1VEDHpAIyZ13td7cJwN6eAr+lJ30dvVote1xXfWvldSv
	 1t81V5ikRZdd6HKch6eOjg7QZ2Z3tCj6ifyJ8JB0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E19C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbeLLQmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:42:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40312 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:42:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so14045964lfe.7;
        Wed, 12 Dec 2018 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5e7CLPwCiJ18XlUvTFdDOWzUy5MIjQbuB+kR/LpYlcA=;
        b=OJ9Z/uW6lxcw5vcYbB95L6WgB7GNoOhPLjMFJh2WRHTVuhvpJOXnDmu8RagnAlR6Wu
         bug7zF792vcvYdgxjjBabzI9LjwCO/LUfdYMolf0LXN/8RoYP20TK5O3WEHvY+mXc8D/
         ajLHiWYALYUJpdEtVPQoFgpgqlJSg61A8G/s/qZMCjif4v4YwIMdthKrnQc9YLinwvhT
         zgP9qA9KQCnpQ3fA7RsfrDPyuA1mkK8v6BEWlswXM3VsIB2IBC2Hut4MLa+WQhKp1SjU
         jcxrnv7Ol62KKepG6QrE9h2hr1zABA+AX0SXR6aRLq7HygCnS1I8HuNFx4UBAk1X+GvG
         cHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5e7CLPwCiJ18XlUvTFdDOWzUy5MIjQbuB+kR/LpYlcA=;
        b=LvT3XBArc7behYccp9f/1OI2llfnvGay1QfiPO8QTaWmSSDP7fz0w8oU6dM/w5Vszn
         eX6vymEdCP2oi4K2Y1k3Q3b6zjg+QtOf9TRW8mnEKVf3jBjYrrIUapwKrlh1SR3h339q
         1YWKL9dpl7vNq+LtKYGRvbNd7ACM4zTLGpfm7gWWKLYB0/xGNrFNPE/lXpQ0uwJPbybo
         azflImrXB11ieTg4ai57mPvZg3WT3WLHTzji5Zep/X/EqS98szljfWfv+aBUN4ydxLjS
         qaRKCD3RdJvhYOA7IghCkTtYEIRjEieNGQuPl1JMrsFsmmv8zMOYxBHGsyr+1LYwd7y9
         KI6A==
X-Gm-Message-State: AA+aEWb+Fb7NApsFPZrqXCdl/MZpa128S7jWZRT6xraIt9bxHvmjf32x
        k5ugKiflFJlbAPGNo7dWOFQ=
X-Google-Smtp-Source: AFSGD/WNZ6o5AKfXfIH6WpFLs5LIkjWt6ayLQuNbt1IiS46qW9t2PaeUBMlHfjPqSNUHAB2EFJkpsQ==
X-Received: by 2002:a19:a086:: with SMTP id j128mr11534328lfe.93.1544632969951;
        Wed, 12 Dec 2018 08:42:49 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v11-v6sm3329313ljc.57.2018.12.12.08.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 08:42:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gX7b1-0005Y6-C7; Wed, 12 Dec 2018 17:42:51 +0100
Date:   Wed, 12 Dec 2018 17:42:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v3 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181212164251.GI3500@localhost>
References: <20181130150247.26294-1-bgodavar@codeaurora.org>
 <20181130150247.26294-2-bgodavar@codeaurora.org>
 <20181205062503.GG18087@localhost>
 <c9bcbaed89a18499fe42463b20367499@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9bcbaed89a18499fe42463b20367499@codeaurora.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 04:10:07PM +0530, Balakrishna Godavarthi wrote:
> Hi Johan,
> 
> On 2018-12-05 11:55, Johan Hovold wrote:
> > On Fri, Nov 30, 2018 at 08:32:44PM +0530, Balakrishna Godavarthi wrote:

> >> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
> > 
> > You're still using 0 as a timeout here which is broken, as I already
> > told you.
> 
> [Bala]: got the change now will update to timeout to non zero value.
> 
> > From 4.21 this will result in an indefinite timeout, but currently
> > implies not to wait for a full write buffer to drain at all.
> > 
> > As I also mentioned, you need to to make sure to call
> > serdev_device_write_wakeup() in the write_wakup() path if you are going
> > to use serdev_device_write() at all.
> 
> [Bala]: this where i am confused.
>          calling serdev_device_write is calling an wakeup internally. 
> below is the flow
> 
>          ttyport_write_buf:
>                * calling serdev_device_write() will call write_buf() in 
> this call we are enabling bit "TTY_DO_WRITE_WAKEUP" and calling write()
>                  i.e. uart_write() where we call in start_tx. this will 
> go to the vendor specific write where in isr we call uart_write_wakeup()
>                  
> https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/qcom_geni_serial.c#L756
> 
>          
> uart_write_wakeup()->ttyport_write_wakeup()->serdev_controller_write_wakeup()->hci_uart_write_wakeup()->hci_uart_tx_wakeup()
> 
>          the above is flow when serdev_device_write() is called, it is 
> indirectly calling serdev_write_wakeup().

No, serdev_device_write_wakeup() is currently not called in this path,
which means you cannot use serdev_device_write().

>          Why actual we need to call an serdev_write_wakeup() is this 
> wakeup related to the UART port or for the BT chip.

serdev_device_write_wakeup() is where a writer blocked on a full write
buffer in serdev_device_write() is woken up. 

Johan
