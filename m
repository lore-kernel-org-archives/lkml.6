Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBC8C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE17020989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqwbHJR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE17020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeLMC1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:27:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46650 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:27:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so260189pgp.13;
        Wed, 12 Dec 2018 18:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B30mj1VTeQgMqk/ISecY1mlTAHqqBe/7hdJ8y9OTzQo=;
        b=VqwbHJR7zA1Jg3E08K6blRcxsgZsk4TehQ2xblTx/67GgLUl1vC8BhL1BEAIWTzPle
         VQBZOlPizW+nyE3zeywse7giELsQZ/qoKMElPTzbkyO2OWlCLEdk10PnZan8DwuzHwne
         BPcyzqBFEzJRhQgO4OjrfB9dbPgsL7MWdSaEAiMMZIPKeHtCbFo4DfzC2F0ZMl2pCXg/
         WRgsxfID2OoOTA0TXONRSYmW2vWZa/FAy6+5r49jWfYMywJldFNssTPtO0FwJve0gx8f
         b+7m1pEMaNXMZvZuxqRu0YvYO9yDZVIV51kNEXg104eXaGVt8DLaSxfPxbPzKP2hYbbd
         PTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B30mj1VTeQgMqk/ISecY1mlTAHqqBe/7hdJ8y9OTzQo=;
        b=BlL/yrk+rSBsvBk+UkuVbskpqf6OMqZD2O+/WurOW+IyPWcXd6iNG+Fptnym4AW/VT
         R2yDR05s07Gq6kseDS+2387cNItlH+tK32ALJckRekNoZwqMmwJxM8zTb/BEBifY0GE7
         iwio4cmxAmPmBNcO9VVsMTlAsVKSsU2FCSX7eVgK06WhFh4OFvKIeClJmMccRgbsMdZR
         0Z/05svR/h2EusSrcCJYydRgOdr3v95T6UdsP9ZS5+h49E4xAl7Z6xE8aKg/pn0EJn6H
         9h97Oih3dsqAJP4ur8sWcA87HklBXqGphiysxYKZwG44Oc7aXp4VRGJwgCmIvGWnvs6w
         qyVw==
X-Gm-Message-State: AA+aEWbCfrLx4K/U2OulkHWKbS0GTwqbdi3UBYICYXheiiPOWBiYZwb9
        GyV20eLeCZnuTfgbrd4ftwU=
X-Google-Smtp-Source: AFSGD/W4eJNuT96yxtPj9IxPfe8UNSA5IKg+BCbe0kqoow9hjaMFHLoItIDD8CKwjNl/CFB6JNudGA==
X-Received: by 2002:a62:3a04:: with SMTP id h4mr22262641pfa.119.1544668027536;
        Wed, 12 Dec 2018 18:27:07 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id f32sm323076pgf.80.2018.12.12.18.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:27:06 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:27:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181213022703.GD4860@jagdpanzerIV>
References: <20181212081034.GA32687@jagdpanzerIV>
 <20181212133603.yyu2zvw7g454zdqd@pathway.suse.cz>
 <20181212135939.GA10170@tigerII.localdomain>
 <20181212174333.GC2746@sasha-vm>
 <CAJmjG2_zey77QxMzq997ALkD56d0UtHmGjF4dhq=TbEc2gox5A@mail.gmail.com>
 <20181212214337.GD2746@sasha-vm>
 <CAJmjG2_C0YRtVmNh2sg4JqhJJ11LMmbRHqwADxyO9CGh9ixQbA@mail.gmail.com>
 <20181212215225.GE2746@sasha-vm>
 <CAJmjG28s9bz51k=5i8eoKH2crj8e7-qM_EYWMqtUKZ_nGREQOg@mail.gmail.com>
 <CAJmjG29PnAfkUsU4PuVaFvjW-okO=U-MbHZHg7Sj_bBJ6EO09w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmjG29PnAfkUsU4PuVaFvjW-okO=U-MbHZHg7Sj_bBJ6EO09w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 16:40), Daniel Wang wrote:
> In case this was buried in previous messages, the commit I'd like to
> get backported to 4.14 is dbdda842fe96f: printk: Add console owner and
> waiter logic to load balance console writes. But another followup
> patch that fixes a bug in that patch is also required. That is
> c14376de3a1b: printk: Wake klogd when passing console_lock owner.

Additionally, for dbdda842fe96f to work as expected we really
need fd5f7cde1b85d4c. Otherwise printk() can schedule under
console_sem and console_owner, which will deactivate the "load
balance" logic.

	-ss
