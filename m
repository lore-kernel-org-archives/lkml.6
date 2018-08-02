Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E253C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BD2208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BMFJTCRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BD2208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeHBCNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:13:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44241 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbeHBCNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:13:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so276350edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N77sJmz5aLracaBeSzQjNhZoMjXF6REe1wgC5V/lGL8=;
        b=BMFJTCRBpngN4li68cUhx5eeh/sYErsEMeJHe4MJH+VWcK6A81UmXcruH5K00BvYrm
         vJ6sWqW/sHfcNcjGs3udXe2nj9Z6vMaQuhZZhqGlKIy/SCQEm07Z3LvyplZ2nBm9iFAp
         +mxcVt6U4jOKLzOPQ8i9mErF9T56CE1uvZSb49LFzk75Jp95EmqMPyBrWnjoIlfONbDv
         4Fl+wjh2fiQk9eEet65FZvX28A4Xe0c1NZh2p/zJA7w/xaJuUmjnpohKEtoK170PK9Wy
         TCIGXkN0FUHnznXZ3SRb/RguUBUVYhRYyonq1TlVUQ2GRWPRQEXavq9cxwRA3en6mkQr
         AJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N77sJmz5aLracaBeSzQjNhZoMjXF6REe1wgC5V/lGL8=;
        b=qJstKGH71JAoPjuU9EUubQBoBgPDrEegRNBFi2h2Xt3Ohgs8kX+4MccI2a1gpIbHAI
         yyoqgcs/Rn/ni7gGaw/6lyC5Q0iP7y2tSxeql98nyrOsSAAylu0e7aJC5aw5yuo5Wk7Z
         JtM2YJ3IKZ/nb4RIFmDsp/6vXx/3lz0fAEsFBJua9FIKp/UAQfHjvaqzwuaSAVe9kOfn
         2vnmvlcGWr/+gw1TjBfYvfg7uo4ojrV426Brgwd4umQi1kHG9oGbhe3ipOiZi1asWeCq
         +nSCK2r7thT8h7NINqflU839AFFlKks/QxTfyde+Fi13KZIvV3iBSANHhy2Ys5O0VQL5
         uFrQ==
X-Gm-Message-State: AOUpUlEkfJOHEXX7cPIr1Gj+yLffcbNKzTEgZAtxZGnlIXeBd97OE4/L
        /1jUAUr+SWEZwRagaXb1s11oDgFF3Yo=
X-Google-Smtp-Source: AAOMgpdRCm0USXVu7+r5lKoi9SKZaAj27NOeTEhTSXTgaQz/dgLrlXzpY5icktRG9Stgl2eu7cxpZw==
X-Received: by 2002:a50:d59d:: with SMTP id v29-v6mr860726edi.307.1533169474319;
        Wed, 01 Aug 2018 17:24:34 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j42-v6sm289920eda.2.2018.08.01.17.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 17:24:33 -0700 (PDT)
Message-ID: <1533169472.2679.126.camel@arista.com>
Subject: Re: [PATCH] mm/selftest: Add MAP_POPULATE test
From:   Dmitry Safonov <dima@arista.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hua Zhong <hzhong@arista.com>,
        Stuart Ritchie <sritchie@arista.com>,
        linux-kselftest@vger.kernel.org
Date:   Thu, 02 Aug 2018 01:24:32 +0100
In-Reply-To: <84c3da30-f4fc-b82a-e8fc-49e365e4ac50@kernel.org>
References: <20180801233636.29354-1-dima@arista.com>
         <84c3da30-f4fc-b82a-e8fc-49e365e4ac50@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 18:02 -0600, Shuah Khan wrote:
> Hi Dmitry,

Hi Shuah,

Thanks for the review,

> 
> Thanks for the test. A few comments below.
> 
> On 08/01/2018 05:36 PM, Dmitry Safonov wrote:
> > As many other projects, we use some shmalloc allocator.
> > At some point we need to make a part of allocated pages back
> > private to
> > process. And it should be populated straight away.
> > Check that (MAP_PRIVATE | MAP_POPULATE) actually copies the private
> > page.
> 
> It is not clear from this commit log what this test is doing? It
> would
> be helpful to rephrase.
> 
> "MAP_POPULATE | MAP_PRIVATE memory maps should COW VMA pages. This
> test is
> for verifying that it does" something along the lines??

Uhm, no. COW VMA is just MAP_PRIVATE.
IOW, if you do mmap(MAP_PRIVATE), you need to actually "touch" (call
write() on) the pages to get a copy. Which might be not handy if one
has hundreds of pages in a VMA.
But mmap(MAP_PRIVATE | MAP_POPULATE) should return mapping with already
pre-copied pages, not the COW.

> 
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> > Cc: Hua Zhong <hzhong@arista.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Stuart Ritchie <sritchie@arista.com>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >  tools/testing/selftests/vm/.gitignore     |   1 +
> >  tools/testing/selftests/vm/Makefile       |   1 +
> >  tools/testing/selftests/vm/map_populate.c | 113
> > ++++++++++++++++++++++++++++++
> >  tools/testing/selftests/vm/run_vmtests    |  11 +++
> >  4 files changed, 126 insertions(+)
> >  create mode 100644 tools/testing/selftests/vm/map_populate.c
> > 
> > diff --git a/tools/testing/selftests/vm/.gitignore
> > b/tools/testing/selftests/vm/.gitignore
> > index 342c7bc9dc8c..af5ff83f6d7f 100644
> > --- a/tools/testing/selftests/vm/.gitignore
> > +++ b/tools/testing/selftests/vm/.gitignore
> > @@ -1,6 +1,7 @@
> >  hugepage-mmap
> >  hugepage-shm
> >  map_hugetlb
> > +map_populate
> >  thuge-gen
> >  compaction_test
> >  mlock2-tests
> > diff --git a/tools/testing/selftests/vm/Makefile
> > b/tools/testing/selftests/vm/Makefile
> > index fdefa2295ddc..9881876d2aa0 100644
> > --- a/tools/testing/selftests/vm/Makefile
> > +++ b/tools/testing/selftests/vm/Makefile
> > @@ -12,6 +12,7 @@ TEST_GEN_FILES += gup_benchmark
> >  TEST_GEN_FILES += hugepage-mmap
> >  TEST_GEN_FILES += hugepage-shm
> >  TEST_GEN_FILES += map_hugetlb
> > +TEST_GEN_FILES += map_populate
> >  TEST_GEN_FILES += mlock-random-test
> >  TEST_GEN_FILES += mlock2-tests
> >  TEST_GEN_FILES += on-fault-limit
> > diff --git a/tools/testing/selftests/vm/map_populate.c
> > b/tools/testing/selftests/vm/map_populate.c
> > new file mode 100644
> > index 000000000000..df3eacc8eecb
> > --- /dev/null
> > +++ b/tools/testing/selftests/vm/map_populate.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 Dmitry Safonov, Arista Networks
> > + *
> > + * MAP_POPULATE | MAP_PRIVATE should COW VMA pages.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <sys/mman.h>
> > +#include <sys/socket.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#ifndef MMAP_SZ
> > +#define MMAP_SZ		4096
> > +#endif
> > +
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
> > +
> > +static int parent_f(int sock, unsigned long *smap, int child)
> > +{
> > +	int status, ret;
> > +
> > +	ret = read(sock, &status, sizeof(int));
> > +	BUG_ON(ret <= 0, "read(sock)");
> > +
> > +	*smap = 0x22222BAD;
> > +	ret = msync(smap, MMAP_SZ, MS_SYNC);
> > +	BUG_ON(ret, "msync()");
> > +
> > +	ret = write(sock, &status, sizeof(int));
> > +	BUG_ON(ret <= 0, "write(sock)");
> > +
> > +	waitpid(child, &status, 0);
> > +	BUG_ON(!WIFEXITED(status), "child hasn't suicide by own
> > will");
> 
> What does this mean? Could you rephrase this please?

Sure, I didn't want to write "child hasn't exited" because it sounds
like it still alive.. I can change it to "child in unexpected state"
if that sounds any better?
Or I can check WIFSIGNALED(), WIFSIGNALED(), WIFSTOPPED() too and write
what happened to the child, but it will needlessly blow the code.

> 
> > +
> > +	return WEXITSTATUS(status);
> > +}
> > +
> > +static int child_f(int sock, unsigned long *smap, int fd)
> > +{
> > +	int ret, buf = 0;
> > +
> > +	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_POPULATE, fd, 0);
> > +	BUG_ON(smap == MAP_FAILED, "mmap()");
> > +
> > +	BUG_ON(*smap != 0xdeadbabe, "MAP_PRIVATE | MAP_POPULATE
> > changed file");
> 
> What is expected here? What is expected?

It's expected that the value in file is the same as before remapping it
MAP_PRIVATE (same as parent set initially).

> 
> > +
> > +	ret = write(sock, &buf, sizeof(int));
> > +	BUG_ON(ret <= 0, "write(sock)");
> > +
> > +	ret = read(sock, &buf, sizeof(int));
> > +	BUG_ON(ret <= 0, "read(sock)");
> > +
> > +	BUG_ON(*smap == 0x22222BAD, "MAP_POPULATE didn't COW
> > private page");
> > +	BUG_ON(*smap != 0xdeadbabe, "mapping was corrupted");
> > +
> > +	return 0;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int sock[2], child, ret;
> > +	FILE *ftmp;
> > +	unsigned long *smap;
> > +
> > +	ftmp = tmpfile();
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
> > diff --git a/tools/testing/selftests/vm/run_vmtests
> > b/tools/testing/selftests/vm/run_vmtests
> > index 88cbe5575f0c..584a91ae4a8f 100755
> > --- a/tools/testing/selftests/vm/run_vmtests
> > +++ b/tools/testing/selftests/vm/run_vmtests
> > @@ -168,6 +168,17 @@ else
> >  fi
> >  
> >  echo "--------------------"
> > +echo "running map_populate"
> > +echo "--------------------"
> > +./map_populate
> > +if [ $? -ne 0 ]; then
> > +	echo "[FAIL]"
> > +	exitcode=1
> > +else
> > +	echo "[PASS]"
> > +fi
> > +
> > +echo "--------------------"
> >  echo "running mlock2-tests"
> >  echo "--------------------"
> >  ./mlock2-tests
> > 
> 
> thanks,
> -- Shuah
