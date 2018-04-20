Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1980664-1524239455-2-6838326666220176161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524239454; b=WWqcNRGEszQiVJniaY9f99fnzFffvvHuZYFwNilt15LzmYmf7k
    Hpb7BQ5T8/vUbeR9z9POqWleEgfXzIObK6MKaF1bpv+GowNy5NZj3HtJP5sUSpWP
    DrNM9g6D7V5sL0vk/JSVyu9pjB66fF3/WAUFOQG5nE6ciL21dzyiUiIMRu8n+XmN
    f7XfsQojvfBNGhe0Esg5Ukg2IjvWT3BA47v6MZ/ESS5VED4H9ezt7gwwokEZKYsx
    CMLPhJshNFsV9xTq57Qlz2FoLxmvyt64y1PN6SJd6jwoIlIyfWRB38qxTSwJoyDz
    KXpuDv6dXilUboUJfq4UDXt5VNiRWyyEuCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524239454; bh=o6UbT
    6AGbrEDy8uENIY7IybrUjKFuVge/gf+YOLXb60=; b=Ln9QgSubglPOrHlOGE8CA
    lRX5DzDjfrolIXPrB2VdZ7j03fjZf+tZCmV3gopQRv1Bc2au3JvgfUPaijNj+s00
    qWzMFn5FtQhA4ARk3Nc27nuTZTtCXofWUUc+HngF+XBEeTzbZACTw+iZp7P1VCuP
    n0uQsg6JrY8G64d1ivpGeLSrWT1JP0IWZicIZ9Su36o+JcH0KsbGcIqAYm3czq3r
    Y+KnbJf3USUT8ZR00EZyWzy8zfYfzCvXc70btSP585Z77wF7TO3rcdgVGTIQAm6l
    6i3a6BcBee1vrYTRAG4/IniOhuwnJdraVl1/uG59xT27IV4aL2qKCkUJ/Cmz1MG0
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=v/A/lg9O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lmLZrS7s;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=v/A/lg9O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lmLZrS7s;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOr2BdgY8s1FxJ6p7DKHwWTIBvsIwZrZRS54yIrn6niQDtUILcJDWQW/mBWefykQlKokclL2PlgOCgx717jNxE3GuMDtygzIZy2pU4lizn6EXCQ+mMHq
    GaeW7xDWQH7waAxlWJKmtn0twG27rmbYwn/TkJgqSo+QDPUYfWf3TrehZ7LLr4RMu0JmvaJYrlD1TUvOkp+16UxxMxeLESuU0yf9WsLxMRFDu5W8f52ZfVQu
    BRYxFckBYv/WQqrNuTfcvw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=t2t0aVZkuDpWksqkN2gA:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/cXbXCHcZY9XYFZ3qmOLbSZJj0FmZv+DSibJEtmF9kw0ha68Mi+W/tPubQL8u4XousOHKaug==
Date: Fri, 20 Apr 2018 08:50:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@linuxonhyperv.com>
Subject: Re: [Patch v2] Storvsc: Select channel based on available
 percentage of ring buffer to write
Message-ID: <20180420085043.3a678b89@xeon-e3>
In-Reply-To: <20180419215424.3557-1-longli@linuxonhyperv.com>
References: <20180419215424.3557-1-longli@linuxonhyperv.com>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 19 Apr 2018 14:54:24 -0700
Long Li <longli@linuxonhyperv.com> wrote:

> From: Long Li <longli@microsoft.com>
> 
> This is a best effort for estimating on how busy the ring buffer is for
> that channel, based on available buffer to write in percentage. It is still
> possible that at the time of actual ring buffer write, the space may not be
> available due to other processes may be writing at the time.
> 
> Selecting a channel based on how full it is can reduce the possibility that
> a ring buffer write will fail, and avoid the situation a channel is over
> busy.
> 
> Now it's possible that storvsc can use a smaller ring buffer size
> (e.g. 40k bytes) to take advantage of cache locality.
> 
> Changes.
> v2: Pre-allocate struct cpumask on the heap.
> Struct cpumask is a big structure (1k bytes) when CONFIG_NR_CPUS=8192 (default
> value when CONFIG_MAXSMP=y). Don't use kernel stack for it by pre-allocating
> them using kmalloc when channels are first initialized.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
