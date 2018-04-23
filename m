Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1113844-1524485620-3-6930200278963967154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524485619; b=ZJ3srUfV8LxtLAcfheZPImF+Utj6eowQaWFTdvgQB7ezp3IOoX
    bqYSUcpJ5I8Qv12rQ5mzPHoP0wg1ZEShLclHaZNCga0Tn9MKvuzZaGLy4o2XjpJr
    o2LqtGE4LuCIAywZQq7IRkNAflq4SyO4mw9FGA3+hlZpBsIJT9QAa3/v+H2505KL
    veKyyhztU9pxIWBNomWRBJi71BUESoTNPH7T35MpcNv7qpnghz8oZ9ugGYsjFMsV
    tAgH334Edv6pdl7L5g/rTHIRx2rVlpjVqtuDBMxBGhOmDiR9G9F0qEpiPuB6YUoq
    T5U+6wuPqMTM02LLtsbzqxpWmHC1+H85Fwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524485619; bh=MzCkj
    CGtQe2teZ5cRctXmJvJXUlvTbTdEAPae9tMJDA=; b=ZLEaVCIzT4ckRRDyxrwLz
    5roj0v6Kbt5n/lG7M4Mr3j3gGKtavmTxFn+3rs0ESfA5PTrSKm/eYG78O2z9r6Ed
    rt2xoP+5zgt7Xy/V2NbadZSgmZ+7uuZoqxPn5kQCQw2HsUvvbzbc2WVlcY1UXECT
    ryA83PCUqytC7QrZo/9K7/SLSLP1KNvyrGg231dMdLNV3mv/OB9SdnuoHupS3L24
    AjR2N1DhRTzDykbgj6sD9ghrN/co3hkIE6T4naXr1U0am7BWqJje/fxht/da0C4f
    b22+Vte5ICkbg9QUeul4qy/2IMJ5bj0lm0PfxgO63mn2OzNko8XySSHKoH2WqVc1
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGoWuyps4rxBl0S1uNtHWsYFSMjU5ysPM5wILXS8kjh6dS+3IaL82KqR5tRx7Vhgxdr3/Bv3zhfMgLHoBxJ02g56+DevQkgmc3QGOP40wgm2SJeGO2+m
    QmOvaQVwpV6N705nqoAGC25fw80SlbLisgHWTh2kWtXMSupt0/+kR7CBny42HmmbpqAK4aDFTehkLLLGo76EsuMTqfhy/MNAikzciAlpyG7TP2Wr5PiPidXl
    VZyncL/b+ojA/5XUlkVRQQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=hqW_Hx1YNEq13vlocB4A:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 14:13:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH v2 10/75] staging: ks7010: Remove unused 'struct
 hostif_mib_get_confirm_t'.
Message-ID: <20180423121328.GA23835@kroah.com>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-10-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180331060855.9452-10-quytelda@tamalin.org>
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:07:50PM -0700, Quytelda Kahja wrote:
> 'struct hostif_mib_get_confirm_t' is not used in this driver. Remove
> 'struct hostif_mib_get_confirm_t'.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> index aedc832bc04c..e6d6c51ccc43 100644
> --- a/drivers/staging/ks7010/ks_hostif.h
> +++ b/drivers/staging/ks7010/ks_hostif.h
> @@ -151,16 +151,10 @@ struct hostif_mib_value {
>  	u8 body[0];
>  } __packed;
>  
> -struct hostif_mib_get_confirm_t {
> -	struct hostif_hdr header;
> -	__le32 mib_status;
>  #define MIB_SUCCESS    0
>  #define MIB_INVALID    1
>  #define MIB_READ_ONLY  2
>  #define MIB_WRITE_ONLY 3

You should have also removed these #defines as they are not used
anywhere either.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
