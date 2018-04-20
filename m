Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3121895-1524774568-2-12659573660947139247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524774568; b=cLy1SZTeXEl4DDpqFd0uhDblwtuleS5QUsueU6ZnJ86Hm/tBdM
    ZSqzJCu8+ZvGh2PIpnc3c2F589ale2dk+JenPIhsg2BYF96OxWtPPirrLubZWm5i
    rKArtxK3k5VY90I/b3Eydm7tOAAe1x5+HGJEtdm95eeAaknpOdZ4sEw7Qs9z5oHs
    F3Msb8j+5jO5oC4gxzHtp8V4PesMK5FOYgqs47uyBB0BD4Rkkn9Vl8bIEOcx5X9J
    Vwj4ZnIfPG3BqzTa42z8mUBvVhzP0tIYIcTbxAVUbYxxmj/H5fcmvRFZf5UMEytz
    Q4tm0rSuGLPUcl03aUGuTY7TwRoOyLJChK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=fm2; t=1524774568; bh=z0wV625yNtaA
    JhPl3pgipBWEl841/KjKHRnUq7EUqYQ=; b=iD+2lLomsqZYxn9VXFSZhd4Li9Tt
    90smGlopREZf/6ihKk3xkg4GlWkslxHnG/+sC+qU4gkCDo2oFSBYwvptdBN9nWKP
    skSE/fj4NMTpcmnanJ1VCzJeBQeGbvKfqQp4ItlQI4SHbcyKXSSHRXpy6XCwSx+Z
    OX0gvN6OeI9+eSK4OxKya6kMoLU2iqFAOAbAhCI7GnlsxsVJZ6oi+6tsFlzSxKj1
    w7/PWcLdMb5g1U2OSQSHou8GKYKzu1NKVP2k1eisRau6q89A5jHTFMLvxC9H5k5M
    Ihqmh1Xxi5HDyb9y6xDJhmWye+KReuj3P24QLVvgaeytVWhWBtw50i/T0w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=S1STZsEw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=S1STZsEw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
X-ME-VSCategory: community:mailing-list
X-CM-Envelope: MS4wfLMDIEEr6irhGLdA16Qq6dJy11UZM2sccgVvYM5+qS5q6Azjw8mojhjQZLz46w4EES/1e+SpOM4403C1DzmY0ENY6sLKZQPEXezzKC4Yc3BNyptR+AP6
    EOOQMRje+FSiCkprOuUm0cZi5WHnq8QmeTy47U69Fm+INIRq0kzqfTHezrNAgRPhUcDVsf9/nSGMvMO3bsioy162E5w2DArmI/8=
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=SiqW3_QkAAAA:8
    a=WaeIK9r7L2twIttjUYQA:9 a=CjuIK1q_8ugA:10 a=Fe-e93FlemcA:10
    a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
Date: Fri, 20 Apr 2018 12:34:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Philipp Klocke <Phil_K97@gmx.de>
Subject: Re: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG
 case
Message-ID: <20180420103419.GJ4064@hirez.programming.kicks-ass.net>
References: <20180416085426.24157-1-Phil_K97@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180416085426.24157-1-Phil_K97@gmx.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailman-Approved-At: Thu, 26 Apr 2018 16:28:11 -0400
Cc: sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
 llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, der.herr@hofr.at, lukas.bulwahn@gmail.com
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Also, please don't cross-post with moderated lists, that's just
annoying.

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
