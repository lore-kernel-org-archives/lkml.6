Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1236102-1524491436-5-3820862110634774675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524491436; b=BI8v8BjND9Gg1MnrdMKO0OeGEuV517vbLouiMgNhEm8zHzDUiW
    8h/Qh9/H55pzCZpEtsDmQRxuNQ0h/btkjZ1x8WhNDh6PXeISwkOTLH0/JmiLayEj
    /o9swZwgOaE3cSi2ClJT0Ff1Ke+XZJlljHgg3dFY1cQmhLxojapd/S6+SvpKk4/r
    ThHZ62srdtUjdqKN1kQNo9/qaFxEr6ZogR/N4PICr24pp/llW/31ejt+/Pisf3Im
    Ix3ox+HAL/drWevg/nYqpwKO1kfZ6DY88jrMdctpM5D3V+nRYUHRgU/Rz2XnyIzc
    Tn8SL7TVtU0oV4gnW+MpLhGdd01mne4b+q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524491436; bh=27eFi
    ewhibv02oqViWKKB1aUpQyd92y9ZJOo+OJEyGM=; b=oLZND6NpKHosIRWNSLXps
    3a4ibkT+DdNtZhhMNxbqkTGabg58v2uwlLIUkUcFIztsxpoZoSiZ78Tm+E+P4Sot
    r/NsVHfjTK7DzpvpICNHQxsxa5f7VCgw9c4fg6o+cyagfM09dD4RkZJKlv1OhTQf
    w2djhT1EYFrCdBeYuerApn7pxq151vqEU28XeEbchPEZ9FxBtTsG80sKFs4YFdk0
    P19VdveD2Jghhki5LnganMenMLqAkNmYLklJKMF8sZWnvBoMmhjlHnH5QF7bbzYk
    mlopH36cpsEuu9iLNitX65q9CPW51hKjtLeSNLzhz+aFoOOpD8OPYdrWXNtyv6k2
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfInLd6EsdqN/k7vDEfgWThgbJW9WLyQHLiXQP1o61mCqFU/bivGZaLMBZ1+2lEpRFT0ZvWYekYLIiGhYJ3bZ/SzzQAbnHuw0GpLUGsYjx6dhS06vEm+7
    RsWbS7y4isKw3t4tCrJDMHgDoV3ISTEOIbM0FRcoyBulIL3l86/TbXdOsvQjM1pa7wqFLarebDxXZMmuIh+1WfVG16TzfsuW6jWYiorAGgG8f+g3tkJrtHuM
    jkYZPOwIb70WBjlVNvOqiw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=DD3tva02LBzV1n9GeKEA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 15:50:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
Message-ID: <20180423135024.GA2337@kroah.com>
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180417050028.19372-1-k.marinushkin@gmail.com>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 07:00:28AM +0200, Kirill Marinushkin wrote:
> In the current implementation, vchi_instance is inited during the first
> call of bcm2835_audio_open_connection(), and is never freed. It causes a
> memory leak when the module `snd_bcm2835` is removed.
> 
> Here is how this commit fixes it:
> 
> * the VCHI context (including vchi_instance) is created once in the
>   platform's devres
> * the VCHI context is allocated and connected once during module_init()
> * all created bcm2835_chips have a pointer to this VCHI context
> * bcm2835_audio_open_connection() can access the VCHI context through the
>   associated bcm2835_chip
> * the VCHI context is disconnected and freed once during module_exit()
> 
> After this commit is applied, I don't see other issues with the module's
> init/exit, so I also remove the associated TODO task.
> 
> Steps to reproduce the memory leak before this commit:

<snip>

Patch dropped due to kbuild complaints.

Please fix up and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
