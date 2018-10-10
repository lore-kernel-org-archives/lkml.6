Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CDF2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="YbkSOozh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CDF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJJQkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:40:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:40:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so4858436wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sdX5s3PMClvx96LzmrzDEiVzosymhg4ArBBd02bkTtc=;
        b=YbkSOozhx5eA3FEE8B+lXarR1kWaZyb4ExixjDBVp6m767GbvqRQYLa4p8BgYeL43X
         RgP6lBG2TWujzj6+VI72WOSXb0U6thmXVIjlO7hgMZXwx33tKv75NyG1WR3ZuJt5mwYS
         OeCRGPPkbh9+BS/Ogto4qLsA4VixoEVsX5vleLsFpkHDoso2OOBRy6rrvVUZgusBYcb4
         Hrl5/IgDqNtHEFM1jGfnUSF8RdfzYRvGLNNz1WBfC4HIHr76e2meRhmpKpNq/9nT6a6R
         v8sw9M7mQDI+WTkRO5UpFS6KcyXdcAvOvaLR4JDR7/mGL8KHfhsOABMsP3+dL6CWpP2R
         duHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sdX5s3PMClvx96LzmrzDEiVzosymhg4ArBBd02bkTtc=;
        b=JeDfLu3CkU/VJMV1TYhTL8G7DNczQhkJ0/L3Z5MWeACkQwHBx9UUHkWv6cI/Cip4wj
         AKzZsnKHi21i+t5TY8jfpIj5PwvKO8Gl+SsdG3fYCEum4xJ8/Sr7fFY2R73uF9qEQ93p
         JUQmJNeIAud8iJOo3tQWZ7oT95R1kXk/v2vfglHssUr/Sgvg5NQnInxTZAm6SUOcVCQu
         olfg/g47BxkS4C8vG4VISExD+NaRyMuNN1RYc1kzBt9ftkfxO1fpDsVi1aB6mvEWM3Ar
         S4I8R+HQStD8aivN4EakLCAK31KCzhdjOvR2QK36mH7J0WIvHh4hsuinVG1IiLk2r/ic
         AVQQ==
X-Gm-Message-State: ABuFfoiDLI7JCb0bnzMnkd/0NLAKRkxjLJYcp/2ChRZjvNgD/coM5+0p
        XT3/t7c+Da/Vb73hNHZMTb+ODfOfwL4=
X-Google-Smtp-Source: ACcGV60r07Yp31hMmjbrJnAL3S9YpxfklFDzKLINEFSaMPWc9Xv6hvUjMq7z64ANdR3K0Eq2W+sWDg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7-v6mr21691832wrp.229.1539163163611;
        Wed, 10 Oct 2018 02:19:23 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id 16-v6sm25728729wrb.95.2018.10.10.02.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 02:19:23 -0700 (PDT)
Date:   Wed, 10 Oct 2018 11:13:58 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
Message-ID: <20181010091358.GB5027@nanopsycho.orion>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006065819.GD3061@nanopsycho.orion>
 <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pKvUOaAHhe7gb3yH4jdkdTtLv+gUqdnh3bJZcN776UWQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Oct 07, 2018 at 07:26:47PM CEST, Jason@zx2c4.com wrote:
>Hi Jiri,
>
>On Sat, Oct 6, 2018 at 9:03 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >+
>> >+      wg->incoming_handshakes_worker =
>> >+              wg_packet_alloc_percpu_multicore_worker(
>> >+                              wg_packet_handshake_receive_worker, wg);
>> >+      if (!wg->incoming_handshakes_worker)
>> >+              goto error_2;
>>
>>
>> Please consider renaming the label to "what went wrong". In this case,
>> it would be "err_alloc_worker".
>>
>>
>> >+
>> >+      wg->handshake_receive_wq = alloc_workqueue("wg-kex-%s",
>> >+                      WQ_CPU_INTENSIVE | WQ_FREEZABLE, 0, dev->name);
>> >+      if (!wg->handshake_receive_wq)
>> >+              goto error_3;
>> >+
>> >+      wg->handshake_send_wq = alloc_workqueue("wg-kex-%s",
>> >+                      WQ_UNBOUND | WQ_FREEZABLE, 0, dev->name);
>> >+      if (!wg->handshake_send_wq)
>> >+              goto error_4;
>> >+
>> >+      wg->packet_crypt_wq = alloc_workqueue("wg-crypt-%s",
>> >+                      WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM, 0, dev->name);
>> >+      if (!wg->packet_crypt_wq)
>> >+              goto error_5;
>> >+
>> >+      if (wg_packet_queue_init(&wg->encrypt_queue, wg_packet_encrypt_worker,
>> >+                               true, MAX_QUEUED_PACKETS) < 0)
>>
>> You need to have "int err" and always in cases like this to do:
>> err = wg_packet_queue_init()
>> if (err)
>>         goto err_*
>>
>>
>> >+              goto error_6;
>> >+
>> >+      if (wg_packet_queue_init(&wg->decrypt_queue, wg_packet_decrypt_worker,
>> >+                               true, MAX_QUEUED_PACKETS) < 0)
>> >+              goto error_7;
>> >+
>> >+      ret = wg_ratelimiter_init();
>> >+      if (ret < 0)
>> >+              goto error_8;
>> >+
>> >+      ret = register_netdevice(dev);
>> >+      if (ret < 0)
>> >+              goto error_9;
>> >+
>> >+      list_add(&wg->device_list, &device_list);
>> >+
>> >+      /* We wait until the end to assign priv_destructor, so that
>> >+       * register_netdevice doesn't call it for us if it fails.
>> >+       */
>> >+      dev->priv_destructor = destruct;
>> >+
>> >+      pr_debug("%s: Interface created\n", dev->name);
>> >+      return ret;
>> >+
>> >+error_9:
>> >+      wg_ratelimiter_uninit();
>> >+error_8:
>> >+      wg_packet_queue_free(&wg->decrypt_queue, true);
>> >+error_7:
>> >+      wg_packet_queue_free(&wg->encrypt_queue, true);
>> >+error_6:
>> >+      destroy_workqueue(wg->packet_crypt_wq);
>> >+error_5:
>> >+      destroy_workqueue(wg->handshake_send_wq);
>> >+error_4:
>> >+      destroy_workqueue(wg->handshake_receive_wq);
>> >+error_3:
>> >+      free_percpu(wg->incoming_handshakes_worker);
>> >+error_2:
>> >+      free_percpu(dev->tstats);
>> >+error_1:
>> >+      return ret;
>> >+}
>
>I'll change away from using error_9,8,7,6,5,4,3,2,1 because of your
>suggestion -- and because it's the norm in the kernel to use real
>names. But, I would be interested in your opinion on the numerical
>errors' reasoning for existing in the first place. The idea was that
>with so many different failure cases that need to cascade in the
>correct order, it's much easier to visually inspect that it's been
>done right by observing up top 1,2,3,4,5,6,7,8,9 and at the bottom
>9,8,7,6,5,4,3,2,1, rather than having to store in my brain's limited
>stack space what each name pertains to and keep track of the ordering
>and such. In light of that, do you still think that following the
>convention of textual error labels is a good match here? Again, I'm
>changing this for v8, but I am nonetheless curious about what you
>think.

I think it is perfectly readable when you have:

	err = do_thing_x();
	if (err)
		goto err_do_thing_x;


err_do_thing_x;

Rest of the code (at least in netdev subtree) uses this a lot.

>
>Jason
