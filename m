Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A06C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB321901
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4zRDkV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeL1AQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:16:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43507 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeL1AQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:16:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so9723465pfk.10;
        Thu, 27 Dec 2018 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hHcJbN2M+xPqwLGAmxStV/AjJhmEJ9tkcqd4DxOnoT0=;
        b=F4zRDkV5qRtqiMtqukBEs0j6vm6cVMnbolF4GPBh6Sd3YS7aA5Xjb8p/jR7v96lES3
         VRwmEwPsHd3Cl6l0xceHW5xZz8dDTNoZ69xOH65ZH4YFQdhD/PpiW6Vc05YzZbLMvIg+
         BQ1FenTzjTbno+JXLrS1X/hlztwrR+EAtVx84WeuryreZ3sENKZA5wd9CdOobiSAqojx
         wkIISjpYMvYpZKxPM3c0Efp05aK5huygVrcdK0QR55VjLLz1UDX0tPuhfAdNWvJIRMYK
         Fvv5RgLE2/IMIT2CP8xB0P9gDpnqQTRw0AyQ7xmvgM2s4Xh6IvmvuYu0xBj/fVbmNxkK
         7Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHcJbN2M+xPqwLGAmxStV/AjJhmEJ9tkcqd4DxOnoT0=;
        b=egY2pYBMvdAS3txh40tYHeDh15BmJbBsTGTINS+bZWN0YYLPR9RN54jHG9B+4RGWNF
         1HZQ0MQ1MkPXo+mMDPhp+IvXutR0b1WLC7p/SPgYyDEYyjxhKXoNgaoCdwURUZjNesbl
         F2XnqwQ5qI8UfWLXhKUBu1VoftM5I9dIVOdHBL//pNLFGNPk9i1IPx9pIokLkBdl7T7J
         QwB9XIZRb2DPox/GixQIhqP+1ILF5htFFuv12MDhP2ooCYCFVXFloCN6QAtP3FxH1Fqx
         /iy03oEvnJc8bcPfimUOxoaj4MPmthP+VRx+sCQqYcTS54KM9Ge/HlwIqNbl9mNo5QOi
         MS0w==
X-Gm-Message-State: AJcUukd5b8Plgvlbs6YVyv/64A+3QvketSD2TDnxMnTAPiEbhoXAU7uf
        L+Ok72Fjb4T9soArzZaLMqQ=
X-Google-Smtp-Source: ALg8bN4I+INFqap6cDgNSIsy8PSUTPHrnfwi++OGPxGsUiaSKjjse32VBzFUAzXUFI0vxtsR7HL7KA==
X-Received: by 2002:a65:484c:: with SMTP id i12mr24303760pgs.309.1545956216499;
        Thu, 27 Dec 2018 16:16:56 -0800 (PST)
Received: from localhost ([110.70.26.250])
        by smtp.gmail.com with ESMTPSA id g15sm182107997pfj.131.2018.12.27.16.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 16:16:54 -0800 (PST)
Date:   Fri, 28 Dec 2018 09:16:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Daniel Wang <wonderfly@google.com>, Petr Mladek <pmladek@suse.com>,
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
        Peter Feiner <pfeiner@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181228001651.GA514@jagdpanzerIV>
References: <CAJmjG2-e6f6p=pE5uDECMc=W=81SYyGCmoabrC1ePXwL5DFdSw@mail.gmail.com>
 <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
 <20181212081034.GA32687@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212081034.GA32687@jagdpanzerIV>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 17:10), Sergey Senozhatsky wrote:
> And there will be another -stable backport request in a week or so.

The remaining one:

commit c7c3f05e341a9a2bd

	-ss
