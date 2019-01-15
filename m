Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9520BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C5420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="grvsM9dK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfAOOuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:50:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43292 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfAOOuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:50:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id z18so1656757qkj.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qnDFckL9HEgxWsqHuXvfsjsZTkSE9SSInszW4dnlDLg=;
        b=grvsM9dKTWReCJDrNGbmQMjbcFnEw4mUqUAemzjCIVGPWG48SBWSsBAsWph7vHKkP1
         Nr+IrMD9eBXu5DPja0jpDiBXbPS42SmnWjyRdbjEEYkgx6EpGVQ9j3TUJmEVjngP9Wqd
         QMO1kkpA3M63r5cQIRbanclxFHcpK64Y8zPrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qnDFckL9HEgxWsqHuXvfsjsZTkSE9SSInszW4dnlDLg=;
        b=HZQXmmt7v+GEAWFHYNTTm77DHEsM3kmkkklPj97tU6s2z8fDzpTB8s/3Z1jUQnViyh
         f7pbfQhfunRlaayngjpkBAdRz8aRyVINywEJ5CWaE95FpCT+KAAR2WGkRKAkDO5Fq1n2
         tVvuNARsfGbewHYaUGW85x+1iEeBfz5ebvjKGrWrLi0kIU1s/GtIU0rOEGzapA2a98If
         SHmDyi8QP/BfP1aCBONKd6Qm99kCtDhp0HcCkHq50GCaEnmlb9N1xiUvynwobKiyW4DF
         pQKWA4r3DPzZmkie1vD/gVzxkNpf37cWkZS2BykFwNfsKD2QqL9HbS03lfCUa49uaWEr
         5NgA==
X-Gm-Message-State: AJcUukeF5n8r4mqoEQxJO1PyQxsB+Zk0qqURxDR62jMtV67H7PncgjyC
        7zBIx9/LEt/CL1eCYb/8VBrbug==
X-Google-Smtp-Source: ALg8bN4vpzoR+DvSzwhEgUlpGDi3XiDundNQ72igkEUWlvsUkzjwKSPH+sjCxjJdKZuoO0Ym15q5vA==
X-Received: by 2002:a37:7885:: with SMTP id t127mr3017116qkc.323.1547563807693;
        Tue, 15 Jan 2019 06:50:07 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cfd0:d2ee:d54d:ab6d])
        by smtp.gmail.com with ESMTPSA id a17sm45422148qth.93.2019.01.15.06.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:50:05 -0800 (PST)
Date:   Tue, 15 Jan 2019 09:50:05 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dancol@google.com,
        minchan@kernel.org, Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 2/2] selftests/memfd: Add tests for
 F_SEAL_FUTURE_WRITE seal
Message-ID: <20190115145005.GC36681@google.com>
References: <20190112203816.85534-1-joel@joelfernandes.org>
 <20190112203816.85534-3-joel@joelfernandes.org>
 <f9ffb7f8-1ff8-3bec-ce79-f9322d8715dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ffb7f8-1ff8-3bec-ce79-f9322d8715dc@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 06:39:59PM -0700, shuah wrote:
> On 1/12/19 1:38 PM, Joel Fernandes wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Add tests to verify sealing memfds with the F_SEAL_FUTURE_WRITE works as
> > expected.
> > 
> > Cc: dancol@google.com
> > Cc: minchan@kernel.org
> > Cc: Jann Horn <jannh@google.com>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> 
> Looks good to me. For selftest part of the series:
> 
> Reviewed-by: Shuah Khan <shuah@kernel.org>

Thanks!

John, could you provide your Reviewed-by again for patch 1/2 ? I had dropped
it since the patch had some more changes.

thanks,

 - Joel

