Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687AE20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXEa8a74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687AE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeLJKaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:30:35 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:38595 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJKae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:30:34 -0500
Received: by mail-pg1-f176.google.com with SMTP id g189so4772868pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5mXNQPZLNqPjp+mYt7n1x1em4mFNHRKjNek2SlTy1w=;
        b=jXEa8a741NxbWVRqk2lCTVQXNWHrBTIsyfO002hzpf4JhDkguN6Dscok4GRZWE9Rkr
         ogjQVyHi1qyvhkk3DWmnMgOlOD+sPQa93MFUh6gOnmX7LdAZ7cSrLiGatMX/bYIVF/Nd
         GAR29wB12CQ3CRPbVW4J/DHEWE+ybS/kaS7zE+8CYtwpQZaWjEtGxey4n3e2rqzLKNmC
         BPZhdZsVqB7+OeDc6kv0NMLFwvYlNdZbAIV2iVfXhid7msE+6cKYU7IldM65lFa4de1w
         GAOW7UMQ8d8+cJ0XR+Yx61R0opPVgJDia7Q9tAigipTkPY3KbXeJ29t+cvIgkTGXlCge
         K27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5mXNQPZLNqPjp+mYt7n1x1em4mFNHRKjNek2SlTy1w=;
        b=dd0xUTpjM95pe6kJnIt+yg6/hCqp018zEru7HpxD3EiT5KOdxlf7xrhUEC+fg2otm5
         xEqqyAoZKpmBXva9StORyxI2p0w5YYAdxFz1EtiyjgX15JjCZWtVenRzmiF1Ih6jVppv
         eAq+iGljvr5A3YSJ0lmoEnhEgjU43UsRGo9otPufwxDrydst0Qy8ZeCMGDBca1OXf49A
         EnuvX2HPQf7bOBGE+3GbiWQpxW8r65/gg878daZg0aG3ECs+bqmtUE9x1NqPhwlyyLn9
         zrO1KaKdo2ezQqjlDiVbVcYSKEVKB22Gy2CC/IdOMt8Ig173c4/z+K0BgA1lQHxARTbJ
         oT7w==
X-Gm-Message-State: AA+aEWbmrVVsCUSA7kUVFMcLWsXiY0FRy7pGOH9/0WHY9/e4qHLWSTx2
        ra/YhODZLufDf9/6CFN7ZQs=
X-Google-Smtp-Source: AFSGD/UZtKXxjcg3T/RNSvgAD7K12wL/QK/1mx8zR/ujPEIBmzPJ5BXea0bN1iLS9gGjjraVccBrQQ==
X-Received: by 2002:a63:1560:: with SMTP id 32mr10179424pgv.383.1544437834131;
        Mon, 10 Dec 2018 02:30:34 -0800 (PST)
Received: from localhost ([175.223.21.78])
        by smtp.gmail.com with ESMTPSA id s9sm13905752pgl.88.2018.12.10.02.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 02:30:32 -0800 (PST)
Date:   Mon, 10 Dec 2018 19:30:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Message-ID: <20181210103029.GA29145@jagdpanzerIV>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
 <20181210061151.GA28533@jagdpanzerIV>
 <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/10/18 18:58), Tetsuo Handa wrote:
> >>>> +                */
> >>>> +               if (sysctl_hung_task_panic && !ignore_loglevel)
> >>>> +                       ignore_loglevel = true;
> >>>
> >>> 		console_verbose()?
> >>
> >> Thanks Sergey, it is really my need. I will prepare for a new version of patch:)
> > 
> > Let's wait for people to take a look at this patch first.


> Shouldn't console_verbose() be called like
> 
> +    if (sysctl_hung_task_panic)
> +        console_verbose();

Sure, that was what I meant. IOW console_verbose() instead of
`ignore_loglevel = true' assignment.

	-ss
