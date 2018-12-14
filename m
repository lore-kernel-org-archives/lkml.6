Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE23C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734FA2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544793386;
	bh=Z+xAcd4frTGEdfEEHnYUNZf2L8gwVyRJOQ46jIdOmtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o1rFptzb83Yg+uaDhKLmKSLjE+yk5xnXwLPEC9OaNJJ33O5czSTgFjTwb0m2Nqc4v
	 /6ZXkT1CbXYxS6Rph5ZRcgn2dQ8rCFMa+ESo9NT1MysV7YXdeNUG09U37fX0e1L3GW
	 Rbc6GOLQqM93SqMhUz3nCA9v+89ha5kL5bA6iaH4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734FA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbeLNNQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:16:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41007 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLNNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:16:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so4217643lfj.8;
        Fri, 14 Dec 2018 05:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=06f7NYDTPHHMECJ/UTvSYrbixyLA1o/6j1CMcmcz16s=;
        b=cONOX9QIWDEJq1EFioCtT1hZU4uI2CucPpuI7cwsWlTOusTd3CcH/SytHOd8C1SLLk
         eskys7NUF4QDCKt0besiXj00CZmniJQNtYpzE4/ExB98wxwoELLKkm0Yid9yJKNCJFfE
         vk8dHws8J6yZ1p67Vq6x0/7AJ89tw3SmKrMA4bp2oWc5g/vqZxz8tryMlNINDLRZ+CpC
         JjZ2T46RB5gbYryakmqcnuZ9MGfqUxikVyEPNCDANgj1AYWjWG3uz8KjDX8N0S/BrrDr
         6Rl4PMviRWPpECB78RvTtyVD8FcpqS+/R/tXvKN75x5xEB5oefs5qntv5EaILe/2ofFD
         jBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=06f7NYDTPHHMECJ/UTvSYrbixyLA1o/6j1CMcmcz16s=;
        b=V73LnNp1R2ZzVuyYWLDsredUt4Cy3QDlOn4TY7IX1elwkqUGQq4GZVst6weeeVO4mv
         Tu0jHM0Wajo4mz+84WYfs2p+mcQ6T3hnjz5We5mZHe3LaCOiqci+W2iVsWUqhsj4NR6K
         K68TYJoaJk3uooNbwE7mK3C/mGZTqoMFx72lYAXJYF/NiONINgMBAz6OT4JD0rh6kzz4
         UjL/1jxalJ30u9ZKtrpgelvNWcTbqInVSUPPZv3VFgznbMt72HuIJCD1dksnQmuh3mSt
         f1QLH57wOc3XMtvWdvrM6AUcIH+rkxOwAbwQS9BYQIl3I0sJ7617B22ywMgq//sTwxnU
         jJ7w==
X-Gm-Message-State: AA+aEWYDOQlw/tk5W79FoB1lKQyCLU/0fLze/95eQR3HXhq/O5j1r5vB
        KSIx7m+ub58MTsOJzZPAdjUwCw9k
X-Google-Smtp-Source: AFSGD/XZaNU5stvXgphSmrJi71D6EEdzE00S1Y1SfiAdqHWtUo5IwdU06w9OO80YSUcXjDGpOF2imQ==
X-Received: by 2002:a19:c203:: with SMTP id l3mr1751212lfc.113.1544793382891;
        Fri, 14 Dec 2018 05:16:22 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u26-v6sm833203lji.22.2018.12.14.05.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 05:16:20 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gXnKF-0007qB-3I; Fri, 14 Dec 2018 14:16:19 +0100
Date:   Fri, 14 Dec 2018 14:16:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v3 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20181214131619.GD20658@localhost>
References: <20181130150247.26294-1-bgodavar@codeaurora.org>
 <20181130150247.26294-2-bgodavar@codeaurora.org>
 <20181205062503.GG18087@localhost>
 <c9bcbaed89a18499fe42463b20367499@codeaurora.org>
 <20181212164251.GI3500@localhost>
 <53775e90cb3803cee9cfff2325cb7429@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53775e90cb3803cee9cfff2325cb7429@codeaurora.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:02:40PM +0530, Balakrishna Godavarthi wrote:
> Hi Johan,
> 
> On 2018-12-12 22:12, Johan Hovold wrote:
> > On Thu, Dec 06, 2018 at 04:10:07PM +0530, Balakrishna Godavarthi wrote:

> >> uart_write_wakeup()->ttyport_write_wakeup()->serdev_controller_write_wakeup()->hci_uart_write_wakeup()->hci_uart_tx_wakeup()
> >> 
> >>          the above is flow when serdev_device_write() is called, it is
> >> indirectly calling serdev_write_wakeup().
> > 
> > No, serdev_device_write_wakeup() is currently not called in this path,
> > which means you cannot use serdev_device_write().
> > 
> >>          Why actual we need to call an serdev_write_wakeup() is this
> >> wakeup related to the UART port or for the BT chip.
> > 
> > serdev_device_write_wakeup() is where a writer blocked on a full write
> > buffer in serdev_device_write() is woken up.
> > 
> > Johan
> 
> Is it preferred to use and serdev_device_write_buf() followed by 
> serdev_device_wait_until_sent()

That's up to the driver author and depends on what you want to achieve.

If you want to do something synchronously, you always have to call
serdev_device_wait_until_sent() after, as both serdev_device_write_buf()
and serdev_device_write() only buffer the data.

If you use serdev_device_write_buf() you also have to make sure that you
can handle incomplete buffering yourself (e.g. when the underlying tty
driver buffer is getting full).

serdev_device_write() was added as a convenience helper for this, but
depends on serdev_device_write_wakeup() being called in the write_wakeup
path to make forward progress.

> or do we required an write_wakeup() called before writing into 
> serdev_device_write_buf()

No, that doesn't make any sense. serdev_device_write_wakeup() needs to
be called in the write-wakeup path, but only if you use
serdev_device_write().

Please see the documentation of these function that I added to
linux-next (and that I linked to earlier).

Johan
