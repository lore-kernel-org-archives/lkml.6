Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87683C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DC9241EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWfEyRxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DC9241EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeGBOxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:53:05 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42332 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeGBOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:52:48 -0400
Received: by mail-yw0-f196.google.com with SMTP id y203-v6so5012225ywd.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3+Ookmu90nkOH6FO4lpd86uux+coECHHrZdLu2yEsRY=;
        b=LWfEyRxH9SfMDUOal1yr9jG7wBOCLa9poIYHXp4Sjt7n/I2gVBH9Cwr01e3UGfwy0S
         //lQ76hsKgAsuQ7rSalE+kVuMW++qMODQb7HNGwNzmNesYlomsL2H0/FaYqLw6tbOczp
         OF53SpQj7TQyaTVOvbvZeyPi2Uzr8rMs2gzzSXy/Q4CJV3i5Ww1LkJ4EqLPBHXQnVVOZ
         sv9HSfL7niDWnKzhTjZoRL5O+N/aWNeeuUJpTMu+Wqb6YbNqzeb4SWqHw2NWmRjZ/w4h
         3Ky2wRACAyE/Xn28YEcCeJY/tG9Xd8L9wriigV3jvtAFdu13fksQiXMZ2+IpJOmM+q4i
         lX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+Ookmu90nkOH6FO4lpd86uux+coECHHrZdLu2yEsRY=;
        b=N3lSPfB0AXwFe7hvRsoZEnM8L0TtHbl05HNERgBejsdzIZMNHz+6k2mzMntVkzQal+
         L7Ny394L+36DilzLkNB/6THqU9mtbKvelFBrhNT+fVipD1s7MV+bEtt2pA9S8Z2EI+vn
         usgUry4FG9xmKIjzHXxy98qNatGJF/0B8l2U25CxmEf1QFG354Cvj7hGzc1063ci/6YO
         96ea5DGNjWJeJYcwCqV/f1GfTtpM/F9ABtwzlUblRz1f+6SmOqahL/RnJXNbptIXVP83
         u3sBWRIBF+EFJh8DYMwz39Ah66JQDLfsS2ET+CkFvVxKQojZ9ftD1xx2RsJTKSGsTb7Z
         W1kg==
X-Gm-Message-State: APt69E0y94+GwkcXuB1fpDbSPZ4fAeNb6Dt9KsfwMSEGTtl1Adj+WIR6
        sp/V5PdKST8n2Lj79kgjDg0=
X-Google-Smtp-Source: AAOMgpeYTVpyir9bxVBTyXq3t0VKowlrjU0IFjXBSoslA12rKWUhUwr2BHV9XKDb9REd/3q7l4+BlQ==
X-Received: by 2002:a81:6bc6:: with SMTP id g189-v6mr7997302ywc.267.1530543168139;
        Mon, 02 Jul 2018 07:52:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id o12-v6sm4811168ywj.65.2018.07.02.07.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:52:47 -0700 (PDT)
Date:   Mon, 2 Jul 2018 07:52:46 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: Replace strncpy with memcpy
Message-ID: <20180702145246.GB533219@devbig577.frc2.facebook.com>
References: <1530478633-16486-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530478633-16486-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 01:57:13PM -0700, Guenter Roeck wrote:
> gcc 8.1.0 complains:
> 
> fs/kernfs/symlink.c:91:3: warning:
> 	'strncpy' output truncated before terminating nul copying
> 	as many bytes from a string as its length
> fs/kernfs/symlink.c: In function 'kernfs_iop_get_link':
> fs/kernfs/symlink.c:88:14: note: length computed here
> 
> Using strncpy() is indeed less than perfect since the length of data to
> be copied has already been determined with strlen(). Replace strncpy()
> with memcpy() to address the warning and optimize the code a little.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
