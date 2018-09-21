Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9186DECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DF120858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJlMBCRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DF120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbeIUPJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:09:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39245 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:09:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so11003283lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CrDKWm3aqHfKMpDRnRbXQnIaHBikxzxR1rfYN6raYgk=;
        b=kJlMBCRdwyecf82zT+oxExNEcno/iImcBCfiVuMe1wQlaL+LOweIrw++neBN5hKmb5
         +S87Ri/58XM01ifvb70qIeBffdsTmd7b28aQCoDMXTGYDffAqeICug+SCQhSc32FR1YQ
         ATpimiJ4GkYwqiQR346JGaxzJ8zT4oyCdX2iGPwJDoHReddOw2+0qujLOPblW5cHtpqZ
         UsC4N7aUjd1/4US1JewNBAfRZ2YQtcSlnFUxEtw8iRV11TUQSGI+S+DgMHqQmKiJuTCC
         Fun8Uf28thyF2YXeyV+Ym0RJD3kgN2Iy4hcatw5iZNM511CrWTA0YasSWYeWsZiCmfI7
         xSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CrDKWm3aqHfKMpDRnRbXQnIaHBikxzxR1rfYN6raYgk=;
        b=ZX+1nCcgMWx6ER6mS1se7Z0eaEZ2qJAzT6K3llEt1+piP0nw6nX4CfiXOB3rwc3n4H
         KVI8oTAnqAH3YvQPjuo8GeTb95YpHwAmDaI1D/Tc5+SkeW7IdmEnrwlRF6XvpwTr05hY
         4f4nEmPG4mbXzqomJWNi+ISuJmXDqxvzzDWYS/Eey6ThrMh5Z6vrqnjwXa+Tlt6Sj1dx
         MTlO72GBuyd250a52ZriKvrXETeJBo6xgTK3wf0EB+PH/CsLwiyUImvSeP347aqhLpN+
         BIA409S/7ub5oHe0LbtfE45dkYGWeJMCqZYJh3WTOGBIcMkJtPtA1P9FZhub9aIvZBxh
         JKBA==
X-Gm-Message-State: ABuFfojvUo3O9PzKibhKsyQE2vst0E51Y+9aueH9pINglHjIu8wFOfmb
        QVD00MFY16exjERETFV7e68=
X-Google-Smtp-Source: ACcGV63yhBj9kmY2xUPAqS5//1TbIvzwYcNPOvJIaOlM2BQd+aNXuMnNAZzf4A1WjxYEoHhqwXZlOg==
X-Received: by 2002:a2e:240c:: with SMTP id k12-v6mr1166036ljk.135.1537521715214;
        Fri, 21 Sep 2018 02:21:55 -0700 (PDT)
Received: from kbp1-dhp-f54120 ([195.238.93.39])
        by smtp.gmail.com with ESMTPSA id w18-v6sm4753209ljd.73.2018.09.21.02.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 02:21:54 -0700 (PDT)
Date:   Fri, 21 Sep 2018 12:21:35 +0300
From:   Nick Simonov <nicksimonovv@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     oleksandr_andrushchenko@epam.com, alsa-devel@alsa-project.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: xen-front: Refine indentations and constify
 snd_pcm_ops
Message-ID: <20180921092135.GA20633@kbp1-dhp-f54120>
Reply-To: s5ha7obuyuw.wl-tiwai@suse.de
References: <20180921054514.GA11771@nick>
 <s5ha7obuyuw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s5ha7obuyuw.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:51:51AM +0200, Takashi Iwai wrote:
> On Fri, 21 Sep 2018 07:47:38 +0200,
> Nick Simonov wrote:
> > 
> > snd_pcm_ops are not supposed to change. So mark the
> > non-const structs as const. Also, refine indentation
> > to increase readability.
> > 
> > Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
> > ---
> > Changes v2:
> > - Fix typo in commit description, ncrease to increase.
> 
> Since I already merged your first version, please resubmit as an
> incremental patch.  At best, check the latest linux-next or my
> sound.git tree for-next branch, and create a patch on its top.
> 
> 
> thanks,
> 
> Takashi

Sorry I want to clarify, there is no mistakes in the code itself
there is a typo in commit message. As I now there is no way to change
commit message without rebase after merge, so which is the proper way in
this case? leave it as is?

Thanks,

Nick

