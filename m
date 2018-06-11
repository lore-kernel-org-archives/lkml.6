Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id G630ESSXHltWPAAAmS7hNA
	; Mon, 11 Jun 2018 15:37:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DB86060792; Mon, 11 Jun 2018 15:37:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTrLihGs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 553A9601C3;
	Mon, 11 Jun 2018 15:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 553A9601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeFKPht (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:37:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40381 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753999AbeFKPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:37:48 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so12529101plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OW0BF0whTRRqArbVd0wrhpf0NrDr/wJmtbx2es4h8mQ=;
        b=BTrLihGsKccw11BqHR9AWZQ+Btk1reaWywaSnanbAli3qleuTttO/M+zUjWll/V4HK
         gPvv4zCKZYXvQU/0HCa1RNkAi/wXTA2H/lwtHaevhd54Rjm1rtCArfsomT3SPMbw1+rY
         py1uaDGDbV6kHgu5fV+gM6wgeHdRG4eSrbkdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OW0BF0whTRRqArbVd0wrhpf0NrDr/wJmtbx2es4h8mQ=;
        b=M16uft4WCDQkwWdroe09xPidwXVQIlNU9MX9dNy/33yHiaezUdiqNHYdsIAvWqPvb1
         SKhMv5Txt2bjbYMWln5WZc+sXVrSgw82ikptJp/n0VacyQQ4h+rHSVRq3UQVl7790Me7
         5/px9zTcYxwebBTtQYEqFmJAMaffQ8EEz1WjFdrmDgNMp527fSaBfz0EY4zriHOxkkbP
         KVeCJhwBAmIkxdDsk6J+JFHZ/20juc/HqGTnlrOIFjc5CMNaeYSI6Uph+kjvcR+N6n+g
         UFFgx1qcDpFBR9Gy+OwPH5ouaXl1pT9cROjAuKXVEANbjT/6sfrhaqYIRBsfpzKpS4X5
         JJUg==
X-Gm-Message-State: APt69E0WSkrDXJ1Uy/g3RT+zw7prUkR9bLyKTRfBTkrT6XgiChgRja+3
        qXxLLdB36q+eG7zjydx+ODenbA==
X-Google-Smtp-Source: ADUXVKIHT3TVrnzgWR5OAQpJ3/rTsNgtWFHhZpBf/ridKq/higQp6M5UPXRo0ib6+NkpefFOCuKn2Q==
X-Received: by 2002:a17:902:be0b:: with SMTP id r11-v6mr19612408pls.182.1528731467691;
        Mon, 11 Jun 2018 08:37:47 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j11-v6sm107586850pff.64.2018.06.11.08.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:37:46 -0700 (PDT)
Date: Mon, 11 Jun 2018 09:37:44 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: jagadish tirumala <t.jag587@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH fixed coding style error in drivers/bluetooth/hci_serdev.c
Message-ID: <20180611153744.GA8246@xps15>
References: <2a6059f5-e3f8-9a15-1319-f1189fdd4d83@gmail.com>
 <07c1607e-e75a-967e-c007-329832306936@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c1607e-e75a-967e-c007-329832306936@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 08:15:13AM -0700, jagadish tirumala wrote:
> 
> HI , This is Jagdish , I have fixed a coding style ERROR: space required
> before the open parenthesis in drivers/bluetooth/hci_serdev.c , please
> have a look
> 
> Jagdish
> 
> 
>

Hello Jagdish,

I am afraid your patch has several problems and won't be considered (nor
accepted) by the community.  First the patch can't be an attachment to an email
- please see how patches are posted on the kernel mailing list and use a tool
 like "git send-email".

Second you need to send the patch to the maintainers and CC the kernel mailing
list.  Otherwise it is very unlikey the person who is supposed to look at your
patch will actually do so.  A tool like script/get_maintainer.pl will help you
with that.

> From 3c3e844d0f0ba49a6d40a7265548f81316f756e4 Mon Sep 17 00:00:00 2001
> From: Jagdish587 <t.jag587@gmail.com>
> Date: Sun, 10 Jun 2018 04:15:53 -0700
> Subject: [PATCH 1/1] fixed coding style error

We can do better here.  git log --oneline -10 drivers/bluetooth/hci_serdev.c
will give you examples of the title other people have given to their patches
when submitting fix that touch this file.

> 
> Signed-off-by: Jagdish587 <t.jag587@gmail.com>

This needs to be the name you would use to sign documents.

I suggest you familiarise yourself with chapter 1 to 8 in
Documentation/process/.  This will save you a lot of time.

Mathieu

> ---
>  drivers/bluetooth/hci_serdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index aa2543b..d41c520 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -94,7 +94,7 @@ static void hci_uart_write_work(struct work_struct *work)
>  			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
>  			kfree_skb(skb);
>  		}
> -	} while(test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
> +	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
>  
>  	clear_bit(HCI_UART_SENDING, &hu->tx_state);
>  }
> -- 
> 2.7.4
> 
> 
> 
