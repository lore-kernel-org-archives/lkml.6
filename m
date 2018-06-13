Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C457DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC7C208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksz4CBc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC7C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeFMVrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:47:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33618 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeFMVri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:47:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id e11-v6so1902756pgq.0;
        Wed, 13 Jun 2018 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mnLc0Qd51YQgbM3T5FxLl8Op3Un1auyOIMcBhY5fZk=;
        b=Ksz4CBc1kl0PEj6kVHSn3mCtPJhwo0kV5Q/T+umni/vd1cE+Lqr9DQUBuG8f4qkjhh
         zGDGRktsMDi4vVbRaj4X+n3b2Ixj3Yl7vBGb3mYHveVhUI3672lcjSFs77HWMP2YH+DC
         sLotrFrueYdDaW4irfjT63E20oOH3aPoIco8CtxvWjUOGwb8KaLDNBs7yjGDRCFjFeWD
         1k7FzLXQ4jkwXdrYgEP4i1QOtn6ELXbM01lPMpSCUcof3wQ4IjwcCvIpHWln0X/o1Mu8
         AmLsbmSuQRU1VdvweNKceGb26Lk4svwm6Pivy6ybDKq3KGIE3XGR4ynEIi9zzWFiIb9c
         h+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mnLc0Qd51YQgbM3T5FxLl8Op3Un1auyOIMcBhY5fZk=;
        b=RVZ9MFFe5IC+8vDb0JoYPoHcbOtzXyihE/r11EPsg0Tw3QZAyvIV3M0BM45wiNaHfl
         xSpcdkZu0ta4MuQUyI3WY6bsIKpTVLgsR0emBBFHpfhJQEW2EBDTzYAGDeSHkrqI5aT5
         JnbTQDmG3AaLx2swLOXEfo773EMLeCEHgJmHprxVOpFrmHjZRqdrdnxytRnxRiHIo9kn
         Xqz1//P7LeG3F1roFoGJWRrIr18qrfjfvjXmlVQsV3Ty5n8hoijiS5MMm+Ttgc7EjWIA
         JWBcqz1lekiUi0mUEvy+AL7CTdjJ8gfXTHTrY6eae6TUssR552nAEp4t6qNX31EZMuMT
         lxAQ==
X-Gm-Message-State: APt69E2MNN418slmdwenEXsJpbx72DX4D8V1wFrjse8wXHZwjpH46s7p
        9GffFG9YaM4Ujq6CcTM0kqc=
X-Google-Smtp-Source: ADUXVKKfo8vKabggYkFXVXUoT4jJ9uFBymbPZip/LEKAv7qoE2LEpkOiyWoGFLV6RmL8Cvs8mTGNag==
X-Received: by 2002:a65:6290:: with SMTP id f16-v6mr5554118pgv.155.1528926457753;
        Wed, 13 Jun 2018 14:47:37 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-137-177-220.mycingular.net. [166.137.177.220])
        by smtp.gmail.com with ESMTPSA id s27-v6sm7337409pfk.184.2018.06.13.14.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 14:47:37 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To:     Alan Tull <atull@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <CANk1AXQZ6ax5j9QOrLZA9qT2xGpiU0BQLxAmKQFEqSb6NrbeRQ@mail.gmail.com>
 <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b8c7cd9e-a841-a4b7-2366-6f08328b2b8f@gmail.com>
Date:   Wed, 13 Jun 2018 14:47:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CANk1AXSvVD5x7TKQV_HZm=9Lzeymm5H3p7DZPiAc-RRRxdAOZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/18 07:42, Alan Tull wrote:
> On Tue, Jun 12, 2018 at 1:16 PM, Alan Tull <atull@kernel.org> wrote:
>> On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
>>
>> Hi Frank,
>>
>> I'm investigating a refcount use-after-free warning that happens after
>> overlays are applied, removed, reapplied a few (typically three) times
>> (see below).  This is new in v4.17, didn't happen in v4.16.  As I was
>> investigating I found that rebuilding the phandle_cache after overlays
>> are applied or removed seems to help.
> 
> I was probably wrong about this.  The more I look at the phandle_cache code,
> the more it looks looks good and straightforward.  Probably disabling
> phandle_cache is 'fixing' things through some weird side effect.  I'll
> keep investigating.  Sorry for the noise.

I suspect that you have found an issue, even if it is not the cause of
the refcount issue.  I noted in a reply to v4 of the patch:

  >> +static void of_populate_phandle_cache(void)
  >> +{
  >> +Â Â Â  unsigned long flags;
  >> +Â Â Â  u32 cache_entries;
  >> +Â Â Â  struct device_node *np;
  >> +Â Â Â  u32 phandles = 0;
  >> +
  >> +Â Â Â  raw_spin_lock_irqsave(&devtree_lock, flags);
  >> +
  >> +Â Â Â  kfree(phandle_cache);
  > 
  > I couldn't understood this. Everything else looks good to me.

  I will be adding a call to of_populate_phandle_cache() from the
  devicetree overlay code.  I put the kfree here so that the previous
  cache memory is freed when a new cache is created.
  
  Adding the call from the overlay code is not done in this
  series because I have a patch series modifying overlays and
  I do not want to create a conflict or ordering between that
  series and that patch.  The lack of the call from overlay
  code means that overlay code will gain some of the overhead
  reduction from this patch, but possibly not the entire reduction.

Sorry I'm not giving a link to the archive of this message - I have
a class I have to go to so I don't have enough time to find it.  The
email was

  Subject: Re: [PATCH v3] of: cache phandle nodes to reduce cost of
  of_find_node_by_phandle()
  Date: Fri, 16 Feb 2018 14:20:22 -0800
  Message-ID: <46d5fc76-33e3-d54a-26b8-e9bb8332924d@gmail.com>

Quickly looking at the current code, I don't see the overlay patch
that I mentioned.  I have to dig into what happened to that.

Leaving a phandle from an overlay in the phandle cache after the
overlay is removed would clearly be a bug.

-Frank
