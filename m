Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7D3C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12C820834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK6aIGGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12C820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLCQRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:17:19 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:38116 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeLCQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:17:18 -0500
Received: by mail-yw1-f47.google.com with SMTP id i20so5609869ywc.5;
        Mon, 03 Dec 2018 08:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y9j3PhmycYw6Qr1C9EO/9ht1q/JW9XQqu6X+2fdt+eE=;
        b=FK6aIGGXfd4GzHu+5VcLQc17PnjRnWyavIN+cclCpGigX1eY04H3IaHixevNcYdrIV
         CbaUQEVfobLySM5+4jHCAJABP26EZ1mAxFk3Gb1geQlOQt38QDRK2dsMPJysPzrNQGL3
         OylTo833d5NjdRqThEQ2H3Spg2CJXKUoJvrnFusBN5pvw5kqpWvRAw/0FhNl5/8UUFSI
         e8rI87deBXkjFMm34nUakxXZXvpylsw6gPlJmSNOd3+9hwf3wfekA+HnOs5aiQ4xQ2I6
         7A0O7gHBosNewqjcTCBIKF0/kP9e0rKpr3jgDS4G+MjG6KHdzj2CxHqf0O6e+NXQHK+F
         HQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9j3PhmycYw6Qr1C9EO/9ht1q/JW9XQqu6X+2fdt+eE=;
        b=iYHb/Aaqjj57KrwBZj/wbAvuFyE27to0EVU3uKm8wTdcV6srGExBmtHj6EKje9+deB
         XUhytdSDYzx2SoqoMVoxbA1Yv5rqpneOVdtn4oP8vVYcahrx/UyyPJXpv+Hv7k7KUgV/
         1qLmBust+5Gy8h4i4LoAwtuVGr0NM+Lm72WulwQcLURanB/lA69+NVDvDkWzK5sScbHK
         ovh80tBjahkVebSCkRks+LCkUDXoqM9W7ytWSXn3TY/zYGRCaelRQFrOC6NtjleDzTgc
         g5KegPe++2S/lKm/oGNU21KpRg5C1Vf52bv4NBN1+mROTPp7ZiKuhceWjvy78olGwBbY
         vr3g==
X-Gm-Message-State: AA+aEWb4NySN2puskPLTnt3FDwrestVx3wtDk3ySaM/k6otYyVMC2+79
        nCJ2Zll4vILOR+Czwz4MiAk=
X-Google-Smtp-Source: AFSGD/XoHAA6VtIkLEuYRvOJ+rBZOyXfLPsV9EEIublSRxW81Id6MAZPO8vlZyVlErYS4V3ipg8IcA==
X-Received: by 2002:a81:4412:: with SMTP id r18mr16279713ywa.204.1543853828897;
        Mon, 03 Dec 2018 08:17:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:20d7])
        by smtp.gmail.com with ESMTPSA id n16sm5936001ywn.31.2018.12.03.08.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 08:17:08 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:17:06 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v4 3/7] cgroup: protect cgroup->nr_(dying_)descendants by
 css_set_lock
Message-ID: <20181203161706.GL2509588@devbig004.ftw2.facebook.com>
References: <20181130234745.6756-1-guro@fb.com>
 <20181130234745.6756-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130234745.6756-4-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:47:41PM -0800, Roman Gushchin wrote:
> +	 * nr_descendants and nr_dying_descendants are protected
> +	 * by cgroup_mutex and css_set_lock.

Can you be a bit more specific - hold both for writes, either for
reads.

Thanks.

-- 
tejun
