Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1700296-1520507294-2-10450563382368513898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520507294; b=sUCMwVUdRqA5eO657VEnpTRVOwo8kQe3iLQz/i2mEpSgh44
    cAWE+hNNdvEJDNQEb3OtkUldIh5xDTUU4dzwJbt8eOwL4cJN5wwKVyfhpDVBNTkD
    bXliYOz2quvA7Bi9RVe+iKP6l4Ue5bKJwgUGjOHDMDYRoJgjXNzgYNoeW/VHfm4Q
    1Y4KLsppTC1i/IgiG8BteCPzOEP8DERU859oQMZZhAmWHjCVhUmvhebSPTO1D4Iu
    uwNq0akRvffo++Z5bZV7yTwIyiQChTjQPrEP9Sdl8phk901yBXLvNbHB52wt7cQ9
    3J3R2w3Dm4yBmIMyClUFJg/pMuTcQ6kmbtiushA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520507294; bh=+
    TRbhX+p/Vbl59u+3wNtHCgiNAUTaUoN6508d5kq+0M=; b=pK2ZULWqEt8Iam/u6
    UVo/qcjmBHyurayRqiBGut7y1VKaeJmmQQWCZqAZQx60B05k0thlUQ1osVpKaw4G
    UTdrmCZK/hyVKctUYFqUqNDcRgWwEegVGo6N3SVURw2EO0Cm7VIbibdzsGHX0U6R
    9nAw0iNEUaFgJfr3M/gqliqkcVm3tcPJtH8V6Mg9LOLxAcJpj3LYzhMriZDJ6s/j
    ROE14SsAUZkxJxgs0vBV5toy9OkgAx+/ajMSUP3oIG1HwWIKcmyBaJfDUnB1zaFi
    rnKUqJKWRvWWc7q33p39zx0mqS7dGQrNzvLg46OkSTCKqlPCoDp80LJf3FQCCMyz
    N0X9Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ITTigp8L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ITTigp8L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 8 Mar 2018 14:02:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Paul Lawrence <paullawrence@google.com>
Subject: Re: [PATCH] staging: android: ashmem: Remove deadlock
Message-ID: <20180308110244.htlc5uh5aqtltgol@mwanda>
References: <20180307214042.135109-1-paullawrence@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180307214042.135109-1-paullawrence@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080131
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks!  Somebody already sent this.

On Wed, Mar 07, 2018 at 01:40:30PM -0800, Paul Lawrence wrote:
> Regression introduced in commit ce8a3a9e76d0193e2e8d74a06d275b3c324ca652
> ("staging: android: ashmem: Fix a race condition in pin ioctls")
> causing deadlock.

Use the Fixes tag for this.  The format is:

Fixes: ce8a3a9e76d0 ("staging: android: ashmem: Fix a race condition in pin ioctls")

Then you only need one stable CC line.  Just the oldest kernel which
needs to be patched.

Cc: <stable@vger.kernel.org> # 3.18.x

The extra git hash after the stable CC is for if a bug requires several
patches to fix it.  In this case it only requires just this patch so
there's no need to have the hash.

Basically you did extra work which isn't required.  Anyway, this fix was
already merged so no need to resend or anything.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
