Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CC0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1C82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e5ee8ktc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1C82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeHNVWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:22:04 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44719 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeHNVWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:22:03 -0400
Received: by mail-wr1-f53.google.com with SMTP id r16-v6so18006980wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2JzaO4YaxfIJQPRJFexQauhTefoAUb9Tb4X41Uepf88=;
        b=e5ee8ktcz8koxZspRZBdUR1n7UkzN1jQs7oSI8lNIFnAfDuCpuG8gvrBGr0xlvF8DW
         c96kb8IeeADl6HNbPGVJpksxdYpRZxVsiz2LSzvNgpTxZUObti2SraboLXYTZuztnDUX
         wh9P5eVcNtG49HM2hX0NZD10CeTMLtrltfhIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2JzaO4YaxfIJQPRJFexQauhTefoAUb9Tb4X41Uepf88=;
        b=KPe1FmdXBCy9S5q0TCmcNCpopuQ8xda45i1tgnIfCFt5wn78ZJsfRbAzt7sfGvH7Kf
         UAyIOb3m9Mr2yT3YobFl/A+KZkXX59jFJpAPL5WzdSdHyTnDDKePBGiIe7hVVBD0bVRl
         I5ZTVMDVg2u6HPO5LIeNxUMwXkI1CXVoYstySwsuUuQvN3ZqQ6Kh3Q78+iYvkmvKdRDR
         StoWqgJF/MdSBWKti24pdYKHLWWL+pDLcFM1Ig8+fqRVdBaj7lXYlQ/s2FR8GRQy8Hv1
         a9pQxbG1q74nkkdkhqYx52G4CNlb+u50eqfW0kyOMCcoFRSlp/zY2C0V3qwhBfN69dQP
         +oTw==
X-Gm-Message-State: AOUpUlHV1rNVSxiA+pYKbX/uYPPTugxxSywM19qa/kYG4CjoVEe898vF
        CrwSFGrPd6+OSj7JAmGaU3FRxA==
X-Google-Smtp-Source: AA+uWPz4anND7o8euKOe3sbGftNsAiWhMHhKtd/u8TPwQsuVl1YpweKZJN8aO2Mh3pnCVurL6MmBkA==
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr14096335wrf.46.1534271615160;
        Tue, 14 Aug 2018 11:33:35 -0700 (PDT)
Received: from andrea (host47-68-dynamic.36-79-r.retail.telecomitalia.it. [79.36.68.47])
        by smtp.gmail.com with ESMTPSA id u14-v6sm21770815wrs.57.2018.08.14.11.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 11:33:34 -0700 (PDT)
Date:   Tue, 14 Aug 2018 20:33:28 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     JeffyChen <jeffy.chen@rock-chips.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        AL Yu-Chen Cho <acho@suse.com>
Subject: Re: [Question] bluetooth/{bnep,cmtp,hidp}: memory barriers
Message-ID: <20180814183328.GA8874@andrea>
References: <20180730031030.GA9430@andrea>
 <20180813231854.GA173912@ban.mtv.corp.google.com>
 <5B725A12.8050409@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B725A12.8050409@rock-chips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy, Brian,

On Tue, Aug 14, 2018 at 12:26:58PM +0800, JeffyChen wrote:
> Hi guys,
> 
> Thanks for your mails, and sorry for the late response..
> 
> On 08/14/2018 07:18 AM, Brian Norris wrote:
> >
> >commit 5da8e47d849d3d37b14129f038782a095b9ad049
> >Author: Jeffy Chen<jeffy.chen@rock-chips.com>
> >Date:   Tue Jun 27 17:34:44 2017 +0800
> >
> >     Bluetooth: hidp: fix possible might sleep error in hidp_session_thread
> >
> >that*some*  kind of barrier was stuck in there simply as a response to
> >comments like this, that were going away:
> >
> >-                *
> >-                * Note: set_current_state() performs any necessary
> >-                * memory-barriers for us.
> >                  */
> >-               set_current_state(TASK_INTERRUPTIBLE);
> >
> >+               /* Ensure session->terminate is updated */
> >+               smp_mb__before_atomic();
> >
> >
> >It was probably an attempt to fill in the gap for the
> >set_current_state() (and comment) which was being removed. I believe
> >Jeffy originally added more barriers in other places, but I convinced
> >him not to.
> 
> right, i was trying to avoid losing memory-barriers when removing
> set_current_state and changing wake_up_process to wake_up_interruptible.
> 
> and checking these code again, it's true the smp_mb__before_atomic before
> atomic_read is not needed, the smp_mb after atomic_inc(&session->terminate)
> should be enough.
> 
> and as Brian point out, there's already an smp_store_mb at the end of
> wait_woken, i agree we can remove all the smp_mb__{before,after}_atomic() i
> wrongly added :)

Thank you for checking this once again.  I'll send out a patch removing
these barriers shortly.

  Andrea

P.S. I'm out of office for the next two weeks, so my replies could come
with some delay until ~ -rc1...


> 
> >
> >I have to say, I'm not really up-to-speed on the use of manual barriers
> >in Linux (it's much preferable when they're wrapped into higher-level
> >data structures already), but I believe the main intention here is to
> >ensure that any change to 'terminate' that happened during the previous
> >"wait_woken()" would be visible to our atomic_read().
> >
> >Looking into wait_woken(), I'm feeling like none of these additional
> >barriers are necessary at all. I believe wait_woken() handles the
> >visibility issues we care about (that if we were woken for termination,
> >we'll see the terminating condition).
> 
> 
