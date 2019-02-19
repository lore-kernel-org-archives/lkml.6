Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12618C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0BC2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550586469;
	bh=3869wbbmoblp/Qgedjy7+VR7uUPl5XvZpW2jQTpDvMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tU4pz1OrDIqBWiB35dM9A/1nbYeI+icCyg+EmcJ8fIqNzSIZJv9gi8He2sSX0G/GO
	 Ok9TvC/Am7/hiHCvUt3Z1TTDZw3piYpb25XjMV8gDKDxbPkWv83La1nWl+kmBi26Dd
	 sCG55+XpgHaWwFHW4Kpp+1JyLuwv+6DvXRsdU80A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfBSO1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:27:48 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41741 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfBSO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:27:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id q128so7808948ywg.8;
        Tue, 19 Feb 2019 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HlWDL69fGUB2hXNN5vwXu3zttVL9vpZ9zstLdQC687k=;
        b=oKzmVeCLjaHjrMjixMvB/v4ZX6hjRdcSXQSiY87El836UYu1WQlQSirC6kQ1Gx+W51
         BAsoUGV/6aUNgh6xtwafYsKRhMVZdlJJWvZjVCdUrSSyBjFZPx+Gm34QL/lOcBafA+n9
         oqJ9s6EzddGWbwRgtBEdcoEXkBLQyPTqIHQmTQUK0hwDW7EoWprBg/8RD+KtyUv2u8Sx
         Kaeeqwhnp7hLID7HrrxssxeMLbhFrYryDiEO11OidwzdtXkd96v450Ouqo94gGTtxCJE
         k0SguYPcXboULDKlgi/9LpuqbnTnqeYaM2s1ndthbw1pA8/eaCa09/6V/+zlE0agtB0s
         o0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HlWDL69fGUB2hXNN5vwXu3zttVL9vpZ9zstLdQC687k=;
        b=PTahA6h0K1aXy/QXUpNujtIcBfYQ6x3nFVRBeaBF2tF2XgGX5D4zWOn0arGk3bJaa+
         gUVY+v7eph3s6YMqDz326oAwEbclrFOLeNbS94Gj4Jve+0D+DjPTTkbHhVMSlCiZPNcS
         W5fkyTwIlcFDAE+sne0WpHhHoPcjYjnq/6vUicQpklFSsSi/tVPGMpdyMlt8IzOoiePI
         kpL17fqvjbW69rcnNn/ICAJzZTb6lUoe8g9HEMSzzqDl6H2ZH/RraMqfKV7Ib8nM/mML
         P6hqjmrZHwA1FUQaXkFabV7+OY1BE05tYdw9UnMr9kAYgoztTFuWtDQvMQgNGchN7FBN
         uQFQ==
X-Gm-Message-State: AHQUAuYyygTJVY4YKe+08tevXLPw0lld/TRT4tZCctOBGrYzWFt2Ce9p
        UU2wkQl11NETzmsv1aHb1K0=
X-Google-Smtp-Source: AHgI3IbK5wWuVLeuPNmeJrSie4VSk5KX42HOSHokhyEKVl0XKT/gMQ+gpi+fIgxWu4mJ025XdkqdqQ==
X-Received: by 2002:a0d:d705:: with SMTP id z5mr23698253ywd.400.1550586467170;
        Tue, 19 Feb 2019 06:27:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:2c70])
        by smtp.gmail.com with ESMTPSA id m65sm96011ywb.46.2019.02.19.06.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 06:27:45 -0800 (PST)
Date:   Tue, 19 Feb 2019 06:27:44 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: remove unused task_has_mempolicy()
Message-ID: <20190219142744.GV50184@devbig004.ftw2.facebook.com>
References: <1550471291-4327-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550471291-4327-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 03:28:11PM +0900, Masahiro Yamada wrote:
> This is a remnant of commit 5f155f27cb7f ("mm, cpuset: always use
> seqlock when changing task's nodemask").
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to cgroup/for-5.0.

Thanks.

-- 
tejun
