Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA90C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068D52241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtbYU7Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068D52241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbeKMAI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:08:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44840 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeKMAI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:08:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so9498830wrq.11;
        Mon, 12 Nov 2018 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bfc7PnchO9DzEg2NP/9/1u6MbdYgzrMscQcD90PF9ag=;
        b=CtbYU7ArE7ACYPHaS8NEPoz+8AtFx+wUm7BaPWCpyFSLiuRDYPMwC1mOucfXOsQsnD
         EI1liODs/Pq0hrLofeKzdwV1fktPxhXNQTw+95nqK5OZ/Li9og/NQ5pYD+RhvHhp4suu
         wtSvEdoZvX9O8MhPqmkp0JaL0KtXZeI8vGx/0vuagVxTGrVIrXfUhC2/a/DannWxmc4M
         t5ObKZMdwLn6vAluBvQTnFnSWhr8pHahY2fy7XU81HUNKGJY3r8lRsbUi5cKwBg0A0Dn
         j9ryO3pVKGzSzrhlr/yAhnk8HPqVJHXURSXDha50aewVVUIfeXvdXuQo8tfxdU8oflKC
         1GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bfc7PnchO9DzEg2NP/9/1u6MbdYgzrMscQcD90PF9ag=;
        b=thwbFDl3jMhHs5qYBh9YRrD7TgmVRVVwMlFGCcMP5EQUlFYRCrQiNO0bvRGVvDBx/4
         0U8VCDjWkNIoFHUHt0RdPDdG+sOUiocKfJfYD8feTJz6inlJOvS3U8IddiKuA2ioPUFO
         CJWVBzY5bv9sN6YjRHRn0SoG5qz1cOb/KdSaI5ASzrHtFTtQ8HDYheBtPUCXuPVfs1+2
         ydu5MrqfSM3XompA4yUT8oCDyEZvZHxa71/mWVlPxnazUzWzT3q7AOAK3aoRW+P4iuuT
         HQPmFWaYhbfgWfiE1AdTRNbQ38YpNZ3USVlQB/Uqy9974pqShH/qIouEqR0gdH2aqozX
         GI7Q==
X-Gm-Message-State: AGRZ1gIcwXA4byG7unFT3I1F9kqxtUIfQwyssCxkawQdGFAbWL2VZISe
        F81lWjNurRXCF3n8nHJ5azwxqnU=
X-Google-Smtp-Source: AJdET5fLwdDG0ZRHVyy2mmaNXaFWL6a3iWo7sU6DTe4ZvgA7OmnBMF/XWoRaqNjGHU+OqgbUh59GgA==
X-Received: by 2002:adf:b50a:: with SMTP id a10-v6mr1053008wrd.273.1542032099788;
        Mon, 12 Nov 2018 06:14:59 -0800 (PST)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id r1sm17432787wrx.15.2018.11.12.06.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 06:14:59 -0800 (PST)
Date:   Mon, 12 Nov 2018 17:14:57 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        gorcunov@gmail.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] proc: fixup map_files test on arm
Message-ID: <20181112141456.GA15690@avx2>
References: <20181110184920.GA18252@avx2>
 <1541904527.857883.1572718104.2AE8D0DA@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541904527.857883.1572718104.2AE8D0DA@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:48:47AM -0200, Rafael David Tinoco wrote:
> Including Shuah and kselftest list...
> 
> On Sat, Nov 10, 2018, at 4:49 PM, Alexey Dobriyan wrote:
> > https://bugs.linaro.org/show_bug.cgi?id=3782
> > 
> > Turns out arm doesn't allow to map address 0, so try minimum virtual
> > address instead.
> > 
> > Reported-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  tools/testing/selftests/proc/proc-self-map-files-002.c |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > --- a/tools/testing/selftests/proc/proc-self-map-files-002.c
> > +++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
> > @@ -13,7 +13,7 @@
> >   * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT 
> > OF
> >   * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> >   */
> > -/* Test readlink /proc/self/map_files/... with address 0. */
> > +/* Test readlink /proc/self/map_files/... with minimum address. */
> >  #include <errno.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > @@ -47,6 +47,11 @@ static void fail(const char *fmt, unsigned long a, 
> > unsigned long b)
> >  int main(void)
> >  {
> >  	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> > +#ifdef __arm__
> > +	unsigned long va = 2 * PAGE_SIZE;
> > +#else
> > +	unsigned long va = 0;
> > +#endif
> >  	void *p;
> >  	int fd;
> >  	unsigned long a, b;
> > @@ -55,7 +60,7 @@ int main(void)
> >  	if (fd == -1)
> >  		return 1;
> >  
> > -	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
> > +	p = mmap(va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
> >  	if (p == MAP_FAILED) {
> >  		if (errno == EPERM)
> >  			return 2;
> 
> I have sent a patch removing proc-self-map-files-002 AND making 001 to use as a
> HINT for mmap (MAP_FIXED) *at least*  *(2 * PAGE_SIZE), which would, likely,
> attend all  architectures, avoiding trying to make the test specific to one,
> and, still, test the symlinks for issues (like bad chars, spaces, so on).

If the goal is to test the lowest address then going for 2*PAGE_SIZE is
a mistake.

Which BTW hints to add a test for the highest address.

> Both tests (001 and 002) have pretty much the same code, while they could have 2
> tests in a single code, using kselftest framework. Is NULL hint + MAP_FIXED
> something imperative for this test ? Why not to have all in a single test ?

I dislike tests which lump everything together into one process.

> Are you keeping the NULL hint just to test mmap, apart" from the core of
> this test ?
