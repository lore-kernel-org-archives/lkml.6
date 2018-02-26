Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3069381-1519656489-2-2102750320525694827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519656489; b=V7R1CaZd8OjNv1FzhSLVMv6AJVbSXX0rfq1gKoU+DzGsKvc
    djI4G3fB7930C1QIl820xjSkZOWtGL6pfZK3gayFobIOdovt8LoH8r5Dfo10xyDk
    aukDcdXSTamVFDJq1GniPKy1GHauCrxRX6d05hnWO9WRcVLPBP8L2u78rHuzCWGN
    gJv+DBq52g2e0NoWS1BnwxuBxYZJpx74XU7kUvQYlRFIp/vcmbyJIDHaVgmFSwob
    yjg2xyLy2oMGS7k+my/T85pj/bFUzFq+LTrlZDRTGP7O+wGk05m/9gtjC51PP/Lm
    xeF4xqFiTkzJsdV6mTbrNcP1QwmdHDWC13JfeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519656489; bh=w
    eDzYMGyw0pEI4+g8fyn/8e+hNRy0yz5RfiEhOxC/h4=; b=ZRYKyQXxCYjayUqn6
    y2oE45bMvwONTejhwEH5utrPeAwnV0QTcPipv7q1Zz+YL2K2G+LT7IcFkVHOLYLd
    49P7pisO2ZUVYtMufsvU2gXYSauXHg7tkRIAI0cGOBj3wrZ5ze9JC7dwWhZajrAp
    oPmURQ6NgwisAvm73zxLzDS04j5EWVa42cqqS4DiYxAg00oS+3CgE6SOf91G8P4/
    C+eG6HQ+0IvYdfcfc5ooYX0kE2Eguj3waQCbnTajqLAV3lDsbdjto6fEhDYd3Lus
    p06cr1xuiVqApQYzfYJED7uIMZVqm0L3NIxxJZAvnihBokAb2y2aeE8ayiMlf2XY
    W3m/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SxEv1fP2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SxEv1fP2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....9 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Mon, 26 Feb 2018 14:47:56 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 1/3] staging: lustre: lov: use correct env in
 lov_io_data_version_end()
In-Reply-To: <151933737380.16436.3113702074708223689.stgit@noble>
Message-ID: <alpine.LFD.2.21.1802261447160.13228@casper.infradead.org>
References: <151933726925.16436.9827896439357574011.stgit@noble>
 <151933737380.16436.3113702074708223689.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180226_144757_192443_07F67CB5 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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


> lov - the logical object volume manager - is responsible for
> striping data across multiple volumes.
> 
> So when it is given a request, it creates one or more
> sub-requests, one for each target volume.  Each sub_io
> request has a sub_env environment which it operates in.
> 
> When lov_io_data_version_end() calls lov_io_end_wrapper() to
> wait for and close off a sub_io, it passes the wrong
> environment.
> 
> This causes an LINVRNT() to fail in cl2osc_io(), and may
> cause other problems.
> 
> This patch changes the call to use ->sub_env, much like
> other code in the same file.
> 
> Fixes: f0cf21abcccc ("staging: lustre: clio: add CIT_DATA_VERSION and remove IOC_LOV_GETINFO")
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: James Simmons <jsimmons@infradead.org>

> ---
>  drivers/staging/lustre/lustre/lov/lov_io.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lustre/lov/lov_io.c b/drivers/staging/lustre/lustre/lov/lov_io.c
> index c0dbf6cd53b4..b823f8a21856 100644
> --- a/drivers/staging/lustre/lustre/lov/lov_io.c
> +++ b/drivers/staging/lustre/lustre/lov/lov_io.c
> @@ -483,7 +483,7 @@ lov_io_data_version_end(const struct lu_env *env, const struct cl_io_slice *ios)
>  	struct lov_io_sub *sub;
>  
>  	list_for_each_entry(sub, &lio->lis_active, sub_linkage) {
> -		lov_io_end_wrapper(env, sub->sub_io);
> +		lov_io_end_wrapper(sub->sub_env, sub->sub_io);
>  
>  		parent->u.ci_data_version.dv_data_version +=
>  			sub->sub_io->u.ci_data_version.dv_data_version;
> 
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
