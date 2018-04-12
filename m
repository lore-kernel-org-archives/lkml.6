Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2081082-1523574308-2-14004694299049801427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523574307; b=J2elm2RdS4z+mnobwp0SCD35hCwwAC1OsZVQwwglkr1AszKDuu
    qt8Y1/P8UFhimaWD2trOqPUcOPUx5fdYBTIjkEm/sv/vCWO+blMzqZBkT+vg0RuC
    yAys8CxXRW4klj1LSxWiWRvFcPfIqKGsPsJ9g/cU2+1U1vYKDyZjMKwjxRZsb0bi
    lEdjbSSNd2AuadQjCjwqYDzM2N5V031WHlsJhcIqjQUZTK7+O8xt69KWnmyaGckQ
    3ecz8YoPouyWLTvhRsMdt3g4oA/E1+gYoSL//R/qIat2LQRaZfLF0AFFScXDliMQ
    N0whxEG9UMkkUGwyW6/qaRZ97yIfDrGh9KQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523574307; bh=Pdq+z
    5ZGvoC2rCfUR54VqNjQgHeocQHweNFtWRTRIno=; b=WSwCySYN5FAS0B7WzveSv
    SrP0nigdLqCau8Kek/QhzaGFKWbK8euDJQC5O+QA5wCmagKuX81uXwCGkiPLtudF
    wGt3COdTwbomjaOnrZClRg+DjvSwWC9QinAp+bBmDz7O9IoxHmmdGuYKEwNa81fQ
    y2LIV8PzBxfB3NofAA654NCDGAiy9gSsm54xi825y4kVRibIFg2a6f99uUDccHXR
    qekPMJN4mfin7yF+lu7K2G09fJzYYllJ+IdFShY7ECa8ewyow/BCgLlUOIKsisOv
    xYTm5k6b9aQEeNecjO0PedbCrR7BWTvoRTKC3xBNgKTD82f86XJZTPc85Bb9bblD
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jFP2o61g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bcR1RDaQ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jFP2o61g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bcR1RDaQ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM43WFvl2JecM9oX7wqnb1SNjbvZZrjmggmDNhXDnb7D0as8A8RsEAWZuqptv8xojbWFvf169N1my4lZYUB6+bQf0EjlE0TIO6F4XM9bIEnz1K5V2TyI
    4aLfq6NdyLyTkdFtZ7z9t5xN4wuw288F5M1qCEZ6eDLqetZ18P6wEKeH9tdtKxFay3BttwqT+iAShpcmQ4hfgoVoUC7yH60VHEg3Y/GX+5xqedJkWk6RoN32
    nI+GlmYEvn1KP10sGx6eIA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=BkPDqxY9XNgA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=K-CKVkLlRTJHRCJysXMA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+5baAfcL2Xag6E5bPYVyrzPiiB35oILVZ4v4TTvuB66qm//Elded8miGw/oP79C1lOnmZZQg==
Date: Thu, 12 Apr 2018 20:04:56 -0300
From: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] staging: comedi: cb_pcidas64: fix alignment of function
 parameters
Message-ID: <20180412230456.GA21454@gfm-ubuntu>
References: <20180410225007.GA5050@gfm-note>
 <50d5d5b9-d4f3-68a5-268b-fbe46188ebb4@mev.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50d5d5b9-d4f3-68a5-268b-fbe46188ebb4@mev.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
 lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 10:18:38AM +0100, Ian Abbott wrote:
> On 10/04/18 23:50, Gabriel Francisco Mandaji wrote:
> >Fix most checkpatch.pl issues of type:
> >
> >CHECK: Alignment should match open parenthesis
> >---
> Looks good, thanks.  I guess the remaining case of open parentheses
> alignment wasn't changed because that would exceed 80 columns.

Exactly. I wasn't sure whether it would be OK to use a temporary variable
to store the longest parameter on that line (devpriv->ai_buffer[devpriv->ai_dma_index]),
so I ended up fixing only the straightforward occurrences.

Thanks!
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
