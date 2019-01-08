Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B79C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC072087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnMRl0TK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfAHEr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:47:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45006 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHErY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:47:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so1276697pfh.11;
        Mon, 07 Jan 2019 20:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmEBXxr8tgGn0uAttO01eUtf0eTF6IJNY6XPXurik/s=;
        b=DnMRl0TK71zt4HxzxIECDI3ovxU8s1nPDeEErqgYhAMRJQwFAlKYxgA4tgBaRSGqLG
         VRF4HkeqIm1Q9SM/dNnjwDrD3u3t9dsR14XP+0jkhhUM1xpZ73PwutDWx+hjwrargHJf
         8mTNlCl4HX5tFWe4Zwgfq0+XYn9xksBtVwC7TeNfhdZmEcmNU7nUTM2JuBJ1eRQK47Sx
         ZQcNRSQWYxSGM8iAqKNZvd7maiBALXEuVM9tiTXv0klIYyCScYHjWppMu/ej7vraPqZE
         IgyDdm2TiA2j+VALNMMynWdNt0zjKDwEskGclLp3bvxw4b3F1vNRltCrLgb1xhJHsEKK
         fv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmEBXxr8tgGn0uAttO01eUtf0eTF6IJNY6XPXurik/s=;
        b=Nf1adwdTWJs6lTJRpfzLWQ/5D7cHdTAdyPhIY7nGho4xzL1J/H5IeoNBx8Ey3tMssq
         GFW//dauwrhTcsZVHypk6X7h6Rm7QSPcuuONNsjpTDwbLuKxzkD6gNyZ8TFHC9tLpOC5
         uham47z4cQuMiYN0SKI6ln67Oi2LGtgqZmcZJWIiDBQ9rC3B0HjBiPmoSanWUDkLpQix
         sOQjwYbYwuwWFNABj5Ypik5vrWHm7TaVIOysoT3aVWIzjFXCQF5bkwFWjtioO5/XmeOV
         oiGBWCgeSBiuUVm/+vQ3Y4mkrsD77nYqdF/HmjivMEF0/0ahujZFFLXszxiU0KkwqeI4
         Y/fA==
X-Gm-Message-State: AJcUukftZeKds1gg5tPK8zVCtjQMLPL20VdNTBzQYzRkb+HceZqG+BQp
        2dHUYw4Zu/zSDpLGHkCtCWk=
X-Google-Smtp-Source: ALg8bN7qf5lPIEcMJDl9qTk4M2FVEhh5ojBPq1oYKoKvmR9eYmToey3WSXWwy/wa6IfHjnstOzPLdw==
X-Received: by 2002:a63:a30a:: with SMTP id s10mr236594pge.234.1546922843732;
        Mon, 07 Jan 2019 20:47:23 -0800 (PST)
Received: from localhost ([39.7.51.153])
        by smtp.gmail.com with ESMTPSA id g185sm95159728pfc.174.2019.01.07.20.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 20:47:22 -0800 (PST)
Date:   Tue, 8 Jan 2019 13:47:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 01/13] work-simple: drop a shit statement in
 SWORK_EVENT_PENDING
Message-ID: <20190108044719.GA19275@jagdpanzerIV>
References: <20190107195252.599921907@goodmis.org>
 <20190107195331.608898679@goodmis.org>
 <20190108030623.GA6619@jagdpanzerIV>
 <20190107222634.381bfbd0@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107222634.381bfbd0@vmware.local.home>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/07/19 22:26), Steven Rostedt wrote:
> > On (01/07/19 14:52), Steven Rostedt wrote:
> > > Subject: [PATCH RT 01/13] work-simple: drop a shit statement in SWORK_EVENT_PENDING  
> > 
> > 						shift?
> 
> Yes. And I noticed this typo after I sent out the list. It appears that
> Sebastian's keyboard has a faulty 'f' key, as he has made this typo
> more than once.

I think Sebastian can configure his emacs to interpret a long
spacebar hold as 'f' key [0].

[0] https://imgs.xkcd.com/comics/workflow.png

	-ss
