Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368F8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D425421480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcqMUxNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D425421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeIZNKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:10:36 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34888 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:10:35 -0400
Received: by mail-lf1-f44.google.com with SMTP id r191-v6so9735909lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tk5+EorbqRhSejz9SAlOnZ7aKWsSouQan+dH1/ISsx0=;
        b=YcqMUxNSqOu05t8ux9Sdp9eQAKVC3EV15wEGAC+IiLRhgbtBe+lQgPUssSYQzGPfMx
         eioy/lOndQsdInRu3MsiLYYqUeenUEPJOJah1hWYGC/Y0gCxRiIO58zUbl1mPEynvQ03
         fqBj2RwGEDwwvzblBGRXr/odwRIEwVJ7klY3iuXrNTJaKIX0HpR85KlRoIrTlCVqySXL
         8liEzS+oEOrMONSah6g3DFAuMVUyxUH918uduQNiOXg/sbKgWCM4YZ6IuEhBSefi8s6h
         rmFYiuikhwIqzGqDkMCCRyvek9ZtzuudFuORfKRgdLpKeaV6Tqwp2xQJp4Lxs8ix31b8
         MD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tk5+EorbqRhSejz9SAlOnZ7aKWsSouQan+dH1/ISsx0=;
        b=Xsk1MMlYvvn9JZQi8NrbiZ4QsT2l1NeCcuoZnoOGktXcSAfNvjf4qVnfkbtiX4SQs8
         2H37YiouFAWh5AAsVW+qEa2/lu5DsIHwg9/0Ss7uPenUckxNtA4FGXYdvzhSUE8WyaqA
         tUpdntNmebwndQYotUdNvzrcAzZNpcPHvRwHuOEJYGyxbb73/JHazp4dcgElnZvS7JA3
         40hXZ/+yGwEGnorXhb5pTxFpl+fdZuj++jORGJENmQBgr6Z2NOZx8VD8g7rv84CEU3mh
         nxsKItbmE/XW8bVZIOg1QmrY9cMjYMNr8KhD1JzLnR/YPG1J8xsg8jRy37uthOYPiRA9
         2cgg==
X-Gm-Message-State: ABuFfoiJH6AzMcNOEh2LaLyUxYk4oX9fpGrJQL6GluLebLgTTGTVvzzi
        PBJDN7QOs6+a7+SEXCIqBrc=
X-Google-Smtp-Source: ACcGV60u7Ku14A9iDdZG07RjQsYpOye8Q2oiaX7zzSTQM6YaKDeyOYEMtf/vNt7GP8vVlQqRPc7CAg==
X-Received: by 2002:a19:a854:: with SMTP id r81-v6mr3045806lfe.70.1537945147690;
        Tue, 25 Sep 2018 23:59:07 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id r82-v6sm453541lfe.37.2018.09.25.23.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 23:59:06 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 283C146065D; Wed, 26 Sep 2018 09:59:06 +0300 (MSK)
Date:   Wed, 26 Sep 2018 09:59:06 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     TongZhang <ztong@vt.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de,
        akpm@linux-foundation.org, linux@dominikbrodowski.net,
        ebiederm@xmission.com, keescook@chromium.org, Dave.Martin@arm.com,
        wolffhardt.schwabe@fau.de, yang.shi@linux.alibaba.com,
        LKML <linux-kernel@vger.kernel.org>, wenbo.s@samsung.com
Subject: Re: different capability from different namespace required for
 prctl_set_mm_exe_file
Message-ID: <20180926065906.GK15710@uranus>
References: <990D0DB4-35C7-4B7B-A938-2B984CD97E78@vt.edu>
 <20180925173745.GA20508@kroah.com>
 <20180925183427.GH15710@uranus>
 <7D0EDE0E-ADFB-4B43-90BB-1845FD0FEAE8@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D0EDE0E-ADFB-4B43-90BB-1845FD0FEAE8@vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:37:14PM -0400, TongZhang wrote:
> I can see there are two problems,
> 
> First: In kernel/sys.c:2117  capable(CAP_SYS_RESOURCE), seems that ns_capable should
> be used to check capability against user namespace, instead of init_user_ns. Because a
> process in a user namespace may call prctl system call and this should be checked against
> their user namespace capability instead of init_user_ns capability.
> 
> Second: They should both require CAP_SYS_RESOURCE or CAP_SYS_ADMIN, is there any particular
> reasons for requiring different privilege?

Yes. We consider changing fields one by one in init_ns as an undesirable action,
mostly because some sysadmins/tools continue relay on this info for monitoring.
And requiring sysadmin here is too much: sysamin can do a way more than just
changing these members. In turn because userns is even more weak than init-ns
we require admin capability instead.

Again: non of the monitoring instrument should rely on the members this prctl
changes, they are not consistent and never was. But we still grip the privileges
here simply to not allow anyone change random members, at least in init-ns.

p.s. pleaase don't top post
