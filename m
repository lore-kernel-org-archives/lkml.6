Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-899412-1526306846-2-14405413338759152777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526306845; b=E3dyZm4R04kdQB0tAfJSe0IDZW40oS5yalj+rJHawg1ZoezwqK
    aGikuhVxS0U8eD/T/1FlnRFHxDMW/fQ3poKg9H3zoGJLWQK4xPlRnco6Nx/RM+PB
    kK3P8xjufxAGsetJSPCgHtHThjgPiG/KPU6U9rxBfZjFIb6KJ1d4A5GjTP4fhjyi
    a5kJddNYCnkYjWaMYCRrD8hQB0GcD7IRFPSGG0e3wPf7q1EfiCiyqCL6eyYXBoWA
    BHNJqTvH/wgrGLdR4VbY0ykBkN+//bkRCdhpgqoxaBuOL8whsuB6ZcZSJ0NnUzPF
    Y2apiX8ECIPjGgZDy9lb20svR4YL7Ntu7gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526306845; bh=QpgRu
    pNSmy4DI3YilZQAw3fj3aj4467oiDxWKzS59VE=; b=kEw3hWbjNd2iMiMsixN+y
    gmuSYc340Ux1AnSgifhdV3VUQ5cDTtjESSkMGUcMjV0ibK2EJ6y+iQYik2nTIaBK
    BHAfn4pJfr7YESy0GssvUTH5MF3cuOTX4tJ/tz0zASJxtSGUoPJFYyKtOJcfu6R2
    b9UaBZD3iApzn+/VMPFCHSAsxmBezmZJgxIheFqi1w9WlsjjBCYiWXoV7QsK0xE+
    YKQTAOCoWcog+x9RIqTAilpKmculZICdWCHaHu+e+mY5woaBPij6AW4Wwgx9ZaVD
    TPyvcxHIXNigJBcjCS0ajnhoPkoDWHXRpPh/Wi1sOTdNN3NMYmowuoJSq23iiNwg
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=R+IO+iKw x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=R+IO+iKw x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOTH6C/rW4+IPJOnd3nFNlXjSrbAKUtSwX9cpwBcYNrLPeviylvGDFa/4VpfCzhCfMVK+7BsX4ynSojG9IggMqEjlHoDOLr7PFa44BhAyK4jxX/6T1lW
    2evKFMRFK2J6jxh93mFwZqYLNsCEJdYU/akqeF8tDsJSy8R9Ng/s8s/M4LvkEfPc/l00j6Vj5KF5TIdhf1R6SbMcVpH2OxH7ZmvRNOofWzMDF6Qp9tIGlrsQ
    +dOXzouEF8V6Sf6PLaqABg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
    a=P-IC7800AAAA:8 a=DDOyTI_5AAAA:8 a=EMxJyCO0WJoxtPCG7IkA:9 a=CjuIK1q_8ugA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 17:07:06 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Justin Skists <justin.skists@juzza.co.uk>
Subject: Re: [PATCH 2/6] staging: android: Clean up license identifiers
Message-ID: <20180514140706.qjddnq5vrclf665w@mwanda>
References: <20180507011328.11982-1-natechancellor@gmail.com>
 <20180507011328.11982-2-natechancellor@gmail.com>
 <20180514132945.jofe4rb3ml4muusa@mwanda>
 <121696744.206121.1526305937025@email.1and1.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <121696744.206121.1526305937025@email.1and1.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8892
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140146
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 02:52:16PM +0100, Justin Skists wrote:
> 
> > On 14 May 2018 at 14:29 Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > 
> > On Sun, May 06, 2018 at 06:13:24PM -0700, Nathan Chancellor wrote:
> > > Add the identifiers when missing and fix the ones already present
> > > according to checkpatch.pl.
> > > 
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/staging/android/ashmem.h        |  6 +-----
> > >  drivers/staging/android/uapi/ashmem.h   |  6 +-----
> > >  drivers/staging/android/uapi/vsoc_shm.h | 10 +---------
> > >  drivers/staging/android/vsoc.c          | 11 +----------
> > >  4 files changed, 4 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/drivers/staging/android/ashmem.h b/drivers/staging/android/ashmem.h
> > > index 60d7208f110a..1a478173cd21 100644
> > > --- a/drivers/staging/android/ashmem.h
> > > +++ b/drivers/staging/android/ashmem.h
> > > @@ -1,13 +1,9 @@
> > > -// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)
> > > +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
> > 
> > 
> > // was correct for SPDX headers.
> 
> Sorry, header files use the /* ... */ format. :)
> 
> https://elixir.bootlin.com/linux/v4.17-rc5/source/Documentation/process/license-rules.rst
> 

Oh.  Huh...  That's fine then.  My bad.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
