Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25259ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A46206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYElH5xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A46206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeIRPMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:12:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45540 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbeIRPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:12:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so732512pfo.12;
        Tue, 18 Sep 2018 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VbvpOHjrehBMtZm6KUAslq27yOK+2BZYUex61xRcLQ=;
        b=dYElH5xuZPNxi7QC2nWwm7xAwDmqZtX4eKMTG26urJjC92A8Haq284pYEmAF1HT/6k
         D5E8OrLnNjpVdk0Xzcfjq6MDxGlr7QqzAMcmJ9QDHE2LsbKtP2KDRZVtjqpadoqotziK
         07oCSwiDjIoDK3YZ3uOEhM6UYnVmrQS3oOh5h3Iffbapv9APjLOorW4WHA6Rco6KOOjT
         SJ2l+lUFyELFKeIyKbRuavp3ILlU5iPY6edvR/WHF28onQ27AI5MDxaKPUHAaWQHubBB
         aygdqwsAqqn3cqKqOxOMiQFXpr4djDRzbSjr6WuBnztCXHK6VxugWvEWSStcN6hereY5
         1M5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VbvpOHjrehBMtZm6KUAslq27yOK+2BZYUex61xRcLQ=;
        b=rxk8g01MPsml59ILmbmp9VuwmRcZ0zWO4aMhCXpTrMEOSv+GckvwQ8wwIMbAHOjQPb
         yPfUkNZHf3uqaOMjLuhChVg5drYraXY8fUYamdVpXeeiW+6Imp1DNgrq3GIgi2QuYdWO
         SJyXT5qz7Keue7CwXEu/yX1zF6nvm51N7puRCWab8UF/l3rzSdYxyXXfRXMibkVHkq7L
         BX3hEoRsgvO+/YKkoQkqQHJFlmFPJEtcUJYWkEHHIVIWNT8F1abGyk91Ar1T75kfAhm3
         DuEzPOlMKTZkRmNcuoS2Kt77XJZ+vi4Tjpnl60xVVSbZppGrbsZo/FUl4Og+s/5+XnYa
         QoCg==
X-Gm-Message-State: APzg51BiphoZKrgCNnyciD+IurxiKKpzZyb3OoYaX6Ywmu259J6DQ9f/
        jAm9UrzCugx5/srCQhus65g=
X-Google-Smtp-Source: ANB0VdY1YGbbmzxxeBqfi6whBFX4vFCwn85LzQwzdkEkbb6Qc0H7QcoO3dYy8wg3m2OTTNCZC8aP+Q==
X-Received: by 2002:a63:d244:: with SMTP id t4-v6mr26575429pgi.335.1537263658790;
        Tue, 18 Sep 2018 02:40:58 -0700 (PDT)
Received: from localhost ([110.70.59.176])
        by smtp.gmail.com with ESMTPSA id v20-v6sm36721623pfk.12.2018.09.18.02.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 02:40:57 -0700 (PDT)
Date:   Tue, 18 Sep 2018 18:40:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180918094053.GA417@jagdpanzerIV>
References: <20180911220743.GA13208@roeck-us.net>
 <20180911174641.GA15149@roeck-us.net>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
 <27113.1536702746@warthog.procyon.org.uk>
 <32382.1536707855@warthog.procyon.org.uk>
 <20180911235403.GA10107@roeck-us.net>
 <20180918090722.GA463@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918090722.GA463@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/18 18:07), Sergey Senozhatsky wrote:
> emergency_remount()
>  do_emergency_remount()
>   do_emergency_remount_callback()
>    reconfigure_super()
> 
> At fc->ops dereference:
> 
>  981         if (fc->ops->reconfigure) {
> 		^^^^^^^^^
>  982                 retval = fc->ops->reconfigure(fc);
>  983                 if (retval == 0) {
>  984                         security_sb_reconfigure(fc);
> 
> 
> So the check either better be
> 
> 	if (fc->ops && fc->ops->reconfigure)

I guess I was pretty lucky to have leading zeroes in that fc.

David, do you want to add a macro which would make `struct fs_context fc'
misuse less possible? There are 3 users right now who don't use
vfs_new_fs_context(), and none of them appear to properly set all of
`struct fs_context fc' members. This can cause problems in the future,
right?

fs/namespace.c: struct fs_context fc = {
fs/super.c:                     struct fs_context fc = {
fs/super.c:     struct fs_context fc = {

	-ss
