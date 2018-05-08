Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525779933-2-951715880195910791
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
    1525779933; b=fbeZvryw/qc5ptAArZMiUrL/14eIosNBnbZM2ckBkVVQHTUrxY
    Iu6ajRJeJ7FxxE75srbwVO3LPlYYiKqZWleZZafgCkY319iHCF6zINmcyyPM1IO2
    npJ0Mefve1eRM05H11mqEgFdtd8esvEFGFuw31iX7SxMhqp02YU7WUuunIt6ZU0E
    Cdf1Lsog+SxrJJvnGczE8VSa+C6ZznP7RRHzLrSeKS32Re6KX7DpEdLpNDDUl5x2
    A7rAbqCFguxR6NvgBUdbkPdgQmU1N9BFt9vkgsIKM/Mdyh/yn92DbeayWis48r5r
    cw1x1oSGG+YwHXGYih0KRmH5rUZjAQrSnKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525779933; bh=i2JWk
    RbykC8OlvC6Liwo705xmngCvVi3iqI16NV0iR4=; b=BjUWJ0s2aC5CgxO0hn9P9
    yw7+fK/D85g9u53l41XGKP8DvmD7ObLyAWdJs/W9UNZ4FDmnnzQ0LSzcw0Q6d7or
    8KBLHPprDURAi+ZdmASshPJlPUJ+8Jh1DQOsGtj/Mx8SJOG9rVVPGXrnpUW3dHp5
    c2XgKm+uo5MnSFVk319dOs+Epc+Oudv2xwYSiQwcHDkFbpwZsM2+9iUpxOz06PS3
    OFr2Fcw9gP02U6KGn4XHyEDwk8oCTmgPIqrzag+tJv85Tf22x9jIOiwfyKMci8+E
    Yi8YL7SEE64eOd73VZzocMmAjIP7otq2/eYuFV5J67b4sEu9B5NEvqeuaMUPkGD4
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=ryaBD6qh x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=ryaBD6qh x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPLIdOE/13BQGsV0H8o9n+w/TWZwHNpwD2nRce6oQQV40Slmxt+lzuDVpFdKIyfiQNHf018oc09NYkLf0RrIYAqJnwsnZ6Yt0Iq2VmjgzCd+aZbztu3X
    +BZMELje5jwfMU+FWwldqshvizx+qjgoHalL/o3G9HJR8o9BVcjNkMyJqYtmuYzg/2F8U7sY39SdbRzmfyLqQKNWj9aJFyn6gF9oU3WK9N9lBAEvFMNH1huR
    P7R2w7/aL02W+dRkGB+tZw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=jyydC5_kgn_WP5qzohYA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 8 May 2018 13:45:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 4/7] staging: ks7010: Adjust spacing around functions and
 declarations
Message-ID: <20180508114514.GA502@kroah.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-4-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180506220304.13040-4-natechancellor@gmail.com>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 03:03:01PM -0700, Nathan Chancellor wrote:
> checkpatch.pl warns about too many or not enough spaces in these
> locations. Adjust them accordingly.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/ks7010/ks7010_sdio.c | 1 -
>  drivers/staging/ks7010/ks_hostif.c   | 2 +-
>  drivers/staging/ks7010/michael_mic.c | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)

Doesn't apply to my tree :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
