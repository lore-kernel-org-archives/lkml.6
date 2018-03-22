Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3230827-1521739225-2-2704453566596578367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521739224; b=giCmlWB/hBamsQK/yOG60mqJg2JyQ0r6MoRdvu7DuRPuhod
    hXwYRKCTgBexmbmNM0aTCrL05Vui4DdGPeEturKFb8DwoTlVRHuCDOifys34MPCS
    r36xJo1f7kyytHqYj8Iko3K9CcI3YmTvc4zb7t5pmAf7hUkGl3/7M1YfQ7FVcFQ1
    RsqBYoaXqO9v9UoL/R/Xy1sYQ6t0p5b5vBcbTeEh8pvuzT0SWiT+5pQHGoWO4SkW
    PXlOj0pfvDTc2TJT/yrpT9kB2sM8bUGzSfgc8OfIS2r5QIH+Oowp+4GW/tQJTlA1
    XVC1BL2sEFiBh+S2Xtl/iUHbWrpHvQpvJAtIvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521739224; bh=+
    G3v/8aXM166UfEx2zw+jK9EtQ8wt/B2VLrbK8su2ro=; b=he+xzQpQRNh6hwFj8
    Rw161vhkMXJtwh9vmBBs2x/TDJ2a7T85oWndw+CMxDh7BiHgx8P/fUZQJgc4LrdC
    EZYqVwVjiywfdv/JUGZD17U1esAdVv/BVkxO8NqViGKK4sg3ARJMwILIAg5qRW9b
    BIoouFFgxzMnd2gO2p4GOYSeQ58AwRvCYeutLE9MCBmKdkLDEQqdJyXLYlAQ1Gco
    DLbohrsHaKlGZmNP9M95GbdNt9MyYO3BTH9mqZZkXQRdCWSOB0xSyFWRRuoAIEAt
    E9v6Kdu/u1ogygEprTGt+eevuiJ0gAVY6GWDejs7QIrUy8fBzWkJmdEFxDDAoYUI
    kKkgA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 22 Mar 2018 18:20:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 1/6] staging: ks7010: Factor out repeated code.
Message-ID: <20180322172014.GA6801@kroah.com>
References: <20180319185125.GA13209@kroah.com>
 <20180320055815.32651-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180320055815.32651-1-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Mon, Mar 19, 2018 at 10:58:10PM -0700, Quytelda Kahja wrote:
> Some of the code for reading IEs is replicated multiple times in the
> switch statement for get_ap_information().  Factor that code out into
> read_ie().
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 48 +++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)

Does not apply at all to my tree :(

Please rebase and resend the whole series.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
