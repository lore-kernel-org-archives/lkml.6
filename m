Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3817F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Y99yKRU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3817F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIZA5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:57:53 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34880 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeIZA5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:57:52 -0400
Received: by mail-lj1-f175.google.com with SMTP id j25-v6so2756901ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=K+CK6/JK9NoS9LCQtCqUtUy7XYEtjbTk8RCaxRN4oyE=;
        b=Y99yKRU8OYFLs1oRnTxs9nuJ08/zPcQ/amAv5irASRyI+hUTb8nEcYtGn9npD50dCm
         qcks4RGJKKvVqjUaiPI0vri85XV9lMVn+2MllusuLDe0HBTSi3hjG19sQRIrssgXdlFy
         uxiOFAihbWSEoxCfN8P++FD3110am6YdlEXHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=K+CK6/JK9NoS9LCQtCqUtUy7XYEtjbTk8RCaxRN4oyE=;
        b=QuZqEdQcvWXNyf6PE/fzSEpAuXczhVZQwsEePDchMktn0COiVML0KAIAO+7HaBjDZu
         pdHQ3SBzDDfGi2xWGyaw5Ewhp3p+Vtxx9d+7+tVmV8IkAcfiFrfCkqliM6WF5A9A+eu+
         MnIB+GaIogiCE01BGh0hUm/0W/0p5/NTX21Q8fO99HckaKNrIMovMfS5AAr/4RtYaEJz
         +FCQrtHHEsztxDhBW7XRs/Zwc1+yX2YewOg5/KcRbhhP1EJBvNboLKfk6JGIujiotkMW
         fJfppzAfWjjr66uu1T8Mur2xA8EhDcbdh73LUZqhSWpnb5a7EB5b+dzGJL79Suw8xNhq
         qvlg==
X-Gm-Message-State: ABuFfoiOJsUW5PHzHIG5CzUGyrLCbkRuXBopgognwDzzfEMWRsbHzL0A
        MR1z6brN4ZprSpM1jPEEV5Yz8igLehACyzCe5cnTTAFF
X-Google-Smtp-Source: ACcGV62/49yWghhUv2hh/7vN1+YS0HltGPlGAreDJhTXMJhUgHJeQeQc8Dc2HSSLOkDM38j9SekgSW5k7UEkSSD7I4c=
X-Received: by 2002:a2e:7406:: with SMTP id p6-v6mr1979395ljc.5.1537901337869;
 Tue, 25 Sep 2018 11:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180925182601.37421-1-joel@joelfernandes.org>
In-Reply-To: <20180925182601.37421-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Sep 2018 11:48:46 -0700
Message-ID: <CAEXW_YQDmnHRcnEx+H5aOggMqPm8WwfytEKdq_CVp+w0mp5hvw@mail.gmail.com>
Subject: Re: [0/5] rcu doc updates
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:26 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Hi Paul,
> These patches are documentation updates for the rcu_dynticks rolling into
> rcu_data and also the updates to the fact that there's a single rcu_state now.
> Its based on your rcu/dev branch.
>
> Next I'm thinking of tackling 'RCU Callback Handling' and further digging into
> the dyntick handling and then dig into other documents outside of
> Data-Structure that need updates. But let me know any suggestions.
> Thanks!

Apologies that my scripts missed the 'PATCH' prefix. Hopefully that's
Ok for this time, but let me know if you'd like me to resend them!
Thanks!

 - Joel
