Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422FC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AA92082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="dv0A6oS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AA92082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeJ3K4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:56:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37863 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeJ3K4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:56:36 -0400
Received: by mail-io1-f65.google.com with SMTP id k17-v6so6314532ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHjsyUZwkVdffniSG8yBXo3rDvcKss3R2U6JiFgs1Xw=;
        b=dv0A6oS7gxTfAvNXdJHyl2JHYiDRTvytU5e6pLb0lqvUL8qEwMSYhu32jeAiHwduWA
         9mqCMmfHXoxvaQ1IkdELBgLSltxz9DZJ553CKV+jFFPvX8iKTgx1mys4OJXzXYISdW9L
         Qcw53froqjtrlolukPx2LrkfVmad0BjGR7RVQXCJJR+R6cTzE/8mlMWZjcJJPQx3xy/V
         l8BbyEkGCBRpLLwyBaFJcBrLgYV34W0YI6TiP8gcq1PoWakRmIiD+VkOmuUPMOi0ovAo
         cfMHALXYYWaiS1pEgM/RFxL5xI1fHHlVQm8qLa77kP6hpoTxNGE0T7g0AG9MZU6XD487
         Nk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHjsyUZwkVdffniSG8yBXo3rDvcKss3R2U6JiFgs1Xw=;
        b=Y08Tp0MLAA89QoxwG/w7KK6UK0BoPrngQ+aYHZPtU/oPWNTtNWt4tvisUt5MsCsJtV
         0HRpbwkcFqKXVobdt6COyg54IiBF28RQrz+/xPOs+NJNX4ZmEygNevEIBNomFf2j3iWQ
         gTXnj5U7k5yyt+/0YzkD3dVRR1RMPB1UqjIjrm6k1KAN0RhSMcdZdPkX8s7lglWAFFOV
         YLq9+YZw831mI54yiUxVP2kPDeiP2HH+UcJ57VZUndpPAw8Qgv/mRA7LZMhJRZB+7gsr
         7dJb6xWD1dVM/7LODINEleslLVZPZV3jjChDzPZ98RQQtcpKIFQMp2xiIqlBIIXObPAO
         I/QA==
X-Gm-Message-State: AGRZ1gIyw9ncsOZx6qG17F3gCNHFQI1JuI09LbRogtyYZD4lFxQI8hcU
        4k0mp+SlQ0mMttd3lefs4tUcDQ==
X-Google-Smtp-Source: AJdET5dmpUvMs1UmBXV2rMOtnEkuy5s1XVPkwGqODTRQgT3lIwKKorydy01OqGblkAfYblkhimzkDg==
X-Received: by 2002:a6b:5503:: with SMTP id j3-v6mr2253762iob.209.1540865110020;
        Mon, 29 Oct 2018 19:05:10 -0700 (PDT)
Received: from cisco (75-166-175-210.hlrn.qwest.net. [75.166.175.210])
        by smtp.gmail.com with ESMTPSA id d19-v6sm6843650itd.15.2018.10.29.19.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 19:05:09 -0700 (PDT)
Date:   Mon, 29 Oct 2018 20:05:07 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 2/2] samples: add an example of seccomp user trap
Message-ID: <20181030020507.GA7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-3-tycho@tycho.ws>
 <20181029233100.GA24103@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029233100.GA24103@mail.hallyn.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:31:00PM +0000, Serge E. Hallyn wrote:
> On Mon, Oct 29, 2018 at 04:40:31PM -0600, Tycho Andersen wrote:
> > +	if (req->data.nr != __NR_mount) {
> > +		fprintf(stderr, "huh? trapped something besides mknod? %d\n", req->data.nr);
> 
> 'besides mount' ?

Yes, thanks :)

Tycho
