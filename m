Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1227858-1523950761-2-3735184644683120967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523950760; b=c35gQULM2PQPZW1tII+8q3YqxMVj9UIi8hBPrkOL1F/lPfmnJA
    PwJZPwZjvOR52eSFUoBga9l5nv8ptV4bFwhdjSR0t3hp9L3BXbO5JDhS8NVjGN6h
    dDvhJFs+mvehagQyzckqyHswYy4gfE01gblhomhMvZ8XrwnuvpXUoOWXZ2NS2cAx
    i5N5mOXhSrwd0HMFcEZJBdG6JB/04eCmSqQfNeDYCCMVFmN9db9YQX8LUmDwZ0MJ
    PJE6+ea5qeAP4BxZbrJeTS32COBOkfYIpMfeRJXZN5iD0+/iCHQqkZaqo034xNsy
    cEh/qjZH2KjDXl1oYtgEAzDOa+7+VsOp4w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523950760; bh=hkV0T
    8+llRPJkyTjp2XR7pl7jt3fplcq9cWzZEGlZyU=; b=nu6z7lKo66hOK2mpd9qDe
    +wk0zxSNwTCDoCXBph7eT/ANLf7P7pW5Of3QG00dbZlHsX98NsoOt5UUAGqVAP2u
    6g4NKDEqinrrDjNyrh1R7jMls95QBlq79Yda3Bax7xA+nMV7VKcCQH+lvkn4N8/C
    SrenoUTpWTig8SC1eEv+UhkS+MBKTeqmDdXULbbfGCWho0aovQzOVX35kcstuO/T
    AOa+2giCxpMq51K0YSkjW52gdYnL0Hx1n28ktAs8Jp+NdVVzPm1pKyGZ5z17y5bC
    pypEuTIm/bzqZ0NLjP6T9CJ3aoZ8dRP/pKTvZ/8afFxGq4Haivqd3mRW1YxzYpFL
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=vx4XXegC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=vx4XXegC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIwqXXOblHRi6qzH13DcFZnWQjoloFwq71mjyMCXB1c/d8w/3jKdBViTMf1dyKuOxSh45qS+5v3OAd9fyXmDqrxHm38bj35FlUVkUh6UnjEB1Pv6+mvc
    +JaITkoxjwqGh1VXP7axJZaShixx/N/Hh0L+n0o/xp+LTNNzCdEcVw1xVkP1XyI7Z4GZHNjTkAP2iV1iDJjLYHvIAhisEAHmDwTRBP8iQg8RCZyc+1C+L9aU
    oxJ6b8uAkIijiKWPw1BvHw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=ptlokd3fXilD-7VZ_eMA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 17 Apr 2018 10:39:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 18/25] staging: lustre: libcfs: clear up failure patch in
 cfs_cpt_*_print
Message-ID: <20180417073902.slxgixniiytw7guk@mwanda>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
 <1523851807-16573-19-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523851807-16573-19-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=370
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170069
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
Cc: devel@driverdev.osuosl.org, Dmitry Eremin <dmitry.eremin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -err:
> -	if (rc < 0)
> -		return rc;
> -
>  	return tmp - buf;
> +
> +err:
> +	return -E2BIG;


We finally fixed this bug!  Hooray!  But it's like you guys are
deliberately writing in terrible style.  You can just return directly
and then you would have avoided this bug altogether from square one!

People think that by adding little twists and moving code to the end
of the function the it will be less buggy.  It's not true.  It's like at
a hospital if they just swept the cockroaches under the bed, just
because it's at the end of the function where you can't see it or review
it doesn't mean it's not buggy.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
