Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD44C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CE42087F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbeLUQ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:28:32 -0500
Received: from dmz-mailsec-scanner-6.mit.edu ([18.7.68.35]:55450 "EHLO
        dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731121AbeLUQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:28:31 -0500
X-AuditID: 12074423-8c3ff700000053bc-94-5c1d14aa08b6
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 92.5D.21436.BA41D1C5; Fri, 21 Dec 2018 11:28:28 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-4.mit.edu (8.14.7/8.9.2) with ESMTP id wBLGSOZ8023106;
        Fri, 21 Dec 2018 11:28:25 -0500
Received: from callcc.thunk.org (251.sub-174-192-22.myvzw.com [174.192.22.251])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBLGSFoJ012525
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Dec 2018 11:28:19 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4458F7A45FA; Fri, 21 Dec 2018 11:28:13 -0500 (EST)
Date:   Fri, 21 Dec 2018 11:28:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181221162813.GB26547@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu>
 <20181221070447.GA21687@infradead.org>
 <20181221154714.GA26547@mit.edu>
 <20181221155354.GC10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221155354.GC10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuzPj7Lg4cl01b6sGbUVhaRkhE2gvCqciKKjAEmp0J3dxd7WZ
        1dQKLEN0tbCobBddNo0etlq5Yj4rHy2+CEoxiawwLZTMQjRFi3bWfPx3zvf7vnPu5V4KV4x6
        KCmtwcgLBk6nIuWEQrZ9XajdLzh2c5vDh8m/0eTB9I8982CqnB8BU94wizOdBSUYM/jYgjNm
        6weSeVsSzYxYJwmmobGdYNpeO2VMd10RyXwymXBm4OqojGl1tJLMzFQRuROyHSWItVWmsI4H
        IWxlWS7Jtt2eIdjPzQ6CrbeNY+yvofcEe/lFL8mOV648JD8uj1TzOm0qL2zafkqu+VBbiyd/
        k6X9vFUFMsFd0gQ8KQS3otKuEZkJyCkFtGPImfcLn2ueAvSywvm/eYOhm333MSmigAIae1cN
        pJqAa9GrpotunYTrkX3oD2ECFOXnqr9XbZGyOOwjULY11+33hbtQ6cAPt5+GG1HpYKF7AQ1/
        E2hiuoyc21aDoczOO/9dPqjdPEhINQ5DUN/fYUzagMNAdP8vJcmeMBL9aOyRSbI/XIPGbbAA
        KCxLwpYlYcti2AbwMhCs1meE6jmtTuTjQ8V4zmDghdCIML3WGMarUyqB+1X3rK4Bw1cPNANI
        AZUXXTAZFKvw4FLFdH0zWEFhKn86b9olecclqdM1nKg5KaToeLEZIApX+dE5US5Gq7n0DF5I
        mkeBFKEKoGf9vpxQwATOyCfyfDIvzNMgilIh2uYbHKvwEfgEPu20VmdcxBjlKQ33cg2vkjy0
        mMzpRW3CHO8Aq5QB9F0JQAloUgwLWemXVrxcPjMCAlxX8aVJyeXl+sML6RHXYMw1WL5bOrVo
        5BaRMhOkhx9uLIRO9dfi6IHuEPOOn2lwmblvgxUVrnMUpWYph6YuyCJawi+dLbXvtxzZpiSO
        FMRvCeqP6bL51JzPE0rq4sIK84ee4r6dx1ZavI+Zz6X1nBGvd1w52JsdlWOrns1s2TeRW/GI
        jdmbNT6QfPLJquv3jibW24utD0+UP7/Wr1IRooYLD8EFkfsHYox4f4ADAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 07:53:54AM -0800, Matthew Wilcox wrote:
> In contrast to "we'll just fix it up later" (which usually applies
> to in-kernel interfaces), we have a policy of not breaking userspace,
> so accepting this interface means setting it in stone.  We should get
> it right.

I'm not convinced it's a "fix", but my point is that if later on you
want to add extra complexity transforming

     ioctl(fd, FS_IOC_ENABLE_VERITY);

so it does the equivalent of

     ioctl(fd, FS_IOC_ENABLE_VERITY_NOW_WITH_EXTRA_USELESS_COMPLEXITY,
	   fd, sizeof_data, sizeof_verity_data);

it adds essentially no complexity to provide this backwards
compatibility.  But if we need to implement
FS_IOC_ENABLE_VERITY_NOW_WITH_EXTRA_USELESS_COMPLEXITY *now*, we gain
nothing, other than pushing back when fsverity lands upstream.  We'd
have to provide that backwards compatibility interface anyway, since
there are a lot of users for that existing interface.

So why?

				- Ted

