Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525779896-2-2767792322255222184
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525779894; b=aka5cVfwSlDeNhuO2cxigNgXW3TCsYXEbVemVAWy7TnLPRrwVN
    ImD95GKT3MJMSaYLDEEY2sBAOi9XFvYL7m0mLlRLMIojyfx8KG2BmW2dIUn/p9xW
    2QhHeqA8+x3dmB0MMy3dvSf7pl84rUThNXmxCHkQiakFvtZLnt/p8LcKd5suo5Wl
    bTJUz4GN+NbB24q3dE2AmI3HYTwKaCMAOhPhH8flLFI9+ijKhqXKcTVOQl+Xc3NR
    xx4tWu3TZ+6Z3piRv6TaJWhiooo/KRxI3s6SENVuZwJqub36B3OagxEnjv8qEE8j
    v438I5pMThcHQoJ6bkgrPVSwaX+vBY7bf2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525779894; bh=pIraQ
    IRJcTFrh6NnnXKYNG5HiyjvQ09ZIF97Bx3CuGQ=; b=Cv0qyA/NkRMOs7XKjPFwF
    gS8iJfHoMn9z0FcqLzcLuGdOW2vidCl4A0pJaAlm1B30rJE8NzjwcpCE33937Snh
    TqIKRQm7j7Nqd3mx/KBMT7OLGUIEacKrRTNo4nMQf+J2ZC9ttlrh9RkWi/KPfbwY
    6LwUo0hxc7Z8CUv5l4tzpFXB9OjnpjYPt9VOFpfsMmHaycVQzBGFdu0Ewf18YlfQ
    HVNLnUwybAf1HOGwAV7lOjYJjfN8zVn377t/+ALaSzJ0B8uUOF7VrISKl0BZPtZW
    s6Y35MB0tNbz6g2lZ5Y7yVNSJ9Lkr+QSfP5nasXbTbjNjReHXis/Z00HL959RDEk
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=xrfiiSB/ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=xrfiiSB/ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfML1XvjW4sSl3Pms+FxmspYijyBUtarc4mcTc2N53A/2Y6EHkI/nmuurj3UMcjFHQnEMjizxS2y35jm+c+dLF7dh/ElYKwGPUKd96oq2a6avmMwaLCSZ
    2AfZ05N9Po/AxrGuQjQV70PBjuXSenCbvI82NT7vJ7jwEfT9xU/SCiXouqUGr85tsE+FNrcIS8oj9ZxbBsiozK5zPlJjv1FIileXVIeQdVw4ecSi3tjK+t4a
    EivkEW6Dg0uRggqSsgW4xQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=IDctnxVwTqnogm8OifMA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 8 May 2018 13:44:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 5/7] staging: ks7010: Remove unnecessary parentheses
Message-ID: <20180508114436.GA28419@kroah.com>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-5-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180506220304.13040-5-natechancellor@gmail.com>
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

On Sun, May 06, 2018 at 03:03:02PM -0700, Nathan Chancellor wrote:
> Fixes checkpatch.pl warnings.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index a2833707e0bf..094f8c11b4ab 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -35,7 +35,7 @@ static inline u8 get_byte(struct ks_wlan_private *priv)
>  {
>  	u8 data;
>  
> -	data = *(priv->rxp)++;
> +	data = *priv->rxp++;

Ick, no, the original is correct here.  The changed one is now harder to
read, I have to go look up order of operations here to figure this out
:(

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
