Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7747C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDD7208BA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XZZDiMjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDD7208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeHBCRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:17:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42366 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeHBCRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:17:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so282420edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHsOAJS7Oj99qFEeZdx5tkmey/K0wawQYzb7PSk3Gwo=;
        b=XZZDiMjNPUXLcV2WQo7bunL9b4Vp1E0wj+NHBnRATwkBCTOpJV+G02gU3qgr3LmtjK
         Lpctm/WOqx7WqXey/hn4VYETxyT3b+hAaDOF7M8iiTgi9ZX4aXPMFec1nsAQ1c9yVfaH
         GLApp/p34RMoI8a3l2E7QJ0iaME+cu340IWRvPp3Hh8wGxkOYaN1b8ebMU/B0MAPnr7K
         6r4VFQyI/5VKkQsKYDnZDqX623QLH0t5zqmoyVwrmrc5xs4+u7Y17dSFXX4YJjrTbRke
         5FWhWQ7BdYNJy4x92U9Q/m+HmqF/sLeqQbqlbeU8d2SmfqPgQtedcce5AufHp5FAOF+G
         YX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHsOAJS7Oj99qFEeZdx5tkmey/K0wawQYzb7PSk3Gwo=;
        b=g39ZMnF/x84k9qI6ou3lNIcoJEe/qTOF7Q2V6T8RKDVnLDwSO2fd5YR1Q6ajkUxsl5
         7axLuTqS7ZbOG5rswu3wGVuvIVtfiGq1RzOQN7C+9B6tuuS277fMFIfkWPVJq/CaDXv+
         qxZyGHGZH9AB81K0oNlAxDN4pu21a8YYT2Mg2OSG8ukZqCsUn7EK/EAQd9888n2zKyB6
         mM78gxRqN3/bR3P4KxBkB03+/PPtNWFORmuy9Af3DE5TgcZUFR9k0HR+Vmct4vcwQC1F
         vi4UXmxjLlb0MtEYqIQEGgwAczA/4dVrcBMYELqMwvp0i/3qc1Eq5LqPnuCO7owHdnNv
         asng==
X-Gm-Message-State: AOUpUlFgk5Y8KtHq7t5xnD5OTUtUbSxT4Mr0GVYz2nvtjCZXaEAc9OYY
        YsbbsypTpQiq6lM8zKUmCJ2AaA==
X-Google-Smtp-Source: AAOMgpdycIxtddjPQcy7oXQrJidfgsoY2Jh1BhA9NaU1ewCE1sGe/ZemxRoPnH7eDdVwCFrLErgvxA==
X-Received: by 2002:aa7:d5d6:: with SMTP id d22-v6mr842138eds.161.1533169748011;
        Wed, 01 Aug 2018 17:29:08 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e20-v6sm248413eds.20.2018.08.01.17.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 17:29:07 -0700 (PDT)
Message-ID: <1533169746.2679.130.camel@arista.com>
Subject: Re: [PATCH] mm/selftest: Add MAP_POPULATE test
From:   Dmitry Safonov <dima@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hua Zhong <hzhong@arista.com>, Shuah Khan <shuah@kernel.org>,
        Stuart Ritchie <sritchie@arista.com>,
        linux-kselftest@vger.kernel.org
Date:   Thu, 02 Aug 2018 01:29:06 +0100
In-Reply-To: <20180801171224.562aa07efc6b1612d6d6b23f@linux-foundation.org>
References: <20180801233636.29354-1-dima@arista.com>
         <20180801171224.562aa07efc6b1612d6d6b23f@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 17:12 -0700, Andrew Morton wrote:
> On Thu,  2 Aug 2018 00:36:36 +0100 Dmitry Safonov <dima@arista.com>
> wrote:
> 
> > As many other projects, we use some shmalloc allocator.
> > At some point we need to make a part of allocated pages back
> > private to
> > process. And it should be populated straight away.
> > Check that (MAP_PRIVATE | MAP_POPULATE) actually copies the private
> > page.
> > 
> > ...
> > 
> > --- /dev/null
> > +++ b/tools/testing/selftests/vm/map_populate.c
> > 
> > ...
> > 
> > +#define BUG_ON(condition, description)				
> > 	\
> > +	do {							
> > 	\
> > +		if (condition) {					
> > \
> > +			fprintf(stderr, "[FAIL]\t%s:%d\t%s:%s\n",
> > __func__, \
> > +				__LINE__, (description),
> > strerror(errno)); \
> > +			exit(1);					
> > \
> > +		}							
> > \
> > +	} while (0)
> 
> This is userspace.   Why not use assert()?

I wanted to print errno too. Of cause it's possible to get it from
coredump - but I think it's easier if you get buildbot reply to see
what the error is from the log.

> 
> > 
> > ...
> > 
> > +int main(int argc, char **argv)
> > +{
> > +	int sock[2], child, ret;
> > +	FILE *ftmp;
> > +	unsigned long *smap;
> > +
> > +	ftmp = tmpfile();
> 
> Seems odd to putz around with stdio when you just want the fd. 
> mkstemp(), maybe?

It needs a template and unlink() call.. I can do it.
I initially thought about memfd_create(), can change it that way.
The only downside is that it will be syscall(NR_memfd_create,...)

> 
> > +	BUG_ON(ftmp == 0, "tmpfile()");
> > +
> > +	ret = ftruncate(fileno(ftmp), MMAP_SZ);
> > +	BUG_ON(ret, "ftruncate()");
> > +
> > +	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,
> > +			MAP_SHARED, fileno(ftmp), 0);
> > +	BUG_ON(smap == MAP_FAILED, "mmap()");
> > +
> > +	*smap = 0xdeadbabe;
> > +	/* Probably unnecessary, but let it be. */
> > +	ret = msync(smap, MMAP_SZ, MS_SYNC);
> > +	BUG_ON(ret, "msync()");
> > +
> > +	ret = socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sock);
> > +	BUG_ON(ret, "socketpair()");
> > +
> > +	child = fork();
> > +	BUG_ON(child == -1, "fork()");
> > +
> > +	if (child) {
> > +		ret = close(sock[0]);
> > +		BUG_ON(ret, "close()");
> > +
> > +		return parent_f(sock[1], smap, child);
> > +	}
> > +
> > +	ret = close(sock[1]);
> > +	BUG_ON(ret, "close()");
> > +
> > +	return child_f(sock[0], smap, fileno(ftmp));
> > +}
> > 
> > ...
> > 
