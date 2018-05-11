Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-221214-1526067153-2-907083033777969505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526067152; b=GcnvILmlXZtDAgJBiB7kdA4iNpE0hBkFXLDGIT0/c4UVWvTTVb
    objgQgxSrDsO+NNjEe6HI0YK/HT32WMXjHQD4UlIm1Fcpj4a83KlSHAE/0vFwZMW
    Xy6hO3JHCB255GhHr4h3c3Z9Ly0wg+Olkx08NS0S8IvAm9si027bhMulCtND/Wxn
    FPN7Gjqb0TpyaAc2o/YAmrYc/HCn1Z3+Wsga/cNWhgwm+1lfxNcfI6j4BlsBd5NF
    A2eiF/0fusIPdbWqJhtiq6jwG8KXJmDNpjmDQZR4Mty4Hjzy1ngUxnV7EdMC9xVY
    u1NkN+Q8WZZcCIHh5NqEB2rlh0ksdmL9dE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1526067152; bh=TB9mzg8y2AI7anr46Yg9UdUJyE60M3s
    jhG2/x5Zcb14=; b=asZI0o6GnE1boAecx8rWXkkv+TlpZhd9EqvHKY+/oO/FvlJ
    +s4nLM+CEMOzqp/OzL3kMQDLxGGjfXdMvYMKmpSVJUWY7TuJG5C89Erc7BN32T94
    U+h5pZ6UqlFyJVoqF1/gJ5V3dl3ou+Q4b9Mfjf/9M7zj+cDAQFEnhs5fgpn035SX
    GSWjLzMQ71IH1O6Ltrdc5SqPux426YaHPj8Ek46/ZYMSAd/CUB/tucgSrfLXm38L
    57ej9RRSHhRPkwEvxnpkV3/Gsi8SfLDHCPDBswOGawkNKqeVR2LWzmnP2MvPSSKz
    T0f50Bjmd9P6BsmiVKr5zMlaeFHefmjYjZ0B8zQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdp3MPQd/qIpOH2eoo0EW8WxhLgnvR+KpkVfKwFj7DcjSw5ZCC+qH00jq5SkK3afxEV6dM088+eE6erDqp89+17nQfgRE9YqUHrv2+q0LMzX2X7nW9h
    Q8WIHb0T0JX1joA/ZHWL6lTeHdWTYT3rWph0B8PtSV7SyV1rq8VJ698SWQIC2fb5P/qjStB+t6UpfJaga1BPkQ5tMt/+KTImwrGo140U9L3vkibQjZgacnXD
    vgm5BehZ/+q0eHr+yaKkxQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=16motl-LBekA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8
    a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8 a=3cpFS41aDno2OGFQi4AA:9 a=CjuIK1q_8ugA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,389,1520924400"; d="scan'208";a="40264658"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [lustre-devel] [PATCH] staging: lustre: fix spelling mistake:
 "req_ulinked" -> "req_unlinked"
Thread-Topic: [lustre-devel] [PATCH] staging: lustre: fix spelling mistake:
 "req_ulinked" -> "req_unlinked"
Thread-Index: AQHT6S1znLwp9/grd0yFMIk+GH0AJqQrYI+A
Date: Fri, 11 May 2018 19:32:23 +0000
Message-ID: <C3001646-0A1B-4118-81DF-486D7BAC7208@intel.com>
References: <20180511133859.18733-1-colin.king@canonical.com>
In-Reply-To: <20180511133859.18733-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.11.24]
Content-ID: <FCEB140BE9FFAB41A62B804FF6A7FBBA@intel.com>
MIME-Version: 1.0
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 NeilBrown <neilb@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On May 11, 2018, at 07:38, Colin King <colin.king@canonical.com> wrote:
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in DEBUG_REQ message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/ptlrpc/client.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/client.c b/drivers/staging/lustre/lustre/ptlrpc/client.c
> index eeb281266413..a51feaeb7734 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/client.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/client.c
> @@ -2514,7 +2514,7 @@ static int ptlrpc_unregister_reply(struct ptlrpc_request *request, int async)
> 		}
> 
> 		DEBUG_REQ(D_WARNING, request,
> -			  "Unexpectedly long timeout receiving_reply=%d req_ulinked=%d reply_unlinked=%d",
> +			  "Unexpectedly long timeout receiving_reply=%d req_unlinked=%d reply_unlinked=%d",
> 			  request->rq_receiving_reply,
> 			  request->rq_req_unlinked,
> 			  request->rq_reply_unlinked);
> -- 
> 2.17.0

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation







_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
