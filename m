Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-837036-1526305915-2-6212898208064197722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526305915; b=BvzkcmNZTpH5gYqyEfuV63w9k0T7ZDqB72lLNnamzaNQgHqbV4
    +unVblo6Z2PCMlrJM6TrqJuA+obDcMefFdPfJRZGvl4kNDTncJBYqXuFw6RYRRDo
    JZEwL4hr+ugBE5H6seyzYFbF277p3DVgJMyPXffk8OfRZ/VkfLngu6wIRlmwqpJ7
    VhM3yOXlvo8J7luyFQgQLbs0dErai4cN/7CkHMOvoB96R7M01sGb+qOkYvdKD+hI
    E2nxkNasdTsRn8NImB4m8CwsCDtsk/QA08E4rgPRsXAlAz/SdPbphJGlaP9uM0yL
    RGstUiurIPYzo/Hrfb9knmulc2JVnjEtYJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526305915; bh=Xz8pt
    Z/nD/ApIZ6/vL9gMf3cWmtPQLQqTzEdShhM7MU=; b=CXpFnnzf6CE8tJR7PvKtn
    gZPAH3nHXTuFeFDW6YmRhTiIQ+X39OX+uFUoOHDc82vqZ+XuUtsyaZBDgKCXOSns
    K9UaPYh/qcUdfAO2GbNeaOqaNSDsHk/pcvoesaqJZF6ook6ylEfQIuXGZe5hIBAS
    FiI6Pkd2mbYkGW9ci7spmTlghqf1hN7JT1kJC0HP/zmmYbdtl0M2gZeFyc6k8rGu
    D5F9eh1izMkSCdo1RJi3CSujmjkm2+2fBJw/Pcjwc4FovbsiwicB3pk0K6J5Giza
    wvAnMXTcwa/R9I6ao8Ltw+EFGk6PJ9JMWGSgMMCftiOYG1AGBTA1Iu2J3pXomOYr
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=Ju4t2W2Q x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=Ju4t2W2Q x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAmerm7phbmxgfJn5Go7BsRH9uR5ZD/C5pJuz1631tIlEZEdogKI1QnXvWJGqQjZ3wzUR+24rBIwWoXgdBmjrXV8P9/F1nPybelOd5eqplqQDmWpZ29e
    yGieHbZIIMrpE9v4yao+aZfdO7JugmmnZu8bwCGm/gcdeElMz58hd4+NnvbihNUyX7k9IX44U6MwW9ZsIMkgAzY2Ps5yvhO0UzZncJZTRvKvwxuDdMOiZega
    U8negRhLxSjwLH6py5ezVA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=pnPMSRcF3cjsB9Dy1JQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 15:51:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/6] staging: android: Clean up license identifiers
Message-ID: <20180514135131.GA1962@kroah.com>
References: <20180507011328.11982-1-natechancellor@gmail.com>
 <20180507011328.11982-2-natechancellor@gmail.com>
 <20180514132945.jofe4rb3ml4muusa@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514132945.jofe4rb3ml4muusa@mwanda>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
 linux-kernel@vger.kernel.org,
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

On Mon, May 14, 2018 at 04:29:45PM +0300, Dan Carpenter wrote:
> On Sun, May 06, 2018 at 06:13:24PM -0700, Nathan Chancellor wrote:
> > Add the identifiers when missing and fix the ones already present
> > according to checkpatch.pl.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/android/ashmem.h        |  6 +-----
> >  drivers/staging/android/uapi/ashmem.h   |  6 +-----
> >  drivers/staging/android/uapi/vsoc_shm.h | 10 +---------
> >  drivers/staging/android/vsoc.c          | 11 +----------
> >  4 files changed, 4 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/staging/android/ashmem.h b/drivers/staging/android/ashmem.h
> > index 60d7208f110a..1a478173cd21 100644
> > --- a/drivers/staging/android/ashmem.h
> > +++ b/drivers/staging/android/ashmem.h
> > @@ -1,13 +1,9 @@
> > -// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)
> > +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
> 
> 
> // was correct for SPDX headers.

Not for .h files, as per the documentation.  Sorry, I got this wrong the
first time around.

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
