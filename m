Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B09C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAEA218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546445805;
	bh=t3BilsQ1crkX31VxdoS1ut+E3Yi0Ko97YozgFp6CGEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h8PhG5WY9hPmWyM+embIdz/T0fi/BgNZyY6bAteM5G47m6LKVHaqtr/mvEvCOtmVV
	 +cfj4mDDxgRgfy7InxTJGsKOdbVKq2l/umzbcjcSPfHip/AF+JPVwJPlpLHvMtOx8I
	 ixtvtPw4e3ubDFwgv/4BfANkpO7rKfgOqEarQ7L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfABQQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:16:44 -0500
Received: from mail-yw1-f51.google.com ([209.85.161.51]:41069 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfABQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:16:44 -0500
Received: by mail-yw1-f51.google.com with SMTP id f65so12190116ywc.8;
        Wed, 02 Jan 2019 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=495vRgiGxo8CriZ4Xnf6rDvwm/NSTnoCm4J6MTqAB4o=;
        b=iFdbDhiTWYAa+FVWrjVr87Vz2pCvr5PvMHx2ccOG9cCkNqQvRITSAjhszcOAXgQSBo
         YvO4wdv2cxQ2GRE+gvCIB13T77jW/NVLfaG8vnvQNSm/G0DK7hKcZcmLikT3wVZUsDWJ
         f3upVIbAwbfz9mleIP/wxqIF1JexifJLs19hGe7HT1nOqaRzHHnVaOcRdEnbukZ0egKy
         8rs1ORiRQ4sP8wZEG6eElkH2CeX3WrxrpO+ejaEBJ+G9Ky4XtvwePCCnjQ9KVIcoGdlo
         yPjd6bf7a31+rOXkJ96/+CBVXpO5xbRSTyj4JyVIwCLclMcRnJWDpFOR+B/NA88pL6T5
         DPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=495vRgiGxo8CriZ4Xnf6rDvwm/NSTnoCm4J6MTqAB4o=;
        b=SVLMecvNKGs81I+GGinJSQ6wI4F6H/z+asim90FExRqV2HOkt1pCJdnkL7CssYygMZ
         yle7gg5njLtqV+zZV5jVVWRWZQRdMcCig3pxu/aTqHvK3QVJI+H49Vz3Z5+H8JdNcIbr
         8kPJg02sm4Xo7tKaAeiHu5Zl86C+7lMFsaxPB/13vZXyYdhO1G5e/OBaQznaCNCA2vTF
         /UGN9WM1NXPTNJpbldlodIOHNhBP0dfsbvJ3j+cvUS+jC90De3EjdX8Jb8RrFbHFBPM8
         K1MgzczC9Z6KuMYncEfP7P2xAmV63ZTlRiz766L/ryWJ15zKL5xCdwHoL2LMBsW8/6OV
         MlvA==
X-Gm-Message-State: AA+aEWYfTuOb3WlFm8FmbX/djq51/9q9er7U6CdnrSWy3+eQ8fKyrqEm
        H6Zny6sMmGM83prJ89ixUDU=
X-Google-Smtp-Source: AFSGD/X7ukjKrfL6esgfnpirWxzTq373DcvasZf8KS0r0Ya+fmOgIrE/zDX2Nciso6iw/hKfRAW5oA==
X-Received: by 2002:a0d:f102:: with SMTP id a2mr45363187ywf.186.1546445803173;
        Wed, 02 Jan 2019 08:16:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:f03d])
        by smtp.gmail.com with ESMTPSA id j12sm19475552ywk.43.2019.01.02.08.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:16:42 -0800 (PST)
Date:   Wed, 2 Jan 2019 08:16:40 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Zefan Li <lizefan@huawei.com>,
        syzbot <syzbot+87b93137e0280beaeba1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING: lock held when returning to user space in grab_super
Message-ID: <20190102161640.GS2509588@devbig004.ftw2.facebook.com>
References: <000000000000638c1b057e787822@google.com>
 <a6e8d929-3765-ad70-0f7c-942b68d7b25c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e8d929-3765-ad70-0f7c-942b68d7b25c@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Happy new year, Tetsuo.

On Wed, Jan 02, 2019 at 09:08:56PM +0900, Tetsuo Handa wrote:
> According to commit 633feee310de6b6c ("cgroup: refactor mount path and
> clearly distinguish v1 and v2 paths"), cgroup_do_mount() is failing to
> do full teardown steps for kernfs_mount() (deactivate_locked_super() ?)
> when kernfs_node_dentry() failed.

Hmm... that's basically dget()'ing the root dentry of the sb.  I'm not
sure how that could fail.  Can it?

Thanks.

-- 
tejun
